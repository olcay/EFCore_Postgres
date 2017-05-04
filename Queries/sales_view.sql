create view raw_sales as
select title, description, length, rating, p.amount, payment_date,
date_part('quarter', payment_date) as quarter,
date_part('month', payment_date) as month,
date_part('year', payment_date) as year,
concat('Q', date_part('quarter', payment_date)::text, '-', date_part('year', payment_date)::text) as qyear,
cash_words(amount::money) as spelling_it_out,
to_tsvector(concat(title, ' ', description)) as search_field
from film f
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id = i.inventory_id
inner join payment p on p.rental_id = r.rental_id;


with sales_rollups as (select distinct title, qyear,
	sum(amount) over (partition by title, qyear) as "Quarterly Sales",
	sum(amount) over (partition by qyear) as "Total Quarterly",
	sum(amount) over (partition by title, qyear)/sum(amount) over (partition by qyear) * 100 as "Percent of Total Quarter"
	from raw_sales
order by title),
	q1_2007 as (select * from sales_rollups where qyear = 'Q1-2007'),
	q2_2007 as (select * from sales_rollups where qyear = 'Q2-2007'),
	things_are_correct as (
		select 
			(select sum("Percent of Total Quarter") from q2_2007),
			(select sum("Percent of Total Quarter") from q1_2007)
)

select * from things_are_correct