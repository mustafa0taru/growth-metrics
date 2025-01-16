
  create view "nca"."marts"."stg_market__dbt_tmp"
    
    
  as (
    

WITH source AS (
    SELECT * FROM "nca"."staging"."market"
)
SELECT
    date,
    token,
    price,
    daily_volume
FROM source
  );