select * from clients;
select * from resources;
select * from projects;

-- 3a
select r.Employee_name, (select r1.Employee_name from resources r1 where r1.Employee_id = r.Manager_id) as Manager_Name, p.Project_name, c.Client_name
from resources r
join projects p on p.Employee_id = r.Employee_id
join clients c on c.Client_id = p.Client_id;

-- 3b

select *
from clients c 
where c.Client_id NOT IN (select p.Client_id from projects p);

-- 3c
select * from Orders order by visited_at desc;
select * from Sessions_website order by visited_at desc;
select count(distinct session_id) from Orders;

SELECT COUNT(DISTINCT s.session_id) AS sessions,
COUNT(DISTINCT o.order_id) AS orders,
(COUNT(DISTINCT o.order_id)*100.0 / COUNT(DISTINCT
s.session_id)) AS conversion_rate
FROM sessions_website s
LEFT JOIN orders o ON s.session_id = o.session_id
WHERE s.visited_at <= '2020-08-24'
AND s.source_UTM IN ('gsearch','nonbrand');

SELECT MONTH(visited_at) AS month_start,
SUM(CASE WHEN source_UTM='gsearch' AND
device_type='desktop' THEN 1 ELSE 0 END) AS g_dtop_sessions,
SUM(CASE WHEN source_UTM='bsearch' AND
device_type='desktop' THEN 1 ELSE 0 END) AS b_dtop_sessions,
(SUM(CASE WHEN source_UTM='bsearch' AND
device_type='desktop' THEN 1 ELSE 0 END) *1.0 /
NULLIF(SUM(CASE WHEN source_UTM='gsearch' AND
device_type='desktop' THEN 1 ELSE 0 END),0)) AS b_pct_of_g_dtop,
SUM(CASE WHEN source_UTM='gsearch' AND
device_type='mobile' THEN 1 ELSE 0 END) AS g_mob_sessions,
SUM(CASE WHEN source_UTM='bsearch' AND
device_type='mobile' THEN 1 ELSE 0 END) AS b_mob_sessions,
(SUM(CASE WHEN source_UTM='bsearch' AND
device_type='mobile' THEN 1 ELSE 0 END) *1.0 /
NULLIF(SUM(CASE WHEN source_UTM='gsearch' AND
device_type='mobile' THEN 1 ELSE 0 END),0)) AS b_pct_of_g_mob
FROM sessions_website
WHERE visited_at BETWEEN '2012-08-01' AND '2012-12-22'
GROUP BY MONTH(visited_at);

select DATE_TRUNC('month', visited_at) AS month_start from sessions_website;

select * from catalogue;
select * from products;

select c.Catalogue_Entry_Description, Product_Price, (Product_Price - Product_Price * 0.05) as DiscountedPrice from products p
 join catalogue c on c.Catalogue_Entry_id = p.Catalogue_Entry_id;
 
 select c.Catalogue_Entry_Description, Product_Price, (Product_Price - Product_Price * 0.05) as DiscountedPrice from catalogue c
 right join products p on c.Catalogue_Entry_id = p.Catalogue_Entry_id
 where c.Parent_Catalogue_Entry_id in ('MA', 'WA', 'A');
 
 select c.Catalogue_Entry_id, avg() from catalogue c left join products p on p.Catalogue_Entry_id = c.Catalogue_Entry_id
 group by p.Catalogue_Entry_id;
 
 select p.Catalogue_Entry_id, avg(p.Product_Price) as avg_price from products p group by p.Catalogue_Entry_id having avg_price > 1000;
 
 select p.Catalogue_Entry_id, count(*) from products p group by p.Catalogue_Entry_id;
 
 select c.Catalogue_Entry_Description, (select cl.Catalogue_Entry_Description from catalogue cl where cl.Catalogue_Entry_id = c.Parent_Catalogue_Entry_id) as Sub_Prod_Desc from catalogue c
 where c.Parent_Catalogue_Entry_id is not null AND c.Parent_Catalogue_Entry_id not in ('A', 'C');
 
 SELECT c1.catalogue_entry_description AS prod_desc,
c2.catalogue_entry_description AS main_prod_desc,
c3.catalogue_entry_description AS parent_prod_desc
FROM catalogue c1
LEFT JOIN catalogue c2 ON c1.parent_catalogue_entry_id =
c2.catalogue_entry_id
LEFT JOIN catalogue c3 ON c2.parent_catalogue_entry_id =
c3.catalogue_entry_id
where c1.Parent_Catalogue_Entry_id is not null AND c1.Parent_Catalogue_Entry_id not in ('A', 'C');