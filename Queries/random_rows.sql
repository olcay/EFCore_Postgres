create or replace function random_payments(counter int) returns setof payment
as $$
DECLARE
	start_id int;
	end_id int;
BEGIN
	select min(payment_id) from payment into start_id;
	select max(payment_id) from payment into end_id;
	return query (select * from payment
	where payment_id IN(
	select trunc(random() * (end_id - start_id) + start_id)
	from generate_series(1, counter + 1)));
END
$$ language plpgsql;

select * from random_payments(200)