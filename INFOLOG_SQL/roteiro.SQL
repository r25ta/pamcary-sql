select R.ctl_rtmot, R.ctl_ptopd,  R.ctl_parad, fc_vinculado_nom_guerr(R.ctl_ptopd), D.cod_docum, to_char(R.dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss'),
       to_char(R.dhr_previ_sis,'dd/mm/yyyy hh24:mi:ss'), R.sit_fase_rea
from roteiro_motorista R, doc_vinculado D
where D.ctl_vincd = R.ctl_ptopd
and R.ctl_plvia = 806684
order by R.num_seque


SELECT PV.ctl_plvia, PV.sit_plvia, RM.ctl_rtmot,RM.ctl_parad,RM.ctl_ptopd,
       NVL(FC_VINCULADO_NOM_GUERR(PV.ctl_motot), ' ') AS nom_motot,
       NVL(FC_VINCULADO_NOM_GUERR(PV.ctl_trnsp), ' ') AS nom_trnsp,
       NVL(FC_PLACA_VEICULO(PV.ctl_plvia), ' ') AS placa_veiculo,
       NVL(FC_PLACA_CARRETA(PV.ctl_plvia), ' ') AS placa_carreta,
       NVL(TO_CHAR(pv.dhr_inclu,'DDMMYYYYHH24MISS'),' ') AS dhr_plvia_inc,
       NVL(TO_CHAR(pv.dhr_plvia_ter,'DDMMYYYYHH24MISS'),' ') AS dhr_plvia_ter,
       NVL(TO_CHAR(fc_dhr_fim_viagem(pv.ctl_plvia),'DDMMYYYYHH24MISS'), ' ' ) AS dhr_efeti_ter
       FROM ROTEIRO_MOTORISTA RM, PLANO_VIAGEM PV, DOC_VINCULADO DV WHERE PV.ctl_plvia = RM.ctl_plvia
       AND RM.ctl_ptopd = DV.ctl_vincd AND RM.ctl_parad = 12
       AND PV.sit_plvia <>  10
       AND DV.tip_docum = 1
       AND DV.cod_docum = '057543795000100' AND PV.num_pcard = '0251481024'
       ORDER BY TO_CHAR(pv.dhr_inclu,'yyyymmddhh24:mi:ss')

SELECT DPV.ctl_desti, DPV.ord_desti, NVL(DPV.num_janel_rec, '999' ) AS num_janel_rec,
TO_CHAR(DPV.dhr_plvia_ter,'DDMMYYYYHH24MISS') AS dhr_plvia_ter
FROM DESTINATARIO_PLANO_VIAGEM DPV, ROTEIRO_MOTORISTA RM, PLANO_VIAGEM PV
WHERE PV.ctl_plvia = RM.ctl_plvia  AND PV.ctl_plvia = DPV.ctl_plvia
AND DPV.ctl_desti = RM.ctl_ptopd
AND RM.sit_fase_rea NOT IN ('R','M')
AND RM.ctl_parad = 12
AND PV.ctl_plvia = 806046


select * from  plano_viagem
where ctl_plvia = 806684

select * from mct_macro
order by dhr_event desc
SELECT * FROM PLANO_VIAGEM
WHERE CTL_PLVIA = 806046


SELECT * FROM ROTA
WHERE CTL_ROTA = 1008

SELECT ctl_rtmot, ctl_ptopd,  ctl_parad, num_seque, NVL( TO_CHAR(dhr_previ_sis, 'DDMMYYYYHH24MISS'), ' ' ) AS dhr_previ_sis,  NVL( TO_CHAR(dhr_efeti_rea, 'DDMMYYYYHH24MISS'), ' ' ) AS dhr_efeti_rea,  sit_fase_rea, NVL( TO_CHAR(hor_rtvia_qtd, 'HH24MISS'), '000001') AS hor_rtvia_qtd FROM ROTEIRO_MOTORISTA  WHERE ctl_plvia = 806046 AND num_seque >= 7.2 AND ctl_parad <> 12  AND ctl_parad <> 10  AND ctl_parad NOT IN (11,17,18,20,23,24,26) ORDER BY num_seque


SELECT * FROM LOG_MONITORA_TERMINAL
WHERE CTL_PROVE_TEC IS NOT NULL



