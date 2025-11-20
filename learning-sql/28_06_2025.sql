/*

Transaction Control Language
----------------------------

commit
Rollaback
Save point

Syntaxt:



disable auto commit - to use commit

Transaction -sequence of steps

ACID Transactional Properties (RDBM)
A - Atomicity

	- ALl the step in your trancation should be successful, if any step fails all changes should be rollbacked, 
    save changes using commit, rollback to revert.
C - Consistency

	- After the transaction both the state should be consistent, otherwise inconsistency
I - Isolation

	- While booking train ticket, no one will get same ticket, even cuncurrently request million requst it should happen
    sequentially, one user not effetct another user. every user is isolated with onother user

D - Durability
	
    - How long your service sustain, if any accident happen, serer is going down. evry month take backup.
    all the data should be there in any case.

BASE Transaction Properties (NO SQL)
 Basical Available Sequece 


commit will save transaction to the databse permanently,
----------------
syntax:

set autommit = 0;
savepoint s1;
release savepoint s2; savepoint s3 also get's release since it is between rollback and s2

once sapoint is release we can't release it again
----------------
select
update
insert
delete
commit - saves all the change to db permanently
insert
insert
rollback - to last commit
---inser
---inser
save point - like bookmark
insert
insert
rollback - to last save point

To Release save point, use RELEASE



LOCKS
------

1. Table level lock - locks entire Table
	- Shared locks - Read lock
		- Consider user A and B, now A user has acquire READ locks on Table T, but he cann't overrite, 
        all the DML operations not allowed, user B can accquire READ locks or need not aquire read locks to read the contents.
        Ehen one user has read lock, other user or itself can't update table.
    - and Exclusive locks - Write lock
		- A is going to get the WRITE logs, only A can read and write to the TABLE T.
        - while updating something, no one allowed to read the table content
    
2. Row level locks - only certain columsn will be locked
3. Column levele locks - certail columns will be locked



Syntax

UNLOCK TABLES;
lock table cust1 read;
lock table cust1 write;
*/

/*
Isolation - is very important when there is a cuncurrency-banking, ecommerce
	- should handle sequentially
    READ UNCOMMITTED - least isolation level - heavy reading
    READ COMMITTED
    REPEATABLE READ - default isolation level
    SERIALIZABLE - flight booking - very costly - heavy writing
    
    - at every isolation level eeach anmaly will be reduced
    
SET TRANSACTION - change the isolation level using this.

DIRTYA READ - user is able to read the un commited changes
NON REPEATEABLE READS - before the commit the user not able to read.
					 - NON repeating value - try to reads many times until user commits data
                     
PANTAM READ - No issue of DIRTY READ and NON REPEATABLE READS, 
			- issue when trying the group of query or range query - invisible READS
            - when thread1 reading count(counter) -> 50 2nd time count(counter) -> 100, values are changed 
            when thread2 inserted some rows
            - happens on range query
		
            
*/

/*
View
--------------

- is a virtual table - does not exists
- physically does not stroe any data, on demand excecuted and fetch the data
- not occupy any data
- it's a empty object
- extract the data from other table and give the result

Create View
-------------
Create view v1 as (select * from any_table)
drop view v1,v2

we can drop many views name at a time, but table can drop one only

alter view:
-----------------
alter view v1 as (select * from any_table) - simple view
- complex view, join multiple table
- subquery - inline
- horizontal view, all the columns but few rows
- vertical views
- group view - when it as group by clause
- Joined view - when query as join
- drop view 
- views not updatable when they are
- aggregate fun
- discys
- group by
- having
- unon or union allcountries
- subquery
- certain joins
*/

select @@autocommit;


use new1;