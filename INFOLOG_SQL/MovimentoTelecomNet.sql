
/* MOVIMENTO TELECOM NET DETALHADO */
SELECT MC.num_lote_arq, MCD.num_termn, MCD.num_funca_col, TO_CHAR(MCD.dhr_passa_cao,'DD/MM/YYYY HH24:MI:SS') AS dhr_passa_cao
FROM MONITORA_CARTAO MC, MONITORA_CARTAO_DETALHE MCD
WHERE MCD.ctl_monit_cao = MC.ctl_monit_cao
AND MC.num_tecno_trm = 1
AND to_char(MC.dhr_gerac_arq,'yyyymmdd') between '20050101' and '20050131'
AND MCD.num_termn <> 1111
ORDER BY num_lote_arq, dhr_passa_cao

select * from monitora_cartao_detalhe
where ctl_monit_cao in ( select ctl_monit_cao from monitora_cartao 
                         where to_char(dhr_gerac_arq,'yyyymmdd') between '20050101' and '20050131'
                        and num_tecno_trm = 1)
order by num_lote_arq

select * from monitora_cartao


/* MOVIMENTO TELECOM NET GERENCIAL */
select num_lote_arq, to_char(dhr_gerac_arq,'dd/mm/yyyy hh24:mi:ss'),qtd_regis_arq from monitora_cartao
where to_char(dhr_gerac_arq,'yyyymmdd') between '20050101' and '20050131'
and num_tecno_trm = 1
order by num_lote_arq
