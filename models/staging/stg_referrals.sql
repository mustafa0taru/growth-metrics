{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('staging', 'referrals') }}
)
SELECT
    referrer_user_id,
    referred_user_id,
    referral_date
FROM source