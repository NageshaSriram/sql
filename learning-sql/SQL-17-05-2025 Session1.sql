-- Database 17-05-2025 Session1

/**

What is data?
- Raw fact and figures

Database?
- Collection of inter-related data

DBMS?
- DataBase Management System
- to main all the data

RDBMS?
- Realtional DBMS


Relation?
- Another name for Table

Table?
- Rows and columns

Modules?
- Commands
- Joins
- Subquery
- window function
- keys/Constrains
- view
- Theory X prozen

SQl?
- Structured Query language

SQl Command Group?students
- DDL - Create, Alter, Drop, Truncate
- DML - Data Manipulation Language - insert, Update, Delete
- DQL - Data Query Language - SELECT
- DCL - Data Control Language - Grant, Revoke
- TCL - Transactional Control Languge
- 


Schema or Database are same?
- Collection of Table

**/


 --  Create Database;
 
 create database apr;
 
 use apr;

-- show all the databases and table 

show databases;
show tables;



 /**
 the is the comment multiline
 **/
 
 
 /**
 table - Relation
 columns - Attributes
 rows - tuples
 **/
 
 -- What is diff between char and varchar
 
 -- varchar 
 
 -- Create Table
 
 create table student(
	rollno int ,
    name varchar(30),
    marks float
 );
 
 desc student; # structure of the table

-- insert a single row
insert into student values(18, "Nagesh", 100);

-- multiple insertion
insert into student values(2, "Tej", 100),(3, "Hsa", 100),(4, "Bgd", 100);

-- not inserting some values, intentionally null values
insert into student values(5, 'Bob', null);

-- insert only to specific columns
insert into student(rollno, name) values(6, 'John');

insert into student values(7, "Sam", 48),(8, "Jane", 34),(8, "Smith", 79);

-- Select all the data
select * from student;

create table IF NOT EXISTS subjects(no int AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(200) not NULL,
author VARCHAR(30),
publish_date DATE);

-- logical operators
-- and, or, not

-- opertator
-- <, >, <=, >=, =,<> or != 
-- defaults write com.oracle.workbench.MySQLWorkbench NSRequiresAquaSystemAppearance -bool yes

select * from student;

select * from student where marks > 50;

select * from student where marks>50 and marks<=100;

select * from student where rollno=2 or rollno=3;

select * from student where rollno in (1,2,3);

select * from student where marjs between 30 and 50; -- both 30 and 50 are inclusive

select * from student where marks is null;

select * from student where marks is not null;

select * from student where name like '_a%'; -- second letter is 'a'

select * from student where name not like 'B%'; -- name doesn't start with letter 's'

-- Order by - sorting asc desc - 1 column, 2 columns

-- order by 2 column make sense only when duplicate values are allowed - sorting

select * from student order by marks desc;

select * from student order by name asc, marks desc;

select * from student order by 2; -- oder based on original tables 2nd column

select marks, rollno from student order by 2; -- here order by rollno

-- limit clause

select * from student order by marks desc limit 5;

select * from student order by marks desc limit 3, 1; -- offset 4th highest marks(offset start from 1)

-- 4th and 5th highest marks
select * from student order by marks desc limit 3, 2;

select * from student limit 0,4;

-- distinc: remove duplicat evalues and 

select DISTINCT name from student; -- unique values

select DISTINCT name, marks from student; -- works

select DISTINCT(name, marks) from student; -- fails at syntax error


-- Update
set sql_safe_updates = 0;
update student set marks =marks+10 WHERE name = 'Sam';

update student set marks=marks+10, rollno=rollno+2 where name LIKE 's%';

select * from student;

-- delete: deletes the rows

delete from student where marks< 60;

select * from student;

/**
Alter
----------
- add a column
- drop a column
- rename a columns
- modify a table
- change = rename + modify

**/

-- add a column (position: first, after, by default it will be last)
alter table student add column city VARCHAR(30);

desc student;

-- add column at the first place
ALTER table student add column phone int first;

-- add the column after some column
alter table student add COLUMN aadhar varchar(20) after marks; 

-- add two columns
ALTER table student add COLUMN col1 varchar(20), col2 int;

-- drop column
alter table student drop COLUMN city;

-- rename
alter table student rename column phone to phonenumm;


-- modify
alter table student modify phonenumm float;

-- change
alter table student change column rollno regno float;


desc student;

-- drop, truncate and rename

create table csestudet as select * from student;

-- TRUNCATE
select * from csestudet;

TRUNCATE table csestudet;

drop table csestudet;

rename table student to student_new;

-- can use desc/describe to get table details

 