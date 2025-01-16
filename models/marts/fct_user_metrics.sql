{{ config(materialized='table') }}

WITH user_metrics AS (
    SELECT
        u.user_id,
        u.signup_date,
        u.country,
        u.is_referred_user,
        u.signup_week,
        COUNT(DISTINCT t.transaction_id) as total_transactions,
        SUM(t.usd_value) as total_volume_usd,
        COUNT(DISTINCT t.token) as unique_tokens_traded,
        MIN(t.timestamp) as first_transaction_date,
        MAX(t.timestamp) as last_transaction_date
    FROM {{ ref('int_enriched_users') }} u
    LEFT JOIN {{ ref('int_enriched_transactions') }} t
        ON u.user_id = t.user_id
    GROUP BY 1, 2, 3, 4, 5
)
SELECT * FROM user_metrics