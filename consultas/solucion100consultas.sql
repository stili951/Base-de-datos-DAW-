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
-- Hecho en clase 29/ 10/2026
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
-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.
	select customer.customer_id , sum(payment.amount)
    from payment join customer using(customer_id) 
    group by customer.customer_id
    having sum(payment.amount) >=200;
-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.
	select staff.staff_id , count(payment.payment_id)
    from staff join payment using(staff_id)
    group by staff.staff_id;
-- 13:  Para cada empleado, muestra el importe total procesado.
	select staff.staff_id , sum(payment.amount)
    from payment join staff using(staff_id)
    group by staff.staff_id;
-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.
	select store.store_id , count(inventory_id)
    from store join inventory using(store_id)
    group by store.store_id;
-- ejercicios en casa
-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.
	select store.store_id , count(customer.customer_id)
    from store join customer using(store_id)
    group by store.store_id;
-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.
	select st.store_id , count(s.staff_id) as empleados_totales
    from store st join staff s using(store_id)
    group by st.store_id;
-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).
	select address.address_id , address.address, count(store.store_id)
    from address join store using(address_id)
    group by address.address_id;
-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.
	select address.address_id , address.address , count(staff.staff_id)
    from address join staff using(address_id)
    group by address.address_id , address.address;
-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.
	select address.address_id , address.address ,count(customer_id)
    from address join customer using(address_id)
    group by address.address_id,address.address;
-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.
	select city.city_id, city.city ,count(address.address_id) 
    from city join address using (city_id) 
    group by city.city_id, city.city ;
-- 21:  Para cada país, cuenta cuántas ciudades existen.
	select c.country_id , c.country , count(ci.city_id)
    from country c join city ci using (country_id)
    group by c.country_id , c.country;
-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.
	select l.language_id ,l.name , avg(f.length)
    from language l join film f using(language_id)
    group by l.language_id, l.name
    having avg(f.length) >= 90 && avg(f.length) <= 120 ;
-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).
	select f.film_id, f.title ,count(r.inventory_id)
    from film f join inventory i using(film_id)
    join rental r using(inventory_id)
    group by f.film_id , f.title;
-- hecho el 04-11-2026
-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).
	select c.customer_id , first_name , count(p.payment_date) as total_pagos
    from customer c join payment p using(customer_id)
    where year(p.payment_date)= 2005
    group by c.customer_id
    order by c.customer_id asc;
-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).
	select film_id , title , avg(rental_rate)
    from film join inventory using(film_id)
    group by film_id , title;
-- 26:  Para cada actor, muestra la duración media (length) de sus películas.
	select a.actor_id, avg(f.length) as duracion_media
    from film_actor a join film f using(film_id)
    group by a.actor_id;	
-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
	select city_id ,city, count(customer_id)
    from city join address using(city_id)
    join customer using(address_id)
    group by city_id, city 
    order by city_id asc; 
-- 28:  Para cada película, cuenta cuántos actores tiene asociados.
	select film_id ,title, count(actor_id)
    from film join film_actor using(film_id)
    group by film_id , title;
-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).
	select category_id , count(film_id)
	from film_category join film using(film_id)
    group by category_id;
-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.
	select store_id , count(inventory_id)
    from store join inventory using(store_id)
    join rental using(inventory_id)
    group by store_id;
-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.
	select actor_id , first_name ,last_name , count(film_id) 
    from actor join film_actor using(actor_id)
    join film using(film_id)
    group by actor_id, last_name;
-- Hecho el 05 -11 en la mañana 
-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.
	select c.category_id , c.name , count(f.film_id)
    from category c join film_category using(category_id)
    join film f using(film_id)
    group by category_id, c.name;
-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.
	select f.film_id , title , count(rental_id)
    from film f join inventory using(film_id)
    join rental using(inventory_id)
    group by f.film_id , title;
-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.
	select c.customer_id, first_name, last_name ,sum(amount) as importe_pagado 
    from customer c join payment using(customer_id)
    where year(payment_date) = 2005
    group by c.customer_id
    having sum(amount) >= 150 ;
-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.
	select store_id , first_name, last_name ,sum(amount) as importe_cobrado
    from store join staff using(store_id)
    join payment using(staff_id)
    group by store_id, first_name, last_name;
-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).
	select city_id , city , count(staff_id)
    from city join address using(city_id)
    join staff using (address_id)
    group by city_id , city;
-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).
	select city_id , city , count(store_id) 
    from city join address using(city_id) 
    join store using(address_id)
    group by city_id , city;
-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.
	select actor_id , first_name, last_name , avg(length) as duracion_media
    from actor join film_actor using(actor_id)
    join film f using(film_id)
    where release_year = 2006
    group by actor_id , first_name , last_name;
-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.
	select category_id , name , avg(length) as duracion_media
    from category join film_category using(category_id)
    join film using(film_id)
    group by category_id, name
    having avg(length) > 120;
-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.
	select language_id , name , sum(rental_rate)
    from language join film using(language_id)
    group by language_id , name;
-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).
	select customer_id, first_name, last_name , count(rental_date)
	from customer join rental using (customer_id)
    where dayofweek(rental_date) in (1,7)
    group by customer_id , first_name , last_name
    order by customer_id asc;
-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).
	select actor_id , first_name, last_name, count(distinct film_id)
    from actor join film_actor using(actor_id)
    join film using(film_id)
    group by actor_id , first_name, last_name;
-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).
	select city_id , city, count(customer_id)
    from city join address using(city_id)
    join customer using(address_id)
    group by city_id , city;
-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
	select category_id , count(Distinct actor_id)
    from film_category join film using(film_id)
    join film_actor using(film_id)
    group by category_id;
-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
	select store_id , count(film_id) as copias_totales
    from store join inventory using(store_id)
    join film using(film_id)
    where release_year = 2006
    group by store_id;
-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
	select customer_id ,c.first_name , c.last_name, sum(amount) as total_pagado
    from customer c join payment using(customer_id)
    join staff using(staff_id)
    where staff_id = 1 
    group by customer_id,c.first_name ,c.last_name , staff_id;
-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
	select film_id , title , count(actor_id) as total_actores
    from film join film_actor using(film_id)
    join actor using(actor_id)
    where length(last_name) >=5
    group by film_id, title ;
-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
	select category_id , name , sum(length) as duracion_total
    from category join film_category using(category_id)
    join film using(film_id)
    group by category_id , name ;
-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
	select city_id , city , sum(amount) 
    from city join address using(city_id)
    join customer using(address_id)
    join payment using(customer_id)
    group by city_id , city;
-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
	select language_id , name , count(distinct actor_id)
    from film_actor join film using(film_id)
    join language using(language_id)
    group by language_id , name;
-- 	Ejercicio hata el 70  , dia 09-11-2026
-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
	select store_id , count(customer_id)
    from store join customer using(store_id)
    where active = 1 
    group by store_id;
-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
	select customer_id , first_name , last_name , count(distinct category_id) as categorias_distintas
    from customer join rental using(customer_id) 
    join inventory using(inventory_id)
    join film_category using(film_id)
    where year(rental_date) = 2006
    group by customer_id , first_name , last_name;
-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
	select staff_id ,s.first_name ,s.last_name , count(distinct customer_id) as pago_diferentes
    from staff s join payment using(staff_id)
    join customer using(customer_id)
    group by staff_id , s.first_name, s.last_name ;
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
	select c.city_id , c.city , count(inventory_id) as peliculas_alquiladas
    from city c join address using(city_id)
    join customer using(address_id)
    join rental using(customer_id)
    where year(rental_date)=2006
    group by c.city_id, c.city;
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
	select category_id , name , avg(replacement_cost)
    from category join film_category using(category_id)
    join film using(film_id)
    group by category_id , name;
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
	select store_id , sum(amount)
    from store join staff using(store_id)
    join payment using(staff_id)
    where year(payment_date) = 2006
    group by store_id;
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
	select actor_id , first_name , last_name , count(title)
    from actor join film_actor using(actor_id)
    join film using(film_id)
    where length(title) > 12
    group by actor_id, first_name , last_name ;
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
	select city_id , city, sum(amount)
    from city join address using(city_id)
    join customer using(address_id)
    join payment using(customer_id)
    where year(payment_date) = 2005 
    group by city_id , city
    having sum(amount)=300;
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
	select category_id , name , count(film_id)
    from category join film_category using(category_id)
    join film using(film_id)
    where rating in ('PG','PG-13')
    group by category_id, name;
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
	select customer_id , c.first_name , c.last_name , sum(amount)
    from customer c join payment using(customer_id)
    join staff using(staff_id)
    where staff_id = 2
    group by customer_id , c.first_name ,c.last_name;
-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
	select city_id , city , count(customer_id)
    from city join address using(city_id)
    join customer using(address_id)
    group by city_id, city
    having count(customer_id) >=10;
-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
	select actor_id , first_name , last_name , count(rental_id) 
    from actor join film_actor using(actor_id)
    join inventory using(film_id)
	join rental using(inventory_id)
    group by actor_id, first_name , last_name;
-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
	select category_id , name , sum(amount) as importes_pagados
    from category join film_category using(category_id)
    join inventory using(film_id)
    join rental using(inventory_id)
    join payment using(rental_id)
    group by category_id, name;
-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
	select city_id , city , sum(amount)
    from city join address using(city_id)
    join customer using(address_id)
    join payment using(customer_id)
    where year(payment_date) = 2005
    group by city_id , city ;
-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
	select store_id , count(distinct actor_id)
    from store join inventory using(store_id)
    join film_actor using(film_id)
    group by store_id;
-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
	select language_id , name, count(rental_id)
    from language join film using(language_id)
    join inventory using(film_id)
    join rental using(inventory_id)
    group by language_id , name;
-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
	select customer_id , first_name , last_name , count(distinct month(payment_date))
    from customer join payment using(customer_id) 
    where year(payment_date) = 2005 
    group by customer_id , first_name, last_name;
-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
	select category_id , name, avg(length)
    from category join film_category using(category_id)
    join film using(film_id)
    join inventory using(film_id)
    join rental using(inventory_id) 
    group by category_id , name ;
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
	select country_id , country , count(customer_id)
    from country join city using(country_id)
    join address using(city_id)
    join customer using(address_id)
    group by country_id , country
    order by country_id asc;
-- 70:  Para cada país, suma los importes pagados por sus clientes.
	select country_id , country, sum(amount)
    from country join city using(country_id)
    join address using(city_id)
    join customer using(address_id)
    join payment using(customer_id)
    group by country_id, country;
