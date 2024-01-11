#COMANDO DDL - Data Definition Language (Linguagem de definição de dados)

DROP TABLE tb_pizza;
DROP TABLE tb_cliente;
DROP TABLE tb_pedido;

CREATE TABLE tb_pizza (id BIGINT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(255) NOT NULL, valor NUMERIC(18,2) NOT NULL);
CREATE TABLE tb_cliente (telefone VARCHAR(11) PRIMARY KEY, nome VARCHAR(255) NOT NULL, endereco VARCHAR(255) NOT NULL);
CREATE TABLE tb_pedido (id BIGINT AUTO_INCREMENT PRIMARY KEY, data TIMESTAMP NOT NULL DEFAULT NOW(), quantidade INTEGER NOT NULL, pizza_id INTEGER NOT NULL, telefone varchar(11) NOT NULL);

ALTER TABLE tb_pedido ADD FOREIGN KEY (pizza_id)  REFERENCES tb_pizza (id);
ALTER TABLE tb_pedido ADD FOREIGN KEY (telefone)  REFERENCES tb_cliente (telefone);


#COMANDO DML - Data Manipulation Language (Linguagem de manipulação de dados) 

INSERT INTO tb_pizza(id, nome, valor) VALUES (1, 'Muzzarela', 30.50);
INSERT INTO tb_pizza(id, nome, valor) VALUES (2, 'Calabreza', 25.50);
INSERT INTO tb_pizza VALUES (3, 'Frango com catupiry', 45.89);
INSERT INTO tb_pizza VALUES (4, 'Beterraba', 10);


INSERT INTO tb_cliente(telefone, nome, endereco) VALUES ('11999999999', 'Marcos', 'Av. Paulista, 1578');
INSERT INTO tb_cliente VALUES ('11999999998', 'Renato', 'Av. Pedro Álvares Cabral, portão: 02');
INSERT INTO tb_cliente VALUES ('11999999997', 'Rodrigo', 'Av. Guarapiranga, 575');

INSERT INTO tb_pedido(id, quantidade, pizza_id, telefone) VALUES (1, 2, 1, 11999999999);
INSERT INTO tb_pedido(id, quantidade, pizza_id, telefone) VALUES (2, 1, 2, 11999999998);
INSERT INTO tb_pedido(id, quantidade, pizza_id, telefone) VALUES (3, 1, 3, 11999999997);
INSERT INTO tb_pedido(id, quantidade, pizza_id, telefone) VALUES (4, 1, 3, 11999999999);  
INSERT INTO tb_pedido(id, quantidade, pizza_id, telefone) VALUES (5, 1, 1, 11999999999);  

UPDATE tb_pizza SET nome='Calabreza com cebola', valor=30.40 WHERE id = 2;

DELETE FROM tb_pizza WHERE id=4;


#COMANDO DQL - Data Query Language (linguagem de consulta de dados)
SELECT * FROM tb_pizza;
SELECT id, nome, valor FROM tb_pizza WHERE id = 1;
SELECT id, nome, valor FROM tb_pizza WHERE id <> 1;
SELECT id, nome, valor FROM tb_pizza WHERE id > 1;
SELECT id, nome, valor FROM tb_pizza WHERE id <= 2;
SELECT * FROM tb_pizza WHERE id IN (1,3);
SELECT valor FROM tb_pizza WHERE nome = 'Muzzarela';
SELECT * FROM tb_pizza WHERE nome like '%a%';
SELECT * FROM tb_pizza WHERE nome like '%a';
SELECT * FROM tb_pizza WHERE nome like 'a%';
SELECT COUNT(*) FROM tb_pizza WHERE valor > 40;


SELECT b.id AS pedido, b.data, b.quantidade, a.telefone, a.nome AS cliente, c.nome AS pizza, c.valor
FROM tb_cliente  AS a INNER JOIN tb_pedido AS b ON a.telefone = b.telefone
INNER JOIN tb_pizza AS c ON c.id = b.pizza_id;

SELECT b.id AS pedido, b.data, b.quantidade, a.telefone, a.nome AS cliente, c.nome AS pizza, c.valor
FROM tb_cliente  AS a INNER JOIN tb_pedido AS b ON a.telefone = b.telefone
INNER JOIN tb_pizza AS c ON c.id = b.pizza_id ORDER BY a.nome ASC;

SELECT b.id AS pedido, b.data, b.quantidade, a.telefone, a.nome AS cliente, c.nome AS pizza, c.valor
FROM tb_cliente  AS a INNER JOIN tb_pedido AS b ON a.telefone = b.telefone
INNER JOIN tb_pizza AS c ON c.id = b.pizza_id ORDER BY a.nome DESC;

SELECT b.id AS pedido, b.data, b.quantidade, a.telefone, a.nome AS cliente, c.nome AS pizza, c.valor
FROM tb_cliente  AS a INNER JOIN tb_pedido AS b ON a.telefone = b.telefone
INNER JOIN tb_pizza AS c ON c.id = b.pizza_id ORDER BY a.nome, b.quantidade ASC;

SELECT a.nome AS cliente, SUM(b.quantidade) AS quantidade_total_venda,  SUM(c.valor) AS total_venda 
FROM tb_cliente  AS a INNER JOIN tb_pedido AS b ON a.telefone = b.telefone
INNER JOIN tb_pizza AS c ON c.id = b.pizza_id 
WHERE data > TIMESTAMP '2022-06-20 19:00:00'
GROUP BY a.nome;

SELECT a.nome AS cliente, SUM(b.quantidade) AS quantidade_total_venda,  SUM(c.valor) AS total_venda 
FROM tb_cliente  AS a INNER JOIN tb_pedido AS b ON a.telefone = b.telefone
INNER JOIN tb_pizza AS c ON c.id = b.pizza_id 
WHERE data > TIMESTAMP '2022-06-20 19:00:00'  
AND  data < TIMESTAMP '2022-06-22 19:00:00'
GROUP BY a.nome;

#Gera o plano de execução da consulta abaixo
EXPLAIN SELECT a.nome AS cliente, SUM(b.quantidade) AS quantidade_total_venda,  SUM(c.valor) AS total_venda 
FROM tb_cliente  AS a INNER JOIN tb_pedido AS b ON a.telefone = b.telefone
INNER JOIN tb_pizza AS c ON c.id = b.pizza_id 
WHERE data > TIMESTAMP '2022-06-20 19:00:00'  
AND  data < TIMESTAMP '2022-06-22 19:00:00'
GROUP BY a.nome;

#Melhora a performance 
- Normalização correta das tabelas;
- Montagem das consultas utilizando os índices corretos; 
- Regras de expurgo de dados;
- Ajustes corretos no banco (tunar o banco) tanto na configuração do banco como na configuração da máquina (processador, memória, espaço em disco, cluster, etc.)


#Nunca esqueça, o banco precisa de:
- regras de backup; 
 




  