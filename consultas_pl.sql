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

--BLOCO ANÔNIMO + SELECT … INTO
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

--CREATE PROCEDURE
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
--%TYPE
--%ROWTYPE
--IF ELSIF
--CASE WHEN
--LOOP EXIT WHEN
--WHILE LOOP
--FOR IN LOOP
--CURSOR (OPEN, FETCH e CLOSE)
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
