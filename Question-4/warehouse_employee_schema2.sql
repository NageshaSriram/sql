
create database warehouse_employees;
use warehouse_employees;

	CREATE TABLE warehouses (
	   code INTEGER NOT NULL,
	   location VARCHAR(255) NOT NULL ,
	   capacity INTEGER NOT NULL,
	   PRIMARY KEY (code)
	 );
	CREATE TABLE boxes (
	    code CHAR(4) NOT NULL,
	    contents VARCHAR(255) NOT NULL ,
	    value REAL NOT NULL ,
	    warehouse INTEGER NOT NULL,
	    PRIMARY KEY (code),
	    FOREIGN KEY (warehouse) REFERENCES warehouses(code)
	 ) ENGINE=INNODB;
	 
	  INSERT INTO warehouses(code,location,capacity) values(1,'Chicago',3);
	 INSERT INTO warehouses(code,location,capacity) values(2,'Chicago',4);
	 INSERT INTO warehouses(code,location,capacity) values(3,'New York',7);
	 INSERT INTO warehouses(code,location,capacity) values(4,'Los Angeles',2);
	 INSERT INTO warehouses(code,location,capacity) values(5,'San Francisco',8);
	 
	 INSERT INTO boxes(code,contents,value,warehouse) values('0MN7','Rocks',180,3);
	 INSERT INTO boxes(code,contents,value,warehouse) values('4H8P','Rocks',250,1);
	 INSERT INTO boxes(code,contents,value,warehouse) values('4RT3','Scissors',190,4);
	 INSERT INTO boxes(code,contents,value,warehouse) values('7G3H','Rocks',200,1);
	 INSERT INTO boxes(code,contents,value,warehouse) values('8JN6','Papers',75,1);
	 INSERT INTO boxes(code,contents,value,warehouse) values('8Y6U','Papers',50,3);
	 INSERT INTO boxes(code,contents,value,warehouse) values('9J6F','Papers',175,2);
	 INSERT INTO boxes(code,contents,value,warehouse) values('LL08','Rocks',140,4);
	 INSERT INTO boxes(code,contents,value,warehouse) values('P0H6','Scissors',125,1);
	 INSERT INTO boxes(code,contents,value,warehouse) values('P2T6','Scissors',150,2);
	 INSERT INTO boxes(code,contents,value,warehouse) values('TU55','Papers',90,5);



	CREATE TABLE departments (
	  code INTEGER PRIMARY KEY,
	  name varchar(255) NOT NULL ,
	  budget decimal NOT NULL 
	);
	

	CREATE TABLE employees (
	  ssn INTEGER PRIMARY KEY,
	  name varchar(255) NOT NULL ,
	 lastname varchar(255) NOT NULL ,
	  department INTEGER NOT NULL , 
	  foreign key (department) references departments(code) 
	);
	

	INSERT INTO departments(code,name,budget) values(14,'IT',65000);
	INSERT INTO departments(code,name,budget) values(37,'Accounting',15000);
	INSERT INTO departments(code,name,budget) values(59,'Human Resources',240000);
	INSERT INTO departments(code,name,budget) values(77,'Research',55000);
	

	INSERT INTO employees(ssn,name,Lastname,department) values('123234877','Michael','Rogers',14);
	INSERT INTO employees(ssn,name,Lastname,department) values('152934485','Anand','Manikutty',14);
	INSERT INTO employees(ssn,name,Lastname,department) values('222364883','Carol','Smith',37);
	INSERT INTO employees(ssn,name,Lastname,department) values('326587417','Joe','Stevens',37);
	INSERT INTO employees(ssn,name,Lastname,department) values('332154719','Mary-Anne','Foster',14);
	INSERT INTO employees(ssn,name,Lastname,department) values('332569843','George','ODonnell',77);
	INSERT INTO employees(ssn,name,Lastname,department) values('546523478','John','Doe',59);
	INSERT INTO employees(ssn,name,Lastname,department) values('631231482','David','Smith',77);
	INSERT INTO employees(ssn,name,Lastname,department) values('654873219','Zacary','Efron',59);
	INSERT INTO employees(ssn,name,Lastname,department) values('745685214','Eric','Goldsmith',59);
	INSERT INTO employees(ssn,name,Lastname,department) values('845657245','Elizabeth','Doe',14);
	INSERT INTO employees(ssn,name,Lastname,department) values('845657246','Kumar','Swamy',14);

