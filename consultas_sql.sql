--ALTER TABLE
ALTER TABLE TELEFONES
ADD Celular VARCHAR2(20)

--CREATE INDEX
CREATE INDEX index_pessoas
ON PESSOAS (NOME, ENDERECO, CPF, NASCIMENTO, CPF_INDICA);

--INSERT INTO
INSERT INTO Evento_Esportivo (Mandante, Visitante, Estadio) VALUES ('Manchester City', 'Fluminense', 'King Abdullah Sports City');

--UPDATE
UPDATE DADOS_BANCARIOS
SET AGENCIA ='4522-2'
WHERE ID_CONTA = 13;

--DELETE
--deletando as dependências
DELETE FROM Apostar 
WHERE ID_Evento = 18;
DELETE FROM DataHora
WHERE ID_Evento = 18;

--deletando o evento
DELETE FROM Evento_Esportivo
WHERE ID_Evento = 18;

--SELECT-FROM-WHERE
SELECT ID_Evento
FROM Evento_Esportivo
WHERE Mandante = 'Botafogo' AND Visitante = 'Flamengo';

--BETWEEN
SELECT *
FROM CONTA
WHERE SALDO BETWEEN 500 AND 1000

--IN
SELECT *
FROM Evento_Esportivo
WHERE Mandante IN ('Fluminense', 'Sport', 'São Paulo');

--LIKE
SELECT * 
FROM Pessoas_movimentam_contas
WHERE CPF LIKE '2__.___.___-__' ;

--IS NULL ou IS NOT NULL
UPDATE Telefones
SET Celular = '8199113-1829'
WHERE CPF = '244.244.244-23'

SELECT *
FROM Telefones
WHERE Celular IS NOT NULL;

--INNER JOIN
SELECT Evento_Esportivo.Mandante, Evento_Esportivo.Visitante, Evento_Esportivo.Estadio, DataHora.ID_Evento, DataHora.DataHora
FROM DataHora
INNER JOIN Evento_Esportivo ON Evento_Esportivo.ID_Evento = DataHora.ID_Evento;

--MAX
SELECT MAX(SALDO)
FROM Conta;

--MIN
SELECT MIN(VALOR)
FROM Pessoas_movimentam_contas;

--AVG
SELECT AVG(VALOR)
FROM Pessoas_movimentam_contas;

--COUNT
SELECT COUNT(*) AS highest_deposits
FROM Pessoas_movimentam_contas
WHERE VALOR > 1000;

--LEFT ou RIGHT ou FULL OUTER JOIN
SELECT Pessoas.Nome, Pessoas.CPF, Pessoas_movimentam_contas.Valor
FROM Pessoas
LEFT JOIN Pessoas_movimentam_contas ON Pessoas.CPF = Pessoas_movimentam_contas.CPF;

--SUBCONSULTA COM OPERADOR RELACIONAL
SELECT Saldo
FROM Conta
WHERE Saldo > (
    SELECT AVG(Saldo)
    FROM Conta
);

--SUBCONSULTA COM IN
SELECT Nome
FROM Pessoas
WHERE CPF IN (
    SELECT CPF
    FROM Pessoas_movimentam_contas
);

--SUBCONSULTA COM ANY
SELECT Nome
FROM Pessoas
WHERE CPF = ANY (
    SELECT CPF
    FROM Telefones
);

--SUBCONSULTA COM ALL***
SELECT ID_Evento
FROM Evento_Esportivo
WHERE ID_Evento = ALL (
    SELECT ID_Evento
    FROM Apostar
    WHERE Valor > 100.00
);

--ORDER BY
SELECT *
FROM Pessoas_movimentam_contas
ORDER BY VALOR DESC;

--GROUP BY
SELECT COUNT (Saldo) as contas, Saldo as valores_saldo
FROM CONTA
GROUP BY Saldo;

--HAVING
SELECT COUNT (Saldo) as contas, Saldo as valores_saldo
FROM CONTA
GROUP BY Saldo
HAVING Saldo > 100;

--UNION ou INTERSECT ou MINUS
SELECT CPF
FROM Pessoas
MINUS
SELECT CPF
FROM Pessoas_movimentam_contas;

--CREATE VIEW
CREATE VIEW FogaoMengudo AS
SELECT ID_Evento
FROM Evento_Esportivo
WHERE Mandante = 'Botafogo' AND Visitante = 'Flamengo';

--GRANT / REVOKE
CREATE USER jp IDENTIFIED BY jp123;
CONNECT jp/jp123;
GRANT SELECT ON Pessoas TO jp;

SELECT * FROM Pessoas;

REVOKE SELECT ON Pessoas FROM jp;

SELECT * FROM Pessoas;