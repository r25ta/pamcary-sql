
SELECT P.ctl_plvia, P.tip_rastr, C.des_cirto, FC_VINCULADO_NOM_GUERR(P.ctl_motot) AS nom_motot,
       P.num_pcard, TO_CHAR(P.dhr_posic_ult,'DD/MM/YYYY HH24:MI:SS') AS dhr_posic_ult, P.des_praca_ult
FROM PLANO_VIAGEM P, CIRCUITO C
WHERE P.ctl_cirto = C.ctl_cirto
AND P.sit_plvia IN (0,1)
AND P.ctl_opera_tip = 20

SELECT * FROM ROTEIRO_MOTORISTA

/* DADOS DA VIAGEM ROTEIRO MOTORISTA*/
SELECT R.ctl_plvia, R.ctl_rtmot, R.ctl_user, R.ctl_ptopd, FC_VINCULADO_NOM_GUERR(R.ctl_ptopd) AS entidade, R.ctl_parad, TP.sig_parad, R.num_seque,
    TO_CHAR(R.dhr_previ_sis,'DD/MM/YYYY HH24:MI') AS dhr_previ_sis,
    TO_CHAR(R.dhr_previ_mot,'DD/MM/YYYY HH24:MI') AS dhr_previ_mot,
    TO_CHAR(R.dhr_efeti_rea,'DD/MM/YYYY HH24:MI') AS dhr_efeti_rea,
    R.sit_fase_rea
FROM ROTEIRO_MOTORISTA R, TIPO_PARADA TP
WHERE TP.ctl_parad = R.ctl_parad
order by ctl_plvia desc

AND R.ctl_plvia =
ORDER BY R.num_seque

SELECT * FROM VEICULO

SELECT * FROM VEICULO_PLANO_VIAGEM
where ctl_plvia = 813986


SELECT VPV.ctl_plvia, VPV.ctl_veicu
FROM VEICULO V, VEICULO_PLANO_VIAGEM VPV


/*DADOS DO VEICULO */
SELECT VPV.ctl_veicu,
       V.num_placa,
       TV.ctl_veicu_tip,
       NVL(TV.des_veicu_tip, ' ') AS des_veicu_tip,
       NVL(V.des_veicu_cor,' ') AS des_veicu_cor,
       NVL(V.ano_veicu,' ') AS ano_veicu,
       NVL(V.des_frota,' ') AS des_frota,
       NVL(V.cod_chass,' ') AS cod_chass,
       NVL(V.des_praca,' ') AS des_praca,
       NVL(V.num_mct,0) AS num_mct,
       NVL(V.sit_veicu,0) AS sit_veicu,
       NVL(V.qtd_eixo,0) AS qtd_eixo,
       NVL(V.ton_bruto,0) AS ton_bruto,
       NVL(V.num_renav,0) AS num_renav,
       NVL(GV.des_gener,' ') AS des_gener,
       NVL(MV.des_model,' ') AS des_model,
       NVL(MA.des_marca,' ') AS des_marca,
       NVL(UF.sig_unfed,' ') AS sig_unfed,
       NVL(UF.nom_unfed,' ') AS nom_unfed
FROM VEICULO_PLANO_VIAGEM VPV, VEICULO V, GENERO_VEICULO GV, MODELO_VEICULO MV, MARCA_VEICULO MA, PRACA P, UNIDADE_FEDERAL UF, TIPO_VEICULO TV
WHERE VPV.ctl_plvia = 857626
AND V.ctl_veicu = VPV.ctl_veicu
AND MV.ctl_model = V.ctl_model
AND MV.ctl_gener = GV.ctl_gener
AND TV.ctl_veicu_tip = GV.ctl_veicu_tip
AND MA.ctl_marca = MV.ctl_marca
AND P.cod_praca = V.cod_praca
AND UF.cod_unfed = P.cod_unfed
