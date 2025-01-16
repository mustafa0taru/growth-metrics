

WITH source AS (
    SELECT * FROM "nca"."staging"."transactions"
)
SELECT
    transaction_id,
    user_id,
    transaction_type,
    token,
    amount,
    timestamp
FROM source