
SELECT * FROM TIPO_OPERACAO
WHERE CTL_OPERA_TIP = 183

/*PARAMETRIZAÇÃO INFOLOG*/
SELECT * FROM PERFIL_PARAMETRO_INFOLOG
WHERE CTL_VINCD = 12680


/*CONSULTA POSICAO DISPOSITIVO*/
select d.cod_dispo_rst, p.*
from posicao_dispositivo p, dispositivo d
where d.ctl_dispo_rst = p.ctl_dispo_rst
AND P.STA_PROCS = 'N'
--AND P.CTL_POSIC_DIO IN (494314,515755,515688,514979,514780,514980,514256,514257)
ORDER BY CTL_POSIC_DIO

/*TROCA STATUS*/
UPDATE POSICAO_DISPOSITIVO SET
STA_PROCS = 'S'
WHERE CTL_POSIC_DIO IN (494314,515755,515688,514979,514780,514980,514256,514257)



/* 1 - COMETA SP BASE 840 ENTRADA - 494314*/
update posicao_dispositivo set
NUM_BASE_COL = 840,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'ENTRADA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 494314

/* 2 - COMETA SP BASE 840 SAIDA - 514256*/
update posicao_dispositivo set
NUM_BASE_COL = 840,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'SAIDA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 514256

/* 3 - POSTO COTEGY BASE 849 ENTRADA - 514979*/
update posicao_dispositivo set
NUM_BASE_COL = 849,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'ENTRADA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 514257

/* 4 - POSTO COTEGY BASE 849 SAIDA - 514980*/
update posicao_dispositivo set
NUM_BASE_COL = 849,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'SAIDA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 514780



/* 5 - POSTO PETROPAL BASE 843 ENTRADA - 515688*/
update posicao_dispositivo set
NUM_BASE_COL = 843,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'ENTRADA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 514979

/* 6 - POSTO PETROPAL BASE 843 SAIDA - 515755*/
update posicao_dispositivo set
NUM_BASE_COL = 843,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'SAIDA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 514980



/* 7 - COMETA FORTALEZA BASE 520 ENTRADA - 514257*/
update posicao_dispositivo set
NUM_BASE_COL = 520,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'ENTRADA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 515688

/* 8 - COMETA FORTALEZA BASE 520 SAIDA - 514780*/
update posicao_dispositivo set
NUM_BASE_COL = 520,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'SAIDA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 515755


/* 9 - COMETA SAO LUIS BASE 600 ENTRADA - 334247*/
update posicao_dispositivo set
NUM_BASE_COL = 600,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'ENTRADA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 334247

/* 10 - COMETA SAO LUIS BASE 600 SAIDA - 335086*/
update posicao_dispositivo set
NUM_BASE_COL = 600,
CTL_PARAD = NULL,
COD_EVENT_ORI = 'SAIDA',
sta_procs = 'N',
dhr_event = sysdate
where ctl_posic_dio = 335086
















select * from relac_veiculo_dispositivo
WHERE CTL_VEICU = 86841

select * from veiculo
where num_placa = 'CLL5974'




SELECT * FROM PARADA_VINCULADO
WHERE CTL_OPERA_TIP = 183

SELECT * FROM REF_PARADA_VINCULADO

SELECT * FROM REF_VINCULADO_CLIENTE


SELECT * FROM BASE_COLETORA
WHERE NUM_BASE_COL IN (840,849,843,520,600)
where DES_base_col like '%PETROPAL%'

SELECT FC_VINCULADO_NOM_GUERR(CTL_VINCD), D.* FROM DOC_VINCULADO D
WHERE CTL_VINCD = 271174

INSERT INTO DOC_VINCULADO VALUES(278722,1,'10970887000447','SUPERVISOR',SYSDATE)

UPDATE DOC_VINCULADO SET
COD_DOCUM = '10970887000447'
WHERE CTL_VINCD = 278722

UPDATE BASE_COLETORA SET
CTL_VINCD = 271174
where NUM_BASE_COL = 600



select * from rota
where ctl_OPERA_TIP = 183

SELECT sq_dispos_ctldispo.nextval AS proximo FROM dual



select fc_vinculado_nom_guerr(ctl_ptopd), r.* from roteiro_viagem r
where ctl_rota = 2177
--AND CTL_OPERA_TIP = 51
order by num_seque_ord

select * from usuario_internet
where usr_name like '%COMETA%'

select * from plano_viagem
where ctl_plvia = 860944



select to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi'), ctl_parad,
fc_vinculado_nom_guerr(ctl_ptopd),
r.* from roteiro_motorista r
where ctl_plvia = 860946
order by num_seque

UPDATE ROTEIRO_MOTORISTA SET
CTL_PTOPD = 271150
WHERE CTL_RTMOT IN (4177746,4177747)





/*RELACIONAMENTO DISPOSITIVO*/
 SELECT PV.ctl_plvia, PV.ctl_trnsp, PV.ctl_remet, PV.ctl_motot,
  PV.ctl_opera_tip, PV.ctl_rtvia, PV.sit_plvia,
  TO_CHAR(PV.dhr_plvia_ini,'DDMMYYYYHH24MISS') AS dhr_plvia_ini,
  NVL(sta_circu_etc,'N') AS sta_circu_etc
  FROM PLANO_VIAGEM PV, RELAC_VEICULO_DISPO_PLANO RVDP
  WHERE PV.sit_plvia IN(0,1)
  AND RVDP.ctl_dispo_rst = 1052
  AND RVDP.ctl_plvia = PV.ctl_plvia

/*VEICULO PLANO*/
 SELECT PV.ctl_plvia, PV.ctl_trnsp, PV.ctl_remet, PV.ctl_motot, PV.ctl_opera_tip, PV.ctl_rtvia, PV.sit_plvia,
 TO_CHAR(PV.dhr_plvia_ini,'DDMMYYYYHH24MISS') AS dhr_plvia_ini,
 NVL(sta_circu_etc,'N') AS sta_circu_etc
 FROM PLANO_VIAGEM PV, VEICULO_PLANO_VIAGEM VPV
 WHERE PV.sit_plvia IN(0,1)
 AND VPV.cod_trnpo = '100001807'
 AND VPV.ctl_plvia = PV.ctl_plvia

/*BASE*/
 SELECT num_base_col,  tip_rastr_col,  NVL(sit_base_col,'0') AS sit_base_col, num_praca,  des_base_col, NVL(num_cnpj_bse,'00000000000000') AS num_cnpj_bse, NVL(num_inses_bse, ' ') AS num_inses_bse,  NVL(num_unfed_isc, ' ') AS num_unfed_isc, NVL(num_latit_bse,'000000') AS num_latit_bse,  NVL(num_longi_bse,'000000') AS num_longi_bse,  cod_cep, des_ender_bse,  sta_local_km, NVL(des_compl_end,' ') AS des_compl_end,  des_alias_bse,  P.des_praca, UF.sig_unfed, bc.ctl_vincd FROM BASE_COLETORA BC, PRACA P, UNIDADE_FEDERAL UF  WHERE num_base_col = 840 AND BC.num_praca = P.cod_praca AND UF.cod_unfed = P.cod_unfed AND tip_rastr_col = 3

 /*EVENTO X BASE */
  SELECT  P.ctl_parad_ent,  P.ctl_parad_sai FROM BASE_COLETORA B, PARADA_VINCULADO P  WHERE B.num_base_col = P.num_base_col  AND P.num_base_col = 840 AND P.ctl_opera_tip = 183

/* VEICULO DISPOSITIVO ATUALIZA*/
 SELECT DISTINCT(RVDP.ctl_plvia), RVDP.ctl_veicu, V.num_placa, NVL(DV.cod_docum,' ') AS cod_docum  FROM RELAC_VEICULO_DISPO_PLANO RVDP, VEICULO V, DOC_VINCULADO DV WHERE V.ctl_veicu = RVDP.ctl_veicu AND V.ctl_trnsp = DV.ctl_vincd AND RVDP.ctl_plvia =860944

/*LOCALIZA EVENTO*/
SELECT RM.ctl_plvia AS ctl_plvia, RM.ctl_rtmot AS ctl_rtmot, RM.ctl_ptopd AS ctl_ptopd,  PV.ctl_opera_tip, RM.num_seque, RM.ctl_parad, PV.sit_plvia, RM.sit_fase_rea, NVL(TO_CHAR(RM.dhr_efeti_rea ,'DDMMYYYYHH24MISS'),' ') AS dhr_efeti_rea,  NVL(TO_CHAR(RM.dhr_previ_sis ,'DDMMYYYYHH24MISS'),' ') AS dhr_previ_sis,  NVL(TO_CHAR(RM.dhr_previ_mot ,'DDMMYYYYHH24MISS'),' ') AS dhr_previ_mot,  NVL(EV.des_latit,0) AS des_latit, NVL(EV.des_longi,0) AS des_longi,  NVL(EV.num_latit,0) AS num_latit, NVL(EV.num_longi,0) AS num_longi,  PR.des_praca AS des_praca,  UF.nom_unfed AS nom_unfed,  NVL(RM.dia_rtvia_qtd,0) AS dia_rtvia_qtd,  NVL( TO_CHAR(RM.hor_rtvia_qtd,'HH24:MI:SS'),'00:00:01' ) AS hor_rtvia_qtd  FROM PLANO_VIAGEM PV, ROTEIRO_MOTORISTA RM,  ENDERECO_VINCULADO EV, PRACA PR, UNIDADE_FEDERAL UF  WHERE PV.ctl_plvia = 860944 AND RM.ctl_parad = 24 AND PV.sit_plvia IN ( 0, 1 )  AND PV.ctl_plvia = RM.ctl_plvia  AND RM.ctl_ptopd = EV.ctl_vincd  AND EV.cod_praca = PR.cod_praca  AND PR.cod_unfed = UF.cod_unfed  ORDER BY RM.num_seque

 SELECT RM.ctl_rtmot  FROM ROTEIRO_MOTORISTA RM, DOC_VINCULADO DV  WHERE RM.ctl_ptopd = DV.ctl_vincd  AND RM.ctl_plvia = 860944 AND DV.cod_docum = 10970887000285 AND RM.ctl_parad = 10 AND RM.sit_fase_rea NOT IN('R','T') AND DV.tip_docum = 1


 /*LOCALIZA EVENTOS PARA RECALCULO*/
  SELECT DES_DIFER_DAT, ctl_rtmot, ctl_ptopd,  ctl_parad, num_seque, NVL( TO_CHAR(dhr_previ_sis, 'DD/MM/YYYY HH24:MI:SS'), ' ' ) AS dhr_previ_sis,
  NVL( TO_CHAR(dhr_efeti_rea, 'DD/MM/YYYY HH24:MI:SS'), ' ' ) AS dhr_efeti_rea,
  NVL( TO_CHAR(dhr_previ_sis, 'DD/MM/YYYY HH24:MI:SS'), ' ' ) AS DHR_PREVI_MOT, sit_fase_rea, NVL( TO_CHAR(hor_rtvia_qtd, 'HH24MISS'), '000001') AS hor_rtvia_qtd FROM ROTEIRO_MOTORISTA
  WHERE ctl_plvia = 860947
  ORDER BY NUM_SEQUE




    AND num_seque >= 2.0AND ctl_parad <> 12  AND ctl_parad NOT IN (11,17,18,20,23,24,26) ORDER BY num_seque
















 SELECT RM.ctl_rtmot  FROM ROTEIRO_MOTORISTA RM, DOC_VINCULADO DV  WHERE RM.ctl_ptopd = DV.ctl_vincd  AND RM.ctl_plvia = 860947 AND DV.cod_docum = 41113804000184 AND RM.ctl_parad = 13 AND RM.sit_fase_rea NOT IN('R','T') AND DV.tip_docum = 1 
