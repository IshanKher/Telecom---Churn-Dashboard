-- New Final Telecom Project

-- ====================== Dashboard 1 ======================

create Schema Telecom_Vodafone_Idea;

CREATE TABLE telecom_churn (
    customer_id VARCHAR(50),
    telecom_partner VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    state VARCHAR(50),
    city VARCHAR(50),
    pincode VARCHAR(10),
    date_of_registration DATE,
    num_dependents INT,
    monthly_bill DECIMAL(10,2),
    international_usage_kb DECIMAL(10,2),
    calls_made_sec DECIMAL(10,2),
    sms_sent INT,
    data_used_kb DECIMAL(10,2),
    churn INT -- 1 = Yes, 0 = No
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/telecom_churn.csv'
INTO TABLE telecom_churn
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 1 - Total Customers

SELECT COUNT(*) AS total_customers FROM telecom_churn;

-- 2 - Total Churned

SELECT COUNT(*) AS churned_customers 
FROM telecom_churn 
WHERE churn = 1;

-- 3 - Churn Rate %
SELECT 
    Round(SUM(Churn) / Count(*) * 100,2) AS churn_rate_percentage
FROM telecom_churn; 

-- 4 - Churned By Gender

Select
	gender,
    Count(churn) AS Churned_Count
FROM telecom_churn
Where churn = 1
Group By gender
Order By Churned_Count;

-- Churned By Gender %
Select
	Gender,
	Round(Sum(churn) / Count(*) * 100,2) AS churn_rate_percentage
FROM telecom_churn
Group By gender
Order By churn_rate_percentage;

-- 5 - Churn by Age Group

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age >= 55 THEN '55+'
    END AS age_group,
    COUNT(*) AS churned_customers
FROM telecom_churn
WHERE churn = 1
GROUP BY age_group
ORDER BY age_group;

-- Churn Rate

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age >= 55 THEN '55+'
    END AS age_group,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM telecom_churn
GROUP BY age_group
ORDER BY age_group;

-- 6 - Churn by State

Select
	state,
    Count(*) AS Total_Customers,
    Sum(churn) AS churned_customers,
    Round(Sum(Churn) * 100 / Count(*) ,2) AS churn_rate_percentage
FROM telecom_churn
Group By state
Order By churn_rate_percentage desc
Limit 10;

-- add on - Churn by Number of Dependents

Select 
	num_dependents,
    count(*) AS total_customers,
    Sum(churn) AS Churned_Customers,
    Round(SUM(Churn) * 100 /  count(*),2) AS churn_rate_percentage
From telecom_churn
Group By num_dependents
Order By num_dependents;

-- 7 - Churn by Revenue Metrics

Select
	Case
		When monthly_bill < 30000 THEN "30000"
		When monthly_bill Between 50000 AND 80000 THEN "50000-79999"
		When monthly_bill Between 80000 AND 112000 THEN "80000-111999"
		ELSE "112001"
END AS bill_bucket,
Count(*) AS total_customers,
SUM(churn) AS churned_customers,
Round(SUM(Churn) * 100 / Count(*),2) AS churn_rate_percentage
From telecom_churn
Group By bill_bucket
Order by churn_rate_percentage DESC;

-- 8 - Age vs Churn

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age >= 55 THEN '55+'
    END AS age_group,
    Count(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM telecom_churn
GROUP BY age_group
ORDER BY churn_rate_percentage;

-- 9 -  Calls Made, SMS Sent, Data Usage vs Churn

Select
	Churn,
    Round(AVG(calls_made_sec), 2) AS AVG_Calling,
    Round(AVG(sms_sent), 2) AS AVG_SMS,
    Round(AVG(data_used_kb), 2) AS AVG_Data_Usage
From telecom_churn
Group By Churn;


-- ====================== Dashboard 2 ======================



-- 1 - Monthly Bill Segment + KPI Overview

Select
	Case
		When monthly_bill < 30000 THEN "30000"
		When monthly_bill Between 30000 AND 80000 THEN "50000-79999"
		When monthly_bill Between 80000 AND 112000 THEN "80000-111999"
		ELSE "112001"
END AS bill_segment,
Count(*) AS total_customers,
SUM(churn) AS churned_customers,
Round(SUM(Churn) * 100 / Count(*),2) AS churn_rate_percentage,
Round(AVG(monthly_bill), 2) AS avg_bill
From telecom_churn
Group By bill_segment
Order by bill_segment;

-- 2 - Behavior Comparison

SELECT 
  churn,
  ROUND(AVG(calls_made_sec), 2) AS avg_calls_made_sec,
  ROUND(AVG(sms_sent), 2) AS avg_sms_sent,
  ROUND(AVG(data_used_KB), 2) AS avg_data_used_KB,
  ROUND(AVG(international_usage_KB), 2) AS avg_int_usage_KB
FROM telecom_churn
GROUP BY churn;

-- 3 - Monthly Churn Trend (by Registration Date)

Select
	date_format(date_of_registration, '%Y,%m') AS Reg_Month,
    Count(*) AS Total_registered,
    SUM(churn) AS churned_customers,
    Round(Sum(churn) * 100 / Count(*), 2) AS churn_rate_percentage
FROM telecom_churn
GROUP BY reg_month
ORDER BY reg_month;

-- 4 - Age Group vs Churn Rate

SELECT 
  CASE 
    WHEN age < 25 THEN '<25'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END AS age_group,
  COUNT(*) AS total_customers,
  SUM(churn) AS churned_customers,
  ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM telecom_churn
GROUP BY age_group
ORDER BY age_group;

-- 5 - Top 10% Power Users

-- ➤ 1. Get total rows and compute position for 90th percentile:

SELECT 
  FLOOR(COUNT(*) * 0.9) AS skip_count
FROM telecom_churn;

-- ➤ 2. Get the 90th Percentile Value for calls_made_sec

Select
	calls_made_sec
From telecom_churn
Order By calls_made_sec
Limit 1 Offset 54721;

-- For data_used_kb

-- ➤ 1. Get total rows and compute position for 90th percentile:

SELECT 
  FLOOR(COUNT(*) * 0.9) AS skip_count
FROM telecom_churn;

-- ➤ 2. Get the 90th Percentile Value for calls_made_sec

Select
	data_used_kb
From telecom_churn
Order By calls_made_sec
Limit 1 Offset 54721;

-- ➤ 3. Use These Values in Final Query

Select
	Count(*) AS Total_Users,
    Sum(Case
		When calls_made_sec >= 89.00 or data_used_kb >= 9000 Then 1
        Else 0
        End) AS Power_Users
From telecom_churn;

SELECT 
  customer_id,
  calls_made_sec,
  data_used_KB,
  (calls_made_sec + data_used_KB) AS power_score,
  RANK() OVER (ORDER BY (calls_made_sec + data_used_KB) DESC) AS power_rank
FROM telecom_churn;

-- Churn Rate KPI

select
	Round(SUM(Churn) / Count(*) * 100,2) AS Churn_Rate
From telecom_churn;

-- Churn by Gender

Select
    Gender,
    Count(*) AS Total_Customers,
    Sum(Churn) AS Churned_customers,
	Round(Sum(Churn) / Count(*) * 100,2) AS churn_rate
From telecom_churn
Group By Gender;

-- Churn by Age Buckets

Select
	Case
		When Age <=25  then 'Under 25'
        When Age Between 26 and 40 Then '26-40'
        When Age Between 41 and 60 Then '41-60'
		Else '60+'
End AS Age_group,
Count(*) AS Total_Customers,
SUM(Churn) AS Churned_Customers,
Round(sum(churn) / Count(*) * 100,2) AS Churn_Rate
From telecom_churn
Group By Age_group;

-- Churn by Num of Dependents

Select
	num_dependents,
    Count(*) AS Total_Customers,
    SUm(Churn) AS Churned_Customers,
    Round(SUM(Churn) / Count(*) * 100,2) AS Churn_Rate
From telecom_churn
Group By num_dependents;

-- Churn by State

Select
	State,
    Count(*) AS Total_Customers,
    SUm(Churn) AS Churned_Customers,
    Round(SUM(Churn) / Count(*) * 100,2) AS Churn_Rate
From telecom_churn
Group By State;

--  Churn by Monthly Bill Buckets

Select
	Case
		When monthly_bill < 30000 THEN "30000"
		When monthly_bill Between 30000 AND 80000 THEN "50000-79999"
		When monthly_bill Between 80000 AND 112000 THEN "80000-111999"
		ELSE "112001"
	End AS bill_range,
    Round(AVG(monthly_bill),2) as avg_bill,
    Round(AVG(Churn) / Count(*) * 100,2) AS AVG_Churn_Rate
FROM telecom_churn
GROUP BY bill_range
ORDER BY bill_range;

-- Age vs Churn (Scatter or Distribution)

Select
	Age,
    Churn
FROM telecom_churn;

-- Calls / SMS / Data Usage vs Churn

Select
	Churn,
    Round(AVG(calls_made_sec),2) AS avg_calls_made,
    Round(AVG(sms_sent),2) AS avg_sms_sent,
    Round(AVG(data_used_kb),2) AS AVG_data_used_kb
FROM telecom_churn
GROUP BY churn;

--  1. Telecom – Churn Rate by Age Group

Select
	Case
		When Age <=25  then 'Young'
        When Age Between 26 and 40 Then 'Adult'
        When Age Between 41 and 60 Then 'Senior'
	End AS Age_Group,
Round(Sum(churn) / count(*) * 100,2) AS Churn_Rate
FROM telecom_churn
Group By Age_Group;

-- 2. Walmart – Top 3 Product Lines by Quantity Sold

Select
	ProductLine,
    Count(Quantity) AS Quantity_Sold
From walmartsales
Group By ProductLine
Order By Quantity_Sold DESC
Limit 3;

-- 3. Telecom – Identify High-Spend Users (NTILE)

Select
Case
		When monthly_bill < 30000 THEN "Low"
		When monthly_bill Between 30000 AND 80000 THEN "Moderate"
		ELSE "High"
	End AS Top_Spenders,
	customer_id,
    monthly_bill,
    Ntile(4) over (Order By monthly_bill DESC)
From telecom_churn;
    
-- 4. Netflix – Count of Movies vs TV Shows Added per Year

Select
	type,
    Count(*) AS Total_Count,
    date_added
From netflix_titles
Group By type, date_added
Order By Total_Count;

-- 5. Telecom – Running Avg of Data Usage by Month

SELECT 
  DATE_FORMAT(date_of_registration, '%Y-%m') AS Month,
  ROUND(AVG(data_used_kb), 2) AS Avg_Data,
  ROUND(AVG(AVG(data_used_kb)) OVER (ORDER BY DATE_FORMAT(date_of_registration, '%Y-%m') ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS Running_Avg
FROM telecom_churn
GROUP BY Month
ORDER BY Month;
