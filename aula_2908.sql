use sakila;

SELECT CONCAT(first_name, ' ', last_name) as nome 
    from actor where actor_id = 1; 

create Function nome_ator(id int)
returns VARCHAR(100)
DETERMINISTIC
begin
DECLARE nome VARCHAR(100);
    SELECT CONCAT(first_name, ' ', last_name) into nome  
    from actor where actor_id = id; 
return nome;
end

SELECT nome_ator(55);

select film_id, nome_ator(actor_id) from film_actor;


create Function total_pago(id int)
returns VARCHAR(100)
DETERMINISTIC
BEGIN
declare valor VARCHAR(100);
select CONCAT(customer.first_name, ' = ', SUM(payment.amount)) into valor from payment
    inner join customer on payment.customer_id = customer.customer_id
        where payment.customer_id = id GROUP BY payment.customer_id;
return valor;
end;


drop function total_pago;

SELECT total_pago(5);

select total_pago(customer_id) from customer;

select staff.first_name, SUM(payment.amount) as total 
    from payment 
    inner join staff on payment.staff_id = staff.staff_id
    where payment.staff_id = 1;

select * from staff;

create Function total_gerente(id int)
returns VARCHAR(100)
DETERMINISTIC
BEGIN
declare mensagem VARCHAR(100);
select CONCAT(staff.first_name, ' - ', SUM(payment.amount)) into mensagem 
    from payment 
    inner join staff on payment.staff_id = staff.staff_id
    where payment.staff_id = id GROUP BY payment.staff_id;
return mensagem;
end;

drop Function total_gerente;

select total_gerente(staff_id) from staff;

SELECT * from category;
SELECT * from film_category;

select COUNT(film_category.film_id), category.name 
    from film_category 
    inner join category on film_category.category_id = category.category_id
    where film_category.category_id = 1 GROUP BY film_category.category_id;

CREATE FUNCTION filmes_genero(id int)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
DECLARE mensagem VARCHAR(100);
    select CONCAT(COUNT(film_category.film_id),' - ', category.name) into mensagem
    from film_category 
    inner join category on film_category.category_id = category.category_id
    where film_category.category_id = id 
    GROUP BY film_category.category_id;
return mensagem;
end;

SELECT filmes_genero(category_id) from category;