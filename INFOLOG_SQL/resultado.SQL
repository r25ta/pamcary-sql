SELECT PV.ctl_plvia AS ctl_plvia, T.nom_guerr AS nom_trnsp, R.nom_guerr AS nom_guerr,
SUBSTR(D.nom_guerr,5,LENGTH(D.nom_guerr)-4) AS nom_desti,
TO_CHAR( PV.dhr_plvia_ini, 'DD/MM HH24:MI' ) AS dhr_plvia_ini,
TO_CHAR( PV.dhr_plvia_ter, 'DD/MM HH24:MI' ) AS dhr_plvia_ter,
TO_CHAR( PV.dhr_posic_ult, 'DD/MM HH24:MI' ) AS dhr_posic_ult,
TO_CHAR( RM.dhr_efeti_rea, 'DD/MM HH24:MI' ) AS dhr_efeti_rea,
NVL( PV.tip_rastr, 0 ) AS tip_rastr,
NVL( PV.des_praca_ult, ' ' ) AS des_praca_ult,
SPL.des_situa,
NVL( TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia), 'DD/MM HH24:MI'), ' ' ) AS dhr_viage_ini
FROM PLANO_VIAGEM PV, DESTINATARIO_PLANO_VIAGEM DPV, VINCULADO T, VINCULADO D,
VINCULADO R, SITUACAO_PLANO_VIAGEM SPL, ROTEIRO_MOTORISTA RM
WHERE PV.ctl_remet = 12666
AND PV.ctl_trnsp = 12684
AND TO_CHAR(FC_DHR_FIM_VIAGEM(PV.ctl_plvia),'yyyymmdd') BETWEEN '20020731' AND '20020731'
AND RM.ctl_parad = 12
AND PV.ctl_plvia = RM.ctl_plvia
AND PV.sit_plvia = SPL.sit_plvia
AND PV.ctl_remet = R.ctl_vincd
AND PV.ctl_trnsp = T.ctl_vincd
AND PV.ctl_desti = D.ctl_vincd
AND PV.ctl_plvia = DPV.ctl_plvia 
