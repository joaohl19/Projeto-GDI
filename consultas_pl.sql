--USO DE RECORD
--USO DE ESTRUTURA DE DADOS DO TIPO TABLE
--BLOCO ANÔNIMO
--CREATE PROCEDURE
--CREATE FUNCTION
--%TYPE
--%ROWTYPE
--IF ELSIF
--CASE WHEN
--LOOP EXIT WHEN
--WHILE LOOP
--FOR IN LOOP
--SELECT … INTO
--CURSOR (OPEN, FETCH e CLOSE)
--EXCEPTION WHEN
--USO DE PAR METROS (IN, OUT ou IN OUT)
--CREATE OR REPLACE PACKAGE
--CREATE OR REPLACE PACKAGE BODY
--CREATE OR REPLACE TRIGGER (COMANDO)
-- Trigger para impedir que uma pessoa seja excluída se ela possuir apostas associadas
CREATE OR REPLACE TRIGGER BEFORE_DELETE_PESSOAS
BEFORE DELETE ON Pessoas
FOR EACH ROW
DECLARE
    contador_apostas NUMBER;
BEGIN
    -- Verifica se a pessoa possui apostas
    SELECT COUNT(*)
    INTO contador_apostas
    FROM Apostar
    WHERE CPF = :OLD.CPF;

    -- Se houver apostas, impede a exclusão
    IF contador_apostas > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Não é possível excluir uma pessoa com apostas.');
    END IF;
END;
/

--CREATE OR REPLACE TRIGGER (LINHA)
-- Trigger para impedir que seja inserida uma conta com saldo negativo
CREATE OR REPLACE TRIGGER VerificarSaldoNegativo
BEFORE INSERT ON Conta
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.Saldo < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Não é permitido inserir uma conta com saldo negativo.');
    END IF;
END;
/