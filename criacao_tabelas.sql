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
    Nome VARCHAR(255),
    Endereço VARCHAR(255),
    CPF VARCHAR(20) PRIMARY KEY,
    Nascimento DATE,
    CPF_Indica VARCHAR(20),
    FOREIGN KEY (CPF_Indica) REFERENCES Pessoas(CPF)
);


CREATE TABLE Telefones (
    CPF VARCHAR(20),
    Telefone VARCHAR(20),
    FOREIGN KEY (CPF) REFERENCES Pessoas(CPF)
);

CREATE TABLE Conta (
    ID_Conta INT DEFAULT seq_conta.NEXTVAL PRIMARY KEY,
    Saldo DECIMAL(10,2)
);

CREATE TABLE Dados_Bancarios (
    Conta VARCHAR(20),
    Agencia VARCHAR(20),
    ID_Conta INT,
    FOREIGN KEY (ID_Conta) REFERENCES Conta(ID_Conta)
);

CREATE TABLE Pessoas_movimentam_contas (
    CPF VARCHAR(20),
    ID_Conta INT,
    Valor DECIMAL(10,2),
    DataHora TIMESTAMP,
    FOREIGN KEY (CPF) REFERENCES Pessoas(CPF),
    FOREIGN KEY (ID_Conta) REFERENCES Conta(ID_Conta),
    PRIMARY KEY (CPF, ID_Conta)
);

CREATE TABLE Evento_Esportivo (
    Mandante VARCHAR(255),
    Visitante VARCHAR(255),
    Local VARCHAR(255),
    ID_Evento INT DEFAULT seq_evento.NEXTVAL PRIMARY KEY
);

CREATE TABLE DataHora (
    DataHora TIMESTAMP,
    ID_Evento INT,
    FOREIGN KEY (ID_Evento) REFERENCES Evento_Esportivo(ID_Evento)
);

CREATE TABLE Aposta (
    ID_Aposta INT DEFAULT seq_aposta.NEXTVAL PRIMARY KEY
);

CREATE TABLE Bonus (
    CPF VARCHAR(20),
    Codigo_Bonus VARCHAR(20),
    Valor DECIMAL(10,2),
    FOREIGN KEY (CPF) REFERENCES Pessoas(CPF)
);

CREATE TABLE Gols (
    ID_Aposta INT,
    Quantidade INT,
    FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE TABLE Placar_Exato (
    ID_Aposta INT,
    Gol_Mandante INT,
    Gol_Visitante INT,
    FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE TABLE Resultado (
    ID_Aposta INT,
    Resultado VARCHAR(255),
    FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE TABLE Ambos_Marcam (
    ID_Aposta INT,
    Sim_Nao VARCHAR(3),
    FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);

CREATE TABLE Apostar (
    CPF VARCHAR(20),
    ID_Conta INT,
    ID_Evento INT,
    ID_Aposta INT,
    Valor DECIMAL(10,2),
    FOREIGN KEY (CPF) REFERENCES Pessoas(CPF),
    FOREIGN KEY (ID_Conta) REFERENCES Conta(ID_Conta),
    FOREIGN KEY (ID_Evento) REFERENCES Evento_Esportivo(ID_Evento),
    FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta),
    PRIMARY KEY (CPF, ID_Conta, ID_Evento, ID_Aposta)
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