SELECT * FROM MODELO_PLANO_VIAGEM
ORDER BY CTL_MODEL_PLV DESC

242


SELECT FC_VINCULADO_NOM_GUERR(CTL_DESTI), R.* FROM RELAC_PLVIA_DOCUMENTO R
WHERE CTL_PLVIA = 000857754
ORDER BY ORD_DESTI

INSERT INTO RELAC_PLVIA_DOCUMENTO VALUES (857754,14,'00000000181M','SUPERVISOR',SYSDATE,76697,5)

SELECT  FC_VINCULADO_NOM_GUERR(CTL_DESTI), D.* FROM DESTINATARIO_PLANO_VIAGEM D
WHERE CTL_PLVIA = 000857754
ORDER BY ORD_DESTI


SELECT * FROM MODELO_PLANO_VIAGEM
ORDER BY CTL_MODEL_PLV DESC



SELECT * FROM roteiro_motorista
WHERE CTL_PLVIA = 000857754

243

105623
272757
272755
76697


SELECT * FROM CIRCUITO

UPDATE PLANO_VIAGEM SET
CTL_CIRTO = 243
WHERE CTL_PLVIA = 000857754

SELECT ctl_parad FROM relac_prazo_evento WHERE tip_prazo_cli IN ( 1, 3 )  AND ctl_parad = 13
SELECT NVL(PV.ctl_plvia,'0'), NVL(MPV.des_model_plv,'') FROM modelo_plano_viagem MPV, plano_viagem PV WHERE MPV.ctl_model_plv = PV.ctl_cirto  AND PV.ctl_plvia = 857754
SELECT NVL(DPV.ord_desti, '0') FROM roteiro_motorista RM, destinatario_plano_viagem DPV,       (         SELECT NVL(MAX(num_seque),0) AS num_seque         FROM roteiro_motorista         WHERE ctl_plvia = 857754           AND sit_fase_rea IN ('R','T')      ) SEQ WHERE RM.ctl_plvia = 857754  AND RM.ctl_parad IN ( 10, 12 )  AND RM.sit_fase_rea IN ( 'S', 'M' )  AND RM.num_seque > SEQ.num_seque  AND DPV.ctl_plvia = RM.ctl_plvia  AND DPV.ctl_desti = RM.ctl_ptopd ORDER BY DPV.ord_desti
SELECT SUBSTR(NVL(SUBSTR(des_event, 1, 30),' '), 1, 30), NVL(FC_PLACA_CARRETA(ctl_plvia), ' '), NVL(TO_CHAR(dhr_event,'yyyymmdd'),' '), NVL(TO_CHAR(dhr_event,'hh24mi'),' '), NVL(num_latit, '0'), NVL(num_longi, '0') FROM monitora_terminal WHERE ctl_plvia = 857754
