
  create view "nca"."marts"."dim_market__dbt_tmp"
    
    
  as (
    


WITH cleaned_market AS (
    SELECT
        date,
        UPPER(token) as token,
        NULLIF(price, 0) as price,
        NULLIF(daily_volume, 0) as daily_volume
    FROM "nca"."marts"."stg_market"
    WHERE token IS NOT NULL
        AND date IS NOT NULL
)
SELECT * 
FROM cleaned_market
  );