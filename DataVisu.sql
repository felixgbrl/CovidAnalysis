/*
QUERIES FOR DATA VISUALIZATION
*/
--1
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidPortofolio..CovidDeaths$
--Where location like '%states%'
where continent ='North America' OR continent = 'South America' OR continent = 'Asia' OR continent = 'Europe' OR continent = 'Africa' OR continent ='Oceania'
--Group By date
order by 1,2



--2
select continent,Max(cast(total_deaths as int)) as TotalDeathCount
from CovidPortofolio..CovidDeaths$
where continent ='North America' OR continent = 'South America' OR continent = 'Asia' OR continent = 'Europe' OR continent = 'Africa' OR continent ='Oceania'
group by continent
order by TotalDeathCount DESC

--3
select location,Population,Max(total_cases) as HighestInfectedCount,Max((total_cases/population))*100 as PercentPopulationInfected
from CovidPortofolio..CovidDeaths$
group by location,population  
order by PercentPopulationInfected DESC


select location,Population,date,Max(total_cases) as HighestInfectedCount,Max((total_cases/population))*100 as PercentPopulationInfected
from CovidPortofolio..CovidDeaths$
group by location,population,date  
order by PercentPopulationInfected DESC
