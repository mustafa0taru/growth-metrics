{{ config(materialized='view') }}

WITH user_enriched AS (
    SELECT
        u.user_id,
        u.signup_date,
        u.country,
        u.referral_code,
        r.referrer_user_id,
        CASE 
            WHEN r.referred_user_id IS NOT NULL THEN true 
            ELSE false 
        END as is_referred_user,
        DATE_TRUNC('week', u.signup_date) as signup_week
    FROM {{ ref('dim_users') }} u
    LEFT JOIN {{ ref('dim_referrals') }} r
        ON u.user_id = r.referred_user_id
)
SELECT * FROM user_enriched