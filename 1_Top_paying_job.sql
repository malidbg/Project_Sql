/*Q1:- what are the top-paying Data Analyst job?
    -Identify the top 10 highest-paying data analyst roles that are available remotely.
    -Focuses on job postings with specified salaries (remove nulls).
    -why? Highlight the top-paying opportunities for data analysts, offering insights into employment */
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
LIMIT 10


