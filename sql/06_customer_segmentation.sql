/*
============================================================
PROJECT: Telecom Customer Churn Analysis
FILE: 06_customer_segmentation.sql

PURPOSE:
Segment customers by tenure, customer value, tariff plan,
complaint behaviour and customer status to identify customer
groups with different observed churn patterns.

BASELINE:
The overall churn rate identified in the previous analysis
was 15.71%.

NOTE:
These segments identify associations within the dataset.
They do not establish causation.

CHURN:
0 = Retained
1 = Churned
============================================================
*/


-- ============================================================
-- 1. SUBSCRIPTION LENGTH PROFILE
-- Business Question:
-- What is the overall distribution of customer tenure?
-- ============================================================

SELECT
    MIN(subscription_length) AS minimum_months,
    MAX(subscription_length) AS maximum_months,
    ROUND(AVG(subscription_length), 2) AS average_months
FROM analytics.customer_churn;



-- ============================================================
-- 2. TENURE SEGMENTATION
-- Business Question:
-- How does churn vary across customer lifecycle stages?
-- ============================================================

WITH tenure_segments AS (

    SELECT
        *,
        CASE
            WHEN subscription_length <= 12 THEN '0-12 months'
            WHEN subscription_length <= 24 THEN '13-24 months'
            WHEN subscription_length <= 36 THEN '25-36 months'
            WHEN subscription_length <= 48 THEN '37-48 months'
            ELSE '49+ months'
        END AS tenure_segment

    FROM analytics.customer_churn
)

SELECT
    tenure_segment,
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
        100.0 *
        SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM tenure_segments

GROUP BY tenure_segment

ORDER BY
    CASE tenure_segment
        WHEN '0-12 months' THEN 1
        WHEN '13-24 months' THEN 2
        WHEN '25-36 months' THEN 3
        WHEN '37-48 months' THEN 4
        WHEN '49+ months' THEN 5
    END;



-- ============================================================
-- 3. CUSTOMER VALUE QUARTILES
-- Business Question:
-- How does churn vary across customer-value groups?
--
-- NTILE(4) divides customers into approximately four equally
-- sized groups after ordering them by customer value.
-- ============================================================

WITH value_segments AS (

    SELECT
        *,
        NTILE(4) OVER (
            ORDER BY customer_value
        ) AS value_quartile

    FROM analytics.customer_churn
)

SELECT
    value_quartile,
    COUNT(*) AS customers,

    ROUND(
        MIN(customer_value)::numeric,
        2
    ) AS min_customer_value,

    ROUND(
        AVG(customer_value)::numeric,
        2
    ) AS avg_customer_value,

    ROUND(
        MAX(customer_value)::numeric,
        2
    ) AS max_customer_value,

    SUM(
        CASE
            WHEN churn = 1 THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        100.0 *
        SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM value_segments

GROUP BY value_quartile
ORDER BY value_quartile;



-- ============================================================
-- 4. TARIFF PLAN + COMPLAINT SEGMENTATION
-- Business Question:
-- How does churn vary when tariff plan and complaint
-- behaviour are considered together?
-- ============================================================

SELECT
    tariff_plan,
    complains,
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
        100.0 *
        SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM analytics.customer_churn

GROUP BY
    tariff_plan,
    complains

ORDER BY churn_rate_pct DESC;



-- ============================================================
-- 5. STATUS + COMPLAINT SEGMENTATION
-- Business Question:
-- How does churn vary when customer status and complaint
-- behaviour are considered together?
-- ============================================================

SELECT
    status,
    complains,
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
        100.0 *
        SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM analytics.customer_churn

GROUP BY
    status,
    complains

ORDER BY churn_rate_pct DESC;



-- ============================================================
-- 6. COMPLAINT SEGMENTS VS OVERALL CHURN
-- Business Question:
-- How far above or below the overall churn rate is each
-- complaint segment?
--
-- difference_percentage_points measures the difference
-- between the segment churn rate and overall churn rate.
-- ============================================================

WITH overall AS (

    SELECT
        AVG(churn::numeric) * 100 AS overall_churn_rate

    FROM analytics.customer_churn
),

complaint_segments AS (

    SELECT
        complains,
        COUNT(*) AS customers,

        AVG(churn::numeric) * 100 AS segment_churn_rate

    FROM analytics.customer_churn

    GROUP BY complains
)

SELECT
    complains,
    customers,

    ROUND(
        segment_churn_rate,
        2
    ) AS churn_rate_pct,

    ROUND(
        overall_churn_rate,
        2
    ) AS overall_churn_rate_pct,

    ROUND(
        segment_churn_rate - overall_churn_rate,
        2
    ) AS difference_percentage_points

FROM complaint_segments

CROSS JOIN overall

ORDER BY segment_churn_rate DESC;



-- ============================================================
-- 7. TARIFF SEGMENTS VS OVERALL CHURN
-- Business Question:
-- How far above or below the overall churn rate is each
-- tariff plan?
-- ============================================================

WITH overall AS (

    SELECT
        AVG(churn::numeric) * 100 AS overall_churn_rate

    FROM analytics.customer_churn
),

tariff_segments AS (

    SELECT
        tariff_plan,
        COUNT(*) AS customers,

        AVG(churn::numeric) * 100 AS segment_churn_rate

    FROM analytics.customer_churn

    GROUP BY tariff_plan
)

SELECT
    tariff_plan,
    customers,

    ROUND(
        segment_churn_rate,
        2
    ) AS churn_rate_pct,

    ROUND(
        overall_churn_rate,
        2
    ) AS overall_churn_rate_pct,

    ROUND(
        segment_churn_rate - overall_churn_rate,
        2
    ) AS difference_percentage_points

FROM tariff_segments

CROSS JOIN overall

ORDER BY segment_churn_rate DESC;



-- ============================================================
-- 8. STATUS SEGMENTS VS OVERALL CHURN
-- Business Question:
-- How far above or below the overall churn rate is each
-- customer status group?
-- ============================================================

WITH overall AS (

    SELECT
        AVG(churn::numeric) * 100 AS overall_churn_rate

    FROM analytics.customer_churn
),

status_segments AS (

    SELECT
        status,
        COUNT(*) AS customers,

        AVG(churn::numeric) * 100 AS segment_churn_rate

    FROM analytics.customer_churn

    GROUP BY status
)

SELECT
    status,
    customers,

    ROUND(
        segment_churn_rate,
        2
    ) AS churn_rate_pct,

    ROUND(
        overall_churn_rate,
        2
    ) AS overall_churn_rate_pct,

    ROUND(
        segment_churn_rate - overall_churn_rate,
        2
    ) AS difference_percentage_points

FROM status_segments

CROSS JOIN overall

ORDER BY segment_churn_rate DESC;



-- ============================================================
-- 9. MULTI-FACTOR CUSTOMER PROFILE
-- Business Question:
-- What happens when complaint behaviour and customer status
-- are combined into business-readable customer profiles?
-- ============================================================

WITH customer_profiles AS (

    SELECT
        *,

        CASE

            WHEN complains = 1
             AND status = 2
                THEN 'Complaint + Non-Active'

            WHEN complains = 1
             AND status = 1
                THEN 'Complaint + Active'

            WHEN complains = 0
             AND status = 2
                THEN 'No Complaint + Non-Active'

            WHEN complains = 0
             AND status = 1
                THEN 'No Complaint + Active'

            ELSE 'Other'

        END AS customer_profile

    FROM analytics.customer_churn
)

SELECT
    customer_profile,
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
        100.0 *
        SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate_pct

FROM customer_profiles

GROUP BY customer_profile

ORDER BY churn_rate_pct DESC;



-- ============================================================
-- 10. CUSTOMER PROFILE VS OVERALL CHURN
-- Business Question:
-- Which complaint/status customer profiles are above or
-- below the overall churn baseline?
-- ============================================================

WITH overall AS (

    SELECT
        AVG(churn::numeric) * 100 AS overall_churn_rate

    FROM analytics.customer_churn

),

customer_profiles AS (

    SELECT
        churn,

        CASE

            WHEN complains = 1
             AND status = 2
                THEN 'Complaint + Non-Active'

            WHEN complains = 1
             AND status = 1
                THEN 'Complaint + Active'

            WHEN complains = 0
             AND status = 2
                THEN 'No Complaint + Non-Active'

            WHEN complains = 0
             AND status = 1
                THEN 'No Complaint + Active'

            ELSE 'Other'

        END AS customer_profile

    FROM analytics.customer_churn

),

profile_summary AS (

    SELECT
        customer_profile,
        COUNT(*) AS customers,
        AVG(churn::numeric) * 100 AS profile_churn_rate

    FROM customer_profiles

    GROUP BY customer_profile

)

SELECT
    customer_profile,
    customers,

    ROUND(
        profile_churn_rate,
        2
    ) AS churn_rate_pct,

    ROUND(
        overall_churn_rate,
        2
    ) AS overall_churn_rate_pct,

    ROUND(
        profile_churn_rate - overall_churn_rate,
        2
    ) AS difference_percentage_points

FROM profile_summary

CROSS JOIN overall

ORDER BY profile_churn_rate DESC;