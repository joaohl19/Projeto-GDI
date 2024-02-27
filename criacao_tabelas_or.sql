/* VER SE ESSE CREATE SEQUENCE TB FUNCIONA PRA ATRIBUTOS DE UM TIPO */
CREATE SEQUENCE seq_conta START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE SEQUENCE seq_evento START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

/*TIPO ABSTRATO : DADOS BANCÁRIOS*/
CREATE OR REPLACE TYPE tp_dados_bancarios AS OBJECT (
    Conta VARCHAR2(20),
    Agencia VARCHAR2(20)
)NOT INSTANTIABLE;


/*TIPO TELEFONE + MÉTODO MAP QUE ORDENA AS INSTÂNCIAS PELO DDD */
CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
    Telefone VARCHAR2(20),
    MAP MEMBER FUNCTION codigo_postal RETURN VARCHAR2    
);
CREATE OR REPLACE TYPE BODY tp_telefone AS 
MEMBER FUNCTION codigo_postal RETURN VARCHAR2 IS
BEGIN
    RETURN SUBSTR(Telefone, 1, 2);
END;
END;
/* CRIAÇÃO DO TIPO VARRAY: CADA PESSOA PODE TER NO MÁXIMO 3 TELEFONES */
CREATE OR REPLACE TYPE tp_telefones AS VARRAY(3) OF tp_telefone;

/* TIPO PESSOA */
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    Nome VARCHAR2(255),
    Endereco VARCHAR2(255),
    CPF VARCHAR2(20),
    Nascimento DATE,
    Telefones tp_telefones
);
/* TIPO CONTA + MÉTODO QUE COMPARA SALDO */
CREATE OR REPLACE TYPE tp_conta AS OBJECT (
    ID_Conta NUMBER DEFAULT seq_conta.NEXTVAL,
    Saldo DECIMAL(10,2),
    Dados_Bancarios tp_dados_bancarios,
    ORDER MEMBER FUNCTION compara_saldo(X tp_conta) RETURN INTEGER
);
CREATE OR REPLACE TYPE BODY tp_conta AS 
ORDER MEMBER FUNCTION compara_saldo(X tp_conta) 
RETURN INTEGER IS
BEGIN
RETURN (SELF.saldo - X.saldo)
END;
END;


/* TIPO PESSOAS MOVIMENTAM CONTAS + MÉTODO QUE EXIBE A TRANSAÇÃO */
CREATE OR REPLACE TYPE tp_pessoas_movimentam_contas AS OBJECT (
    Pessoa REF tp_pessoa,
    Conta REF tp_conta,
    valor DECIMAL(10,2) CHECK (Valor > 0),
    DataHora TIMESTAMP,

    MEMBER PROCEDURE exibir_transação 
);
CREATE OR REPLACE TYPE BODY tp_pessoas_movimentam_contas AS 
MEMBER PROCEDURE exibir_transação IS
BEGIN
FOR i IN 1..tb_pessoas_movimentam_contas.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Nome : ' || VALUE(tb_pessoas_movimentam_contas(i).Pessoa).Nome);
    DBMS_OUTPUT.PUT_LINE('CPF : ' || DEREF(tb_pessoas_movimentam_contas(i).Pessoa).CPF);
    DBMS_OUTPUT.PUT_LINE('ID_Conta : ' || tb_pessoas_movimentam_contas(i).Conta.ID_Conta);
    DBMS_OUTPUT.PUT_LINE('Valor : ' || tb_pessoas_movimentam_contas(i).valor);
    DBMS_OUTPUT.PUT_LINE('Data e Hora : ' || tb_pessoas_movimentam_contas(i).DataHora); 
END LOOP
END;
END;

/* TIPO EVENTO ESPORTIVO + MÉTODO QUE EXIBE O EVENTO
+ MÉTODO QUE MAPEIA OS EVENTOS DE ACORDO COM DataHora */
CREATE OR REPLACE TYPE tp_evento_esportivo AS OBJECT (
    Mandante VARCHAR2(255),
    Visitante VARCHAR2(255),
    Estadio VARCHAR2(255),
    ID_Evento NUMBER DEFAULT seq_evento.NEXTVAL,
    DataHora TIMESTAMP,
    
    MEMBER PROCEDURE exibir_partida(SELF tp_evento_esportivo),

    FINAL MAP MEMBER FUNCTION mapear_datahora RETURN TIMESTAMP
);
CREATE OR REPLACE TYPE BODY tp_evento_esportivo AS 

MEMBER PROCEDURE exibir_partida(SELF tp_evento_esportivo) IS
BEGIN
DBMS_OUTPUT.PUT_LINE(Mandante || "  X  " || Visitante);
DBMS_OUTPUT.PUT_LINE(Estadio);
DBMS_OUTPUT.PUT_LINE(DataHora); 
END;

FINAL MEMBER FUNCTION mapear_datahora RETURN TIMESTAMP
datahora TIMESTAMP := DataHora;
BEGIN
RETURN datahora;
END;
END;

/* TIPO BÔNUS + FUNÇÃO QUE RETORNA O SALDO DA PESSOA APÓS ESSE BÔNUS */
CREATE OR REPLACE TYPE tp_bonus AS OBJECT (
    código_bonus VARCHAR2(20),
    valor DECIMAL(10,2) CHECK (valor > 0),

    MEMBER FUNCTION saldo_pos_bonus(Pessoa tp_pessoa) RETURN NUMBER
);
CREATE OR REPLACE TYPE BODY tp_bonus AS
MEMBER FUNCTION saldo_pos_bonus(Pessoas tp_pessoa) RETURN NUMBER IS
val_bonus DECIMAL(10,2);
BEGIN
    SELECT T.valor INTO val_bonus
    FROM Pessoa.bonus_recebido T
    WHERE (T.código_bonus == Código_bonus) AND (T.valor == Valor);

    RETURN(Pessoa.saldo + val_bonus);
END;
END;

/* TIPO APOSTA FUNÇÃO QUE RETORNA OS GANHOS DESSA APOSTA */
CREATE OR REPLACE TYPE tp_apostas AS OBJECT (
    ID_Aposta NUMBER,
    Odd NUMBER(5, 2) CHECK(Odd > 1),
    NOT FINAL MEMBER FUNCTION ganho (X tp_apostar) RETURN NUMBER
)NOT FINAL;

CREATE OR REPLACE TYPE BODY tp_apostas AS 
NOT FINAL MEMBER FUNCTION ganho(X tp_apostar) IS
Valor X.valor%TYPE = X.valor;
Retorno X.valor%TYPE;
BEGIN
Retorno = Valor * Odd;
RETURN Retorno;
END
END;

/* SUBTIPO GOLS COM UMA FUNÇÃO CONSTRUTORA */
CREATE OR REPLACE TYPE tp_gols UNDER tp_apostas(
    Quantidade INT,
    CONSTRUCTOR FUNCTION tp_gols(X tp_apostas, Quantidade INT) RETURN SELF AS RESULT
)FINAL;
CREATE OF REPLACE TYPE BODY tp_gols AS
CONSTRUCTOR FUNCTION tp_gols(X tp_apostas, Quantidade INT) RETURN SELF AS RESULT IS
BEGIN
    SELF.ID_Aposta := X.ID_Aposta,
    SELF.Quantidade := Quantidade
    RETURN;
END;
END;

/*SUBTIPO PLACAR COM MODIFICAÇÃO DA FUNÇÃO QUE RETORNA OS GANHOS
DO TIPO APOSTA */
CREATE OR REPLACE TYPE tp_placar UNDER tp_apostas(
    Gol_Mandante INT,
    Gol_Visitante INT,
    OVERRIDING FINAL MEMBER FUNCTION ganho RETURN NUMBER
)FINAL;
CREATE OR REPLACE TYPE BODY tp_placar AS 
OVERRIDING NOT FINAL MEMBER FUNCTION ganho(X tp_apostar) IS
Valor X.valor%TYPE = X.valor;
Retorno X.valor%TYPE;
BEGIN
Retorno = Valor * Odd * 1.2;
RETURN Retorno;
END
END;

/* TIPO RESULTADO */
CREATE OR REPLACE TYPE tp_resultado UNDER tp_apostas(
    Resultado VARCHAR2(255) CHECK (Resultado IN ('Mandante', 'Visitante', 'Empate'))
)FINAL;

/* TIPO AMBOS_MARCAM */
CREATE OR REPLACE TYPE tp_ambos_marcam UNDER tp_apostas(
    Sim_Nao VARCHAR2(3) CHECK (Sim_Nao IN ('Sim', 'Nao'))
)FINAL;

/*TABELAS DE OBJETOS*/
CREATE TABLE tb_pessoas_movimentam_contas OF tp_pessoas_movimentam_contas(
    Pessoa WITH ROWID REFERENCES tb_pessoas,
    Conta WITH ROWID REFERECES tb_conta,
    valor NOT NULL,
    DataHora NOT NULL
);
CREATE TABLE tb_evento_esportivo OF tp_evento_esportivo(
    ID_Evento PRIMARY KEY,
    Mandante NOT NULL,
    Visitante NOT NULL,
    Estadio NOT NULL,
    DataHora NOT NULL
);
CREATE TABLE tb_gols OF tp_gols(
    ID_Aposta PRIMARY KEY,
    Quantidade NOT NULL,
);
CREATE TABLE tb_ambos_marcam OF tp_ambos_marcam;
CREATE TABLE tb_placar OF tp_placar(
    Gol_Mandante NOT NULL,
    Gol_Visitante NOT NULL
);
CREATE TABLE tb_resultado OF tp_resultado;
CREATE TABLE tb_conta OF tp_conta(
    ID_Conta PRIMARY KEY,
    Saldo NOT NULL,
    Dados_Bancarios NOT NULL,

);
CREATE TABLE tb_bonus OF tp_bonus(
    código_bonus NOT NULL,
    valor NOT NULL
);

/* RELACIONAMENTOS */
/* 1.Apostar + TIPO APOSTAR + MÉTODO QUE EXIBE AS APOSTAS FEITAS AO VIVO
+ CRIAÇÃO DA TABELA DE OBJETOS DO TIPO APOSTAR */
CREATE OR REPLACE TYPE tp_apostar AS OBJECT(
    pessoas_movimentam_contas REF tp_pessoas_movimentam_contas,
    apostas REF tp_apostas,
    evento_esportivo REF tp_evento_esportivo,
    valor DECIMAL(10, 2) CHECK(valor > 0),

    MEMBER PROCEDURE apostas_aovivo
)
CREATE OF REPLACE TYPE BODY tp_apostar AS
MEMBER PROCEDURE apostas_aovivo(X tp_apostar) RETURN NUMBER IS
n NUMBER := 0;
soma := 0;
DataHora X.evento_esportivo.DataHora%TYPE;
Valor DECIMAL(10, 2);
BEGIN 
    FOR cur IN(
        SELECT * FROM tb_apostar.evento_esportivo WHERE tb_apostar.pessoas_movimentam_contas.DataHora >= tb_apostar.evento_esportivo.DataHora) LOOP
        
        DataHora := cur.DataHora;
        Valor = X.valor;
        n  :=  n + 1;
        soma := soma + Valor;

        DBMS_OUTPUT.PUT_LINE(Mandante || "  X  " || Visitante);
        DBMS_OUTPUT.PUT_LINE(Estadio);
        DBMS_OUTPUT.PUT_LINE("Hora do jogo : " || DataHora);
        DBMS_OUTPUT.PUT_LINE("Hora da aposta : " || X.pessoas_movimentam_contas.DataHora);
        DBMS_OUTPUT.PUT_LINE("Valor da aposta : " || Valor);  
    END LOOP;
    DBMS_OUTPUT.PUT_LINE("Número de apostas : " || n);
    DBMS_OUTPUT.PUT_LINE("Valor total apostado : " || soma);
END;
END;

CREATE TABLE tb_apostar OF tp_apostar(
    evento_esportivo WITH ROWID REFERENCES tb_evento_esportivo,
    aposta WITH ROWID REFERENCES (tb_ambos_marcam, tb_gols, tb_placar, tb_resultado)
);

/* 2.Recebe + NESTED TABLE tb_bonus_recebidos + REDEFINIÇÃO DO TIPO PESSOA
PRA REPRESENTAR O RELACIONAMENTO 1:N + MÉTODOS PRA EXIBIR O CONTEÚDO DAS 
NESTED TABLES*/

CREATE OR REPLACE TYPE tb_bonus_recebidos AS TABLE OF tp_bonus;

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    Nome VARCHAR2(255),
    Endereco VARCHAR2(255),
    CPF VARCHAR2(20),
    Nascimento DATE,
    Telefones tp_telefones,
    bonus_recebido tb_bonus_recebidos,
    
    MEMBER PROCEDURE exibir_telefones(SELF tp_pessoa),
    MEMBER PROCEDURE exibir_bonus(SELF tp_pessoa)

);

/* 3.Indica + REDEFINIÇÃO DO TIPO PESSOA
PRA REPRESENTAR O RELACIONAMENTO 1:N */

CREATE OR REPLACE TYPE tp_indicadores AS OBJECT (
    Nome VARCHAR2(255),
    Endereco VARCHAR2(255),
    CPF VARCHAR2(20),
    Nascimento DATE,
    Telefones tp_telefones,
    bonus_recebido tb_bonus_recebidos
);
ALTER TYPE tp_pessoa
ADD ATTRIBUTE(Indicador REF tp_indicadores) CASCADE;


CREATE OR REPLACE TYPE BODY tp_pessoa AS 
MEMBER PROCEDURE exibir_telefones IS
cont NUMBER := 0;
BEGIN
FOR i IN 1..tp_telefones.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Telefone : ' || tp_telefones(i).Telefone);
    cont := cont + 1;
END LOOP
IF cont = 0 THEN 
    DBMS_OUTPUT.PUT_LINE('Nenhum telefone encontrado!');
END IF;
END;

MEMBER PROCEDURE exibir_bonus IS
BEGIN
FOR i IN 1..tb_lista_bonus.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Nome : ' || tb_lista_indicados(i).código_bonus);
    DBMS_OUTPUT.PUT_LINE('CPF : ' || tb_lista_indicados(i).valor);

END LOOP;
END;
END;

CREATE TABLE tb_indicadores OF tp_indicadores(
    Nome NOT NULL,
    Endereco NOT NULL,
    CPF PRIMARY KEY,
    Nascimento NOT NULL
)

/* TABELA DE OBJETOS DO TIPO PESSOA */
CREATE TABLE tb_pessoas OF tp_pessoa(
    Indicador SCOPE IS tb_indicadores,
    Nome NOT NULL,
    Endereco NOT NULL,
    CPF PRIMARY KEY,
    Nascimento NOT NULL,
    NESTED TABLE bonus_recebido STORE AS tb_lista_bonus
);














