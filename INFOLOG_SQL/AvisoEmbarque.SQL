select * from dado_adicional_embarc_cliente

select ctl_vincd, fc_vinculado_nom_guerr(ctl_vincd), ctl_vincd_rld, fc_vinculado_nom_guerr(ctl_vincd_rld) from relacionamento_vinculado
where tip_relac = 3
and ctl_vincd = 41243

SELECT * FROM PLANO_VIAGEM

SELECT * FROM TIPO_RELACIONAMENTO

SELECT * FROM TIPO_OPERACAO


select * from dado_adicional_embarc_cliente
where ctl_remet = 41243
and ctl_desti = 77597

SELECT RV.ctl_vincd AS emb_mestre, FC_VINCULADO_NOM_GUERR(RV.ctl_vincd), RV.ctl_vincd_rld AS filial, DAEC.sta_envio
FROM RELACIONAMENTO_VINCULADO RV, DADO_ADICIONAL_EMBARC_CLIENTE DAEC
WHERE RV.ctl_vincd = DAEC.ctl_remet
AND RV.ctl_vincd_rld = DAEC.ctl_desti
AND DAEC.sta_envio = 1
AND RV.ctl_vincd = 50419
AND RV.ctl_vincd_rld = 50419
AND RV.tip_relac IN (1,2,3)

SELECT RV.ctl_vincd AS emb_mestre,
    FC_VINCULADO_NOM_GUERR(RV.ctl_vincd),
    RV.ctl_vincd_rld AS filial, DAEC.sta_envio
FROM RELACIONAMENTO_VINCULADO RV, DADO_ADICIONAL_EMBARC_CLIENTE DAEC
WHERE RV.ctl_vincd = DAEC.ctl_remet
AND RV.ctl_vincd_rld = DAEC.ctl_desti
AND DAEC.sta_envio = 1
AND RV.ctl_vincd = 41243
AND RV.ctl_vincd_rld = 41243
AND RV.tip_relac IN (1,2,3) 

SELECT * FROM COMUNICACAO_RELAC_CONTATO
WHERE ctl_relac_con = 1964

SELECT RC.ctl_vincd, RC.ctl_vincd_rld, RC.nom_contt, CRC.ctl_relac_con, CRC.des_comun_vin
FROM RELAC_CONTATO RC, COMUNICACAO_RELAC_CONTATO CRC
WHERE CRC.tip_comun = 7
AND RC.ctl_relac_con = CRC.ctl_relac_con
AND RC.ctl_vincd = 41243
AND RC.ctl_vincd_rld = 41116

SELECT * FROM CONTA_RASTREAMENTO
where des_conta_rst like '%CO%'

INSERT INTO CONTA_RASTREAMENTO VALUES (128594,128594, 'TRANSPORTES COVRE','SUPERVISOR',SYSDATE)

INSERT INTO VINCULADO VALUES(SQ_CTL_VINCD.NEXTVAL, 8, 1,'TRANSPORTES COVRE', 'EMPRESA DE TRANSPORTES COVRE LTDA','SUPERVISOR',SYSDATE)

SELECT * FROM VINCULADO 
WHERE nom_guerr like '%COVR%'

SELECT * FROM PLANO_VIAGEM
WHERE CTL_TRNSP = 119184

SELECT * FROM DOC_VINCULADO
WHERE CTL_VINCD = 128594

INSERT INTO DOC_VINCULADO VALUES
    (128594,1,'51485274000159','SUPERVISOR',SYSDATE)

SELECT * FROM VINCULADO
WHERE NOM_GUERR LIKE '%COVRE%'

select * from dado_adicional_embarc_cliente
where ctl_remet = 50419

127796
119184
50419

select ctl_remet, fc_vinculado_nom_guerr(ctl_remet) from dado_adicional_embarc_cliente

select * from Plano_viagem
WHERE CTL_OPERA_TIP = 21

SELECT PV.ctl_plvia AS ctl_plvia, PV.ctl_opera_tip AS ctl_opera_tip,
       TPO.ctl_vincd_emb AS ctl_vincd_emb, FC_VINCULADO_NOM_GUERR(TPO.ctl_vincd_emb) AS nom_emb_mestre,
       PV.ctl_remet AS ctl_remet, FC_VINCULADO_NOM_GUERR(PV.ctl_remet) AS nom_remet,
       PV.ctl_desti AS ctl_desti, FC_VINCULADO_NOM_GUERR(PV.ctl_desti) AS nom_desti,
       PV.ctl_trnsp AS ctl_trnsp, FC_VINCULADO_NOM_GUERR(PV.ctl_trnsp) AS nom_trnsp,
       TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia), 'dd/mm/yyyy hh24:mi') AS dhr_inici_rea,
       TO_CHAR(DPV.dhr_plvia_ter, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prva,
       TO_CHAR(RM.dhr_efeti_rea, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prv,
       DPV.num_consi_mer AS ctl_consi_mer, FC_VINCULADO_NOM_GUERR(DPV.num_consi_mer) AS nom_consi_mer,
       AE.sit_envio AS sit_envio
FROM AVISO_EMBARQUE AE, PLANO_VIAGEM PV, TIPO_OPERACAO TPO, DESTINATARIO_PLANO_VIAGEM DPV, ROTEIRO_MOTORISTA RM
WHERE PV.ctl_plvia = AE.ctl_plvia
AND PV.ctl_plvia = DPV.ctl_plvia
AND PV.ctl_plvia = RM.ctl_plvia
AND PV.ctl_desti = DPV.ctl_desti
AND DPV.ctl_desti = RM.ctl_ptopd
AND PV.ctl_opera_tip = TPO.ctl_opera_tip
AND AE.sit_envio = 1

SELECT PV.ctl_plvia, fc_vinculado_nom_guerr(PV.ctl_remet) as nom_remet,
       fc_vinculado_nom_guerr(PV.ctl_desti) as nom_desti,
       fc_vinculado_nom_guerr(PV.ctl_trnsp) as nom_trnsp,
       fc_vinculado_nom_guerr(PV.ctl_motot) as nom_motot,   
       TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia),'DD/MM/YYYY HH24:MI:SS') AS dhr_inicio_viagem,
       TO_CHAR(fc_dhr_fim_viagem(PV.ctl_plvia),'DD/MM/YYYY HH24:MI:SS') as dhr_fim_viagem,
       TO_CHAR(PV.dhr_inclu,'dd/mm/yyyy hh24:mi:ss') AS dhr_inclu,
       fc_qtd_alerta(fc_id_veiculo(PV.ctl_plvia),fc_dhr_inicio_viagem(PV.ctl_plvia),fc_dhr_fim_viagem(PV.ctl_plvia)) as qtd_alerta
FROM PLANO_VIAGEM PV
WHERE PV.ctl_opera_tip = 21
AND PV.sit_plvia = 4
AND TO_CHAR(PV.dhr_inclu,'yyyymmdd') >= '20031001'
ORDER BY PV.dhr_inclu

select * from plano_viagem
where ctl_opera_tip = 21

SELECT DISTINCT AE.ctl_plvia, RE.nom_vincd AS nom_remet, TR.nom_guerr AS nom_trnsp,
    DS.nom_guerr AS nom_desti,  TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia), 'dd/mm/yyyy hh24:mi') AS dhr_inici_rea,
    TO_CHAR(DPV.dhr_plvia_ter, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prva,
    TO_CHAR(RM.dhr_efeti_rea, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prv,
    LOWER(CRC.des_comun_vin) As email, PV.ctl_remet AS ctl_remet, DPV.ctl_desti AS ctl_desti,
    DPV.num_consi_mer AS num_consi_mer
FROM AVISO_EMBARQUE AE, PLANO_VIAGEM PV, DESTINATARIO_PLANO_VIAGEM DPV,
    VINCULADO RE, VINCULADO DS, VINCULADO TR, ROTEIRO_MOTORISTA RM,
    COMUNICACAO_RELAC_CONTATO CRC, RELAC_CONTATO RC
WHERE AE.sit_envio = 1
    AND AE.ctl_plvia = PV.ctl_plvia
    AND PV.ctl_plvia = DPV.ctl_plvia
    AND PV.ctl_remet = RE.ctl_vincd
    AND DPV.ctl_desti = DS.ctl_vincd
    AND PV.ctl_trnsp = TR.ctl_vincd
    AND PV.ctl_plvia = RM.ctl_plvia
    AND DPV.ctl_desti = RM.ctl_ptopd
    AND PV.ctl_remet = RC.ctl_vincd_rld(+)
    AND RC.ctl_relac_con = CRC.ctl_relac_con
    AND CRC.tip_comun(+) = 7

select * from vinculado
where nom_guerr like 'CARAIBA%'

select * from email_solicitacao
order by ctl_solic_env desc

select * from email_solicitacao_endereco
where ctl_solic_env in (95958,95952)

SELECT RV.ctl_vincd AS emb_mestre, FC_VINCULADO_NOM_GUERR(RV.ctl_vincd), RV.ctl_vincd_rld AS filial, DAEC.sta_envio  FROM RELACIONAMENTO_VINCULADO RV, DADO_ADICIONAL_EMBARC_CLIENTE DAEC  WHERE RV.ctl_vincd = DAEC.ctl_remet  AND RV.ctl_vincd_rld = DAEC.ctl_desti  AND DAEC.sta_envio = 1  AND RV.ctl_vincd = 41243 AND RV.ctl_vincd_rld = 41243
 AND RV.tip_relac IN (1,2,3) 

 SELECT PV.ctl_plvia AS ctl_plvia, PV.ctl_opera_tip AS ctl_opera_tip, TPO.ctl_vincd_emb AS ctl_vincd_emb, FC_VINCULADO_NOM_GUERR(ctl_vincd_emb) AS nom_emb_mestre,  PV.ctl_remet AS ctl_remet, FC_VINCULADO_NOM_GUERR(PV.ctl_remet) AS nom_remet,  PV.ctl_desti AS ctl_desti, FC_VINCULADO_NOM_GUERR(PV.ctl_desti) AS nom_desti,  PV.ctl_trnsp AS ctl_trnsp, FC_VINCULADO_NOM_GUERR(PV.ctl_trnsp) AS nom_trnsp,  TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia), 'dd/mm/yyyy hh24:mi') AS dhr_inici_rea,  TO_CHAR(DPV.dhr_plvia_ter, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prva,  TO_CHAR(RM.dhr_efeti_rea, 'dd/mm/yyyy hh24:mi') AS dhr_termi_prv,  DPV.num_consi_mer AS ctl_consi_mer, FC_VINCULADO_NOM_GUERR(DPV.num_consi_mer) AS nom_consi_mer,  AE.sit_envio AS sit_envio  FROM AVISO_EMBARQUE AE, PLANO_VIAGEM PV, TIPO_OPERACAO TPO, DESTINATARIO_PLANO_VIAGEM DPV, ROTEIRO_MOTORISTA RM  WHERE PV.ctl_plvia = AE.ctl_plvia  AND PV.ctl_plvia = DPV.ctl_plvia  AND PV.ctl_plvia = RM.ctl_plvia  AND PV.ctl_desti = DPV.ctl_desti  AND DPV.ctl_desti = RM.ctl_ptopd  AND PV.ctl_opera_tip = TPO.ctl_opera_tip  AND AE.sit_envio = 0 
