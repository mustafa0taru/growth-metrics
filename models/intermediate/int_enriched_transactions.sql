{{ config(materialized='view') }}

WITH transaction_enriched AS (
    SELECT
        t.*,
        m.price as token_price,
        m.daily_volume as market_daily_volume,
        t.amount * m.price as usd_value,
        DATE_TRUNC('day', t.timestamp) as transaction_date
    FROM {{ ref('dim_transactions') }} t
    LEFT JOIN {{ ref('dim_market') }} m
        ON t.token = m.token 
        AND DATE_TRUNC('day', t.timestamp) = m.date
)
SELECT * FROM transaction_enriched