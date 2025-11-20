-- creating database
create database school;

-- show all databases
show databases;

-- use a database
use school;

-- drop database 
drop database school;

/**
Numeric Data Types

| Data Type      | Description                         |
| -------------- | ----------------------------------- |
| `INT`          | Integer (whole numbers)             |
| `TINYINT`      | Very small integer (-128 to 127)    |
| `SMALLINT`     | Small integer                       |
| `MEDIUMINT`    | Medium integer                      |
| `BIGINT`       | Large integer                       |
| `DECIMAL(m,d)` | Fixed-point number                  |
| `FLOAT(p)`     | Floating-point number (approximate) |
| `DOUBLE`       | Double precision floating-point     |

String DataType

| Data Type    | Description                              |
| ------------ | ---------------------------------------- |
| `CHAR(n)`    | Fixed-length string (padded with spaces) |
| `VARCHAR(n)` | Variable-length string (up to 65,535)    |
| `TEXT`       | Large text (up to 65,535 characters)     |
| `TINYTEXT`   | Small text (up to 255 characters)        |
| `MEDIUMTEXT` | Medium-length text                       |
| `LONGTEXT`   | Very large text                          |


Date and Time Data Types

| Data Type   | Description                          |
| ----------- | ------------------------------------ |
| `DATE`      | YYYY-MM-DD                           |
| `DATETIME`  | YYYY-MM-DD HH\:MM\:SS                |
| `TIMESTAMP` | Similar to `DATETIME` + auto-updates |
| `TIME`      | HH\:MM\:SS                           |
| `YEAR`      | YYYY                                 |

Boolean

is_active TINYINT(1) -- 0 = false, 1 = true

**/

create table students (
	id int primary key,
    name varchar(50),
    birthdate date,
    gpa decimal(3, 2),
    is_enrolled tinyint(1)
);
drop table students;

create table students (
	id int primary key,
    name varchar(50) not null,
    age int,
    email varchar(100) unique,
    enrolled_date date,
    is_active tinyint(1) default 1,
    join_date DATE default current_timestamp
);

-- selecting current user
select current_user();

-- Select cuurent date
select current_date();








