CREATE DATABASE loan_risk;
USE loan_risk;

# 1. overall portfolio summary

SELECT
    COUNT(*) AS total_loans,
    SUM(loan_default) AS total_defaults,
    ROUND(AVG(loan_default) * 100, 2) AS default_rate,
    ROUND(AVG(disbursed_amount), 2) AS avg_loan_amount,
    ROUND(AVG(ltv), 2) AS avg_ltv
FROM loan_data;

# 2. default rate by employment type
SELECT
    `Employment.Type`,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS total_defaults,
    ROUND(AVG(loan_default) * 100, 2) AS default_rate
FROM loan_data
GROUP BY `Employment.Type`
ORDER BY default_rate DESC;


# 3. loan default rate across LTV risk bands
SELECT
    CASE
        WHEN ltv < 60 THEN '<60'
        WHEN ltv < 70 THEN '60-70'
        WHEN ltv < 80 THEN '70-80'
        WHEN ltv < 90 THEN '80-90'
        WHEN ltv < 100 THEN '90-100'
        ELSE '100+'
    END AS ltv_band,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS total_defaults,
    ROUND(AVG(loan_default) * 100, 2) AS default_rate
FROM loan_data
GROUP BY ltv_band
ORDER BY default_rate DESC;

# 4. loan default rate across credit score bands
SELECT
    CASE
        WHEN `PERFORM_CNS.SCORE` = 0 THEN 'No Score'
        WHEN `PERFORM_CNS.SCORE` <= 300 THEN '1-300'
        WHEN `PERFORM_CNS.SCORE` <= 600 THEN '301-600'
        WHEN `PERFORM_CNS.SCORE` <= 750 THEN '601-750'
        WHEN `PERFORM_CNS.SCORE` <= 900 THEN '751-900'
        ELSE '900+'
    END AS credit_score_band,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS total_defaults,
    ROUND(AVG(loan_default) * 100, 2) AS default_rate
FROM loan_data
GROUP BY credit_score_band
ORDER BY default_rate DESC;

# 5. loan default rate based on previous overdue accounts
SELECT
    CASE
        WHEN `PRI.OVERDUE.ACCTS` = 0 THEN '0'
        WHEN `PRI.OVERDUE.ACCTS` = 1 THEN '1'
        WHEN `PRI.OVERDUE.ACCTS` = 2 THEN '2'
        WHEN `PRI.OVERDUE.ACCTS` = 3 THEN '3'
        WHEN `PRI.OVERDUE.ACCTS` BETWEEN 4 AND 5 THEN '4-5'
        ELSE '6+'
    END AS overdue_band,
    COUNT(*) AS total_loans,
    SUM(loan_default) AS total_defaults,
    ROUND(AVG(loan_default) * 100, 2) AS default_rate
FROM loan_data
GROUP BY overdue_band
ORDER BY default_rate DESC;

# 6. Compare each LTV band's share of loans with its share of total defaults
WITH ltv_summary AS (
    SELECT
        CASE
            WHEN ltv < 60 THEN '<60'
            WHEN ltv < 70 THEN '60-70'
            WHEN ltv < 80 THEN '70-80'
            WHEN ltv < 90 THEN '80-90'
            WHEN ltv < 100 THEN '90-100'
            ELSE '100+'
        END AS ltv_band,
        COUNT(*) AS total_loans,
        SUM(loan_default) AS total_defaults
    FROM loan_data
    GROUP BY
        CASE
            WHEN ltv < 60 THEN '<60'
            WHEN ltv < 70 THEN '60-70'
            WHEN ltv < 80 THEN '70-80'
            WHEN ltv < 90 THEN '80-90'
            WHEN ltv < 100 THEN '90-100'
            ELSE '100+'
        END
)
SELECT
    ltv_band,
    total_loans,
    total_defaults,
    ROUND(total_loans * 100.0 / SUM(total_loans) OVER (), 2) AS loan_share_pct,
    ROUND(total_defaults * 100.0 / SUM(total_defaults) OVER (), 2) AS default_share_pct,
    ROUND(
        (total_defaults * 100.0 / SUM(total_defaults) OVER ())
        - (total_loans * 100.0 / SUM(total_loans) OVER ()),
        2
    ) AS share_gap_pct
FROM ltv_summary
ORDER BY default_share_pct DESC;

# 7. High-LTV + overdue borrowers vs. overall default rate
WITH portfolio AS (
    SELECT
        AVG(loan_default) * 100 AS overall_default_rate
    FROM loan_data
),
high_risk AS (
    SELECT
        COUNT(*) AS high_risk_loans,
        AVG(loan_default) * 100 AS high_risk_default_rate
    FROM loan_data
    WHERE ltv >= 90
      AND `PRI.OVERDUE.ACCTS` > 0
)
SELECT
    high_risk_loans,
    ROUND(high_risk_default_rate, 2) AS high_risk_default_rate,
    ROUND(overall_default_rate, 2) AS overall_default_rate,
    ROUND(high_risk_default_rate - overall_default_rate, 2) AS difference_pp
FROM high_risk
CROSS JOIN portfolio;