
  create view "nca"."marts"."dim_users__dbt_tmp"
    
    
  as (
    

WITH cleaned_users AS (
    SELECT
        user_id,
        signup_date,
        TRIM(LOWER(country)) as country,
        COALESCE(referral_code, 'no_referral') as referral_code
    FROM "nca"."marts"."stg_users"
    WHERE user_id IS NOT NULL
)
SELECT * FROM cleaned_users
  );