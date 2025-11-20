        use hr;
        
  -- CTE 
   # Find the minimum and maximum of the avg salary among all the depts

      with ex1 as (select avg(salary) as avgsalary from employees group by department_id)
      select min(avgsalary), max(avgsalary) from ex1;
      
      SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY',''));
      
      # Find the big and small departments wrt to the count of employees 
      
            with ex1 as (select count(*) as number_of_emp,department_id  from employees group by department_id)
				select min(number_of_emp) as min_emp, max(number_of_emp) from ex1;
      
      
      with ex1 as (select count(*) as number_of_emp,department_id  from employees group by department_id)
      select (select department_id from ex1 where number_of_emp = max(number_of_emp) as dd from ex1;
      
       -- Find percentile rank  of every dept by total salary.

with ex2 as (select *, sum(salary) as total from employees group by department_id)
	select department_id, PERCENT_RANK() over (order by total) from ex2;
   
  -- find employee details who earns 2nd highest salary dept wise 

with ex3 as (select *, DENSE_RANK() over
	(PARTITION BY department_id order by salary desc) as rankk from employees)
		select * from ex3 where rankk=2;
        
        
        
        
/*
   Data Integrity
   
   1. Constrints
   2. Normalization
		- partitions
        
        
3 types of data intigrity
- Entity Integrity or row level
- Domin Integrity or column level
- Referential integrity or table

Keys
----------------
- Candidate key
- Primary key - one of the candidate key - should be unique and not null
- Foreign key
- unique key
- Alternate key


*/

use hr;

create table example1 (
	stuid int primary key,
    stuname varchar(20) unique,
    phone int not null,
    city varchar(20) default 'blr',
    age int check (age>18) 
);

desc example1;

select * from example1;

insert into example1 values(1, "sam", 9000, "blr", 19);
insert into example1 values(1, "sam", 9000, "blr", 19);
insert into example1 values(2, "sam", 9000, "blr", 19);
insert into example1 values(1, "samy", null, "blr", 19);
insert into example1(stuid, stuname, phone, age) values(2, "John", 4555, 19);


-- ON DELETE RESTRICT ON UPDATE RESTRICT same as No Action
