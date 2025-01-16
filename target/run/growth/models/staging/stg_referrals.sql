
  create view "nca"."marts"."stg_referrals__dbt_tmp"
    
    
  as (
    

WITH source AS (
    SELECT * FROM "nca"."staging"."referrals"
)
SELECT
    referrer_user_id,
    referred_user_id,
    referral_date
FROM source
  );