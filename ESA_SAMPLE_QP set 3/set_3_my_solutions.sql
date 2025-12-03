select * from boxes;
select * from departments;
select * from employees;
select * from warehouses;

-- 3a
select b.code, w.location from boxes b
join warehouses w on b.warehouse = w.code;

-- 3b
select w.code, (select count(*) from boxes b where b.warehouse = w.code) from warehouses w;

SELECT w.code, COUNT(b.code) AS num_boxes
FROM warehouses w
LEFT JOIN boxes b ON w.code = b.warehouse
GROUP BY w.code;

-- 3c
select w.code from warehouses w 
where w.capacity < (select count(*) as box_cap from boxes b where b.warehouse = w.code);

SELECT w.code, COUNT(b.code) AS num_boxes, w.capacity
FROM warehouses w
JOIN boxes b ON w.code = b.warehouse
GROUP BY w.code
having num_boxes > w.capacity;

SELECT w.code, w.capacity, COUNT(b.code)
FROM warehouses w
JOIN boxes b ON w.code = b.warehouse
GROUP BY w.code, w.capacity
HAVING COUNT(b.code) > w.capacity;


-- 3d
select b.code from boxes b
join warehouses w on w.code = b.warehouse
where w.location = 'Chicago';

SELECT code
FROM boxes
WHERE warehouse IN (
    SELECT code FROM warehouses WHERE location = 'Chicago'
);


-- 3e
select e.*, d.name as department_name from employees e
LEFT JOIN departments d on d.code = e.department;

-- 3f
select e.name, e.lastname, d.name, d.budget from employees e
JOIN departments d on d.code = e.department;

-- 3g
select e.name, e.lastname from employees e
JOIN departments d on d.code = e.department
where d.budget > 60000;

-- 3h
select d.name from departments d
where (select count(*) from employees e where e.department = d.code) > 2;

SELECT name
FROM departments
WHERE code IN (
    SELECT department
    FROM employees
    GROUP BY department
    HAVING COUNT(*) > 2
);

-- 3i
select * from employees e
where e.department in (select code from departments d1 where d1.code not in (select code from departments d order by d.budget asc limit 1) order by d1.budget asc limit 1);

select * from employees e where e.department in ( select d4.code from departments d4 where d4.budget = (select min(d3.budget) from departments d3 where d3.code in (select d2.code from departments d2 where d2.code not in ( select code from departments d where d.budget = (select min(d1.budget) from departments d1)))));

SELECT e.name, e.lastname
FROM employees e
JOIN departments d ON e.department = d.code
WHERE d.budget = (
    SELECT DISTINCT budget
    FROM departments
    ORDER BY budget ASC
    LIMIT 1 OFFSET 1
);

-- 3j
select * from employees e where e.department = (select code from departments order by budget asc limit 1 offset 1);

select e.department, count(*) as number_of_emp from employees e
group by e.department;

select e.department, d.name, count(*) as number_of_emp from employees e
left join departments d on d.code = e.department
group by e.department;


-- 4a
select * from customer;
select * from track;
select * from artist;
select * from invoice;


select c1.firstname from customer c1 where c1.firstname in (select c2.firstname from customer c2 where c1.customerid != c2.customerid);

select * from customer where firstname = 'Mark';

SELECT c1.customerid, c1.firstname, c2.customerid, c2.firstname
FROM customer c1
JOIN customer c2 ON c1.firstname = c2.firstname AND c1.customerid <> c2.customerid;

select c.firstname, c.customerid, i.invoicedate from customer c
JOIN invoice i on i.customerid = c.customerid order by c.firstname asc;

select customerid, count(*), invoicedate from invoice group by customerid;

-- 4b
SELECT c.customerid, c.firstname, i.invoicedate,
       LAG(i.invoicedate) OVER (PARTITION BY c.customerid ORDER BY i.invoicedate) AS prev_invoice
FROM customer c
JOIN invoice i ON c.customerid = i.customerid;

select i.customerid, i.invoicedate, LAG(i.invoicedate) OVER (PARTITION BY i.customerid order by i.invoicedate) as previous_invoice_date;

-- 4c
select * from track;
select * from genre;


select g.genreid, g.name, count(*) as total_tracks  from track t 
join genre g on g.genreid = t.genreid
where t.unitprice > 0.9 and g.name like 's%'
group by g.genreid;

SELECT g.name, COUNT(t.trackid) AS total_tracks
FROM track t
JOIN genre g ON t.genreid = g.genreid
WHERE t.unitprice > 0.9 AND g.name LIKE 's%'
GROUP BY g.name;

-- 4d
select * from track;
select * from invoiceline;
select * from invoice;

select i.customerid, count(DISTINCT t.albumid) as unique_albums, RANK() OVER (ORDER BY count(distinct t.albumid) desc) AS rank_customers from invoice i
join invoiceline il on il.invoiceid = i.invoiceid
join track t on t.trackid = il.trackid
group by i.customerid;

SELECT c.customerid, c.firstname, COUNT(DISTINCT t.albumid) AS unique_albums,
       DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT t.albumid) DESC) AS rank_customers
FROM customer c
JOIN invoice i ON c.customerid = i.customerid
JOIN invoiceline il ON i.invoiceid = il.invoiceid
JOIN track t ON il.trackid = t.trackid
GROUP BY c.customerid, c.firstname;

-- 4e

-- 4f

CREATE VIEW sample_view AS (
SELECT c.customerid, i.billingcity, c.city AS customer_city,
       COUNT(DISTINCT t.albumid) AS albums_billed
FROM customer c
JOIN invoice i ON c.customerid = i.customerid
JOIN invoiceline il ON i.invoiceid = il.invoiceid
JOIN track t ON il.trackid = t.trackid
GROUP BY c.customerid, i.invoiceid, i.billingcity, c.city);