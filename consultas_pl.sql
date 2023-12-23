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
  -- Atribuindo valores ao registro
  meu_registro.id := 1;
  meu_registro.nome := 'João';

  -- Printando os valores do registro
  DBMS_OUTPUT.PUT_LINE('Nome: ' || meu_registro.nome);
  DBMS_OUTPUT.PUT_LINE('ID: ' || meu_registro.id);
END;
/

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
/

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
/

--CREATE PROCEDURE + SELECT … INTO
CREATE OR REPLACE PROCEDURE CONSULTA_PARTIDAS(TIME1 IN VARCHAR2, TIME2 IN VARCHAR2) AS
    COLUNA_AUX NUMBER;
BEGIN
    SELECT ID_Evento INTO COLUNA_AUX
    FROM Evento_Esportivo
    WHERE Mandante = TIME1 AND Visitante = TIME2;

    DBMS_OUTPUT.PUT_LINE('ID_Evento: '  || COLUNA_AUX);
END;
/
EXEC CONSULTA_PARTIDAS('Fluminense', 'Vasco')


--CREATE FUNCTION 
--Função para calcular a porcentagem de gols do mandante em um evento

CREATE OR REPLACE FUNCTION PorcentagemGolMandante
    (ID_Aposta NUMBER)
    RETURN DECIMAL
IS
    TotalGols NUMBER;
    Porcentagem NUMBER;
BEGIN
    SELECT SUM(Gol_Mandante + Gol_Visitante)
    INTO TotalGols
    FROM Placar_Exato
    WHERE ID_Aposta = ID_Aposta;

    SELECT (Gol_Mandante / TotalGols) * 100
    INTO Porcentagem
    FROM Placar_Exato
    WHERE ID_Aposta = ID_Aposta;

    RETURN Porcentagem;
END;

--%TYPE
--Salva o tipo de uma coluna em uma variável

DECLARE 
    nome Pessoas.Nome%TYPE;
    cpf Pessoas.CPF%TYPE;
BEGIN
    SELECT Nome, CPF
    INTO nome, cpf
    FROM Pessoas
    WHERE CPF = '888.777.666-22';
END;


--%ROWTYPE
--Salva o resultado de uma consulta em uma variável do tipo ROWTYPE

CREATE OR REPLACE FUNCTION get_pessoas_info(p_pessoas_id IN Pessoas.CPF%TYPE)
RETURN Pessoas%ROWTYPE
IS
    v_pessoas_info Pessoas%ROWTYPE;
BEGIN
    SELECT *
    INTO v_pessoas_info
    FROM Pessoas
    WHERE CPF = p_pessoas_id;

    RETURN v_pessoas_info;
END;


--IF ELSIF
--Verifica se o saldo é maior que 0, menor que 0 ou igual a 0

CREATE OR REPLACE PROCEDURE check_account_status(ID_Conta IN NUMBER)
IS
    c_saldo DECIMAL(10, 2);
BEGIN

    SELECT Saldo
    INTO c_saldo
    FROM Conta
    WHERE ID_Conta = ID_Conta;

    IF c_saldo > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Pode apostar');
    ELSIF c_saldo < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Devendo');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Não pode apostar');
    END IF;
END;



--CASE WHEN
--Verifica se o saldo é maior que 0, menor que 0 ou igual a 0

CREATE OR REPLACE PROCEDURE check_account_status(ID_Conta IN NUMBER)
IS
    c_saldo DECIMAL(10, 2);
BEGIN
    SELECT Saldo
    INTO c_saldo
    FROM Conta
    WHERE ID_Conta = ID_Conta;

    CASE
        WHEN c_saldo > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Pode apostar');
        WHEN c_saldo < 0 THEN
            DBMS_OUTPUT.PUT_LINE('Devendo');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Não pode apostar');
    END CASE;
END;


--EXIT LOOP WHEN
--Sair do loop quando o saldo for maior que 0

CREATE OR REPLACE PROCEDURE check_account_status(ID_Conta IN NUMBER)
IS
    c_saldo DECIMAL(10, 2);
BEGIN
    SELECT Saldo
    INTO c_saldo
    FROM Conta
    WHERE ID_Conta = ID_Conta;

    LOOP
        EXIT WHEN c_saldo > 0;
        DBMS_OUTPUT.PUT_LINE('Saldo negativo');
    END LOOP;
END;


--FOR IN LOOP
--Loop para somar o saldo de todas as contas

CREATE OR REPLACE PROCEDURE calculate_total_balance
IS
    v_saldo_total DECIMAL(10, 2) := 0;
    CURSOR Conta_cursor IS
        SELECT Saldo FROM Conta;
BEGIN
    FOR Conta_rec IN Conta_cursor
    LOOP
        v_saldo_total := v_saldo_total + Conta_rec.Saldo;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Saldo total da tabela: ' || v_saldo_total);
END;

--WHILE LOOP
--Loop para somar o saldo de todas as contas

CREATE OR REPLACE PROCEDURE calculate_total_balance
IS
    v_saldo_total DECIMAL(10, 2) := 0;
    CURSOR Conta_cursor IS
        SELECT Saldo FROM Contas;
BEGIN
    OPEN Conta_cursor;
    LOOP
        FETCH Conta_cursor INTO v_saldo_total;
        EXIT WHEN Conta_cursor%NOTFOUND;
        v_saldo_total := v_saldo_total + Conta_rec.Saldo;
    END LOOP;
    CLOSE Conta_cursor;

    DBMS_OUTPUT.PUT_LINE('Saldo total da tabela: ' || v_saldo_total);
END;


--SELECT … INTO
--Seleciona o saldo de uma conta e o exibe

CREATE OR REPLACE PROCEDURE get_account_balance(ID_Conta IN NUMBER)
IS
    v_saldo DECIMAL(10, 2);
BEGIN
    SELECT Saldo
    INTO v_saldo
    FROM Conta
    WHERE ID_Conta = ID_Conta;

    DBMS_OUTPUT.PUT_LINE('Saldo da conta: ' || v_saldo);
END;


--CURSOR (OPEN, FETCH e CLOSE) 
--Exibe todas as pessoas cadastradas

CREATE OR REPLACE PROCEDURE get_all_pessoas
IS
    CURSOR pessoas_cursor IS
        SELECT *
        FROM Pessoas;
    v_pessoas pessoas_cursor%ROWTYPE;
BEGIN
    OPEN pessoas_cursor;
    LOOP
        FETCH pessoas_cursor INTO v_pessoas;
        EXIT WHEN pessoas_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_pessoas.Nome || ', CPF: ' || v_pessoas.CPF);
    END LOOP;
    CLOSE pessoas_cursor;
END;


--EXCEPTION WHEN
CREATE OR REPLACE PROCEDURE inserir_pessoa(
    p_nome VARCHAR2,
    p_endereco VARCHAR2,
    p_cpf VARCHAR2,
    p_nascimento DATE,
    p_cpf_indica VARCHAR2
)
AS
BEGIN
    -- Tenta inserir uma pessoa na tabela Pessoas
    INSERT INTO Pessoas (Nome, Endereco, CPF, Nascimento, CPF_Indica)
    VALUES (p_nome, p_endereco, p_cpf, p_nascimento, p_cpf_indica);

    -- Se a inserção for bem-sucedida, exibe uma mensagem
    DBMS_OUTPUT.PUT_LINE('Pessoa inserida com sucesso!');
EXCEPTION
    -- Captura exceções específicas
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: CPF já existente na tabela Pessoas!');
    WHEN OTHERS THEN
        -- Captura outras exceções não tratadas
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END;
/

-- Exemplo de uso do procedimento que gera exceção
BEGIN
    inserir_pessoa('João', 'Rua A', '12345678901', SYSDATE, '98765432109');
END;
/

--USO DE PARAMETROS (IN, OUT ou IN OUT)
CREATE OR REPLACE PROCEDURE AtualizarSaldo (
  p_id_conta IN Conta.ID_Conta%TYPE,
  p_valor IN OUT DECIMAL
) IS
  v_saldo_atual DECIMAL(10,2);
BEGIN
  -- Obtém o saldo atual da conta
  SELECT Saldo
  INTO v_saldo_atual
  FROM Conta
  WHERE ID_Conta = p_id_conta;

  -- Atualiza o saldo da conta
  UPDATE Conta
  SET Saldo = v_saldo_atual + p_valor
  WHERE ID_Conta = p_id_conta;

  -- Atualiza o valor de saída
  p_valor := p_valor + v_saldo_atual;

  -- Exibe o resultado
  DBMS_OUTPUT.PUT_LINE('Saldo atualizado para: ' || (p_valor));
END AtualizarSaldo;
/

-- Exemplo de uso do procedimento
DECLARE
  v_id_conta Conta.ID_Conta%TYPE := 1;
  v_valor DECIMAL := 2000.00;
BEGIN
  AtualizarSaldo(v_id_conta, v_valor);
END;
/

--CREATE OR REPLACE PACKAGE
CREATE OR REPLACE PACKAGE PacoteExemplo AS
    -- Declaração de Função Pública para Calcular Saldo Total
    FUNCTION CalcularSaldoTotal(p_cpf IN VARCHAR2) RETURN DECIMAL;
END PacoteExemplo;
/

--CREATE OR REPLACE PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY PacoteExemplo AS
    -- Implementação da Função para Calcular Saldo Total
    FUNCTION CalcularSaldoTotal(p_cpf IN VARCHAR2) RETURN DECIMAL IS
        v_saldo_total DECIMAL(10,2) := 0;

        -- Cursor para Obter Saldo da Conta
        CURSOR c_saldo_conta (cpf_param VARCHAR2) IS
            SELECT Saldo
            FROM Conta c
            JOIN Pessoas_movimentam_contas pmc ON c.ID_Conta = pmc.ID_Conta
            WHERE pmc.CPF = cpf_param;

    BEGIN
        -- Loop pelo Cursor e Soma dos Saldos
        FOR saldo_rec IN c_saldo_conta(p_cpf) LOOP
            v_saldo_total := v_saldo_total + saldo_rec.Saldo;
        END LOOP;

        -- Retorna o Saldo Total
        RETURN v_saldo_total;
    END CalcularSaldoTotal;
END PacoteExemplo;
/

--Exemplo de teste para o pacote
DECLARE
    v_saldo_total DECIMAL(10,2);
BEGIN
    v_saldo_total := PacoteExemplo.CalcularSaldoTotal('111.222.333-44');
    DBMS_OUTPUT.PUT_LINE('Saldo Total: ' || v_saldo_total);
END;
/

--CREATE OR REPLACE TRIGGER (COMANDO)
-- Trigger para printar o número de eventos esportivos após um insert
CREATE OR REPLACE TRIGGER AfterInsertEvento
AFTER INSERT ON Evento_Esportivo
DECLARE
    num_eventos NUMBER;
BEGIN
    SELECT COUNT(*) INTO num_eventos FROM Evento_Esportivo;
    DBMS_OUTPUT.PUT_LINE('Número total de eventos esportivos: ' || num_eventos);
END;
/

-- Teste do trigger
INSERT INTO Evento_Esportivo (Mandante, Visitante, Estadio) VALUES ('TimeA', 'TimeB', 'EstadioX');

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

-- Teste do trigger
INSERT INTO Conta (Saldo) VALUES (-100.00);