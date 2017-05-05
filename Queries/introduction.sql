
drop view if exists membership.pending_users;
drop table if exists membership.users_roles;
drop table if exists membership.users;
drop table if exists membership.roles;
drop schema if exists membership;

create schema membership;

create or replace function random_string(len int) returns text as
$$
	select substring(md5(random()::text), 0, len) as result;
$$ language sql;

create or replace function the_time() returns TIMESTAMPTZ as
$$
	select now() as result;
$$ language sql;

create table membership.users(
	id serial primary key not null,
	user_key varchar(18) default random_string(18),
	email varchar(255) unique not null,
	first varchar(50),
	last varchar(50),
	created_at timestamptz not null default the_time(),
	status varchar(10) not null default 'pending',
	search_field tsvector not null
);

create table membership.roles(
	id serial primary key not null,
	name varchar(50) not null
);

create table membership.users_roles(
	user_id int not null references membership.users(id) on delete cascade,
	role_id int not null references membership.roles(id) on delete cascade,
	primary key(user_id, role_id)
);

create trigger users_search_update_refresh
before insert or update on membership.users
for each row execute procedure
tsvector_update_trigger(search_field, 'pg_catalog.english', email, first, last);

insert into membership.users(email, first, last)
values ('test@test.com', 'Olcay', 'Bayram');

insert into membership.roles(name)
values ('Administrator');

insert into membership.users_roles(user_id, role_id)
values (1, 1);

create view membership.pending_users as
select * from membership.users where status = 'pending';

--select * from membership.users
--where search_field @@ to_tsquery('olcay & bay:*');

select * from membership.pending_users;