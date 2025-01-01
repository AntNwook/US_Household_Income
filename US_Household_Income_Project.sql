# US Household Income Data Cleaning

SELECT *
FROM US_Household_Income;

SELECT *
FROM us_household_income_statistics;



SELECT COUNT(id)
FROM US_Household_Income;

SELECT COUNT(id)
FROM us_household_income_statistics; 


# Identify and Remove Duplicates

SELECT ID,
COUNT(id)
FROM US_Household_Income
GROUP BY Id
HAVING COUNT(id) > 1;


SELECT *
FROM(
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM US_Household_Income
 ) duplicates 
WHERE row_num > 1;

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM(
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM US_Household_Income
		) duplicates 
	WHERE row_num > 1);
    
    
SELECT DISTINCT State_name
FROM us_household_income_statistics
;

#Correcting Spelling Errors and filling Blanks 


UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autaga County'
AND City = 'Vinemont';


SELECT Type, COUNT(type)
FROM US_Household_Income
GROUP BY Type;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

SELECT ALand,
AWater
FROM US_Household_Income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL;
    
SELECT DISTINCT AWater
FROM US_Household_Income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL;

SELECT ALand,
AWATER
FROM US_Household_Income
WHERE ALand = 0 OR ALAnd = '' OR ALand IS NULL;

SELECT DISTINCT ALand
FROM US_Household_Income
WHERE ALand = 0 OR ALAnd = '' OR ALand IS NULL;

# US Household Income Exploratory Data Analysis 

SELECT *
FROM US_Household_Income;

SELECT * 
FROM us_household_income_statistics;


SELECT State_name,
SUM(ALand),
SUM(AWater)
FROM US_Household_Income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;

SELECT State_name,
SUM(ALand),
SUM(AWater)
FROM US_Household_Income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10;


Select * 
FROM US_Household_Income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0;


Select u.State_Name,
County,
Type,
`Primary`,
Mean,
Median
FROM US_Household_Income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0;


Select Type,
ROUND(AVG(Mean),1),
ROUND(AVG(Median),1)
FROM US_Household_Income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 2;


Select u.State_Name,
ROUND(AVG(Mean),1),
ROUND(AVG(Median),1)
FROM US_Household_Income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.state_Name
ORDER BY 2 DESC
LIMIT 5;

Select u.State_Name,
ROUND(AVG(Mean),1),
ROUND(AVG(Median),1)
FROM US_Household_Income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.state_Name
ORDER BY 2 DESC;


SELECT *
FROM US_Household_Income
WHERE Type = 'Community';


Select u.State_Name, 
City, 
ROUND(AVG(Mean),1)
FROM US_Household_Income u
JOIN us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, 
City
ORDER BY ROUND(AVG(Mean),1) DESC;