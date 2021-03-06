-- What 3 towns have the highest population of citizens that are 65 years and older?
select town, population_greater_than_65_2005 from town_health_records where population_greater_than_65_2005 IS NOT NULL order by population_greater_than_65_2005 desc limit 3;

-- What 3 towns have the highest population of citizens that are 19 years and younger?
select town, population_0_to_19_2005 from town_health_records where population_0_to_19_2005 IS NOT NULL order by population_0_to_19_2005 desc limit 3;

-- What 5 towns have the lowest per capita income?
select town, per_capita_income_2000 from town_health_records order by per_capita_income_2000 asc limit 5;

-- Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
select town, percent_teen_births_2005_to_2008 from town_health_records WHERE percent_teen_births_2005_to_2008 IS NOT NULL AND town NOT in ('Boston', 'Becket', 'Beverly') order by percent_teen_births_2005_to_2008 desc limit 1;

-- Omitting Boston, what town has the highest number of infant mortalities?
select town, infant_mortality_rate_per_thousand_2005_to_2008 from town_health_records where infant_mortality_rate_per_thousand_2005_to_2008 IS NOT NULL AND town NOT IN ('Boston') order by infant_mortality_rate_per_thousand_2005_to_2008 desc limit 1;

-- Of the 5 towns with the highest per capita income, which one has the highest number of people below the poverty line?
select town from town_health_records where town in (select town from town_health_records where per_capita_income_2000 IS NOT NULL AND  persons_below_poverty_2000 IS NOT NULL order by per_capita_income_2000 desc limit 5) order by persons_below_poverty_2000 desc limit 1;

-- Of the towns that start with the letter b, which has the highest population?
select town, total_population_2005 from town_health_records where town ilike 'b%' order by total_population_2005 desc limit 1;

-- Of the 10 towns with the highest percent publicly financed prenatal care, are any of them also the top 10 for total infant deaths?
select town, percent_publicly_financed_prenatal_care_2005_to_2008, infant_mortality_rate_per_thousand_2005_to_2008 from town_health_records where infant_mortality_rate_per_thousand_2005_to_2008 is not null and percent_publicly_financed_prenatal_care_2005_to_2008 is not null order by infant_mortality_rate_per_thousand_2005_to_2008, percent_publicly_financed_prenatal_care_2005_to_2008 desc limit 6;

-- Which town has the highest percent multiple births?
select town, percent_multiple_births_2005_to_2008 from town_health_records where percent_multiple_births_2005_to_2008 is not null order by  percent_multiple_births_2005_to_2008 desc limit 1;

-- What is the percent adequacy of prenatal care in that town?
select town, percent_adequacy_pre_natal_care from town_health_records where percent_multiple_births_2005_to_2008 is not null order by  percent_multiple_births_2005_to_2008 desc limit 1;

-- Excluding towns that start with W, how many towns are part of this data?
SELECT COUNT(DISTINCT town) FROM town_health_records where town not ilike 'w%';

-- How many towns have a lower per capita income that of Boston?
SELECT COUNT(DISTINCT town) FROM town_health_records where per_capita_income_2000 < (select per_capita_income_2000 from town_health_records where town = 'Boston');
