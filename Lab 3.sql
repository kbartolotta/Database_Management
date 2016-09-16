/*Katie Bartolotta
Lab 3
9/16/16*/

select ordnum, totalUSD
From orders;

Select name, city
from agents
where name = 'Smith';

select pid, name, priceUSD
from products
Where quantity > 201000;

select name, city
from customers
where city = 'Duluth';

select name
from agents
where city != 'New York' 
	AND city != 'Duluth';

select *
from products
where city != 'Dallas'
	AND city != 'Duluth'
	AND priceUSD >= 1;

select *
from orders
where mon = 'feb'
	OR mon = 'mar';

select *
from orders
where mon = 'feb'
	and totalUSD >= 600;

select *
from orders
where cid = 'C005';
