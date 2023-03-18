CREATE DATABASE Sales_analytics;
USE Sales_analytics;


														# JANUARY SALES DATA
                                                                            
					# FORMATTING DATA
                    
ALTER TABLE Jan RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Jan RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Jan RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Jan RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Jan RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Jan; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM jan;
SELECT DISTINCT Quantity FROM jan;
SELECT DISTINCT Rate FROM jan;
SELECT DISTINCT Product FROM jan;
SELECT DISTINCT MONTH(Order_Date) FROM jan; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM jan; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM jan; # FORMATTING NEEDED


# ORDER DATE
UPDATE jan SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE jan SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM jan;
UPDATE jan SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM jan;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM jan;
SELECT DISTINCT DAY(Order_Date) FROM jan;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM jan;
ALTER TABLE jan ADD COLUMN Sales DOUBLE;
UPDATE jan SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM jan;
ALTER TABLE jan ADD COLUMN Month text;
UPDATE jan SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE jan SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE jan SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE jan SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE jan SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE jan SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE jan SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE jan SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE jan SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE jan SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE jan SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE jan SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';


# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM jan;
ALTER TABLE jan ADD COLUMN Street VARCHAR(20);
UPDATE jan SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM jan;
ALTER TABLE jan ADD COLUMN City VARCHAR(20);
UPDATE jan SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM jan;
ALTER TABLE jan ADD COLUMN State VARCHAR(20);
UPDATE jan SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM jan;
ALTER TABLE jan ADD COLUMN ZipCode VARCHAR(25);
UPDATE jan SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM jan;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM jan GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM jan;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM jan GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM jan GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM jan GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM jan GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM jan GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM jan GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM jan GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM jan GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM jan GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM jan GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#-----------------------------------------------------FEBRURARY SALES DATA---------------------------------------------------------------#

# FORMATTING DATA

ALTER TABLE Feb RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Feb RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Feb RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Feb RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Feb RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Feb; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Feb;
SELECT DISTINCT Quantity FROM Feb;
SELECT DISTINCT Rate FROM Feb;
SELECT DISTINCT Product FROM Feb;
SELECT DISTINCT MONTH(Order_Date) FROM Feb; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Feb; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Feb; # FORMATTING NEEDED


# ORDER DATE
UPDATE Feb SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Feb SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Feb;
UPDATE Feb SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Feb;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Feb;
SELECT DISTINCT DAY(Order_Date) FROM Feb;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Feb;
ALTER TABLE Feb ADD COLUMN Sales DOUBLE;
UPDATE Feb SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Feb;
ALTER TABLE Feb ADD COLUMN Month text;
UPDATE Feb SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Feb SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Feb SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Feb SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Feb SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Feb SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Feb SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Feb SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Feb SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Feb SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Feb SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Feb SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';


# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Feb;
ALTER TABLE Feb ADD COLUMN Street VARCHAR(20);
UPDATE Feb SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Feb;
ALTER TABLE Feb ADD COLUMN City VARCHAR(20);
UPDATE Feb SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Feb;
ALTER TABLE Feb ADD COLUMN State VARCHAR(20);
UPDATE Feb SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Feb;
ALTER TABLE Feb ADD COLUMN ZipCode VARCHAR(25);
UPDATE Feb SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Feb;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Feb GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Feb;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Feb GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Feb GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Feb GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Feb GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Feb GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Feb GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Feb GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Feb GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Feb GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Feb GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;


#-----------------------------------------------------MARCH SALES DATA---------------------------------------------------------------#

# FORMATTING DATA

ALTER TABLE Mar RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Mar RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Mar RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Mar RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Mar RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Mar; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Mar;
SELECT DISTINCT Quantity FROM Mar;
SELECT DISTINCT Rate FROM Mar;
SELECT DISTINCT Product FROM Mar;
SELECT DISTINCT MONTH(Order_Date) FROM Mar; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Mar; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Mar; # FORMATTING NEEDED


# ORDER DATE
UPDATE Mar SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Mar SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Mar;
UPDATE Mar SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Mar;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Mar;
SELECT DISTINCT DAY(Order_Date) FROM Mar;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Mar;
ALTER TABLE Mar ADD COLUMN Sales DOUBLE;
UPDATE Mar SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Mar;
ALTER TABLE Mar ADD COLUMN Month text;
UPDATE Mar SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Mar SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Mar SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Mar SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Mar SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Mar SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Mar SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Mar SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Mar SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Mar SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Mar SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Mar SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Mar;
ALTER TABLE Mar ADD COLUMN Street VARCHAR(20);
UPDATE Mar SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Mar;
ALTER TABLE Mar ADD COLUMN City VARCHAR(20);
UPDATE Mar SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Mar;
ALTER TABLE Mar ADD COLUMN State VARCHAR(20);
UPDATE Mar SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Mar;
ALTER TABLE Mar ADD COLUMN ZipCode VARCHAR(25);
UPDATE Mar SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Mar;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Mar GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Mar;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Mar GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Mar GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Mar GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Mar GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Mar GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Mar GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Mar GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Mar GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Mar GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Mar GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#-----------------------------------------------------APRIL SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE Apr RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Apr RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Apr RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Apr RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Apr RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Apr; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Apr;
SELECT DISTINCT Quantity FROM Apr; # FORMATTING NEEDED
SELECT DISTINCT Rate FROM Apr; # FORMATTING NEEDED
SELECT DISTINCT Product FROM Apr; # FORMATTING NEEDED
SELECT DISTINCT MONTH(Order_Date) FROM Apr; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Apr; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Apr; # FORMATTING NEEDED

# REMOVING EMPTY & INVALID VALUES
DELETE FROM Apr WHERE Quantity = '' OR  Quantity = 'Quantity Ordered';

# ORDER DATE
UPDATE Apr SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Apr SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Apr;
UPDATE Apr SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Apr;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Apr;
SELECT DISTINCT DAY(Order_Date) FROM Apr;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Apr;
ALTER TABLE Apr ADD COLUMN Sales DOUBLE;
UPDATE Apr SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Apr;
ALTER TABLE Apr ADD COLUMN Month text;
UPDATE Apr SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Apr SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Apr SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Apr SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Apr SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Apr SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Apr SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Apr SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Apr SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Apr SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Apr SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Apr SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Apr;
ALTER TABLE Apr ADD COLUMN Street VARCHAR(20);
UPDATE Apr SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Apr;
ALTER TABLE Apr ADD COLUMN City VARCHAR(20);
UPDATE Apr SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Apr;
ALTER TABLE Apr ADD COLUMN State VARCHAR(20);
UPDATE Apr SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Apr;
ALTER TABLE Apr ADD COLUMN ZipCode VARCHAR(25);
UPDATE Apr SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Apr;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Apr GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Apr;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Apr GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Apr GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Apr GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Apr GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Apr GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Apr GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Apr GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Apr GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Apr GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Apr GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;


#-----------------------------------------------------MAY SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE May RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE May RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE May RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE May RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE May RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC May; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM May;
SELECT DISTINCT Quantity FROM May;
SELECT DISTINCT Rate FROM May;
SELECT DISTINCT Product FROM May;
SELECT DISTINCT MONTH(Order_Date) FROM May; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM May; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM May; # FORMATTING NEEDED


# ORDER DATE
UPDATE May SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE May SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM May;
UPDATE May SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM May;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM May;
SELECT DISTINCT DAY(Order_Date) FROM May;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM May;
ALTER TABLE May ADD COLUMN Sales DOUBLE;
UPDATE May SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM May;
ALTER TABLE May ADD COLUMN Month text;
UPDATE May SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE May SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE May SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE May SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE May SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE May SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE May SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE May SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE May SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE May SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE May SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE May SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM May;
ALTER TABLE May ADD COLUMN Street VARCHAR(20);
UPDATE May SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM May;
ALTER TABLE May ADD COLUMN City VARCHAR(20);
UPDATE May SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM May;
ALTER TABLE May ADD COLUMN State VARCHAR(20);
UPDATE May SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM May;
ALTER TABLE May ADD COLUMN ZipCode VARCHAR(25);
UPDATE May SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM May;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM May GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM May;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM May GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM May GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM May GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM May GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM May GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM May GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM May GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM May GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM May GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM May GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#-----------------------------------------------------JUNE SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE Jun RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Jun RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Jun RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Jun RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Jun RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Jun; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Jun;
SELECT DISTINCT Quantity FROM Jun;
SELECT DISTINCT Rate FROM Jun;
SELECT DISTINCT Product FROM Jun;
SELECT DISTINCT MONTH(Order_Date) FROM Jun; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Jun; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Jun; # FORMATTING NEEDED


# ORDER DATE
UPDATE Jun SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Jun SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Jun;
UPDATE Jun SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Jun;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Jun;
SELECT DISTINCT DAY(Order_Date) FROM Jun;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Jun;
ALTER TABLE Jun ADD COLUMN Sales DOUBLE;
UPDATE Jun SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Jun;
ALTER TABLE Jun ADD COLUMN Month text;
UPDATE Jun SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Jun SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Jun SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Jun SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Jun SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Jun SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Jun SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Jun SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Jun SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Jun SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Jun SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Jun SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Jun;
ALTER TABLE Jun ADD COLUMN Street VARCHAR(20);
UPDATE Jun SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Jun;
ALTER TABLE Jun ADD COLUMN City VARCHAR(20);
UPDATE Jun SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Jun;
ALTER TABLE Jun ADD COLUMN State VARCHAR(20);
UPDATE Jun SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Jun;
ALTER TABLE Jun ADD COLUMN ZipCode VARCHAR(25);
UPDATE Jun SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Jun;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Jun GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Jun;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Jun GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Jun GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Jun GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Jun GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Jun GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Jun GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Jun GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Jun GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Jun GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Jun GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;


#-----------------------------------------------------JULY SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE Jul RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Jul RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Jul RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Jul RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Jul RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Jul; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Jul;
SELECT DISTINCT Quantity FROM Jul;
SELECT DISTINCT Rate FROM Jul;
SELECT DISTINCT Product FROM Jul;
SELECT DISTINCT MONTH(Order_Date) FROM Jul; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Jul; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Jul; # FORMATTING NEEDED


# ORDER DATE
UPDATE Jul SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Jul SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Jul;
UPDATE Jul SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Jul;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Jul;
SELECT DISTINCT DAY(Order_Date) FROM Jul;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Jul;
ALTER TABLE Jul ADD COLUMN Sales DOUBLE;
UPDATE Jul SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Jul;
ALTER TABLE Jul ADD COLUMN Month text;
UPDATE Jul SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Jul SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Jul SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Jul SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Jul SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Jul SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Jul SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Jul SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Jul SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Jul SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Jul SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Jul SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Jul;
ALTER TABLE Jul ADD COLUMN Street VARCHAR(20);
UPDATE Jul SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Jul;
ALTER TABLE Jul ADD COLUMN City VARCHAR(20);
UPDATE Jul SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Jul;
ALTER TABLE Jul ADD COLUMN State VARCHAR(20);
UPDATE Jul SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Jul;
ALTER TABLE Jul ADD COLUMN ZipCode VARCHAR(25);
UPDATE Jul SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Jul;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Jul GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Jul;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Jul GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Jul GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Jul GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Jul GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Jul GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Jul GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Jul GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Jul GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Jul GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Jul GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#-----------------------------------------------------AUGUST SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE Aug RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Aug RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Aug RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Aug RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Aug RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Aug; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Aug;
SELECT DISTINCT Quantity FROM Aug;
SELECT DISTINCT Rate FROM Aug;
SELECT DISTINCT Product FROM Aug;
SELECT DISTINCT MONTH(Order_Date) FROM Aug; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Aug; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Aug; # FORMATTING NEEDED


# ORDER DATE
UPDATE Aug SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Aug SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Aug;
UPDATE Aug SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Aug;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Aug;
SELECT DISTINCT DAY(Order_Date) FROM Aug;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Aug;
ALTER TABLE Aug ADD COLUMN Sales DOUBLE;
UPDATE Aug SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Aug;
ALTER TABLE Aug ADD COLUMN Month text;
UPDATE Aug SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Aug SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Aug SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Aug SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Aug SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Aug SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Aug SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Aug SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Aug SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Aug SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Aug SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Aug SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Aug;
ALTER TABLE Aug ADD COLUMN Street VARCHAR(20);
UPDATE Aug SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Aug;
ALTER TABLE Aug ADD COLUMN City VARCHAR(20);
UPDATE Aug SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Aug;
ALTER TABLE Aug ADD COLUMN State VARCHAR(20);
UPDATE Aug SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Aug;
ALTER TABLE Aug ADD COLUMN ZipCode VARCHAR(25);
UPDATE Aug SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Aug;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Aug GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Aug;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Aug GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Aug GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Aug GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Aug GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Aug GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Aug GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Aug GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Aug GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Aug GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Aug GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#-----------------------------------------------------SEPTEMBER SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE Sep RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Sep RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Sep RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Sep RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Sep RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Sep; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Sep;
SELECT DISTINCT Quantity FROM Sep;
SELECT DISTINCT Rate FROM Sep;
SELECT DISTINCT Product FROM Sep;
SELECT DISTINCT MONTH(Order_Date) FROM Sep; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Sep; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Sep; # FORMATTING NEEDED


# ORDER DATE
UPDATE Sep SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Sep SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Sep;
UPDATE Sep SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Sep;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Sep;
SELECT DISTINCT DAY(Order_Date) FROM Sep;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Sep;
ALTER TABLE Sep ADD COLUMN Sales DOUBLE;
UPDATE Sep SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Sep;
ALTER TABLE Sep ADD COLUMN Month text;
UPDATE Sep SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Sep SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Sep SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Sep SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Sep SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Sep SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Sep SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Sep SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Sep SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Sep SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Sep SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Sep SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Sep;
ALTER TABLE Sep ADD COLUMN Street VARCHAR(20);
UPDATE Sep SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Sep;
ALTER TABLE Sep ADD COLUMN City VARCHAR(20);
UPDATE Sep SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Sep;
ALTER TABLE Sep ADD COLUMN State VARCHAR(20);
UPDATE Sep SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Sep;
ALTER TABLE Sep ADD COLUMN ZipCode VARCHAR(25);
UPDATE Sep SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Sep;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Sep GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Sep;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Sep GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Sep GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Sep GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Sep GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Sep GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Sep GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Sep GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Sep GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Sep GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Sep GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#-----------------------------------------------------OCTOBER SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE Oct RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Oct RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Oct RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Oct RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Oct RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Oct; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Oct;
SELECT DISTINCT Quantity FROM Oct;
SELECT DISTINCT Rate FROM Oct; 
SELECT DISTINCT Product FROM Oct; 
SELECT DISTINCT MONTH(Order_Date) FROM Oct; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Oct; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Oct; # FORMATTING NEEDED


# ORDER DATE
UPDATE Oct SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Oct SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Oct;
UPDATE Oct SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Oct;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Oct;
SELECT DISTINCT DAY(Order_Date) FROM Oct;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Oct;
ALTER TABLE Oct ADD COLUMN Sales DOUBLE;
UPDATE Oct SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Oct;
ALTER TABLE Oct ADD COLUMN Month text;
UPDATE Oct SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Oct SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Oct SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Oct SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Oct SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Oct SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Oct SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Oct SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Oct SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Oct SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Oct SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Oct SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Oct;
ALTER TABLE Oct ADD COLUMN Street VARCHAR(20);
UPDATE Oct SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Oct;
ALTER TABLE Oct ADD COLUMN City VARCHAR(20);
UPDATE Oct SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Oct;
ALTER TABLE Oct ADD COLUMN State VARCHAR(20);
UPDATE Oct SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Oct;
ALTER TABLE Oct ADD COLUMN ZipCode VARCHAR(25);
UPDATE Oct SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Oct;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Oct GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Oct;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Oct GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Oct GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Oct GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Oct GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Oct GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Oct GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Oct GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Oct GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Oct GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Oct GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#-----------------------------------------------------NOVEMBER SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE Nov RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE Nov RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE Nov RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE Nov RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE Nov RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC Nov; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM Nov;
SELECT DISTINCT Quantity FROM Nov; 
SELECT DISTINCT Rate FROM Nov; 
SELECT DISTINCT Product FROM Nov; 
SELECT DISTINCT MONTH(Order_Date) FROM Nov; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Nov; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM Nov; # FORMATTING NEEDED


# ORDER DATE
UPDATE Nov SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE Nov SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM Nov;
UPDATE Nov SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM Nov;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM Nov;
SELECT DISTINCT DAY(Order_Date) FROM Nov;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM Nov;
ALTER TABLE Nov ADD COLUMN Sales DOUBLE;
UPDATE Nov SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM Nov;
ALTER TABLE Nov ADD COLUMN Month text;
UPDATE Nov SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE Nov SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE Nov SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE Nov SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE Nov SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE Nov SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE Nov SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE Nov SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE Nov SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE Nov SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE Nov SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE Nov SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM Nov;
ALTER TABLE Nov ADD COLUMN Street VARCHAR(20);
UPDATE Nov SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM Nov;
ALTER TABLE Nov ADD COLUMN City VARCHAR(20);
UPDATE Nov SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM Nov;
ALTER TABLE Nov ADD COLUMN State VARCHAR(20);
UPDATE Nov SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM Nov;
ALTER TABLE Nov ADD COLUMN ZipCode VARCHAR(25);
UPDATE Nov SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM Nov;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM Nov GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM Nov;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Nov GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Nov GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM Nov GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Nov GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM Nov GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM Nov GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM Nov GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM Nov GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM Nov GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM Nov GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#-----------------------------------------------------DECEMBER SALES DATA---------------------------------------------------------------#


# FORMATTING DATA

ALTER TABLE `Dec` RENAME COLUMN `Order ID` TO Order_Id;
ALTER TABLE `Dec` RENAME COLUMN `Quantity Ordered` TO Quantity;
ALTER TABLE `Dec` RENAME COLUMN `Price Each` TO Rate;
ALTER TABLE `Dec` RENAME COLUMN `Order Date` TO Order_Date;
ALTER TABLE `Dec` RENAME COLUMN `Purchase Address` TO Purchase_Address;

# CHECKING RECORDS
DESC `Dec`; 
SELECT COUNT(Order_Id) AS 'Total Records',COUNT(DISTINCT Order_Id) AS 'Distinct Records',(COUNT(Order_Id)-COUNT(DISTINCT Order_Id)) AS Difference FROM `Dec`;
SELECT DISTINCT Quantity FROM `Dec`;
SELECT DISTINCT Rate FROM `Dec`;
SELECT DISTINCT Product FROM `Dec`;
SELECT DISTINCT MONTH(Order_Date) FROM `Dec`; # FORMATTING NEEDED
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM `Dec`; # FORMATTING NEEDED
SELECT DISTINCT DAY(Order_Date) FROM `Dec`; # FORMATTING NEEDED


# ORDER DATE
UPDATE `Dec` SET Order_Date = REPLACE(Order_Date,RIGHT(Order_Date,6),'');
UPDATE `Dec` SET Order_Date = REPLACE(Order_Date,'-','/');
SELECT CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)) AS Order_Date FROM `Dec`;
UPDATE `Dec` SET Order_Date = STR_TO_DATE(CONCAT(SUBSTR(Order_Date,4,2),'/',SUBSTR(Order_Date,1,2),'/20',SUBSTR(Order_Date,7,2)),'%d/%m/%Y');
SELECT DISTINCT MONTH(Order_Date) FROM `Dec`;
SELECT DISTINCT DISTINCT YEAR(Order_Date) FROM `Dec`;
SELECT DISTINCT DAY(Order_Date) FROM `Dec`;

					
                    # EXTRACTING DATA
# SALES
SELECT Product,Quantity,Rate,(Quantity)*(Rate) AS Sales FROM `Dec`;
ALTER TABLE `Dec` ADD COLUMN Sales DOUBLE;
UPDATE `Dec` SET Sales = (Quantity)*(Rate);

# MONTH
SELECT Order_Id,MONTH(Order_Date) FROM `Dec`;
ALTER TABLE `Dec` ADD COLUMN Month text;
UPDATE `Dec` SET Month = 'Jan' WHERE MONTH(Order_Date) = '01';
UPDATE `Dec` SET Month = 'Feb' WHERE MONTH(Order_Date) = '02';
UPDATE `Dec` SET Month = 'Mar' WHERE MONTH(Order_Date) = '03';
UPDATE `Dec` SET Month = 'Apr' WHERE MONTH(Order_Date) = '04';
UPDATE `Dec` SET Month = 'May' WHERE MONTH(Order_Date) = '05';
UPDATE `Dec` SET Month = 'Jun' WHERE MONTH(Order_Date) = '06';
UPDATE `Dec` SET Month = 'Jul' WHERE MONTH(Order_Date) = '07';
UPDATE `Dec` SET Month = 'Aug' WHERE MONTH(Order_Date) = '08';
UPDATE `Dec` SET Month = 'Sep' WHERE MONTH(Order_Date) = '09';
UPDATE `Dec` SET Month = 'Oct' WHERE MONTH(Order_Date) = '10';
UPDATE `Dec` SET Month = 'Nov' WHERE MONTH(Order_Date) = '11';
UPDATE `Dec` SET Month = 'Dec' WHERE MONTH(Order_Date) = '12';

# STREET
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2) AS Street FROM `Dec`;
ALTER TABLE `Dec` ADD COLUMN Street VARCHAR(20);
UPDATE `Dec` SET Street = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',1),' ',3),' ',-2)));

# CITY
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1) AS City FROM `Dec`;
ALTER TABLE `Dec` ADD COLUMN City VARCHAR(20);
UPDATE `Dec` SET City = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',2),',',-1)));

# STATE
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1) AS State FROM `Dec`;
ALTER TABLE `Dec` ADD COLUMN State VARCHAR(20);
UPDATE `Dec` SET State = LTRIM(RTRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Address,',',-1),' ',2),' ',-1)));

# ZIPCODE
SELECT SUBSTRING(Purchase_Address, -5) AS ZipCode FROM `Dec`;
ALTER TABLE `Dec` ADD COLUMN ZipCode VARCHAR(25);
UPDATE `Dec` SET ZipCode = LTRIM(RTRIM(SUBSTRING(Purchase_Address, -5)));

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM `Dec`;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM `Dec` GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM `Dec`;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM `Dec` GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM `Dec` GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM `Dec` GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM `Dec` GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM `Dec` GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM `Dec` GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM `Dec` GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM `Dec` GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM `Dec` GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM `Dec` GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;



#---------------------------------------------------------------PREPARING FOR VISUALIZATION----------------------------------------------------------------------------#


INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Feb;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Mar;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Apr;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM May;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Jun;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Jul;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Aug;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Sep;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Oct;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM Nov;

INSERT INTO Jan (Order_Id,Product,Quantity,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode)
SELECT  Order_Id,Product,Quantity ,Rate,Order_Date,Purchase_Address,Sales,`Month`,Street,City,State,ZipCode  FROM `Dec`;



# REMOVING UNNECESSARY DATA

ALTER TABLE Jan DROP Purchase_Address;
DELETE FROM Jan WHERE YEAR = 2020;

DROP TABLE Feb;
DROP TABLE Mar;
DROP TABLE Apr;
DROP TABLE May;
DROP TABLE Jun;
DROP TABLE Jul;
DROP TABLE Aug;
DROP TABLE Sep;
DROP TABLE Oct;
DROP TABLE Nov;
DROP TABLE `Dec`;


ALTER TABLE Jan RENAME TO SALES;

ALTER TABLE Sales ADD COLUMN Month_Id int;
UPDATE Sales SET Month_Id = MONTH(Order_Date);

# EXTRACTING YEAR
ALTER TABLE SALES ADD COLUMN Year INT;
UPDATE SALES SET Year = YEAR(Order_Date);

# TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS 'Total Quantity Sold' FROM SALES;

# QUANTITY SOLD PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity_Sold FROM SALES GROUP BY Product ORDER BY COUNT(Quantity) DESC;

# TOTAL SALES
SELECT ROUND(SUM(Sales),0) AS 'Total Sales' FROM SALES;

# TOTAL SALES PER PRODUCT
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM SALES GROUP BY Product ORDER BY Sales_Value DESC;

# 3 MOST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM SALES GROUP BY Product ORDER BY Quantity DESC LIMIT 3;

# 3 LEAST SOLD PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity FROM SALES GROUP BY Product ORDER BY Quantity ASC LIMIT 3;

# HIGHEST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM SALES GROUP BY Product ORDER BY Sales_Value DESC LIMIT 3;

# LEAST REVENUE GENERATING PRODUCTS
SELECT Product,SUM(Quantity) AS Quantity, ROUND((Rate)*(SUM(Quantity))) AS Sales_Value FROM SALES GROUP BY Product ORDER BY Sales_Value LIMIT 3;

# QUANTITY SOLD PER STREET
SELECT Product,Street,SUM(Quantity) AS Quantity_Sold FROM SALES GROUP BY Street,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER CITY
SELECT Product,City,SUM(Quantity) AS Quantity_Sold FROM SALES GROUP BY City,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD PER STATE
SELECT Product,State,SUM(Quantity) AS Quantity_Sold FROM SALES GROUP BY State,Product ORDER BY Product ASC,Quantity_Sold DESC;

# QUANTITY SOLD DEMOGRAPHICS
SELECT Product,State,City,SUM(Quantity) AS Quantity_Sold FROM SALES GROUP BY Product,City ORDER BY Product ASC,State ASC,Quantity_Sold DESC;

# USERS DEMOGRAPHICS
SELECT State,City,Street,COUNT(Purchase_Address) AS Total_User FROM SALES GROUP BY State,City,Street ORDER BY State ASC,Total_User DESC;

# AVERAGE SALES PER MONTH
SELECT ROUND((SUM(sales)/12)) AS Average_Sales FROM sales;

# AVERAGE QUANTITY SOLD PER MONTH
SELECT ROUND((SUM(Quantity)/12)) AS Average_Quantity_Sold FROM sales;

# MONTHLY SALES DATA
SELECT Month,ROUND(SUM(sales)) AS Total_Sales,SUM(Quantity) AS Total_Quantity FROM sales GROUP BY Month;


























