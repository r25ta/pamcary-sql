
--APOLICE TESTE 5400034633

/**APLICAÇÃO DAS TARIFAS DA APOLICE EM CADA AVERBAÇÃO DROOLS TBIL_RELAC_VISAO_PROPT**/
SELECT TRVP.SEQ_NUMER_PRS
,TRVP.SEQ_NUMER_AVB 
,ta.DHR_EMBAR 
,ta.vlr_embar
,TRAP.VLR_IS
,TVTC.VLR_TARIF 
,trvp.vlr_tarif_prs
,TVTC.STA_AGREGA_FILIAL 
,TVTC.DAT_INICI_VIG 
,TVTC.DAT_FIM_VIG 
, (SELECT NUM_TARIF FROM BILHEt.TBIL_RELAC_TAXA_PROPOSTA WHERE NUM_SEQUE_TAR = tvtc.num_seque_tar)
FROM BILHET.TBIL_RELAC_VISAO_PROPT trvp
, BILHET.TBIL_VIGENCIA_TAXA_CLIENTE tvtc 
, BILHET.TBIL_AVERBACAO ta 
, BILHET.TBIL_RELAC_AVERB_PROPT trap 
WHERE TVTC.NUM_SEQUE_VIG = TRVP.NUM_SEQUE_VIG
AND ta.SEQ_NUMER_AVB = TRVP.SEQ_NUMER_AVB
AND (TRAP.SEQ_NUMER_PRS, TRAP.SEQ_NUMER_AVB) = (TRVP.SEQ_NUMER_PRS, TRVP.SEQ_NUMER_AVB)
and TRVP.SEQ_NUMER_PRS = 505036
AND TRVP.DHR_ALTER BETWEEN '2023-09-13 00:00:00' AND '2023-09-13 23:59:59'
ORDER BY ta.SEQ_NUMER_AVB, ta.DHR_EMBAR

/**ITINERARIO - PERCURSO PREENCHIDO PELO DROOLS RELAC_VISAO_PERCU_PADRA**/
SELECT trtp.NUM_TARIF_PEC
,trvpp.seq_numer_prs
,trvpp.seq_numer_avb
,trvpp.vlr_tarif_pec
, SEQ_LOCAL_ORI 
,(SELECT nom_local FROM bilhet.tbil_localidade WHERE seq_numer_loc = SEQ_LOCAL_ORI ) AS origem
,SEQ_LOCAL_DES 
,(SELECT nom_local FROM bilhet.tbil_localidade WHERE seq_numer_loc = SEQ_LOCAL_des ) AS destino
,trtp.NUM_TARIF 
,ttp.NOM_APELI_TAR
,TVTP.CTL_VIGEN_PEC 
,TVTP.DAT_INICI_VIG 
,tvtp.DAT_FIM_VIG 
,tvtp.PCE_TARIF_PEC 
,tvtp.VLR_LIMIT_INF 
,tvtp.VLR_LIMIT_SPE 
FROM bilhet.TBIL_RELAC_TARIFA_PERCURSO trtp
, bilhet.tbil_tipo_tarifa_proposta ttp
, BILHET.TBIL_VIGEN_TARIFA_PERCURSO tvtp 
, BILHET.TBIL_RELAC_VISAO_PERCU_PADRA trvpp
WHERE ttp.num_tarif = trtp.num_tarif
AND trtp.NUM_TARIF_PEC  = TVTP.NUM_TARIF_PEC
AND trvpp.ctl_vigen_pec = tvtp.ctl_vigen_pec
AND trvpp.seq_numer_prs = 505036
AND trvpp.DHR_ALTER BETWEEN '2023-09-13 00:00:00' AND '2023-09-13 23:59:59'

SELECT * FROM BILHET.TBIL_RELAC_AVERB_PROPT trap 




         SELECT cc2.num_tarif, SUM(aa2.vlr_tarif_pec) vlr
         FROM bilhet.tbil_relac_visao_percu_propt aa2, bilhet.tbil_tarif_percu_proposta bb2, bilhet.tbil_relac_tarifa_percurso cc2, bilhet.tbil_relac_averb_propt dd2, bilhet.tbil_averbacao avb
         WHERE aa2.seq_numer_prs = 505036
--           AND dd2.seq_numer_fat IS NULL
		   AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
           AND avb.seq_numer_avb = dd2.seq_numer_avb
           AND aa2.seq_numer_pec = bb2.seq_numer_pec
           AND cc2.num_tarif_pec = bb2.num_tarif_pec
           AND aa2.seq_numer_prs = dd2.seq_numer_prs
           AND aa2.seq_numer_avb = dd2.seq_numer_avb
         GROUP BY aa2.seq_numer_prs, cc2.num_tarif

         
          SELECT cc1.num_tarif, SUM(aa1.vlr_tarif_prs) vlr
         FROM bilhet.tbil_relac_visao_propt aa1, bilhet.tbil_vigencia_taxa_cliente bb1, bilhet.tbil_relac_taxa_proposta cc1, bilhet.tbil_relac_averb_propt dd1, bilhet.tbil_averbacao avb
         WHERE aa1.seq_numer_prs = 505036
--           AND dd1.seq_numer_fat IS NULL
		   AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
           AND avb.seq_numer_avb = dd1.seq_numer_avb
           AND cc1.num_seque_tar = bb1.num_seque_tar
           AND aa1.num_seque_vig = bb1.num_seque_vig
           AND aa1.seq_numer_prs = dd1.seq_numer_prs
           AND aa1.seq_numer_avb = dd1.seq_numer_avb
         GROUP BY aa1.seq_numer_prs, cc1.num_tarif
        
         
          SELECT c1.num_tarif, SUM(a1.vlr_tarif_pec) vlr
         FROM bilhet.tbil_relac_visao_percu_padra a1, bilhet.tbil_vigen_tarifa_percurso b1, bilhet.tbil_relac_tarifa_percurso c1
         WHERE a1.seq_numer_prs = 505036
           AND a1.ctl_vigen_pec = b1.ctl_vigen_pec
           AND b1.num_tarif_pec = c1.num_tarif_pec
           AND (a1.seq_numer_prs, a1.seq_numer_avb, c1.num_tarif) IN
			( SELECT a.seq_numer_prs, a.seq_numer_avb, c.num_tarif
				FROM bilhet.tbil_relac_visao_percu_padra a, bilhet.tbil_vigen_tarifa_percurso b, bilhet.tbil_relac_tarifa_percurso c, bilhet.tbil_relac_averb_propt d, bilhet.tbil_averbacao avb
				WHERE a.seq_numer_prs = 505036
	--			AND d.seq_numer_fat IS NULL
				AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
				AND avb.seq_numer_avb = d.seq_numer_avb
				AND a.ctl_vigen_pec = b.ctl_vigen_pec
				AND b.num_tarif_pec = c.num_tarif_pec
				AND a.seq_numer_prs = d.seq_numer_prs
				AND a.seq_numer_avb = d.seq_numer_avb
        				EXCEPT
	
				SELECT aa.seq_numer_prs, aa.seq_numer_avb, cc.num_tarif
				FROM bilhet.tbil_relac_visao_percu_propt aa, bilhet.tbil_tarif_percu_proposta bb, bilhet.tbil_relac_tarifa_percurso cc, bilhet.tbil_relac_averb_propt dd, bilhet.tbil_averbacao avb
				WHERE aa.seq_numer_prs = 505036
				--AND dd.seq_numer_fat IS NULL
				AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
				AND avb.seq_numer_avb = dd.seq_numer_avb
				AND aa.seq_numer_pec = bb.seq_numer_pec
				AND cc.num_tarif_pec = bb.num_tarif_pec
				AND aa.seq_numer_prs = dd.seq_numer_prs
				AND aa.seq_numer_avb = dd.seq_numer_avb
	
				EXCEPT
	
				SELECT aax.seq_numer_prs, aax.seq_numer_avb, ccx.num_tarif
				FROM bilhet.tbil_relac_visao_propt aax, bilhet.tbil_vigencia_taxa_cliente bbx, bilhet.tbil_relac_taxa_proposta ccx, bilhet.tbil_relac_averb_propt ddx, bilhet.tbil_averbacao avb
				WHERE aax.seq_numer_prs = 505036
				--AND ddx.seq_numer_fat IS NULL
				AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
				AND avb.seq_numer_avb = ddx.seq_numer_avb
				AND aax.num_seque_vig = bbx.num_seque_vig
				AND ccx.num_seque_tar = bbx.num_seque_tar
				AND aax.seq_numer_prs = ddx.seq_numer_prs
				AND aax.seq_numer_avb = ddx.seq_numer_avb
			)
         GROUP BY a1.seq_numer_prs, c1.num_tarif
     )
     GROUP BY num_tarif

     
     
          SELECT 'v_seq_numer_fat', c.num_tarif, 'T', SUM(a.vlr_tarif_pec), 'v_data_procs', 'p_cod_user'
       FROM bilhet.tbil_relac_visao_percu_padra a, bilhet.tbil_vigen_tarifa_percurso b, bilhet.tbil_relac_tarifa_percurso c, bilhet.tbil_relac_averb_propt d, bilhet.tbil_averbacao avb
      WHERE a.seq_numer_prs = 505036
 --       AND d.seq_numer_fat IS NULL
	    AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
        AND avb.seq_numer_avb = d.seq_numer_avb
		AND a.ctl_vigen_pec = b.ctl_vigen_pec
        AND b.num_tarif_pec = c.num_tarif_pec
        AND a.seq_numer_prs = d.seq_numer_prs
        AND a.seq_numer_avb = d.seq_numer_avb
      GROUP BY a.seq_numer_prs, c.num_tarif;

     
          SELECT 'v_seq_numer_fat', 69, 'A', NVL(SUM(x.vlr_is), 0), 'v_data_procs', 'p_cod_user'
	   FROM (
			 SELECT distinct d.seq_numer_prs, d.seq_numer_avb, d.vlr_is
			   FROM bilhet.tbil_relac_averb_propt d, bilhet.tbil_averbacao avb, bilhet.tbil_relac_visao_percu_padra c 
			  WHERE d.seq_numer_prs = 505036
	--			AND d.seq_numer_fat IS NULL
				AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
				AND avb.seq_numer_avb = d.seq_numer_avb
				AND d.seq_numer_prs = c.seq_numer_prs
				AND d.seq_numer_avb = c.seq_numer_avb
			) x
			
			
			