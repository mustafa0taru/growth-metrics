
  create view "nca"."marts"."int_enriched_users__dbt_tmp"
    
    
  as (
    

WITH user_enriched AS (
    SELECT
        u.user_id,
        u.signup_date,
        u.country,
        u.referral_code,
        r.referrer_user_id,
        CASE 
            WHEN r.referred_user_id IS NOT NULL THEN true 
            ELSE false 
        END as is_referred_user,
        DATE_TRUNC('week', u.signup_date) as signup_week
    FROM "nca"."marts"."dim_users" u
    LEFT JOIN "nca"."marts"."dim_referrals" r
        ON u.user_id = r.referred_user_id
)
SELECT * FROM user_enriched
  );