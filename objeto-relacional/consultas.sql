/* CONSULTAS SIMPLES */

/* seleciona as pessoas que possuem pelo menos 1 telefone com ddd 85 e a média dos bônus
que elas receberam */

select media_bonus, P.Nome, P.CPF
from (select f.Nome, f.CPF, avg(B.bonus_turbinado()) as media_bonus
      from tb_pessoas f, table(f.Telefones) T, table(f.bonus_recebido) B
      where T.codigo_postal() = '85'
      GROUP BY f.Nome, f.CPF
    )P
order by media_bonus;

/* selecionar os indicadores cujas pessoas tenham recebido algum bônus, cuja primeira letra é igual à primeira letra do nome do indicador e ordenar de acordo com o valor do bônus */

select 
      P.nome, 
      P.CPF, 
      P.código_bonus, 
      P.valor
from (
      select DEREF(Indicador).CPF as CPF, 
      DEREF(Indicador).Nome as Nome, 
      b.código_bonus as código_bonus, 
      b.bonus_turbinado() as valor
      from tb_pessoas t, table(t.bonus_recebido) b
      where substr(b.código_bonus, 1, 1) = substr(DEREF(Indicador).Nome, 1, 1)
     ) P
order by P.CPF;


/* selecionando as pessoas com seus saldos 
atualizados após receberem todos os seus bônus e ordenando as de acordo com o bonus recebido */ 
select 
      P.Nome,
      P.cpf,  
      P.Saldo as saldo_inicial, 
      P.soma_bonus,
      P.saldo_final
from(
      select 
          t.Nome AS Nome, 
          t.cpf AS cpf, 
          t.Saldo as Saldo,
          sum(b.bonus_turbinado()) as soma_bonus,
          sum(b.bonus_turbinado()) + t.Saldo as saldo_final 
      from (
            select *
            from tb_pessoas_movimentam_contas h
            inner join tb_conta c on deref(h.Conta).ID_Conta = c.ID_Conta
            inner join tb_pessoas f on deref(h.Pessoa).CPF = f.CPF
      ) t, 
      table(t.bonus_recebido) b
      group by t.Nome, t.cpf, t.Saldo
) P
order by P.soma_bonus;


/* seleciona o nome das pessoas que apostaram no mercado de resultado em algum evento esportivo junto com o evento no qual elas apostaram e o seu saldo pré aposta e pós aposta, considerando ganho e perda e ordena de acordo com as mais lucrativas  */
select 
    P.Nome, 
    P.Mandante,
    P.Visitante, 
    P.Estadio, 
    P.saldo as saldo_prebet, 
    (P.saldo - P.valor) as saldo_red, 
    (P.saldo - P.valor + (P.valor * P.Odd)) as saldo_green
from(
      select 
        deref(t.pm.Pessoa).Nome AS Nome,
        t.ev.Mandante as Mandante, 
        t.ev.Visitante as Visitante, 
        t.ev.Estadio as Estadio, 
        deref(t.pm.Conta).Saldo as saldo, 
        t.valor as valor, 
        t.resultados.Odd as Odd
      from(
            select 
                deref(a.apostas) as resultados, 
                deref(a.pessoas_movimentam_contas) as pm, 
                deref(a.evento_esportivo) as ev,
                a.valor
            from tb_apostar a
            inner join tb_resultado r on deref(a.apostas).ID_Aposta = r.ID_Aposta 
      )t
)P
order by ((P.valor * P.Odd) - P.valor);


/*selecionar os indicadores, cujas pessoas indicadas possuem apenas telefones com ddd = 81 ou ddd = 83 e que fizeram apostas ao vivo, junto como o valor apostado, a odd e o número de bônus que cada um recebeu além do número de apostas ao vivo que cada um fez */
select F.Nome, F.cpf, a.valor as valor_apostado, deref(a.apostas).Odd as odd, F.maior_bonus, count(e.ID_Evento) as numero_de_apostas_ao_vivo
from tb_apostar a
inner join (
    select c.Saldo, J.Nome, J.cpf, J.maior_bonus
    from tb_pessoas_movimentam_contas h
    inner join tb_conta c on deref(h.Conta).ID_Conta = c.ID_Conta
    inner join (
        select max(b.bonus_turbinado()) as maior_bonus, deref(K.Indicador).Nome as Nome, deref(K.Indicador).cpf as cpf
        from(
            select *
            from tb_pessoas l
            where not exists (
                select 1
                from table(l.Telefones) tel
                where tel.codigo_postal() != '81' and tel.codigo_postal() != '83'
            ) and Indicador IS NOT NULL
        ) K,
        table(deref(K.Indicador).bonus_recebido) b
        group by deref(K.Indicador).Nome, deref(K.Indicador).cpf
    ) J  on h.Pessoa.cpf = J.cpf
) F on deref(deref(a.pessoas_movimentam_contas).Pessoa).cpf = F.cpf
inner join tb_evento_esportivo e on deref(a.evento_esportivo).ID_Evento = e.ID_Evento
where deref(a.evento_esportivo).DataHora <= a.DataHora
GROUP BY F.Nome, F.cpf, a.valor, deref(a.apostas).Odd, F.maior_bonus
order by F.cpf;


/* seleciona a soma dos valores apostados*/
select M.soma
from( 
    select sum(a.valor) as soma
    from tb_apostar a
    left join tb_resultado r on deref(a.apostas).ID_Aposta = r.ID_Aposta
    left join tb_placar p on deref(a.apostas).ID_Aposta = p.ID_Aposta
    left join tb_ambos_marcam amb on deref(a.apostas).ID_Aposta = amb.ID_Aposta
    left join tb_gols g on deref(a.apostas).ID_Aposta = g.ID_Aposta  
) M


/* seleciona o valor total apostado em cada mercado a quantidade de apostas feitas em cada mercado*/
select G.total_apostado_gols, G.apostas_gols, R.total_apostado_resultado, R.apostas_resultado, 
       P.total_apostado_placar, P.apostas_placar, A.total_apostado_ambos, A.apostas_ambos
from
    (select sum(a.valor) as total_apostado_gols, count(g.ID_Aposta) as apostas_gols
    from tb_apostar a
    inner join tb_gols g on deref(a.apostas).ID_Aposta = g.ID_Aposta) G,
    
    (select sum(a.valor) as total_apostado_resultado, count(r.ID_Aposta) as apostas_resultado
    from tb_apostar a
    inner join tb_resultado r on deref(a.apostas).ID_Aposta = r.ID_Aposta) R,

    (select sum(a.valor) as total_apostado_placar, count(p.ID_Aposta) as apostas_placar
    from tb_apostar a
    inner join tb_placar p on deref(a.apostas).ID_Aposta = p.ID_Aposta) P,

    (select sum(a.valor) as total_apostado_ambos, count(amb.ID_Aposta) as apostas_ambos
    from tb_apostar a
    inner join tb_ambos_marcam amb on deref(a.apostas).ID_Aposta = amb.ID_Aposta) A 

/* selecionar a nome, cpf, quantia movimentada e valor apostado pela pessoa que fez a aposta de maior valor*/

select P.Nome, P.cpf, P.quantia_movimentada, P.valor_aposta
from (
       select a.valor as valor_aposta, deref(a.pessoas_movimentam_contas.Pessoa).Nome as Nome, 
       deref(a.pessoas_movimentam_contas.Pessoa).cpf as cpf, 
       deref(a.pessoas_movimentam_contas).valor as quantia_movimentada
       from tb_apostar a
) P
order by P.valor_aposta desc
fetch first 1 row only;











