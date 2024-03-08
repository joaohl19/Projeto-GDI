/* TESTANDO OS MÉTODOS DE CADA TIPO */

/* TIPO DADOS BANCÁRIOS */
DECLARE 
    db tp_dados_bancarios;
BEGIN
    db := tp_dados_bancarios('NuBank', 12867);
    DBMS_OUTPUT.PUT_LINE(db.Agencia);
    DBMS_OUTPUT.PUT_LINE(db.Conta);
END;


/* TIPO TELEFONE */
DECLARE 
    fones tp_telefones;
    fone1 tp_telefone;
    ddd VARCHAR2(2);
BEGIN
    SELECT p.Telefones INTO fones
    FROM tb_pessoas p
    WHERE CPF = '137.897.367-01';
    fone1 := fones(1);
    ddd := fone1.codigo_postal();
    DBMS_OUTPUT.PUT_LINE(ddd);
END;

/* TIPO CONTA */
DECLARE 
    conta1 tp_conta;
    comp INTEGER;
BEGIN
    SELECT VALUE(C) INTO conta1
    FROM tb_conta C
    WHERE C.Dados_Bancarios.Conta = 'gkdjk12';

    SELECT P.compara_saldo(conta1) INTO comp 
    FROM tb_conta P
    WHERE P.Dados_Bancarios.Agencia = '123491';
END;

/* TIPO EVENTO ESPORTIVO */
/*exibir_detalhes*/
DECLARE
    evento tp_evento_esportivo;
BEGIN
    SELECT VALUE(P) INTO evento
    FROM tb_evento_esportivo P
    WHERE P.Mandante = 'Mandante1';

    evento.exibir_partida();
END;

/*mapear_datahora*/
select e.Mandante, e.Visitante, e.Estadio, e.DataHora, e.ID_Evento
from tb_evento_esportivo e 
order by e.mapear_datahora();

/* TIPO BONUS */
select p.nome, b.código_bonus, b.valor as bonus_anterior, b.bonus_turbinado() as bonus_novo 
from tb_pessoas p,
table(p.bonus_recebido) b


/* TIPO APOSTA */
select a.ID_Aposta, a.Odd, a.Resultado
from tb_resultado a
order by a.map_aposta();

/* TIPO PLACAR */
select a.ID_Aposta, a.Odd, a.Gol_Mandante, a.Gol_Visitante
from tb_placar a
order by a.map_aposta();

/* TIPO PESSOA */
DECLARE
    p tp_pessoa;
BEGIN
    select value(f) into p
    from tb_pessoas f
    where CPF = '137.897.367-20';

    p.exibir_telefones();
    p.exibir_bonus();
END;

/* TIPO PESSOAS MOVIMENTAM CONTAS */
DECLARE
    pm tp_pessoas_movimentam_contas;

BEGIN
    select value(e) into pm
    from tb_pessoas_movimentam_contas e
    where e.Pessoa = (select ref(p) 
                        from tb_pessoas p 
                        where cpf = '137.897.367-20');
    pm.exibir_transacao();

END;

/* TIPO APOSTAR */
DECLARE 
    ap tp_apostar; 
 
BEGIN 
    select value(e) into ap 
    from tb_apostar e 
    where e.pessoas_movimentam_contas = (select REF(pm)  
                        from tb_pessoas_movimentam_contas pm 
                        where pm.Pessoa = (select REF(p) 
                                           from tb_pessoas p 
                                           where p.CPF = '137.897.367-11')); 
    ap.apostas_aovivo(); 
 
END;

