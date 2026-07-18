/*
===============================================================================
                         TeleConnect Analytics Hub
===============================================================================

File Name : Service_Quality_Analysis.sql
Author    : Vishwajit Waghdhare
Database  : TelecomAnalysis

-------------------------------------------------------------------------------
DESCRIPTION
-------------------------------------------------------------------------------

This SQL script contains the queries used to analyze customer
complaints, service quality, and customer satisfaction.

The analysis focuses on:

• Total Complaints
• Complaint Rate
• Average Satisfaction
• Churn Customers
• Monthly Complaint Trend
• Complaint Distribution by Category
• Complaints by Subscription Plan
• Average Satisfaction by Complaint Category

===============================================================================
*/

USE TelecomAnalysis;


-- KPI 1 : Total Complaints

SELECT
    SUM(ComplaintCount) AS Total_Complaints
FROM customer_cleaned;


-- KPI 2 : Complaint Rate

SELECT
    ROUND(
        SUM(CASE
                WHEN ComplaintCount > 0 THEN 1
                ELSE 0
            END) * 100.0 /
        COUNT(*),
        2
    ) AS Complaint_Rate
FROM customer_cleaned;


-- KPI 3 : Average Satisfaction


SELECT
    ROUND(
        AVG(SatisfactionScore),
        2
    ) AS Average_Satisfaction
FROM customer_cleaned;


-- KPI 4 : Churn Customers


SELECT
    COUNT(*) AS Churn_Customers
FROM customer_cleaned
WHERE ChurnStatus = 'Yes';


-- Monthly Complaint Trend


SELECT
    MONTHNAME(JoinDate) AS Month,
    SUM(ComplaintCount) AS Total_Complaints
FROM customer_cleaned
GROUP BY
    MONTH(JoinDate),
    MONTHNAME(JoinDate)
ORDER BY
    MONTH(JoinDate);


-- Complaint Distribution by Category


SELECT
    ComplaintCategory,
    COUNT(*) AS Total_Complaints
FROM customer_cleaned
GROUP BY ComplaintCategory
ORDER BY Total_Complaints DESC;


-- Complaints by Subscription Plan


SELECT
    PlanName,
    SUM(ComplaintCount) AS Total_Complaints
FROM customer_cleaned
GROUP BY PlanName
ORDER BY Total_Complaints DESC;


-- Average Satisfaction by Complaint Category

SELECT
    ComplaintCategory,
    ROUND(
        AVG(SatisfactionScore),
        2
    ) AS Average_Satisfaction
FROM customer_cleaned
GROUP BY ComplaintCategory
ORDER BY Average_Satisfaction DESC;
