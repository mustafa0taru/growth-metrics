{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('staging', 'market') }}
)
SELECT
    date,
    token,
    price,
    daily_volume
FROM source
