-- SECTION B: 40 MARKS
use hospital;


#Using the hospital database, answer the following questions:

#3a. From the world_happiness_report table, identify the country where the perception of corruption 
#was the lowest in the most recent year available. (3 marks)


#3b.  List the top 5 countries with the highest social support scores for every year. 
# Arrange the data in ascending order of year.(5 Marks)


#3c.  Identify countries where the freedom to make life choices was greater than 0.8 for both 2019 and 2020. (5 Marks)


#3d.   Calculate the yearly average of Negative_Affect across all countries and arrange the data from lowest to highest. (3 Marks)


#3e.  Retrieve the country with the highest Healthy_life_expectancy_at_birth and its corresponding value. (4 Marks)


#3f.  Compute a rolling average of Positive_affect for each country using a 3-year moving window. (5 Marks)


#3g.  Write a subquery to find the lowest Social_support value in the most recent year and identify the corresponding country. (5 Marks)



#3h. Generate a report to list healthcare providers with the highest number of discharges, 
#including the average charges and payments per provider, sorted in descending order. (5 Marks)


#3i. Generate a report displaying the insurance coverage ratio for all healthcare providers, arranged from lowest to highest. 
#The insurance coverage ratio is calculated as Average_Covered_Charges / (Average_Total_Payments + Average_Medicare_Payments). (5 Marks)


-- SECTION C – 40 MARKS
-- Use sales schema for answering questions 4a to 4f
 use sales;
 #4a.	Write a Query to display the customers who have similar first name. (8 marks) (USE TABLE: customer) 


#4b. Write a Query to find the customer id, invoice date and previous invoice dates for every customer. (5 marks) (USE TABLES: invoice) 


#4c.Write a Query to find the total tracks for each genre, which has unit price more than 0.9 and genre name starts with ‘s’. (5 marks) (USE TABLES: track, genre) 



#4d. Write a query to rank customers based on number of unique albums purchased by them in the lifetime. (8 Marks) (USE TABLES: track, invoiceline, invoice) 



#4e. Write a Query to get the details of total number of tracks billed per composer. Sort the result in the descending order of the total tracks billed. (Use Tables: track , invoiceline) (6 marks).



#4f. Write a query to create a virtual table to display the details like customerid, billing city and customer city 
# and the number of albums billed in each order placed(invoice raised). (8 Marks) (USE TABLES: track, invoiceline, invoice, customer).

