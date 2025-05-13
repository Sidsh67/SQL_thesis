use ndap;


-- ----------------------------------------------------------------------------------------------
-- SECTION 1. 
-- SELECT Queries [5 Marks]

-- 	Q1.	Retrieve the names of all states (srcStateName) from the dataset.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
-- <write your answers in the empty spaces given, the length of solution queries (and the solution writing space) can vary>
SELECT DISTINCT srcStateName 
FROM FarmersInsuranceData;

###

-- 	Q2.	Retrieve the total number of farmers covered (TotalFarmersCovered) 
-- 		and the sum insured (SumInsured) for each state (srcStateName), ordered by TotalFarmersCovered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, SUM(TotalFarmersCovered) AS TotalFarmersCovered, SUM(SumInsured) AS SumInsured
FROM FarmersInsuranceData
GROUP BY srcStateName
ORDER BY TotalFarmersCovered DESC;

-- ###

-- --------------------------------------------------------------------------------------
-- SECTION 2. 
-- Filtering Data (WHERE) [15 Marks]

-- 	Q3.	Retrieve all records where Year is '2020'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *
FROM FarmersInsuranceData
WHERE YearCode = '2020';

-- ###

-- 	Q4.	Retrieve all rows where the TotalPopulationRural is greater than 1 million and the srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *
FROM FarmersInsuranceData
WHERE TotalPopulationRural > 1000000 AND srcStateName = 'HIMACHAL PRADESH';

-- ###

-- 	Q5.	Retrieve the srcStateName, srcDistrictName, and the sum of FarmersPremiumAmount for each district in the year 2018, 
-- 		and display the results ordered by FarmersPremiumAmount in ascending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, srcDistrictName, SUM(FarmersPremiumAmount) AS FarmersPremiumAmount
FROM FarmersInsuranceData
WHERE YearCode = '2018'
GROUP BY srcStateName, srcDistrictName
ORDER BY FarmersPremiumAmount ASC;

-- ###

-- 	Q6.	Retrieve the total number of farmers covered (TotalFarmersCovered) and the sum of premiums (GrossPremiumAmountToBePaid) for each state (srcStateName) 
-- 		where the insured land area (InsuredLandArea) is greater than 5.0 and the Year is 2018.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, SUM(TotalFarmersCovered) AS TotalFarmersCovered, 
       SUM(GrossPremiumAmountToBePaid) AS GrossPremiumAmountToBePaid
FROM FarmersInsuranceData
WHERE InsuredLandArea > 5.0 AND YearCode = '2018'
GROUP BY srcStateName;

	  
-- ###
-- ------------------------------------------------------------------------------------------------

-- SECTION 3.
-- Aggregation (GROUP BY) [10 marks]

-- 	Q7. 	Calculate the average insured land area (InsuredLandArea) for each year (srcYear).
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcYear, AVG(InsuredLandArea) AS AvgInsuredLandArea
FROM FarmersInsuranceData
GROUP BY srcYear;


-- ###

-- 	Q8. 	Calculate the total number of farmers covered (TotalFarmersCovered) for each district (srcDistrictName) where Insurance units is greater than 0.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcDistrictName, SUM(TotalFarmersCovered) AS TotalFarmersCovered
FROM FarmersInsuranceData
WHERE InsuranceUnits > 0
GROUP BY srcDistrictName;


-- ###

-- 	Q9.	For each state (srcStateName), calculate the total premium amounts (FarmersPremiumAmount, StatePremiumAmount, GOVPremiumAmount) 
-- 		and the total number of farmers covered (TotalFarmersCovered). Only include records where the sum insured (SumInsured) is greater than 500,000 (remember to check for scaling).
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, 
       SUM(FarmersPremiumAmount) AS TotalFarmersPremium,
       SUM(StatePremiumAmount) AS TotalStatePremium,
       SUM(GOVPremiumAmount) AS TotalGOVPremium,
       SUM(TotalFarmersCovered) AS TotalFarmersCovered
FROM FarmersInsuranceData
WHERE SumInsured > 5
--### SumInsured is in lakhs already
GROUP BY srcStateName;



-- ###

-- -------------------------------------------------------------------------------------------------
-- SECTION 4.
-- Sorting Data (ORDER BY) [10 Marks]

-- 	Q10.	Retrieve the top 5 districts (srcDistrictName) with the highest TotalPopulation in the year 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcDistrictName, TotalPopulation
FROM FarmersInsuranceData
WHERE YearCode = '2020'
ORDER BY TotalPopulation DESC
LIMIT 5;



-- ###

-- 	Q11.	Retrieve the srcStateName, srcDistrictName, and SumInsured for the 10 districts with the lowest non-zero FarmersPremiumAmount, 
-- 		ordered by insured sum and then the FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, srcDistrictName, SumInsured
FROM FarmersInsuranceData
WHERE FarmersPremiumAmount > 0
ORDER BY SumInsured ASC, FarmersPremiumAmount ASC
LIMIT 10;


###

-- 	Q12. 	Retrieve the top 3 states (srcStateName) along with the year (srcYear) where the ratio of insured farmers (TotalFarmersCovered) to the total population (TotalPopulation) is highest. 
-- 		Sort the results by the ratio in descending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, srcYear, 
       (TotalFarmersCovered / TotalPopulation) AS InsuredFarmerRatio
FROM FarmersInsuranceData
ORDER BY InsuredFarmerRatio DESC
LIMIT 3;


-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 5.
-- String Functions [6 Marks]

-- 	Q13. 	Create StateShortName by retrieving the first 3 characters of the srcStateName for each unique state.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT LEFT(srcStateName, 3) AS StateShortName
FROM FarmersInsuranceData;


-- ###

-- 	Q14. 	Retrieve the srcDistrictName where the district name starts with 'B'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcDistrictName
FROM FarmersInsuranceData
WHERE srcDistrictName LIKE 'B%';


-- ###

-- 	Q15. 	Retrieve the srcStateName and srcDistrictName where the district name contains the word 'pur' at the end.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, srcDistrictName
FROM FarmersInsuranceData
WHERE srcDistrictName LIKE '%pur';

-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 6.
-- Joins [14 Marks]

-- 	Q16. 	Perform an INNER JOIN between the srcStateName and srcDistrictName columns to retrieve the aggregated FarmersPremiumAmount for districts where the district’s Insurance units for an individual year are greater than 10.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT a.srcStateName, a.srcDistrictName, SUM(a.FarmersPremiumAmount) AS TotalFarmersPremium
FROM FarmersInsuranceData a
INNER JOIN FarmersInsuranceData b ON a.srcStateName = b.srcStateName AND a.srcDistrictName = b.srcDistrictName
WHERE a.InsuranceUnits > 10
GROUP BY a.srcStateName, a.srcDistrictName;


-- ###

-- 	Q17.	Write a query that retrieves srcStateName, srcDistrictName, Year, TotalPopulation for each district and the the highest recorded FarmersPremiumAmount for that district over all available years
-- 		Return only those districts where the highest FarmersPremiumAmount exceeds 20 crores.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, srcDistrictName, YearCode, TotalPopulation, 
       MAX(FarmersPremiumAmount) AS MaxFarmersPremium
FROM FarmersInsuranceData
GROUP BY srcStateName, srcDistrictName, YearCode, TotalPopulation
HAVING MAX(FarmersPremiumAmount) > 2000
--###20 crores is 2000x100000
ORDER BY MaxFarmersPremium DESC;


-- ###

-- 	Q18.	Perform a LEFT JOIN to combine the total population statistics with the farmers’ data (TotalFarmersCovered, SumInsured) for each district and state. 
-- 		Return the total premium amount (FarmersPremiumAmount) and the average population count for each district aggregated over the years, where the total FarmersPremiumAmount is greater than 100 crores.
-- 		Sort the results by total farmers' premium amount, highest first.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT a.srcStateName, a.srcDistrictName, 
       SUM(a.FarmersPremiumAmount) AS TotalFarmersPremium,
       AVG(b.TotalPopulation) AS AvgPopulation
FROM FarmersInsuranceData a
LEFT JOIN FarmersInsuranceData b ON a.srcStateName = b.srcStateName AND a.srcDistrictName = b.srcDistrictName
GROUP BY a.srcStateName, a.srcDistrictName
HAVING SUM(a.FarmersPremiumAmount) > 10000
--###100 crores is 10000x100000
ORDER BY TotalFarmersPremium DESC;



-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 7.
-- Subqueries [10 Marks]

-- 	Q19.	Write a query to find the districts (srcDistrictName) where the TotalFarmersCovered is greater than the average TotalFarmersCovered across all records.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcDistrictName
FROM FarmersInsuranceData
WHERE TotalFarmersCovered > (SELECT AVG(TotalFarmersCovered) FROM FarmersInsuranceData);



-- ###

-- 	Q20.	Write a query to find the srcStateName where the SumInsured is higher than the SumInsured of the district with the highest FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName
FROM FarmersInsuranceData
WHERE SumInsured > (
    SELECT SumInsured
    FROM FarmersInsuranceData
    ORDER BY FarmersPremiumAmount DESC
    LIMIT 1
)
GROUP BY srcStateName;




-- ###

-- 	Q21.	Write a query to find the srcDistrictName where the FarmersPremiumAmount is higher than the average FarmersPremiumAmount of the state that has the highest TotalPopulation.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcDistrictName
FROM FarmersInsuranceData
WHERE FarmersPremiumAmount > (
    SELECT AVG(FarmersPremiumAmount)
    FROM FarmersInsuranceData
    WHERE srcStateName = (
        SELECT srcStateName
        FROM FarmersInsuranceData
        GROUP BY srcStateName
        ORDER BY SUM(TotalPopulation) DESC
        LIMIT 1
    )
);



-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 8.
-- Advanced SQL Functions (Window Functions) [10 Marks]

-- 	Q22.	Use the ROW_NUMBER() function to assign a row number to each record in the dataset ordered by total farmers covered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *,
       ROW_NUMBER() OVER (ORDER BY TotalFarmersCovered DESC) AS RowNum
FROM FarmersInsuranceData;



-- ###

-- 	Q23.	Use the RANK() function to rank the districts (srcDistrictName) based on the SumInsured (descending) and partition by alphabetical srcStateName.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, srcDistrictName, SumInsured,
       RANK() OVER (PARTITION BY srcStateName ORDER BY SumInsured DESC) AS DistrictRank
FROM FarmersInsuranceData;


-- ###

-- 	Q24.	Use the SUM() window function to calculate a cumulative sum of FarmersPremiumAmount for each district (srcDistrictName), ordered ascending by the srcYear, partitioned by srcStateName.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, srcDistrictName, srcYear, FarmersPremiumAmount,
       SUM(FarmersPremiumAmount) OVER (PARTITION BY srcStateName, srcDistrictName ORDER BY srcYear ASC) AS CumulativePremium
FROM FarmersInsuranceData;



-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 9.
-- Data Integrity (Constraints, Foreign Keys) [4 Marks]

-- 	Q25.	Create a table 'districts' with DistrictCode as the primary key and columns for DistrictName and StateCode. 
-- 		Create another table 'states' with StateCode as primary key and column for StateName.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
CREATE TABLE states (
    StateCode VARCHAR(10) PRIMARY KEY,
    StateName VARCHAR(100)
);

CREATE TABLE districts (
    DistrictCode VARCHAR(10) PRIMARY KEY,
    DistrictName VARCHAR(100),
    StateCode VARCHAR(10)
);



-- ###

-- 	Q26.	Add a foreign key constraint to the districts table that references the StateCode column from a states table.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
ALTER TABLE districts
ADD CONSTRAINT fk_state
FOREIGN KEY (StateCode) REFERENCES states(StateCode);



-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 10.
-- UPDATE and DELETE [6 Marks]

-- 	Q27.	Update the FarmersPremiumAmount to 500.0 for the record where rowID is 1.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
UPDATE FarmersInsuranceData
SET FarmersPremiumAmount = 500.0
WHERE rowID = 1;



-- ###

-- 	Q28.	Update the Year to '2021' for all records where srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
UPDATE FarmersInsuranceData
SET YearCode = '2021' 
WHERE srcStateName = 'HIMACHAL PRADESH';


-- ###

-- 	Q29.	Delete all records where the TotalFarmersCovered is less than 10000 and Year is 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
DELETE FROM FarmersInsuranceData
WHERE TotalFarmersCovered < 10000 AND YearCode = '2020';

-- ###
