{{ config(materialized='view') }}

{{ config(materialized='view') }}

WITH user_first_transaction AS (
    SELECT
        user_id,
        MIN(transaction_date) AS first_transaction_date
    FROM {{ ref('fact_transactions') }}
    GROUP BY user_id
),

user_enriched AS (
    SELECT
        u.user_id,
        COALESCE(ft.first_transaction_date, u.signup_date) AS signup_date,
        COALESCE(u.country, 'Not Specified') AS country,
        u.referral_code,
        r.referrer_user_id,
        CASE 
            WHEN r.referred_user_id IS NOT NULL THEN true 
            ELSE false 
        END as is_referred_user,
        DATE_TRUNC('week', COALESCE(ft.first_transaction_date, u.signup_date)) AS signup_week
    FROM {{ ref('dim_users') }} u
    LEFT JOIN {{ ref('dim_referrals') }} r
        ON u.user_id = r.referred_user_id
    LEFT JOIN user_first_transaction ft
        ON u.user_id = ft.user_id
)

SELECT * 
FROM user_enriched
