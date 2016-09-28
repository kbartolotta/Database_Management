/*
Katie Bartolotta
CMPT 308N 114
Lab 4
*/
--1. 
SELECT city
FROM agents
WHERE aid IN (SELECT aid
		FROM orders
		WHERE cid ='c006'
		);

--2. 		
SELECT pid
FROM orders
WHERE aid IN (SELECT aid
		FROM orders
		WHERE cid IN (SELECT cid
				FROM customers
				WHERE city = 'Kyoto'
			)
		)
ORDER BY pid DESC;

--3.
SELECT cid, name
FROM customers
WHERE cid IN (SELECT cid
		FROM orders
		WHERE aid IN (SELECT aid
				FROM orders
				WHERE aid != 'a03'
			)
	);

--4.
SELECT cid
FROM customers
WHERE cid IN (SELECT cid
		FROM orders
		WHERE pid IN (SELECT pid
				FROM orders
				WHERE pid = 'p01'
					AND pid = 'p07'
			)
	);

--5.
SELECT pid
FROM orders
WHERE cid NOT IN (SELECT cid
			FROM orders
			WHERE aid IN (SELECT aid
					FROM orders
					WHERE aid = 'a08'
				)
		)
ORDER BY pid DESC;


--6.
SELECT name, discount, city
FROM customers
WHERE cid IN (SELECT cid
		FROM orders
		WHERE aid IN (SELECT aid
				FROM agents
				WHERE city = 'Dallas'
					OR city = 'New York'
			)
	);

--7.
SELECT cid, name
FROM customers
WHERE discount IN (SELECT discount
			FROM customers
			WHERE city = 'Dallas'
				OR city = 'London'
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
