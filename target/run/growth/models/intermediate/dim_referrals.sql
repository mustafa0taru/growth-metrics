
  create view "nca"."marts"."dim_referrals__dbt_tmp"
    
    
  as (
    

WITH cleaned_referrals AS (
    SELECT DISTINCT
        referrer_user_id,
        referred_user_id,
        referral_date
    FROM "nca"."marts"."stg_referrals"
    WHERE referrer_user_id IS NOT NULL
        AND referred_user_id IS NOT NULL
        AND referrer_user_id != referred_user_id
)
SELECT * 
FROM cleaned_referrals
  );