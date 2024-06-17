/*TAXA EMBARCADOR - INSERT SOMA VIAGEM - 92*/


	  --INSERE TARIFA COM TOTAL DE VIAGEM
    INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (seq_numer_fat, cod_cnpj_embarcador, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
    SELECT p_seq_numer_fat, cod_cnpj_embarcador, 92, 'E', sum(total), CURRENT timestamp, p_cod_user
	     FROM (
		     SELECT COUNT(DISTINCT avb.num_averb_pam) AS total
		     	,e.cod_cnpj_embarcador ||'-'|| (SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE cod_docum_pri = e.cod_cnpj_embarcador) AS cod_cnpj_embarcador
		       FROM bilhet.tbil_relac_visao_percu_padra a
		       , bilhet.tbil_vigen_tarifa_percurso b
		       , bilhet.tbil_relac_tarifa_percurso c
		       , bilhet.tbil_relac_averb_propt d
		       , bilhet.tbil_averbacao avb
		       , bilhet.TBIL_RELAC_TAXA_PROPOSTA e
		      WHERE a.seq_numer_prs = v_seq_numer_prs
			      AND d.seq_numer_fat IS NULL
                  AND TRUNC(avb.dhr_embar) <= LAST_DAY(v_dat_fim_vig) 
   		          AND e.seq_numer_prs = a.seq_numer_prs
		          AND e.num_tarif = 91
		          AND avb.seq_numer_avb = d.seq_numer_avb
		          AND a.ctl_vigen_pec = b.ctl_vigen_pec
		          AND b.num_tarif_pec = c.num_tarif_pec
		          AND a.seq_numer_prs = d.seq_numer_prs
		          AND a.seq_numer_avb = d.seq_numer_avb
				  AND e.cod_cnpj_embarcador = avb.cod_cnpj_tomador
		        GROUP BY a.seq_numer_prs, e.cod_cnpj_embarcador
		    UNION
		       SELECT COUNT(DISTINCT avb.num_averb_pam) AS total, 'Demais' AS cod_cnpj_embarcador
				FROM bilhet.TBIL_AVERBACAO avb 
				inner JOIN bilhet.TBIL_RELAC_AVERB_PROPT trap
					ON trap.seq_numer_avb = avb.seq_numer_avb
				WHERE TRAP.SEQ_NUMER_PRS = = v_seq_numer_prs
					AND trap.seq_numer_fat  IS NULL 
					AND TRUNC(avb.dhr_embar) <= LAST_DAY(v_dat_fim_vig)
					AND (avb.COD_CNPJ_TOMADOR IS NULL OR avb.COD_CNPJ_TOMADOR NOT IN (SELECT cod_cnpj_embarcador 
																						FROM bilhet.TBIL_RELAC_TAXA_PROPOSTA trtp 
																						WHERE SEQ_NUMER_PRS = trap.SEQ_NUMER_PRS 
																						AND num_tarif = 91))
		        GROUP BY trap.seq_numer_prs
	     
	     
	     ) GROUP BY cod_cnpj_embarcador
