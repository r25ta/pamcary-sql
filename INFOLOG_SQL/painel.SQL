select * from base_coletora
select * from circuito


SELECT cod_parad_ref, ctl_parad FROM REF_PARADA_VINCULADO
WHERE tip_relac = 2
AND ctl_vincd = 264646
ORDER BY cod_parad_ref

select * from ref_parada_vinculado

select * from tipo_parada

select * from provtecn_relvincd

select * from provedor_tecnologia

SELECT RPV.cod_parad_ref, RPV.ctl_parad 
FROM REF_PARADA_VINCULADO RPV,  PROVTECN_RELVINCD PR, PROVEDOR_TECNOLOGIA PT
WHERE RPV.ctl_prove_vin = PR.ctl_prove_vin
AND PT.ctl_prove_tec = PR.ctl_prove_tec
AND PR.ctl_vincd = 264646

AND PR.tip_relac = 2

ORDER BY RPV.cod_parad_ref
AND PR.ctl_vincd_rld = 
AND PR.ctl_prove_tec = 1

SELECT DISTINCT NVL( num_mct,'0' ) AS num_mct FROM VEICULO_PLANO_VIAGEM

SELECT COUNT(1) FROM LOG_MONITORA_TERMINAL
WHERE CTL_PLVIA = 
AND TIP_EVENT_TER = 

SELECT * FROM plano_viagem
WHERE ctl_plvia = 857633
and num_termn = 1111111

select * from veiculo_plano_viagem


select * from vinculado
where ctl_vincd = 107206


select * from comunicacao_vinculado
insert into comunicacao_vinculado values (107206,10,1,38891154,'SUPERVISOR',SYSDATE)




SELECT P.ctl_plvia, P.tip_rastr,  C.sig_cirto,
FC_VINCULADO_NOM_GUERR(P.ctl_motot) AS nom_motot, NVL(P.num_pcard,' ') AS num_pcard,
NVL(TO_CHAR(P.dhr_posic_ult,'DD/MM/YYYY HH24:MI:SS'),' ') AS dhr_posic_ult,  NVL(P.des_praca_ult,' ') AS des_praca_ult,
ctl_remet, NVL(CV.des_comun_vin,' ') AS des_comun_vin
FROM PLANO_VIAGEM P, CIRCUITO C, COMUNICACAO_VINCULADO CV
WHERE P.ctl_cirto = C.ctl_cirto  AND CV.ctl_vincd = P.ctl_motot AND CV.tip_comun = 10 AND P.sit_plvia IN (0,1)
AND P.ctl_opera_tip IN(20) ORDER BY P.ctl_plvia 
