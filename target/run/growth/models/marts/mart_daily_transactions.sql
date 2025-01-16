
  
    

  create  table "nca"."marts"."mart_daily_transactions__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    timestamp,
    token,
    transaction_type,
    COUNT(*) as daily_transaction_count,
    SUM(amount) as daily_volume,
    AVG(amount) as avg_transaction_size
FROM "nca"."marts"."stg_transactions"
GROUP BY 
    timestamp,
    token,
    transaction_type
  );
  