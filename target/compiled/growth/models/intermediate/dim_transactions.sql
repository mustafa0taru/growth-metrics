

WITH cleaned_transactions AS (
    SELECT DISTINCT
        transaction_id,
        user_id,
        LOWER(transaction_type) as transaction_type,
        UPPER(token) as token,
        CASE 
            WHEN amount <= 0 THEN NULL
            ELSE amount 
        END as amount,
        timestamp
    FROM "nca"."marts"."stg_transactions"
    WHERE transaction_id IS NOT NULL
        AND user_id IS NOT NULL
)
SELECT * FROM cleaned_transactions