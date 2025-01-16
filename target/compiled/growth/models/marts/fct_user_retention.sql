

WITH user_cohorts AS (
    SELECT
        u.user_id,
        DATE_TRUNC('month', u.signup_date) as cohort_month,
        DATE_TRUNC('month', t.timestamp) as activity_month,
        COUNT(DISTINCT t.transaction_id) as transactions,
        SUM(t.amount) as volume
    FROM "nca"."marts"."int_enriched_users" u
    LEFT JOIN "nca"."marts"."int_enriched_transactions" t
        ON u.user_id = t.user_id
    GROUP BY 1, 2, 3
),

cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT user_id) as cohort_size
    FROM user_cohorts
    GROUP BY 1
),

retention_data AS (
    SELECT
        c.cohort_month,
        c.activity_month,
        COUNT(DISTINCT c.user_id) as active_users,
        cs.cohort_size,
        -- Fix for months_since_signup calculation
        (EXTRACT(YEAR FROM c.activity_month) - EXTRACT(YEAR FROM c.cohort_month)) * 12 +
        (EXTRACT(MONTH FROM c.activity_month) - EXTRACT(MONTH FROM c.cohort_month)) as months_since_signup
    FROM user_cohorts c
    JOIN cohort_sizes cs ON c.cohort_month = cs.cohort_month
    GROUP BY 1, 2, 4, 5
)
SELECT 
    *,
    ROUND(100.0 * active_users / cohort_size, 2) as retention_rate
FROM retention_data