use sakila;

-- Query 1 --
-- 1. Find out the number of documentaries with deleted scenes. --
SELECT count(distinct title) FROM film WHERE special_features like '%Deleted Scenes%' AND film.film_id 
IN(SELECT fc.film_id FROM category c inner join film_category fc  on c.category_id=fc.category_id and c.name='Documentary' );


-- Query 2 --
-- 2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens. --
 select count(*) from category c inner join film_category fc on c.category_id = fc.category_id and c.name='Sci-fi' 
 inner join inventory i on fc.film_id=i.film_id
 inner join rental r on i.inventory_id=r.inventory_id
 inner join staff s on r.staff_id=s.staff_id AND s.first_name='Jon' AND s.last_name='Stephens';

-- Query 3 --
-- 3. Find out the total sales from Animation movies. --
select sum(p.amount) from payment p where p.customer_id in 
(select r.customer_id from category ca inner join film_category fc on ca.category_id=fc.category_id and ca.name='Animation' 
inner join inventory i on fc.film_id = i.film_id 
inner join rental r on i.inventory_id=r.inventory_id);

-- Query 4 --
-- 4. Find out the top 3 rented category of movies by “PATRICIA JOHNSON”. --
select fl.category from film_list fl inner join inventory i on fl.FID=i.film_id 
inner join rental r on i.inventory_id = r.inventory_id 
inner join customer_list cl on cl.ID = r.customer_id and cl.name='PATRICIA JOHNSON'
GROUP BY fl.category ORDER BY count(fl.category) desc, fl.category limit 3;

-- Query 5 --
-- 5. Find out the number of R rated movies rented by “SUSAN WILSON”. --
select count(*) from rental r inner join customer c on r.customer_id = c.customer_id and c.first_name='SUSAN' and c.last_name='WILSON'
inner join inventory i on r.inventory_id=i.inventory_id 
inner join film f on f.film_id = i.film_id and f.rating='R';


