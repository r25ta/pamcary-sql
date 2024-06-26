
select TO_CHAR(DHR_EVENT,'DD/MM/YYYY HH24:MI:SS'), L.* from log_monitora_terminal L
where num_termn = 958714
and tip_event_ter <> 99
order by dhr_event desc

SELECT * FROM LOG_MONITORA_TERMINAL_DET
WHERE NUM_SEQUE_TER = 31211419

SELECT TO_CHAR(DHR_MANUT,'DD/MM/YYYY HH24:MI:SS'), V.* FROM VEICULO_PLANO_VIAGEM V
where num_MCT = 958714

SELECT * FROM DOC_VINCULADO
WHERE COD_DOCUM = '10250359847'

SELECT  M.* FROM MOTORISTA_PLANO_VIAGEM M
WHERE CTL_MOTOT = 283341
ORDER BY CTL_PLVIA DESC

911341 
911338
911003
911338

910983 -> 17/04/2006 11:54:19
910892 -> 17/04/2006 09:29:04

SELECT * FROM VEICULO
WHERE NUM_PLACA = ''

SELECT FC_VINCULADO_NOM_GUERR(CTL_PTOPD), to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss'), R.* FROM ROTEIRO_MOTORISTA R
WHERE CTL_PLVIA = 911337  
ORDER BY NUM_SEQUE


SELECT * FROM TIPO_PARADA 

SELECT * FROM LOG_MONITORA_TERMINAL
WHERE NUM_SEQUE_TER IN (31221906,31221623,31221621,31221466,31151594)



SELECT RPV.cod_parad_ref, RPV.ctl_parad
FROM REF_PARADA_VINCULADO RPV,  PROVTECN_RELVINCD PR, PROVEDOR_TECNOLOGIA PT
WHERE RPV.ctl_prove_vin = PR.ctl_prove_vin
AND PT.ctl_prove_tec = PR.ctl_prove_tec
AND PR.ctl_vincd = 264646
AND PR.tip_relac = 2
ORDER BY RPV.cod_parad_ref


SELECT * FROM ENDERECO_VINCULADO
WHERE CTL_VINCD = 78510

VALINHOS -> 225802 465958
PERUS -> 232510 464753


SELECT FC_DISTANCIA_PONTOS_INFOLOG('232513','464749','232510','464753') FROM DUAL

SELECT * FROM ROTEIRO_MOTORISTA  WHERE ctl_plvia = 911341
AND sit_fase_rea NOT IN ('R', 'T') AND ctl_parad IN ( 10, 12 )


select * from usuario_internet
where usr_name like 'PAMCARY.PAMCARY'





SELECT DISTINCT RV.ctl_vincd_rld, NVL(V.nom_guerr,' ') AS nom_guerr,  NVL(V.nom_vincd,' ') AS nom_vincd, NVL(DV.cod_docum,'000000000000000') AS cod_docum  FROM RELACIONAMENTO_VINCULADO RV, TIPO_RELACIONAMENTO TR, DOC_VINCULADO DV, VINCULADO V  WHERE DV.ctl_vincd = RV.ctl_vincd_rld  AND RV.ctl_vincd_rld = V.ctl_vincd  AND TR.tip_relac = 2 AND RV.ctl_vincd = 50720 AND DV.cod_docum = 066036146000103


SELECT distinct P.ctl_plvia, P.ctl_remet, P.ctl_motot, P.ctl_trnsp, P.ctl_desti
FROM PLANO_VIAGEM P ,
VEICULO_PLANO_VIAGEM V
WHERE V.num_mct = 958714 
AND P.ctl_plvia = V.ctl_plvia
AND P.sit_plvia <> 10
AND P.ctl_opera_tip = 20 ORDER BY ctl_plvia DESC 
