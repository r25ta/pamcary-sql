SELECT T.DES_OPERA_TIP AS OPERACAO,
                PV.CTL_PLVIA AS NUMERO_VIAGEM,
                VMOT.NOM_MOTORISTA AS MOTORISTA_NOME,
                VMOT.COD_DOCUM_MOT AS MOTORISTA_DOCUMENTO,
                NVL((SELECT COD_DOCUM_PES FROM PAMAIS_PRD.TCRP_DOCUMENTO_PESSOA 
                    WHERE TIP_DOCUM_PES = 12 AND CTL_PESSO = MPV.CTL_MOTOT),'') AS MOTORISTA_RG,
                NVL(PV.NUM_PCARD,'') AS MOTORISTA_NUMERO_PAMCARD,
                NVL(TO_CHAR(VMOT.DAT_NASCI,'DD/MM/YYYY'),'') AS MOTORISTA_DATA_NASCIMENTO,
                VMOT.DES_ESTAD_CIV AS MOTORISTA_ESTADO_CIVIL,
                VMOT.COD_DOCUM_CNH AS MOTORISTA_CNH_NUMERO,
                VMOT.COD_CATEG_CNH AS MOTORISTA_CNH_CATEGORIA,
                '' AS MOTORISTA_CNH_VENCIMENTO,
                FC_RECONSULTA_STATUS_TELERISCO(PV.CTL_PLVIA) AS STATUS_CONSULTA_TELERISCO,
                FC_RECONSULTA_PROTO_TELERISCO(PV.CTL_PLVIA) AS NUMERO_CONSULTA_TELERISCO,
                FC_RECONSULTA_DATA_TELERISCO(PV.CTL_PLVIA) AS DATA_CONSULTA_TELERISCO,
                NVL((SELECT DES_LOGRA FROM PAMAIS_PRD.TCRP_ENDERECO_PESSOA WHERE CTL_PESSO = MPV.CTL_MOTOT AND NUM_ENDER_PES = 1),'') AS END_RUA,
                NVL((SELECT COD_NUMER_LGR FROM PAMAIS_PRD.TCRP_ENDERECO_PESSOA WHERE CTL_PESSO = MPV.CTL_MOTOT AND NUM_ENDER_PES = 1),'') AS END_NUMERO,
                NVL((SELECT DES_COMPL FROM PAMAIS_PRD.TCRP_ENDERECO_PESSOA WHERE CTL_PESSO = MPV.CTL_MOTOT AND NUM_ENDER_PES = 1),'') AS END_COMPLEMENTO,
                NVL((SELECT NOM_BAIRR FROM PAMAIS_PRD.TCRP_ENDERECO_PESSOA WHERE CTL_PESSO = MPV.CTL_MOTOT AND NUM_ENDER_PES = 1),'') AS END_BAIRRO,
                NVL((SELECT L.NOM_LOCAL FROM PAMAIS_PRD.V_CRP_LOCALIDADE L, PAMAIS_PRD.TCRP_ENDERECO_PESSOA E 
                    WHERE E.CTL_PESSO = MPV.CTL_MOTOT AND E.CTL_LOCAL = L.CTL_LOCAL AND NUM_ENDER_PES = 1),'') AS END_CIDADE,
                NVL((SELECT L.SIG_UNFED FROM PAMAIS_PRD.V_CRP_LOCALIDADE L, PAMAIS_PRD.TCRP_ENDERECO_PESSOA E 
                    WHERE E.CTL_PESSO = MPV.CTL_MOTOT AND E.CTL_LOCAL = L.CTL_LOCAL AND NUM_ENDER_PES = 1),'') AS END_UF,
                NVL((SELECT L.NOM_PAIS FROM PAMAIS_PRD.V_CRP_LOCALIDADE L, PAMAIS_PRD.TCRP_ENDERECO_PESSOA E 
                    WHERE E.CTL_PESSO = MPV.CTL_MOTOT AND E.CTL_LOCAL = L.CTL_LOCAL AND NUM_ENDER_PES = 1),'') AS END_PAIS,
                NVL((SELECT COD_CEP FROM PAMAIS_PRD.TCRP_ENDERECO_PESSOA WHERE CTL_PESSO = MPV.CTL_MOTOT AND NUM_ENDER_PES = 1),'') AS END_CEP,
                NVL((SELECT NUM_DDD || '-' || COD_TELEF FROM PAMAIS_PRD.TCRP_TELEFONE_CONTATO 
                    WHERE NUM_TELEF_PES = 1 AND CTL_PESSO = MPV.CTL_MOTOT AND ROWNUM <= 1),'') AS TELEFONE_FIXO,
                NVL(CV.DES_COMUN_VIN,'') AS TELEFONE_CELULAR,
                '' AS TELEFONE_RECADO,
                '' AS NEXTEL,
                '' AS VINCULO,
                NVL(V.COD_PLACA,'') AS VEICULO_PLACA,
                NVL(V.NUM_RENAV, 0) AS VEICULO_RENAVAM,
                NVL(V.NOM_MARCA_VEI,'') AS VEICULO_MARCA,
                NVL(V.NOM_MODEL_VEI,'''') AS VEICULO_MODELO,
                NVL(V.NOM_COR_VEI,'') AS VEICULO_COR,
                NVL(V.ANO_FABRC,'') AS VEICULO_ANO,
                NVL(FC_VINCULADO_NOM_GUERR(DV.CTL_VINCD),'') AS VEICULO_VINCULO,
                NVL(V.QTD_EIXO, 0) AS VEICULO_NUMERO_EIXOS,
                NVL(DECODE(DV.TIP_DOCUM, 1, 'CNPJ', 2, 'CPF', 3, 'COD.EXTERNO'), 0) AS VEICULO_TIPO_DOC_PROPRIETARIO,
                NVL(DV.COD_DOCUM,'') AS VEICULO_NUM_DOC_PROPRIETARIO,
                NVL(VEV.DES_ENDER,'') AS END_VEICU_RUA,
                NVL(VEV.DES_NUMER_END,'') AS END_VEICU_NUMERO,
                NVL(VEV.DES_COMPL_END,'') AS END_VEICU_COMPLEMENTO,
                NVL(VEV.DES_BAIRR_END,'') AS END_VEICU_BAIRRO,
                NVL(VPR.NOM_LOCAL,'') AS END_VEICU_CIDADE,
                NVL(VPR.SIG_UNFED,'') AS END_VEICU_UF,
                NVL(VPR.NOM_PAIS,'') AS END_VEICU_PAIS,
                NVL(VPR.COD_CEP,'00000000') AS END_VEICU_CEP,
                NULL AS NUMERO_FROTA,
                NVL(V.NOM_CATEG_VEI,'') AS TIPO,
                NVL(VPT.NOM_FANTS,'TELEFONE') AS TECNOLOGIA,
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
                NVL(TEV.NUM_LATIT, 0) AS TRNSP_LATITUDE,
                NVL(TEV.NUM_LONGI, 0) AS TRNSP_LONGITUDE,
                '' AS TRNSP_TELEFONE,
                '' AS TRNSP_EMAIL,
                '' AS TRNSP_RESPONSAVEL,
                '' AS TRNSP_CARGO,
                '' AS TRNSP_TEL_FIXO,
                '' AS TRNSP_TEL_CELULAR,
                '' AS TRNSP_EMAIL_RESP,
                NVL(DECODE(ODV.TIP_DOCUM, 1, 'CNPJ', 2, 'CPF', 3, 'COD.EXTERNO'), 0) AS ORIGEM_TIPO_DOCUMENTO,
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
                NVL(OEV.NUM_LATIT, 0) AS ORIGEM_LATITUDE,
                NVL(OEV.NUM_LONGI, 0) AS ORIGEM_LONGITUDE,
                '' AS ORIGEM_TELEFONE,
                '' AS ORIGEM_EMAIL,
                '' AS ORIGEM_RESPONSAVEL,
                '' AS ORIGEM_CARGO,
                '' AS ORIGEM_TEL_FIXO,
                '' AS ORIGEM_TEL_CELULAR,
                '' AS ORIGEM_EMAIL_RESP,
                NVL(DECODE(DDV.TIP_DOCUM, 1, 'CNPJ', 2, 'CPF', 3, 'COD.EXTERNO'), 0) AS DESTINO_TIPO_DOCUMENTO,
                NVL(DDV.COD_DOCUM,'') AS DESTINO_NUM_DOCUMENTO,
                TO_CHAR(DPV.DHR_PLVIA_TER,'DD/MM/YYYY') AS DESTINO_PREVISAO_DATA,
                TO_CHAR(DPV.DHR_PLVIA_TER,'HH24:MI') AS DESTINO_PREVISAO_HORA,
                '' AS DESTINO_NUMERO_NOTA,
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
                NVL(DEV.NUM_LATIT, 0) AS DESTINO_LATITUDE,
                NVL(DEV.NUM_LONGI, 0) AS DESTINO_LONGITUDE,
                '' AS DESTINO_TELEFONE,
                '' AS DESTINO_EMAIL,
                '' AS DESTINO_RESPONSAVEL,
                '' AS DESTINO_CARGO,
                '' AS DESTINO_TEL_FIXO,
                '' AS DESTINO_TEL_CELULAR,
                '' AS DESTINO_EMAIL_RESP,
                NVL(FC_RELATORIO_DOC_VINCULADO(DPV.NUM_CONSI_MER),'') AS DESTINO_REMET_CNPJ,
                NVL(FC_VINCULADO_NOM_GUERR(DPV.NUM_CONSI_MER),'') AS DESTINO_REMET_RAZAO_SOCIAL,
                NVL(DPV.SIG_ORDEM_EVE,'') AS DESTINO_JANELA_OPERACIONAL,
                '' AS OPERAC_VIAGEM_CLIENTE,
                '' AS FAIXA_TERMPERATURA,
                NVL(PV.QTD_TOTAL_CGA, 0) AS PESO_TOTAL,
                NVL(TOV.DES_OPERA_VIE,'') AS TIPO_OPERACAO,
                NVL(MMPV.DES_MODEL_PLV,'') AS NOME_IMG,
                NVL(PV.OBS_PLVIA,'') AS OBSERVACAO,
                '' AS TIPO_CARGA,
                '' AS DESCRICAO_CARGA,
                '' AS PERCURSO,
                NVL(PV.VLR_TOTAL_EMB, 0) AS VALOR,
                NVL(TO_CHAR(PV.DHR_ATVIE_PLN,'DD/MM/YYYY HH24:MI'), '') AS AGENDAMENTO,
                TO_CHAR(PV.DHR_PLVIA_INI,'DD/MM/YYYY HH24:MI') AS INICIO,
                '' AS LIBERACAO,
                DPV.ORD_DESTI AS ORD_DESTINO,
                NVL(TO_CHAR(PV.DHR_MANUT,'DD/MM/YYYY HH24:MI:SS'), '') AS DATA_ALTERACAO,
                NVL(FC_RELATORIO_DOCUMENTO_CLIENTE(PV.CTL_PLVIA), 0) AS DOC_PROPRIO_CLIENTE,
                SPV.DES_SITUA AS STATUS_PLANO_VIAGEM,
                CPV.NUM_COMPS AS NUMERO_BI_TREM,
                NVL(FC_DADOS_DISPO_COMPL(PV.CTL_PLVIA,1),'') AS DISPOSITIVO_COMPL,
                NVL(FC_DADOS_DISPO_COMPL(PV.CTL_PLVIA,2),'') AS TECNOLOGIA_COMPL,
                NVL(FC_DADOS_DISPO_COMPL(PV.CTL_PLVIA,3),'') AS TIPO_COMPL,
                NVL(FC_DADOS_DISPO_COMPL(PV.CTL_PLVIA,4),'') AS MODELO_COMPL,
                NVL(FC_DADOS_DISPO_COMPL(PV.CTL_PLVIA,5),'') AS CLASSIFICACAO_COMPL,
                NVL(FC_DADOS_MERCADORIA(PV.CTL_PLVIA, DPV.ORD_DESTI, 1),'') AS MERCADORIA,
                NVL(FC_DADOS_MERCADORIA(PV.CTL_PLVIA, DPV.ORD_DESTI, 2),'') AS VALOR_MERCADORIA,
                NVL(FC_DADOS_NORMA(PV.CTL_PLVIA, DPV.ORD_DESTI, 1),'') AS COD_GRUPO_NORMA,
                NVL(FC_DADOS_NORMA(PV.CTL_PLVIA, DPV.ORD_DESTI, 2),'') AS GRUPO_NORMA,
                NVL(FC_DADOS_NORMA(PV.CTL_PLVIA, DPV.ORD_DESTI, 3),'') AS NORMA,
                NVL((SELECT CTL_ROTA_GRI FROM SUPERVISOR.TINF_ROTA INFR WHERE DPV.CTL_ROTA_GRI = INFR.CTL_ROTA_GRI), '') AS CODIGO_ROTA,
                NVL((SELECT NOM_ROTA FROM SUPERVISOR.TINF_ROTA INFR WHERE DPV.CTL_ROTA_GRI = INFR.CTL_ROTA_GRI), '') AS NOME_ROTA
          
    FROM SUPERVISOR.PLANO_VIAGEM PV, SUPERVISOR.TIPO_OPERACAO T, SUPERVISOR.TINF_MOTORISTA_PLANO_VIAGEM MPV, 
                PAMAIS_PRD.V_CRP_MOTORISTA VMOT, SUPERVISOR.ENDERECO_VINCULADO EV, SUPERVISOR.TCOMUNICACAO_VINCULADO CV, 
                SUPERVISOR.TINF_VEICU_PLANO_VIAGEM VPV, PAMAIS_PRD.V_CRP_VEICULO V, SUPERVISOR.TINF_VEICU_PROPR_VINCD IFPV, 
                SUPERVISOR.DOC_VINCULADO DV, SUPERVISOR.ENDERECO_VINCULADO VEV, PAMAIS_PRD.V_CRP_LOCALIDADE VPR, 
                SUPERVISOR.TINF_RELAC_VEICU_DISPO RVD, SUPERVISOR.TINF_DISPOSITIVO D, 
                SUPERVISOR.TINF_RELAC_PROVE_RASTR_DISPO PT, PAMAIS_PRD.V_CRP_PROVEDOR_TECNOLOGIA VPT, SUPERVISOR.DOC_VINCULADO TDV, 
                SUPERVISOR.ENDERECO_VINCULADO TEV, SUPERVISOR.VINCULADO TVV, SUPERVISOR.PRACA TPR, SUPERVISOR.DOC_VINCULADO ODV, 
                SUPERVISOR.ENDERECO_VINCULADO OEV, SUPERVISOR.VINCULADO OVV, SUPERVISOR.PRACA OPR, SUPERVISOR.DESTINATARIO_PLANO_VIAGEM DPV, SUPERVISOR.DOC_VINCULADO DDV, 
                SUPERVISOR.ENDERECO_VINCULADO DEV, SUPERVISOR.VINCULADO DVV, SUPERVISOR.PRACA DPR, 
                SUPERVISOR.TTIPO_OPERACAO_VIAGEM TOV, SUPERVISOR.TMODELO_PLANO_VIAGEM MMPV, SUPERVISOR.SITUACAO_PLANO_VIAGEM SPV, SUPERVISOR.TCOMPS_PLANO_VIAGEM CPV, 
                SUPERVISOR.TPERFIL_PARAMETRO_INFOLOG PPI
    
    WHERE T.CTL_OPERA_TIP =  51
                AND PPI.CTL_VINCD = T.CTL_VINCD_EMB
                AND PPI.STA_INTEG_PST = 'S'
                AND T.STA_ATIVO = 'S'
                
      AND (( RVD.STA_ATIVO = 'S') OR VPT.CTL_PROVE_TEN IS NULL)
                AND PV.TIP_RASTR in (1,6)
                AND ((T.CTL_OPERA_TIP = 20 AND TDV.COD_DOCUM IN('066199068000150','066199068000230','066199068000311')) OR (T.CTL_OPERA_TIP <> 20))
                AND T.CTL_OPERA_TIP = PV.CTL_OPERA_TIP
                AND MPV.CTL_PLVIA(+) = PV.CTL_PLVIA
                AND VMOT.CTL_MOTOT(+) = MPV.CTL_MOTOT
                AND MPV.CTL_MOTOT = EV.CTL_VINCD(+)
                AND MPV.CTL_MOTOT = CV.CTL_VINCD(+)
                AND VPV.CTL_PLVIA(+) = PV.CTL_PLVIA
                AND V.CTL_VEICU(+) = VPV.CTL_VEICU
                AND V.CTL_VEICU = IFPV.CTL_VEICU(+)
                AND IFPV.CTL_VINCD = DV.CTL_VINCD(+)
                AND DV.CTL_VINCD = VEV.CTL_VINCD(+)
                AND VEV.COD_PRACA = VPR.CTL_LOCAL(+)
                AND V.CTL_VEICU = RVD.CTL_VEICU(+)
                AND RVD.CTL_DISPO_RST = D.CTL_DISPO_RST(+)
                AND D.CTL_DISPO_RST = PT.CTL_DISPO_RST(+)
                AND PT.CTL_PROVE_TEN = VPT.CTL_PROVE_TEN(+)
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
                AND PV.TIP_OPERA_VIE = TOV.TIP_OPERA_VIE(+)
                AND PV.CTL_MODEL_PLV = MMPV.CTL_MODEL_PLV(+)
                AND CPV.CTL_PLVIA(+) = PV.CTL_PLVIA
                AND PV.SIT_PLVIA = SPV.SIT_PLVIA
                and PV.ctl_plvia in ( 11032503, 11032643 )
  ORDER BY PV.CTL_PLVIA, MPV.ORD_MOTOT, VPV.ORD_VEICU, DPV.ORD_DESTI