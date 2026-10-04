# Indian Vehicle Loan Credit Risk Analytics

An end-to-end credit risk analytics project using **Python, SQL, Power BI, and XGBoost** to analyze vehicle loan defaults and identify higher-risk borrower segments.

## Problem Statement

Loan defaults create financial risk for lenders and make it important to identify borrowers who may be more likely to default.

This project aims to analyze vehicle loan data to understand the factors associated with loan default and develop a data-driven approach to **risk segmentation and portfolio analysis**.

## Objective

- Identify key factors associated with loan default
- Analyze default patterns across borrower and loan characteristics
- Compare machine learning approaches for risk prediction
- Segment borrowers based on predicted default risk
- Build a dashboard to communicate the findings for business decision-making

## Approach

The project was carried out in the following stages:

1. **Data Cleaning & EDA** — Cleaned and explored 41K+ loan records using Python.
2. **Feature Engineering** — Created features including borrower age, LTV bands, credit score bands, and credit history measures.
3. **SQL Analysis** — Used MySQL to analyze portfolio-level default patterns.
4. **Machine Learning** — Compared Logistic Regression and XGBoost for default prediction.
5. **Risk Segmentation** — Ranked borrowers by predicted default probability and divided them into 10 risk deciles.
6. **Dashboard** — Built a Power BI dashboard to present portfolio and risk insights.

## Key Results

- **41K+** loan records analyzed
- **20.09%** overall default rate
- **53.47K** average loan amount
- **73.85%** average LTV
- XGBoost achieved a **0.668 mean 5-fold ROC-AUC**
- Logistic Regression achieved a **0.644 mean 5-fold ROC-AUC**
- Default rates ranged from approximately **8% in the lowest-risk decile to 36% in the highest-risk decile**
- The **80–90% LTV band** showed the highest observed default rate

## Machine Learning

Two models were evaluated:

| Model | 5-Fold Mean ROC-AUC |
|---|---:|
| Logistic Regression | **0.644** |
| XGBoost | **0.668** |

XGBoost was selected for risk segmentation because it showed stronger cross-validated performance.

Rather than relying only on a fixed classification threshold, borrowers were ranked by predicted default probability and grouped into **10 risk deciles** to provide a more useful view of relative borrower risk.

## SQL Analysis

MySQL was used for portfolio-level analysis, including:

- Default rate by LTV
- Default rate by credit score
- Default rate by previous overdue accounts
- Default rate by employment type
- Loan share vs. default share across LTV bands
- High-LTV borrowers with previous overdue accounts

## Power BI Dashboard

The dashboard provides a business-focused view of the portfolio, covering:

- Portfolio KPIs
- Default rate by LTV
- Credit score analysis
- Loan share vs. default share
- Employment type
- Previous overdue accounts
- XGBoost risk deciles

![Power BI Dashboard](risk%20dashboard.png)

## Key Insights

- The **80–90% LTV band** had the highest observed default rate.
- Credit score segments showed meaningful differences in default rates.
- Previous overdue accounts were associated with differences in observed default risk.
- XGBoost risk deciles showed clear separation between lower- and higher-risk borrower groups.

## Tech Stack

**Python:** Pandas, NumPy, Scikit-learn, XGBoost  
**SQL:** MySQL  
**Visualization:** Power BI, DAX, Matplotlib

