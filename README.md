# Telecom---Churn-Dashboard
SQL + Tableau-based Telecom Churn Analysis with Overview &amp; Deep Dive dashboards for business decision-making


telecom-churn-dashboard-sql-tableau/
│
├── README.md
├── churn_overview.pdf
├── churn_deep_dive.pdf
├── churn_segmentation.sql
├── project_summary.docx
└── https://public.tableau.com/app/profile/ishan4560/viz/Telecom-ChurnOverview/ChurnOverview
https://public.tableau.com/app/profile/ishan4560/viz/Telecom-ChurnDeepDive/ChurnDeepDiveCustomerPerson

# Telecom Churn Analysis (SQL + Tableau)

This project contains two dashboards built using SQL and Tableau to analyze telecom customer churn from both a high-level and deep-dive perspective.

## 🔹 Churn Overview Dashboard
Provides a summary of churn by region, age, plan type, and billing metrics.

Objective:
To provide a snapshot of customer churn across demographic, geographic, and billing metrics — enabling business teams to quickly identify churn trends and retention opportunities.

Key KPIs:
Average Data Used – Tracks service engagement level
Average Monthly Bill – Segments users by ARPU (Revenue)
Churn Rate – (SUM(Churn)/COUNT(*)) * 100
Total Customers – Overall customer base

SQL Highlights:
NTILE(4) for bill-based segmentation
CASE WHEN for age and billing groups
AVG() and SUM() for KPI calculation
Business Insight Highlights:
Gen-Z users show highest churn – indicates low loyalty
Churn is regionally concentrated – highlights service gaps
High-bill users churn more – signals loss of premium customers

## 🔸 Churn Deep Dive Dashboard
Uncovers root causes of churn using usage behavior, demographics, and tenure.

Objective:
To uncover root causes of churn through customer-level behavioral, demographic, and usage data — and help define targeted retention strategies.

Key Features:
Household size & tenure-based churn risk mapping
Age buckets, usage frequency, billing trend breakdown
Drill-down filters by region, plan type, churn segment

SQL Highlights:
DATEDIFF() to analyze tenure and recency
Combined filtering logic for churn vs retained segmentation
Multi-level aggregations for behavior patterns

Business Insight Highlights:
Long-tenure users churn less – possible loyalty indicators
High usage ≠ retention – overuse may link to dissatisfaction
Certain family-size patterns correlate with higher churn

## 🔗 Tableau Public Links
- https://public.tableau.com/app/profile/ishan4560/viz/Telecom-ChurnOverview/ChurnOverview
- https://public.tableau.com/app/profile/ishan4560/viz/Telecom-ChurnDeepDive/ChurnDeepDiveCustomerPerson

## 📁 Included Files
- churn_overview.pdf
- churn_deep_dive.pdf
- churn_segmentation.sql
- project_summary.docx

## - This dashboard helps business teams detect revenue leakage via churn and prioritize customer segments for retention campaigns.
