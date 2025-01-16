{{ config(materialized='table') }}

WITH first_transactions AS (
    SELECT 
        user_id,
        MIN(timestamp) as first_transaction_date
    FROM {{ ref('int_enriched_transactions') }}
    GROUP BY 1
),

daily_transactions AS (
    SELECT
        DATE_TRUNC('day', t.timestamp) as date,
        t.token,
        t.transaction_type,
        COUNT(DISTINCT t.transaction_id) as transaction_count,
        COUNT(DISTINCT t.user_id) as unique_users,
        SUM(t.amount) as total_volume,
        AVG(t.amount) as avg_transaction_size,
        SUM(CASE WHEN t.transaction_date = ft.first_transaction_date THEN 1 ELSE 0 END) as new_user_transactions
    FROM {{ ref('int_enriched_transactions') }} t
    LEFT JOIN first_transactions ft ON t.user_id = ft.user_id
    GROUP BY 1, 2, 3

)
SELECT 
    *,
    SUM(transaction_count) OVER (PARTITION BY token ORDER BY date) as cumulative_transactions,
    SUM(total_volume) OVER (PARTITION BY token ORDER BY date) as cumulative_volume,
    LAG(transaction_count) OVER (PARTITION BY token ORDER BY date) as prev_day_transactions,
    ROUND(100.0 * (transaction_count - LAG(transaction_count) OVER (PARTITION BY token ORDER BY date)) 
        / NULLIF(LAG(transaction_count) OVER (PARTITION BY token ORDER BY date), 0), 2) as daily_growth_rate
FROM daily_transactions