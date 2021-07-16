use sakila;


-- query 1 --
-- 1. Find out the PG-13 rated comedy movies. DO NOT use the film_list table.-- 
SELECT film_id,title FROM film WHERE rating='PG-13' AND film_id IN(SELECT film_id FROM film_category WHERE category_id IN(SELECT category_id FROM category WHERE category.name='Comedy'));


-- query 2 --
-- 2. Find out the top 3 rented horror movies.-- 
select fl.title from film_list fl inner join inventory i on fl.FID=i.film_id and fl.category='Horror' 
inner join rental r on i.inventory_id=r.inventory_id 
group by title order by count(*) desc limit 3; 



-- query 3 --
-- 3. Find out the list of customers from India who have rented sports movies.-- 
select c.customer_id,c.first_name,c.last_name,ca.name,co.country 
from customer c inner join rental r on c.customer_id=r.customer_id 
inner join inventory i on r.inventory_id = i.inventory_id 
inner join film_category fc on i.film_id = fc.film_id 
inner join category ca on fc.category_id=ca.category_id and ca.name='SPORTS'
inner join address a on c.address_id=a.address_id
inner join city ci on a.city_id = ci.city_id 
inner join country co on ci.country_id = co.country_id and co.country='INDIA'
group by c.customer_id;

-- query 4 --
-- 4. Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies. --

select distinct  c.first_name,c.last_name from actor a inner join film_actor fa on  a.actor_id=fa.actor_id and a.first_name = 'NICK' AND a.last_name='WAHLBERG'
inner join inventory i on fa.film_id =i.film_id 
inner join rental r on i.inventory_id=r.inventory_id 
inner join customer c on r.customer_id = c.customer_id
inner join address ad on c.address_id=ad.address_id
inner join city ci on ad.city_id = ci.city_id 
inner join country co on ci.country_id = co.country_id and co.country='CANADA';

-- Query 5 --
-- 5. Find out the number of movies in which “SEAN WILLIAMS” acted. --
SELECT count(film_id) FROM film_actor a inner join  actor a1 on a.actor_id=a1.actor_id and a1.first_name='SEAN' AND a1.last_name='WILLIAMS' ;