/* Q:- what are the most in-demand skills for data analyst?
    join job posting to inner join table similar to query 2
    identify the top 5 in-demand skills for a data analyst.
    focus on all job posting.
  why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seeker.*/

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
LIMIT 5






 
