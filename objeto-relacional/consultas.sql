/* CONSULTAS SIMPLES */

/* SELECIONA AS PESSOAS QUE POSSUEM PELO MENOS 1 TELEFONE COM DDD 85 E
AS ORDENA DE ACORDO COM A SOMA DOS BÔNUS
QUE ELAS RECEBERAM */

select media_bonus, P.Nome, P.CPF
from (select f.Nome, f.CPF, avg(B.bonus_turbinado()) as media_bonus
      from tb_pessoas f,
      table(f.Telefones) T,
      table(f.bonus_recebido) B
      where T.codigo_postal() = '85'
      GROUP BY f.Nome, f.CPF
    )P
order by media_bonus;

/* selecionar os indicadores cujas pessoas tenham recebido algum bônus, cuja primeira letra é igual à primeira letra do nome do indicador e ordenar de acordo com o valor do bônus */

select P.nome, P.CPF, P.código_bonus, P.valor
from (select DEREF(Indicador).CPF as CPF, DEREF(Indicador).Nome as Nome, b.código_bonus as código_bonus, 
      b.bonus_turbinado() as valor
      from tb_pessoas t,
      table(t.bonus_recebido) b
      where substr(b.código_bonus, 1, 1) = substr(DEREF(Indicador).Nome, 1, 1)
     ) P
order by P.CPF;


/* selecionando as pessoas com seus saldos 
atualizados após receberem todos os seus bônus e ordenando as */ 
/* TÁ COM ERRO */
select P.cpf, P.Nome, P.Saldo as saldo_inicial, P.soma_bonus as soma_bonus, (P.Saldo + P.soma_bonus) as saldo_final
from(
      select deref(t.Pessoa).Nome AS Nome, deref(t.Pessoa).cpf AS cpf, deref(t.Conta).Saldo as Saldo,
      sum(b.valor) as soma_bonus
      from tb_pessoas_movimentam_contas t, 
      table(deref(t.Pessoa).bonus_recebido) b
      group by deref(t.Pessoa).Nome, deref(t.Pessoa).cpf, deref(t.Conta).Saldo
) P
order by p.cpf;


