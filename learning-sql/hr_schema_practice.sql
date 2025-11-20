use hr;

desc employees;

select first_name, last_name from employees;

select first_name, salary from employees where salary > 10000;

select first_name, salary from employees ORDER BY salary desc;

select first_name, salary from employees ORDER BY salary desc limit 5;

select first_name, department_id,salary from employees where department_id = 50 and salary > 5000;

select employee_id, first_name, job_id from employees;

select * from employees where salary BETWEEN 7000 and 10000;

select first_name from employees where first_name like 'A%';

select first_name from employees order by salary limit 3;

select first_name from employees where first_name like 'S%';

select first_name from employees where first_name like '%a';
select first_name from employees where first_name like '%na%';
select * from employees where salary between 6000 and 9000;

select first_name, department_id from employees where department_id in (10, 20, 30);

select first_name, job_id from employees where job_id in ('IT_PROG', 'SA_REP');

select employee_id, manager_id FROM employees where manager_id is null;
select employee_id, manager_id FROM employees where manager_id is not null;

select first_name from employees where first_name like '%n';
select first_name, department_id from employees where department_id in (50, 60, 70);
select first_name, salary from employees where salary between 9000 and 12000;
select first_name, commission_pct from employees where commission_pct is null;

select first_name, salary from employees order by salary;
select first_name, department_id, salary from employees order by department_id asc, salary desc;
select UPPER(first_name), LOWER(last_name) from employees;
select concat(first_name, ' ', last_name) as full_name from employees;
select first_name, length(first_name), substring(first_name, 1, 3) from employees; -- substring() also right

select first_name, salary, ROUND(salary / 12, 2), mod(salary, 12) from employees;

select first_name, hire_date, curdate(), datediff(curdate(), hire_date) as no_days_worked from employees;	

select first_name, hire_date, date_format(hire_date, '%M %Y') as join_month_and_year from employees;

select concat(first_name, ' ', last_name) from employees;

select first_name, salary, ROUND(salary / 12, 2) as monthly_salary from employees;

select first_name, hire_date,  datediff(curdate(), hire_date) as no_days_worked from employees;

select first_name, department_id, salary from employees order by department_id, salary desc;

select e.first_name, e.last_name, d.department_name from employees e JOIN departments d on e.department_id = d.department_id;

select e.first_name, d.departmnent_id from employees RIGHT JOIN departments d on e.departmnet_id = d.department_id;

select e.first_name, e.last_name, d.department_name from employees e RIGHT JOIN departments d on e.department_id = d.department_id;

select e.first_name, d.department_name, l.city
from employees e
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = d.location_id;


select e.first_name, d.department_name
from employees e
JOIN departments d on e.department_id = d.department_id;

select e.first_name, d.department_name
from employees e
LEFT JOIN departments d on e.department_id = d.department_id;

select e.first_name, d.department_name
from employees e
Right JOIN departments d on e.department_id = d.department_id;

select e.first_name, d.department_name, l.city
from employees e
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = l.location_id;

select department_id, count(*) as number_of_employees from employees GROUP BY department_id;
select department_id, avg(salary) as avg_salary from employees GROUP BY department_id;
select department_id, max(salary) as max_salary from employees GROUP BY department_id;	
select sum(salary) as all_salary from employees;

select department_id, count(*) as total_employees from employees group by department_id having total_employees > 5;

select job_id, count(*) as total_employees from employees group by job_id;

select department_id, avg(salary) as avg_salary, count(*) as emp_count
from employees group by department_id having emp_count > 3; 

select department_id, min(salary) as min_salary
from employees
group by department_id;

select sum(salary) from employees;

-- emp names and his manager names use left join 
select e.first_name, e1.first_name
from employees e
LEFT JOIN employees e1
on e.manager_id = e1.employee_id;

-- 6.3 Example: Subquery in WHERE Clause
-- Find employees who earn more than the average salary:
select first_name, salary
from employees
where salary > (select avg(salary) from employees);

-- Subquery in SELECT Clause
-- Show employees with their department name using subquery (instead of JOIN):
select e.first_name, 
	(select d.department_name 
     from departments d 
     where d.department_id = e.department_id) as department_name
from employees e;

-- Simple CASE Example
-- Classify employees by salary level:
select first_name, salary,
	case
		when salary > 15000 then 'High'
        when salary between 10000 and 15000 then 'Medium'
        else 'low'
	end as salary_level
from employees;

-- CASE with Aggregation Example
-- Count how many employees in each salary level:

select 
	case
		when salary > 15000 then 'high'
        when salary between 10000 and 15000 then 'medium'
        else 'low'
	end as salary_level,
    count(*) as total_emp_count
from employees
GROUP BY salary_level;


select first_name, salary
from employees
where salary > (select avg(salary) from employees);

select e.first_name, 
	(select d.department_name 
	 from departments d 
     where d.department_id = e.department_id)
from employees e;

select first_name,
	case
		when salary > 12000 then 'Senior'
        when salary between 7000 and 12000 then 'Junior'
        else 'Entry'
	end as postions
from employees;

select
	case
		when salary > 12000 then 'Senior'
        when salary between 7000 and 12000 then 'Junior'
        else 'Entry'
	end as postions,
    count(*) as total_employees
from employees
group by postions;

select first_name,
	   IF(salary > 12000, 'High', 'Low') as salary_level
from employees;
       
