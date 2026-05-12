-- HR Attrition Analytics — SQL Queries
-- Database: HRAnalyticsDB
-- Analyst: Piumi Jayawardene

USE HRAnalyticsDB;
GO

SELECT TOP 5 * FROM Employees;

-- Query 1: Attrition rate by department
SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 
    1) AS Attrition_Rate_Pct
FROM Employees
GROUP BY Department
ORDER BY Attrition_Rate_Pct DESC;

-- Query 2: Does overtime drive attrition?
SELECT 
    OverTime,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left_Company,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
    1) AS Attrition_Pct
FROM Employees
GROUP BY OverTime
ORDER BY Attrition_Pct DESC;

-- Query 3: Which job roles lose the most people?
SELECT 
    JobRole,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left_Company,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
    1) AS Attrition_Pct
FROM Employees
GROUP BY JobRole
ORDER BY Attrition_Pct DESC;

-- Query 4: Income difference between stayed vs left
SELECT 
    Attrition,
    COUNT(*) AS Employee_Count,
    ROUND(AVG(CAST(MonthlyIncome AS FLOAT)), 0) AS Avg_Monthly_Income,
    ROUND(MIN(CAST(MonthlyIncome AS FLOAT)), 0) AS Min_Income,
    ROUND(MAX(CAST(MonthlyIncome AS FLOAT)), 0) AS Max_Income
FROM Employees
GROUP BY Attrition;

-- Query 5: Job satisfaction and attrition
SELECT 
    JobSatisfaction,
    WorkLifeBalance,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left_Company,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
    1) AS Attrition_Pct
FROM Employees
GROUP BY JobSatisfaction, WorkLifeBalance
ORDER BY Attrition_Pct DESC;