--Faith Matthew
--Lab 5
--2/19/17

--1. Show	the	cities	of	agents	booking	an	order	for	a	customer	whose	id	is	'c006'.	Use	joins this	time;	no	subqueries.	

select city
From agents INNER JOIN orders ON agents.aid = orders.aid
WHERE orders.cid ='c006';


--2.Show	the	ids	of	products	ordered	through	any	agent	who	makes	at	least	one	order	for	
--a	customer	in	Kyoto,	sorted	by	pid	from	highest	to	lowest.	Use	joins;	no	subqueries.	

SELECT DISTINCT orders.pid
FROM orders INNER JOIN customers ON orders.cid=customers.cid
			INNER JOIN products ON orders.pid=products.pid
WHERE customers.city='Kyoto'
ORDER BY orders.pid DESC;


--3.Show	the	names	of	customers	who	have	never	placed	an	order.	Use	a	subquery.	

SELECT name
FROM customers
WHERE cid not in
			(SELECT cid
             FROM orders
             WHERE cid is not NULL
            );
--4.Show	the	names	of	customers	who	have	never	placed	an	order.	Use	an	outer	join.				

SELECT customers.name
FROM customers FULL OUTER JOIN orders on customers.cid=orders.cid
Where orders.cid is NULL;			
			
			
			
--5. Show the names of customers who placed at least one order through an agent in their own city, along with those agent(s') names.

SELECT customers.name, agents.name
FROM orders INNER JOIN customers on customers.cid=orders.cid
			INNER JOIN agents on agents.aid=orders.aid
WHERE agents.city=customers.city;  

--6. Show	the	names	of	customers	and	agents	living	in	the	same	city,	along	with	the	name	of	the	shared	city,	regardless	of	whether	or	not	the	customer	has	ever	placed	an	order	with	that	agent.

SELECT customers.name, agents.name, customers.city
FROM customers INNER JOIN  agents on customers.city=agents.city
WHERE agents.city=customers.city;

--7. Show	the	name	and	city	of	customers	who	live	in	the	city	that	makes	the	fewest different	kinds	of	products.	(Hint:	Use	count	and	group	by	on	the	Products	table.)

SELECT name, city
	FROM customers
	WHERE city in(
					SELECT city
					FROM products 
					GROUP BY city
					ORDER BY count(pid)
					LIMIT 1);