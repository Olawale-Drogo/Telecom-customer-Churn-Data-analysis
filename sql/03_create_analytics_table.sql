/*
============================================================
PROJECT: Telecom Customer Churn Analysis
FILE: 03_create_analytics_table.sql

PURPOSE:
Create an analysis-ready version of the raw churn dataset
using standardized PostgreSQL-friendly column names.
============================================================
*/


-- ============================================================
-- 1. REMOVE EXISTING ANALYTICS TABLE
-- ============================================================

DROP TABLE IF EXISTS analytics.customer_churn;


-- ============================================================
-- 2. CREATE CLEAN ANALYTICS TABLE
-- ============================================================

CREATE TABLE analytics.customer_churn AS
SELECT
    "Call Failure"             AS call_failure,
    "Complains"                AS complains,
    "Subscription Length"      AS subscription_length,
    "Charge Amount"            AS charge_amount,
    "Seconds of Use"           AS seconds_of_use,
    "Frequency of use"         AS frequency_of_use,
    "Frequency of SMS"         AS frequency_of_sms,
    "Distinct Called Numbers"  AS distinct_called_numbers,
    "Age Group"                AS age_group,
    "Tariff Plan"              AS tariff_plan,
    "Status"                   AS status,
    "Age"                      AS age,
    "Customer Value"           AS customer_value,
    "Churn"                    AS churn
FROM raw.customer_churn;


-- ============================================================
-- 3. VERIFY ANALYTICS TABLE
-- ============================================================

SELECT *
FROM analytics.customer_churn
LIMIT 10;


-- ============================================================
-- 4. RECONCILE RAW AND ANALYTICS ROW COUNTS
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM raw.customer_churn) AS raw_rows,
    (SELECT COUNT(*) FROM analytics.customer_churn) AS analytics_rows;