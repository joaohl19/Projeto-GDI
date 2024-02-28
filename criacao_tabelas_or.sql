/*TIPO ABSTRATO : DADOS BANCÁRIOS*/
CREATE OR REPLACE TYPE tp_dados_bancarios AS OBJECT ( 
    Conta VARCHAR2(20), 
    Agencia VARCHAR2(20) 
) FINAL;


/*TIPO TELEFONE + MÉTODO MAP QUE ORDENA AS INSTÂNCIAS PELO DDD */
CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
    Telefone VARCHAR2(20),
    MAP MEMBER FUNCTION codigo_postal RETURN VARCHAR2    
)FINAL;

CREATE OR REPLACE TYPE BODY tp_telefone AS 
MEMBER FUNCTION codigo_postal RETURN VARCHAR2 IS
BEGIN
    RETURN SUBSTR(Telefone, 1, 2);
END;
END;
/* CRIAÇÃO DO TIPO VARRAY: CADA PESSOA PODE TER NO MÁXIMO 3 TELEFONES */
CREATE OR REPLACE TYPE tp_telefones AS VARRAY(3) OF tp_telefone;


/* TIPO CONTA + MÉTODO QUE COMPARA SALDO */
CREATE OR REPLACE TYPE tp_conta AS OBJECT (  
    ID_Conta NUMBER,  
    Saldo DECIMAL(10,2),  
    Dados_Bancarios tp_dados_bancarios,    
    ORDER MEMBER FUNCTION compara_saldo(X tp_conta) RETURN VARCHAR(10)  
)FINAL;
CREATE OR REPLACE TYPE BODY tp_conta AS  
ORDER MEMBER FUNCTION compara_saldo(X tp_conta)  
RETURN VARCHAR(10) IS 
BEGIN 
    IF (SELF.saldo - X.saldo > 0) THEN  
        RETURN "Maior"; 
    ELSE IF (SELF.saldo - X.saldo = 0) THEN 
        RETURN "Igual"; 
    ELSE 
        RETURN "Menor"; 
END; 
END;

/* TIPO EVENTO ESPORTIVO + MÉTODO QUE EXIBE O EVENTO
+ MÉTODO QUE MAPEIA OS EVENTOS DE ACORDO COM DataHora */
CREATE OR REPLACE TYPE tp_evento_esportivo AS OBJECT ( 
    Mandante VARCHAR2(255), 
    Visitante VARCHAR2(255), 
    Estadio VARCHAR2(255), 
    ID_Evento NUMBER, 
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
    valor DECIMAL(10,2), 
 
    MEMBER FUNCTION bonus_turbinado RETURN NUMBER 
);
CREATE OR REPLACE TYPE BODY tp_bonus AS 
MEMBER FUNCTION bonus_turbinado RETURN NUMBER IS 
val_bonus DECIMAL(10,2) := valor; 
BEGIN 
    IF (código_bonus = 'JOAO19') THEN  
        SELF.valor := valor * valor; 
    RETURN SELF.valor; 
END; 
END;

/* TIPO APOSTA FUNÇÃO QUE RETORNA OS GANHOS DESSA APOSTA */
CREATE OR REPLACE TYPE tp_apostas AS OBJECT ( 
    ID_Aposta NUMBER, 
    Odd NUMBER(5, 2), 
    NOT FINAL MAP MEMBER FUNCTION aposta_odd RETURN NUMBER 
)NOT INSTANTIABLE NOT FINAL;
CREATE OR REPLACE TYPE BODY tp_apostas AS  
NOT FINAL MAP MEMBER FUNCTION aposta_odd IS 
BEGIN 
RETURN Odd; 
END; 
END;

/* SUBTIPO GOLS COM UMA FUNÇÃO CONSTRUTORA */
CREATE OR REPLACE TYPE tp_gols UNDER tp_apostas( 
    Quantidade INT, 
    CONSTRUCTOR FUNCTION tp_gols(X tp_apostas, Quantidade INT) RETURN SELF AS RESULT 
)FINAL;
CREATE OR REPLACE TYPE BODY tp_gols AS
CONSTRUCTOR FUNCTION tp_gols(X tp_apostas, Quantidade INT) RETURN SELF AS RESULT IS
BEGIN
    SELF.ID_Aposta := X.ID_Aposta,
    SELF.Quantidade := Quantidade
    RETURN SELF;
END;
END;

/*SUBTIPO PLACAR COM MODIFICAÇÃO DA FUNÇÃO QUE RETORNA OS GANHOS
DO TIPO APOSTA */
CREATE OR REPLACE TYPE tp_placar UNDER tp_apostas(
    Gol_Mandante INT,
    Gol_Visitante INT,
    OVERRIDING FINAL MEMBER FUNCTION aposta_odd RETURN NUMBER
)FINAL;
CREATE OR REPLACE TYPE BODY tp_placar AS 
OVERRIDING FINAL MEMBER FUNCTION aposta_odd IS
diff INTEGER := (Gol_Mandante - Gol_Visitante);
BEGIN
RETURN diff;
END;
END;

/* TIPO RESULTADO */
CREATE OR REPLACE TYPE tp_resultado UNDER tp_apostas(
    Resultado VARCHAR2(255) 
)FINAL;

/* TIPO AMBOS_MARCAM */
CREATE OR REPLACE TYPE tp_ambos_marcam UNDER tp_apostas(
    Sim_Nao VARCHAR2(3)
)FINAL;

CREATE TABLE tb_evento_esportivo OF tp_evento_esportivo(
    ID_Evento PRIMARY KEY,
    Mandante NOT NULL,
    Visitante NOT NULL,
    Estadio NOT NULL,
    DataHora NOT NULL
);
CREATE TABLE tb_gols OF tp_gols(
    ID_Aposta PRIMARY KEY,
    Odd CHECK (Odd > 1),
    Quantidade CHECK (Quantidade > 0)
);

CREATE TABLE tb_ambos_marcam OF tp_ambos_marcam(
    ID_Aposta PRIMARY KEY,
    Odd CHECK (Odd > 1),
    Sim_Nao CHECK (Sim_Nao IN ('Sim', 'Nao'))
);
CREATE TABLE tb_placar OF tp_placar(
    ID_Aposta PRIMARY KEY,
    Odd CHECK (Odd > 1),
    Gol_Mandante CHECK (Gol_Mandante > -1),
    Gol_Visitante CHECK (Gol_Visitante > -1)
);
CREATE TABLE tb_resultado OF tp_resultado(
    ID_Aposta PRIMARY KEY,
    Odd CHECK (Odd > 1),
    Resultado CHECK (Resultado IN ('Mandante', 'Visitante', 'Empate'))
);
CREATE TABLE tb_conta OF tp_conta(
    ID_Conta PRIMARY KEY,
    Saldo NOT NULL,
    Dados_Bancarios NOT NULL
);
CREATE TABLE tb_bonus OF tp_bonus(
    código_bonus NOT NULL,
    valor CHECK(valor > 0)
);

/*1.Recebe + NESTED TABLE tb_bonus_recebidos + DEFINIÇÃO DO TIPO PESSOA
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
/*2. Indica -> Definição do tipo indicadores pra representar o relacionamento
indica */
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
END LOOP; 
IF (cont = 0) THEN  
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

/* TIPO PESSOAS MOVIMENTAM CONTAS + MÉTODO QUE EXIBE A TRANSAÇÃO */
CREATE OR REPLACE TYPE tp_pessoas_movimentam_contas AS OBJECT ( 
    Pessoa REF tp_pessoa, 
    Conta REF tp_conta, 
    valor DECIMAL(10,2), 
    DataHora TIMESTAMP, 
 
    MEMBER PROCEDURE exibir_transação(X tp_pessoas_movimentam_contas) 
);
CREATE OR REPLACE TYPE BODY tp_pessoas_movimentam_contas AS  
MEMBER PROCEDURE exibir_transação IS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('Nome : ' || VALUE(X.Pessoa).Nome); 
DBMS_OUTPUT.PUT_LINE('CPF : ' || DEREF(X.Pessoa).CPF); 
DBMS_OUTPUT.PUT_LINE('ID_Conta : ' || X.Conta.ID_Conta); 
DBMS_OUTPUT.PUT_LINE('Valor : ' || X.valor); 
DBMS_OUTPUT.PUT_LINE('Data e Hora : ' || X.DataHora);  
END; 
END;



CREATE TABLE tb_indicadores OF tp_indicadores(
    Nome NOT NULL,
    Endereco NOT NULL,
    CPF PRIMARY KEY,
    Nascimento NOT NULL
)NESTED TABLE bonus_recebido STORE AS tb_lista_bonus;

/* TABELA DE OBJETOS DO TIPO PESSOA */
CREATE TABLE tb_pessoas OF tp_pessoa(
    Indicador SCOPE IS tb_indicadores,
    Nome NOT NULL,
    Endereco NOT NULL,
    CPF PRIMARY KEY,
    Nascimento NOT NULL
)NESTED TABLE bonus_recebido STORE AS tb_lista_bonus_2;

/*TABELAS DE OBJETOS*/
CREATE TABLE tb_pessoas_movimentam_contas OF tp_pessoas_movimentam_contas(
    Pessoa WITH ROWID REFERENCES tb_pessoas,
    Conta WITH ROWID REFERENCES tb_conta,
    valor CHECK(valor > 0),
    DataHora NOT NULL
);
/* Apostar + TIPO APOSTAR + MÉTODO QUE EXIBE AS APOSTAS FEITAS AO VIVO
+ CRIAÇÃO DA TABELA DE OBJETOS DO TIPO APOSTAR */
CREATE OR REPLACE TYPE tp_apostar AS OBJECT(  
    pessoas_movimentam_contas REF tp_pessoas_movimentam_contas,  
    apostas REF tp_apostas,  
    evento_esportivo REF tp_evento_esportivo,  
    valor DECIMAL(10, 2),  
  
    MEMBER PROCEDURE apostas_aovivo(X tp_apostar) 
);

CREATE OR REPLACE TYPE BODY tp_apostar AS  
MEMBER PROCEDURE apostas_aovivo IS  
datahora evento_esportivo.DataHora%TYPE := evento_esportivo.DataHora;  
mandante evento_esportivo.Mandante%TYPE := evento_esportivo.Mandante;  
visitante evento_esportivo.Visitante%TYPE := evento_esportivo.Visitante; 
estadio evento_esportivo.Estadio%TYPE := evento_esportivo.Estadio; 
 
BEGIN   
    DBMS_OUTPUT.PUT_LINE(mandante || "  X  " || visitante || CHR(10) || estadio || "  " || datahora);  
    IF (datahora_movimenta >= datahora) THEN  
        DBMS_OUTPUT.PUT_LINE("Aposta ao vivo");  
    ELSE  
        DBMS_OUTPUT.PUT_LINE("Aposta pré-jogo");   
    END IF; 
END;  
END;

CREATE TABLE tb_apostar OF tp_apostar(
    evento_esportivo WITH ROWID REFERENCES tb_evento_esportivo,
    valor CHECK(valor > 0)
);
























