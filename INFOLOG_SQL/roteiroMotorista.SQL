select * from tipo_parada
order by ctl_parad

select RM.ctl_rtmot, RM.ctl_ptopd, fc_vinculado_nom_guerr(RM.ctl_ptopd), DV.cod_docum, EV.des_latit, EV.des_longi,
RM.ctl_parad, RM.sit_fase_rea, TO_CHAR(RM.dhr_previ_sis,'dd/mm/yyyy hh24:mi:ss') AS sis,
TO_CHAR(RM.dhr_previ_mot,'dd/mm/yyyy hh24:mi:ss') AS mot,
TO_CHAR(RM.dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss') AS real,
TO_CHAR(RM.dhr_manut,'dd/mm/yyyy hh24:mi:ss') AS manut,
RM.dia_rtvia_qtd,
TO_CHAR(RM.hor_rtvia_qtd,'hh24:mi:ss') AS PREVI,
RM.qtd_klm_tre
from roteiro_motorista RM, doc_vinculado DV, endereco_vinculado EV
where ctl_plvia = 854048
and DV.ctl_vincd = RM.ctl_ptopd
and EV.ctl_vincd = RM.ctl_ptopd
order by num_seque


select * from endereco_vinculado



SELECT CR.ctl_relac_con
FROM relac_contato RC, comunicacao_relac_contato CR, perfil_alerta_viagem PAV
WHERE RC.ctl_vincd = 108762
AND RC.ctl_vincd_rld in ( 266655,266658,108762,162784,162784 )
AND CR.tip_comun = 7
AND PAV.tip_alert_vie =12
AND PAV.ctl_vincd = RC.ctl_vincd
AND PAV.ctl_vincd_rld = RC.ctl_vincd_rld
AND RC.ctl_relac_con = CR.ctl_relac_con 


SELECT * FROM COMUNICACAO_RELAC_CONTATO
WHERE CTL_RELAC_CON IN(5421,7325,7815,7819,8681,8682)

SELECT * FROM PERFIL_ALERTA_VIAGEM
WHERE CTL_VINCD = 108762
AND CTL_VINCD_RLD IN (266655,266658,108762,162784,162784)

SELECT * FROM RELAC_CONTATO
SELECT * FROM RELAC_CONTATO
WHERE CTL_VINCD = 108762
AND CTL_VINCD_RLD IN (266655,266658,108762,162784,162784)

select * from comunicacao_relac_contato

select * from tipo_alerta_viagem




update roteiro_motorista set
sit_fase_rea = 'S',
sta_telef=null,
dhr_efeti_rea = null
where ctl_rtmot = 4084480

SELECT CR.ctl_relac_con  FROM relac_contato RC, comunicacao_relac_contato CR, perfil_alerta_viagem PAV  WHERE RC.ctl_vincd = 108762 AND RC.ctl_vincd_rld in ( 266655,266658,108762,162784,162784 ) AND CR.tip_comun = 7 AND PAV.tip_alert_vie =12 AND PAV.ctl_vincd = RC.ctl_vincd AND PAV.ctl_vincd_rld = RC.ctl_vincd_rld AND RC.ctl_relac_con = CR.ctl_relac_con 
