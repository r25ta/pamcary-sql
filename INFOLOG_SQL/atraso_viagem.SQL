
SELECT EEM.ctl_trnsp, ESG.nom_ender_sgp,EG.nom_grupo, ECE.des_email, ECE.nom_email
FROM VINCULADO V, ESTRUTURA_ESTACAO_MONIT EEM, EMAIL_SUB_GRUPO ESG,
    EMAIL_GRUPO EG, EMAIL_CATALOGO_ENDERECO ECE, EMAIL_SUB_GRUPO_ENDERECO ESGE
WHERE EEM.ctl_trnsp = V.ctl_vincd
    AND EEM.ctl_ender_sgp = ESG.ctl_ender_sgp
    AND ESG.ctl_ender_sgp = ESGE.ctl_ender_sgp
    AND ESG.ctl_grupo = EG.ctl_grupo
    AND ESGE.ctl_email = ECE.ctl_email
    AND EG.ctl_grupo = 34
    AND EEM.ctl_trnsp = 41243
ORDER BY ECE.nom_email

SELECT EEM.ctl_trnsp, ESG.nom_ender_sgp,EG.nom_grupo,
ECE.des_email, ECE.nom_email
FROM VINCULADO V, ESTRUTURA_ESTACAO_MONIT EEM,
EMAIL_SUB_GRUPO ESG, EMAIL_GRUPO EG, EMAIL_CATALOGO_ENDERECO ECE,
EMAIL_SUB_GRUPO_ENDERECO ESGE
WHERE EEM.ctl_trnsp = V.ctl_vincd
AND EEM.ctl_ender_sgp = ESG.ctl_ender_sgp
AND ESG.ctl_ender_sgp = ESGE.ctl_ender_sgp
AND ESG.ctl_grupo = EG.ctl_grupo
AND ESGE.ctl_email = ECE.ctl_email
AND EEM.ctl_trnsp = 39979
ORDER BY ECE.nom_email

SELECT RE.nom_vincd AS nom_remet, SUBSTR(TR.nom_guerr,5,25) AS nom_trnsp, DS.nom_guerr AS nom_desti, TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia), 'dd/mm/yyyy hh24:mi') AS dhr_inici_rea, TO_CHAR(DPV.dhr_plvia_ter, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prva, TO_CHAR(RM.dhr_efeti_rea, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prv, Lower(CCRE.des_comun) As email FROM PLANO_VIAGEM PV, DESTINATARIO_PLANO_VIAGEM DPV, VINCULADO RE, VINCULADO DS, VINCULADO TR, ROTEIRO_MOTORISTA RM, COMUNICACAO_CONTATO CCRE WHERE PV.ctl_plvia = DPV.ctl_plvia AND PV.ctl_remet = RE.ctl_vincd AND DPV.ctl_desti = DS.ctl_vincd AND PV.ctl_trnsp = TR.ctl_vincd AND PV.ctl_plvia = RM.ctl_plvia AND DPV.ctl_desti = RM.ctl_ptopd AND PV.ctl_desti = CCRE.ctl_vincd(+) AND CCRE.tip_contt(+) = 30 AND CCRE.tip_comun(+) = 7 AND PV.ctl_plvia = 367912 
