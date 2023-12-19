CREATE TABLE Pessoas (
    Nome VARCHAR(255),
    Num_End VARCHAR(255),
    CPF VARCHAR(20) PRIMARY KEY,
    Nascimento DATE,
    CPF_Indica VARCHAR(20),
    FOREIGN KEY (CPF_Indica) REFERENCES Pessoas(CPF)
);

CREATE TABLE CEP (
    Rua VARCHAR(255),
    País VARCHAR(255),
    CPF VARCHAR(20),
    FOREIGN KEY (CPF) REFERENCES Pessoas(CPF)
);

CREATE TABLE Telefones (
    CPF VARCHAR(20),
    Telefone VARCHAR(20),
    FOREIGN KEY (CPF) REFERENCES Pessoas(CPF)
);

CREATE TABLE Conta (
    ID_Conta INT PRIMARY KEY,
    CPF VARCHAR(20),
    Saldo DECIMAL(10,2),
    FOREIGN KEY (CPF) REFERENCES Pessoas(CPF)
);

CREATE TABLE Dados_Bancarios (
    Conta VARCHAR(20),
    Agencia VARCHAR(20),
    ID_Conta INT,
    FOREIGN KEY (ID_Conta) REFERENCES Conta(ID_Conta)
);

CREATE TABLE Evento_Esportivo (
    Mandante VARCHAR(255),
    Visitante VARCHAR(255),
    Local VARCHAR(255),
    ID_Evento INT PRIMARY KEY
);

CREATE TABLE DataHora (
    Dia DATE,
    Hora TIME,
    ID_Evento INT,
    FOREIGN KEY (ID_Evento) REFERENCES Evento_Esportivo(ID_Evento)
);

CREATE TABLE Aposta (
    ID_Aposta INT PRIMARY KEY
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
    FOREIGN KEY (ID_Aposta) REFERENCES Aposta(ID_Aposta)
);
