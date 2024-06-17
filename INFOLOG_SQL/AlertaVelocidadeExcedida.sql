
SELECT PV.CTL_PLVIA, 
       TO_CHAR(RAMP.DHR_INICI,'DD/MM/YYYY HH24:MI:SS') AS DT_ALERTA,
       FC_VINCULADO_NOM_GUERR(PV.CTL_TRNSP) AS TRANSP,
       FC_VINCULADO_NOM_GUERR(PV.CTL_REMET) AS ORIGEM,
       FC_VINCULADO_NOM_GUERR(PV.CTL_DESTI) AS DESTINO_FINAL,
       RAMP.COD_PLACA_CAV AS VEICULO,
       MOTOR.NOM_MOTORISTA AS MOTORISTA,
       AV.NUM_VELOC_EXD || ' km/h' AS VELOCIDADE_EXCEDIDA,
       TOV.DES_OPERA_VIE AS TIPO_OPERACAO
       
FROM PLANO_VIAGEM PV, 
     RELAC_ALERTA_MOTOT_PLVIA RAMP,
     INF_MOTORISTA_PLANO_VIAGEM MOT,
     V_CRP_MOTORISTA MOTOR,
     ALERTA_VELOCIDADE AV,
     TIPO_OPERACAO_VIAGEM TOV
  
 WHERE RAMP.TIP_ALERT_VIE = 23
  AND PV.CTL_PLVIA = RAMP.CTL_PLVIA
  AND PV.CTL_PLVIA = MOT.CTL_PLVIA
  AND MOTOR.CTL_MOTOT = MOT.CTL_MOTOT
  AND RAMP.CTL_ALERT_PLV = AV.CTL_ALERT_PLV
  AND TOV.TIP_OPERA_VIE = PV.TIP_OPERA_VIE
  AND PV.CTL_OPERA_TIP = 397
  AND RAMP.DHR_INICI BETWEEN TO_DATE('20190721000001','YYYYMMDDHH24MISS') AND TO_DATE('20190820235959','YYYYMMDDHH24MISS')
  ORDER BY PV.CTL_PLVIA ASC
  