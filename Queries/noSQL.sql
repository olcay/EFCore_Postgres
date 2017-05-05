/*create table film_docs(data jsonb);


insert into film_docs(data)
select row_to_json(film)::jsonb
from film;

select (data ->> 'title') as Title,
(data -> 'length') as Length
from film_docs
where data -> 'title' ? 'Chamber Italian';
*/

--https://www.postgresql.org/docs/current/static/functions-json.html

select (data ->> 'title') as Title,
(data -> 'length') as Length
from film_docs
where data @> '{"title": "Chamber Italian"}';

/*
Seq Scan on film_docs  (cost=0.00..96.50 rows=1 width=64)
  Filter: (data @> '{"title": "Chamber Italian"}'::jsonb)
Time: 0.009s
*/

--jsonb_path_ops means index is specific to @>
create index on film_docs using GIN(data jsonb_path_ops)

/*
Bitmap Heap Scan on film_docs  (cost=12.01..16.03 rows=1 width=64)
  Recheck Cond: (data @> '{"title": "Chamber Italian"}'::jsonb)
  ->  Bitmap Index Scan on film_docs_data_idx  (cost=0.00..12.01 rows=1 width=0)
        Index Cond: (data @> '{"title": "Chamber Italian"}'::jsonb)
Time: 0.008s
*/

