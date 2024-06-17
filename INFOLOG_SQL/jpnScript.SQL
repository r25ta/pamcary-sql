select r.ctl_rtmot, r.ctl_ptopd, FC_VINCULADO_NOM_GUERR(r.ctl_ptopd) as nome , d.cod_docum, r.ctl_parad,
TO_CHAR(r.dhr_efeti_rea,'DD/MM/YYYY HH24:MI:SS') AS REAL, TO_CHAR(r.dhr_previ_sis,'DD/MM/YYYY HH24:MI:SS') AS SIST,
r.des_difer_dat,
r.sit_fase_rea,
r.ord_desti, r.num_seque,ev.des_latit, ev.des_longi, r.cod_user
from roteiro_motorista r, doc_vinculado d, endereco_vinculado ev
where ctl_plvia = 000858614
and d.ctl_vincd = r.ctl_ptopd
and ev.ctl_vincd = r.ctl_ptopd
order by num_seque


UPDATE POSICAO_DISPOSITIVO SET  ctl_rtmot = 4156903, ctl_parad = 10,, sit_proce_int = 'R' sta_procs = 'S' WHERE ctl_posic_dio = 288488
select * from plano_viagem
where ctl_plvia = 000858593

select * from destinatario_plano_viagem
where ctl_plvia = 000858593



SELECT num_base_col,  tip_rastr_col,  NVL(sit_base_col,'0') AS sit_base_col, num_praca,  des_base_col, NVL(num_cnpj_bse,'00000000000000') AS num_cnpj_bse, NVL(num_inses_bse, ' ') AS num_inses_bse,  NVL(num_unfed_isc, ' ') AS num_unfed_isc, NVL(num_latit_bse,'000000') AS num_latit_bse,  NVL(num_longi_bse,'000000') AS num_longi_bse,  cod_cep, des_ender_bse,  sta_local_km, NVL(des_compl_end,' ') AS des_compl_end,  des_alias_bse,  P.des_praca, UF.sig_unfed FROM BASE_COLETORA BC, PRACA P, UNIDADE_FEDERAL UF  WHERE num_base_col = 841 AND BC.num_praca = P.cod_praca AND UF.cod_unfed = P.cod_unfed AND tip_rastr_col = 3
SELECT ctl_rtmot, ctl_ptopd,  ctl_parad, num_seque, NVL( TO_CHAR(dhr_previ_sis, 'DDMMYYYYHH24MISS'), ' ' ) AS dhr_previ_sis,  NVL( TO_CHAR(dhr_efeti_rea, 'DDMMYYYYHH24MISS'), ' ' ) AS dhr_efeti_rea,  sit_fase_rea, NVL( TO_CHAR(hor_rtvia_qtd, 'HH24MISS'), '000001') AS hor_rtvia_qtd FROM ROTEIRO_MOTORISTA  WHERE ctl_plvia = 858580 AND num_seque >= 0.0AND ctl_parad <> 12  AND ctl_parad NOT IN (11,17,18,20,23,24,26) ORDER BY num_seque


SELECT *
FROM POSICAO_DISPOSITIVO
where cod_dispo_rst = 171
order by ctl_posic_dio desc
WHERE sta_procs = 'N' ORDER BY num_lote 


SELECT num_base_col,  tip_rastr_col,  NVL(sit_base_col,'0') AS sit_base_col, num_praca,  des_base_col, NVL(num_cnpj_bse,'00000000000000') AS num_cnpj_bse, NVL(num_inses_bse, ' ') AS num_inses_bse,  NVL(num_unfed_isc, ' ') AS num_unfed_isc, NVL(num_latit_bse,'000000') AS num_latit_bse,  NVL(num_longi_bse,'000000') AS num_longi_bse,  cod_cep, des_ender_bse,  sta_local_km, NVL(des_compl_end,' ') AS des_compl_end,  des_alias_bse,  P.des_praca, UF.sig_unfed FROM BASE_COLETORA BC, PRACA P, UNIDADE_FEDERAL UF  WHERE num_base_col = 841 AND BC.num_praca = P.cod_praca AND UF.cod_unfed = P.cod_unfed AND tip_rastr_col = 3



select * from posicao_dispositivo
order by ctl_posic_dio desc

update posicao_dispositivo set
sta_procs = 'N',
DHR_EVENT = TO_DATE('20061213150001','YYYYMMDDHH24MISS'),
CTL_PARAD = 10
where ctl_posic_dio = 288488

update veiculo_plano_viagem set
cod_trnpo='000001716'
where ctl_plvia = 000858614


update posicao_dispositivo set
sta_procs = 'N',
DHR_EVENT = TO_DATE('20061213140001','YYYYMMDDHH24MISS'),
CTL_PARAD = 10
where ctl_posic_dio = 288488
