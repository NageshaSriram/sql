
 use hr;
 # 1. write a query to list the employees who work for sales dept. 
 -- using join 
 
 select * from employees e 
 join departments d  on e.department_id=d.department_id 
 where department_name='sales';
 
 # rewrite query using subquery 
 
 select department_id from departments where department_name='sales';
 
 select * from employees where department_id=
     (select department_id from departments where department_name='sales');

 
 
 /* Single row subquery :   A subquery that returns a single value and feeds to main query.
Multiple row subquery : Subquery returns multiple values (more rows) to the main query
Multiple column subqueries : Returns one or more columns.
Correlated subqueries : Reference one or more columns in the outer SQL statement. 
The subquery is known as a correlated subquery because the subquery is related to the outer SQL statement.
Nested subqueries : Subqueries are placed within another subquery.*/
-- --------------------------------------------------------------------
/*positions where sq can be placed 
insert,update,delete,select,from,having */
-- ------------------------------------------------------------------
 # relational operators  < ,>,<=>= ==<>- single row sq
 # multiple row sq- in,any ,all,exists
  -- ---------------------------------------------------------
 # single row sq

 # 1. what is the average salary of sales dept?
 select department_id,avg(salary) from employees  where department_id =
    (select department_id from departments where department_name='sales');
  
 # 2.how many employees have salary greater than that of susan
 select count(*) from employees where salary >(
select salary from employees where first_name='susan');

 #3. list of employees who work other than department of Den
select * from employees where department_id <>
 (select department_id from employees where first_name='den');

 #4. list the employees who earn salary less than the employee gerald
 select * from employees where salary <(
 select salary from employees where first_name='gerald');
-- -------------------------------------------------------------------
 # multiple row sq - in , any, all ,exists
 # in - list of values 
 # any -or all -and  > < 
 # x > any(2,3,4)-- > smallest 
  #x < any(2,3,4)-- < greatest
  #x > all(2,3,4)-- > greatest
  #x < all(2,3,4)-- <smallest
#  =any  same as IN

-- --------------------------------------------------------------
# multiple row queries 
#1. list the employees who work for sales,finance department 
 select * from employees where department_id in (
 select department_id from departments where department_name in ('sales','finance'));
 
 #2. list all the employees  who have more salary than everybody who joined in 2000

 select * from employees where salary >all(select salary from employees 
 where year(hire_date)=2000);
 #3.list the employees where the sales representatives are earning more than any of the 
 #sales manager 
select * from employees where job_id='sa_rep' and salary >any(
select salary from employees where job_id='sa_man');

select salary from employees where job_id ='sh_clerk';
# 4.display the names of the employees whose salary is less than the lowest salary of  any sh_clerk
select * from employees where salary <any(
select salary from employees where job_id ='sh_clerk');
 -- ----------------------------------------------
 
 # nested sq 
 #1. get the details of employees who are working in city seattle
 select * from employees where department_id in (
   select department_id from departments where location_id
    in( select location_id from locations where city='seattle'));
 
 # 2.list the locations in asia region 
 
 select * from locations where country_id in
    (select  country_id from countries where region_id  in
        ( select region_id from regions where region_name='asia'));

 -- --------------------------------------------------------------
 # multiple column queries 
 #1. list all the employees who earn salary equal to that of employee gerald and
 # work in the same department as gerald. 
 

    select * from employees 
    where salary  in ( select salary from employees where first_name='gerald')
       and
        department_id in ( select department_id from employees where first_name='gerald');
        
        
        -- multiple column
                select * from employees 
    where (salary,department_id) in
    ( select salary,department_id  from employees where first_name='gerald');
      

    
  -- -----------------------------------------------------------------  
    # sq in from clause  - derived tables - alias 
    #1. find out the  5th highest salary of the employee
     select min(a.salary) from (select salary from employees order by salary desc limit 5) a;

    #2.display the count of employees whose name starts with 'a'
    
   select count(*) from (select * from employees 
       where first_name like 'a%') b;
  -- ----------------------------------------------------------------  
    # sq in having clause 
    #1. find the departments  with average salary greater than the salary of lex.
  
    
    select employee_id,salary,department_id from employees  group by department_id 
    
     having avg(salary) > (select salary from employees where first_name='lex');
    
    select avg(salary),department_id from employees group by department_id;
    
    -- --------------------------------------------------------------
  
    # sq in update, delete and insert statements
    -- dont execute
    # 1.update the comm_pct of the employees as 0.05 for those who belong to accounts
     update employees set commission_pct=0.05 where 
        department_id=(select department_id from departments  where department_name='accounts');
    #2.give 5 % hike to all the employees of sales dept.
    update employees set salary=salary*1.05 where 
        department_id=(select department_id from departments  where department_name='sales');
    
    # sq in delete 
    #1. delete the records of the employees who belongs to accounts dept
 delete from employees where department_id=
 ( select department_id from departments where department_name='accounts');
    # sq in insert 
    -- create a new table - insert - using sq
 
 create table ex ( id int, salary float);
 insert into ex (select employee_id,salary from employees where department_id=100);
 select * from ex;
 
 
 
 
    -- ----------------------------------------------------
    /*Correlated subquery -inner query will depend on outer query
    inner query gets executed , once for every row that is selected by the outer query
    SELECT j FROM t2 WHERE j IN (SELECT i FROM t1); - uncorrelated 
    SELECT j FROM t2 WHERE (SELECT i FROM t1 WHERE i = j); - corrlated query
     time consuming

    
    */


    
    
  # exists and not exists
  # exists -- true if your sq returns atleast one row 
  
  SELECT last_name, salary, department_id FROM employees o WHERE salary
  > (SELECT AVG(salary) FROM employees WHERE department_id = o.department_id);
  
  #Find employees who have atleast one person reporting to them .
  
  select * from employees a where exists (
      select employee_id from employees b 
            where b.manager_id=a.employee_id);
            
   # 1 find all the dept which have atleast one employee with salary >4000
  select * from departments d where exists (
     select * from employees e where salary>4000 and e.department_id=d.department_id);
  
  #2 list the employees who changed their jobs atleast once. 
  select * from employees e where exists ( 
  select * from job_history j where j.employee_id=e.employee_id);
    
  #3  Display only the department which has employees
    select * from departments d where exists 
  ( select * from employees e where e.department_id=d.department_id);
  -- ================
  -- Extra Practice questions
 -- 1.Find all the employees who have the  highest salary
 SELECT first_name,
       last_name,
       salary,
       department_id
  FROM employees
  WHERE salary = (SELECT max(salary)
                     FROM employees
                     );
-- 2.find employees with second maximum salary 
SELECT first_name,
       last_name,
       salary,
       department_id
  FROM employees
  WHERE salary IN (SELECT max(salary)
                     FROM employees
                     WHERE salary< (SELECT max(salary)
                     FROM employees
                     ));
-- 3.list the employees whose salary is in the range of 10000 and 20000 and working for dept id 10 0r 20 
 select * from employees 
    where (salary,department_id) in
    ( select salary,department_id  from employees where salary between 
    10000 and 20000 and department_id in(10,20));
      
-- 4.Write a query to display the employee name (first name and last name), employee id and salary of all employees who report to Payam. 
SELECT first_name,
       last_name,
       employee_id,
       salary
  FROM employees
  WHERE manager_id = (SELECT employee_id
                        FROM employees
                        WHERE first_name = 'Payam');

-- 5.Write a query to display all the information of the employees whose salary is within the range of smallest salary and 2500. 
SELECT *
  FROM employees
  WHERE salary BETWEEN (SELECT MIN(salary)
                          FROM employees) AND 2500.00;
-- 6.Write a query to display the employee number, name (first name and last name), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name. 
SELECT employee_id,
       first_name,
       last_name,
       salary
  FROM employees
  WHERE salary > (SELECT AVG(salary)
                    FROM employees)
    AND department_id IN (SELECT department_id
                            FROM employees
                            WHERE first_name LIKE '%J%');
-- 7.Display the employee name (first name and last name), employee id, and job title for all employees whose department location is Toronto. 
SELECT first_name,
       last_name,
       employee_id,
       job_id
  FROM employees
  WHERE department_id IN (SELECT department_id
                            FROM departments
                            WHERE location_id IN (SELECT location_id
                                                    FROM locations
                                                    WHERE city = 'Toronto'));
-- 8.Write a query to display the employee id, name (first name and last name), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees. 
SELECT employee_id,
       first_name,
       last_name,
       salary,
       CASE WHEN salary >= (SELECT AVG(salary) FROM employees) THEN 'HIGH'
            ELSE 'LOW' END AS salary_status
  FROM employees;
-- 9.Write a query in SQL to display all the information of those employees who did not have any job in the past. 

SELECT *
  FROM employees
  WHERE employee_id NOT IN (SELECT employee_id
                              FROM job_history);
-- 10. Write a query in SQL to display the full name (first and last name) of manager who is supervising 4 or more employees. 

  SELECT CONCAT(first_name, ' ', last_name) AS full_name
  FROM employees
  WHERE employee_id IN (SELECT manager_id
                          FROM employees
                          GROUP BY manager_id
                          HAVING COUNT(*) >= 4);
  
    
    
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
								   
        
    
    
    
    
    
        
        
    
    
    
    
    
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 