/* INSERINDO VALORES NO PLACAR */

INSERT INTO tb_placar VALUES (31, 1.5, 1, 0);
INSERT INTO tb_placar VALUES (32, 2.0, 2, 1);
INSERT INTO tb_placar VALUES (33, 1.8, 0, 0);
INSERT INTO tb_placar VALUES (34, 2.5, 3, 2);
INSERT INTO tb_placar VALUES (35, 1.6, 4, 3);
INSERT INTO tb_placar VALUES (36, 2.2, 0, 1);
INSERT INTO tb_placar VALUES (37, 1.9, 2, 2);
INSERT INTO tb_placar VALUES (38, 2.1, 5, 0);
INSERT INTO tb_placar VALUES (39, 1.7, 1, 2);
INSERT INTO tb_placar VALUES (40, 2.3, 2, 3);

/* INSERINDO VALORES NOS GOLS */

INSERT INTO tb_gols VALUES(1, 1.23, 5);
INSERT INTO tb_gols VALUES(2, 3.14, 3);
INSERT INTO tb_gols VALUES(3, 2.75, 7);
INSERT INTO tb_gols VALUES(4, 4.99, 2);
INSERT INTO tb_gols VALUES(5, 1.67, 6);
INSERT INTO tb_gols VALUES(6, 2.58, 4);
INSERT INTO tb_gols VALUES(7, 4.32, 1);
INSERT INTO tb_gols VALUES(8, 3.71, 7);
INSERT INTO tb_gols VALUES(9, 1.86, 4);
INSERT INTO tb_gols VALUES(10, 5.00, 2);

/* INSERINDO VALORES EM AMBOS MARCAM */

INSERT INTO tb_ambos_marcam VALUES(
    11, 1.8, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    12, 1.5, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    13, 2.5, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    14, 2.7, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    15, 1.8, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    16, 1.5, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    17, 2.5, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    18, 2.7, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    19, 1.8, 'Sim'
);

INSERT INTO tb_ambos_marcam VALUES(
    20, 1.5, 'Sim'
);

/* INSERINDO VALORES EM RESULTADO */

INSERT INTO tb_resultado VALUES(
    21, 1.8, 'Mandante'
);

INSERT INTO tb_resultado VALUES(
    22, 1.5, 'Visitante'
);

INSERT INTO tb_resultado VALUES(
    23, 2.5, 'Empate'
);

INSERT INTO tb_resultado VALUES(
    24, 2.7, 'Mandante'
);

INSERT INTO tb_resultado VALUES(
    25, 1.8, 'Visitante'
);

INSERT INTO tb_resultado VALUES(
    26, 1.5, 'Empate'
);

INSERT INTO tb_resultado VALUES(
    27, 2.5, 'Mandante'
);

INSERT INTO tb_resultado VALUES(
    28, 2.7, 'Visitante'
);

INSERT INTO tb_resultado VALUES(
    29, 1.8, 'Empate'
);

INSERT INTO tb_resultado VALUES(
    30, 1.5, 'Mandante'
);

/* INSERINDO VALORES EM BONUS */

INSERT INTO tb_bonus VALUES(
    'JOAO19', 20
);

INSERT INTO tb_bonus VALUES(
    'BRUNO2', 30
);

INSERT INTO tb_bonus VALUES(
    'BRUNO3', 40
);

INSERT INTO tb_bonus VALUES(
    'BRUNO4', 50
);

INSERT INTO tb_bonus VALUES(
    'BRUNO5', 20
);

INSERT INTO tb_bonus VALUES(
    'BRUNO6', 30
);

INSERT INTO tb_bonus VALUES(
    'BRUNO7', 40
);

INSERT INTO tb_bonus VALUES(
    'BRUNO8', 50
);

INSERT INTO tb_bonus VALUES(
    'BRUNO9', 20
);

INSERT INTO tb_bonus VALUES(
    'BRUNO10', 30
);

INSERT INTO tb_bonus VALUES(
    'BRUNO11', 40
);

INSERT INTO tb_bonus VALUES(
    'BRUNO12', 50
);

INSERT INTO tb_bonus VALUES(
    'BRUNO13', 20
);

INSERT INTO tb_bonus VALUES(
    'BRUNO14', 30
);

INSERT INTO tb_bonus VALUES(
    'BRUNO15', 40
);

INSERT INTO tb_bonus VALUES(
    'BRUNO16', 50
);

INSERT INTO tb_bonus VALUES(
    'BRUNO17', 20
);

INSERT INTO tb_bonus VALUES(
    'BRUNO18', 30
);

INSERT INTO tb_bonus VALUES(
    'BRUNO19', 40
);

INSERT INTO tb_bonus VALUES(
    'BRUNO20', 50
);

INSERT INTO tb_bonus VALUES(
    'RENATO20', 20
);

INSERT INTO tb_bonus VALUES(
    'RENATO30', 30
);

INSERT INTO tb_bonus VALUES(
    'RENATO40', 40
);

INSERT INTO tb_bonus VALUES(
    'RENATO50', 50
);

INSERT INTO tb_bonus VALUES(
    'MAIKE20', 20
);

INSERT INTO tb_bonus VALUES(
    'MAIKE30', 30
);

INSERT INTO tb_bonus VALUES(
    'MAIKE40', 40
);

INSERT INTO tb_bonus VALUES(
    'MAIKE50', 50
);

/* INSERINDO VALORES EM EVENTO ESPORTIVO */

DECLARE
    v_counter NUMBER := 1;
BEGIN
    FOR i IN 1..40 LOOP
        INSERT INTO tb_evento_esportivo (Mandante, Visitante, Estadio, ID_Evento, DataHora)
        VALUES (
            'Mandante' || v_counter,
            'Visitante' || v_counter,
            'Estadio' || v_counter,
            v_counter,
            TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS') + INTERVAL '1' HOUR * i -- Adiciona 1 hora em cada iteração
        );
        v_counter := v_counter + 1;
    END LOOP;
END;
/

/* INSERINDO VALORES EM CONTA */

INSERT INTO tb_conta VALUES(1, 40.00, tp_dados_bancarios('gkdjk1', '123480'));
INSERT INTO tb_conta VALUES(2, 50.00, tp_dados_bancarios('gkdjk2', '123481'));
INSERT INTO tb_conta VALUES(3, 60.00, tp_dados_bancarios('gkdjk3', '123482'));
INSERT INTO tb_conta VALUES(4, 70.00, tp_dados_bancarios('gkdjk4', '123483'));
INSERT INTO tb_conta VALUES(5, 80.00, tp_dados_bancarios('gkdjk5', '123484'));
INSERT INTO tb_conta VALUES(6, 90.00, tp_dados_bancarios('gkdjk6', '123485'));
INSERT INTO tb_conta VALUES(7, 100.00, tp_dados_bancarios('gkdjk7', '123486'));
INSERT INTO tb_conta VALUES(8, 110.00, tp_dados_bancarios('gkdjk8', '123487'));
INSERT INTO tb_conta VALUES(9, 120.00, tp_dados_bancarios('gkdjk9', '123488'));
INSERT INTO tb_conta VALUES(10, 130.00, tp_dados_bancarios('gkdjk10', '123489'));
INSERT INTO tb_conta VALUES(11, 140.00, tp_dados_bancarios('gkdjk11', '123490'));
INSERT INTO tb_conta VALUES(12, 150.00, tp_dados_bancarios('gkdjk12', '123491'));
INSERT INTO tb_conta VALUES(13, 160.00, tp_dados_bancarios('gkdjk13', '123492'));
INSERT INTO tb_conta VALUES(14, 170.00, tp_dados_bancarios('gkdjk14', '123493'));
INSERT INTO tb_conta VALUES(15, 180.00, tp_dados_bancarios('gkdjk15', '123494'));
INSERT INTO tb_conta VALUES(16, 190.00, tp_dados_bancarios('gkdjk16', '123495'));
INSERT INTO tb_conta VALUES(17, 200.00, tp_dados_bancarios('gkdjk17', '123496'));
INSERT INTO tb_conta VALUES(18, 210.00, tp_dados_bancarios('gkdjk18', '123497'));
INSERT INTO tb_conta VALUES(19, 220.00, tp_dados_bancarios('gkdjk19', '123498'));
INSERT INTO tb_conta VALUES(20, 230.00, tp_dados_bancarios('gkdjk20', '123499'));
INSERT INTO tb_conta VALUES(21, 240.00, tp_dados_bancarios('gkdjk21', '123500'));

/* INSERINDO VALORES EM INDICADORES */

INSERT INTO tb_indicadores VALUES('João Pedro', 'Rua 1, 29', '137.897.367-01', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO1', 30), tp_bonus('JOAO19', 20)));

INSERT INTO tb_indicadores VALUES('Bruno', 'Rua 2, 30', '137.897.367-02', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO2', 30), tp_bonus('BRUNO3', 40)));

INSERT INTO tb_indicadores VALUES('Renato', 'Rua 3, 31', '137.897.367-03', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO4', 50), tp_bonus('BRUNO5', 20)));

INSERT INTO tb_indicadores VALUES('Maike', 'Rua 4, 32', '137.897.367-04', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO6', 30), tp_bonus('BRUNO7', 40)));

INSERT INTO tb_indicadores VALUES('João Pedro', 'Rua 1, 29', '137.897.367-05', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO8', 50), tp_bonus('BRUNO9', 20)));

INSERT INTO tb_indicadores VALUES('Bruno', 'Rua 2, 30', '137.897.367-06', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO10', 30), tp_bonus('BRUNO11', 40)));

INSERT INTO tb_indicadores VALUES('Renato', 'Rua 3, 31', '137.897.367-07', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO12', 50), tp_bonus('BRUNO13', 20)));

INSERT INTO tb_indicadores VALUES('Maike', 'Rua 4, 32', '137.897.367-08', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO14', 30), tp_bonus('BRUNO15', 40)));

INSERT INTO tb_indicadores VALUES('João Pedro', 'Rua 1, 29', '137.897.367-09', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO16', 50), tp_bonus('BRUNO17', 20)));

INSERT INTO tb_indicadores VALUES('Bruno', 'Rua 2, 30', '137.897.367-10', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO18', 30), tp_bonus('BRUNO19', 40)));

INSERT INTO tb_indicadores VALUES('Renato', 'Rua 3, 31', '137.897.367-11', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('RENATO20', 20), tp_bonus('RENATO30', 30)));

INSERT INTO tb_indicadores VALUES('Maike', 'Rua 4, 32', '137.897.367-12', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('RENATO40', 40), tp_bonus('RENATO50', 50)));

INSERT INTO tb_indicadores VALUES('João Pedro', 'Rua 1, 29', '137.897.367-13', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('MAIKE20', 20), tp_bonus('MAIKE30', 30)));

INSERT INTO tb_indicadores VALUES('Bruno', 'Rua 2, 30', '137.897.367-14', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('MAIKE40', 40), tp_bonus('MAIKE50', 50)));

INSERT INTO tb_indicadores VALUES('Renato', 'Rua 3, 31', '137.897.367-15', TO_DATE('1999-01-01', 'YYYY-MM-DD'), tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), tb_bonus_recebidos(tp_bonus('BRUNO1', 30), tp_bonus('JOAO19', 20)));


/* INSERINDO VALORES EM PESSOA */

INSERT INTO tb_pessoas VALUES(
    'João Pedro', 
    'Rua 1, 29', 
    '137.897.367-01', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO1', 30), tp_bonus('JOAO19', 20)),
    (SELECT REF(I) FROM tb_indicadores I WHERE CPF = '137.897.367-02')
);

INSERT INTO tb_pessoas VALUES(
    'Bruno', 
    'Rua 2, 30', 
    '137.897.367-02', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO2', 30), tp_bonus('BRUNO3', 40)),
    (SELECT REF(I) FROM tb_indicadores I WHERE CPF = '137.897.367-03')
);

INSERT INTO tb_pessoas VALUES(
    'Renato', 
    'Rua 3, 31', 
    '137.897.367-03', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO4', 50), tp_bonus('BRUNO5', 20)),
    (SELECT REF(I) FROM tb_indicadores I WHERE CPF = '137.897.367-04')
);

INSERT INTO tb_pessoas VALUES(
    'Maike', 
    'Rua 4, 32', 
    '137.897.367-04', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO6', 30), tp_bonus('BRUNO7', 40)),
    (SELECT REF(I) FROM tb_indicadores I WHERE CPF = '137.897.367-05')
);

INSERT INTO tb_pessoas VALUES(
    'João Pedro', 
    'Rua 1, 29', 
    '137.897.367-05', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO8', 50), tp_bonus('BRUNO9', 20)),
    (SELECT REF(I) FROM tb_indicadores I WHERE CPF = '137.897.367-06')
);

INSERT INTO tb_pessoas VALUES(
    'Bruno', 
    'Rua 2, 30', 
    '137.897.367-06', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO10', 30), tp_bonus('BRUNO11', 40)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Renato', 
    'Rua 3, 31', 
    '137.897.367-07', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO12', 50), tp_bonus('BRUNO13', 20)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Maike', 
    'Rua 4, 32', 
    '137.897.367-08', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO14', 30), tp_bonus('BRUNO15', 40)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'João Pedro', 
    'Rua 1, 29', 
    '137.897.367-09', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO16', 50), tp_bonus('BRUNO17', 20)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Bruno', 
    'Rua 2, 30', 
    '137.897.367-10', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO18', 30), tp_bonus('BRUNO19', 40)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Renato', 
    'Rua 3, 31', 
    '137.897.367-11', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('RENATO20', 20), tp_bonus('RENATO30', 30)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Maike', 
    'Rua 4, 32', 
    '137.897.367-12', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('RENATO40', 40), tp_bonus('RENATO50', 50)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'João Pedro', 
    'Rua 1, 29', 
    '137.897.367-13', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('MAIKE20', 20), tp_bonus('MAIKE30', 30)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Bruno', 
    'Rua 2, 30', 
    '137.897.367-14', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('MAIKE40', 40), tp_bonus('MAIKE50', 50)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Renato', 
    'Rua 3, 31', 
    '137.897.367-15', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO1', 30), tp_bonus('JOAO19', 20)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Maike', 
    'Rua 4, 32', 
    '137.897.367-16', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO2', 30), tp_bonus('BRUNO3', 40)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'João Pedro', 
    'Rua 1, 29', 
    '137.897.367-17', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO4', 50), tp_bonus('BRUNO5', 20)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Bruno', 
    'Rua 2, 30', 
    '137.897.367-18', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO6', 30), tp_bonus('BRUNO7', 40)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Renato', 
    'Rua 3, 31', 
    '137.897.367-19', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO8', 50), tp_bonus('BRUNO9', 20)),
    NULL
);

INSERT INTO tb_pessoas VALUES(
    'Maike', 
    'Rua 4, 32', 
    '137.897.367-20', 
    TO_DATE('1999-01-01', 'YYYY-MM-DD'), 
    tp_telefones(tp_telefone('81992893789'), tp_telefone('83992364721')), 
    tb_bonus_recebidos(tp_bonus('BRUNO10', 30), tp_bonus('BRUNO11', 40)),
    NULL
);

/* INSERINDO VALORES EM PESSOAS MOVIMENTAM CONTAS */

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-01'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 1),
    40.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-02'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 2),
    50.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-03'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 3),
    60.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-04'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 4),
    70.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-05'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 5),
    80.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-06'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 6),
    90.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-07'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 7),
    100.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-08'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 8),
    110.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-09'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 9),
    120.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-10'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 10),
    130.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-11'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 11),
    140.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-12'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 12),
    150.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-13'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 13),
    160.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-14'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 14),
    170.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-15'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 15),
    180.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-16'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 16),
    190.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-17'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 17),
    200.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-18'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 18),
    210.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-19'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 19),
    220.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

INSERT INTO tb_pessoas_movimentam_contas VALUES(
    (SELECT REF(P) FROM tb_pessoas P WHERE CPF = '137.897.367-20'),
    (SELECT REF(C) FROM tb_conta C WHERE ID_Conta = 20),
    230.00,
    TO_TIMESTAMP('2024-02-28 14:30:00', 'YYYY-MM-DD HH24:MI:SS')
);

/* INSERINDO VALORES EM APOSTA */

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-01'),
    (SELECT REF(A) FROM tb_resultado A WHERE ID_Aposta = 21),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 1),
    35.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-02'),
    (SELECT REF(A) FROM tb_resultado A WHERE ID_Aposta = 22),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 2),
    45.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-03'),
    (SELECT REF(A) FROM tb_resultado A WHERE ID_Aposta = 23),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 3),
    55.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-04'),
    (SELECT REF(A) FROM tb_resultado A WHERE ID_Aposta = 24),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 4),
    65.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-05'),
    (SELECT REF(A) FROM tb_resultado A WHERE ID_Aposta = 25),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 5),
    75.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-06'),
    (SELECT REF(A) FROM tb_ambos_marcam A WHERE ID_Aposta = 11),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 6),
    85.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-07'),
    (SELECT REF(A) FROM tb_ambos_marcam A WHERE ID_Aposta = 12),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 7),
    95.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-08'),
    (SELECT REF(A) FROM tb_ambos_marcam A WHERE ID_Aposta = 13),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 8),
    105.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-09'),
    (SELECT REF(A) FROM tb_ambos_marcam A WHERE ID_Aposta = 14),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 9),
    115.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-10'),
    (SELECT REF(A) FROM tb_ambos_marcam A WHERE ID_Aposta = 15),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 10),
    125.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-11'),
    (SELECT REF(A) FROM tb_gols A WHERE ID_Aposta = 1),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 11),
    135.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-12'),
    (SELECT REF(A) FROM tb_gols A WHERE ID_Aposta = 2),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 12),
    145.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-13'),
    (SELECT REF(A) FROM tb_gols A WHERE ID_Aposta = 3),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 13),
    155.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-14'),
    (SELECT REF(A) FROM tb_gols A WHERE ID_Aposta = 4),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 14),
    165.75
);

INSERT INTO tb_apostar VALUES(
    (SELECT REF(P) FROM tb_pessoas_movimentam_contas P WHERE P.pessoa.CPF = '137.897.367-15'),
    (SELECT REF(A) FROM tb_gols A WHERE ID_Aposta = 5),
    (SELECT REF(E) FROM tb_evento_esportivo E WHERE ID_Evento = 15),
    175.75
);
