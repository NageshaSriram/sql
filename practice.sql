select concat_ws(", ","Hello", "Hi") as ca;

select LOWER("Nagesh");
select UPPER("Nagesh");
select substring_index(substring_index("Hello Hi mu hu", " ", 4), " ", -1);

select * from orders;

WITH total_sales AS (
	select Segment, SUM(Sales) as total_sales
    from orders group by Segment
),
avg_sales AS(
	select AVG(Sales) as avg_sales
    from orders
)
Select Segment, ts.total_sales from total_sales ts cross join avg_sales as avg_a
where ts.total_sales > avg_a.avg_sales;

select AVG(Discount) as avg_disc, month(Order_Date) from orders group by month(Order_Date) order by avg_disc desc limit 1;

select Product_ID, month(Order_Date), sum(Sales) as monthly_sales, avg(sum(Sales)) OVER (partition by Product_ID order by month(Order_Date) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
as avg_sales from orders  group by PRODUCT_ID, month(Order_Date) order by Product_ID, month(Order_Date);

select c1.Category, c1.best_sales from 
(select Category, SUM(Sales) as best_sales, SUM(Profit) best_profit from orders group by Category) as c1
order by c1.best_sales desc limit 1;

WITH categores AS (
	select Category, SUM(Sales) as best_sales, SUM(Profit) best_profit from orders group by Category
),
best_sales AS (
	select Category, best_sales from categores order by best_sales desc limit 1
),
best_profit AS (
	select Category, best_profit from categores order by best_profit desc limit 1
)
select *
from best_sales
cross join best_profit;


select DISTINCT(Category) from orders;

select month(Order_Date), SUM(Profit) as total_profit from orders group by month(Order_Date) order by total_profit desc limit 5;

select * from orders;

select Country_Region, COUNT(Quantity) as total_product from orders group by Country_Region order by total_product desc limit 1;


select * from customer;

select customerid, firstname from customer c where EXISTS (select 1 from customer c1 where c1.customerid <> c.customerid and c1.firstname = c.firstname) order by c.firstname;

select c.customerid, c.firstname from customer c
JOIN customer c1 ON c1.firstname = c.firstname and c1.customerid <> c.customerid;

select customerid, invoicedate,LAG(invoicedate) OVER (PARTITION BY customerid order by invoicedate) as previous_invoice_date from invoice order by customerid,invoicedate; 
select * from customer where firstname like 'Mark';

select g.genreid,g.name, count(*) as total_track from genre g 
JOIN track t on g.genreid = t.genreid
where t.unitprice > 0.9 and g.name like 's%'
group by g.genreid;


select i.customerid, count(DISTINCT a.albumid), RANK() OVER
 (
 ORDER BY count(DISTINCT a.albumid) desc
) as total_album_rank from
invoice i 
join invoiceline il on il.invoiceid = i.invoiceid
join track t on t.trackid = il.trackid
join album a on a.albumid = t.albumid
group by i.customerid order by total_album_rank;

select i.customerid, count(DISTINCT a.albumid) as uni_alb, RANK() OVER
 (
 ORDER BY count(DISTINCT a.albumid) desc
) as total_album_rank from
invoice i 
join invoiceline il on il.invoiceid = i.invoiceid
join track t on t.trackid = il.trackid
join album a on a.albumid = t.albumid
group by i.customerid order by uni_alb desc;

select t.composer, count(*) as total_tracks from track t
join invoiceline il on il.trackid = t.trackid
where t.composer is not null
group by t.composer order by total_tracks desc;

-- create view cust_detail as
select c.customerid, c.city, i.billingcity, i.invoiceid,count(DISTINCT a.albumid) as num_albumn  from customer as c
join invoice i on i.customerid = c.customerid
join invoiceline il on il.invoiceid = i.invoiceid
join track t on t.trackid = il.trackid
join album a on a.albumid = t.albumid
group by i.invoiceid
order by num_albumn;

WITH album_counts AS
( select i.customerid,
		i.billingcity,
        c.city,
        i.invoiceid,
        count(DISTINCT t.albumid) as album_billed
  from invoice i 
  join customer c on i.customerid = c.customerid 
  join invoiceline il on i.invoiceid = il.invoiceid
  join track t on il.trackid = t.trackid
  group by i.customerid, i.billingcity, c.city, i.invoiceid
)
  
select customerid, billingcity, city, album_billed
from album_counts
order by album_billed;

select * from cust_detail;

select * from world_happiness_report;

WITH recent_year AS ( select Country_name, MAX(w.year) from world_happiness_report w)

select Country_name, w.year, w.Perceptions_of_corruption
 from world_happiness_report  w where w.year = (select MAX(w1.year) from world_happiness_report w1)
 order by w.Perceptions_of_corruption limit 1;
 
 select Country_name, Perceptions_of_corruption
 from world_happiness_report
 where Perceptions_of_corruption = (
	select min(Perceptions_of_corruption)
    from world_happiness_report where year = (select MAX(w1.year) from world_happiness_report w1)
 );

select w.year, w.Perceptions_of_corruption from world_happiness_report w where Perceptions_of_corruption = (select MAX(w1.Perceptions_of_corruption) from world_happiness_report w1 where w1.year = w.year)
order by w.year;

WITH most_per AS
(select w.year, MAX(Perceptions_of_corruption) as max_perc from world_happiness_report w group by w.year)
select m.year, Country_name, m.max_perc
from world_happiness_report w
join most_per m on m.year = w.year and m.max_perc = w.Perceptions_of_corruption;

select year, Country_name, Social_support
from (
	select year, Country_name, Social_support,
    ROW_NUMBER() OVER (PARTITION BY year order by Social_support desc) as rn
    from world_happiness_report
) as ranked
where rn <=5
order by year asc, Social_support desc;


select year, Country_name, MIN(Social_support) from world_happiness_report w
group by w.year, Country_name having MIN(Social_support) order by year;

select DISTINCT(Country_name), Freedom_to_make_life_choices, year from world_happiness_report where Freedom_to_make_life_choices > 0.8 and year in (2019, 2020);

select DISTINCT(w.Country_name), w.Freedom_to_make_life_choices, w.year from world_happiness_report w
JOIN world_happiness_report w1 on w1.Country_name = w.Country_name
Where w.Freedom_to_make_life_choices > 0.8 and w1.Freedom_to_make_life_choices > 0.8
and w1.year = 2019 and w.year = 2020;


select w.Country_name, year, Positive_affect, AVG(w.Positive_affect) OVER ( PARTITION BY w.Country_name ORDER BY year ROWS BETWEEN 2 PRECEDING and CURRENT ROW) as running_total from world_happiness_report w order by Country_name, year;

select (0.5509999999999999 + 0.5733333333333333 + 0.6043333333333333)/3;

select Provider_Name, (CAST(replace(Average_Covered_Charges, "$", "") AS DECIMAL(10, 2)) / CAST(replace(Average_Total_Payments, "$", "") AS DECIMAL(10, 2)) / CAST(replace(Average_Medicare_Payments, "$", "") AS DECIMAL(10, 2))) as coverrage_ratios from inpatient1;

select Provider_Name, (CAST(replace(Average_Covered_Charges, "$", "") AS DECIMAL(10, 2))) as coverrage_ratios from inpatient1;
select * from inpatient1;
select CAST(replace("$38083.54", "$", "") AS DECIMAL(10, 2));



select e.*, o.city from employees e
join offices o on o.officeCode = e.officeCode
where o.city = 'Paris';

select * from productlines; -- Classic Cars
select * from customers where country = 'USA';

select SUM(od.quantityOrdered * od.priceEach) from orderdetails od
JOIN products p on p.productCode = od.productCode
JOIN orders o on o.orderNumber = od.orderNumber
JOIN customers c on c.customerNumber = o.customerNumber
where p.productLine = 'Classic Cars' and c.country = 'USA';

select c.customerNumber, c.customerName, c.contactFirstName, c.contactLastName, SUM(p.amount) from customers c
LEFT join payments p on c.customerNumber = p.customerNumber
group by c.customerNumber, c.customerName, c.contactFirstName, c.contactLastName;


select * from customers c
LEFT join orders o on o.customerNumber = c.customerNumber
where o.orderNumber is null;

WITH cust_payment AS (
	Select c.customerNumber, c.customerName,
    SUM(p.amount) as tota_payments,
    ROW_NUMBER() OVER (ORDER BY SUM(p.amount) desc) rn
    from customers c
    join payments p on p.customerNumber = c.customerNumber
    group by c.customerNumber, c.customerName
)
select customerNumber, customerName, tota_payments
from cust_payment
where rn <=5;

select c.customerNumber, count(*) from customers c
join orders o on o.customerNumber = c.customerNumber
group by c.customerNumber
having count(*) > 5;

select p.productName, p.productScale, p.productDescription from products p where p.productLine = 'Motorcycles'
and p.productScale <> '1:18'
order by p.productScale, p.productName;

use house;

select * from bangalore_houses;

select location, ROUND(AVG(price), 2) as avg_price from bangalore_houses
group by location having AVG(price) > 100;

select location, count(*) as number_of_houses from bangalore_houses
where bath > 2 and total_sqft > 1500
group by location
having count(*) > 5;

select * from bangalore_houses h where h.price = (select MIN(h1.price) from bangalore_houses h1 WHERE h1.location=h.location);

select * from bangalore_houses h where h.price = (select MAX(h1.price) from bangalore_houses h1);

select location, AVG(price), DENSE_RANK() OVER (ORDER BY AVG(price) desc) from bangalore_houses
group by location;

WITH expensice_houses as (
	select *, ROW_NUMBER() OVER (PARTITION BY location order by price desc) as rn
    from bangalore_houses
)
select location, price
from expensice_houses
where rn<=3;
WITH top_ten AS (
select b.price from bangalore_houses b
where b.location = 'Whitefield'
order by b.price desc limit 10
)
select * from bangalore_houses b1
where b1.location = 'Whitefield' and b1.bath > 3 and b1.price in (select price from top_ten) order by b1.price desc;

WITH price_rank AS (
	select *, DENSE_RANK() OVER (PARTITION BY location ORDER BY price desc) as price_rank from bangalore_houses where location = 'Whitefield'
)
select * from price_rank
where location = 'Whitefield' and bath > 3 and price_rank <=10;

select count(*) from bangalore_houses where price > (select AVG(price) from bangalore_houses where location = 'Whitefield');

select *, CASE WHEN price > 100 THEN 'HIGH' WHEN price < 100 THEN 'LOW' END AS cat from bangalore_houses;

select replace('Hello', 'e', 'z');

select CASE WHEN LOCATE("World", "Hello World") > 0 THEN 'PRESENT' ELSE 'NOT PRESET' end as res;

select CASE WHEN '1e233' REGEXP '^[0-9]+$' THEN 'Integer' end as we;

select CAST('120.34545' as DECIMAL(10, 3)) + 1;
select CAST(123 as CHAR(4));
select CASE WHEN 101 % 2 = 0 THEN 'EVEN' ELSE 'ODD' end as even_odd;

select CONVERT('1001', DECIMAL) as str;

select b.code, w.location from boxes b left join warehouses w on b.warehouse = w.code;

select w.code, count(*) from warehouses w join boxes b on b.warehouse = w.code group by w.code;

select * from boxes where warehouse = 1;

select * from warehouses;
select * from boxes;
select w.code, count(b.code), w.capacity  from warehouses w join boxes b on b.warehouse = w.code group by w.code having count(b.code) > w.capacity;

select b.code from boxes b join warehouses w on w.code = b.warehouse where w.location = 'Chicago';

select b.code from boxes b where b.warehouse in (select code from warehouses where location = 'Chicago');

select e.*, d.* from employees e join departments d on e.department = d.code;

select e.name, e.lastname, d.name, d.budget from employees e join departments d on  d.code = e.department; 

select d.name as department_name, count(e.ssn) as employee_count  from departments d join employees e on e.department = d.code group by d.code having employee_count > 2;

select d.name from departments d where  (select count(*) from employees e where e.department = d.code) > 2;

select * from employees e where  e.department = (select code from departments order by budget limit 1 offset 1);

select d.code, count(e.ssn) as num_emps from departments d join employees e on d.code = e.department group by d.code;

select e.department, count(*) from employees e group by e.department;

select c.firstname from customer c join customer c1 on c1.firstname = c.firstname and c1.customerid <> c.customerid;

select c.firstname, c.lastname, i.invoicedate, LAG(i.invoicedate) OVER (partition by c.customerid order by i.invoicedate) from customer c join invoice i on i.customerid = c.customerid;

select g.name, count(t.trackid) as track_count from genre g join track t on t.genreid = g.genreid where t.unitprice > 0.9 and g.name like 's%' group by g.genreid;

select i.customerid, count(DISTINCT t.albumid) as total_alumbs, RANK() OVER (order by count(DISTINCT t.albumid) desc) purshace_albumn_rank from invoice i 
join invoiceline il on i.invoiceid = il.invoiceid
join track t on t.trackid = il.trackid
group by i.customerid
order by total_alumbs desc;

select t.composer, count(il.trackid) as total_tracks_billed from track t 
join invoiceline il on il.trackid = t.trackid
group by t.composer
order by total_tracks_billed desc;

create view alumb_billed_per_order as
select i.customerid, i.billingcity, c.city as customer_city, count(distinct t.albumid) as num_albumns_billed from invoice i
join customer c on c.customerid = i.customerid
join invoiceline il on il.invoiceid = i.invoiceid
join track t on t.trackid = il.trackid
group by i.customerid, i.invoiceid, i.billingcity, c.city;


