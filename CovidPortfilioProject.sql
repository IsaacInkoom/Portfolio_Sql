-- Data Information we will be using location / Continent, Date, Total_cases, new_cases , population, Total_Deaths

Select location, date, population, total_cases,new_cases, total_deaths
from CovidDeaths
order by 1,2;

-- Total_Cases vrs Total_Deaths(Percentage of population who died from Covid in Country)
Select Location,date, population, total_cases, total_deaths, 
(cast(total_deaths as float) /total_cases)*100 as Death_Percentage  from CovidDeaths
where continent is not null
order by 1,2;

-- Total_cases vrs Population(Percentage of Population who have gotten Covid)
Select Location,date, population, total_cases, (total_cases / population )*100 as Percentage_of_Infected from CovidDeaths
where continent is not null
order by 1,2;

Select location, population, max(cast(total_cases as int)) as   Highest_cases, max((total_cases / population))*100 as Percentage_of_highestinfection from CovidDeaths
where continent is not null
group by location, population
order by Percentage_of_highestinfection desc;

--Total_deaths vrs Population (Highest Population deaths)
Select location, max(cast(total_deaths as float)) as Highest_Deaths from CovidDeaths 
where continent is not null
group by location
order by Highest_Deaths desc;

--Continent with Highest cases 

Select continent, max(cast(total_deaths as int)) as Highest_death from CovidDeaths
where continent is not null
group by continent
order by Highest_death desc;

--Global Numbers (Total death Percentage Globally)
Select sum(new_cases) as Total_newcases, sum(cast(new_deaths as int)) as Total_newdeath,
sum(cast(new_deaths as int))/(sum(new_cases))*100 as DeathPercentage
from CovidDeaths
where continent is not null
order by 1,2;

--Total Population vrs vaccinations

Select dea.location,dea.continent,dea.date, dea.population, vac.new_vaccinations
from CovidDeaths as dea
inner join CovidVaccinations as vac
on dea.date = vac.date 
and dea.location = vac.location
where dea.continent is not null
group by dea.location,dea.continent,dea.date,dea.population,vac.new_vaccinations
order by 1,2,3;

--Rolling Count  of total Vaccines 

Select dea.location,dea.continent,dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as float)) over (partition by dea.location Order by dea.location, dea.date) as Rolling_PeopleVaccinated
from CovidDeaths as dea
inner join CovidVaccinations as vac
on dea.date = vac.date 
and dea.location = vac.location
where dea.continent is not null
group by dea.location,dea.continent,dea.date,dea.population,vac.new_vaccinations
order by 1,2,3;


With PopvsVac (location,continent,date,population, new_vaccinations, Rolling_PeopleVaccinated)
as 
(
Select dea.location,dea.continent,dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as float)) over (partition by dea.location Order by dea.location, dea.date) as Rolling_PeopleVaccinated
from CovidDeaths as dea
inner join CovidVaccinations as vac
on dea.date = vac.date 
and dea.location = vac.location
where dea.continent is not null
group by dea.location,dea.continent,dea.date,dea.population,vac.new_vaccinations

)
select *,(Rolling_PeopleVaccinated/population)*100
from PopvsVac


