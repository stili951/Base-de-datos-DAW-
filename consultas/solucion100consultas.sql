use sakila;
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
	select actor.actor_id, actor.first_name , actor.last_name , count(film_actor.film_id) 
    from actor join film_actor using (actor_id)
    join film using (film_id)
    group by actor.actor_id ,actor.first_name , actor.last_name;

-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.
	select actor.actor_id, actor.first_name , actor.last_name , count(film_actor.film_id) 
    from actor join film_actor using (actor_id)
    join film using (film_id)
    group by actor.actor_id ,actor.first_name , actor.last_name
	having count(film_actor.film_id) >= 20
    order by count(film_actor.film_id) ASC;
-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.
	select count(film.film_id)  , language.name
    from language join film using (language_id)
    group by  language.name ;
-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.
	select language_id , avg(length)
    from language join film using (language_id)
    group by language_id
    order by avg(length) > 110;
-- 5:  Para cada película, muestra cuántas copias hay en el inventario.
	select film.title , count(inventory.inventory_id) as copias_total
    from film join inventory using(film_id)
    group by film.title , film_id;
-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.
	select film.title , count(inventory.inventory_id) as copias_total
    from film join inventory using(film_id)
    group by film.title , film_id
    having count(inventory.inventory_id) >=5
    order by count(inventory.inventory_id);
-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.
	select inventory.inventory_id , count(inventory_id)
    from inventory join rental using(inventory_id)
    group by inventory_id;
-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.
	select customer.customer_id , count(*)
    from rental join customer using(customer_id)
    group by customer.customer_id;
-- 9:  Lista los clientes con 30 o más alquileres acumulados.
	select customer.customer_id , count(*)
    from rental join customer using(customer_id)
    group by customer.customer_id
    having count(*) >= 30;
-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.
	select customer.customer_id , sum(payment.amount)
    from payment join customer using(customer_id) 
    group by customer.customer_id;
