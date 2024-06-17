select * from aviso_embarque
where sit_envio = 0

select * from aviso_embarque
where ctl_plvia = 459388 


update aviso_embarque set
sit_envio = 1
where ctl_plvia = 459388

select * from vinculado
where ctl_vincd = 41059


SELECT DISTINCT AE.ctl_plvia, RE.nom_vincd AS nom_remet,
    SUBSTR(TR.nom_guerr,5,25) AS nom_trnsp,  DS.nom_guerr AS nom_desti,
    TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia), 'dd/mm/yyyy hh24:mi') AS dhr_inici_rea,
    TO_CHAR(DPV.dhr_plvia_ter, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prva,
    TO_CHAR(RM.dhr_efeti_rea, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prv,
    LOWER(CCRE.des_comun) As email, DPV.ctl_desti AS ctl_desti,
    DPV.num_consi_mer AS num_consi_mer
FROM AVISO_EMBARQUE AE, PLANO_VIAGEM PV, DESTINATARIO_PLANO_VIAGEM DPV,  VINCULADO RE,
    VINCULADO DS, VINCULADO TR, ROTEIRO_MOTORISTA RM,  COMUNICACAO_CONTATO CCRE
WHERE AE.sit_envio = 0
AND AE.ctl_plvia = PV.ctl_plvia
AND PV.ctl_plvia = DPV.ctl_plvia
AND PV.ctl_remet = RE.ctl_vincd
AND DPV.ctl_desti = DS.ctl_vincd
AND PV.ctl_trnsp = TR.ctl_vincd
AND PV.ctl_plvia = RM.ctl_plvia
AND DPV.ctl_desti = RM.ctl_ptopd
AND PV.ctl_remet = CCRE.ctl_vincd(+)
AND CCRE.tip_contt(+) = 30
AND CCRE.tip_comun(+) = 7 

 SELECT FC_EMAIL_CTL_SOLIC_ENV AS ctl_solic_env, ESG.ctl_ender_sgp, ECE.nom_email AS nom_email, ECE.des_email AS des_email, EG.nom_grupo AS nom_grupo, ESG.nom_ender_sgp AS nom_ender_sgp  FROM EMAIL_CATALOGO_ENDERECO ECE, EMAIL_GRUPO EG, EMAIL_SUB_GRUPO ESG, EMAIL_SUB_GRUPO_ENDERECO ESGE  WHERE ECE.ctl_email = ESGE.ctl_email  AND EG.ctl_grupo = ESG.ctl_grupo  AND ESG.ctl_ender_sgp = ESGE.ctl_ender_sgp  AND EG.ctl_grupo = 27
 
  SELECT PV.ctl_plvia, PV.ctl_remet AS ctl_remet, DPV.ctl_desti AS ctl_desti,DPV.num_consi_mer AS num_consi_mer, TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia), 'DD/MM/YYYY HH24:MI') AS dhr_inici_rea,  TO_CHAR(DPV.dhr_plvia_ter, 'DD/MM/YYYY HH24:MI') AS dhr_termi_prva  FROM PLANO_VIAGEM PV, DESTINATARIO_PLANO_VIAGEM DPV  WHERE PV.ctl_plvia = DPV.ctl_plvia  AND PV.ctl_plvia = 459388

 SELECT sta_envio FROM DADO_ADICIONAL_EMBARC_CLIENTE  WHERE ctl_remet = 41243 AND ctl_desti = 41059
   
   SELECT sta_envio FROM DADO_ADICIONAL_EMBARC_CLIENTE  WHERE ctl_remet = 41243 AND ctl_desti = 41041
