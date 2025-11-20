Here are the answers to all questions from the attached exam paper based on its sections:

SECTION A - Theory Questions
1a. Differences between UNION and UNION ALL:

UNION removes duplicate rows from the result set.

UNION ALL includes all rows, duplicates allowed.

1b. Can aggregate functions be used in WHERE clause? Justify:

No, aggregate functions cannot be used in WHERE because WHERE filters rows before aggregation.

Use HAVING clause for filtering aggregated results.

1c. Difference between TRUNCATE and ROUND functions:

TRUNCATE cuts off decimal digits without rounding.

ROUND rounds the number to the nearest digit based on the next digit.

1d. Difference between ISNULL() and IFNULL():

ISNULL() is typically used in SQL Server, returns true if expression is NULL.

IFNULL() is used in MySQL, returns replacement if expression is NULL.

1e. What is referential integrity?

Referential integrity ensures that relationships between tables remain consistent.

Foreign key values must match primary key values in the referenced table or be NULL.

2a. Explain EXISTS operator:

EXISTS tests for presence of rows in a subquery.

Returns TRUE if subquery returns any rows, otherwise FALSE.

2b. Difference between WHERE and HAVING:

WHERE filters rows before grouping.

HAVING filters groups after aggregation.

2c. Count total number of 'a' in phrase "Great Learning":

The phrase "Great Learning" contains 3 'a' characters.

2d. How to add and delete a unique constraint after creating a table:

Add Unique Constraint:
ALTER TABLE tableName ADD CONSTRAINT constraintName UNIQUE (columnName);

Delete Unique Constraint:
ALTER TABLE tableName DROP CONSTRAINT constraintName;

2e. Correlated sub-query in HAVING clause example:

A correlated subquery refers to the outer querys columns.
Example:

sql
SELECT department, AVG(salary)
FROM employees e1
GROUP BY department
HAVING AVG(salary) > (
  SELECT AVG(salary)
  FROM employees e2
  WHERE e1.department = e2.department
);
SECTION B - SQL Queries (AustraliaWeather Table)
3a. Query for average rainfall and evaporation for each location excluding NULL evaporation:


SELECT Location, AVG(Rainfall) AS AvgRainfall, AVG(Evaporation) AS AvgEvaporation
FROM AustraliaWeather
WHERE Evaporation IS NOT NULL
GROUP BY Location;


3b. Query to show max temperature (morning and afternoon) for each location in each month:


SELECT Location, MONTH(Date) AS Month,
       MAX(TempMorning) AS MaxTempMorning,
       MAX(TempAfternoon) AS MaxTempAfternoon
FROM AustraliaWeather
GROUP BY Location, MONTH(Date);


3c. Add column Pressure9pm to australiaweather table:


ALTER TABLE australiaweather
ADD Pressure9pm INT NOT NULL DEFAULT 1001;


3d. Query to compare average rainfall for January 2008 and July 2008:

SELECT
  AVG(CASE WHEN MONTH(Date) = 1 AND YEAR(Date) = 2008 THEN Rainfall END) AS AvgRainfallJan2008,
  AVG(CASE WHEN MONTH(Date) = 7 AND YEAR(Date) = 2008 THEN Rainfall END) AS AvgRainfallJuly2008
FROM AustraliaWeather;


3e. Query to add morning and noon humidity into one column and compare averages Jan and Feb 2009:

SELECT
  AVG(CASE WHEN MONTH(Date) = 1 AND YEAR(Date) = 2009 THEN (HumidityMorning + HumidityNoon) END) AS AvgHumidityJan2009,
  AVG(CASE WHEN MONTH(Date) = 2 AND YEAR(Date) = 2009 THEN (HumidityMorning + HumidityNoon) END) AS AvgHumidityFeb2009
FROM AustraliaWeather;


3f. Query for highest pressure in each location per month when evaporation record exists, temperature morning between 14 and 30, and max humidity <= 70:


SELECT Location, MONTH(Date) AS Month, MAX(PressureMorning) AS MaxPressure
FROM AustraliaWeather
WHERE Evaporation IS NOT NULL
  AND TempMorning BETWEEN 14 AND 30
  AND MaxHumidityMorning <= 70
GROUP BY Location, MONTH(Date);


SECTION C - Formula 1 Racing Queries
4a. Query to list circuits where no races have been held:

SELECT CircuitName
FROM Circuits
WHERE CircuitID NOT IN (SELECT DISTINCT CircuitID FROM Races);


4b. Query to get driver details with shortest lap time:


SELECT d.*
FROM Drivers d
JOIN LapTimes lt ON d.DriverID = lt.DriverID
ORDER BY lt.LapTime ASC
LIMIT 1;


4c. Query to rank drivers by points:


SELECT d.DriverID, d.DriverName, SUM(r.Points) AS TotalPoints
FROM Drivers d
JOIN Results r ON d.DriverID = r.DriverID
GROUP BY d.DriverID, d.DriverName
ORDER BY TotalPoints DESC;

/*

select 
d.driver_id,
SUM(points) AS total_points,    
DENSE_RANK() OVER (ORDER BY SUM(points) DESC) AS driver_rank
FROM Results r
JOIN Drivers d ON r.driver_id = d.driver_id
GROUP BY d.driver_id
ORDER BY driver_rank;
*/


4d. Virtual table with driver details and count of races played, sorted by highest to lowest:

CREATE VIEW DriverRaceCount AS

SELECT d.DriverID, d.DriverName, COUNT(r.RaceID) AS TotalRaces
FROM Drivers d
LEFT JOIN Results r ON d.DriverID = r.DriverID
GROUP BY d.DriverID, d.DriverName
ORDER BY TotalRaces DESC;

4e. Report of races with driver, points, laps, duration (milliseconds), sorted:

SELECT r.RaceID, r.RaceName, d.DriverName, res.Points, res.Laps, res.DurationMillis
FROM Races r
JOIN Results res ON r.RaceID = res.RaceID
JOIN Drivers d ON res.DriverID = d.DriverID
ORDER BY r.RaceID, d.DriverName;