
-- A customer forgot his wallet at our store! We need to track down his email to inform --- her. What is the email of Nancy?


select first_name, last_name,email
from customer
where first_name = 'Nancy' 
AND last_name = 'Thomas'


-- what customer has the highest customer ID whose name starts with an 'E' and has an address id lower than 500?

select first_name,last_name,address_id
from customer
where address_id < 500
AND first_name like 'E%'
group by  first_name,last_name,address_id
order by 3 desc
limit 1




-- select the movie that the rental rate is higher than the average 
-- rental rate for all the films

Select avg(rental_rate) from film
select title,rental_rate from film
where rental_rate > 2.980000000

or 

select title, rental_rate from film
where rental_rate >
(select avg(rental_rate)

from film)


-- A customer wants to know what the movie Outlaw Hanky is all about. Could you show them the description of the movie?

select 
title, description
from film
where title = 'Outlaw Hanky'

-- a customer wants to quickly rent a video to watch over their shirt lunch break. What are the title of the 5 shortest movies?

select title,length
from film
order by 2 asc
limit 5

-- if the previous customer can watch any movie that is 50 or less in run time, how many options does he or she have?

select count(length)
from film
where length <=50

-- how many films have a rating of R and a replacement_cost between 5 and 15 usd

select 
count(*)
from film
where rating = 'R' 
And replacement_cost BETWEEN 5 AND 15


-- hom many films begins with the letter J

select count(title)
from film
where title like 'J%'
-- corporate HQ is conducting a study on the relationship between replacement cost and a movie MPAA rating.
-- what is the average replacement cost per MPAA rating?
select rating, avg(replacement_cost) 
from film
group by rating


-- how many films have the word Truman somewhere in the title

select count(*)
from film
where title like '%Truman%'


-- a customer walks in and is a huge fan of the actor Nick Wahlberg and wants to know whihc movies he is in.
-- get a list of all the movies Nick Wahlberg has been in.

select title,first_name,last_name 
from film
inner join film_actor
on film.film_id = film_actor.film_id
inner join actor 
on film_actor.actor_id = actor.actor_id
where first_name = 'Nick' and last_name = 'Wahlberg'

or

select title,first_name,last_name 
from film as f
inner join film_actor as fa
on f.film_id = fa.film_id
inner join actor as a
on fa.actor_id = a.actor_id
where first_name = 'Nick' and last_name = 'Wahlberg'


-- find the title of movies that were release bewteen 2005/05/29 and 2005/05/30
-- use the film, inventory and rental table

select title, film_id from film
where film_id in (
select inventory.film_id from rental
inner join inventory
on inventory.inventory_id = rental.inventory_id
where release_date between '2005-05-29' and '2005-05-30'

)

-- find the first and last name of customers that amount is more than 11
-- use payment and customer’s table

select first_name, last_name
 from customer
 inner join payment
 on customer.customer_id = payment.customer_id 
 where amount > 11
 order by 1
 
 
 or 
 select first_name, last_name
 from customer
 where exists (
 select * from payment 
 where customer.customer_id = payment.customer_id
	 and amount > 11)
	 order by 1



-- address Table
-- a customer is late on their movie return, and we have mailed them a letter to their address at 259 Ipoh Drive.
-- Can you get the phone number for the customer who lives at: 259 Ipoh Drive.


select phone
from address
where address = '259 Ipoh Drive'

-- how many unique district are our customer from?

select count(distinct district) 
from address 

-- retrieve the list of names for those distinct districts from the previous questions.

select distinct(district) 
from address
order by 1


-- we want to reward our first 10 paying customers. What are the customer ids of the first 10 customers who created a payment?
select customer_id, payment_date
from payment
order by 2
limit 10

--how many payment transaction are greater than $5

Select count(amount) 
from payment
Where amount > 5


-- we have two staff members, with staff ids 1 and 2. we want to give a bonus to the staff membe rthat handled the most payments.
-- how many payments did each staff member handled and who gets the bonus

select staff_id, count(amount)
from payment
group by staff_id
order by 2 desc


-- we are running a promotion to reward our top 5 customers with coupons. what are the customer ids of the top 5 customers by total spend?

select customer_id, sum(amount)
from payment
group by customer_id
order by 2 desc
limit 5

-- use the above question to find the top 5 customers tha the totals transaction are above 200

select customer_id, sum(amount) as highest
from payment
group by customer_id
having  sum(amount) > 200
order by highest desc

-- we are lauching a platinum service for our most loyal customers. we will assign platinium status to customers that have had
-- 40 or more transaction payments.
-- what customer_ids are eligible for platinum status?

select customer_id, count(amount)
from payment
group by customer_id
having count(amount) >=40


-- what are the customer_ids of customers who have spent more than $100 in payment transactions with our staff_id member 2

select customer_id, sum(amount)
from payment 
where staff_id = 2
group by customer_id, staff_id
having sum(amount) > 100
order by 3 desc

-- return the customer id of customers who have spent at least 110 with staff member who has an ID of 2

select customer_id, sum(amount)
from payment
where staff_id = 2
group by customer_id
having sum(amount) > 110
-- how long has payment been effective
select Age(payment_date) 
from payment

-- List out the years from the payment_date
select Extract(year from payment_date) 
from payment




-- Actor Table
—how many actors have a first name that starts with the lette P?

select count(*)
from actor
where first_name like 'P%'


-- get the customers first and last name on the same column, customer_id,total sum of transaction,average,max, minimum transaction and
-- count the number of transaction made by each customer. 
-- Then create a view as customers_transaction in order to save these queries

CREATE VIEW customers_transaction AS
Select CONCAT(c.first_name,' ',c.last_name) AS fullnames,
p.customer_id,
SUM(amount) over (partition by p.customer_id ) AS total_per_id,
AVG(amount) over (partition by p.customer_id ) AS avg_per_id,
MAX(amount) over(partition by p.customer_id ) AS highest_per_id,
MIN(amount) over (partition by p.customer_id) AS lowest_per_id,
ROW_NUMBER () over (partition by p.customer_id) AS Ranking,
COUNT(amount) over (partition by p.customer_id) AS Numbers
FROM customer as c
INNER JOIN payment as p
ON c.customer_id = p.customer_id
ORDER BY 2 


-- which customer spent the most 

SELECT fullnames, customer_id, total_per_id
FROM customers_transaction 
GROUP BY 1,2,3
ORDER BY 3 DESC
LIMIT 1

-- we would like to  reward the customer with the highest number of transactions.
-- from this view customers_transaction  that was created, get the customer with the highest numbers of transaction.

SELECT MAX(Numbers),fullnames, customer_id
FROM customers_transaction
Group by 2,3
order by 1 desc
limit 1

-- lowest number of transaction made is by which customer

SELECT MIN(Numbers),fullnames, customer_id
FROM customers_transaction
Group by 2,3
order by 1 
limit 1

-- which customer spent the least 

SELECT fullnames, customer_id, total_per_id
FROM customers_transaction 
GROUP BY 1,2,3
ORDER BY 3 
LIMIT 1

-- we also loved to reward the customers that have spent the most. Please help retrieve the names of ou top 5 highest spender from the view queries

SELECT fullnames, customer_id, total_per_id
FROM customers_transaction
Group by 1,2,3
ORDER BY 3 DESC
LIMIT 5

-- now let us reward customers with over >=200 total transaction with 1000usd, >=150 get 500usd

SELECT fullnames, customer_id, total_per_id,
CASE
WHEN  total_per_id >= 200 THEN 1000
WHEN  total_per_id >= 150 THEN 500
ELSE 0
END AS Customer_Reward
FROM customers_transaction 
GROUP BY 1,2,3
ORDER BY 3 DESC 
LIMIT 5

-- to encourage our top 10 lowest spenders, let us give them the sum of 200 usd each

SELECT fullnames, customer_id, total_per_id,
(200) as Encourage_reward
FROM customers_transaction 
GROUP BY 1,2,3
ORDER BY 3 
LIMIT 10





	









