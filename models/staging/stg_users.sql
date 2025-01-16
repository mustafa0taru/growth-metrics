{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('staging', 'users') }}
)
SELECT
    user_id,
    signup_date,
    country,
    referral_code
FROM source