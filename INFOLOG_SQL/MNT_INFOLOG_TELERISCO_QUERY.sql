SELECT         NVL(MOT.cod_docum_mot,'0')                                           AS cpfMotorista
              ,NVL(MOT.nom_motorista,' ')                                         AS nomeMotorista
              ,NVL(pv.ctl_trnsp,0)                                                AS codTransportadora
              ,NVL(fc_vinculado_documento(pv.ctl_trnsp,1),'0')                    AS cnpjTransportadora
              ,NVL(FC_VINCULADO_NOM_GUERR(pv.ctl_trnsp),' ')                      AS nomeTransportadora
              ,NVL(FC_RELATORIO_PLACA_VEICULO(pv.ctl_plvia),' ')                  AS numPlaca
              ,FC_RELATORIO_PROVEDOR_CNPJ(pv.ctl_plvia)                           AS cnpjProvedor
              ,FC_RELATORIO_PROVEDOR_NOME(pv.ctl_plvia)                           AS nomeProvedor
              ,FC_RELATORIO_PROVEDOR_CODIGO(pv.ctl_plvia)                         AS idProvedor
--            
              ,(SELECT NVL(num_renav,0) 
                  FROM PAMAIS_PRD.v_crp_veiculo v, 
                       SUPERVISOR.Tinf_veicu_plano_viagem vpv
                  WHERE v.ctl_veicu = vpv.ctl_veicu
                  AND v.num_categ_vei <> 3
                  AND vpv.ctl_plvia = pv.ctl_plvia
                  AND ROWNUM = 1 )                                                 AS renavam
--
              ,NVL((SELECT v.ctl_local
                          FROM PAMAIS_PRD.v_crp_veiculo v, 
                               SUPERVISOR.Tinf_veicu_plano_viagem vpv
                          WHERE v.ctl_veicu = vpv.ctl_veicu 
                          AND v.num_categ_vei <> 3
                          AND ctl_plvia = pv.ctl_plvia
                          AND ROWNUM = 1),0)                                      AS cidadeEmplacamento
--
              ,NVL((SELECT pr.cod_unfed
                          FROM praca pr, 
                               PAMAIS_PRD.v_crp_veiculo v, 
                               SUPERVISOR.Tinf_veicu_plano_viagem vpv
                          WHERE v.ctl_veicu = vpv.ctl_veicu 
                          AND pr.cod_praca = v.ctl_local
                          AND v.num_categ_vei <> 3
                          AND vpv.ctl_plvia = pv.ctl_plvia 
                          AND ROWNUM = 1),0)                    AS ufEmplacamento
--
              ,NVL(( SELECT doc.cod_docum 
                          FROM SUPERVISOR.Tinf_veicu_propr_motot iv, 
                                PAMAIS_PRD.v_crp_veiculo v, 
                                SUPERVISOR.Tinf_veicu_plano_viagem vpv,
                                doc_vinculado doc
                          WHERE v.num_categ_vei <> 3
                            AND iv.ctl_veicu = v.ctl_veicu
                            AND vpv.ctl_veicu = v.ctl_veicu
                            AND iv.ctl_motot = doc.ctl_vincd 
                            AND vpv.ctl_plvia = pv.ctl_plvia ),'0')                 AS cnpjProprietario
--
              ,NVL((SELECT FC_VINCULADO_NOM_GUERR(iv.ctl_motot) 
                  FROM SUPERVISOR.Tinf_veicu_propr_motot iv, 
                       PAMAIS_PRD.v_crp_veiculo v, 
                       SUPERVISOR.Tinf_veicu_plano_viagem vpv
                  WHERE v.num_categ_vei <> 3
                    AND iv.ctl_veicu = v.ctl_veicu
                    AND vpv.ctl_veicu = v.ctl_veicu
                    AND vpv.ctl_plvia =pv.ctl_plvia),' ')                           AS nomeProprietario
--
              ,NVL((SELECT cod_praca 
                        FROM endereco_vinculado e
                          WHERE e.ctl_vincd = pv.ctl_remet
                           ),0)                                                     AS cidadeOrigem
--
              ,NVL(fc_vinculado_endereco_uf(pv.ctl_remet, 1),0)                     AS ufOrigem
              ,NVL(pv.ctl_desti, 0)                                                 AS ctlDestino
--
              ,NVL((SELECT cod_praca 
                        FROM endereco_vinculado e
                          WHERE e.ctl_vincd = pv.ctl_desti
                           ),0)                                                     AS cidadeDestino
--                         
              ,NVL(FC_VINCULADO_ENDERECO_UF(pv.ctl_desti, 1),0)                     AS ufDestino
              ,PV.ctl_plvia                                                         AS numeroViagem
              ,IMC.des_meio_cmu                                                     AS tipoMonitoramento
--
              ,NVL((SELECT TO_CHAR(dhr_efeti_rea,'YYYYMMDDHH24MISS')
                  FROM ROTEIRO_MOTORISTA
                    WHERE ctl_plvia = PV.ctl_plvia
                      AND ord_desti=0
                      AND ctl_parad = 10), ' ')                                    AS dhrInicio
--
              ,NVL(TO_CHAR(pv.dhr_plvia_ter,'YYYYMMDDHH24MISS'),' ')               AS dhrTerminoPrevisto
--            
              ,NVL(TO_CHAR(pv.dhr_atvie_pln, 'YYYYMMDD'), ' ')                     AS dataInclusao
              ,NVL(qtd_dista_tot/1000,0)                                           AS kmTotalPrevisto
--
              ,NVL( (SELECT d.cod_docum 
                  FROM doc_vinculado d, 
                       tipo_operacao t
                  WHERE d.ctl_vincd = t.ctl_vincd_emb
                  AND t.ctl_opera_tip = pv.ctl_opera_tip),'0')                     AS cnpjEmbarcador
--
              ,NVL( (SELECT FC_VINCULADO_NOM_GUERR(t.ctl_vincd_emb)
                  FROM tipo_operacao t
                  WHERE t.ctl_opera_tip = pv.ctl_opera_tip),' ')                   AS nomeEmbarcador
--
              ,NVL((SELECT VCMP.nom_merca_pam
                      FROM SUPERVISOR.TINF_RELAC_MERCA_GRPNO_PLVIA IRMGP, 
                           PAMAIS_PRD.V_CRP_MERCADORIA_PAMCARY VCMP
                      WHERE VCMP.num_merca_pam = IRMGP.num_merca_pam
                        AND IRMGP.ctl_plvia = pv.ctl_plvia
                        AND IRMGP.ctl_desti = pv.ctl_desti
                        AND ROWNUM = 1),' ')                                       AS mercadoria
--
              ,NVL(pv.vlr_total_emb,0)                                              AS valorCarregamento
--
              ,NVL((SELECT DISTINCT r.cod_consu_tlr 
                      FROM SUPERVISOR.Trecon_teler_vincd_plvia r
                      WHERE r.ctl_plvia = pv.ctl_plvia
                        AND r.ctl_motot = mpv.ctl_motot
                        AND ROWNUM = 1),0)                                          AS numeroConsultaTelerisco

              ,10                                                                   AS origemInfo
--
          FROM SUPERVISOR.plano_viagem                   pv
              ,SUPERVISOR.TINF_MOTORISTA_PLANO_VIAGEM    mpv
              ,PAMAIS_PRD.V_CRP_MOTORISTA                MOT
              ,SUPERVISOR.TINF_MEIO_COMUNICACAO          IMC
--              
         WHERE pv.ctl_plvia = mpv.ctl_plvia(+)
            AND MOT.ctl_motot(+) = MPV.ctl_motot
            AND MOT.tip_docum_pes = 2
            AND PV.tip_rastr = IMC.tip_meio_cmu
            AND pv.sit_plvia not in(10,14,19,20,16)
            AND to_char(pv.dhr_atvie_pln, 'YYYYMMDDHH24MISS') BETWEEN '20190601000000' AND to_char(SYSDATE, 'YYYYMMDDHH24MISS')
        ORDER BY cpfMotorista, dataInclusao;