
  create view "nca"."marts"."stg_users__dbt_tmp"
    
    
  as (
    

WITH source AS (
    SELECT * FROM "nca"."staging"."users"
)
SELECT
    user_id,
    signup_date,
    country,
    referral_code
FROM source
  );