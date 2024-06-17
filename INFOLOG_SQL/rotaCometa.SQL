
select * from plano_viagem
where ctl_opera_tip = 183
and sit_plvia = 1
order by ctl_plvia desc


  SELECT FC_vinculado_nom_guerr(ctl_ptopd) as local ,DES_DIFER_DAT, ctl_rtmot, ctl_ptopd,  ctl_parad, num_seque, NVL( TO_CHAR(dhr_previ_sis, 'DD/MM/YYYY HH24:MI:SS'), ' ' ) AS dhr_previ_sis,
  NVL( TO_CHAR(dhr_efeti_rea, 'DD/MM/YYYY HH24:MI:SS'), ' ' ) AS dhr_efeti_rea,
  NVL( TO_CHAR(dhr_previ_sis, 'DD/MM/YYYY HH24:MI:SS'), ' ' ) AS DHR_PREVI_MOT, sit_fase_rea, NVL( TO_CHAR(hor_rtvia_qtd, 'HH24MISS'), '000001') AS hor_rtvia_qtd FROM ROTEIRO_MOTORISTA
  WHERE ctl_plvia = 1270235
  ORDER BY NUM_SEQUE
  
  
  select to_char(dhr_posic_ult,'dd/mm/yyyy hh24:mi:ss'), des_praca_ult, p.* from plano_viagem p
  WHERE ctl_plvia = 1270235
  
  
  SELECT * FROM DESTINATARIO_PLANO_VIAGEM
WHERE ctl_plvia = 1270235
  
  1270235
1270203
1270202
1270181
1270144
1270088
1269981
1269974
1269747
1269737
1269346
1269272
1269184
1269014
1268988
1268968
1268966
1268592
1268588
1268323
1267675
1261175


/* EXTRAIR ARQUIVO COM ROTAS DA COMETA COM ROTA, SEQUENCIA, PONTO, TEMPOS E KM*/

SELECT R.CTL_ROTA AS COD_ROTA,
       R.DES_ROTA,
       RV.NUM_SEQUE_ORD AS SEQ,
       FC_VINCULADO_NOM_GUERR(RV.CTL_PTOPD) AS DES_PONTO,
       TO_CHAR(RV.HOR_RTVIA_QTD,'HH24:MI:SS') QTE_HORAS,
       RV.DIA_RTVIA_QTD AS QTE_DIA,
       RV.QTD_KLM_TRE AS KM_TRECHO,
       TO_CHAR(RV.HOR_RTVIA_ACU,'HH24:MI:SS') AS QTE_HORAS_ACUMULADO,
       RV.DIA_RTVIA_ACU AS QTE_DIAS_ACUMULADO ,
       RV.QTD_KLM_ACU AS KM_ACUMULADO
FROM ROTA R, ROTEIRO_VIAGEM RV
WHERE R.CTL_OPERA_TIP = 183
AND R.CTL_ROTA = RV.CTL_ROTA
ORDER BY R.CTL_ROTA

select * from roteiro_viagem
