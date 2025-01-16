

WITH token_metrics AS (
    SELECT
        token,
        COUNT(DISTINCT transaction_id) as total_transactions,
        COUNT(DISTINCT user_id) as unique_users,
        SUM(usd_value) as total_volume_usd,
        AVG(usd_value) as avg_transaction_value_usd,
        MIN(token_price) as min_price,
        MAX(token_price) as max_price,
        AVG(token_price) as avg_price,
        AVG(market_daily_volume) as avg_daily_market_volume
    FROM "nca"."marts"."int_enriched_transactions"
    GROUP BY 1
)
SELECT * FROM token_metrics