{{ config(materialized='table') }}

WITH user_activity AS (
    SELECT
        u.user_id,
        u.signup_date,
        MIN(t.timestamp) as first_activity_date,
        MAX(t.timestamp) as last_activity_date,
        COUNT(DISTINCT t.transaction_id) as total_transactions,
        COUNT(DISTINCT t.token) as unique_tokens_used,
        SUM(t.amount) as total_volume,
        AVG(t.amount) as avg_transaction_size
    FROM {{ ref('int_enriched_users') }} u
    LEFT JOIN {{ ref('int_enriched_transactions') }} t
        ON u.user_id = t.user_id
    GROUP BY 1, 2
)
SELECT 
    *,
    EXTRACT(DAY FROM (first_activity_date - signup_date)) as days_to_activate,
    EXTRACT(DAY FROM (last_activity_date - signup_date)) as days_since_signup,
    EXTRACT(DAY FROM (CURRENT_DATE - last_activity_date)) as days_since_last_activity,
    CASE 
        WHEN total_transactions = 0 THEN 'never_active'
        WHEN EXTRACT(DAY FROM (CURRENT_DATE - last_activity_date)) <= 7 THEN 'active_7d'
        WHEN EXTRACT(DAY FROM (CURRENT_DATE - last_activity_date)) <= 30 THEN 'active_30d'
        ELSE 'inactive'
    END as activity_status
FROM user_activity