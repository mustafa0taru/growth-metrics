

WITH user_acquisition AS (
    SELECT 
        DATE_TRUNC('day', signup_date) as acquisition_date,
        country,
        COUNT(DISTINCT user_id) as new_users,
        COUNT(DISTINCT CASE WHEN is_referred_user THEN user_id END) as referred_users,
        COUNT(DISTINCT CASE WHEN NOT is_referred_user THEN user_id END) as organic_users
    FROM "nca"."marts"."int_enriched_users"
    GROUP BY 1, 2
)
SELECT 
    *,
    SUM(new_users) OVER (PARTITION BY country ORDER BY acquisition_date) as cumulative_users,
    ROUND(100.0 * referred_users / NULLIF(new_users, 0), 2) as referral_rate,
    LAG(new_users) OVER (PARTITION BY country ORDER BY acquisition_date) as prev_day_users,
    ROUND(100.0 * (new_users - LAG(new_users) OVER (PARTITION BY country ORDER BY acquisition_date)) 
        / NULLIF(LAG(new_users) OVER (PARTITION BY country ORDER BY acquisition_date), 0), 2) as daily_growth_rate
FROM user_acquisition