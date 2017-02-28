--1.Display	the	name	and	city	of	customers	who	live	in	any	city	that	makes	the	most different	kinds	of	products.	(There	are	two	cities	that	make	the	most	different	 products.	Return	the	name	and	city	of	customers	FROM	either	one	of	those.)	

SELECT name, city
FROM customers
WHERE city in
			(SELECT city
             FROM products
             GROUP BY products.city
             LIMIT 2);
			 
--2. Display	the	names	of	products	whose	priceUSD is	strictly	above	the	average	priceUSD,	in	reverse-alphabetical	order

SELECT name
FROM products
WHERE priceUSD >
			(SELECT AVG (priceUSD)as avgPrice
			 FROM products
             )
ORDER BY name DESC;

--3.Display	the	customer	name,	pid	ordered,	and	the	total	for	all	orders,	sorted	by	total	FROM	low	to	high.	

SELECT customers.name, products.pid, orders.totalUSD
FROM orders INNER JOIN  customers on customers.cid=orders.cid
			INNER JOIN products on products.pid=orders.pid
ORDER BY orders.totalUSD ASC;

--4.Display	all	customer	names	(in	alphabetical	order)	and	their	total	ordered,	and	nothing	more.	Use	coalesce	to	avoid	showing	NULLs.	

SELECT customers.name, COALESCE(SUM(orders.totalUSD), 0.00)
FROM  customers LEFT OUTER JOIN orders on customers.cid=orders.cid

GROUP BY customers.cid
ORDER BY name ASC;


--5.Display	the	names	of	all	customers	who	bought	products	FROM	agents	based	in	Newark	along	with	the	names	of	the	products	they	ordered,	and	the	names	of	the	agents	who	sold	it	to	them.	

SELECT customers.name, agents.name, products.name
From  orders FULL OUTER JOIN customers on customers.cid = orders.cid
				FULL OUTER JOIN agents ON agents.aid= orders.aid
                FULL OUTER JOIN products ON products.pid=orders.pid
WHERE agents.city ='Newark';

--6.Write	a	query	to	check	the	accuracy	of	the	totalUSD	column	in	the	Orders	table.	This means	calculating	Orders.totalUSD	FROM	data	in	other	tables	and	comparing	those values	to	the	values	in	Orders.totalUSD. Display	all	rows	in	Orders	WHERE Orders.totalUSD	is	incorrect,	if	any.	

SELECT orders.ordnumber,orders.totalUSD, (products.priceUSD * orders.qty) * (1- customers.discount/100)
FROM orders  LEFT OUTER JOIN customers on orders.cid = customers.cid
				  LEFT OUTER JOIN products on orders.pid = products.pid
WHERE totalUSD != (products.priceUSD * orders.qty) * (1- customers.discount/100)
GROUP BY ordnumber, customers.cid, products.pid ;
	
--7. What’s	the	difference	between	a	LEFT	OUTER	JOIN	and	a	RIGHT	OUTER	JOIN?	Give example	queries	in	SQL	to	demonstrate.	(Feel	free	to	use	the	CAP	database	to	make	 your	points	here.)

--A LEFT OUTER JOIN will return all rows from the left table and return any matching rows from the right table if there are any. A RIGHT OUTER JOIN will return all frows from the right table and return any matching rows from the left table if there any 

-- The LEFT OUTER JOIN below returns all customers in the customers table and any customers who placed an order but it also returns Weyland, the only customer who did not place an order
Select customers.name 
From customers Left OUTER JOIN orders on orders.cid=customers.cid

--This RIGHT OUTER JOIN returns all customers who placed an order AND are in the customers table. Therefore, if a customer did not place an order their name will not appear in this query 
Select customers.name
From customers RIGHT OUTER JOIN orders on orders.cid=customers.cid