

WITH source AS (
    SELECT * FROM "nca"."staging"."users"
)
SELECT
    user_id,
    signup_date,
    country,
    referral_code
FROM source