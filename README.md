# Australian Occupation Shortage List (OSL) Analysis

This project provides an analysis of the Australian Occupation Shortage List (OSL), offering insights into the shortage status of various occupations in the Australian labor market. The analysis focuses on identifying trends, regional shortages, and occupation-specific insights using SQL. The data spans from 2021 to 2024 and is based on the ANZSCO6 classification.

---
## 🛡️ License

This project is licensed under the CC BY-NC-ND 4.0 License.  
Unauthorized reposting or modification is strictly prohibited.  
[View License](http://creativecommons.org/licenses/by-nc-nd/4.0/)

📩 For access or collaboration requests, please email me at: navakumarsajjan@gmail.com

---
## Features

- **Occupation Trends**: Analysis of shortages over time (2021-2024).
- **Regional Insights**: Insights into shortages across Australian states and territories.
- **Occupation-Specific Analysis**: Focus on key occupations like analysts and registered nurses.
- **SQL-Driven Approach**: All analysis conducted through SQL queries for accuracy and reproducibility.

---

## Dataset

- **Name**: Australian Occupation Shortage List
- **Timeframe**: 2021-2024
- **Classification**: ANZSCO6
- **Source**: [Australian Skill Shortage Data (2021-2024)](https://www.kaggle.com/datasets/akhtarali1997/australian-skill-shortage-data-2021-2024-anzsco6)

---

**Q1 Identify Occupations with a National Shortage in 2024**
```SQL
select anzsco
	   ,occupation
	   ,year
from occupationshortage
where year = '2024'
			and
	  national_shortage_rating = 'Shortage'		
;
```

There were **293 occupations** with a national shortage in the year 2024.

The image below highlights the national shortage occupations for 2024:

![Q1 Occupation Shortages](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q1.png)

**Q2 Compare shortage ratings for analyst occupation across states in 2024.**
``` SQL
select  occupation,
	    New_South_Wales_Shortage_Rating,
	    Victoria_Shortage_Rating ,
	    Queensland_Shortage_Rating ,
	    South_Australia_Shortage_Rating ,
	    Western_Australia_Shortage_Rating,
	    Tasmania_Shortage_Rating ,
	    Northern_Territory_Shortage_Rating ,
	    Australian_Capital_Territory_Shortage_Rating
from occupationshortage
where lower(occupation) like '%analyst%'
					and
				year = '2024'
order by occupation				
;
```

The image below compares the shortage ratings for analyst occupations across Australian states and territories in 2024:

![Q2 Analyst Shortage Ratings](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q2.png)

#### Observations:

1. **Analyst Programmer** and **Cyber Security Analyst**:
   - These roles face a **shortage** across most states and territories.

2. **Data Analyst**:
   - Rated as **No Shortage** across all regions except **Western Australia**, where it has a **Shortage**.

3. **ICT Business Analyst**:
   - Marked as **Regional Shortage** in **Victoria**, while all other regions report **No Shortage**.

4. **Network Analyst**:
   - Faces **Shortage** in **Victoria**, **Queensland**, and **South Australia**, but **No Shortage** elsewhere.

5. **Other roles like Supply Chain Analyst and Market Research Analyst**:
   - Rated as **No Shortage** across all states and territories.

**Q3 Count how many occupations have shortages in at least one state in 2024.**
```SQL
select count(*)
from occupationshortage
where year = '2024'
          and
	 (
	 New_South_Wales_Shortage_Rating in ('Shortage','Regional Shortage')
	    					or
	 Victoria_Shortage_Rating in ('Shortage','Regional Shortage')
	   						or
	 Queensland_Shortage_Rating in ('Shortage','Regional Shortage')
	   						or
	 South_Australia_Shortage_Rating in ('Shortage','Regional Shortage')
	    					or
	 Western_Australia_Shortage_Rating in ('Shortage','Regional Shortage')
	   						or
	 Tasmania_Shortage_Rating in ('Shortage','Regional Shortage')
	   						or
	 Northern_Territory_Shortage_Rating in ('Shortage','Regional Shortage')
	 						or  
	 Australian_Capital_Territory_Shortage_Rating in ('Shortage','Regional Shortage')
	 )
;
```
**Answer:**
There were **630 occupations** with shortages in at least one state in 2024.

The image below highlights the result of the query:

![Q3 Occupations with Shortages](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q3.png)

**Q4 Find occupations with no shortages across all regions in 2024.**
```SQL
select anzsco
	   ,occupation
from occupationshortage
where year = '2024'
          and
	 (
	 New_South_Wales_Shortage_Rating ='No Shortage'
	    					and
	 Victoria_Shortage_Rating ='No Shortage'
	   						and
	 Queensland_Shortage_Rating ='No Shortage'
	   						and
	 South_Australia_Shortage_Rating ='No Shortage'
	    					and
	 Western_Australia_Shortage_Rating ='No Shortage'
	   						and
	 Tasmania_Shortage_Rating ='No Shortage'
	   						and
	 Northern_Territory_Shortage_Rating ='No Shortage'
	 						and 
	 Australian_Capital_Territory_Shortage_Rating ='No Shortage'
	 )
order by anzsco	 
;
```
**Answer:**
There were **286 occupations** with no shortages across all regions in 2024.

The image below highlights a portion of the occupations with no shortages:

![Q4 Occupations with No Shortages](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q4.png)

**Q5 find the shortage status based on national shortage in 2024**
```SQL
select national_shortage_rating
		,count(*) as cnt
from occupationshortage
where year = '2024'
group by national_shortage_rating
order by national_shortage_rating desc;
```
**Answer:**
Occupations were categorized based on their national shortage status in 2024. There were **293 occupations** facing a **national shortage**, indicating significant demand for labor in these roles. Additionally, **10 occupations** were marked as experiencing a **regional shortage**, highlighting localized labor demands in specific areas. Meanwhile, the majority of occupations, totaling **613**, were classified as having **no shortage**, suggesting a sufficient supply to meet labor market needs in these roles.


The image below highlights the results of the query:

![Q5 National Shortage Status](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q5.png)

**Q6 Find no of shortages for any occupation in all states in 2024.**
```SQL
SELECT 
    'New South Wales' AS State, SUM(CASE WHEN New_South_Wales_Shortage_Rating in ('Shortage','Regional Shortage') THEN 1 ELSE 0 END) AS Shortages
FROM OccupationShortage
WHERE Year = 2024

UNION ALL

SELECT 
    'Victoria' AS State, SUM(CASE WHEN Victoria_Shortage_Rating in ('Shortage','Regional Shortage') THEN 1 ELSE 0 END) AS Shortages
FROM OccupationShortage
WHERE Year = 2024

UNION ALL

SELECT 
    'Queensland' AS State, SUM(CASE WHEN Queensland_Shortage_Rating in ('Shortage','Regional Shortage') THEN 1 ELSE 0 END) AS Shortages
FROM OccupationShortage
WHERE Year = 2024

UNION ALL

SELECT 
    'South Australia' AS State, SUM(CASE WHEN South_Australia_Shortage_Rating in ('Shortage','Regional Shortage') THEN 1 ELSE 0 END) AS Shortages
FROM OccupationShortage
WHERE Year = 2024

UNION ALL

SELECT 
    'Western Australia' AS State, SUM(CASE WHEN Western_Australia_Shortage_Rating in ('Shortage','Regional Shortage') THEN 1 ELSE 0 END) AS Shortages
FROM OccupationShortage
WHERE Year = 2024

UNION ALL

SELECT 
    'Tasmania' AS State, SUM(CASE WHEN Tasmania_Shortage_Rating in ('Shortage','Regional Shortage') THEN 1 ELSE 0 END) AS Shortages
FROM OccupationShortage
WHERE Year = 2024

UNION ALL

SELECT 
    'Northern Territory' AS State, SUM(CASE WHEN Northern_Territory_Shortage_Rating in ('Shortage','Regional Shortage') THEN 1 ELSE 0 END) AS Shortages
FROM OccupationShortage
WHERE Year = 2024

UNION ALL

SELECT 
    'Australian Capital Territory' AS State, SUM(CASE WHEN Australian_Capital_Territory_Shortage_Rating in ('Shortage','Regional Shortage') THEN 1 ELSE 0 END) AS Shortages
FROM OccupationShortage
WHERE Year = 2024

order by 2 desc
;
```
**Answer:**
In 2024, the number of shortages for occupations varied across Australian states. **Western Australia** recorded the highest number of shortages with **339 occupations**, followed closely by **Victoria** with **338 shortages** and **Queensland** with **330 shortages**. **New South Wales** reported **328 shortages**, while the **Northern Territory** had **312 shortages**. **South Australia** recorded **305 shortages**, with **Tasmania** and the **Australian Capital Territory** reporting the lowest numbers at **296** and **295 shortages**, respectively. This data highlights the distribution of occupational shortages across different regions in Australia.


The image below highlights the results of the query:

![Q6 State Shortages](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q6.png)

**Q7 Identify if a shortage trend is improving or worsening over years for an occupation in Australia.**
```SQL
select year
	  ,count(*) as no_of_shortages
from occupationshortage
where national_shortage_rating in ('Shortage','Regional Shortage')
group by year
order by year
;
```
**Answer:**
The shortage trend for the analyzed occupation in Australia shows a significant **worsening trend** from 2021 to 2023, with the number of shortages steadily increasing from **170 shortages in 2021** to **289 in 2022** and further rising to **332 in 2023**. However, the trend shows a slight improvement in 2024, where the number of shortages decreases to **303**, indicating some stabilization in the labor market for this occupation. This suggests that while the shortage situation became more severe over the earlier years, efforts to address the issue might have started yielding results in 2024. 

The image below provides a visual representation of the shortage trend over the years:

![Q7 Shortage Trend](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q7.png)


**Q8 Is 'Registered Nurse' consistently one of the most in-demand jobs in the healthcare sector, based on national shortage ratings?**
```SQL
select year,
	   occupation
	   ,national_shortage_rating
from occupationshortage
where lower(occupation) like '%registered nurse%'
					and
	  national_shortage_rating ='Shortage'
order by 2 ,1	  
;
```
**Answer:**
The data confirms that 'Registered Nurse' is consistently one of the most in-demand jobs in the healthcare sector, as it has been marked with a **shortage rating** across multiple years (2022, 2023, and 2024) for various specialties. These include **Aged Care**, **Child and Family Health**, **Community Health**, **Critical Care and Emergency**, **Developmental Disability**, **Disability and Rehabilitation**, **Medical Practice**, **Mental Health**, and **Paediatrics**.

This consistent shortage highlights the critical and ongoing demand for registered nurses in Australia’s healthcare system.

The image below provides detailed insights into the shortage ratings for 'Registered Nurse' roles over the years:

![Q8 Registered Nurse Shortages](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q8.png)


**Q9 Is 'Analyst' consistently one of the most in-demand jobs based on national shortage ratings across years?**
```SQL
select year
	,anzsco
	,occupation
	,national_shortage_rating
from occupationshortage	
where lower(occupation) like '%analyst'
order by occupation,year;
```
**Answer:**
The data reveals that 'Analyst' roles exhibit mixed trends in terms of being in demand based on national shortage ratings across the years:

- **Cyber Security Analyst**: This role has consistently been marked with a **shortage rating** every year from **2021 to 2024**, highlighting its critical demand across industries.
- **Data Analyst**: Classified as having **no shortage** from **2021 to 2024**, indicating sufficient supply to meet labor market needs.
- **ICT Business Analyst**: Experienced a **regional shortage** in **2022 and 2024**, while having **no shortage** in other years.
- **Systems Analyst**: Faced **regional shortages** in **2022 and 2024**, but **no shortage** in other years.

This analysis indicates that while some specific analyst roles, such as **Cyber Security Analyst**, are consistently in high demand, others like **Data Analyst** show no significant shortages, suggesting varying trends within the 'Analyst' category.

The image below provides additional insights into the shortage ratings for various analyst roles over the years:

![Q9 Analyst Shortages](https://github.com/sajjansaju/Australian-Occupation-Shortage-List-Analysis-SQL/blob/cba7df46d69d811dfcd63c4ea227cda57faa6bf6/Q9.png)



## Conclusion

The analysis of the Australian Occupation Shortage List (OSL) provides valuable insights into the labor market trends across various occupations and regions from 2021 to 2024. Key findings include:

- **Consistent Shortages**: Roles like **Registered Nurse** and **Cyber Security Analyst** have consistently faced shortages, indicating critical demand in the healthcare and technology sectors.
- **Regional Variations**: Shortages vary significantly across states, with **Western Australia** and **Victoria** consistently recording the highest numbers of shortages.
- **Mixed Trends**: While some roles, such as **Data Analyst**, show no significant shortages, other specialized analyst roles exhibit varying levels of demand, reflecting diverse labor market dynamics.
- **Improving Trends**: Certain occupations, like those showing shortages in earlier years, display signs of improvement in 2024, suggesting that interventions may be addressing some labor market gaps.

This study highlights the importance of continuously monitoring labor market trends to address workforce demands effectively. The data-driven approach provides policymakers and organizations with actionable insights to guide decisions on training, immigration, and workforce planning.


