

WITH referral_metrics AS (
    SELECT
        r.referrer_user_id,
        u.signup_date as referrer_signup_date,
        COUNT(DISTINCT r.referred_user_id) as total_referrals,
        COUNT(DISTINCT t.transaction_id) as referred_user_transactions,
        SUM(t.usd_value) as referred_user_volume_usd,
        AVG(t.usd_value) as avg_referred_transaction_value
    FROM "nca"."marts"."dim_referrals" r
    JOIN "nca"."marts"."int_enriched_users" u
        ON r.referrer_user_id = u.user_id
    LEFT JOIN "nca"."marts"."int_enriched_transactions" t
        ON r.referred_user_id = t.user_id
    GROUP BY 1, 2
)
SELECT * FROM referral_metrics