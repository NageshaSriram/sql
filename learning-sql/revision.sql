-- order of operations

-- from -> where -> group by -> having -> select -> order by -> limit

create table Employees (
    emp_id int AUTO_INCREMENT primary key,
    emp_name varchar(50),
    department varchar(50),
    salary int,
    job_id int,
    hire_date date,
    department_id int,
    PRIMARY KEY (emp_id)
);


-- select e.department_id, count()

-- Mention the difference between TRUNCATE and ROUND functions
-- TRUNCATE function is used to remove the decimal part of a number without rounding it. It simply cuts off the decimal portion.
-- ROUND function is used to round a number to the nearest integer or to a specified number of decimal places.  
-- For example, TRUNCATE(5.67, 1) will return 5.6, while ROUND(5.67, 1) will return 5.7.
-- Example:
SELECT TRUNCATE(5.67, 1) AS truncated_value, ROUND(5.67, 1) AS rounded_value;
