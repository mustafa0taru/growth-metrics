{{ config(materialized='table') }}

WITH user_base AS (
    SELECT
        u.user_id,
        u.country,
        u.signup_date,
        DATE_TRUNC('week', u.signup_date) as signup_week,
        CASE WHEN r.referred_user_id IS NOT NULL THEN true ELSE false END as is_referred_user,
        -- Get first transaction details
        MIN(t.timestamp) as first_transaction_date,
        MIN(t.amount) as first_transaction_amount
    FROM {{ ref('stg_users') }} u
    LEFT JOIN {{ ref('stg_referrals') }} r 
        ON u.user_id = r.referred_user_id
    LEFT JOIN {{ ref('stg_transactions') }} t 
        ON u.user_id = t.user_id
    GROUP BY 1, 2, 3, 4, 5
),

user_acquisition AS (
    SELECT 
        country,
        signup_week,
        -- Basic signup metrics
        COUNT(DISTINCT user_id) as total_signups,
        SUM(CASE WHEN is_referred_user THEN 0 ELSE 1 END) as direct_signups,
        SUM(CASE WHEN is_referred_user THEN 1 ELSE 0 END) as referral_signups,
        
        -- Activation metrics
        COUNT(DISTINCT CASE 
            WHEN first_transaction_date IS NOT NULL THEN user_id 
        END) as activated_users,
        
        -- Time to activation
        AVG(CASE 
            WHEN first_transaction_date IS NOT NULL 
            THEN EXTRACT(EPOCH FROM (first_transaction_date - signup_date))/3600
        END) as avg_hours_to_first_transaction,
        
        -- First transaction value
        AVG(CASE 
            WHEN first_transaction_amount IS NOT NULL 
            THEN first_transaction_amount
        END) as avg_first_transaction_value
    FROM user_base
    WHERE country IS NOT NULL
    GROUP BY 1, 2
),

final AS (
    SELECT 
        *,
        -- Signup source percentages
        ROUND((direct_signups * 100.0 / NULLIF(total_signups, 0)), 2) as direct_signup_percentage,
        ROUND((referral_signups * 100.0 / NULLIF(total_signups, 0)), 2) as referral_signup_percentage,
        
        -- Activation rate
        ROUND((activated_users * 100.0 / NULLIF(total_signups, 0)), 2) as activation_rate,
        
        -- Weekly growth metrics
        LAG(total_signups) OVER (PARTITION BY country ORDER BY signup_week) as prev_week_signups,
        ROUND(
            ((total_signups * 1.0 / NULLIF(LAG(total_signups) OVER (PARTITION BY country ORDER BY signup_week), 0)) - 1) * 100,
            2
        ) as week_over_week_growth
    FROM user_acquisition
)

SELECT 
    country,
    signup_week,
    total_signups,
    direct_signups,
    referral_signups,
    direct_signup_percentage,
    referral_signup_percentage,
    activated_users,
    activation_rate,
    avg_hours_to_first_transaction,
    avg_first_transaction_value,
    week_over_week_growth
FROM final
ORDER BY 
signup_week DESC, 
total_signups DESC