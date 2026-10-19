# Vehicle Loan Credit Risk Analysis and Prediction

An end-to-end analysis of vehicle loan defaults using **Python, MySQL, Power BI, and XGBoost** to identify risk factors, analyze portfolio performance, and segment borrowers by predicted default risk.

## Problem Statement

Loan defaults expose financial institutions to potential losses. Identifying borrowers with higher default risk can help lenders make more informed credit assessment decisions.

This project analyzes the **L&T Financial Services Vehicle Loan dataset** to understand factors associated with loan defaults, compare machine learning models, and identify borrower segments that may require closer assessment.

## Key Results and Insights

### **1. Portfolio Default Risk**  
The portfolio had an overall default rate of **20.09%** across **41,000+ vehicle loan records**, establishing the baseline for assessing credit risk.

### **2. Higher Default Risk in the 80–90% LTV Band**  
The **80–90% loan-to-value (LTV) band** recorded the highest observed default rate. It also contributed a larger share of defaults than its share of total loans, highlighting a segment that warrants closer monitoring.

### **3. Credit Score and Default Risk**  
Default rates varied across credit score bands, indicating differences in observed default risk across borrower credit profiles.

### **4. Previous Overdue Accounts and Default Risk**  
Default rates varied by the number of previous overdue accounts. This highlights repayment history as a useful factor in understanding borrower risk, although the relationship was not consistently increasing across all overdue-account categories.

### **5. XGBoost Model Performance**  
XGBoost achieved a mean **5-fold cross-validation ROC-AUC of 0.668**, outperforming Logistic Regression at **0.644**. This indicates that XGBoost was better at distinguishing between default and non-default borrowers in the evaluation.

### **6. Risk Decile Segmentation**  
The XGBoost model ranked borrowers into 10 risk deciles. Observed default rates ranged from approximately **8% in the lowest-risk decile to 36% in the highest-risk decile**, representing a **4.5× spread** and demonstrating useful separation between lower- and higher-risk borrower segments.

## Power BI Dashboard

The dashboard presents portfolio performance and borrower risk patterns through:

- **Portfolio KPIs:** Total loans, default rate, average loan amount, and average LTV.
- **LTV analysis:** Default rates across LTV bands.
- **Credit profile:** Default rates by credit score.
- **Portfolio comparison:** Loan share versus default share across LTV bands.
- **Repayment history:** Default rates by previous overdue accounts.
- **Risk segmentation:** Observed default rates across XGBoost risk deciles.

![Power BI Credit Risk Dashboard](risk%20dashboard.png)

## Methodology

1. **Data Cleaning:** Handled missing values, imputed numerical fields using medians, addressed missing employment types, and removed duplicate records.
2. **Feature Engineering:** Converted account age and credit history into months and created borrower age and risk-related features.
3. **Exploratory Analysis:** Examined default distribution, LTV, credit scores, overdue accounts, and numerical correlations.
4. **SQL Analysis:** Wrote seven MySQL queries to analyze portfolio performance and default patterns.
5. **Model Evaluation:** Compared Logistic Regression and XGBoost using 5-fold cross-validation and ROC-AUC.
6. **Risk Segmentation:** Ranked borrowers by predicted default probability and grouped them into ten risk deciles.
7. **Visualization:** Built a Power BI dashboard to communicate findings and support risk assessment.

## Machine Learning

Two classification models were evaluated:

| Model | Mean 5-Fold ROC-AUC |
|---|---:|
| Logistic Regression | 0.644 |
| XGBoost | **0.668** |

XGBoost was selected for risk segmentation because it achieved stronger cross-validated discrimination than Logistic Regression.

Rather than relying only on a fixed classification threshold, the model was used to rank borrowers by predicted default probability. The resulting deciles showed a substantial difference in observed default rates between the lowest- and highest-risk groups.

## Tech Stack

- **Programming:** Python
- **Data Analysis:** Pandas, NumPy
- **Database:** MySQL
- **Machine Learning:** Scikit-learn, XGBoost
- **Visualization:** Power BI, DAX, Matplotlib
- **Techniques:** EDA, feature engineering, classification, cross-validation, risk segmentation, SQL CTEs and window functions

## Data Source

**L&T Financial Services Vehicle Loan dataset.**

The dataset contains loan and borrower credit information, including disbursed amount, asset cost, LTV, employment type, credit score, account history, overdue accounts, and the loan-default indicator.

The analyzed dataset contained **41K+ records**. The exact source URL and date coverage are not documented here.

## Business Implications

- **Credit assessment:** Higher-LTV borrowers and borrowers with weaker credit or repayment signals can be prioritized for further assessment.
- **Portfolio monitoring:** Comparing loan share with default share helps identify segments contributing disproportionately to defaults.
- **Risk prioritization:** Risk deciles provide a relative ranking of borrowers, helping risk teams focus attention on higher-risk segments.

These are potential applications of the analysis; actual reductions in defaults or financial losses were not measured.

## Limitations

- The model's mean ROC-AUC of **0.668** indicates moderate discrimination, leaving room for improvement.
- Class imbalance affects classification performance, so accuracy alone is not sufficient to evaluate the model.
- Risk deciles indicate relative risk, not certainty that an individual borrower will default.
- The analysis is based on the available dataset and has not been validated in a live lending environment.

## Conclusion

This project combines **SQL-based portfolio analysis, machine learning, and Power BI visualization** to investigate vehicle loan default risk. XGBoost outperformed the Logistic Regression baseline in cross-validation, while risk-decile analysis revealed meaningful differences in observed default rates. The results demonstrate how data analytics can support borrower risk assessment and portfolio monitoring.
