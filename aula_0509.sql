select * from actor;

create procedure listar_sobrenome(valor VARCHAR(40))
begin
    SELECT * from actor
    where last_name like CONCAT(valor, '%');
end;

drop PROCEDURE listar_sobrenome;

call listar_sobrenome('bu');

SELECT * FROM payment;

SELECT payment.amount, customer.first_name, customer.last_name
    from payment inner join customer on payment.customer_id = customer.customer_id
    where customer.first_name like "c%";

    create PROCEDURE pagamentos(wvalor VARCHAR (40))
    begin
    SELECT payment.amount, customer.first_name, customer.last_name
    from payment inner join customer on payment.customer_id = customer.customer_id
    where customer.first_name like "wvalor%";
    end;

CREATE Procedure listar_pagamentos(id int)
begin
select customer.first_name, payment.amount
    from payment
    inner join customer using(customer_id)
    where payment.customer_id = id;
end;

drop Procedure listar_pagamentos;

call listar_pagamentos(3);

SELECT payment.payment_id, customer.first_name, payment.amount,
    if(staff_id=1,(payment.amount * 0.05), payment.amount * 0.03)
    from payment
    inner join customer on payment.customer_id = customer.customer_id


create procedure lista_comissao(id int)
begin
select payment.payment_id, customer.first_name, payment.amount,
    case staff_id
    when 1 then payment.amount * 0.05
    when 2 then payment.amount * 0.03
    END
    from payment
    inner join customer on payment.customer_id = customer.customer_id
    where payment.customer_id = id;
end;

call lista_comissao(2);

create procedure listar_endereco(id int)
begin
select customer.first_name, address.address, address.district, city.city 
    from customer inner join address on customer.address_id = address.address_id 
    inner join city on address.city_id = city.city_id
    where customer.customer_id = id;
end;

call listar_endereco(2);