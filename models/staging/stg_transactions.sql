{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('staging', 'transactions') }}
)
SELECT
    transaction_id,
    user_id,
    transaction_type,
    token,
    amount,
    timestamp
FROM source
