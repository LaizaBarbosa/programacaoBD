use sakila;

-- 1) procedure para saber as categorias de filmes assistidos por um cliente
create procedure filmes_por_cliente(id int)
begin
select customer.first_name, film.title, category.name
    from customer inner join rental on customer.customer_id = rental.customer_id
    inner join inventory on rental.inventory_id = inventory.inventory_id 
    inner join film on inventory.film_id = film.film_id
    inner join film_category on film.film_id = film_category.film_id
    inner join category on film_category.category_id = category.category_id
    where customer.customer_id = id;
end;

drop PROCEDURE filmes_por_cliente;
call filmes_por_cliente(1);

-- 2) função para criar uma nova locação
DESCRIBE rental; --retorna as colunas e os tipos de dados da tabela
CREATE FUNCTION locacao_nova(codigo int)
returns INT
DETERMINISTIC
begin
    DECLARE inventario_id INT;
    DECLARE equipe_id INT;
    SELECT inventory_id
        INTO inventario_id
        from inventory
        where film_id = codigo
        LIMIT 1;
    SELECT staff_id
        INTO equipe_id
        from staff
        LIMIT 1;
    INSERT INTO rental(rental_date, inventory_id, customer_id, staff_id)
    VALUES(NOW(), inventario_id, codigo, equipe_id);
    RETURN LAST_INSERT_ID();
END;

SELECT locacao_nova(1);
SELECT * from rental where rental_id = 16052;

 