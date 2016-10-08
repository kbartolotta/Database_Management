/*
Katie Bartolotta
CMPT 308N 114
10/7/16
*/

--1.
select name, city
from customers 
where city in (select city
		from products 
		group by city
		order by count(city) desc
		limit 1
		);


--2.
select name
from products
where priceUSD < (select avg(priceUSD)
			from products
		)
order by name desc;

--3.
select c.name, pid, totalUSD
From customers c inner join orders o on c.cid = o.cid

order by totalUSD;

--4.
select name, coalesce(sum(qty),0) as total_ordered
from customers c left outer join orders o on c.cid = o.cid
group by name, city

order by name;

--5. 
select c.name, p.name, a.name
from customers c, products p, agents a
where (cid, pid, aid) in (select cid, pid, aid
				from orders
				where aid in (select aid
						from agents
						where city = 'New York'
						)
			);

--6.
select o.totalUSD, o.qty, p.priceUSD, c.discount, coalesce (o.qty * p.priceUSD * (1 - (c.discount/100))) as actual_total
from orders o inner join customers c on o.cid = c.cid
		inner join products p on o.pid = p.pid
					and o.totalUSD != (o.qty * p.priceUSD * (1 - (c.discount/100)));
					
/*
7.
Outer joins compare two tables and return data when a match is available or return a NULL value when there are no matches. 
This will duplicate rows in one table when it matches multiple records in the other table. Most of the time, when compared 
to inner joins, the result sets will be larger with outer joins. Outer joins won't remove any records from the set on their 
own. The user has to tell the outer join when to add the NULL values. A left outer join means keep all the records from the 
first table no matter what and insert NULL values when the second table doesn't match. Right outer join means to keep all the 
records from the second table no matter what and insert NULL values when the first table doesn't match. 

-Left Outer Join
SELECT name
FROM customers c LEFT OUTER JOIN agents a ON c.city = a.city
WHERE a.city IS NULL;

-Right Outer Join
SELECT name
FROM customers c RIGHT OUTER JOIN orders o ON c.cid = o.cid
WHERE c.cid IS NULL;

*/