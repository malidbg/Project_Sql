/* Q :- what are the most optimal skills to learn?  (optimal:-High demand and high paying skills) 
    - Identfy skills in high demand and associated with high average salaries for Data Analyst roles,
    - concentrates on remote position with specified salaries
    why? Target skills that offer job security (high demand) and financial benefits(high salaries),
        offering strategic insights for career development in data analyst */

with demand_skill as(  -- cte_1
    SELECT
        skills_id, 
        count(jpd.job_id) as demand_count,
        skills
    FROM 
        job_posting_dim as jpd
    JOIN skills_job_dim as sjd ON sjd.job_id = jpd.job_id
    JOIN skills_dim as sd ON sd.skills_id = sjd.skill_id
    where 
        job_tittle_short = 'Data Analyst'
        AND salary_year_avg is NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_id
),
avg_salary as (        -- cte_2
    select
        skill_id,
        round(avg(jpd.salary_year_avg),0) as avg_salary
    from
        job_posting_dim as jpd
    join skills_job_dim as sjd ON sjd.job_id = jpd.job_id
    -- join skills_dim as sd ON sd.skills_id = sjd.skill_id
    where
        job_tittle_short = 'Data Analyst' 
        AND salary_year_avg is NOT NULL
        AND job_work_from_home = true
    GROUP BY 
        sjd.skill_id
)
SELECT                          -- combine
    demand_count,
    skills_id,
    skills,
    avg_salary
FROM 
    demand_skill
JOIN avg_salary ON avg_salary.skill_id = demand_skill.skills_id
where demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/* 2nd method */

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


