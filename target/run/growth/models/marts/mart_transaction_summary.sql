
  
    

  create  table "nca"."marts"."mart_transaction_summary__dbt_tmp"
  
  
    as
  
  (
    

WITH transaction_type_summary AS (
    SELECT
        transaction_type,
        COUNT(*) as total_transactions,
        COUNT(DISTINCT user_id) as unique_users,
        SUM(amount) as total_volume,
        AVG(amount) as avg_transaction_size,
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () as transaction_type_percentage
    FROM "nca"."marts"."stg_transactions"
    GROUP BY transaction_type
),

token_summary AS (
    SELECT
        token,
        COUNT(*) as total_transactions,
        SUM(amount) as total_volume,
        AVG(amount) as avg_transaction_size,
        COUNT(DISTINCT user_id) as unique_users,
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () as token_percentage
    FROM "nca"."marts"."stg_transactions"
    GROUP BY token
),

time_trends AS (
    SELECT
        DATE_TRUNC('day', timestamp) as day,
        COUNT(*) as daily_transactions,
        SUM(amount) as daily_volume,
        COUNT(DISTINCT user_id) as daily_active_users
    FROM "nca"."marts"."stg_transactions"
    GROUP BY DATE_TRUNC('day', timestamp)
)

SELECT
    'transaction_type' as metric_type,
    transaction_type as category,
    total_transactions,
    total_volume,
    avg_transaction_size,
    unique_users,
    transaction_type_percentage as percentage
FROM transaction_type_summary

UNION ALL

SELECT
    'token' as metric_type,
    token as category,
    total_transactions,
    total_volume,
    avg_transaction_size,
    unique_users,
    token_percentage as percentage
FROM token_summary
  );
  