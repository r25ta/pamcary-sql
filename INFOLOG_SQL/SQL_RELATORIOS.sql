--LISTA DE RELATÓRIOS A SEREM ENVIADOS POR E-MAIL.
SELECT to_char(sr.dhr_solic, 'dd/mm/yyyy hh24:mi:ss'), 
to_char(sr.dhr_alter, 'dd/mm/yyyy hh24:mi:ss'), 
to_char(sr.dhr_inici, 'dd/mm/yyyy hh24:mi:ss'), 
to_char(sr.dhr_fim, 'dd/mm/yyyy hh24:mi:ss'),
sr.ctl_regis, sr.sit_solic_rel, sr.num_seque_frm, sr.des_email, 
sr.cod_user, t.des_opera_tip, sr.dhr_inici, sr.dhr_fim , sr.*  
FROM solicitacao_relatorio sr, formato_relatorio_infolog fr, tipo_operacao t
WHERE sr.sit_solic_rel = 1
--1 = Relatórios Pendentes a entrega
--2 = Relatórios Já entregues
AND sr.num_seque_frm = fr.num_seque_frm
and sr.ctl_vincd_emb = t.ctl_vincd_emb
order by dhr_solic desc


--RELATÓRIO DE POSIÇÕES POR OPERAÇÃO E POR PERÍODO.
select h.ctl_plvia, to_char(pv.dhr_inclu,'dd/mm/yyyy hh24:mi'), h.num_placa, 
fc_vinculado_nom_guerr(pv.ctl_trnsp) as transportadora,
fc_vinculado_nom_guerr(mpv.ctl_motot) as motorista,
fc_vinculado_nom_guerr(pv.ctl_remet) as origem,
fc_vinculado_nom_guerr(pv.ctl_desti) as destino,
to_char(h.dhr_event,'dd/mm/yyyy hh24:mi'), h.tip_event_ter, h.des_event, h.num_latit, h.num_longi
from monitora_plano_viagem h, plano_viagem pv, motorista_plano_viagem mpv, veiculo v, veiculo_plano_viagem vp
where h.ctl_plvia in (select ctl_plvia FROM plano_viagem
where dhr_inclu between  TO_DATE('21/06/2013','DD/MM/YYYY') AND TO_DATE('26/06/2013','DD/MM/YYYY')
and ctl_opera_tip = 291)
and h.ctl_plvia = pv.ctl_plvia
and mpv.ctl_plvia = pv.ctl_plvia
and mpv.ord_motot = 1
and pv.ctl_plvia = vp.ctl_plvia
and vp.ctl_veicu = v.ctl_veicu
and h.num_placa = v.num_placa
order by h.dhr_event, h.ctl_plvia desc


--RELATÓRIOS DE FATURAMENTO. GERALMENTE PEDIDOS VIA CHAMADO DA SRTA.GISELE
--V_PLANO_VIAGEM_DIA_ANTERIOR
  select distinct o.ctl_opera_tip 
     , o.des_opera_tip
     , dv.cod_docum
     , fc_vinculado_nom_guerr(o.ctl_vincd_emb) nom_guerr
     , pv.ctl_plvia
     , fc_vinculado_nom_guerr(pv.ctl_remet) origem
     , to_char(pv.dhr_inclu,'dd/mm/yyyy hh24:mi') dhr_inclu
     , fc_placa_veiculo(pv.ctl_plvia) num_placa
     , DECODE(d.ctl_prove_tec, 1, 'AUTOTRAC'
                             , 2, 'CONTROLSAT'
                             , 4, 'OMNILINK'
                             , 5, 'JABURSAT'
                             , 7, 'RODOSIS'
                             , 9, 'OUTROS'
                             , 13, 'CONTROL LOC'
                             , 14, 'TRANSPONDER'
                             , 15, 'SEM RASTREAMENTO'
                             , 17, 'SASCAR'
                             , 21, 'CIELO'
                             , 22, 'SIGHRA'
                             , 23, 'TRACKME'
                             , 24, 'CERTASAT'
                             , 25, 'SEGMINAS'
                             , 26, 'STI'
                             , 27, '3TSYSTEMS'
                             , 28, 'LINK-MONITORAMENTO'
                             , 29, 'PROTECTSAT'
                             , 30, 'OMNILOC') AS tecnologia
 from  plano_viagem              pv
     , tipo_operacao             o
     , doc_vinculado             dv
     , relac_veiculo_dispo_plano r
     , dispositivo               d
     , veiculo                   v
     , modelo_veiculo            mv
     , genero_veiculo            gv
     , tipo_veiculo              tp
where pv.dhr_inclu between TO_DATE('01/05/2013','DD/MM/YYYY') AND TO_DATE('01/06/2013','DD/MM/YYYY') 
  and pv.ctl_opera_tip = o.ctl_opera_tip
  and dv.ctl_vincd     = o.ctl_vincd_emb
  and pv.ctl_plvia     = r.ctl_plvia(+)
  and r.ctl_dispo_rst  = d.ctl_dispo_rst(+)
  and r.ctl_veicu      = v.ctl_veicu(+)
  and v.ctl_model      = mv.ctl_model(+)
  and mv.ctl_gener     = gv.ctl_gener(+)
  and gv.ctl_veicu_tip = tp.ctl_veicu_tip(+)
  and (tp.ctl_veicu_tip is null or tp.ctl_veicu_tip in (2,3,5,6,7))
  and ((pv.tip_rastr in (1,2) and (d.ctl_prove_tec is null or d.ctl_prove_tec <> 14)) or (pv.tip_rastr in (3,4)))
  order by pv.ctl_plvia
  
--V_PLANO_VIAGEM_CANCELADO_MES
select p.ctl_plvia,
       fc_vinculado_nom_guerr(p.ctl_remet) origem,
       to_char(p.dhr_manut, 'dd/mm/yyyy hh24:mi') dhr_manut
  from plano_viagem  p
 where p.dhr_inclu between TO_DATE('01/05/2013','DD/MM/YYYY') AND TO_DATE('01/06/2013','DD/MM/YYYY')
       /* Foi colocado sysdate-1 devido o usuário retirar o relatório diarimente
          e no dia primeiro de cada mês deverá considerar o mês anterior */
   and p.sit_plvia     = 10 --Exclusao plano viagem
 order by p.ctl_plvia


 
--PEDIDOS DE PLANOS DE VIAGEM E SEUS EVENTOS, ESTILO REPORT, 
--PARA PLANOS QUE JÁ ESTÃO NO HISTÓRICO (NÃO SÃO MAIS ENXERGADOS NO INFOLOG)
SELECT distinct
PV.CTL_PLVIA AS NUMERO_DO_PLANO,
rm.ord_desti,
rm.num_seque,
TO_CHAR(PV.DHR_INCLU,'DD/MM/YYYY HH24:MI') AS DHR_INCLU,
TOV.DES_OPERA_VIE AS TIPO_OPERACAO_VIAGEM,
DFC.COD_DOCUM_FIS AS DOC_PROPRIO_CLIENTE,
TP.SIG_PARAD AS EVENTO,
TO_CHAR(RM.DHR_PREVI_SIS,'DD/MM/YYYY HH24:MI') AS DATA_PREVISAO_EVENTO,
TO_CHAR(RM.DHR_EFETI_REA,'DD/MM/YYYY HH24:MI') AS DATA_EVENTO,
FC_H_PLACA_VEICULO(PV.CTL_PLVIA) AS PLACA_VEICULO,
FC_H_PLACA_CARRETA(PV.CTL_PLVIA) AS PLACA_CARRETA,
RM.COD_USER AS USUARIO,
RM.STA_REGIS_AUT AS REGISTRO,
DECODE (PV.TIP_RASTR, 1, 'SATELITE', 3, 'TRANSPONDER', 4, 'TELEFONICO') AS TIP_RASTR,
DECODE(D.ctl_prove_tec, 1, 'AUTOTRAC'
                             , 2, 'CONTROLSAT'
                             , 4, 'OMNILINK'
                             , 5, 'JABURSAT'
                             , 7, 'RODOSIS'
                             , 9, 'OUTROS'
                             , 13, 'CONTROL LOC'
                             , 14, 'TRANSPONDER'
                             , 15, 'SEM RASTREADOR'
                             , 17, 'SASCAR'
                             , 21, 'CIELO'
                             , 22, 'SIGHRA'
                             , 23, 'TRACKME'
                             , 24, 'CERTASAT'
                             , 25, 'SEGMINAS'
                             , 26, 'STI'
                             , 27, '3TSYSTEMS'
                             , 28, 'LINK-MONITORAMENTO'
                             , 29, 'PROTECTSAT'
                             , 30, 'OMNILOC') AS PROVEDOR_TECNOLOGIA,
D.COD_DISPO_RST AS ID_TERMINAL,
NVL(FC_VINCULADO_DOCUMENTO(PV.CTL_TRNSP, 1), FC_VINCULADO_DOCUMENTO(PV.CTL_TRNSP, 2)) AS DOCUMENTO_TRANSP,
FC_VINCULADO_NOM_GUERR(PV.CTL_TRNSP) AS TRANSP,
NVL(FC_VINCULADO_DOCUMENTO(PV.CTL_REMET, 1), FC_VINCULADO_DOCUMENTO(PV.CTL_REMET, 2)) AS DOCUMENTO_ORIGEM,
FC_VINCULADO_NOM_GUERR(PV.CTL_REMET) AS ORIGEM,
FC_VINCULADO_ENDERECO_PAIS(PV.CTL_REMET,1) AS PAIS_ORIGEM,
FC_VINCULADO_ENDERECO_SIGLAUF(PV.CTL_REMET,1) AS UF_ORIGEM,
FC_VINCULADO_ENDERECO_PRACA(PV.CTL_REMET,1) AS PRACA_ORIGEM,
TM.DES_MOTOT_TIP AS TIPO_MOTORISTA,
NVL(FC_VINCULADO_DOCUMENTO(MTPV.CTL_MOTOT, 1), FC_VINCULADO_DOCUMENTO(MTPV.CTL_MOTOT, 2)) AS DOCUMENTO_MOTORISTA,
FC_VINCULADO_NOM_GUERR(MTPV.CTL_MOTOT) AS NOME_MOTORISTA,
NVL(FC_VINCULADO_DOCUMENTO(RM.CTL_PTOPD, 1), FC_VINCULADO_DOCUMENTO(RM.CTL_PTOPD, 2)) AS DOCUMENTO_DESTINO,
FC_VINCULADO_NOM_GUERR(RM.CTL_PTOPD) AS DESTINO,
SPV.DES_SITUA AS SITUACAO_DESTINO,
FC_VINCULADO_ENDERECO_PAIS(RM.CTL_PTOPD,1) AS PAIS_DESTINO,
FC_VINCULADO_ENDERECO_SIGLAUF(RM.CTL_PTOPD,1) AS UF_DESTINO,
FC_VINCULADO_ENDERECO_PRACA(RM.CTL_PTOPD,1) AS PRACA_DESTINO,
FC_VINCULADO_NOM_GUERR(RM.CTL_PTOPD) AS CONSIGNATARIO,
NVL(FC_VINCULADO_DOCUMENTO(RM.CTL_PTOPD, 1), FC_VINCULADO_DOCUMENTO(RM.CTL_PTOPD, 2)) AS DOCUMENTO_CONSIGNATARIO
FROM HIST_PLANO_VIAGEM PV, 
TIPO_VIAGEM TV, 
TIPO_OPERACAO_VIAGEM TOV, 
HIST_RELAC_PLVIA_DOCUM RPD, 
DOCUMENTO_FISCAL_CLIENTE DFC, 
HIST_ROTEIRO_MOTORISTA RM, 
TIPO_PARADA TP,
SITUACAO_PLANO_VIAGEM SPV, 
HIST_MOTORISTA_PLANO_VIAGEM MTPV, 
TIPO_MOTORISTA TM,
EXP_RELAC_VEICULO_DISPO_PLANO r,
dispositivo               d,
veiculo                   v,
modelo_veiculo            mv,
genero_veiculo            gv,
tipo_veiculo              tp
WHERE PV.CTL_PLVIA IN (3158416, 3176520)
AND PV.TIP_VIAGE = TV.TIP_VIAGE(+)
AND PV.TIP_OPERA_VIE = TOV.TIP_OPERA_VIE(+)
AND RPD.CTL_PLVIA = PV.CTL_PLVIA
AND DFC.TIP_DOCUM_FIS = 7 
AND RPD.ORD_DESTI = 0
AND RPD.CTL_DOCUM_CLI = DFC.CTL_DOCUM_CLI
AND RM.CTL_PLVIA = PV.CTL_PLVIA
AND RM.CTL_PARAD = TP.CTL_PARAD
AND PV.SIT_PLVIA = SPV.SIT_PLVIA(+)
AND MTPV.TIP_MOTOT = TM.TIP_MOTOT
AND MTPV.ctl_plvia(+) = PV.ctl_plvia 
AND (MTPV.ord_motot is null OR MTPV.ord_motot = 1)
and pv.ctl_plvia = r.ctl_plvia(+)
and r.ctl_dispo_rst = d.ctl_dispo_rst(+)
and r.ctl_veicu = v.ctl_veicu(+)
and v.ctl_model = mv.ctl_model(+)
and mv.ctl_gener = gv.ctl_gener(+)
and gv.ctl_veicu_tip = tp.ctl_veicu_tip(+)
and (tp.ctl_veicu_tip is null or tp.ctl_veicu_tip in (2,3,5,6,7))
and ((pv.tip_rastr in (1,2) and (d.ctl_prove_tec is null or d.ctl_prove_tec <> 14)) or (pv.tip_rastr in (3,4)))
ORDER BY PV.CTL_PLVIA, RM.NUM_SEQUE


--GERENCIAMENTO KRONA. CONSULTA DE PLANOS DE VIAGEM. (PC_GERENCIAMENTO_RISCOS_KRONA)
SELECT T.DES_OPERA_TIP AS OPERACAO, 
         PV.CTL_PLVIA AS NUMERO_VIAGEM, 
         NVL(FC_VINCULADO_NOM_GUERR(MPV.CTL_MOTOT),'') AS MOTORISTA_NOME, 
         NVL(FC_VINCULADO_DOCUMENTO(MPV.CTL_MOTOT,2),'') AS MOTORISTA_DOCUMENTO, 
         '' AS MOTORISTA_RG, 
         NVL(PV.NUM_PCARD,'') AS MOTORISTA_NUMERO_PAMCARD, 
         '' AS MOTORISTA_DATA_NASCIMENTO, 
         '' AS MOTORISTA_ESTADO_CIVIL, 
         '' AS MOTORISTA_CNH_NUMERO, 
         '' AS MOTORISTA_CNH_CATEGORIA, 
         '' AS MOTORISTA_CNH_VENCIMENTO, 
         '' AS END_RUA, 
         '' AS END_NUMERO, 
         '' AS END_COMPLEMENTO, 
         '' AS END_BAIRRO, 
         '' AS END_CIDADE, 
         '' AS END_UF, 
         '' AS END_PAIS, 
         '' AS END_CEP, 
         '' AS TELEFONE_FIXO, 
         NVL(CV.DES_COMUN_VIN,'') AS TELEFONE_CELULAR, 
         '' AS TELEFONE_RECADO, 
         '' AS NEXTEL, 
         '' AS VINCULO, 
         NVL(V.NUM_PLACA,'') AS VEICULO_PLACA, 
         NVL(V.NUM_RENAV,'0') AS VEICULO_RENAVAM, 
         NVL(MRV.DES_MARCA,'') AS VEICULO_MARCA, 
         NVL(MV.DES_MODEL,'') AS VEICULO_MODELO, 
         NVL(V.DES_VEICU_COR,'') AS VEICULO_COR, 
         NVL(V.ANO_VEICU,'') AS VEICULO_ANO, 
         NVL(FC_VINCULADO_NOM_GUERR(V.CTL_TRNSP),'') AS VEICULO_VINCULO, 
         NVL(V.QTD_EIXO,'0') AS VEICULO_NUMERO_EIXOS, 
         NVL(DECODE(DV.TIP_DOCUM, 1, 'CNPJ', 2, 'CPF'),'0') AS VEICULO_TIPO_DOC_PROPRIETARIO, 
         NVL(DV.COD_DOCUM,'') AS VEICULO_NUM_DOC_PROPRIETARIO, 
         NVL(VEV.DES_ENDER,'') AS END_VEICU_RUA, 
         NVL(VEV.DES_NUMER_END,'') AS END_VEICU_NUMERO, 
         NVL(VEV.DES_COMPL_END,'') AS END_VEICU_COMPLEMENTO, 
         NVL(VEV.DES_BAIRR_END,'') AS END_VEICU_BAIRRO, 
         NVL(FC_VINCULADO_ENDERECO_PRACA(VEV.CTL_VINCD,1),'') AS END_VEICU_CIDADE, 
         NVL(FC_VINCULADO_ENDERECO_SIGLAUF(VEV.CTL_VINCD,1),'') AS END_VEICU_UF, 
         NVL(FC_VINCULADO_ENDERECO_PAIS(VEV.CTL_VINCD,1),'') AS END_VEICU_PAIS, 
         NVL(VPR.NUM_CEP,'00000000') AS END_VEICU_CEP, 
         '' AS NUMERO_FROTA, 
         NVL(TV.DES_VEICU_TIP,'') AS TIPO, 
         CASE 
            WHEN TV.DES_VEICU_TIP <> 'CARRETA' THEN
              NVL(PT.DES_PROVE_TEC,'TELEFONE') 
            ELSE 
              NULL
         END AS TECNOLOGIA, 
         NVL(D.COD_DISPO_RST,'') AS ID_RASTREADOR, 
         '' AS COMUNICACAO, 
         '' AS TECNOLOGIA_SEC, 
         '' AS ID_RASTREADOR_SEC, 
         '' AS COMUNICACAO_SEC, 
         NVL(TDV.COD_DOCUM,'') AS TRANSP_CNPJ, 
         NVL(TVV.NOM_VINCD,'') AS TRANSP_RAZAO_SOCIAL, 
         NVL(FC_VINCULADO_NOM_GUERR(PV.CTL_TRNSP),'') AS TRANSP_NOME_FANTASIA, 
         '' AS TRANSP_UNIDADE, 
         NVL(TEV.DES_ENDER,'') AS END_TRNSP_RUA, 
         NVL(TEV.DES_NUMER_END,'') AS END_TRNSP_NUMERO, 
         NVL(TEV.DES_COMPL_END,'') AS END_TRNSP_COMPLEMENTO, 
         NVL(TEV.DES_BAIRR_END,'') AS END_TRNSP_BAIRRO, 
         NVL(FC_VINCULADO_ENDERECO_PRACA(TEV.CTL_VINCD,1),'') AS END_TRNSP_CIDADE, 
         NVL(FC_VINCULADO_ENDERECO_SIGLAUF(TEV.CTL_VINCD,1),'') AS END_TRNSP_UF, 
         NVL(FC_VINCULADO_ENDERECO_PAIS(TEV.CTL_VINCD,1),'') AS END_TRNSP_PAIS, 
         NVL(TPR.NUM_CEP,'00000000') AS END_TRNSP_CEP, 
         NVL(TEV.NUM_LATIT,'0') AS TRNSP_LATITUDE, 
         NVL(TEV.NUM_LONGI,'0') AS TRNSP_LONGITUDE, 
         '' AS TRNSP_TELEFONE, 
         '' AS TRNSP_EMAIL, 
         '' AS TRNSP_RESPONSAVEL, 
         '' AS TRNSP_CARGO, 
         '' AS TRNSP_TEL_FIXO, 
         '' AS TRNSP_TEL_CELULAR, 
         '' AS TRNSP_EMAIL_RESP, 
         NVL(DECODE(ODV.TIP_DOCUM, 1, 'CNPJ', 2, 'CPF'),'0') AS ORIGEM_TIPO_DOCUMENTO, 
         NVL(ODV.COD_DOCUM,'') AS ORIGEM_NUM_DOCUMENTO, 
         NVL(OVV.NOM_VINCD,'') AS ORIGEM_RAZAO_SOCIAL, 
         NVL(FC_VINCULADO_NOM_GUERR(PV.CTL_REMET),'') AS ORIGEM_NOME_FANTASIA, 
         '' AS ORIGEM_UNIDADE, 
         NVL(OEV.DES_ENDER,'') AS END_ORIGEM_RUA, 
         NVL(OEV.DES_NUMER_END,'') AS END_ORIGEM_NUMERO, 
         NVL(OEV.DES_COMPL_END,'') AS END_ORIGEM_COMPLEMENTO, 
         NVL(OEV.DES_BAIRR_END,'') AS END_ORIGEM_BAIRRO, 
         NVL(FC_VINCULADO_ENDERECO_PRACA(OEV.CTL_VINCD,1),'') AS END_ORIGEM_CIDADE, 
         NVL(FC_VINCULADO_ENDERECO_SIGLAUF(OEV.CTL_VINCD,1),'') AS END_ORIGEM_UF, 
         NVL(FC_VINCULADO_ENDERECO_PAIS(OEV.CTL_VINCD,1),'') AS END_ORIGEM_PAIS, 
         NVL(OPR.NUM_CEP,'00000000') AS END_ORIGEM_CEP, 
         NVL(OEV.NUM_LATIT,'0') AS ORIGEM_LATITUDE, 
         NVL(OEV.NUM_LONGI,'0') AS ORIGEM_LONGITUDE, 
         '' AS ORIGEM_TELEFONE, 
         '' AS ORIGEM_EMAIL, 
         '' AS ORIGEM_RESPONSAVEL, 
         '' AS ORIGEM_CARGO, 
         '' AS ORIGEM_TEL_FIXO, 
         '' AS ORIGEM_TEL_CELULAR, 
         '' AS ORIGEM_EMAIL_RESP, 
         NVL(DECODE(DDV.TIP_DOCUM, 1, 'CNPJ', 2, 'CPF'),'0') AS DESTINO_TIPO_DOCUMENTO, 
         NVL(DDV.COD_DOCUM,'') AS DESTINO_NUM_DOCUMENTO, 
         TO_CHAR(DPV.DHR_PLVIA_TER,'DD/MM/YYYY') AS DESTINO_PREVISAO_DATA, 
         TO_CHAR(DPV.DHR_PLVIA_TER,'HH24:MI') AS DESTINO_PREVISAO_HORA, 
         NVL(DFC.COD_DOCUM_FIS, '') AS DESTINO_NUMERO_NOTA, 
         NVL(DVV.NOM_VINCD,'') AS DESTINO_RAZAO_SOCIAL, 
         NVL(FC_VINCULADO_NOM_GUERR(DPV.CTL_DESTI),'') AS DESTINO_NOME_FANTASIA, 
         '' AS DESTINO_UNIDADE, 
         NVL(DEV.DES_ENDER,'') AS END_DESTINO_RUA, 
         NVL(DEV.DES_NUMER_END,'') AS END_DESTINO_NUMERO, 
         NVL(DEV.DES_COMPL_END,'') AS END_DESTINO_COMPLEMENTO, 
         NVL(DEV.DES_BAIRR_END,'') AS END_DESTINO_BAIRRO, 
         NVL(FC_VINCULADO_ENDERECO_PRACA(DEV.CTL_VINCD,1),'') AS END_DESTINO_CIDADE, 
         NVL(FC_VINCULADO_ENDERECO_SIGLAUF(DEV.CTL_VINCD,1),'') AS END_DESTINO_UF, 
         NVL(FC_VINCULADO_ENDERECO_PAIS(DEV.CTL_VINCD,1),'') AS END_DESTINO_PAIS, 
         NVL(DPR.NUM_CEP,'00000000') AS END_DESTINO_CEP, 
         NVL(DEV.NUM_LATIT,'0') AS DESTINO_LATITUDE, 
         NVL(DEV.NUM_LONGI,'0') AS DESTINO_LONGITUDE, 
         '' AS DESTINO_TELEFONE, 
         '' AS DESTINO_EMAIL, 
         '' AS DESTINO_RESPONSAVEL, 
         '' AS DESTINO_CARGO, 
         '' AS DESTINO_TEL_FIXO, 
         '' AS DESTINO_TEL_CELULAR, 
         '' AS DESTINO_EMAIL_RESP, 
         NVL(ODV.COD_DOCUM,'') AS DESTINO_REMET_CNPJ, 
         NVL(FC_VINCULADO_NOM_GUERR(PV.CTL_REMET),'') AS DESTINO_REMET_RAZAO_SOCIAL, 
         NVL(DPV.SIG_ORDEM_EVE,'') AS DESTINO_JANELA_OPERACIONAL, 
         '' AS OPERAC_VIAGEM_CLIENTE, 
         '' AS FAIXA_TERMPERATURA, 
         NVL(PV.QTD_TOTAL_CGA,'0') AS PESO_TOTAL, 
         NVL(TOV.DES_OPERA_VIE,'') AS TIPO_OPERACAO, 
         NVL(MMPV.DES_MODEL_PLV,'') AS NOME_IMG, 
         NVL(PV.OBS_PLVIA,'') AS OBSERVACAO, 
         '' AS TIPO_CARGA, 
         '' AS DESCRICAO_CARGA, 
         '' AS PERCURSO, 
         NVL(PV.VLR_TOTAL_EMB,'0') AS VALOR, 
         NVL(TO_CHAR(PV.DHR_ATVIE_PLN,'DD/MM/YYYY HH24:MI'), ' ') AS AGENDAMENTO, 
         TO_CHAR(PV.DHR_PLVIA_INI,'DD/MM/YYYY HH24:MI') AS INICIO, 
         '' AS LIBERACAO,
         DPV.ORD_DESTI AS ORD_DESTINO,
         NVL(TO_CHAR(PV.DHR_MANUT,'DD/MM/YYYY HH24:MI:SS'), ' ') AS DATA_ALTERACAO,
         NVL(FC_RELATORIO_DOCUMENTO_CLIENTE(PV.CTL_PLVIA),'0') AS DOC_PROPRIO_CLIENTE,
         SPV.DES_SITUA AS STATUS_PLANO_VIAGEM
    FROM PLANO_VIAGEM PV, TIPO_OPERACAO T, MOTORISTA_PLANO_VIAGEM MPV, ENDERECO_VINCULADO EV, COMUNICACAO_VINCULADO CV, 
                    VEICULO_PLANO_VIAGEM VPV, VEICULO V, MODELO_VEICULO MV, MARCA_VEICULO MRV, GENERO_VEICULO GV, TIPO_VEICULO TV,  
                    DOC_VINCULADO DV, ENDERECO_VINCULADO VEV, PRACA VPR, RELAC_VEICULO_DISPOSITIVO RVD, DISPOSITIVO D,  
                    PROVEDOR_TECNOLOGIA PT, DOC_VINCULADO TDV, ENDERECO_VINCULADO TEV, VINCULADO TVV, PRACA TPR, DOC_VINCULADO ODV,  
                    ENDERECO_VINCULADO OEV, VINCULADO OVV, PRACA OPR, DESTINATARIO_PLANO_VIAGEM DPV, DOC_VINCULADO DDV,  
                    ENDERECO_VINCULADO DEV, VINCULADO DVV, PRACA DPR, RELAC_PLVIA_DOCUMENTO RPD, DOCUMENTO_FISCAL_CLIENTE DFC, 
                    TIPO_OPERACAO_VIAGEM TOV, MODELO_PLANO_VIAGEM MMPV, SITUACAO_PLANO_VIAGEM SPV 
    WHERE T.CTL_OPERA_TIP = 51
		AND (((PV.DHR_INCLU > SYSDATE - (10/1440)) OR PV.DHR_ATVIE_PLN > SYSDATE - (10/1440)) or PV.DHR_MANUT > SYSDATE - (10/1440))
		AND ((D.CTL_PROVE_TEC NOT IN (9,14,15) AND RVD.STA_ATIVO = 'S') OR D.CTL_PROVE_TEC IS NULL) 
		AND D.CTL_MODEL_DIO IS NULL 
		AND PV.TIP_RASTR in (1,3) 
		AND T.CTL_OPERA_TIP = PV.CTL_OPERA_TIP 
		AND MPV.CTL_PLVIA(+) = PV.CTL_PLVIA 
		AND PV.CTL_MOTOT = EV.CTL_VINCD(+) 
		AND MPV.CTL_MOTOT = CV.CTL_VINCD(+) 
		AND VPV.CTL_PLVIA(+) = PV.CTL_PLVIA 
		AND V.CTL_VEICU(+) = VPV.CTL_VEICU 
		AND V.CTL_MODEL = MV.CTL_MODEL 
		AND MV.CTL_MARCA = MRV.CTL_MARCA 
		AND MV.CTL_GENER = GV.CTL_GENER 
		AND GV.CTL_VEICU_TIP = TV.CTL_VEICU_TIP 
		AND V.CTL_TRNSP = DV.CTL_VINCD(+) 
		AND DV.CTL_VINCD = VEV.CTL_VINCD(+) 
		AND VEV.COD_PRACA = VPR.COD_PRACA(+) 
		AND V.CTL_VEICU = RVD.CTL_VEICU(+) 
		AND RVD.CTL_DISPO_RST = D.CTL_DISPO_RST(+) 
		AND D.CTL_PROVE_TEC = PT.CTL_PROVE_TEC(+) 
		AND PV.CTL_TRNSP = TVV.CTL_VINCD(+) 
		AND TVV.CTL_VINCD = TDV.CTL_VINCD(+) 
		AND TDV.CTL_VINCD = TEV.CTL_VINCD(+) 
		AND TEV.COD_PRACA = TPR.COD_PRACA(+) 
		AND PV.CTL_REMET = OVV.CTL_VINCD(+) 
		AND OVV.CTL_VINCD = ODV.CTL_VINCD(+) 
		AND ODV.CTL_VINCD = OEV.CTL_VINCD(+) 
		AND OEV.COD_PRACA = OPR.COD_PRACA(+) 
		AND PV.CTL_PLVIA = DPV.CTL_PLVIA(+) 
		AND DPV.CTL_DESTI = DVV.CTL_VINCD(+) 
		AND DVV.CTL_VINCD = DDV.CTL_VINCD(+) 
		AND DDV.CTL_VINCD = DEV.CTL_VINCD(+) 
		AND DEV.COD_PRACA = DPR.COD_PRACA(+) 
		AND PV.CTL_PLVIA = RPD.CTL_PLVIA(+) 
		AND RPD.CTL_DOCUM_CLI = DFC.CTL_DOCUM_CLI(+) 
		AND PV.TIP_OPERA_VIE = TOV.TIP_OPERA_VIE(+) 
		AND PV.CTL_MODEL_PLV = MMPV.CTL_MODEL_PLV(+)
    AND PV.SIT_PLVIA = SPV.SIT_PLVIA
    ORDER BY PV.CTL_PLVIA, MPV.ORD_MOTOT, VPV.ORD_VEICU, DPV.ORD_DESTI