CREATE DATABASE hranalytics;
use hranalytics;

#----------CLEANING DATA----------#
ALTER TABLE records 
DROP COLUMN MarriedID,
DROP COLUMN MaritalStatusID,
DROP COLUMN Termd,
DROP COLUMN GenderID,
DROP COLUMN DeptID,
DROP COLUMN FromDiversityJobFairID,
DROP COLUMN EmpStatusID,
DROP COLUMN HispanicLatino;

#----------Formatting Date Of Birth----------#
UPDATE records SET Dob = LTRIM(Dob);
UPDATE records SET Dob = REPLACE(Dob,"/","-");
UPDATE records SET Dob = CONCAT('19',RIGHT(Dob,2),'-',LEFT(Dob,5));
UPDATE records SET Dob = STR_TO_DATE(Dob,'%Y-%m-%d');

#----------Deriving AGE From Date Of Birth----------#
ALTER TABLE records ADD COLUMN Age INT;
UPDATE records SET Age = DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(),Dob)), '%Y') + 0;

#----------Formating DateOfHire----------#
UPDATE records SET DateofHire = LTRIM(RTRIM(DateofHire));
UPDATE records SET DateofHire = REPLACE(DateofHire,"/","-");
UPDATE records SET DateofHire = CONCAT('0',DateofHire) WHERE DateofHire NOT LIKE "0%" AND LENGTH(DateofHire)=9;
UPDATE records SET DateofHire = CONCAT(RIGHT(DateofHire,4),'-',LEFT(DateofHire,5));
UPDATE records SET DateofHire = STR_TO_DATE(DateofHire,'%Y-%m-%d');

#----------Deriving Hire/Termination Year-------------#
ALTER TABLE records ADD COLUMN HireYear int;
UPDATE records SET HireYear = YEAR(DateofHire);

ALTER TABLE records ADD COLUMN TermYear int;
UPDATE records SET TermYear = YEAR(DateofTermination) WHERE DateofTermination IS NOT NULL;

#----------Foramatting DateOfTermination----------#
UPDATE records SET DateofTermination = LTRIM(RTRIM(DateofTermination));
UPDATE records SET DateofTermination = NULLIF(DateofTermination,'');
UPDATE records SET DateofTermination = REPLACE(DateofTermination,"/","-");
UPDATE records SET DateofTermination = CONCAT('0',DateofTermination) WHERE DateofTermination NOT LIKE "0%" AND LENGTH(DateofTermination)=9 AND DateofTermination IS NOT NULL;
UPDATE records SET DateofTermination = CONCAT(RIGHT(DateofTermination,4),'-',LEFT(DateofTermination,5)) WHERE LENGTH(DateofTermination) > 0 ;
UPDATE records SET DateofTermination = STR_TO_DATE(DateofTermination,'%Y-%m-%d') WHERE DateofTermination IS NOT NULL;


# 1.HEADCOUNT

SELECT COUNT(*) AS Total FROM records WHERE DateofTermination IS NULL ;
# By Department
SELECT Department,COUNT(Employee_Name) AS Count FROM records WHERE DateofTermination IS NULL GROUP BY Department ORDER BY Count;

# 2.GENDER RATIO

SELECT Gender,COUNT(Gender) AS Count FROM records WHERE DateofTermination IS NULL GROUP BY Gender;
# By Department
SELECT Gender,Department,COUNT(Gender) AS Count FROM Records WHERE DateofTermination IS NULL GROUP BY Department,Gender ORDER BY Department,Gender DESC;

# 3.Left Within an Year
SELECT EXTRACT(YEAR FROM DateOfHire) AS HireYear,COUNT(DATEDIFF(DateofTermination,DateofHire)<364) AS 'LeftWithinYear' FROM records 
WHERE DATEDIFF(DateofTermination,DateofHire)<364 OR DateofTermination IS NULL GROUP BY EXTRACT(YEAR FROM DateofHire) ORDER BY DateofHire;

# 4.Total Hired Per Year
SELECT EXTRACT(YEAR FROM DateofHire) AS HireYear,COUNT(DateofHire) AS TotalHired FROM records GROUP BY EXTRACT(YEAR FROM DateOfHire) ORDER BY DateofHire;

# 5.Total Left Per Year
SELECT YEAR(DateofTermination) AS Year,COUNT(DateofTermination) AS Total_Left FROM records 
WHERE DateofTermination IS NOT NULL GROUP BY YEAR(DateofTermination) ORDER BY Year;

# 6.Recruitment Source
SELECT RecruitmentSource,COUNT(RecruitmentSource) Total_Hired FROM records WHERE DateofTermination IS NULL GROUP BY RecruitmentSource ;

# 7.Termination Reasons 
SELECT TermReason,COUNT(TermReason) AS Total FROM records WHERE DateofTermination IS NOT NULL GROUP BY TermReason ORDER BY Total DESC;

# 8.Years Served
SELECT Employee_Name,DateofHire,DateofTermination,Floor((DATEDIFF(DateofTermination,DateofHire))/365) AS Years_Served FROM records WHERE DateofTermination IS NOT NULL;
SELECT Employee_Name,DateofHire,Floor((DATEDIFF(NOW(),DateofHire))/365) AS Years_Served FROM records WHERE DateofTermination IS NULL;

ALTER TABLE records ADD YearsInCompany int;
UPDATE records SET YearsInCompany = Floor((DATEDIFF(NOW(),DateofHire))/365) WHERE DateofTermination IS NULL;
UPDATE records SET YearsInCompany = Floor((DATEDIFF(DateofTermination,DateofHire))/365) WHERE DateofTermination IS NOT NULL;

# 9.Average Service
SELECT FLOOR(AVG(YearsInCompany)) AS AverageService FROM records;

# 10.Average Salary By Department
SELECT Position,FLOOR(AVG(Salary)) AS Average_Salary FROM records WHERE DateofTermination IS NULL GROUP BY Position ORDER BY Position;

# 11.Average Employee Score By Department
SELECT Department,AVG(PerfScoreID) AS PerformanceScore FROM records WHERE DateofTermination IS NULL GROUP BY Department ORDER BY Department;

# 12.Absence_Percentage
SELECT Employee_Name,Department,position,Absences,CONCAT(ROUND(((Absences/250)*100),1),'%') AS Absence_Percentage FROM records;
ALTER TABLE records ADD COLUMN `Absence%` float;
UPDATE records SET `Absence%` = ROUND(((Absences/250)*100),1);

# 13.Employees likely to leave
SELECT Employee_Name,Department,position FROM records WHERE EmpSatisfaction <2;

# 14.Employees likely to stay
SELECT Employee_Name,Department FROM records WHERE EmpSatisfaction = 5 AND EngagementSurvey = 5 AND PerfScoreID >=4;

# 15.Diversity
SELECT CitizenDesc,RaceDesc,COUNT(RaceDesc) AS Total FROM records GROUP BY CitizenDesc,RaceDesc ORDER BY CitizenDesc;

# 16.Best Recruitment Source
SELECT RecruitmentSource,ROUND(AVG(PerfScoreID),2) AS Average_Performance,ROUND(AVG(EngagementSurvey),2) AS Average_Engagement,ROUND(AVG(EmpSatisfaction),2) AS Avg_Employee_Satisfaction
FROM records
GROUP BY RecruitmentSource ORDER BY Average_Performance DESC;

# 17. Laggards
SELECT Employee_Name,Department,Position FROM records WHERE PerfScoreID < 2 AND EngagementSurvey < 2 AND SpecialProjectsCount =0;





