# Base-de-datos-DAW-

ejercicios en casa
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
