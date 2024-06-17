SELECT ctl_plvia, ord_desti, 
        entidade_ORIGEM, 
        entidade_DESTINO, 
        ctl_ptopd , 
        nom_guerr, 
        des_ativi, 
        des_praca, 
        sig_unfed , 
        nom_pais,
        PREV_CH, 
        REAL_CH, 
        REAL_IV, 
        PREV_IV, 
        PREV_FV,
        REAL_FV,
    CASE WHEN PREV_CH IS NOT NULL AND REAL_CH IS NOT NULL AND (REAL_CH > PREV_CH) THEN 'No Show'
         WHEN PREV_CH IS NOT NULL AND REAL_CH IS NOT NULL AND (REAL_CH <= PREV_CH) THEN 'On Time'
	 WHEN PREV_CH IS NULL AND PREV_IV IS NOT NULL AND REAL_IV IS NOT NULL AND (REAL_IV > PREV_IV) THEN 'No Show'
	 WHEN PREV_CH IS NULL AND PREV_IV IS NOT NULL AND REAL_IV IS NOT NULL AND (REAL_IV <= PREV_IV) THEN 'On Time'
	 WHEN PREV_CH IS NULL AND PREV_FV IS NOT NULL AND REAL_FV IS NOT NULL AND (REAL_FV > PREV_FV) THEN 'No Show'
         WHEN PREV_CH IS NULL AND PREV_FV IS NOT NULL AND REAL_FV IS NOT NULL AND (REAL_FV <= PREV_FV) THEN 'On Time'
    ELSE 'N/A'
    END AS STA_ONTIME_NOSHOW,

    CASE WHEN PREV_CH IS NOT NULL AND PREV_IV IS NOT NULL AND ORD_DESTI = 0 THEN ROUND(( PREV_IV - PREV_CH )*24,2) 
         WHEN PREV_IV IS NOT NULL AND PREV_CH IS NOT NULL AND ORD_DESTI > 0 THEN ROUND(( PREV_IV - PREV_CH )*24,2) 
        WHEN PREV_FV IS NOT NULL AND PREV_CH IS NOT NULL AND ORD_DESTI > 0 THEN ROUND(( PREV_FV - PREV_CH )*24,2) 
    ELSE 0
    END AS TMP_PERM_PREVI,

    CASE WHEN REAL_CH IS NOT NULL AND REAL_IV IS NOT NULL AND ORD_DESTI = 0 THEN ROUND(( REAL_IV - REAL_CH )*24,2) 
         WHEN REAL_IV IS NOT NULL AND REAL_CH IS NOT NULL AND ORD_DESTI > 0 THEN ROUND(( REAL_IV - REAL_CH )*24,2) 
         WHEN REAL_FV IS NOT NULL AND REAL_CH IS NOT NULL AND ORD_DESTI > 0 THEN ROUND(( REAL_FV - REAL_CH )*24,2) 
    ELSE 0
    END AS TMP_PERM_REAL

FROM (

select  r.ctl_plvia, r.ord_desti, 
        decode(r.ord_desti,0,'ORIGEM', NULL) AS entidade_ORIGEM, 
        decode(r.ord_desti,0,NULL, 'DESTINO') AS entidade_DESTINO, 
        r.ctl_ptopd , 
        v.nom_guerr, 
        a.des_ativi, 
        p.des_praca, 
        uf.sig_unfed , 
        ps.nom_pais,
max(DECODE (r.ctl_parad, 24, r.dhr_previ_sis, NULL)) PREV_CH, 
max(DECODE (r.ctl_parad, 24, r.dhr_efeti_rea, NULL)) REAL_CH, 
max(DECODE (r.ctl_parad, 10, r.dhr_efeti_rea, NULL)) REAL_IV, 
max(DECODE (r.ctl_parad, 10, r.dhr_previ_sis, NULL)) PREV_IV, 
max(DECODE(r.ord_desti, 0 , TO_DATE(NULL),
    DECODE (r.ctl_parad, 12, r.dhr_previ_sis, NULL))) PREV_FV,
max(DECODE(r.ord_desti, 0 , TO_DATE(NULL), 
    DECODE (r.ctl_parad, 12, r.dhr_efeti_rea, NULL))) REAL_FV
   
from roteiro_motorista r,
endereco_vinculado ev, 
              praca p,
              unidade_federal uf,
              pais ps,
              atividade a, 
              vinculado v,
              plano_viagem p
WHERE ev.cod_praca = p.cod_praca
    and r.ctl_ptopd = ev.ctl_vincd
    and uf.cod_unfed = p.cod_unfed
    and ps.cod_pais = uf.cod_pais
    and r.ctl_ptopd = v.ctl_vincd
    and a.cod_ativi = v.cod_ativi
    and p.ctl_plvia = r.ctl_plvia
    and r.ctl_parad in (10,12,24)
group by r.ctl_plvia, r.ord_desti, r.ctl_ptopd,v.nom_guerr, a.des_ativi, p.des_praca, uf.sig_unfed , ps.nom_pais
)

SELECT  ((SYSDATE) - TO_DATE('16/06/2012 12:00:00', 'DD/MM/YYYY HH24:MI:SS'))*1440 FROM DUAL

SELECT  (TO_DATE('2008-06-25 15:30:00', 'YYYY-MM-DD HH24:MI:SS') - TO_DATE('2008-06-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS') )*1440,
ROUND((TO_DATE('2008-06-25 15:30:00', 'YYYY-MM-DD HH24:MI:SS') - TO_DATE('2008-06-25 15:00:00', 'YYYY-MM-DD HH24:MI:SS')) *24 ,2)
FROM DUAL

SELECT CTL_PLVIA, CTL_RTMOT, CTL_PTOPD, CTL_PARAD, SIT_FASE_REA, ORD_DESTI, TO_CHAR(DHR_PREVI_SIS,'DD/MM/YYYY HH24:MI:SS'),
TO_CHAR(DHR_EFETI_REA,'DD/MM/YYYY HH24:MI:SS') AS REAL FROM ROTEIRO_MOTORISTA
WHERE CTL_PLVIA = 1297400
AND CTL_PARAD IN (10,12,24)
ORDER BY ORD_DESTI, NUM_SEQUE
287904

SELECT * FROM DESTINATARIO_PLANO_VIAGEM
WHERE CTL_PLVIA = 860974

SELECT * FROM PLANO_VIAGEM
WHERE CTL_PLVIA = 860974


select  r.ctl_plvia, r.ord_desti, decode(r.ord_desti,0,'ORIGEM', 'DESTINO') AS tipo_entidade, r.ctl_ptopd , v.nom_guerr, a.des_ativi, p.des_praca, uf.sig_unfed , ps.nom_pais,
max(DECODE (r.ctl_parad, 24, r.dhr_previ_sis, NULL)) PREV_CH, 
max(DECODE (r.ctl_parad, 24, r.dhr_efeti_rea, NULL)) REAL_CH, 
max(DECODE (r.ctl_parad, 10, r.dhr_efeti_rea, NULL)) REAL_IV, 
max(DECODE (r.ctl_parad, 10, r.dhr_previ_sis, NULL)) PREV_IV, 
max(DECODE(r.ord_desti, 0 , TO_DATE(NULL),
    DECODE (r.ctl_parad, 12, r.dhr_previ_sis, NULL))) PREV_FV,
max(DECODE(r.ord_desti, 0 , TO_DATE(NULL), 
    DECODE (r.ctl_parad, 12, r.dhr_efeti_rea, NULL))) REAL_FV
from roteiro_motorista r,
endereco_vinculado ev, 
              praca p,
              unidade_federal uf,
              pais ps,
              atividade a, 
              vinculado v,
              plano_viagem p
WHERE ev.cod_praca = p.cod_praca
    and r.ctl_ptopd = ev.ctl_vincd
    and uf.cod_unfed = p.cod_unfed
    and ps.cod_pais = uf.cod_pais
    and r.ctl_ptopd = v.ctl_vincd
    and a.cod_ativi = v.cod_ativi
    and p.ctl_plvia = r.ctl_plvia
    and r.ctl_parad in (10,24)
    and r.ord_desti = 0
group by r.ctl_plvia, r.ord_desti, r.ctl_ptopd,v.nom_guerr, a.des_ativi, p.des_praca, uf.sig_unfed , ps.nom_pais