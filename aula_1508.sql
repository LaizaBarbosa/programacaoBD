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


