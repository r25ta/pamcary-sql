-- CONSULTA QUE RETORNAR O RELATORIO DE ERROS
-- OS FILTROS SEGURADO, RAMO, CIA E APOLICE EXIGEM QUE O USUÁRIO INFORME O PERIODO 
-- NÚMERO DA AVERBAÇÃO É O UNICO CAMPO QUE NÃO PRECISA INFORMAR O PERIODO	
SELECT    a.CTL_AVERB
        , s.NUM_APOLI AS apolice
        , s.CTL_CLIEN_PPS
        , COALESCE ((SELECT COD_DOCUM_PRI FROM PAMAIS.TCRP_PESSOA WHERE CTL_PESSO = s.ctl_clien_pps),'00000000000000') AS cnpj_segurado
        , COALESCE((SELECT cr.nom_fants FROM PAMAIS.TCRP_PESSOA cr WHERE cr.CTL_PESSO = s.ctl_clien_pps),'SEGURADO NÃO INFORMADO') AS segurado
        , s.NUM_RAMO_SEG
        , (SELECT cs.sig_ramo FROM CRP_RAMO_SEGURO cs   WHERE cs.num_ramo_seg = s.NUM_RAMO_SEG) AS ramo
        , s.NUM_CIA_PAM
        , (SELECT cp.nom_cia_pam FROM PAMAIS.CRP_CIA_SEGURADORA_PAMCARY cp WHERE cp.NUM_CIA_PAM = s.NUM_CIA_PAM) AS cia_seguradora
        , COALESCE((SELECT sum(VLR_LIMIT) FROM seguro.TSEG_PROPOSTA_LIMITE WHERE NUM_PROPT = s.NUM_PROPT AND num_versa_prs = s.NUM_VERSA_PRS),0) AS lmr
        , ai.TIP_AVERB
        , ta.des_tipo_avb AS des_tipo_averbacao
        , ai.NUM_AVERB
        , ai.num_propt
        , a.COD_CEP
        , a.NUM_LOCAL_ORI
        , (SELECT sig_unfed FROM UNIDADE_FEDERAL  WHERE num_unfed  = a.NUM_LOCAL_ORI) AS uf_origem
        , (SELECT des_praca FROM PRACA WHERE num_praca = a.NUM_LOCAL_ORI) AS praca_origem
        , av.NUM_SEQUE_VEI
        , av.COD_IDENT_VEI
        ,a.NUM_MERCA
        ,(SELECT des_merca FROM MERC_ESPECIFICA WHERE num_merca = a.num_merca) AS mercadoria
        ,a.DAT_EMBAR
        ,a.NUM_MOEDA
        ,(SELECT SIG_SIMBO_MOE FROM CRP_MOEDA WHERE NUM_MOEDA = a.NUM_MOEDA) AS moeda
        ,a.VLR_EMBAR
        ,a.COD_MANIF
        ,d.num_local
        , (SELECT sig_unfed FROM UNIDADE_FEDERAL  WHERE num_unfed  = d.num_local) AS uf_destino
        ,d.vlr_manif
        ,ae.TIP_ERRO AS erro
        ,ea.DES_ERRO
        ,ea.TIP_GRUPO_ERR
        ,gea.DES_GRUPO_ERR
        FROM AVERBACAO a
        INNER JOIN AVERBACAO_INDICE ai ON ai.CTL_AVERB = a.CTL_AVERB
        INNER JOIN TIPO_AVERBACAO ta ON ta.TIP_AVERB = ai.TIP_AVERB
        left JOIN AVERBACAO_VEICULO av ON av.CTL_AVERB = a.CTL_AVERB AND av.NUM_SEQUE_VEI = 1
        INNER JOIN AVERBACAO_ERRO ae ON ae.CTL_AVERB = a.CTL_AVERB
        INNER JOIN ERRO_AVERBACAO ea ON ea.TIP_ERRO = ae.TIP_ERRO
        INNER JOIN DBPROD.TGRUPO_ERRO_AVB gea ON gea.TIP_GRUPO_ERR = ea.TIP_GRUPO_ERR
        INNER JOIN DESTINO d ON d.CTL_AVERB = a.CTL_AVERB
        LEFT JOIN SEGURO.TSEG_PROPOSTA_SEGURO s ON s.NUM_PROPT = ai.NUM_PROPT AND s.NUM_VERSA_PRS = 1
        WHERE 1=1
--      AND s.CTL_CLIEN_PPS = 221807  -- TRANSUL SERVICOS  LOCACAO E TRANSPORTE LTDA -- FILTRO POR SEGURADO (PERIODO OBRIGATÓRIO)
        --AND s.NUM_RAMO_SEG =  1 -- RCTR-C -- FILTRO POR RAMO (PERIODO OBRIGATÓRIO)
        --AND s.NUM_CIA_PAM = 265 -- MAPFRE PAMCORP -- FILTRO POR CIA (PERIODO OBRIGATÓRIO)
        --AND s.NUM_APOLI = 1568000000301 -- FILTRO POR APOLICE (PERIODO OBRIGATÓRIO)
        AND a.DAT_EMBAR BETWEEN '2024-03-01' AND now() -- FILTRO POR DATA É OBRIGATÓRIO PARA OS CAMPOS SEGURADO, RAMO, CIA E APOLICE
        --AND a.CTL_AVERB = 866710527 -- FILTRO AVERBACAO (NÃO PRECISA INFORMAR PERIODO)
        --AND ae.TIP_ERRO IN ( 12 )--FILTRO POR TIPO DE ERRO
ORDER BY segurado, ramo
OPTIMIZE FOR 1 ROWS WITH UR
