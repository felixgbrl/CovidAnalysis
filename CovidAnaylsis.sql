select * 
FROM CovidPortofolio..CovidDeaths$
order by 3,4


select location,date,total_cases,new_cases,total_deaths
FROM CovidPortofolio..CovidDeaths$
order by 1,2

select location,date,total_cases,total_deaths,'Death Percentage'=(total_deaths/total_cases)*100 
from CovidPortofolio..CovidDeaths$
where location like '%Indonesia%'
order by 1,2


select location,Population,Max(total_cases) as HighestInfectedCount,Max((total_cases/population))*100 as PercentPopulationInfected
from CovidPortofolio..CovidDeaths$
group by location,population  
order by PercentPopulationInfected DESC

--HIGHEST DEATH COUNT
select continent,Max(cast(total_deaths as int)) as TotalDeathCount
from CovidPortofolio..CovidDeaths$
where continent ='North America' OR continent = 'South America' OR continent = 'Asia' OR continent = 'Europe' OR continent = 'Africa' OR continent ='Oceania'
group by continent
order by TotalDeathCount DESC



--GLOBAL DEATH PERCENTAGE--
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidPortofolio..CovidDeaths$
--Where location like '%states%'
where continent ='North America' OR continent = 'South America' OR continent = 'Asia' OR continent = 'Europe' OR continent = 'Africa' OR continent ='Oceania'
--Group By date
order by 1,2

--Vaccinations Progress In Indonesia--
With PopuvsVac(Location,Population,Date,new_vaccionations,ProgressPeopleVaccinated)
as
(
select dea.location,dea.population,dea.date,vac.new_vaccinations,
SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.location ORDER by dea.location, dea.date) as ProgressPeopleVaccinated
from CovidPortofolio..CovidDeaths$ dea
join CovidPortofolio..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date	= vac.date
where dea.continent is not null and dea.location like '%Indonesia%'
-- order by date ASC
)

Select * ,( ProgressPeopleVaccinated/population)*100 as 'PopulationVaccinatedProgress'
from PopuvsVac


CREATE VIEW PercentPopulationVaccinated as
select dea.continent, dea.location,dea.population,dea.date,vac.new_vaccinations,
SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.location ORDER by dea.location, dea.date) as ProgressPeopleVaccinated
from CovidPortofolio..CovidDeaths$ dea
join CovidPortofolio..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date	= vac.date
where	dea.continent ='North America' OR 
		dea.continent = 'South America' OR 
		dea.continent = 'Asia' OR 
		dea.continent = 'Europe' OR 
		dea.continent = 'Africa' OR 
		dea.continent ='Oceania'
-- order by date ASC


