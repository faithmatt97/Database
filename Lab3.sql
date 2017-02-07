--Faith Matthew
--Lab 3
-- 2/6/2017


-- 1)List the ORder number AND total dollars of all ORders.

	SELECT ORdnumber, totalusd
	FROM Orders;
	
--2)List	the	name	AND	city	of	agents	named	Smith.
	SELECT ORdnumber, totalusd
	FROM Orders;
	
--3)List	the	id,	name,	AND	price	of	products	with	quantity	mORe	than	200,100.	
	SELECT pid, name, priceUSD
	FROM Products
	WHERE quantity> 200100;
	
--4)List	the	names	AND	cities	of	customers	in	Duluth
	SELECT name, city
	FROM Customers
	WHERE city= 'Duluth';
	
--5)List	the	names	of	agents	not	in	New	YORk	AND	not	in	Duluth.	
	SELECT name, city
	FROM Customers
	WHERE city= 'Duluth';
	
--6). List	all	data	fOR	products	in	neither	Dallas	nOR	Duluth	that	cost	US$1	OR	mORe.	
	SELECT *
	FROM Products
	WHERE city != 'Duluth'
	AND city != 'Dallas'
	AND priceUSD>=1;
	
--7)List	all	data	fOR	ORders	in	February	OR	May.	
	SELECT *
	FROM Orders
	WHERE month = 'May'
	OR month = 'Feb';
	
--8)List	all	data	fOR	ORders	in	February	of	US$600	OR	mORe.	
	SELECT *
	FROM Orders
	WHERE totalUSD >= 600
	AND month = 'Feb';
	
--9)List	all	ORders	FROM	the	customer	whose	cid	is	C005.
	SELECT *
	FROM Orders
	WHERE totalUSD >= 600
	AND month = 'Feb';
