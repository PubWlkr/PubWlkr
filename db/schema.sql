CREATE TABLE users(
	id serial primary key,
	f_name varchar(255),
	l_name varchar(255),
	email varchar(255),
	password_digest varchar(255)
	);

CREATE TABLE trips(
	id serial primary key,
	user_id integer,
	user_rating integer,
	completed boolean,
	time_created timestamp,
	name varchar(255),
	map_url text
);

CREATE TABLE bars(
	id serial primary key,
	name varchar(255),
	address varchar(255),
	website text,
	pic_url text,
	rating integer,
	price_range integer,
	place_id text
);

CREATE TABLE stops(
	id serial primary key,
	bar_id integer,
	trip_id integer,
	completed boolean
);
