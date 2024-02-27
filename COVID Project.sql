SELECT *
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent IS NOT NULL
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject.dbo.CovidVaccination$
--ORDER BY 3,4


--*The data I will use*

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent IS NOT NULL --and location = 'Montenegro'
ORDER BY 1,2


-- *Looking at Total Cases vs Total Deaths*

SELECT location, date, total_cases , total_deaths, ((cast(total_deaths as int)*1.0)/total_cases)*100 as PercOfDeaths
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent IS NOT NULL --and location = 'montenegro'
ORDER BY 1,2 desc





--*Looking at total death vs population*

SELECT location, date, total_cases,population, (total_cases/population)*100 as PercOfPopInfected
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent IS NOT NULL --and location = 'montenegro'
ORDER BY 1,2




--Looking at Countries with highest infection rate

SELECT location, population, max(total_cases) as MaxCaseNumber, (max(total_cases)/population)*100 as PercOfPopInfected
FROM PortfolioProject.dbo.CovidDeaths$
--Where location = 'Montenegro'
WHERE continent IS NOT NULL
GROUP BY location, Population
ORDER BY PercOfPopInfected DESC




--*Countries with the hieghts deaths*

SELECT location, population, max(cast(total_deaths as int)) as MaxDeathsNumber
FROM PortfolioProject.dbo.CovidDeaths$
--WHERE location = 'Montenegro'
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY MaxDeathsNumber DESC

--LETS BREAK THINGS BY CONTINENT
--*Showing continents with the highest death count per population*

SELECT continent, max(cast(total_deaths as int)) as MaxDeathsNumber
FROM PortfolioProject.dbo.CovidDeaths$
--WHERE location = 'Montenegro'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY MaxDeathsNumber DESC

--Alternative
--SELECT location, max(cast(total_deaths as int)) as MaxDeathsNumber
--FROM PortfolioProject.dbo.CovidDeaths$
----WHERE location = 'Montenegro'
--WHERE continent IS NULL
--GROUP BY location
--ORDER BY MaxDeathsNumber DESC



--*GLOBAL NUMBERS*

SELECT SUM(new_cases) AS Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, (((SUM((cast(new_deaths as int)))) *1.0)/((SUM(new_cases)) * 1.0)) * 100  AS PercOfDeaths
FROM PortfolioProject.dbo.CovidDeaths$
--WHERE location = 'Montenegro'
WHERE continent IS NOT NULL --and location = 'Montenegro' and new_cases != 0
--GROUP BY date
ORDER BY 1,2 desc


--*Loking at Total Population vs Vaccination (CTE)*

with popvsvac (Continent, Location, Date, Population, NewVaccination, RoallingPopleVaccinated)
as
(
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, 
SUM(cast(cv.new_vaccinations as float)) OVER (partition by cd.location order by cd.location,cd.date) as RoallingPopleVaccinated
--(RoallingPopleVaccinated / cd.population)*100
FROM PortfolioProject.dbo.CovidDeaths$ cd
JOIN PortfolioProject.dbo.CovidVaccination$ cv
	ON cd.location = cv.location
	and cd.date = cv.date
WHERE cd.continent IS NOT NULL --and cd.location = 'Montenegro'
--ORDER BY 2,3
)
SELECT *,(RoallingPopleVaccinated/Population)*100 as PercentVaccinatedPeople
FROM popvsvac



--TEMP TABLE
DROP table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated

(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated

SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, 
SUM(cast(cv.new_vaccinations as float)) OVER (partition by cd.location order by cd.location,cd.date) as RollingPeopleVaccinated
--(RoallingPopleVaccinated / cd.population)*100
FROM PortfolioProject.dbo.CovidDeaths$ cd
JOIN PortfolioProject.dbo.CovidVaccination$ cv
	ON cd.location = cv.location
	and cd.date = cv.date
WHERE cd.continent IS NOT NULL --and cd.location = 'Montenegro'
--ORDER BY 2,3

SELECT *,(RollingPeopleVaccinated/Population)*100 as PercentVaccinatedPeople
FROM #PercentPopulationVaccinated



-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, 
SUM(cast(cv.new_vaccinations as float)) OVER (partition by cd.location order by cd.location,cd.date) as RollingPeopleVaccinated
--(RoallingPopleVaccinated / cd.population)*100
FROM PortfolioProject.dbo.CovidDeaths$ cd
JOIN PortfolioProject.dbo.CovidVaccination$ cv
	ON cd.location = cv.location
	and cd.date = cv.date
WHERE cd.continent IS NOT NULL --and cd.location = 'Montenegro'
--ORDER BY 2,3

SELECT *
FROM PortfolioProject.dbo.PercentPopulationVaccinated

