SELECT OV.ctl_plvia,
                 CNF.dat_emiss_nf,
                 CNF.num_ntfis               
            FROM PLANO_VIAGEM PV, DOC_VINCULADO DV, OFERTA_VEICULO OV, OFERTA_VEICULO_ETIQUETA OVE, 
                 CSN_NOTA_FISCAL CNF, CSN_NOTA_FISCAL_PRODUTO CNFP, CSN_NOTA_FISCAL_CLIENTE CNFC, CSN_ETIQUETA CE 
            WHERE PV.ctl_plvia = OV.ctl_plvia 
              AND OV.ctl_ofert_vei = OVE.ctl_ofert_vei 
              AND OVE.num_etiqt = CE.num_etiqt 
              AND CE.num_docum = CNF.num_docum 
              AND CNF.num_docum = CNFP.num_docum 
              AND CNF.num_docum = CNFC.num_docum 
              AND PV.ctl_desti = DV.ctl_vincd 
              AND DV.tip_docum = 1 
              AND SUBSTR(DV.cod_docum,1,15) = CNFC.num_cgc_cli1 
              AND OV.ctl_plvia =   141449              
            GROUP BY OV.ctl_plvia, CNF.num_orven, CNF.dat_emiss_nf, CNF.num_ntfis, CNFP.nom_abrev_pro, CNF.num_docum 

            ORDER BY CNF.num_ntfis,
                     CNF.dat_emiss_nf
