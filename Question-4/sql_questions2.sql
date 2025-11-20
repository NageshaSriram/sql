
-- SECTION B – 40 MARKS
-- Use warehouse_employees schema for answering questions 3a to 3j
use warehouse_employees;
-- 3a.Write a Query to Select the code of each box, along with the name of the city the box is located in.(4 Marks)


-- 3b.Write a Query to Select the warehouse codes, along with the number of boxes in each warehouse.(4 Marks)


-- 3c.Write a Query to Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger
 -- than the warehouse 's capacity).(4 Marks)


-- 3d.Write a Query to  Select the codes of all the boxes located in Chicago.(Use Subquery)(4 Marks)


-- 3e. Write a Query to Select all the data of employees, including each employee's department's data.(4 Marks)
	
    
-- 3f.Write a Query to Select the name and last name of each employee, along with the name and budget of the employee's department.(4 Marks)

    
-- 3g. Write a Query to Select the name and last name of employees working for departments with a budget greater than $60,000.(4 Marks)


-- 3h. Write a Query to Select the names of departments with more than two employees (use subquery) (4 Marks)

	
-- 3i.Write a Query to Select the name and last name of employees working for departments with second lowest budget.(4 Marks)
	

	
-- 3j.Write a Query to Select the number of employees in each department (you only need to show the department code and the number of employees).(4 Marks)
	


-- SECTION C – 40 MARKS
-- Use sales schema for answering questions 4a to 4f
 use sales;
 #4a.	Write a Query to display the customers who have similar first name. (8 marks) (USE TABLES: track, artist, customer) 



#4b.	Write a Query to find the customer name, invoice date and previous invoice dates for every customer. (5 marks) (USE TABLES: invoice) 

 


#4c.Write a Query to find the total tracks for each genre, which has unit price more than 0.9 and genre name starts with ‘s’. (5 marks) (USE TABLES: track, genre) 




#4d.Consumer behaviour analysis is the study of how people make purchase decisions with regard to a product, service or organisation. 
-- And a Quantitative analysis is to be performed to understand the number of unique items bought by customer. Using the Media database, 
-- write a query to rank customers based on number of unique albums purchased by them in the lifetime. (8 Marks) (USE TABLES: track, invoiceline, invoice) 




#4e.	The popularity of Music, irrespective of the quality of the song or the talent involved in composing and playing it, it is nearly impossible to know what makes a song popular. 
-- As a musician, people have always been curious about what really makes a song likeable to the masses. To analyse this, the data about the number of tracks billed per composer is needed (invoice raised). 
--  Write a Query to get the details of total number of tracks billed per composer. Sort the result in the descending order of the total tracks billed. (Use Tables: track , invoiceline) (6 marks).



#4f.Consumer behaviour analysis is the study of how people make purchase decisions with regard to a product, service or organisation. And a Quantitative analysis is to be performed to understand the number of items bought by customers in every order.
--  Using the Media database, write a query to Create a virtual table to display the details like customerid, billing city and customer city and the number of albums billed in each order placed(invoice raised). (8 Marks) (USE TABLES: track, invoiceline, invoice, customer).


