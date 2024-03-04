/*TIPO DADOS BANCÁRIOS*/
CREATE OR REPLACE TYPE tp_dados_bancarios AS OBJECT ( 
    Conta VARCHAR2(20), 
    Agencia VARCHAR2(20), 
    CONSTRUCTOR FUNCTION tp_dados_bancarios(SELF IN OUT NOCOPY tp_dados_bancarios, Conta VARCHAR2, Agencia VARCHAR2) RETURN SELF AS RESULT
) FINAL;
/
CREATE OR REPLACE TYPE BODY tp_dados_bancarios AS
CONSTRUCTOR FUNCTION tp_dados_bancarios(Conta VARCHAR2, Agencia VARCHAR2) RETURN SELF AS RESULT IS
BEGIN
    SELF.Agencia := Agencia;
    SELF.Conta := Conta;
    RETURN;
END;
END;
/

/*TIPO TELEFONE + MÉTODO QUE PEGA DDD */
CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
    Telefone VARCHAR2(20),
    MEMBER FUNCTION codigo_postal RETURN VARCHAR2    
)FINAL;
/

CREATE OR REPLACE TYPE BODY tp_telefone AS 
MEMBER FUNCTION codigo_postal RETURN VARCHAR2 IS
BEGIN
    RETURN SUBSTR(Telefone, 1, 2);
END;
END;
/

/* CRIAÇÃO DO TIPO VARRAY: CADA PESSOA PODE TER NO MÁXIMO 3 TELEFONES */
CREATE OR REPLACE TYPE tp_telefones AS VARRAY(3) OF tp_telefone;
/

/* TIPO CONTA + MÉTODO QUE COMPARA SALDO */
CREATE OR REPLACE TYPE tp_conta AS OBJECT (   
    ID_Conta NUMBER,   
    Saldo DECIMAL(10,2),   
    Dados_Bancarios tp_dados_bancarios,     
    ORDER MEMBER FUNCTION compara_saldo(X tp_conta) RETURN INTEGER  
)FINAL;
/

CREATE OR REPLACE TYPE BODY tp_conta AS   
ORDER MEMBER FUNCTION compara_saldo(X tp_conta)   
RETURN INTEGER IS  
BEGIN  
    IF (SELF.saldo - X.saldo > 0) THEN   
        DBMS_OUTPUT.PUT_LINE('Maior'); 
        RETURN (SELF.saldo - X.saldo); 
    ELSIF (SELF.saldo - X.saldo = 0) THEN  
        DBMS_OUTPUT.PUT_LINE('Igual'); 
        RETURN (SELF.saldo - X.saldo);  
    ELSE  
        DBMS_OUTPUT.PUT_LINE('Menor'); 
        RETURN (SELF.saldo - X.saldo); 
    END IF; 
END;  
END;
/

/* TIPO EVENTO ESPORTIVO + MÉTODO QUE EXIBE O EVENTO
+ MÉTODO QUE MAPEIA OS EVENTOS DE ACORDO COM DataHora */
CREATE OR REPLACE TYPE tp_evento_esportivo AS OBJECT ( 
    Mandante VARCHAR2(255), 
    Visitante VARCHAR2(255), 
    Estadio VARCHAR2(255), 
    ID_Evento NUMBER, 
    DataHora TIMESTAMP, 
     
    MEMBER PROCEDURE exibir_partida(SELF IN OUT NOCOPY tp_evento_esportivo), 
 
    MAP MEMBER FUNCTION mapear_datahora RETURN DataHora%TYPE
);
/

CREATE OR REPLACE TYPE BODY tp_evento_esportivo AS   
MEMBER PROCEDURE exibir_partida(SELF IN OUT NOCOPY tp_evento_esportivo) IS  
BEGIN  
    DBMS_OUTPUT.PUT_LINE(Mandante || '  X  ' || Visitante);  
    DBMS_OUTPUT.PUT_LINE(Estadio);  
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(DataHora, 'DD-MM-YYYY HH24:MI'));   
END; 
MAP MEMBER FUNCTION mapear_datahora RETURN DataHora%TYPE IS  
BEGIN  
RETURN DataHora;  
END;  
END;
/

/* TIPO BÔNUS + FUNÇÃO QUE RETORNA UM BÔNUS TURBINADO, CASO O BÔNUS POSSUA DETERMINADO CÓDIGO */
CREATE OR REPLACE TYPE tp_bonus AS OBJECT (  
    código_bonus VARCHAR2(20),  
    valor DECIMAL(10,2),  
  
    MEMBER FUNCTION bonus_turbinado RETURN valor%TYPE 
);
/

CREATE OR REPLACE TYPE BODY tp_bonus AS  
MEMBER FUNCTION bonus_turbinado RETURN valor%TYPE IS  
val_bonus valor%TYPE := valor;  
BEGIN  
    IF (código_bonus = 'JOAO19') THEN 
        RETURN (val_bonus * val_bonus);  
    END IF; 
    RETURN valor;  
END;  
END;
/

/* TIPO ABSTRATO APOSTA + FUNÇÃO QUE AS MAPEIA DE ACORDO COM
A ODD */
CREATE OR REPLACE TYPE tp_apostas AS OBJECT ( 
    ID_Aposta NUMBER, 
    Odd NUMBER(5, 2), 
    NOT FINAL MAP MEMBER FUNCTION map_aposta RETURN NUMBER
)NOT INSTANTIABLE NOT FINAL;
/

CREATE OR REPLACE TYPE BODY tp_apostas AS  
NOT FINAL MAP MEMBER FUNCTION map_aposta RETURN NUMBER IS 
BEGIN 
RETURN Odd; 
END; 
END;
/

/* SUBTIPO GOLS*/
CREATE OR REPLACE TYPE tp_gols UNDER tp_apostas( 
    Quantidade NUMBER 
)FINAL;
/

/*SUBTIPO PLACAR COM MODIFICAÇÃO DA FUNÇÃO QUE MAPEIA AS APOSTAS
DE ACORDO COM A ODD*/
CREATE OR REPLACE TYPE tp_placar UNDER tp_apostas(
    Gol_Mandante NUMBER,
    Gol_Visitante NUMBER,
    OVERRIDING FINAL MAP MEMBER FUNCTION map_aposta RETURN NUMBER
)FINAL;
/
CREATE OR REPLACE TYPE BODY tp_placar AS 
OVERRIDING FINAL MAP MEMBER FUNCTION map_aposta RETURN NUMBER IS
BEGIN
RETURN (Gol_Mandante + Gol_Visitante);
END;
END;
/

/* TIPO RESULTADO */
CREATE OR REPLACE TYPE tp_resultado UNDER tp_apostas(
    Resultado VARCHAR2(255) 
)FINAL;
/

/* TIPO AMBOS_MARCAM */
CREATE OR REPLACE TYPE tp_ambos_marcam UNDER tp_apostas(
    Sim_Nao VARCHAR2(3)
)FINAL;
/

CREATE TABLE tb_evento_esportivo OF tp_evento_esportivo(
    ID_Evento PRIMARY KEY,
    Mandante NOT NULL,
    Visitante NOT NULL,
    Estadio NOT NULL,
    DataHora NOT NULL
);
/

CREATE TABLE tb_gols OF tp_gols(
    ID_Aposta PRIMARY KEY,
    Odd CHECK (Odd > 1),
    Quantidade CHECK (Quantidade > 0)
);
/
CREATE TABLE tb_ambos_marcam OF tp_ambos_marcam(
    ID_Aposta PRIMARY KEY,
    Odd CHECK (Odd > 1),
    Sim_Nao CHECK (Sim_Nao IN ('Sim', 'Nao'))
);
/

CREATE TABLE tb_placar OF tp_placar(
    ID_Aposta PRIMARY KEY,
    Odd CHECK (Odd > 1),
    Gol_Mandante CHECK (Gol_Mandante > -1),
    Gol_Visitante CHECK (Gol_Visitante > -1)
);
/

CREATE TABLE tb_resultado OF tp_resultado(
    ID_Aposta PRIMARY KEY,
    Odd CHECK (Odd > 1),
    Resultado CHECK (Resultado IN ('Mandante', 'Visitante', 'Empate'))
);
/

CREATE TABLE tb_conta OF tp_conta(
    ID_Conta PRIMARY KEY,
    Saldo NOT NULL,
    Dados_Bancarios NOT NULL
);
/

CREATE TABLE tb_bonus OF tp_bonus(
    código_bonus NOT NULL,
    valor CHECK(valor > 0)
);
/

/*1.Recebe + DEFINIÇÃO DO TIPO PESSOA + NESTED TABLE tb_bonus_recebidos PRA REPRESENTAR O RELACIONAMENTO 1:N + MÉTODOS PRA EXIBIR OS BÔNUS E OS TELEFONES*/

CREATE OR REPLACE TYPE tb_bonus_recebidos AS TABLE OF tp_bonus;
/
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    Nome VARCHAR2(255),
    Endereco VARCHAR2(255),
    CPF VARCHAR2(20),
    Nascimento DATE,
    Telefones tp_telefones,
    bonus_recebido tb_bonus_recebidos,
    
    MEMBER PROCEDURE exibir_telefones,
    MEMBER PROCEDURE exibir_bonus

);
/
/*2. Indica -> DEFINIÇÃO DO TIPO INDICADORES, USADO NO
RELACIONAMENTO INDICA */
CREATE OR REPLACE TYPE tp_indicadores AS OBJECT ( 
    Nome VARCHAR2(255), 
    Endereco VARCHAR2(255), 
    CPF VARCHAR2(20), 
    Nascimento DATE, 
    Telefones tp_telefones, 
    bonus_recebido tb_bonus_recebidos 
);
/
ALTER TYPE tp_pessoa
ADD ATTRIBUTE(Indicador REF tp_indicadores) CASCADE;
/

CREATE OR REPLACE TYPE BODY tp_pessoa AS  
MEMBER PROCEDURE exibir_telefones IS  
BEGIN 
FOR i IN 1..Telefones.COUNT LOOP 
    DBMS_OUTPUT.PUT_LINE('Telefone ' || i || ' : ' || Telefones(i).Telefone); 
    IF(i = Telefones.COUNT) THEN
        RETURN;
    END IF;
END LOOP; 
    DBMS_OUTPUT.PUT_LINE('Nenhum telefone encontrado!');  
END; 
MEMBER PROCEDURE exibir_bonus IS 
BEGIN 
FOR i IN 1..bonus_recebido.COUNT LOOP 
    DBMS_OUTPUT.PUT_LINE('Bônus ' || i); 
    DBMS_OUTPUT.PUT_LINE('Código : ' || bonus_recebido(i).código_bonus); 
    DBMS_OUTPUT.PUT_LINE('Valor : ' || bonus_recebido(i).valor);
    IF(i = bonus_recebido.COUNT) THEN
        RETURN;
    END IF;
END LOOP; 
    DBMS_OUTPUT.PUT_LINE('Nenhum bônus encontrado!');
END;
END;
/

/* TIPO PESSOAS MOVIMENTAM CONTAS + MÉTODO QUE EXIBE A TRANSAÇÃO */
CREATE OR REPLACE TYPE tp_pessoas_movimentam_contas AS OBJECT ( 
    Pessoa REF tp_pessoa, 
    Conta REF tp_conta, 
    valor DECIMAL(10,2), 
    DataHora TIMESTAMP, 
 
    MEMBER PROCEDURE exibir_transacao 
);
/
CREATE TABLE tb_indicadores OF tp_indicadores(
    Nome NOT NULL,
    Endereco NOT NULL,
    CPF PRIMARY KEY,
    Nascimento NOT NULL
)NESTED TABLE bonus_recebido STORE AS tb_lista_bonus;
/
/* TABELA DE OBJETOS DO TIPO PESSOA */
CREATE TABLE tb_pessoas OF tp_pessoa(
    Indicador SCOPE IS tb_indicadores,
    Nome NOT NULL,
    Endereco NOT NULL,
    CPF PRIMARY KEY,
    Nascimento NOT NULL
)NESTED TABLE bonus_recebido STORE AS tb_lista_bonus_2;
/

CREATE OR REPLACE TYPE BODY tp_pessoas_movimentam_contas AS  
MEMBER PROCEDURE exibir_transacao IS 
    p tp_pessoa;
    id NUMBER;
BEGIN 
    SELECT VALUE(e) INTO p
    FROM tb_pessoas e
    WHERE REF(e) = Pessoa;

    SELECT c.ID_Conta INTO id
    FROM tb_conta c
    WHERE REF(c) = Conta;

    DBMS_OUTPUT.PUT_LINE('Nome : ' || p.Nome); 
    DBMS_OUTPUT.PUT_LINE('CPF : ' || p.CPF); 
    DBMS_OUTPUT.PUT_LINE('ID_Conta : ' || id); 
    DBMS_OUTPUT.PUT_LINE('Valor : ' || valor); 
    DBMS_OUTPUT.PUT_LINE('Data e Hora : ' || TO_CHAR(DataHora, 'DD-MM-YYYY HH24:MI'));   
END; 
END;
/

CREATE TABLE tb_pessoas_movimentam_contas OF tp_pessoas_movimentam_contas(
    Pessoa WITH ROWID REFERENCES tb_pessoas,
    Conta WITH ROWID REFERENCES tb_conta,
    valor CHECK(valor > 0),
    DataHora NOT NULL
);
/

/* Apostar + TIPO APOSTAR + MÉTODO QUE IDENTIFICA SE A APOSTA FOI
FEITA DURANTE O JOGO E EXIBE INFORMAÇÕES ACERCA DELA*/
CREATE OR REPLACE TYPE tp_apostar AS OBJECT(  
    pessoas_movimentam_contas REF tp_pessoas_movimentam_contas,  
    apostas REF tp_apostas,  
    evento_esportivo REF tp_evento_esportivo,  
    valor DECIMAL(10, 2),  
  
    MEMBER PROCEDURE apostas_aovivo
);
/

CREATE OR REPLACE TYPE BODY tp_apostar AS  
MEMBER PROCEDURE apostas_aovivo IS  
    e tp_evento_esportivo;
    pm TIMESTAMP;
    ap tp_apostas;
    gols tp_gols;
    placar tp_placar;
    resultado tp_resultado;
    ambos tp_ambos_marcam;
BEGIN   
    SELECT VALUE(t) INTO e
    FROM tb_evento_esportivo t
    WHERE REF(t) = evento_esportivo;

    SELECT p.DataHora INTO pm
    FROM tb_pessoas_movimentam_contas p
    WHERE REF(p) = pessoas_movimentam_contas;

    SELECT VALUE(a) INTO ap
    FROM tb_placar a
    FULL JOIN tb_gols g ON (1 = 1)
    FULL JOIN tb_resultado r ON (1 = 1)
    FULL JOIN tb_ambos_marcam am ON (1 = 1)
    WHERE REF(a) = apostas;

    DBMS_OUTPUT.PUT_LINE(e.Mandante || '  X  ' || e.Visitante);
    DBMS_OUTPUT.PUT_LINE(e.Estadio);
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(e.DataHora, 'DD-MM-YYYY HH24:MI'));
    IF (pm >= e.DataHora) THEN  
        DBMS_OUTPUT.PUT_LINE('Aposta ao vivo');
    ELSE  
        DBMS_OUTPUT.PUT_LINE('Aposta pré-jogo');   
    END IF; 
    DBMS_OUTPUT.PUT_LINE('Valor: ' || valor);
   
    IF (ap IS OF (tp_gols)) THEN
        SELECT VALUE(g) INTO gols
        FROM tb_gols g
        WHERE REF(g) = apostas;
        DBMS_OUTPUT.PUT_LINE('+'  || gols.Quantidade || ' gols');  
    ELSIF(ap IS OF(tp_ambos_marcam)) THEN 
        SELECT VALUE(g) INTO ambos
        FROM tb_ambos_marcam g
        WHERE REF(g) = apostas;
        DBMS_OUTPUT.PUT_LINE('Para ambas as equipes marcarem' || ambos.Sim_Nao);    
    ELSIF(ap IS OF (tp_resultado)) THEN 
        SELECT VALUE(g) INTO resultado
        FROM tb_resultado g
        WHERE REF(g) = apostas;
        DBMS_OUTPUT.PUT_LINE('Resultado : ' || resultado.Resultado);    
    ELSE 
        SELECT VALUE(g) INTO placar
        FROM tb_placar g
        WHERE REF(g) = apostas;
        DBMS_OUTPUT.PUT_LINE('Placar exato : ' || placar.Gol_Mandante ||  '  X  ' || placar.Gol_Visitante);    
    END IF;  
    DBMS_OUTPUT.PUT_LINE('Odd : ' || ap.Odd); 
    DBMS_OUTPUT.PUT_LINE('Retorno possível : ' || valor * ap.Odd);  

END;  
END;
/
CREATE TABLE tb_apostar OF tp_apostar(
    evento_esportivo WITH ROWID REFERENCES tb_evento_esportivo,
    valor CHECK(valor > 0)
);
/