 
/** cliente, num_viagem, prev_ch, real_ch, real_iv, real_fv, tendencia */
SELECT fc_vinculado_nom_guerr(ctl_ptopd) as cliente,
    DECODE (ctl_parad, 24, dhr_previ_sis, NULL) PREV_CH,
    DECODE (ctl_parad, 24, dhr_efeti_rea, NULL) REAL_CH,
    DECODE (ctl_parad, 10, dhr_efeti_rea, NULL) REAL_IV,
    DECODE (ctl_parad, 12, dhr_efeti_rea, NULL) REAL_FV,
    DECODE (ctl_parad, 10, dhr_tende_chg, NULL) TENDE_IV,
    DECODE (ctl_parad, 12, dhr_tende_chg, NULL) TENDE_FV 
FROM (
    select RM.ctl_ptopd, RM.ctl_parad, RM.dhr_previ_sis, RM.dhr_efeti_rea, RM.dhr_tende_chg
    FROM ROTEIRO_MOTORISTA RM, vinculado v
    WHERE RM.CTL_PLVIA = 1355554 
    and RM.ctl_parad in (10,12,24)
    and v.ctl_vincd = RM.ctl_PTOPD 
    and v.cod_ativi = 12
)

257816
362414
select fc_vinculado_nom_guerr(ctl_ptopd) as cliente,

    ( select to_char(dhr_previ_sis,'dd/mm/yyyy hh24:mi:ss')
     FROM ROTEIRO_MOTORISTA
     WHERE CTL_PLVIA = 1355554 
     and ctl_parad = 24 ) as prev_ch,
     


from roteiro_motorista 
WHERE CTL_PLVIA = 1355554



SELECT NVL(
   (SELECT nom_apeli_etd FROM REF_VINCULADO_CLIENTE 
    WHERE ctl_vincd = PCTL_VINCD_MESTRE 
    AND ctl_vincd_rld = PCTL_VINCD)
   , nom_guerr) as nom_guerr
 FROM VINCULADO
 WHERE ctl_vincd = 

SELECT * FROM PLANO_VIAGEM

NVL((SELECT CV.des_class_vie FROM PLANO_VIAGEM PV, CLASSIFICACAO_VIAGEM CV
WHERE PV.ctl_plvia = 1355554 
AND CV.ctl_class_vie(+) = PV.ctl_class_vie) ,'') AS CLASSIFICACAO 


SELECT FC_VINCULADO_NOM_GUERR(ctl_ptopd) AS CLIENTE, 
       NVL((SELECT spv.des_situa 
             FROM destinatario_plano_viagem dpv, situacao_plano_viagem spv
             WHERE spv.sit_plvia = dpv.sit_plvia
             AND dpv.ctl_plvia = 1355554 
             AND dpv.ctl_desti = ctl_ptopd),'') AS ETAPA,
        NVL((SELECT ctl_plvia FROM PLANO_VIAGEM WHERE ctl_plvia = 1355554),'') AS NUM_VIAGEM,
        NVL((SELECT TO_CHAR(dhr_posic_ult,'DD/MM/YYYY HH24:MI') FROM PLANO_VIAGEM WHERE ctl_plvia = 1355554),'') AS DHR_POSIC,
        NVL((SELECT des_praca_ult FROM PLANO_VIAGEM WHERE ctl_plvia = 1355554),'') AS DESC_POSIC,
        NVL((SELECT CV.des_class_vie 
             FROM PLANO_VIAGEM PV, CLASSIFICACAO_VIAGEM CV 
             WHERE PV.ctl_plvia = 1355554 
             AND CV.ctl_class_vie(+) = PV.ctl_class_vie) ,'') AS CLASSIFICACAO,
    MAX(DECODE (ctl_parad, 24, dhr_previ_sis, NULL)) PREV_CH,
    MAX(DECODE (ctl_parad, 24, dhr_efeti_rea, NULL)) REAL_CH,
    MAX(DECODE (ctl_parad, 10, dhr_efeti_rea, NULL)) REAL_IV,
    MAX(DECODE (ctl_parad, 12, dhr_efeti_rea, NULL)) REAL_FV,
    MAX(DECODE (ctl_parad, 10, dhr_tende_chg, NULL)) TENDE_IV,
    MAX(DECODE (ctl_parad, 12, dhr_tende_chg, NULL)) TENDE_FV 
FROM (
    SELECT RM.ctl_ptopd, RM.ctl_parad, RM.dhr_previ_sis, RM.dhr_efeti_rea, RM.dhr_tende_chg,
           NVL((SELECT spv.des_situa 
                FROM destinatario_plano_viagem dpv, situacao_plano_viagem spv
                WHERE spv.sit_plvia = dpv.sit_plvia
                    AND dpv.ctl_plvia = 1355554 
                    AND dpv.ctl_desti = RM.ctl_ptopd),'') AS ETAPA,
            NVL((SELECT ctl_plvia 
                 FROM PLANO_VIAGEM 
                 WHERE ctl_plvia = 1355554),'') AS NUM_VIAGEM,
            NVL((SELECT TO_CHAR(dhr_posic_ult,'DD/MM/YYYY HH24:MI') 
                 FROM PLANO_VIAGEM 
                 WHERE ctl_plvia = 1355554),'') AS DHR_POSIC,
            NVL((SELECT des_praca_ult 
                FROM PLANO_VIAGEM 
                WHERE ctl_plvia = 1355554),'') AS DESC_POSIC,
            NVL((SELECT CV.des_class_vie 
                 FROM PLANO_VIAGEM PV, CLASSIFICACAO_VIAGEM CV 
                 WHERE PV.ctl_plvia = 1355554 
                 AND CV.ctl_class_vie(+) = PV.ctl_class_vie) ,'') AS CLASSIFICACAO
    FROM ROTEIRO_MOTORISTA RM, vinculado v
    WHERE RM.CTL_PLVIA = 1355554 
        AND RM.ctl_parad IN (10,12,24)
        AND v.ctl_vincd = RM.ctl_PTOPD 
        AND v.cod_ativi = 12
) 
GROUP BY ctl_ptopd


select * from tipo_relacionamento
select * from relacionamento_vinculado



select * from atividade