

WITH source AS (
    SELECT * FROM "nca"."staging"."market"
)
SELECT
    date,
    token,
    price,
    daily_volume
FROM source