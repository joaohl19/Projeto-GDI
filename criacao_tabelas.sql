DROP TABLE Pessoas;
DROP TABLE Pessoas_movimentam_contas;
DROP TABLE Telefones;
DROP TABLE Conta;
DROP TABLE Dados_Bancarios;
DROP TABLE Evento_Esportivo;
DROP TABLE DataHora;
DROP TABLE Aposta;
DROP TABLE Bonus;
DROP TABLE Gols;
DROP TABLE Placar_Exato;
DROP TABLE Resultado;
DROP TABLE Ambos_Marcam;
DROP TABLE Apostar;

CREATE TABLE Pessoas (
    Nome VARCHAR2(255),
    Endereço VARCHAR2(255),
    CPF VARCHAR2(20),
    Nascimento DATE,
    CPF_Indica VARCHAR2(20),
    CONSTRAINT pessoas_pk PRIMARY KEY (CPF),
    CONSTRAINT pessoas_fk FOREIGN KEY (CPF_Indica) REFERENCES Pessoas(CPF)
);

CREATE TABLE Telefones (
    CPF VARCHAR2(20),
    Telefone VARCHAR2(20),
    CONSTRAINT telefones_fk FOREIGN KEY (CPF) REFERENCES Pessoas(CPF)
);

CREATE TABLE Conta (
    ID_Conta NUMBER DEFAULT seq_conta.NEXTVAL,
    Saldo DECIMAL(10,2),
    CONSTRAINT conta_pk PRIMARY KEY (ID_Conta)
);

CREATE TABLE Dados_Bancarios (
    Conta VARCHAR2(20),
    Agencia VARCHAR2(20),
    ID_Conta NUMBER,
    CONSTRAINT dados_bancarios_fk FOREIGN KEY (ID_Conta) REFERENCES Conta(ID_Conta)
);

CREATE TABLE Pessoas_movimentam_contas (
    CPF VARCHAR2(20),
    ID_Conta NUMBER,
    Valor DECIMAL(10,2),
    DataHora TIMESTAMP,
    CONSTRAINT pmc_pk PRIMARY KEY (CPF, ID_Conta),
    CONSTRAINT pmc_fk_cpf FOREIGN KEY (CPF) REFERENCES Pessoas(CPF),
    CONSTRAINT pmc_fk_id_conta FOREIGN KEY (ID_Conta) REFERENCES Conta(ID_Conta)
);

CREATE TABLE Evento_Esportivo (
    Mandante VARCHAR2(255),
    Visitante VARCHAR2(255),
    Local VARCHAR2(255),
    ID_Evento NUMBER DEFAULT seq_evento.NEXTVAL,
    CONSTRAINT evento_esportivo_pk PRIMARY KEY (ID_Evento)
);

CREATE TABLE DataHora (
    DataHora TIMESTAMP,
    ID_Evento NUMBER,
    CONSTRAINT datahora_fk FOREIGN KEY (ID_Evento) REFERENCES Evento_Esportivo(ID_Evento)
);

CREATE TABLE Aposta (
    ID_Aposta NUMBER DEFAULT seq_aposta.NEXTVAL,
    CONSTRAINT aposta_pk PRIMARY KEY (ID_Aposta)
);

CREATE TABLE Bonus (
    CPF VARCHAR2(20),
    Codigo_Bonus VARCHAR2(20),
    Valor DECIMAL(10,2),
    CONSTRAINT bonus_fk FOREIGN KEY (CPF) REFERENCES Pessoas(CPF)
);

CREATE TABLE Gols (
    ID_Aposta NUMBER,
    Quantidade INT,
    CONSTRAINT gols_fk FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE TABLE Placar_Exato (
    ID_Aposta NUMBER,
    Gol_Mandante INT,
    Gol_Visitante INT,
    CONSTRAINT placar_exato_fk FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE TABLE Resultado (
    ID_Aposta NUMBER,
    Resultado VARCHAR2(255),
    CONSTRAINT resultado_fk FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE TABLE Ambos_Marcam (
    ID_Aposta NUMBER,
    Sim_Nao VARCHAR2(3),
    CONSTRAINT ambos_marcam_fk FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE TABLE Apostar (
    CPF VARCHAR2(20),
    ID_Conta NUMBER,
    ID_Evento NUMBER,
    ID_Aposta NUMBER,
    Valor DECIMAL(10,2),
    CONSTRAINT apostar_pk PRIMARY KEY (CPF, ID_Conta, ID_Evento, ID_Aposta),
    CONSTRAINT apostar_fk_cpf FOREIGN KEY (CPF) REFERENCES Pessoas(CPF),
    CONSTRAINT apostar_fk_id_conta FOREIGN KEY (ID_Conta) REFERENCES Conta(ID_Conta),
    CONSTRAINT apostar_fk_id_evento FOREIGN KEY (ID_Evento) REFERENCES Evento_Esportivo(ID_Evento),
    CONSTRAINT apostar_fk_id_aposta FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE SEQUENCE seq_conta
    START WITH 1,
    INCREMENT BY 1,
    NOCACHE,
    NOCYCLE

CREATE SEQUENCE seq_aposta
    START WITH 1,
    INCREMENT BY 1,
    NOCACHE,
    NOCYCLE

CREATE SEQUENCE seq_evento
    START WITH 1,
    INCREMENT BY 1,
    NOCACHE,
    NOCYCLE