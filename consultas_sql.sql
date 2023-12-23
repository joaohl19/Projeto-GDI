--ALTER TABLE
-- Adicionando uma coluna
ALTER TABLE TELEFONES
ADD Celular VARCHAR2(20)

--CREATE INDEX
CREATE INDEX index_pessoas
ON PESSOAS (NOME, ENDERECO, CPF, NASCIMENTO, CPF_INDICA);

--INSERT INTO
-- Inserindo um novo evento
INSERT INTO Evento_Esportivo (Mandante, Visitante, Estadio) VALUES ('Manchester City', 'Fluminense', 'King Abdullah Sports City');

--UPDATE
-- Atualizando um dado bancário com base no ID da conta
UPDATE DADOS_BANCARIOS
SET AGENCIA ='4522-2'
WHERE ID_CONTA = 13;

--DELETE
--deletando as dependências
DELETE FROM Apostar 
WHERE ID_Evento = 17;
DELETE FROM DataHora
WHERE ID_Evento = 17;

--deletando o evento
DELETE FROM Evento_Esportivo
WHERE ID_Evento = 17;

--SELECT-FROM-WHERE
-- Selecionando um evento com base no mandante e visitante
SELECT ID_Evento
FROM Evento_Esportivo
WHERE Mandante = 'Botafogo' AND Visitante = 'Flamengo';

--BETWEEN
-- Selecionando contas com saldo entre 500 e 1000
SELECT *
FROM CONTA
WHERE SALDO BETWEEN 500 AND 1000

--IN
-- Selecionando eventos que possuem tais mandantes
SELECT *
FROM Evento_Esportivo
WHERE Mandante IN ('Fluminense', 'Sport', 'São Paulo');

--LIKE
-- Selecionando pessoas_movimentam_contas com CPF que começa com 2
SELECT * 
FROM Pessoas_movimentam_contas
WHERE CPF LIKE '2__.___.___-__' ;

--IS NULL ou IS NOT NULL
-- Criando um celular na tabela de telefones e selecionando os celulares não nulos
UPDATE Telefones
SET Celular = '8199113-1829'
WHERE CPF = '244.244.244-23'

SELECT *
FROM Telefones
WHERE Celular IS NOT NULL;

--INNER JOIN
-- Selecionando a interseção entre as tabelas de evento e datahora
SELECT Evento_Esportivo.Mandante, Evento_Esportivo.Visitante, Evento_Esportivo.Estadio, DataHora.ID_Evento, DataHora.DataHora
FROM DataHora
INNER JOIN Evento_Esportivo ON Evento_Esportivo.ID_Evento = DataHora.ID_Evento;

--MAX
-- Selecionando o maior saldo entre as contas
SELECT MAX(SALDO)
FROM Conta;

--MIN
-- Selecionando o menor valor movimentado entre as pessoas
SELECT MIN(VALOR)
FROM Pessoas_movimentam_contas;

--AVG
-- Selecionando a média de valores movimentados entre as pessoas
SELECT AVG(VALOR)
FROM Pessoas_movimentam_contas;

--COUNT
SELECT COUNT(*) AS highest_deposits
FROM Pessoas_movimentam_contas
WHERE VALOR > 1000;

--LEFT ou RIGHT ou FULL OUTER JOIN
-- Left Join de pessoas com pessoas_movimentam_contas (conjunto pessoas + interseção)
SELECT Pessoas.Nome, Pessoas.CPF, Pessoas_movimentam_contas.Valor
FROM Pessoas
LEFT JOIN Pessoas_movimentam_contas ON Pessoas.CPF = Pessoas_movimentam_contas.CPF;

--SUBCONSULTA COM OPERADOR RELACIONAL
-- Selecionando contas com saldo maior que a média
SELECT Saldo
FROM Conta
WHERE Saldo > (
    SELECT AVG(Saldo)
    FROM Conta
);

--SUBCONSULTA COM IN
-- Selecionando pessoas com CPF que movimentam contas
SELECT Nome
FROM Pessoas
WHERE CPF IN (
    SELECT CPF
    FROM Pessoas_movimentam_contas
);

--SUBCONSULTA COM ANY
-- Selecionando pessoas que possuem telefone
SELECT Nome
FROM Pessoas
WHERE CPF = ANY (
    SELECT CPF
    FROM Telefones
);

--SUBCONSULTA COM ALL
-- Selecionando gols com quantidade maior que todas as apostas em gols
SELECT *
FROM Gols
WHERE Quantidade > ALL (
    SELECT ID_Aposta 
    FROM Aposta 
    WHERE Aposta.ID_Aposta = Gols.ID_Aposta
);

--ORDER BY
-- Selecionando pessoas_movimentam_contas ordenadas por valor
SELECT *
FROM Pessoas_movimentam_contas
ORDER BY VALOR DESC;

--GROUP BY
-- Agrupando contas com base no saldo
SELECT COUNT (Saldo) as contas, Saldo as valores_saldo
FROM CONTA
GROUP BY Saldo;

--HAVING
-- Agrupando contas que possuem saldo maior que 100
SELECT COUNT (Saldo) as contas, Saldo as valores_saldo
FROM CONTA
GROUP BY Saldo
HAVING Saldo > 100;

--UNION ou INTERSECT ou MINUS
-- Selecionando CPFs que estão em Pessoas mas não estão em Pessoas_movimentam_contas (diferença de conjuntos)
SELECT CPF
FROM Pessoas
MINUS
SELECT CPF
FROM Pessoas_movimentam_contas;

--CREATE VIEW
-- Criando uma view para selecionar eventos com mandante Botafogo e visitante Flamengo
CREATE VIEW FogaoMengudo AS
SELECT ID_Evento
FROM Evento_Esportivo
WHERE Mandante = 'Botafogo' AND Visitante = 'Flamengo';

--GRANT / REVOKE
-- Criando um usuário e dando/tirando permissão de SELECT na tabela Pessoas
CREATE USER jp IDENTIFIED BY jp123;
CONNECT jp/jp123;
GRANT SELECT ON Pessoas TO jp;

SELECT * FROM Pessoas;

REVOKE SELECT ON Pessoas FROM jp;

SELECT * FROM Pessoas;