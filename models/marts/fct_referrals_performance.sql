{{ config(materialized='table') }}

WITH referrer_stats AS (
    SELECT 
        r.referrer_user_id,
        COUNT(DISTINCT r.referred_user_id) as total_referrals,
        COUNT(DISTINCT CASE WHEN t.transaction_id IS NOT NULL THEN r.referred_user_id END) as activated_referrals,
        SUM(t.amount) as referred_user_volume,
        AVG(t.amount) as avg_referred_transaction_size
    FROM {{ ref('dim_referrals') }} r
    LEFT JOIN {{ ref('int_enriched_transactions') }} t
        ON r.referred_user_id = t.user_id
    GROUP BY 1
)
SELECT 
    *,
    ROUND(100.0 * activated_referrals / NULLIF(total_referrals, 0), 2) as referral_activation_rate,
    ROUND(referred_user_volume / NULLIF(activated_referrals, 0), 2) as volume_per_activated_referral
FROM referrer_stats