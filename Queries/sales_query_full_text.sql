with actor_rollup  as (select f.film_id, title, sum(p.amount)::money as total_sales,
group_concat(first_name || ' ' || last_name) as actors,
to_tsvector(concat(f.title, ' ', group_concat(first_name || ' ' || last_name))) as search_field
from film f
inner join film_actor fa on f.film_id = fa.film_id
inner join actor a on a.actor_id = fa.actor_id
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id = i.inventory_id
inner join payment p on p.rental_id = r.rental_id
group by f.film_id, title)

select title, actors, total_sales
from actor_rollup
where search_field @@ to_tsquery('jedi');