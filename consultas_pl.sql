--USO DE RECORD
DECLARE
  -- Criando o tipo registro
  TYPE Registro IS RECORD (
    nome VARCHAR2(255),
    id NUMBER
  );
  -- Criando um objeto do tipo registro
  meu_registro Registro;
BEGIN
  -- atribuindo valores ao registro
  meu_registro.id := 1;
  meu_registro.nome := 'João';

  -- Printando os valores do registro
  DBMS_OUTPUT.PUT_LINE('Nome: ' || meu_registro.nome);
  DBMS_OUTPUT.PUT_LINE('ID: ' || meu_registro.id);
END;

--USO DE ESTRUTURA DE DADOS DO TIPO TABLE
DECLARE
   -- Definindo uma tabela indexada por valores
   TYPE Hashtable IS TABLE OF NUMBER INDEX BY VARCHAR2(255);

   -- Declarando uma variável do tipo tabela indexada
   tabela1 Hashtable;
BEGIN
   -- Inserindo elementos na tabela indexada
   tabela1('Chave1') := 19;
   tabela1('Chave2') := 22;

   -- Obtendo e exibindo valores da tabela indexada
   DBMS_OUTPUT.PUT_LINE('Valor para Chave1: ' || tabela1('Chave1'));
   DBMS_OUTPUT.PUT_LINE('Valor para Chave2: ' || tabela1('Chave2'));
END;
--BLOCO ANÔNIMO
DECLARE
   ID_conta NUMBER;
   Saldo DECIMAL(10, 2);
   Contador INTEGER;
BEGIN
   Contador := 1;
   FOR cliente IN (SELECT * FROM Conta WHERE Saldo > 200) LOOP
      DBMS_OUTPUT.PUT_LINE('Conta encontrada: ' || Contador || ', Idade: ' || cliente.Saldo);
      Contador := Contador + 1;
   END LOOP;
END;
--CREATE PROCEDURE
CREATE PROCEDURE ConsultaPartidas
    @TIME1 VARCHAR2(255),
    @TIME2 VARCHAR2(255)
AS
BEGIN
    SELECT ID_Evento
    FROM Evento_Esportivo
    WHERE Mandante = @TIME1 OR Visitante = @TIME2;
END;
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
--CREATE OR REPLACE TRIGGER (LINHA)

