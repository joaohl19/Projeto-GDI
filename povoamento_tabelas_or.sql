/* INSERINDO VALORES NAS TABELAS */

INSERT INTO tb_pessoas VALUES(
    'João', 'Rua 1', '12345678901', '01/01/2000', 
    tp_telefones(tp_telefone('123456789'), tp_telefone('987654321'), tp_telefone('123456789')),
    tb_bonus_recebidos(tp_bonus('B1', 100), tb_bonus('B2', 200))
);

INSERT INTO tb_pessoas VALUES(
    'Maria', 'Rua 2', '12345678902', '01/01/2000', 
    tp_telefones(tp_telefone('123456789'), tp_telefone('987654321'), tp_telefone('123456789')),
    tb_bonus_recebidos(tp_bonus('B3', 300), tb_bonus('B4', 400))
);

INSERT INTO tb_indicadores VALUES(
    'João', 'Rua 1', '12345678901', '01/01/2000', 
    tp_telefones(tp_telefone('123456789'), tp_telefone('987654321'), tp_telefone('123456789')),
    tb_bonus_recebidos(tp_bonus('B1', 100), tb_bonus('B2', 200))
);

INSERT INTO tb_indicadores VALUES(
    'Maria', 'Rua 2', '12345678902', '01/01/2000', 
    tp_telefones(tp_telefone('123456789'), tp_telefone('987654321'), tp_telefone('123456789')),
    tb_bonus_recebidos(tp_bonus('B3', 300), tb_bonus('B4', 400))
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE P.CPF = '12345678901'),
    (SELECT REF(C) FROM tb_conta C WHERE C.ID_Conta = 1),
    100,
    '01/01/2020 12:00:00'
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE P.CPF = '12345678902'),
    (SELECT REF(C) FROM tb_conta C WHERE C.ID_Conta = 2),
    200,
    '01/01/2020 12:00:00'
);

INSERT INTO tb_evento_esportivo VALUES(
    'Mandante1', 'Visitante1', 'Estádio1', 1, '01/01/2020 12:00:00'
);

INSERT INTO tb_evento_esportivo VALUES(
    'Mandante2', 'Visitante2', 'Estádio2', 2, '01/01/2020 12:00:00'
);

INSERT INTO tb_gols VALUES(
    1, 2
);

INSERT INTO tb_gols VALUES(
    2, 3
);

INSERT INTO tb_ambos_marcam VALUES(
    'Sim', 1
);

INSERT INTO tb_ambos_marcam VALUES(
    'Nao', 2
);

INSERT INTO tb_placar VALUES(
    1, 2, 1
);

INSERT INTO tb_placar VALUES(
    2, 3, 2
);

INSERT INTO tb_resultado VALUES(
    'Mandante', 1
);

INSERT INTO tb_resultado VALUES(
    'Visitante', 2
);

INSERT INTO tb_conta VALUES(
    1, 1000, tp_dados_bancarios('123456', '123', '12345678901')
);

INSERT INTO tb_conta VALUES(
    2, 2000, tp_dados_bancarios('123456', '123', '12345678902')
);

INSERT INTO tb_bonus VALUES(
    'B1', 100
);

INSERT INTO tb_bonus VALUES(
    'B2', 200
);

INSERT INTO tb_bonus VALUES(
    'B3', 300
);

INSERT INTO tb_bonus VALUES(
    'B4', 400
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE P.CPF = '12345678901'),
    (SELECT REF(A) FROM tb_ambos_marcam A WHERE A.ID_Aposta = 1),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE E.ID_Evento = 1),
    100
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE P.CPF = '12345678902'),
    (SELECT REF(A) FROM tb_ambos_marcam A WHERE A.ID_Aposta = 2),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE E.ID_Evento = 2),
    200
);
