SELECT
/*
       tp.ctl_opera_tip,
       tp.DES_OPERA_TIP,
       fc_vinculado_nom_guerr(RC.ctl_vincd_rld),
       CRC.des_comun_vin
*/

FROM tipo_operacao tp
     ,RELAC_CONTATO RC
     ,COMUNICACAO_RELAC_CONTATO CRC
WHERE tp.ctl_vincd_emb = RC.CTL_VINCD
and RC.CTL_RELAC_CON = CRC.CTL_RELAC_CON 
AND CRC.tip_comun=7
AND TP.STA_ATIVO = 'S'
GROUP BY tp.DES_OPERA_TIP, CRC.DES_COMUN_VIN
ORDER BY TP.DES_OPERA_TIP

COMMIT

SELECT ICA.DES_EMAIL_ALE, count(1)
/*TP.des_opera_tip,
       ica.nom_contt_ale,
       ica.des_email_ale9
*/
FROM  TIPO_OPERACAO TP
     ,INF_RELAC_CONTT_ALERT IRCT
     ,INF_CONTATO_ALERTA ICA
WHERE TP.ctl_opera_tip = IRCT.ctl_opera_tip
AND ICA.ctl_contt_ale = IRCT.ctl_contt_ale
AND TP.STA_ATIVO = 'S'
GROUP BY ICA.DES_EMAIL_ALE
order by tp.des_opera_tip 




SELECT COUNT(1) FROM PLANO_VIAGEM
WHERE CTL_OPERA_TIP = 292
AND SIT_PLVIA IN (14,0,1)