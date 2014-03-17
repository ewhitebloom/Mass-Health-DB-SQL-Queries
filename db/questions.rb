# What 3 towns have the highest population of citizens that are 65 years and older?
TownHealthRecord.where('population_greater_than_65_2005 IS NOT Null').order('population_greater_than_65_2005 desc').limit(5).pluck(:town)

# What 3 towns have the highest population of citizens that are 19 years and younger?
TownHealthRecord.where('population_0_to_19_2005 is not null').order('population_0_to_19_2005 desc').limit(3).pluck(:town)

# -- What 5 towns have the lowest per capita income?
TownHealthRecord.where('per_capita_income_2000 is not null').order('per_capita_income_2000 asc').limit(5).pluck(:town)

# -- Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
TownHealthRecord.where('percent_teen_births_2005_to_2008 is not null').where.not(:town => ['Boston', 'Becket', 'Beverly']).order('percent_teen_births_2005_to_2008 desc').limit(1).pluck(:town)

# -- Omitting Boston, what town has the highest number of infant mortalities?
TownHealthRecord.where('infant_mortality_rate_per_thousand_2005_to_2008 IS NOT NULL').where.not(:town => 'Boston').order('infant_mortality_rate_per_thousand_2005_to_2008 desc').limit(1).pluck(:town)

# -- Of the 5 towns with the highest per capita income, which one has the highest number of people below the poverty line?
select town from town_health_records where town in (select town from town_health_records where per_capita_income_2000 IS NOT NULL AND  percent_persons_below_poverty_2000 IS NOT NULL order by per_capita_income_2000 desc, percent_persons_below_poverty_2000 desc limit 5) order by percent_persons_below_poverty_2000 desc limit 1;
TownHealthRecord.where(:town => (TownHealthRecord.where('per_capita_income_2000 IS NOT NULL').where('percent_persons_below_poverty_2000 IS NOT NULL').order('per_capita_income_2000 desc').limit(5))).order('percent_persons_below_poverty_2000 desc').limit(1).pluck(:town)

# -- Of the towns that start with the letter b, which has the highest population?
TownHealthRecord.where("town ilike 'b%'").order('total_population_2005 desc').limit(1).pluck(:town)

# -- Of the 10 towns with the highest percent publicly financed prenatal care, are any of them also the top 10 for total infant deaths?
TownHealthRecord.where('infant_mortality_rate_per_thousand_2005_to_2008 is not null').where('percent_publicly_financed_prenatal_care_2005_to_2008 is not null').order('infant_mortality_rate_per_thousand_2005_to_2008').order('percent_publicly_financed_prenatal_care_2005_to_2008 desc ').limit(6)

# -- Which town has the highest percent multiple births?
TownHealthRecord.where('percent_multiple_births_2005_to_2008 is not null').order('percent_multiple_births_2005_to_2008 desc').limit(1)

# -- What is the percent adequacy of prenatal care in that town?
TownHealthRecord.where('percent_multiple_births_2005_to_2008 is not null').order('percent_multiple_births_2005_to_2008 desc').limit(1).pluck(:percent_adequacy_pre_natal_care)

# -- Excluding towns that start with W, how many towns are part of this data?
TownHealthRecord.where.not("town ilike 'w%'").count

# -- How many towns have a lower per capita income that of Boston?
SELECT COUNT(DISTINCT town) FROM town_health_records where per_capita_income_2000 < (select per_capita_income_2000 from town_health_records where town = 'Boston');
TownHealthRecord.where("per_capita_income_2000 < TownHealthRecord.where('town = Boston').pluck(:per_capita_income_2000)").count
