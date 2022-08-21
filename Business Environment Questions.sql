
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



create view New_date AS ext

select To_Char(payment_date, 'YYYY') as Year, To_Char(payment_date,'Mon')
as Month, To_Char(payment_date,'dd') as Days, payment_date,
To_Char(payment_date, 'MONTH/YYYY'), To_Char(payment_date, 'dd/mm/yyyy') as Dates
from payment


















	









