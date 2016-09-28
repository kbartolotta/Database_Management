/*
Katie Bartolotta
CMPT 308N 114
Lab 4
*/
--1. 
SELECT city
FROM agents
WHERE aid in (Select aid
		from orders
		where cid ='c006'
		);

--2. 		
select pid
from orders
where aid in (select aid
		from orders
		where cid in (select cid
				from customers
				where city = 'Kyoto'
			)
		)
order by pid desc;

--3.
select cid, name
from customers
where cid in (select cid
		from orders
		where aid in (select aid
				from orders
				where aid != 'a03'
			)
	);

--4.
select cid
from customers
where cid in (select cid
		from orders
		where pid in (select pid
				from orders
				where pid = 'p01'
					and pid = 'p07'
			)
	);

--5.
select pid
from orders
where cid not in (select cid
			from orders
			where aid in (select aid
					from orders
					where aid = 'a08'
				)
		)
order by pid Desc;


--6.
select name, discount, city
from customers
where cid in (select cid
		from orders
		where aid in (select aid
				from agents
				where city = 'Dallas'
					or city = 'New York'
			)
	);

--7.
select cid, name
from customers
Where discount in (select discount
			from customers
			where city = 'Dallas'
				or city = 'London'
		);

/* 
8.
Check constraints specify requirements for the output row. These constraints limit the values that are accepted by one 
or more columns by enforcing data integrity. An example of a good check constraint is if the salary of employees ranges 
from $10,000 to $20,000, but you only want to see the salaries that range from $15,000 to %16,000. The check constraint 
that would be written for this is: salary >= 15000 AND salary <= 16000. It is possible to have multiple constraints for 
one column or apply one constraint to multiple columns. This means that multiple conditions can be checked in one location.
A misuse of check constraints is if someone were to create a check constraint on a column that is in another table. This 
is not possible in SQL as only columns in the table where the check constraint was defined can be referred to.
*/