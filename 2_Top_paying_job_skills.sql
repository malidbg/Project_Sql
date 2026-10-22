/* Q:- what skills are required for the top-paying Data Analyst job?
use  the top 10 highest-paying Data Analyst jobs form first query
Add the specific skills required for these roles
why? it provides a detailed look at which high-paying jobs demand certain skill,
    helping job seekers understand with skills to develop that align with salaries */

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
ORDER BY salary_year_avg DESC
