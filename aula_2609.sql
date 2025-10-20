select film.title
from
    customer
    inner join rental on customer.customer_id = rental.customer_id
    inner join inventory on rental.inventory_id = inventory.inventory_id
    inner join film on inventory.film_id = film.film_id
    inner join film_category on film.film_id = film_category.film_id
    inner join category on film_category.category_id = category.category_id
where
    category.category_id = 1
    and customer.customer_id = 1;

create Function total_filmes(id int)
returns INTEGER
DETERMINISTIC
begin
declare total INTEGER;
select  COUNT(film.title) into total
    from customer inner join rental on customer.customer_id = rental.customer_id
    inner join inventory on rental.inventory_id = inventory.inventory_id 
    inner join film on inventory.film_id = film.film_id
    inner join film_category on film.film_id = film_category.film_id
    inner join category on film_category.category_id = category.category_id
    where category.category_id = 1 and customer.customer_id = 1;
return total;
end;

SELECT total_filmes (1) as 'Total de filmes assistidos';

CREATE TABLE produto (
    id_prod INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    qtd INT,
    valor DECIMAL(9, 2),
    grupo VARCHAR(20)
);

INSERT INTO produto (descricao, qtd, valor, grupo) VALUES
('Caneta', 10, 1.50, 'Papelaria'),
('Caderno', 15, 12.00, 'Papelaria'),
('Borracha', 25, 0.80, 'Papelaria'),
('Mochila', 5, 120.00, 'Acessórios'),
('Estojo', 8, 25.00, 'Acessórios');


SELECT * from produto;

CREATE TABLE venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_prod INT,
    qtd INT,
    FOREIGN KEY (id_prod) REFERENCES produto (id_prod)
);

DELIMITER

update produto set qtd = 40 WHERE id_prod = 2;

CREATE TRIGGER baixa_estoque
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
    INSERT venda
    SET qtd = NEW.qtd - OLD.qtd,
    id_prod = NEW.id_prod;
END

drop trigger baixa_estoque;

DELIMITER;
select * from produto;
select * from venda;
