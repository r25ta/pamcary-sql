
select * from plano_viagem
where ctl_plvia = 857351


select to_char(dhr_previ_sis,'dd/mm/yyyy hh24:mi:ss'), a.* from roteiro_motorista a
where ctl_plvia = 857354
ORDER BY NUM_SEQUE


SELECT distinct DPV.ctl_desti, DPV.ord_desti, NVL(DPV.num_janel_rec, '999' ) AS num_janel_rec,
TO_CHAR(DPV.dhr_plvia_ter,'YYYYMMDD HH24MISS') AS dhr_plvia_ter,
FC_VINCULADO_NOM_GUERR(DPV.ctl_desti) AS nom_desti, DPV.num_consi_mer,
FC_VINCULADO_NOM_GUERR(DPV.num_consi_mer) AS NOM_CONSI_MER, DPV.sit_plvia, sig_ordem_eve
FROM DESTINATARIO_PLANO_VIAGEM DPV
WHERE DPV.ctl_plvia = 857351
ORDER BY ord_desti




update plano_viagem set
sit_plvia = 0
where ctl_plvia = 857354

update destinatario_plano_viagem set
sit_plvia = 1
where ctl_plvia = 857354

update roteiro_motorista set
sta_telef = null,
sit_fase_rea = 'S',
dhr_efeti_rea = null
where ctl_rtmot = 4117692


select * from endereco_vinculado
where ctl_vincd in (162784,269512, 108762)


SELECT * FROM ROTEIRO_MOTORISTA  WHERE ctl_plvia = 857354 AND ctl_ptopd = 162784 AND dhr_previ_sis = TO_DATE('20051024090000','YYYYMMDDHH24MISS')
