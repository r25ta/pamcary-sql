SELECT PV.ctl_plvia,PV.ctl_opera_tip,PV.des_praca_ult,
TO_CHAR(PV.dhr_posic_ult, 'dd/mm hh24:mi') AS dhr_posic_ult,
NVL(TO_CHAR(FC_DHR_INICIO_VIAGEM(PV.ctl_plvia), 'dd/mm hh24:mi'),' ') AS dhr_inici_rea,
FC_VINCULADO_NOM_GUERR(PV.ctl_trnsp) AS nom_trnsp,
FC_VINCULADO_NOM_GUERR(PV.ctl_remet) AS nom_remet,
FC_ID_VEICULO(PV.ctl_plvia) AS num_mct,
FC_PLACA_VEICULO(PV.ctl_plvia) AS num_placa,
PV.obs_plvia, FC_ANALISE_PLVIA_PM(PV.ctl_plvia) AS pm,
FC_ANALISE_PLVIA(PV.ctl_plvia, 20) AS pe,
FC_ANALISE_PLVIA(PV.ctl_plvia, 30) AS oc,
FC_ANALISE_PLVIA(PV.ctl_plvia, 40) AS pnp
FROM PLANO_VIAGEM PV, ESTRUTURA_ESTACAO_MONIT EEM
WHERE PV.tip_rastr = 1
AND PV.sit_plvia NOT IN ( 0, 1, 10 )
AND PV.ctl_user = 1
AND PV.ctl_opera_tip = 13
AND PV.ctl_trnsp = EEM.ctl_trnsp
AND EEM.cod_serve in( 2) ORDER BY nom_trnsp 
