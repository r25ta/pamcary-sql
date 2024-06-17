select * from tipo_operacao
select * from plano_viagem
select * from destinatario_plano_viagem
select * from roteiro_motorista
select * from tipo_parada

SELECT PV.ctl_plvia as Plano_Viagem , P.des_parad as Tipo_Parada, TP.des_opera_tip as Operacao,
       RM.num_seque as Ordem_Entrega, FC_VINCULADO_NOM_GUERR(RM.ctl_ptopd) AS ENTIDADE,
       TO_CHAR(RM.dhr_previ_sis,'DD/MM/YYYY HH24:MI:SS') AS DT_PREVISTA,
       TO_CHAR(RM.dhr_efeti_rea,'DD/MM/YYYY HH24:MI:SS') AS DT_REAL,
       TO_CHAR(PV.dhr_inclu,'DD/MM/YYYY HH24:MI:SS') AS DT_Inclusao       
FROM PLANO_VIAGEM PV, TIPO_OPERACAO TP, ROTEIRO_MOTORISTA RM, TIPO_PARADA P
WHERE TP.ctl_opera_tip = PV.ctl_opera_tip
AND PV.ctl_plvia = RM.ctl_plvia
AND P.ctl_parad = RM.ctl_parad
AND TO_CHAR(PV.dhr_inclu,'YYYYMMDD') BETWEEN '20060501' AND '20060510'
AND RM.ctl_parad IN (24,18,10,12)
AND PV.ctl_opera_tip = 11
ORDER BY PV.ctl_plvia, num_seque

select * from tipo_operacao


select * from roteiro_motorista
where ctl_plvia = 894994
order by num_seque
