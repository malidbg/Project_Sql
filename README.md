# Introduction
- Dive into the job market! focusing on data analyst roles, this project explores & top-paying jobs, in-demand skills,
  and where high demand meets high salary in data analytics.
- SQL queries ? Check them out here: [Project_Sql](/Project_Sql/)

# Background
- Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.
- Data hails from my [sql_data](/Project_Sql/Sql_Data_csv.file/) . It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:
    1. What are the top-paying data analyst jobs?
    2. What skills are required for these top-paying jobs?
    3. What skills are most in demand for data analysts?
    4. Which skills are associated with higher salaries?
    5. What are the most optimal skills to learn?

# Tool I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:
- **SQL** : The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL** : The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code** : My go-to for database -management and executing SQL queries.
- **Git & GitHub** : Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:
### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

``` sql
select
    job_id,
    job_title,
    salary_year_avg,
    job_location,
    name as company_name
FROM
    job_posting_dim as jpd
LEFT JOIN company_dim as cd ON cd.company_id = jpd.company_id
where
    job_tittle_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg is NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023 :
- **Wide Salary Range :** Top 10 paying data
analyst roles from $184,000 to $650,000, indicating significant salary potential in the field.
- **Job Title Variety :** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
``` sql
with top_paying AS (      
    select
        job_id,
        job_title,
        salary_year_avg,
        name as company_name
    FROM
        job_posting_dim as jpd
    LEFT JOIN company_dim as cd ON cd.company_id = jpd.company_id
    WHERE
        job_tittle_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg is NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
select
    top_paying . *,
    skills
from
    top_paying
JOIN skills_job_dim as sjd ON sjd.job_id = top_paying.job_id
JOIN skills_dim as sd ON sd.skills_id = sjd.skill_id
ORDER BY salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 hightest paying data analyst jobs in 2023.
- Sql , python, tableau, and other skills like R, Snowflake, pandas, and Excel.

### 3. In-Demand Skills for Data Analysts
This query helped identify the skill most frequently requested in job postings,directing focus to areas with high demand.

``` sql
SELECT 
    count(*) as demand_count,
    skills_id,
    skills
FROM
    job_posting_dim as jpd
JOIN skills_job_dim as sjd ON sjd.job_id = jpd.job_id
JOIN skills_dim as sd ON sd.skills_id = sjd.skill_id
where
    job_tittle_short = 'Data Analyst'
GROUP BY skills_id
ORDER BY demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analyst in 2023.
- SQL and Excel remain fundamental, emphasizing the need for strong fondational skills in data processing and spreadsheet manipulation.
- Programming and Visualization Tools like Python and Power BI are essential, pointing towards the increasing  importance of technical skills in data storytelling and decision support.

### 4.Skills Based On Salary.
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

``` sql
SELECT
    skills,
    round(avg(jpd.salary_year_avg),0)as avg_salary
FROM
    job_posting_dim as jpd
JOIN skills_job_dim as sjd ON sjd.job_id = jpd.job_id
JOIN skills_dim as sd ON sd.skills_id = sjd.skill_id
where 
    job_tittle_short = 'Data Analyst'
    AND salary_year_avg is not NULL
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
limit 25
```

### 5. Most Optimal skills to learn.
combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic for skill development.

``` sql
select
    count(*) as demand_count,
    sd.skills_id,
    sd.skills,
    round(avg(salary_year_avg),0) as avg_salary
from
    job_posting_dim as jpd
join skills_job_dim as sjd ON sjd.job_id = jpd.job_id
JOIN skills_dim as sd ON sd.skills_id = sjd.skill_id
where
    job_tittle_short = 'Data Analyst'
    AND salary_year_avg is NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills_id
HAVING count(*) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
# What I Learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:
- **Complex Query Crafting :** Mastered the art
of advanced SQL, merging tables like a pro and wielding WITH Clauses for ninja-level.
- **Data Aggregation :** Got cozy with GROUP BY
and turned aggregate functions like COUNT() and AVG () into my data-summarizing.
- **Analytical Wizardry :** Leveled up my
real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions
### Insights
1. **Top-Paying Data Analyst Jobs** : The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs** : High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills** : SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries** : Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value** : SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts
- This project enhanced my SQL skills and provided valuable insights into the data analyst job market . Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
