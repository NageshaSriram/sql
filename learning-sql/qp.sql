use hr;
#Q1. WAQ to display the details of employees like id, names , salary ,
# and the names of the departments they work in.  

select e.first_name, e.employee_id, e.salary, d.department_name
from employees e
JOIN departments d
on e.department_id = d.department_id;



#Q2. WAQ to display the details of employees like id, names , salary ,
# and the names of the departments they work in. Also include such
#employees who are not assigned to any departments yet.  

select e.first_name, e.employee_id, e.salary, d.department_name
from employees e
left join departments d
on e.department_id = d.department_id;


# Q3. WAQ to display the details of employees like id, names , salary ,
# and the names of the departments they work in. Include the list of departments
#where no employees are working. 

select e.first_name, e.employee_id, e.salary, d.department_name
from employees e
right join departments d
on e.department_id = d.department_id;


#Q4. WAQ to display the details of employees like id, names , salary ,
# and the names of the departments they work in. Also include such
#employees who are not assigned to any departments yet and the list of 
#departments where no employees are working.

select e.first_name, e.employee_id, e.salary, d.department_name
from employees e
left join departments d
on e.department_id = d.department_id

UNION

select e.first_name, e.employee_id, e.salary, d.department_name
from employees e
right join departments d
on e.department_id = d.department_id;

select e.first_name, e.employee_id, e.salary, d.department_name
from employees e
left join departments d
on e.department_id = d.department_id

UNION ALL

select e.first_name, e.employee_id, e.salary, d.department_name
from employees e
right join departments d
on e.department_id = d.department_id;

#Q5. WAQ to display the details of employees along with the departments,
# cities and the country they work in.

explain select e.first_name, d.department_id, l.city, c.country_name
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id;



#Q6. WAQ to get the count of employees working in different cities.
#display such cities which has more than 20 employees working in them.

select l.city, count(*) as emp_count
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
group by l.city having emp_count > 20;
     
#Q7. Display the list of employees who are based out of America Region.

select e.first_name, r.region_name
	from employees e
		join departments d on e.department_id = d.department_id
			join locations l on d.location_id = l.location_id
				join countries c on c.country_id = l.country_id
					join regions r on r.region_id = c.region_id
						where r.region_name like '%America%';



#Q8. WAQ to list the employees working in 'Seattle'.

select e.first_name, l.city
	from employees e
		join departments d on e.department_id = d.department_id
			join locations l on d.location_id = l.location_id
				where l.city = 'Seattle';
                
#Q9. WAQ to list the details of employees, their department names and 
#the job titles.
select e.first_name, d.department_name, j.job_title
	from employees e
		join departments d on e.department_id = d.department_id
			join jobs j on e.job_id = j.job_id;


   -- --------------------------------------
#Natural join - primitive join - uses any columns with same name and datatype to perform the join.
#Write a query to find the addresses (location_id, street_address, city, 
#state_province, country_name) of all the departments.

select location_id, street_address, city, state_province, country_name, department_name
from locations
NATURAL JOIN countries
NATURAL JOIN departments;


#write a query to display job title, firstname , difference between
# max salary and salary of all employees using natural join 

select job_title, first_name, max_salary - salary
from employees
NATURAL JOIN jobs;

-- ----------------------------------------------------------------
 -- ---------------------------------------------------------------------------------------
 #Self join 
-- Write a query to find the name (first_name, last_name) and hire date of
# the employees who was  hired after 'Jones'.

select *
from employees e1
join employees e2
where e2.last_name = 'Jones' and e1.hire_date > e2.hire_date;

-- same as above on/where

select e1.first_name, e1.hire_date
from employees e1
join employees e2
on e2.last_name = 'Jones' and e1.hire_date > e2.hire_date;
    
# Write a query to display first and last name ,salary of employees who 
#earn less than the employee  whose number is 182 using self join  


select e1.first_name, e1.last_name, e2.salary
from employees e1
join employees e2
where e2.employee_id = 182 and e1.salary < e2.salary;
-------------------------------------------------------------------

/*
#Cross Join - cartersian product between tables
			- every row of 1 table mapped to every row of other table.
            - m*n rows
            - cross join   ,   join 
*/
select * from employees, departments;
select * from employees cross join departments;
---------------------------------------------------------------------------

-- extra practices 
 
 
 
 -- 1.Display the first name, last name, department id and department name, for all employees for departments 80 or 40.
 
select e.first_name, e.last_name, d.department_id, d.department_name
 from employees e
join departments d on d.department_id = e.department_id
where d.department_id in (80, 40); -- 35 rows

 
 
-- 2. Write a query in SQL to display the full name (first and last name), and salary of those employees who working in
--  any department located in London. */


select concat(e.first_name, ' ', e.last_name) as full_name, e.salary, l.city
from employees e
join departments d on d.department_id = e.department_id
join locations l on d.location_id = l.location_id
 where l.city = 'London'; -- 1 row
 
 
 -- 3.	Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name,
 -- department, city, and state province. (3 rows)

select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
join departments d on d.department_id = e.department_id
join locations l on d.location_id = l.location_id
where first_name like '%z%'; -- 3 rows

-- 4.	Write a query in SQL to display the job title, department id, full name (first and last name) of employee, starting date 
-- and end date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 2000. (8 rows)

select j.job_title, e.department_id, concat_ws(' ', e.first_name, e.last_name) as full_name, jh.start_date, jh.end_date
from employees e
join departments d on d.department_id = e.department_id
join jobs j on j.job_id = e.job_id
join job_history jh on jh.employee_id = e.employee_id
where jh.start_date >= '1993-01-01' and jh.end_date <= '2000-08-31';

-- select * from job_history;



-- 5.	.Display employee name if the employee joined before his manager.

select e1.first_name, e1.hire_date as emp_start_date, e2.hire_date as manager_start_date
from employees e1
join employees e2
where e1.hire_date < e2.hire_date and e1.manager_id = e2.employee_id; -- 30 rows

-- or
select e1.first_name, e1.hire_date as emp_start_date, e2.hire_date as manager_start_date
from employees e1
join employees e2
on e1.hire_date < e2.hire_date and e1.manager_id = e2.employee_id; -- 30 rows

-- 6 •Write a query in SQL to display the name of the department, average salary and number of employees working in that department who 
-- got commission. */

select d.department_name, avg(e.salary), count(*) 
from employees e
join departments d on e.department_id = d.department_id
where e.commission_pct is not null
group by d.department_id; -- 1 rows

select d.department_name, avg(e.salary), count(commission_pct)
from employees e
join departments d on e.department_id = d.department_id
where e.commission_pct is not null
group by d.department_id; -- 1 rows

-- 7. Write a query in SQL to display the details of jobs which was done by any of the employees who is  earning a salary on and above 12000( use job_history) */

select jh.*
from employees e
join job_history jh on e.employee_id = jh.employee_id
where e.salary >= 12000;


-- 8. Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80.(use job, job_history)

select e.employee_id, j.job_title, datediff(jh.end_date, jh.start_date)
from employees e
join jobs j on e.job_id = j.job_id
join job_history jh on jh.employee_id = e.employee_id
where e.department_id = 80;

/*
Sub Queries
---------------
- Query withing a query
Query2(Query1)
Query1 - first execute, indpendent of oute query, this answer substitute to outer query
Query2 - second execute 

SubQuery types
- Single row => operators to be used <,>, <=, >=, !=, ==
- multiple row => in, not in, any, all, EXISTS 
- multiple columns => 
- Nested - upto 64 levels Q(Q(Q))
- Correlated sub query - inner query is depended on Outer querry use exists operator, 
inner query execute for every instance of outer querry

subquery can write in. 
- select - where/ having/ from
- insert
- update
- delete
*/

-- find all the details of employee who works in 'Sales' department



