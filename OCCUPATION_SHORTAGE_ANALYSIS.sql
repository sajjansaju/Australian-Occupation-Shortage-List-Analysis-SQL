
-- Step 1: Create the database
CREATE DATABASE OccupationShortageDB;

-- Step 2: Use the database
USE OccupationShortageDB;

-- Step 3: Create the table
CREATE TABLE OccupationShortage (
    Year INT NOT NULL,
    ANZSCO INT NOT NULL,
    Occupation VARCHAR(255) NOT NULL,
    National_Shortage_Rating VARCHAR(50),
    New_South_Wales_Shortage_Rating VARCHAR(50),
    Victoria_Shortage_Rating VARCHAR(50),
    Queensland_Shortage_Rating VARCHAR(50),
    South_Australia_Shortage_Rating VARCHAR(50),
    Western_Australia_Shortage_Rating VARCHAR(50),
    Tasmania_Shortage_Rating VARCHAR(50),
    Northern_Territory_Shortage_Rating VARCHAR(50),
    Australian_Capital_Territory_Shortage_Rating VARCHAR(50),
    Skill_Level VARCHAR(50)
);

select *
from occupationshortage;

-- Q1 Identify occupations with a national shortage in the year 2024.
select anzsco
	   ,occupation
	   ,year
from occupationshortage
where year = '2024'
			and
	  national_shortage_rating = 'Shortage'		
;

-- Q2 Compare shortage ratings for analyst occupation across states in 2024.
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

-- Q3 Count how many occupations have shortages in at least one state in 2024.
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

-- Q4 Find occupations with no shortages across all regions in 2024.
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

-- Q5 find the shortage status based on national shortage in 2024
select national_shortage_rating
		,count(*) as cnt
from occupationshortage
where year = '2024'
group by national_shortage_rating
order by national_shortage_rating desc;

-- Q6 Find no of shortages for any occupation in all states in 2024.

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


-- Q7 Identify if a shortage trend is improving or worsening over years for an occupation in Australia.
select year
	  ,count(*) as no_of_shortages
from occupationshortage
where national_shortage_rating in ('Shortage','Regional Shortage')
group by year
order by year
;

-- Q8 Is 'Registered Nurse' consistently one of the most in-demand jobs in the healthcare sector, based on national shortage ratings?
select year,
	   occupation
	   ,national_shortage_rating
from occupationshortage
where lower(occupation) like '%registered nurse%'
					and
	  national_shortage_rating ='Shortage'
order by 2 ,1	  
;

--Q9 Is 'Analyst' consistently one of the most in-demand jobs based on national shortage ratings across years?
select year
	,anzsco
	,occupation
	,national_shortage_rating
from occupationshortage	
where lower(occupation) like '%analyst'
order by occupation,year

--------------END OF PROJECT------------------