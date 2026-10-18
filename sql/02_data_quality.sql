/* ============================================================
PROJECT: Telecom Customer Churn Analysis
FILE: 02_data_quality.sql

PURPOSE:
Assess the quality of the raw UCI Iranian Churn dataset
before transformation and analysis.

CHECKS:
1. Record count
2. SAMPLE DATA PREVIEW
3. TABLE STRUCTURE
4. CATEGORICAL VALUE VALIDATION
5. NUMERIC RANGE CHECKS
6. MISSING VALUE CHECKS
7. DUPLICATE RECORD INVESTIGATION
8. INVALID CATEGORICAL VALUES
9. INVALID NEGATIVE VALUES 
*/
-- ============================================================
-- 1. RECORD COUNT
-- ============================================================

SELECT
    COUNT(*) AS total_rows
FROM raw.customer_churn;


-- ============================================================
-- 2. SAMPLE DATA PREVIEW
-- ============================================================

SELECT *
FROM raw.customer_churn
LIMIT 10;


-- ============================================================
-- 3. TABLE STRUCTURE
-- ============================================================

SELECT
    ordinal_position,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'raw'
  AND table_name = 'customer_churn'
ORDER BY ordinal_position;


-- ============================================================
-- 4. CATEGORICAL VALUE VALIDATION
-- ============================================================

-- Churn distribution
SELECT
    "Churn",
    COUNT(*) AS customer_count
FROM raw.customer_churn
GROUP BY "Churn"
ORDER BY "Churn";


-- Complaint distribution

SELECT
    "Complains",
    COUNT(*) AS customer_count
FROM raw.customer_churn
GROUP BY "Complains"
ORDER BY "Complains";


-- Tariff plan distribution

SELECT
    "Tariff Plan",
    COUNT(*) AS customer_count
FROM raw.customer_churn
GROUP BY "Tariff Plan"
ORDER BY "Tariff Plan";


-- Customer status distribution

SELECT
    "Status",
    COUNT(*) AS customer_count
FROM raw.customer_churn
GROUP BY "Status"
ORDER BY "Status";


-- Age group distribution

SELECT
    "Age Group",
    COUNT(*) AS customer_count
FROM raw.customer_churn
GROUP BY "Age Group"
ORDER BY "Age Group";


-- ============================================================
-- 5. NUMERIC RANGE CHECKS
-- ============================================================

SELECT
    MIN("Call Failure") AS min_call_failure,
    MAX("Call Failure") AS max_call_failure,

    MIN("Subscription Length") AS min_subscription_length,
    MAX("Subscription Length") AS max_subscription_length,

    MIN("Charge Amount") AS min_charge_amount,
    MAX("Charge Amount") AS max_charge_amount,

    MIN("Seconds of Use") AS min_seconds_of_use,
    MAX("Seconds of Use") AS max_seconds_of_use,

    MIN("Frequency of use") AS min_frequency_of_use,
    MAX("Frequency of use") AS max_frequency_of_use,

    MIN("Frequency of SMS") AS min_frequency_of_sms,
    MAX("Frequency of SMS") AS max_frequency_of_sms,

    MIN("Distinct Called Numbers") AS min_distinct_numbers,
    MAX("Distinct Called Numbers") AS max_distinct_numbers,

    MIN("Age") AS min_age,
    MAX("Age") AS max_age,

    MIN("Customer Value") AS min_customer_value,
    MAX("Customer Value") AS max_customer_value

FROM raw.customer_churn;


-- ============================================================
-- 6. MISSING VALUE CHECKS
-- ============================================================

SELECT
    COUNT(*) AS total_rows,

    COUNT(*) - COUNT("Call Failure") AS null_call_failure,
    COUNT(*) - COUNT("Complains") AS null_complains,
    COUNT(*) - COUNT("Subscription Length") AS null_subscription_length,
    COUNT(*) - COUNT("Charge Amount") AS null_charge_amount,
    COUNT(*) - COUNT("Seconds of Use") AS null_seconds_of_use,
    COUNT(*) - COUNT("Frequency of use") AS null_frequency_of_use,
    COUNT(*) - COUNT("Frequency of SMS") AS null_frequency_of_sms,
    COUNT(*) - COUNT("Distinct Called Numbers") AS null_distinct_numbers,
    COUNT(*) - COUNT("Age Group") AS null_age_group,
    COUNT(*) - COUNT("Tariff Plan") AS null_tariff_plan,
    COUNT(*) - COUNT("Status") AS null_status,
    COUNT(*) - COUNT("Age") AS null_age,
    COUNT(*) - COUNT("Customer Value") AS null_customer_value,
    COUNT(*) - COUNT("Churn") AS null_churn

FROM raw.customer_churn;


-- ============================================================
-- 7. DUPLICATE RECORD INVESTIGATION
-- ============================================================

SELECT
    *,
    COUNT(*) AS duplicate_count
FROM raw.customer_churn
GROUP BY
    "Call Failure",
    "Complains",
    "Subscription Length",
    "Charge Amount",
    "Seconds of Use",
    "Frequency of use",
    "Frequency of SMS",
    "Distinct Called Numbers",
    "Age Group",
    "Tariff Plan",
    "Status",
    "Age",
    "Customer Value",
    "Churn"
HAVING COUNT(*) > 1;


-- ============================================================
-- 8. INVALID CATEGORICAL VALUES
-- ============================================================

SELECT *
FROM raw.customer_churn
WHERE "Churn" NOT IN (0, 1)
   OR "Complains" NOT IN (0, 1)
   OR "Tariff Plan" NOT IN (1, 2)
   OR "Status" NOT IN (1, 2)
   OR "Age Group" NOT BETWEEN 1 AND 5;


-- ============================================================
-- 9. INVALID NEGATIVE VALUES
-- ============================================================ --

SELECT *
FROM raw.customer_churn
WHERE "Call Failure" < 0
   OR "Subscription Length" < 0
   OR "Charge Amount" < 0
   OR "Seconds of Use" < 0
   OR "Frequency of use" < 0
   OR "Frequency of SMS" < 0
   OR "Distinct Called Numbers" < 0
   OR "Age" < 0
   OR "Customer Value" < 0;