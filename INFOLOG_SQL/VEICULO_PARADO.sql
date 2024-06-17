SELECT DHR_EVENT, ROUND(TO_NUMBER(TO_DATE(SYSDATE,'DD/MM/YYYY HH24:MI') - TO_DATE(DHR_EVENT,'DD/MM/YYYY HH24:MI'))*24) AS OCIO from MONITORA_TERMINAL
WHERE TO_NUMBER(TO_DATE(SYSDATE,'DD/MM/YYYY HH24:MI') - TO_DATE(DHR_EVENT,'DD/MM/YYYY HH24:MI'))*24 <= 100
AND CTL_PLVIA IS NULL

WHERE ROUND(TO_NUMBER(TO_DATE(SYSDATE,'YYYYMMDDHH24MI') - TO_DATE(DHR_EVENT,'YYYYMMDDHH24MI'))*24)


SELECT * FROM MONITORA_TERMINAL
SELECT * FROM PROVEDOR_TECNOLOGIA

/* OCIO AGRUPADO POR TECNOLOGIA*/
SELECT COUNT(1) AS TOTAL , P.DES_PROVE_TEC
FROM MONITORA_TERMINAL M, PROVEDOR_TECNOLOGIA P, plano_viagem pv
WHERE P.CTL_PROVE_TEC = M.CTL_PROVE_TEC
and pv.ctl_plvia = m.ctl_plvia
and pv.sit_plvia = 10
AND TO_NUMBER(TO_DATE(SYSDATE,'DD/MM/YYYY HH24:MI') - TO_DATE(DHR_EVENT,'DD/MM/YYYY HH24:MI'))*24 >= 100
and M.ctl_plvia is not null
GROUP BY P.DES_PROVE_TEC, Pv.sit_plvia
ORDER BY TOTAL DESC

/* */


SELECT COUNT(1) AS TOTAL , P.DES_PROVE_TEC 
FROM MONITORA_TERMINAL M, PROVEDOR_TECNOLOGIA P
WHERE P.CTL_PROVE_TEC = M.CTL_PROVE_TEC
GROUP BY P.DES_PROVE_TEC 
ORDER BY TOTAL DESC


select * from plano_viagem
where ctl_opera_tip = 51

select count(1) from plano_viagem
where ctl_desti = 162784
and ctl_opera_tip = 51

/* ranking por origem*/
select count(ctl_remet) as total, ctl_remet, fc_vinculado_nom_guerr(ctl_remet) 
from plano_viagem p
where p.ctl_opera_tip = 51
group by ctl_remet,fc_vinculado_nom_guerr(ctl_remet)
order by total desc

/* ranking por destino*/
select count(ctl_desti) as total, ctl_desti, fc_vinculado_nom_guerr(ctl_desti) 
from plano_viagem p
where p.ctl_opera_tip = 51
group by ctl_desti,fc_vinculado_nom_guerr(ctl_desti)
order by total desc

/* ranking por transportadora*/
select count(ctl_trnsp) as total, ctl_trnsp, fc_vinculado_nom_guerr(ctl_trnsp) 
from plano_viagem p
where p.ctl_opera_tip = 51
group by ctl_trnsp,fc_vinculado_nom_guerr(ctl_trnsp)
order by total desc

select * from roteiro_motorista
select * from tipo_parada

/* eventos reais na origem por transp*/
select count(r.ctl_parad), t.des_parad
from roteiro_motorista r, plano_viagem p, tipo_parada t
where p.ctl_plvia = r.ctl_plvia
and t.ctl_parad = r.ctl_parad
and r.ord_desti = 0
and r.sit_fase_rea in ('R', 'T')
and p.ctl_opera_tip = 51
and p.ctl_trnsp = 321188
group by t.des_parad

/* eventos reais no destino por transp*/
select count(r.ctl_parad), t.des_parad
from roteiro_motorista r, plano_viagem p, tipo_parada t
where p.ctl_plvia = r.ctl_plvia
and t.ctl_parad = r.ctl_parad
and r.ord_desti > 0
and r.ctl_parad <> 13
and r.sit_fase_rea in ('R', 'T')
and p.ctl_opera_tip = 51
and p.ctl_trnsp = 321188
group by t.des_parad

select * from situacao_plano_viagem

/*rank situação viagem por transp*/
select fc_vinculado_nom_guerr(ctl_trnsp) as trnsp, s.des_situa, count(p.sit_plvia) as total
from plano_viagem p, situacao_plano_viagem s
where s.sit_plvia = p.sit_plvia
and p.ctl_opera_tip = 51
group by fc_vinculado_nom_guerr(ctl_trnsp),s.des_situa
order by fc_vinculado_nom_guerr(ctl_trnsp), to_number(total) desc


from plano_viagem
where ctl_opera_tip = 51
select count(p.sit_plvia), s.des_situa
        from plano_viagem p, situacao_plano_viagem s
        where s.sit_plvia = p.sit_plvia
        and p.ctl_opera_tip = 51
        --and p.ctl_trnsp = 321188
        group by s.des_situa


