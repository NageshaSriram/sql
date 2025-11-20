create database zomato;

use zomato;

create table users (
	id int AUTO_INCREMENT primary key,
    name VARCHAR(30),
    gender VARCHAR(10),
    phone_number int(10),
    email varchar(50),
    address varchar(100)
);

create table restaurents (
	rest_id int AUTO_INCREMENT primary key,
    name varchar(50),
    address varchar(100)
);

create table food (
	food_id int AUTO_INCREMENT PRIMARY key,
    food_name varchar(30)
);

alter table food add column rest_id int;

alter table food add constraint fk_rest_id FOREIGN KEY (rest_id) references restaurents(rest_id);
