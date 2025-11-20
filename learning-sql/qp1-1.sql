

-- Practice  Questions use hr
use hr;

-- 1.Write a query to show the employee details whose job id is  'IT_PROG'

select * from employees where job_id = 'IT_PROG';

-- 2.Write a query to show the employee details hired between 1990 and 1995 

select * from employees where hire_date BETWEEN '1990-01-01' and '1995-12-31';

select * from employees where year(hire_date) between 1990 and 1995;

-- 3.Write a query to show the Department id  & hire_date for Neena  & bruce

select department_id, hire_date from employees where first_name in ('Neena', 'bruce');

-- 4.Write a query to show the Name and job id of the employees working as accountant or clerk.

select first_name, job_id from employees where job_id like '%ACCOUNT%' or job_id like '%CLERK%';

-- 5.Write a query to show the employee details who has joined before 1995

select * from employees where hire_date < '1995-01-01';
select * from employees where year(hire_date) < 1995;

-- 6.Write a query to show the employee details who has not assigned any manager

select * from employees where manager_id is null;

-- 7.Write a query to show the details of all employees whose job_id is IT_PROG name and earns salary more than 5,000.

select * from employees where job_id = 'IT_PROG'  and salary > 5000;

-- 8.Write a query to show all the employees not belonging from department id 90,80,70

select * from employees where department_id not in (90,80,70);

-- 9.Write a query to display employee id, first name, last name, job id  of first 5 highest salaried employees.

select employee_id, first_name, last_name, job_id from employees ORDER BY salary desc limit 5;
-- 10.Write a query to display third highest salaried employee details having 'ST_MAN' job id.

select * from employees where job_id = 'ST_MAN' order by salary desc limit 2,1;

-- 11.Write a query to display the average, highest, lowest, and sum of monthly salaries for all sales representatives

select avg(salary), MAX(salary), MIN(salary), sum(salary) from employees where job_id = 'SA_REP';
-- 12.Write a query to show the earliest and latest join dates of employees

select min(hire_date), max(hire_date) from employees;

-- 13. Write a query to display the no. of weeks the employee has been employed for all employees in department 90
-- select ceil((datediff('2000-04-21', '1987-06-17') / 365)* 52); 
select *, round(datediff(curdate(), hire_date)/7) from employees where department_id = 90;
select *, round(datediff(curdate(), hire_date) / 7) as weeks from employees where department_id = 90;
-- 14.Write a query to display hire date, date after 100 days of joining and date before 1 Month of joining for those belong  department id 90

select hire_date, adddate(hire_date, interval 100 day) as after100,
subdate(hire_date, interval 1 month) as before1, adddate(hire_date, interval -1 month) from employees;
-- 15.Write a query to display salay, and sal_grade as ‘Good’ if salary >15000 other wise ‘Bad’

select salary, if(salary>15000, 'Good', 'Bad') from employees;

-- 16.Write a query to display id, firstname,department_id salary and list 0 if commission_pct value is NULL for those employees belong to department id 80 and 90 */

select coalesce(commission_pct, 0) from employees;


select employee_id, department_id, salary, coalesce(commission_pct, 0) from employees where department_id = 90;

-- no. employees greater than 20 in a department

select department_id, count(*) from employees GROUP BY department_id having count(*) > 20; -- having for filtering group by
 
 


use hr;
# use employees table 
# Question 1: display the number of employees in each department. 
select department_id, count(*) from employees group by department_id;

# Question 2:  display total salary paid to employees  in each department
select department_id, sum(salary) from employees group by department_id;

# Question 3: display number of employees, avg salary paid to employees in each department.
select department_id, count(*), avg(salary) from employees group by department_id;

# Question 4: display the department id, job id, min salary paid to employees group 
#by department_id, job_id.
select department_id, job_id, min(salary) from employees group by department_id, job_id;


# Question 5: find the sum of salary, count of employees who belong to the department id
# 80 and 90  
select department_id,sum(salary), count(*) from employees where department_id in (80, 90) group by department_id;

# Question 6: display the count of the employees based on year( hiredate )

select year(hire_date), count(*) as number_of_employees from employees group by year(hire_date);

select year(hire_date), month(hire_date), count(*) from employees group by year(hire_date), month(hire_date) order by year(hire_date), month(hire_date);
# Question 7: sort and group  the employees based on year and month wise with count of
# employees 
select year(hire_date), month(hire_date), count(*) from employees group by year(hire_date), month(hire_date) ORDER BY year(hire_date), month(hire_date); # order by should be at the end


# Question 8: display the department id, number of employees of those groups that have 
#more than 2 employees -- having clause 

select department_id, count(*) from employees GROUP BY department_id having count(*) > 2;

select department_id, count(*) as emp_count from employees GROUP BY department_id having emp_count > 2;

# select department_id, count(*) as employee_count from employees GROUP BY department_id having employee_count > 2;

# Question 9:  display the departments which has sum of salary greater than 35000
select department_id, sum(salary) from employees GROUP BY department_id having sum(salary) > 35000;
   /*
CASE <input>
    WHEN <eval_expression_1> THEN <expression if true>
    WHEN <eval_expression_2> THEN <expression if true>
    …
    WHEN <eval_expression_N> THEN <expression if true>
    ELSE <default expression> END 
*/

select salary,
case 
	when salary between 15000 and 24000 then 'heavily paid'
    when salary between 10000 and 14000 then 'heavily paid'
    when salary between 5000 and 1000 then 'heavily paid'
    else 'very low'
    end as salary_categories
from employees;



-- categorize employees based on their year of service <365 as less than 1 yr,
# <730 as 1-2 yrs <1095 as 2-3 yrs else more than 3 yrs 
-- consider todays date as 2000-12-31.

select hire_date, case
	when datediff('2000-12-31', hire_date) < 365 then 'less than 1 yr'
    when datediff('2000-12-31', hire_date) < 730 then '1-2 yrs'
    when datediff('2000-12-31', hire_date) < 1095 then '2-3 years'
    else 'more than 3 yrs'
    end as experience
    from employees;

select hire_date, case
	when datediff('2000-12-31', hire_date) < 365 then 'less than 1 yr'
    when datediff('2000-12-31', hire_date) < 730 then '1-2 yrs'
    when datediff('2000-12-31', hire_date) < 1095 then '2-3 yrs'
    else 'more than 3 yrs'
    end as experience from employees;
    


















