--Faith Matthew
--Lab 4
--2/12/17
--1)Get	the	cities	of	agents	bookingg	an	order	for	a	customer	whose	cid	is	'c006'.	
SELECT city 
FROM Agents
WHERE aid IN 
		(SELECT aid
         FROM orders
         WHERE cid= 'c006');
--2)Get	the	distinct	ids	of	products	ordered	through	any	agent	who	takes	at	least	one	order	FROM	a	customer	IN	Kyoto,	sorted	by	pid	FROM	highest	to	lowest.	(This	is	not	the	same	as	askINg	for	ids	of	products	ordered	by	customers	IN	Kyoto.)
SELECT DISTINCT pid
FROM Orders
WHERE aid IN
			(SELECT aid
             FROM Orders
             WHERE cid IN 
							(SELECT cid
                             FROM Customers
                             WHERE city = 'Kyoto'))
ORDER BY pid DESC;

--3) Get	the	ids	and	names	of	customers	who	did	not	place	an	order	through	agent	a01.
Select cid, name
FROM Customers
WHERE cid NOT IN
				(Select pid
				FROM Orders
				WHERE aid!='a01');

	
--4)Get	the	ids	of	customers	who	ordered	both	product	p01	and	p07.	
SELECT cid
FROM Orders
WHERE pid = 'p07'
AND cid IN 
		(SELECT cid
         FROM orders
         WHERE pid = 'p01');
		 
--5) Get	the	ids	of	products	not	ordered	by	any	customers	who	placed	any	order	through	agent	a08	IN	pid	order	FROM	highest	to	lowest.			 
Select pid
FROM products
WHERE pid NOT IN
				(SELECT pid
				FROM Orders
				WHERE aid='a08')
ORDER BY pid DESC;
		
		
--6)Get	the	name,	discount,	and	city	for	all	customers	who	place	orders	through	agents	IN	Tokyo	or	New	York.
	SELECT name, discount, city
FROM Customers
WHERE cid IN
			(SELECT cid 
             FROM Orders
             WHERE aid IN
             			(SELECT aid
                         FROM Agents
                         WHERE city ='New York'
                         OR city= 'Tokyo'));
--7) Get	all	customers	who	have	the	same	discount	as	that	of	any	customers	IN	Duluth	or	London
SELECT name, discount
FROM Customers
WHERE discount IN
			(SELECT discount
             FROM Customers
             WHERE city = 'Duluth'
             OR city  ='London');



						 
-- 8. Tell	me	about	check	constraints:	What	are	they?	What	are	they	good	for?	What’s	the	
--advantage	of	putting	that	sort	of	thing	inside	the	database?	Make	up	some	examples	
--of	good	uses	of	check	constraints	and	some	examples	of	bad	uses	of	check	constraints.	
--Explain	the	differences	in	your	examples	and	argue	your	case.

--Check constraints are used to limit the range of a value in a column. They're good for enforcing integrity by limiting the values taken by a column. An example of a good check constraint is making the range of salary 9.00 to 100,000.00. This way, you can't accidently enter a number below the minimum or above the maximum. This is okay because any amount of people can have the same salary. An example of a bad contraint is having Id numbers range from 1-10, limiting the amount of entries in the table since it shouls be a one to one relationship.