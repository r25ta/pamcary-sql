select * from user_tables
where table_name like '%INDEV%'


select fc_vinculado_nom_guerr(ctl_ptopd), des_latit, des_longi, r.* from roteiro_motorista r, endereco_vinculado e
where r.ctl_plvia = 1347356
and e.ctl_vincd = r.ctl_ptopd
order by num_seque

select * from praca
where des_praca like '%RECIF%'


SELECT FC_CONV_COORDENADA_DEC_GEO('-34,8811111450195',1) FROM DUAL

select * from endereco_vinculado
UPDATE endereco_vinculado SET
DES_LATIT = '080314',
DES_LONGI='345252'
WHERE CTL_VINCD = 310696

select  sit_plvia from plano_viagem 
where ctl_plvia=1347356


commit

update plano_viagem 
set sit_plvia=0
where ctl_plvia=1347356

update destinatario_plano_viagem 
set sit_plvia=0
where ctl_plvia=1347356



select * from evento_indevido_plano_viagem
where ctl_plvia=1347356

 SELECT RM.ctl_plvia AS ctl_plvia, RM.ctl_rtmot AS ctl_rtmot, RM.ctl_ptopd AS ctl_ptopd,  PV.ctl_opera_tip, RM.num_seque, RM.ctl_parad,
 PV.sit_plvia, RM.sit_fase_rea, NVL(TO_CHAR(RM.dhr_efeti_rea ,'YYYYMMDDHH24MISS'),' ') AS dhr_efeti_rea,
 NVL(TO_CHAR(RM.dhr_previ_sis ,'YYYYMMDDHH24MISS'),' ') AS dhr_previ_sis,  NVL(TO_CHAR(RM.dhr_previ_mot ,'YYYYMMDDHH24MISS'),' ') AS dhr_previ_mot,
 NVL(EV.des_latit,0) AS des_latit, NVL(EV.des_longi,0) AS des_longi,  NVL(EV.num_latit,0) AS num_latit, NVL(EV.num_longi,0) AS num_longi,
 PR.des_praca AS des_praca,  UF.nom_unfed AS nom_unfed,  NVL(RM.dia_rtvia_qtd,0) AS dia_rtvia_qtd,
 NVL( TO_CHAR(RM.hor_rtvia_qtd,'HH24MISS'),'000001' ) AS hor_rtvia_qtd,  NVL (RM.ord_desti,0) AS ord_desti
 FROM PLANO_VIAGEM PV, ROTEIRO_MOTORISTA RM,  ENDERECO_VINCULADO EV, PRACA PR, UNIDADE_FEDERAL UF
 WHERE PV.ctl_plvia = 1347356 AND RM.ctl_parad IN (24, 13, 25, 12) AND PV.sit_plvia IN ( 0, 1 )
 AND PV.ctl_plvia = RM.ctl_plvia  AND RM.ctl_ptopd = EV.ctl_vincd  AND EV.cod_praca = PR.cod_praca
 AND PR.cod_unfed = UF.cod_unfed
 ORDER BY RM.num_seque 


 SELECT ctl_plvia, ctl_rtmot, ctl_ptopd, ctl_parad, sit_fase_rea, ord_desti, NVL(TO_CHAR(dhr_efeti_rea,'YYYYMMDDHH24MISS'),' ') AS dhr_event_rea
 FROM ROTEIRO_MOTORISTA
 WHERE dhr_efeti_rea = (SELECT max(dhr_efeti_rea) FROM ROTEIRO_MOTORISTA WHERE sit_fase_rea IN ('R','T')
 AND ctl_plvia = 1347356
 AND ctl_ptopd = 176776
 AND ord_desti = 1)
 AND ctl_plvia =1347356
 AND ord_desti = 1
 AND ctl_ptopd = 176776
 ORDER BY num_seque
 
 
 
select * from hist_log_monitora_terminal
where ctl_plvia = 1347356
and num_termn = 203899
