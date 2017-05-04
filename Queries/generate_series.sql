explain select * from payment;

select * from payment
where date_gt(payment_date::date, '2007-04-01'::date);

select 
amount,
payment_Date,
date_part('quarter', payment_date) as quarter,
date_part('year', payment_date) as year,
concat('Q', date_part('quarter', payment_date), '-', date_part('year', payment_date)) as display_quarter
from payment;


select x, md5(random()::text) from generate_series(100, 0, -5) as f(x)

select x from generate_series('2001-10-01'::TIMESTAMP, '2002-10-01'::TIMESTAMP, '10 days') as f(x)

select trunc(random() * 1000 + 1) from generate_series(1, 1000)