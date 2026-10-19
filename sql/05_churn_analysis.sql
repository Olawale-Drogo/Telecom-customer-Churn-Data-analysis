-- Add churn rate and churn-driver analysis queries here.
/*
============================================================
PROJECT: Telecom Customer Churn Analysis
FILE: 05_churn_analysis.sql

PURPOSE:
Analyse customer churn across demographic, behavioural,
service usage and customer-value characteristics.

NOTE:
The analysis identifies associations with churn.
It does not establish that any individual factor causes churn.

CHURN:
0 = Retained
1 = Churned
============================================================
*/


-- ============================================================
-- 1. OVERALL CHURN RATE
-- Business Question:
-- What percentage of customers churned?
-- ============================================================

SELECT
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN churn = 1 THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    SUM(
        CASE
            WHEN churn = 0 THEN 1
            ELSE 0
        END
    ) AS retained_customers,

    ROUND(
        100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM analytics.customer_churn;


-- ============================================================
-- 2. COMPLAINTS VS CHURN
-- Business Question:
-- Is churn different between customers who complained and
-- customers who did not complain?
-- ============================================================

SELECT
    complains,
    COUNT(*) AS customers,

    SUM(
        CASE
            WHEN churn = 1 THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM analytics.customer_churn
GROUP BY complains
ORDER BY complains;


-- ============================================================
-- 3. TARIFF PLAN VS CHURN
-- Business Question:
-- Does churn vary between tariff plans?
-- ============================================================

SELECT
    tariff_plan,
    COUNT(*) AS customers,

    SUM(
        CASE
            WHEN churn = 1 THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM analytics.customer_churn
GROUP BY tariff_plan
ORDER BY tariff_plan;


-- ============================================================
-- 4. AGE GROUP VS CHURN
-- Business Question:
-- How does churn vary across customer age groups?
-- ============================================================

SELECT
    age_group,
    COUNT(*) AS customers,

    SUM(
        CASE
            WHEN churn = 1 THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    SUM(
        CASE
            WHEN churn = 0 THEN 1
            ELSE 0
        END
    ) AS retained_customers,

    ROUND(
        100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM analytics.customer_churn
GROUP BY age_group
ORDER BY age_group;


-- ============================================================
-- 5. CUSTOMER STATUS VS CHURN
-- Business Question:
-- How does churn vary by customer status?
-- ============================================================

SELECT
    status,
    COUNT(*) AS customers,

    SUM(
        CASE
            WHEN churn = 1 THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        100.0 * SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM analytics.customer_churn
GROUP BY status
ORDER BY status;


-- ============================================================
-- 6. SUBSCRIPTION LENGTH VS CHURN
-- Business Question:
-- Do churned customers have a different average subscription
-- length from retained customers?
-- ============================================================

SELECT
    churn,
    COUNT(*) AS customers,

    ROUND(
        AVG(subscription_length),
        2
    ) AS avg_subscription_length,

    MIN(subscription_length) AS min_subscription_length,
    MAX(subscription_length) AS max_subscription_length

FROM analytics.customer_churn
GROUP BY churn
ORDER BY churn;


-- ============================================================
-- 7. CUSTOMER VALUE VS CHURN
-- Business Question:
-- Does customer value differ between churned and retained
-- customers?
-- ============================================================

SELECT
    churn,
    COUNT(*) AS customers,

    ROUND(
        AVG(customer_value)::numeric,
        2
    ) AS avg_customer_value,

    ROUND(
        MIN(customer_value)::numeric,
        2
    ) AS min_customer_value,

    ROUND(
        MAX(customer_value)::numeric,
        2
    ) AS max_customer_value

FROM analytics.customer_churn
GROUP BY churn
ORDER BY churn;


-- ============================================================
-- 8. USAGE BEHAVIOUR VS CHURN
-- Business Question:
-- How do average usage patterns differ between churned and
-- retained customers?
-- ============================================================

SELECT
    churn,
    COUNT(*) AS customers,

    ROUND(
        AVG(seconds_of_use),
        2
    ) AS avg_seconds_of_use,

    ROUND(
        AVG(frequency_of_use),
        2
    ) AS avg_frequency_of_use,

    ROUND(
        AVG(frequency_of_sms),
        2
    ) AS avg_frequency_of_sms,

    ROUND(
        AVG(distinct_called_numbers),
        2
    ) AS avg_distinct_called_numbers

FROM analytics.customer_churn
GROUP BY churn
ORDER BY churn;


-- ============================================================
-- 9. CALL FAILURES VS CHURN
-- Business Question:
-- Do churned customers experience a different average number of call failures than retained customers?
-- ============================================================

SELECT *
FROM analytics.customer_churn
WHERE call_failure < 0
   OR subscription_length < 0
   OR  charge_amount  < 0
   OR seconds_of_use < 0
   OR frequency_of_use < 0
   OR frequency_of_sms < 0
   OR distinct_called_numbers < 0
   OR age < 0
   OR customer_value < 0;
    