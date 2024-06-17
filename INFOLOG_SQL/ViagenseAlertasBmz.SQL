SELECT PV.ctl_plvia, fc_vinculado_nom_guerr(PV.ctl_remet) as nom_remet,
       fc_vinculado_nom_guerr(PV.ctl_desti) as nom_desti,
       fc_vinculado_nom_guerr(PV.ctl_trnsp) as nom_trnsp,
       fc_vinculado_nom_guerr(PV.ctl_motot) as nom_motot,   
       TO_CHAR(fc_dhr_inicio_viagem(PV.ctl_plvia),'DD/MM/YYYY HH24:MI:SS') AS dhr_inicio_viagem,
       TO_CHAR(fc_dhr_fim_viagem(PV.ctl_plvia),'DD/MM/YYYY HH24:MI:SS') as dhr_fim_viagem,
       TO_CHAR(PV.dhr_inclu,'dd/mm/yyyy hh24:mi:ss') AS dhr_inclu,
       fc_qtd_alerta(fc_id_veiculo(PV.ctl_plvia),fc_dhr_inicio_viagem(PV.ctl_plvia),fc_dhr_fim_viagem(PV.ctl_plvia)) as qtd_alerta
FROM PLANO_VIAGEM PV
WHERE PV.ctl_opera_tip = 21
AND PV.sit_plvia = 4
AND TO_CHAR(PV.dhr_inclu,'yyyymmdd') >= '20031001'
ORDER BY PV.dhr_inclu
