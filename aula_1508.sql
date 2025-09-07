use sakila;
select * from actor;
select first_name as Nome, 
        last_name as Sobrenome
from actor
order by first_name;

select * from customer
        inner join address on customer.address_id = address.address_id
        inner join city on address. city_id = city.city_id;
select * from address;

select * from customer; 
select c.first_name, c.last_name, a.address, a.district, ci.city, co.country from customer as c
    inner join address as a on  c.address_id = a.address_id
    inner join city ci on ci.city_id = a.address_id
    inner join country co on co.country_id = ci.country_id;


select customer.first_name as nome,
        customer.last_name as sobrenome, 
        payment.amount as 'preço', 
        payment.payment_date as 'data' 
        from customer
    inner join payment on customer.customer_id = payment.customer_id where first_name like "mary";

select customer.first_name as nome, 
    payment.customer_id as 'id cliente',
    SUM(payment.amount) as 'pagamento total'
    from customer
    inner join payment on customer.customer_id = payment.customer_id where first_name like "mary" group by payment.customer_id;

-- DIA 22/08

create view pagamentos as 
select customer.first_name as nome,
    SUM(payment.amount) as 'pagamento total'
    from customer
    inner join payment on customer.customer_id = payment.customer_id group by payment.customer_id;

select * from pagamentos;

SELECT * FROM category;
SELECT * from rental;
SELECT * from inventory;
SELECT * from film;

SELECT COUNT(*), category.name 
    from rental 
    inner join inventory on rental.inventory_id = inventory.inventory_id
    inner join film on inventory.film_id = film.film_id
    inner join film_category on film.film_id = film_category.film_id
    inner join category on film_category.category_id = category.category_id
    GROUP BY category.name;


CREATE VIEW lista_categorias as
SELECT category.name as 'gênero', COUNT(*) as 'quantidade' from rental
    inner join  inventory on rental.inventory_id = inventory.inventory_id
    inner join film_category on inventory.film_id = film_category.film_id
    inner join category on film_category.category_id = category.category_id
    GROUP BY category.name
    ORDER BY 2 DESC limit 10;

SELECT * from lista_categorias;

CREATE VIEW atores_filmes as
select CONCAT(actor.first_name," ", actor.last_name) as 'ator', film.title as 'título'
    from actor
    inner join film_actor on actor.actor_id = film_actor.actor_id
    inner join film on film_actor.film_id = film.film_id;

SELECT * FROM atores_filmes order by 1 asc;


