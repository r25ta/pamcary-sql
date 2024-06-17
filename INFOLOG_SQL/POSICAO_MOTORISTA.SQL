/*DADOS DO MOTORISTA*/
SELECT MO.nom_guerr AS nom_motot, NVL(MPV.num_pcard, '') AS num_pcard,
NVL(DV.cod_docum, '') AS cod_docum,
NVL(SCF.prontuario,0) AS prontuario
FROM MOTORISTA_PLANO_VIAGEM MPV, VINCULADO MO, DOC_VINCULADO DV, CONSULTA SCF
WHERE MPV.ctl_plvia = 221267
AND MPV.ctl_motot = MO.ctl_vincd
AND MO.ctl_vincd = DV.ctl_vincd(+)
AND DV.cod_docum = LPAD(TO_CHAR(SCF.cpf),11,'0')
ORDER BY MPV.ord_motot

/*SELECT NOME REMETENTE, TRNSP E DHR_SAIDA*/
SELECT NVL(RE.nom_guerr, ' ' ) AS nom_remet,
NVL(T.nom_guerr, ' ' ) AS nom_trnsp,
TO_CHAR(PV.dhr_plvia_ini, 'DD/MM/YYYY HH24:MI') AS dhr_plvia_ini
FROM PLANO_VIAGEM PV, VINCULADO RE, VINCULADO T
WHERE PV.ctl_plvia = 221267
AND PV.ctl_remet = RE.ctl_vincd
AND PV.ctl_trnsp = T.ctl_vincd

/*SELECT PARA DESCOBRIR OS DESTINATARIOS*/
SELECT DS.nom_guerr AS nom_desti,
NVL(TO_CHAR(DPL.dhr_plvia_ter,'dd/mm/yyyy hh24:mi'), ' ') AS dhr_plvia_ter
FROM DESTINATARIO_PLANO_VIAGEM DPL, VINCULADO DS
WHERE DPL.ctl_plvia = 221267
AND DPL.ctl_desti = DS.ctl_vincd
ORDER BY ord_desti 



/*SELECT PARA DESCOBRIR OS DADOS DO VEICULO*/
SELECT V.ctl_veicu, V.num_placa, V.des_veicu_cor, V.ano_veicu, ModV.des_model,
MV.des_marca, GV.des_gener, TV.des_veicu_tip, NVL(V.des_praca, ' ') AS des_praca0,
NVL(UF.sig_unfed,' ')||'-'||NVL(PR.des_praca, ' ') AS des_praca1
FROM VEICULO_PLANO_VIAGEM VPV, VEICULO V, GENERO_VEICULO GV, TIPO_VEICULO TV,
MARCA_VEICULO MV, MODELO_VEICULO ModV, PRACA PR, UNIDADE_FEDERAL UF
WHERE VPV.ctl_plvia = 221267
AND VPV.ctl_veicu = V.ctl_veicu
AND V.ctl_model = ModV.ctl_model
AND ModV.ctl_marca = MV.ctl_marca
AND ModV.ctl_gener = GV.ctl_gener
AND TV.ctl_veicu_tip = GV.ctl_veicu_tip
AND V.cod_praca = PR.cod_praca(+)
AND PR.cod_unfed = UF.cod_unfed(+) 

/* SELECT DO ROTEIRO DA VIAGEM*/
SELECT RM.ctl_rtmot, RM.ctl_plvia, RM.ctl_user, RM.ctl_ptopd, RM.ctl_parad,
NVL(RM.obs_rtmot, ' ') AS obs_rtmot, NVL(RM.obs_rtmot, ' ') AS obs_rtmot,
TO_CHAR(RM.dhr_previ_sis, 'DD/MM/YYYY HH24:MI:SS') AS dhr_previ_sis,
TO_CHAR(RM.dhr_previ_mot, 'DD/MM/YYYY HH24:MI:SS') AS dhr_previ_mot,
TO_CHAR(RM.dhr_efeti_rea, 'DD/MM HH24:MI') AS dhr_efeti_rea,
NVL(RM.sit_fase_rea, ' ') AS sit_fase_rea, TP.sig_parad,
NVL(PP.nom_guerr, ' ' ) AS nom_ptopd,
NVL(PR.des_praca, ' ') AS des_praca,
NVL(PR.cod_praca, 0) AS cod_praca,
NVL(UF.sig_unfed, ' ') AS sig_unfed
FROM ROTEIRO_MOTORISTA RM, TIPO_PARADA TP, VINCULADO PP, ENDERECO_VINCULADO EV,
PRACA PR, UNIDADE_FEDERAL UF
WHERE RM.ctl_plvia = 221267
AND RM.ctl_ptopd = PP.ctl_vincd
AND PP.ctl_vincd = EV.ctl_vincd(+)
AND EV.cod_praca = PR.cod_praca(+)
AND PR.cod_unfed = UF.cod_unfed(+)
AND RM.ctl_parad = TP.ctl_parad
ORDER BY RM.num_seque 
