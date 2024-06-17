SELECT PV.CTL_PLVIA, --PLACA DO VEICULO, PLACAS DAS CRARETAS,
TV.des_viage_tip, tov.des_opera_vie, RM.ord_desti,
FC_VINCULADO_DOCUMENTO(PV.CTL_REMET, 1) AS CNPJ_ORIGEM, 
FC_VINCULADO_NOM_GUERR(PV.CTL_REMET) AS ORIGEM, 
FC_VINCULADO_DOCUMENTO(PV.CTL_DESTI, 1) AS CNPJ_DESTINO, 
FC_VINCULADO_NOM_GUERR(PV.CTL_DESTI) AS DESTINO, 

(select TO_CHAR(dhr_previ_sis,'DD/MM/YYYY HH24:MI:SS') 
    from roteiro_motorista
    where ord_desti = 0 -- CONSTANTE
    and ctl_parad = 10 -- CONSTANTE
    and ctl_plvia = 1355594) AS PREV_INICIO,

(select TO_CHAR(dhr_efeti_rea,'DD/MM/YYYY HH24:MI:SS') 
    from roteiro_motorista
    where sit_fase_rea in ('R', 'T') -- CONSTANTE
    and ord_desti = 0 -- CONSTANTE
    and ctl_parad = 10 -- CONSTANTE
    and ctl_plvia = 1355594) AS REAL_INICIO,

(select TO_CHAR(dhr_previ_sis,'DD/MM/YYYY HH24:MI:SS') 
    from roteiro_motorista
    where ctl_parad = 12 -- CONSTANTE
    and ctl_plvia = 1355594
    and ctl_ptopd = (select max(ctl_desti) from destinatario_plano_viagem where ctl_plvia = 1355594)) AS PREVI_FIM,

(select TO_CHAR(dhr_efeti_rea,'DD/MM/YYYY HH24:MI:SS') 
    from roteiro_motorista
    where sit_fase_rea in ('R', 'T') -- CONSTANTE
    and ctl_parad = 12 -- CONSTANTE
    and ctl_plvia = 1355594
    and ctl_ptopd = (select max(ctl_desti) from destinatario_plano_viagem where ctl_plvia = 1355594)) AS REAL_FIM,
-- RGISTRO INICIO VIA, REGISTRO FIM VIA
PV.CTL_MODEL_PLV, dpv.sig_ordem_eve, 
FC_VINCULADO_DOCUMENTO(PV.ctl_trnsp, 1) AS CNPJ_TRANSPORTADORA, 
FC_VINCULADO_NOM_GUERR(PV.ctl_trnsp) AS TRANSPORTADORA, 
-- PROVEDOR TECNOLOGIA, ID TERMINAL, 
TO_CHAR(PV.dhr_posic_ult,'DD/MM/YYYY HH24:MI') AS DES_ULTIMA_POSICAO, 
PV.des_praca_ult AS EVENTO_ULTIMA_POSICAO,
-- LAT ULT POSIC, LONG ULT POSIC, TEMPO VIAGEM, STATUS IGNICAO,
-- DISTANCIA PERCORRER, % PERCORRIDO, 
-- TIPO MOTORISTA, CPF MOTORISTA, NOME MOTORISTA 
PV.obs_plvia, -- DISTANCIA PREVISTA KM, DOC PROPRIO CLIENTE
-- TENDENCIA CHEGADA DESTINO, TENDENCIA DO EVENTO??????
TO_CHAR(PV.dhr_inclu, 'DD/MM/YYYY HH24:MI') AS INCLUSAO, 
-- DISTANCIA PERCORRIDA KM
SPV1.DES_SITUA,
(select TO_CHAR(dhr_tende_chg,'DD/MM/YYYY HH24:MI:SS') 
    from roteiro_motorista
    where sit_fase_rea in ('R', 'T') -- CONSTANTE
    and ctl_parad = 12 -- CONSTANTE
    and ctl_plvia = 1355594
    and ctl_ptopd = (select max(ctl_desti) from destinatario_plano_viagem where ctl_plvia = 1355594)) AS TENDENCIA_FIM_VIAGEM,
 -- USUARIO REGISTRO IV, USUARIO REGISTRO FV
TP.SIG_PARAD || ' - ' || TP.DES_PARAD AS EVENTO, 
TO_CHAR(RM.DHR_PREVI_SIS, 'DD/MM/YYYY HH24:MI') AS PREVISAO_EVENTO,
TO_CHAR(RM.DHR_EFETI_REA, 'DD/MM/YYYY HH24:MI') AS RELA_EVENTO, 
-- REGISTRO VIA, NOME USUARIO REGISTRO EVENTO, 
FC_VINCULADO_NOM_GUERR(DPV.NUM_CONSI_MER) AS CONSIGNATARIO,
FC_VINCULADO_DOCUMENTO(DPV.NUM_CONSI_MER, 1) AS CNPJ_CONSIGNATARIO, 
FC_VINCULADO_ENDERECO_PRACA(PV.ctl_REMET, 1)    AS PRACA_ORIGEM,
FC_VINCULADO_ENDERECO_SIGLAUF(PV.ctl_REMET, 1)  AS ESTADO_ORIGEM,
FC_VINCULADO_ENDERECO_PAIS(PV.ctl_REMET, 1)     AS PAIS_ORIGEM,
FC_VINCULADO_ENDERECO_PRACA(PV.ctl_desti, 1)    AS PRACA_DESTINO,
FC_VINCULADO_ENDERECO_SIGLAUF(PV.ctl_desti, 1)  AS ESTADO_DESTINO,
FC_VINCULADO_ENDERECO_PAIS(PV.ctl_desti, 1)     AS PAIS_DESTINO,
SPV2.DES_SITUA, '' AS LIMITE_MAX_ENTREGA, '' AS DIA_SEMANA, '' AS PRAZO_ENTREGA_CONTRATUAL,
TR.DES_TIPO_RST --, TRANSPONDER VEICULO, TRANSPONDER CARRETA
FROM PLANO_VIAGEM PV, DESTINATARIO_PLANO_VIAGEM DPV, ROTEIRO_MOTORISTA RM, TTIPO_VIAGEM TV,
TTIPO_OPERACAO_VIAGEM TOV, SITUACAO_PLANO_VIAGEM SPV1, TIPO_PARADA TP, SITUACAO_PLANO_VIAGEM SPV2,
TIPO_RASTREAMENTO TR
WHERE PV.ctl_plvia = 1355594
AND PV.CTL_PLVIA = dpv.ctl_plvia
AND PV.ctl_plvia = rm.ctl_plvia
AND rm.ctl_ptopd = dpv.ctl_desti
AND RM.ord_desti = dpv.ord_desti
AND PV.tip_opera_vie = tov.tip_opera_vie
AND PV.tip_viage = tv.tip_viage(+)
AND PV.SIT_PLVIA = SPV1.SIT_PLVIA
AND PV.SIT_PLVIA = SPV2.SIT_PLVIA
AND RM.CTL_PARAD = TP.CTL_PARAD
AND PV.TIP_RASTR = TR.TIP_RASTR


