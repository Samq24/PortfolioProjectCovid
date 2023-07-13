--Create a derived table for the excluded locations
SELECT *
INTO #excluded_locations
FROM (
  SELECT 'World' AS location UNION ALL
  SELECT 'International' UNION ALL
  SELECT 'Europe' UNION ALL
  SELECT 'Asia' UNION ALL
  SELECT 'North America' UNION ALL
  SELECT 'South America' UNION ALL
  SELECT 'Africa' UNION ALL
  SELECT 'Oceania' UNION ALL
  SELECT 'International conveyance' UNION ALL
  SELECT 'MS Zaandam' UNION ALL
  SELECT 'European Union' UNION ALL
  SELECT 'High income' UNION ALL
  SELECT 'Low income' UNION ALL
  SELECT 'Lower middle income' UNION ALL
  SELECT 'Upper middle income'
) AS excluded_locations

-- Final dashboard
SELECT
  location,
  FORMAT(date, 'yyyy-MM-dd') AS date,
  new_cases,
  new_deaths,
  total_deaths,
  population
FROM [Project2 Covid]..['owid-covid-data$']
WHERE location NOT IN (SELECT location FROM #excluded_locations)
ORDER BY 1, 2;


-- Total cases vs total deaths
SELECT
  location,
  SUM(new_cases) AS Total_cases,
  SUM(new_deaths) AS Total_deaths,
  Max(population) AS population,
  CASE
    WHEN SUM(new_cases) = 0 THEN NULL
    ELSE (SUM(new_deaths) * 100.0 / NULLIF(SUM(new_cases), 0))
  END AS DeathPercentage
FROM [Project2 Covid]..['owid-covid-data$']
WHERE location NOT IN (SELECT location FROM #excluded_locations)
GROUP BY location
ORDER BY location;

-- Percentage of total deaths vs population
SELECT
  location,
  MAX(population) AS population,
  SUM(CAST(new_cases AS NUMERIC)) AS total_cases,
  (SUM(CAST(new_cases AS NUMERIC)) * 100.0 / MAX(population)) AS PercentPopulationInfected
FROM [Project2 Covid]..['owid-covid-data$']
WHERE location NOT IN (SELECT location FROM #excluded_locations)
GROUP BY location
ORDER BY location;

-- Countries with the highest infection rate compared to population
SELECT
  location,
  population,
  SUM(new_cases) AS HighestInfectionCount,
  SUM((new_cases / population)) * 100 AS PercentPopulationInfected
FROM [Project2 Covid]..['owid-covid-data$']
WHERE location NOT IN (SELECT location FROM #excluded_locations)
GROUP BY location, population
ORDER BY 1, 2;

-- Continents with the highest death count
SELECT
  continent,
  SUM(CAST(new_cases AS BIGINT)) AS TotalCasesCount,
  SUM(new_deaths) AS TotalDeathsCount
FROM [Project2 Covid]..['owid-covid-data$']
WHERE continent IS NOT NULL AND continent != ' ' AND location NOT IN (SELECT location FROM #excluded_locations)
GROUP BY continent
ORDER BY TotalCasesCount DESC;


-- Global Numbers
SELECT
  FORMAT(date, 'yyyy-MM-dd') AS date,
  SUM(new_cases) AS TotalCases,
  SUM(CAST(new_deaths AS INT)) AS TotalDeaths,
  ISNULL(SUM(CAST(new_deaths AS INT)) / NULLIF(SUM(new_cases), 0) * 100, 0) AS DeathPercentage
FROM [Project2 Covid]..['owid-covid-data$']
WHERE continent IS NOT NULL AND location NOT IN (SELECT location FROM #excluded_locations)
GROUP BY date
ORDER BY 1, 2;

-- How has workplace mobility evolved in relation to the total number of cases?
SELECT
  FORMAT(c.date, 'yyyy,MM,dd') AS Date,
  AVG(m.workplaces) AS TotalWorkplaces,
  SUM(c.new_cases) AS TotalCases
FROM ['changes-visitors-covid$'] m
JOIN [dbo].['owid-covid-data$'] c ON m.Entity = c.location AND m.Day = c.date
WHERE location NOT IN (SELECT location FROM #excluded_locations)
GROUP BY FORMAT(c.date, 'yyyy,MM,dd')
ORDER BY 1;

-- Is there any correlation between changes in mobility in parks and the number of new COVID-19 deaths?
SELECT
  FORMAT(c.date, 'yyyy,MM,dd') AS Date,
  AVG(m.parks) AS Mobility_Parks,
  SUM(c.new_deaths) new_deaths
FROM ['changes-visitors-covid$'] m
JOIN [dbo].['owid-covid-data$'] c ON m.Entity = c.location AND m.Day = c.date
WHERE location NOT IN (SELECT location FROM #excluded_locations)
GROUP BY FORMAT(c.date, 'yyyy,MM,dd')
ORDER BY 1;

-- How has mobility in transit stations changed compared to the implemented stringency index?
SELECT
  FORMAT(c.date, 'yyyy,MM,dd') AS date,
  AVG(m.transit_stations) AS transit_stations,
  AVG(c.stringency_index) AS stringency_index
FROM ['changes-visitors-covid$'] m
JOIN [dbo].['owid-covid-data$'] c ON m.Entity = c.location AND m.Day = c.date
WHERE location NOT IN (SELECT location FROM #excluded_locations)
GROUP BY FORMAT(c.date, 'yyyy,MM,dd')
ORDER BY 1;

-- delete temporary table
DROP TABLE #excluded_locations;