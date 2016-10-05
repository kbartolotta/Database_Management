/*
Katie Bartolotta
CMPT 308N 114
Lab 5
10/1/16
*/

--1.
Select city
FROM agents a, orders o
WHERE a.aid = o.aid
	AND o.cid = 'c006';

--2.
SELECT distinct b.pid
FROM orders o full outer join orders b on o.aid = b.aid, customers c
WHERE c.cid = o.cid
	and c.city = 'Kyoto'
order by b.pid desc;

--3.
select name
from customers 
where cid not in (select cid
			from orders);

--4.
select name
from customers left outer join orders on customers.cid = orders.cid
where orders.cid is null;

--5.
select c.name, a.name
from customers c, agents a
where (c.cid, a.aid) in (select cid, aid
			from orders)
			and c.city = a.city;
--6.
select c.name, a.name, c.city
from customers c, agents a
where c.city = a.city;

--7.
select c.name, c.city
from customers c
where city in (select p.city
		from products p
		group by city
		having Count(city) in ((select min(Num) 
					from (select Count(city) as Num 
						from products p
						group by p.city)as a
					)
					)
		);