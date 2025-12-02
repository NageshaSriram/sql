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


