/* Q:- what are the top skills based on salary?
    look at the average salary associated with each skill for Data Analyst positions
    focuses on roles with specified salaries, regardless of location
    why? it reveals how different skills impact salary levels for Data Analyst and helps identify
    the most financially rewarding skills to acquire or improve */

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
