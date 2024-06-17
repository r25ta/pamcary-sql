SELECT 
      NVL(MOT.cod_docum_mot,'0')                                              AS cpfMotorista
      ,NVL(MOT.nom_motorista,' ')                                             AS nomeMotorista
      ,NVL(pv.ctl_trnsp,0)                                                    AS codTransportadora
      ,NVL(fc_vinculado_documento(pv.ctl_trnsp,1),'0')                        AS cnpjTransportadora
      ,NVL(FC_VINCULADO_NOM_GUERR(pv.ctl_trnsp),' ')                          AS nomeTransportadora
      ,NVL(FC_RELATORIO_PLACA_VEICULO(pv.ctl_plvia),' ')                      AS numPlaca
--      
      ,NVL((SELECT PROVEDOR.COD_DOCUM_PRI
                    FROM
                      SUPERVISOR.PLANO_VIAGEM PLANO,
                      SUPERVISOR.TINF_RELAC_VEICU_DISPO_PLANO travelPlan,
                      SUPERVISOR.TINF_DISPOSITIVO DI,
                      PAMAIS_PRD.V_CRP_PROVEDOR_TECNOLOGIA PROVEDOR,
                      PAMAIS_PRD.V_CRP_VEICULO V,
            SUPERVISOR.TINF_RELAC_PROVE_RASTR_DISPO PRD
            ,SUPERVISOR.TINF_RELAC_VEICU_DISPO RVD
                    WHERE PLANO.CTL_PLVIA = pv.ctl_plvia
                      AND PLANO.CTL_PLVIA         = TRAVELPLAN.CTL_PLVIA
                      AND TRAVELPLAN.CTL_DISPO_RST    = DI.CTL_DISPO_RST
                      AND DI.CTL_DISPO_RST = PRD.CTL_DISPO_RST
                      AND PRD.CTL_PROVE_TEN = PROVEDOR.CTL_PROVE_TEN
                      AND RVD.CTL_DISPO_RST = travelPlan.CTL_DISPO_RST
                      AND RVD.CTL_VEICU = travelPlan.CTL_VEICU
                      AND RVD.STA_ATIVO = 'S'
                      AND travelPlan.CTL_VEICU = V.CTL_VEICU(+)
                      AND V.NUM_CATEG_VEI <> 3
            AND PRD.TIP_RASTR NOT IN (4)
            AND ROWNUM = 1 ),'0')                                             AS cnpjProvedor      
--
      ,NVL((SELECT PROVEDOR.NOM_FANTS
                    FROM
                      SUPERVISOR.PLANO_VIAGEM PLANO,
                      SUPERVISOR.TINF_RELAC_VEICU_DISPO_PLANO travelPlan,
                      SUPERVISOR.TINF_DISPOSITIVO DI,
                      PAMAIS_PRD.V_CRP_PROVEDOR_TECNOLOGIA PROVEDOR,
                      PAMAIS_PRD.V_CRP_VEICULO V,
            SUPERVISOR.TINF_RELAC_PROVE_RASTR_DISPO PRD
            ,SUPERVISOR.TINF_RELAC_VEICU_DISPO RVD
                    WHERE PLANO.CTL_PLVIA = pv.ctl_plvia
                      AND PLANO.CTL_PLVIA         = TRAVELPLAN.CTL_PLVIA
                      AND TRAVELPLAN.CTL_DISPO_RST    = DI.CTL_DISPO_RST
                      AND DI.CTL_DISPO_RST = PRD.CTL_DISPO_RST
                      AND PRD.CTL_PROVE_TEN = PROVEDOR.CTL_PROVE_TEN
                      AND RVD.CTL_DISPO_RST = travelPlan.CTL_DISPO_RST
                      AND RVD.CTL_VEICU = travelPlan.CTL_VEICU
                      AND RVD.STA_ATIVO = 'S'
                      AND travelPlan.CTL_VEICU = V.CTL_VEICU(+)
                      AND V.NUM_CATEG_VEI <> 3
            AND PRD.TIP_RASTR NOT IN (4)
            AND ROWNUM = 1 ),' ')                                             AS nomeProvedor            
--      
      , NVL((SELECT  DI.COD_DISPO_RST
                    FROM
                      SUPERVISOR.PLANO_VIAGEM PLANO,
                      SUPERVISOR.TINF_RELAC_VEICU_DISPO_PLANO travelPlan,
                      SUPERVISOR.TINF_DISPOSITIVO DI,
                      PAMAIS_PRD.V_CRP_PROVEDOR_TECNOLOGIA PROVEDOR,
                      PAMAIS_PRD.V_CRP_VEICULO V,
            SUPERVISOR.TINF_RELAC_PROVE_RASTR_DISPO PRD
            ,SUPERVISOR.TINF_RELAC_VEICU_DISPO RVD
                    WHERE PLANO.CTL_PLVIA = pv.ctl_plvia
                      AND PLANO.CTL_PLVIA         = TRAVELPLAN.CTL_PLVIA
                      AND TRAVELPLAN.CTL_DISPO_RST    = DI.CTL_DISPO_RST
                      AND DI.CTL_DISPO_RST = PRD.CTL_DISPO_RST
                      AND PRD.CTL_PROVE_TEN = PROVEDOR.CTL_PROVE_TEN
                      AND RVD.CTL_DISPO_RST = travelPlan.CTL_DISPO_RST
                      AND RVD.CTL_VEICU = travelPlan.CTL_VEICU
                      AND RVD.STA_ATIVO = 'S'
                      AND travelPlan.CTL_VEICU = V.CTL_VEICU(+)
                      AND V.NUM_CATEG_VEI <> 3
            AND PRD.TIP_RASTR NOT IN (4)
            AND ROWNUM = 1),'0')                                          AS idProvedor
--     
      ,(SELECT NVL(num_renav,0) 
        FROM PAMAIS_PRD.v_crp_veiculo v, 
        SUPERVISOR.Tinf_veicu_plano_viagem vpv
          WHERE v.ctl_veicu = vpv.ctl_veicu
          AND v.num_categ_vei <> 3
          AND vpv.ctl_plvia = pv.ctl_plvia
          AND ROWNUM = 1 )                                                    AS renavam
  --
      ,NVL((SELECT v.ctl_local
        FROM PAMAIS_PRD.v_crp_veiculo v, 
        SUPERVISOR.Tinf_veicu_plano_viagem vpv
          WHERE v.ctl_veicu = vpv.ctl_veicu 
          AND v.num_categ_vei <> 3
          AND ctl_plvia = pv.ctl_plvia
          AND ROWNUM = 1),0)                                                  AS cidadeEmplacamento
  --
      ,NVL((SELECT pr.cod_unfed
        FROM PRACA pr, 
        PAMAIS_PRD.v_crp_veiculo v, 
        SUPERVISOR.Tinf_veicu_plano_viagem vpv
          WHERE v.ctl_veicu = vpv.ctl_veicu 
          AND pr.cod_praca = v.ctl_local
          AND v.num_categ_vei <> 3
          AND vpv.ctl_plvia = pv.ctl_plvia 
          AND ROWNUM = 1),0)                                                  AS ufEmplacamento
  --
      ,NVL(( SELECT doc.cod_docum 
        FROM SUPERVISOR.Tinf_veicu_propr_motot iv, 
        PAMAIS_PRD.v_crp_veiculo v, 
        SUPERVISOR.Tinf_veicu_plano_viagem vpv,
        DOC_VINCULADO doc
          WHERE v.num_categ_vei <> 3
          AND iv.ctl_veicu = v.ctl_veicu
          AND vpv.ctl_veicu = v.ctl_veicu
          AND iv.ctl_motot = doc.ctl_vincd 
          AND vpv.ctl_plvia = pv.ctl_plvia ),'0')                             AS cnpjProprietario
  --
       ,NVL((SELECT FC_VINCULADO_NOM_GUERR(iv.ctl_motot) 
          FROM SUPERVISOR.Tinf_veicu_propr_motot iv, 
          PAMAIS_PRD.v_crp_veiculo v, 
          SUPERVISOR.Tinf_veicu_plano_viagem vpv
            WHERE v.num_categ_vei <> 3
            AND iv.ctl_veicu = v.ctl_veicu
            AND vpv.ctl_veicu = v.ctl_veicu
            AND vpv.ctl_plvia =pv.ctl_plvia),' ')                             AS nomeProprietario
  --
        ,NVL((SELECT cod_praca 
          FROM ENDERECO_VINCULADO e
            WHERE e.ctl_vincd = pv.ctl_remet),0)                              AS cidadeOrigem
  --
        ,NVL(FC_VINCULADO_ENDERECO_UF(pv.ctl_remet, 1),0)                     AS ufOrigem
        ,NVL(pv.ctl_desti, 0)                                                 AS ctlDestino
  --
        ,NVL((SELECT cod_praca 
          FROM ENDERECO_VINCULADO e
            WHERE e.ctl_vincd = pv.ctl_desti),0)                              AS cidadeDestino
  --                         
        ,NVL(FC_VINCULADO_ENDERECO_UF(pv.ctl_desti, 1),0)                     AS ufDestino
        ,PV.ctl_plvia                                                         AS numeroViagem
        ,NVL(IMC.des_meio_cmu,' ')                                            AS tipoMonitoramento
  --
        ,NVL((SELECT TO_CHAR(dhr_efeti_rea,'YYYYMMDDHH24MISS')
          FROM ROTEIRO_MOTORISTA
            WHERE ctl_plvia = PV.ctl_plvia
            AND ord_desti=0
            AND ctl_parad = 10), ' ')                                         AS dhrInicio
  --
        ,NVL(TO_CHAR(pv.dhr_plvia_ter,'YYYYMMDDHH24MISS'),' ')                AS dhrTerminoPrevisto
  --            
        ,NVL(TO_CHAR(pv.dhr_atvie_pln, 'YYYYMMDD'), ' ')                      AS dataInclusao
        ,NVL(FC_RELATORIO_DISTANCIA_TOTAL(pv.ctl_plvia),0)                    AS kmTotalPrevisto
  --
        ,NVL( (SELECT d.cod_docum 
          FROM DOC_VINCULADO d, 
          TIPO_OPERACAO t
            WHERE d.ctl_vincd = t.ctl_vincd_emb
            AND t.ctl_opera_tip = pv.ctl_opera_tip),'0')                      AS cnpjEmbarcador
  --
        ,NVL( (SELECT FC_VINCULADO_NOM_GUERR(t.ctl_vincd_emb)
          FROM TIPO_OPERACAO t
            WHERE t.ctl_opera_tip = pv.ctl_opera_tip),' ')                    AS nomeEmbarcador
  --
        ,NVL((SELECT VCMP.num_merca_pam
          FROM SUPERVISOR.TINF_RELAC_MERCA_GRPNO_PLVIA IRMGP, 
          PAMAIS_PRD.V_CRP_MERCADORIA_PAMCARY VCMP
            WHERE VCMP.num_merca_pam = IRMGP.num_merca_pam
            AND IRMGP.ctl_plvia = pv.ctl_plvia
            AND IRMGP.ctl_desti = pv.ctl_desti
            AND ROWNUM = 1),0)                                              AS codMercadoria
  --
        ,NVL(pv.vlr_total_emb,0)                                              AS valorCarregamento
  --
        ,NVL((SELECT DISTINCT r.cod_consu_tlr 
          FROM SUPERVISOR.TRECON_TELER_VINCD_PLVIA r
            WHERE r.ctl_plvia = pv.ctl_plvia
            AND r.ctl_motot = mpv.ctl_motot
            AND ROWNUM = 1),0)                                                AS numeroConsultaTelerisco
        ,10                                                                   AS origemInfo
  --
    FROM SUPERVISOR.plano_viagem               pv
    ,SUPERVISOR.TINF_MOTORISTA_PLANO_VIAGEM    mpv
    ,PAMAIS_PRD.V_CRP_MOTORISTA                MOT
    ,SUPERVISOR.TINF_MEIO_COMUNICACAO          IMC
  --              
    WHERE pv.ctl_plvia = mpv.ctl_plvia(+)
    AND MOT.ctl_motot(+) = MPV.ctl_motot
    AND MOT.tip_docum_pes = 2
    AND PV.tip_rastr = IMC.tip_meio_cmu
    AND pv.sit_plvia not in(10,14,19,20,16)
    AND to_char(pv.dhr_atvie_pln, 'YYYYMMDDHH24MISS') BETWEEN '20191111000000' AND '20191112235959'
    AND cod_docum_mot = '71381899900'
  --    
    ORDER BY cpfMotorista, dataInclusao;
    
    
    
    