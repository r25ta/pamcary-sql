select fc_vinculado_nom_guerr(ctl_ptopd), to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss'), r.* from roteiro_motorista r
where ctl_plvia = 866160
order by num_seque


select to_char(dhr_passa_cao,'dd/mm/yyyy hh24:mi:ss'), m.* from monitora_cartao_detalhe m
where num_lote_arq = 81291

select * from plano_viagem
where num_pcard = '0246933022'
order by ctl_plvia desc

select * from roteiro_motorista
where ctl_plvia = 866160
order by num_seque desc


select fc_vinculado_nom_guerr(ctl_vincd) from doc_vinculado
where cod_docum = '001000786000100'
