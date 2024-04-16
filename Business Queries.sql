
-- we will like to reward our loyal and old customers. Customers with from id 1 to 5 were the oldest customers that made transaction
-- for our company, please list out the names of all customers with id 1 to 5

select customer_id 
from payment
where customer_id Between 1 AND 5


-- we opened our movie rental shop on the 24th of may 2005.
-- we wanna reward the customers that rented movie within 2 days 
-- please retrive the names,rental_date and email of those that rented movies within 2 days of opening

SELECT c.first_name, c.last_name, r.rental_date
FROM rental as r
INNER JOIN customer as c
ON r.customer_id=c.customer_id
WHERE rental_date BETWEEN '2005-05-24' AND '2005-05-26'


-- please count the numbers of the workers we are to reward and calculate how 
-- much it would cost if we are to pay them $200 each. (refer to the previous question)


SELECT COUNT(first_name) as OldCustomers, 
(COUNT(first_name) * 200) as Reward
FROM rental
INNER JOIN customer 
ON rental.customer_id=customer.customer_id
WHERE rental_date BETWEEN '2005-05-24' AND '2005-05-26'

-- get the last rental date of our customer
SELECT max(rental_date)
FROM rental

-- or

SELECT rental_date
FROM rental
ORDER BY 1 DESC
LIMIT 1
-- find the numbers of customers that made transaction of $5 and above



SELECT COUNT(*)
FROM payment
WHERE amount >=5

-- one of our customer with the name Tracy Cole is now married
-- and she wants us to update her surname from Cole to Markus.
-- please update this information 

UPDATE customer
SET last_name = 'Markus'
WHERE last_name = 'Cole'
AND first_name = 'Tracy'

-- print out the new name to be sure it was updated

SELECT first_name, last_name
FROM customer
WHERE first_name ='Tracy'
AND	last_name = 'Markus'



-- create a new column and name it Company Name. 
-- insert JulieChan AG as the of the company and let it run through
-- the whole rows.


ALTER TABLE customer
ADD Company_name VARCHAR(200) DEFAULT 'JulieChan AG'

-- rename column sex to gender
 ALTER TABLE customer
 RENAME COLUMN sex TO gender



-- rename table workers to Employee
 alter table workers
 rename to employee


-- set the customer status to Gold, Premium, Plus and normal by creating a new column
-- name the column Customer_Status.
-- any customer that made a transaction from 10 and above=Gold,
-- 8 and above ='premium', 6 and above ='plus' and the rest are normal

SELECT customer_id, amount,
CASE
   WHEN amount >= 10 THEN 'Gold'
   WHEN amount >= 8 THEN 'Premiun'
   WHEN amount >= 6  THEN 'Plus'
   ELSE 'Normal'
   END as Customer_Status
FROM payment



-- get their full names and status from the above question
SELECT first_name,last_name, 
CASE
   WHEN amount >= 10 THEN 'Gold'
   WHEN amount >= 8 THEN 'Premiun'
   WHEN amount >= 6  THEN 'Plus'
   ELSE 'Normal'
   END as Customer_Status
FROM payment
inner join customer
on payment.customer_id = customer.customer_id


-- set the customer status to Gold, Premium, Plus and normal by creating a new column
-- name the column Customer_Status.
-- any customer that that the total transaction made is 200 &above=Gold, 150 & above = Premium, 100 & above = Plus, the rest are Normal.


SELECT customer_id,SUM(amount) AS total_amount,

CASE
WHEN SUM(amount)> 200 THEN'Gold'
WHEN SUM(amount)> 150 THEN 'Premium'
WHEN SUM(amount)> 200 THEN 'Plus'
ELSE 'Normal'
end as status
FROM payment
GROUP BY 1






--get the numbers of each rating of movies 
SELECT 
SUM (CASE 
	WHEN rating = 'R' THEN  1 
	 ELSE 0
	 END) AS R,
SUM (CASE 
	WHEN rating = 'PG' THEN  1 
	 ELSE 0
	 END) AS PG,
SUM (CASE 
	WHEN rating = 'PG-13' THEN  1 
	 ELSE 0
	 END) AS PG_13
FROM film

-- we want email for our customers that ends in our company domain name
--  eg JEgbule@juliechan.ag. Please retrive the first letter in every customer's 
-- first and last name, and add our domain  @juliechan.ag to the end of their names to get a new email for all

SELECT CONCAT(left(first_name,1),last_name,'@juliechan.ag') as Email

FROM customer;

-- retrieve the top ten customers with the highest payment made from the dictrict of California

select email as CustomerEmails,district as cities, sum(amount)  as totalPayment≈
from address as a
join customer as c
on a.address_id = c.address_id
join payment as p
on c.customer_id = p.customer_id
where district = 'California'
group by c.email, a.district
order by sum(amount) desc
limit 10
 

 
