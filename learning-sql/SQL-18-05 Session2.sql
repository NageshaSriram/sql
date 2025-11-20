-- numeric function

select round(23.46), round(23.56), truncate(23.45002,3), truncate(23.5654, 2);

select ceil(23.44), floor(23.97);

select greatest(23, 11, 56), least(23, 11, 89), pow(3, 2), sqrt(16);

-- string functions

select lower("SQL"), upper("sql"), replace("pes univercity", "pes", "srm");

select length("univercity"), instr("univercity", "n");

select substr("pesdfs", 3, 4); # start from 3 (index start from 1) + 4 charactor from there

select concat("pes", "univercisty","blore","CSE");

select concat_ws(" ","pes", "univercity", "blore"); # first param can be anything (" ", ",","|") it will concate with them

select right("univercity", 3), left("uivercity", 3); # select from right(end) 3 chars and left(start) 3 chars

select reverse("univercisy");




-- date functions

select curdate(), curtime(), now(); # curdate(2025-05-25), curtime(17:48:41), now(2025-05-25 17:48:41)

select day(curdate()), dayname(curdate());
select monthname('2023-09-09');
select year(curdate());
select month(curdate());

select curdate('YYYY-MM-DD');

select adddate(curdate(), interval 3 month);
select adddate(curdate(), interval 10 day);
select adddate(curdate(), interval -3 month);
select adddate(curdate(), interval 3 year);

select datediff('1999-11-09', '1994-12-04');
select datediff('2025-05-01', '2024-05-01'); # days difference
select period_diff('202509', '202409'); # months difference

select date_format(curdate(), "%W - %D - %Y - %M"); # Sunday - 25th - 2025 - May
select date_format('2025-05-03', "%W, %D, %Y"); # Saturday, 3rd, 2025
select date_format(curdate(), "%W"); # Sunday
select curdate();

select date_format(curdate(), "%a - %d/ %y %m %y"); # Sun - 25/ 25 05 25

select str_to_date("Sunday - 18th - 2025", "%W - %D - %Y"); # not working check it

 -- Aggregate functions
 
 use apr;
 
 select * from student_new;
 
 select min(marks), min(marks) as minimummarks, max(marks) as maximummarks, sum(marks) as total, avg(marks) as averagemarks,
 count(*) as totalno_student from student_new;
 
 select count(-1);

select avg(marks), avg(coalesce(marks, 0)) from student_new;
select avg(marks), avg(ifnull(marks, 0)) from student_new;

select * from student;


create table student(
	roll_no int auto_increment primary key,
    name varchar(30) not null,
    marks float
);

select * from student;

insert into student values
	('Nagesh', 100),
    ('Tejaswini', 100),
    ('Ranamma', 90),
    ('Kullamma', 95),
    ('Babymma', 96),
    ('Nagamma', 99),
    ('tejamma', 100),
    ('nagamma', 100),
    ('Nag Rani', 98);








