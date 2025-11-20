-- to accept in-file load
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

/*
-- enabled from terminal to in-file load
mysql --local-infile=1 -u root -p db_name
*/



show variables like "secure_file_priv";


create database films;

use films;

-- /Users/nageshasriramappa/Downloads/ml-latest/movies.csv

create table movies(
	movieId int,
    title varchar(200),
    genres varchar(200));

-- to check from where we can upload file to import data, if it is NULL then we can import from anywhere    
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA LOCAL INFILE '/Users/nageshasriramappa/Downloads/ml-latest/movies.csv'
INTO TABLE movies
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select count(*) from ratings;
select count(*) from genome_scores;
select * from genome_scores limit 100;

-- rename table `genome-tags` to genome_tags;

select * from movies limit 100;
select count(*) from movies;
select count(*) from links;
select count(*) from tags;

select * from links limit 100;

show databases;
show tables;






