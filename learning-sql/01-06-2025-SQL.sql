-- Joins and SubQueries

-- fetch tables from multiple tables

-- Types

-- Inner - Common rows (keyword JOIN or INNER JOIN)
-- Right join -- common rows and unmatched wors from right table
-- Left join -- common rows and unmatched wors from left table
-- Natural Join -- allow system to think which is the commom column to be used on 'ON', it can be single or multiple column, 
    -- first match with common name and then check for datatype (Internally it is INNER join)
-- Self -- join withiin same table
-- Cross Join (carditio Product m x n) not with common column

-- Joins will work only with common column 
-- Joins works faster than Sub Query because it uses indexing or primary key


-- Set operations
-- Union - no duplicates - 
-- (queryA) UNION (queryB)
-- same number of column and datatype must match from both query
-- Union ALL

-- intersection
-- difference
