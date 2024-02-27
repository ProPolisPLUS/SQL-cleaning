--Overview
SELECT *
FROM Vjezba.dbo.cities$

SELECT *
FROM Vjezba.dbo.countries$

SELECT *
FROM Vjezba.dbo.currencies$

SELECT *
FROM Vjezba.dbo.languages$

SELECT *
FROM Vjezba.dbo.output$

--Add a numeric, auto-incrementing Primary Key to every table

ALTER TABLE Vjezba.dbo.cities$
ADD row_id INT IDENTITY(1,1) PRIMARY KEY;

ALTER TABLE Vjezba.dbo.countries$
ADD row_id INT IDENTITY(1,1) PRIMARY KEY;

ALTER TABLE Vjezba.dbo.currencies$
ADD row_id INT IDENTITY(1,1) PRIMARY KEY;

ALTER TABLE Vjezba.dbo.languages$
ADD row_id INT IDENTITY(1,1) PRIMARY KEY;

--In the countries table, add the column created_on with the current date

SELECT *
FROM Vjezba.dbo.countries$

ALTER TABLE Vjezba.dbo.countries$
ADD created_on date 

UPDATE Vjezba.dbo.countries$
SET created_on = GETDATE();

-- Cleaning column country_name, country_code_2, region and subregion from countries$

SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(country_name, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.countries$

UPDATE Vjezba.dbo.countries$
SET country_name = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(country_name, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))



SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(country_code_2, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.countries$

UPDATE Vjezba.dbo.countries$
SET country_code_2 = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(country_code_2, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))



SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(region, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.countries$

UPDATE Vjezba.dbo.countries$
SET region = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(region, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))



SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(sub_region, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.countries$

UPDATE Vjezba.dbo.countries$
SET sub_region = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(sub_region, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))



-- Cleaning column city_name  from cities

SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(city_name, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.cities$

UPDATE Vjezba.dbo.cities$
SET city_name = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(city_name, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))



--Cleaning columns in currencies

SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(country_code_2, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.currencies$

UPDATE Vjezba.dbo.currencies$
SET country_code_2 = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(country_code_2, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))



SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(currency_name, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.currencies$

UPDATE Vjezba.dbo.currencies$
SET currency_name = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(currency_name, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))



SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(currency_code, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.currencies$

UPDATE Vjezba.dbo.currencies$
SET currency_code = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(currency_code, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))

--Cleaning columns in languages

SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(language, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.languages$

UPDATE Vjezba.dbo.languages$
SET language = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(language, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))



SELECT LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(country_code_2, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))
FROM Vjezba.dbo.languages$

UPDATE Vjezba.dbo.languages$
SET country_code_2 = LOWER(TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(country_code_2, '!', ''), '?', ''), '#', ''), '$', ''), '*', '')))

--Delete duplicates

DELETE FROM Vjezba.dbo.cities$
WHERE row_id NOT IN (
    SELECT MIN(row_id)
    FROM Vjezba.dbo.cities$
    GROUP BY city_name,latitude,longitude,country_code_2
);



DELETE FROM Vjezba.dbo.countries$
WHERE row_id NOT IN (
    SELECT MIN(row_id)
    FROM Vjezba.dbo.countries$
    GROUP BY country_name, country_code_2, country_code_3, region, sub_region
);



DELETE FROM Vjezba.dbo.currencies$
WHERE row_id NOT IN (
    SELECT MIN(row_id)
    FROM Vjezba.dbo.currencies$
    GROUP BY country_code_2, currency_name, currency_code
);



DELETE FROM Vjezba.dbo.languages$
WHERE row_id NOT IN (
    SELECT MIN(row_id)
    FROM Vjezba.dbo.languages$
    GROUP BY language,country_code_2
);

--1. List Regions and Country Count-----------------------------------------------------------------------------------------------------

SELECT UPPER(region) as Region, COUNT(region) as country_count
FROM Vjezba.dbo.countries$
GROUP BY region
ORDER BY country_count desc

--2. List Sub-Regions and City Count

SELECT UPPER(sub_region) as Sub_Region, COUNT(city_name) as City_Count
FROM Vjezba.dbo.cities$ a
RIGHT JOIN Vjezba.dbo.countries$ b
	ON a.country_code_2 = b.country_code_2
WHERE sub_region IS NOT NULL
GROUP BY sub_region
ORDER BY City_Count DESC

--3. Specific Sub-Region(Northern Europe)-->Country_Name depending on the COUNT(City_Name)

SELECT UPPER(b.country_name) as Country_Name, COUNT(city_name) as City_Count
FROM Vjezba.dbo.cities$ a
RIGHT JOIN Vjezba.dbo.countries$ b
	ON a.country_code_2 = b.country_code_2
WHERE sub_region = 'northern europe'
GROUP BY  b.country_name
ORDER BY City_Count

--4. Specific Sub-Region(Southern Europe)-->Country_Name depending on the COUNT(City_Name)

SELECT UPPER(b.country_name) as Country_Name, COUNT(city_name) as City_Count
FROM Vjezba.dbo.cities$ a
RIGHT JOIN Vjezba.dbo.countries$ b
	ON a.country_code_2 = b.country_code_2
WHERE sub_region = 'Southern europe'
GROUP BY  b.country_name
ORDER BY City_Count

--5. List all of the countries in the region of Asia that did NOT have a city with an inserted date from June 2021 through Sept 2021

SELECT a.country_name
FROM Vjezba.dbo.countries$ a
LEFT JOIN  Vjezba.dbo.cities$ b
	ON a.country_code_2 = b.country_code_2
	AND b.insert_date BETWEEN '2021-06-01' AND '2021-10-01'
WHERE region = 'ASIA' and city_name IS NULL 


--6. MultipleJOIN 

SELECT city_name,latitude,longitude, d.language, country_name,a.population, region, sub_region, currency_name,insert_date
FROM Vjezba.dbo.cities$ a
JOIN  Vjezba.dbo.countries$ b
	ON a.country_code_2 = b.country_code_2
JOIN Vjezba.dbo.currencies$ c
	ON a.country_code_2 = c.country_code_2
JOIN Vjezba.dbo.languages$ d
	ON a.country_code_2 = d.country_code_2

--7. Number of languages per countrys

SELECT country_name, COUNT(b.language) as Number_Of_Languages
FROM Vjezba.dbo.countries$ a
JOIN Vjezba.dbo.languages$ b
	ON a.country_code_2 = b.country_code_2
GROUP BY country_name
ORDER BY Number_Of_Languages DESC

--7. Reversable Names

SELECT country_name, city_name,population, LEN(city_name) as CityNameLEN
FROM Vjezba.dbo.cities$ a
JOIN Vjezba.dbo.countries$ b
	ON a.country_code_2 = b.country_code_2
WHERE city_name = REVERSE(city_name) and region = 'asia'
ORDER BY CityNameLEN DESC, city_name ASC

--7. Search with Wildcard and Case
SELECT country_name, SUM(population) as population,
CASE 
	WHEN (CAST(population as int) % 2) = 0
		THEN 'Even'
	ELSE 'Odd'
END AS Odd_or_Evan
FROM Vjezba.dbo.countries$ a
JOIN Vjezba.dbo.cities$ b
	ON a.country_code_2 = b.country_code_2
WHERE country_name LIKE '%stan' and YEAR(insert_date) = 2022
GROUP BY country_name, population
ORDER BY country_name, Odd_or_Evan

--8. List the third most populated city ranked by region

WITH get_city_rank AS (
SELECT region, city_name, population,
DENSE_RANK() OVER (PARTITION BY region	ORDER BY population DESC) as RNK
FROM Vjezba.dbo.cities$ a
JOIN Vjezba.dbo.countries$ b
	ON a.country_code_2 = b.country_code_2
WHERE population IS NOT NULL 
GROUP BY region, city_name, population
)

SELECT *
FROM get_city_rank
WHERE RNK = 3
ORDER BY region, population desc

--9. List the bottom third of all countries in the Western Asia sub-region that speak Arabic

WITH get_ntile_cte as (
SELECT sub_region, language, country_name,
NTILE(3) OVER (ORDER BY country_name) as NT
FROM Vjezba.dbo.cities$ a
JOIN Vjezba.dbo.countries$ b
	ON a.country_code_2 = b.country_code_2
JOIN Vjezba.dbo.languages$ c
	ON a.country_code_2 = c.country_code_2
WHERE sub_region = 'western asia' and language = 'arabic' 
)

SELECT country_name, sub_region, language
FROM get_ntile_cte
WHERE NT = 3
GROUP BY country_name, sub_region, language

--10. Using Arrays

SELECT country_name, city_name, population,
STRING_AGG(language,',') as language, currency_name, region, sub_region
FROM Vjezba.dbo.cities$ a
JOIN Vjezba.dbo.countries$ b
	ON a.country_code_2 = b.country_code_2
JOIN Vjezba.dbo.languages$ c
	ON a.country_code_2 = c.country_code_2
JOIN vjezba.dbo.currencies$ d
	ON a.country_code_2 = d.country_code_2
GROUP BY country_name,city_name,population, currency_name, region, sub_region
