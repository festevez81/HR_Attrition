SELECT *
FROM [dbo].[HR_Employee]

--Verificar si hay valores nulos



SELECT *
FROM dbo.HR_Employee
WHERE Age IS NULL OR Attrition IS NULL OR BusinessTravel IS NULL OR DailyRate IS NULL
   OR Department IS NULL OR DistanceFromHome IS NULL OR Education IS NULL
   OR EducationField IS NULL OR EmployeeCount IS NULL OR EmployeeNumber IS NULL
   OR EnvironmentSatisfaction IS NULL OR Gender IS NULL OR HourlyRate IS NULL
   OR JobInvolvement IS NULL OR JobLevel IS NULL OR JobRole IS NULL OR JobSatisfaction IS NULL
   OR MaritalStatus IS NULL OR MonthlyIncome IS NULL OR MonthlyRate IS NULL
   OR NumCompaniesWorked IS NULL OR OverTime IS NULL OR PercentSalaryHike IS NULL
   OR PerformanceRating IS NULL OR RelationshipSatisfaction IS NULL OR StandardHours IS NULL
   OR StockOptionLevel IS NULL OR TotalWorkingYears IS NULL OR TrainingTimesLastYear IS NULL
   OR WorkLifeBalance IS NULL OR YearsAtCompany IS NULL OR YearsInCurrentRole IS NULL
   OR YearsSinceLastPromotion IS NULL OR YearsWithCurrManager IS NULL;

   --General And Descriptive Analysis
     
  --Number of active employees

   SELECT COUNT(*) AS ActiveEmployees
FROM dbo.HR_Employee
WHERE Attrition = 'No';

--Calculate the average, maximum and minimun age

   SELECT 
    AVG(Age) AS AvgAge,
    MIN(Age) AS MinAge,
    MAX(Age) AS MaxAge
 FROM dbo.HR_Employee;

  --Calculate the average, maximum and minimun daily rate

 SELECT 
    AVG(DailyRate) AS AvgD_RATE,
    MIN(DailyRate) AS MinD_RATE,
    MAX(DailyRate) AS MaxD_RATE
 FROM dbo.HR_Employee;
 
 --Calculate the average, maximum and minimun monthly income

 SELECT 
    AVG(MonthlyIncome) AS AvgMonthlyIncome,
    MIN(MonthlyIncome) AS MinMonthlyIncome,
    MAX(MonthlyIncome) AS MaxMonthlyIncome
 FROM dbo.HR_Employee;

 --Attrition Rate 
 --Percent of employees who left the company

 SELECT 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dbo.HR_Employee) AS AttritionRate
FROM dbo.HR_Employee
WHERE Attrition = 'Yes';

--Gender Distribution 

SELECT Gender, COUNT(*) AS CountByGender
From dbo.HR_Employee
WHERE Attrition = 'No'
GROUP BY Gender;


--Attrition by departments
--departments with highest attrition rates

SELECT Department, COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS AttritionRate
FROM dbo.HR_Employee
GROUP BY Department
ORDER BY AttritionRate DESC;

--Compare average income across departments

SELECT Department, AVG(MonthlyIncome) AS AVGIncome
FROM [dbo].[HR_Employee]
GROUP BY Department
ORDER BY AVGIncome DESC;

--Impact of Overtime
--Compare income and attrition rates between employees who work overtime and those who don´t 

SELECT OverTime, 
       AVG(MonthlyIncome) AS AvgIncome,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS AttritionRate
FROM dbo.HR_Employee
GROUP BY OverTime;

--Job satisfaction Analisis
--Explore relatioship between job satisfaction and attrition rates

SELECT JobSatisfaction, 
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS AttritionRate
FROM dbo.HR_Employee
GROUP BY JobSatisfaction
ORDER BY AttritionRate DESC;

--Performance Rating Distribution
--Count employees by their performance rating

SELECT [PerformanceRating], COUNT(*) AS CountbyPerformance
FROM [dbo].[HR_Employee]
GROUP BY PerformanceRating;

--Impact of total working years on performance
--Analyze how total work experience influences performance rating

SELECT TotalWorkingYears, AVG(PerformanceRating) AS AvgPerformance
FROM dbo.HR_Employee
GROUP BY TotalWorkingYears
ORDER BY TotalWorkingYears ASC;

--Income by Job Level
-- Determine how monthly income varies with job levels

SELECT JobLevel, AVG(MonthlyIncome) AS AvgIncome
FROM dbo.HR_Employee
GROUP BY JobLevel
ORDER BY JobLevel ASC;

--Years with current manager
--Analyze whether years with current manager affect attrition rates

SELECT YearsWithCurrManager, 
       COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS AttritionRate
FROM dbo.HR_Employee
GROUP BY YearsWithCurrManager
ORDER BY YearsWithCurrManager ASC;


