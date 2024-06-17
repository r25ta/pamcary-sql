--TAXA EMBARCADOR(PREMIO EMBARCADOR)
	INSERT INTO bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR (seq_numer_fat, cod_cnpj_embarcador, num_tarif, idt_premi, vlr_calcu, dhr_alter, cod_user)
	SELECT 67999978802, x.cod_cnpj_embarcador, x.num_tarif, 'E', x.total, CURRENT timestamp, 'p_cod_user'
	FROM ( 
        SELECT substr(e.cod_cnpj_embarcador ||'-'|| (SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE cod_docum_pri = e.cod_cnpj_embarcador),1,30) AS cod_cnpj_embarcador
        	,cc1.num_tarif
            , SUM(aa1.vlr_tarif_prs) total
         FROM bilhet.tbil_relac_visao_propt aa1
         	, bilhet.tbil_vigencia_taxa_cliente bb1
         	, bilhet.tbil_relac_taxa_proposta cc1
         	, bilhet.tbil_relac_averb_propt dd1
         	, bilhet.tbil_averbacao avb
         	 , bilhet.TBIL_RELAC_TAXA_PROPOSTA e
         WHERE aa1.seq_numer_prs = 505036
           AND dd1.seq_numer_fat = 67999978802
		   AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
		   AND cc1.NUM_TARIF = 91
		   AND e.SEQ_NUMER_PRS = aa1.SEQ_NUMER_PRS 
           AND avb.seq_numer_avb = dd1.seq_numer_avb
           AND cc1.num_seque_tar = bb1.num_seque_tar
           AND aa1.num_seque_vig = bb1.num_seque_vig
           AND aa1.seq_numer_prs = dd1.seq_numer_prs
           AND aa1.seq_numer_avb = dd1.seq_numer_avb
           AND avb.COD_CNPJ_TOMADOR = e.COD_CNPJ_EMBARCADOR 
         GROUP BY aa1.seq_numer_prs, e.COD_CNPJ_EMBARCADOR, cc1.num_tarif
	) x;

    SELECT * FROM  bilhet.TBIL_VALOR_SOMA_TIPO_TAR_EMBAR




SELECT 'p_seq_numer_fat', x.cod_cnpj_embarcador, 92, 'E', sum(x.total), CURRENT timestamp, 'p_cod_user'
	     FROM (
		     SELECT e.cod_cnpj_embarcador ||'-'|| (SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE cod_docum_pri = e.cod_cnpj_embarcador) AS cod_cnpj_embarcador 
		     	,COUNT(DISTINCT avb.num_averb_pam) AS total
		       FROM bilhet.tbil_relac_visao_percu_padra a
		       , bilhet.tbil_vigen_tarifa_percurso b
		       , bilhet.tbil_relac_tarifa_percurso c
		       , bilhet.tbil_relac_averb_propt d
		       , bilhet.tbil_averbacao avb
		       , bilhet.TBIL_RELAC_TAXA_PROPOSTA e
		      WHERE a.seq_numer_prs = 505036
			      AND d.seq_numer_fat = 67999978802
                  AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31') 
   		          AND e.seq_numer_prs = a.seq_numer_prs
		          AND e.num_tarif = 91
		          AND avb.seq_numer_avb = d.seq_numer_avb
		          AND a.ctl_vigen_pec = b.ctl_vigen_pec
		          AND b.num_tarif_pec = c.num_tarif_pec
		          AND a.seq_numer_prs = d.seq_numer_prs
		          AND a.seq_numer_avb = d.seq_numer_avb
				  AND e.cod_cnpj_embarcador = avb.cod_cnpj_tomador
		        GROUP BY a.seq_numer_prs, e.cod_cnpj_embarcador
	     
	     ) x 
	    GROUP BY cod_cnpj_embarcador;


	SELECT 'p_seq_numer_fat',	x.cod_cnpj_embarcador, 93, 'E',	NVL(SUM(x.vlr_is), 0), CURRENT timestamp, 'p_cod_user'
	FROM ( SELECT DISTINCT d.seq_numer_prs
			,d.seq_numer_avb
			,d.vlr_is
            ,a.cod_cnpj_embarcador || '-' || (SELECT nom_pesso FROM pamais.tcrp_pessoa WHERE cod_docum_pri = a.cod_cnpj_embarcador) AS cod_cnpj_embarcador
			FROM bilhet.tbil_relac_averb_propt d
				,bilhet.tbil_averbacao avb
                ,bilhet.tbil_relac_visao_percu_padra c 
                ,bilhet.TBIL_RELAC_TAXA_PROPOSTA a
			WHERE d.seq_numer_prs = 505036
				AND d.seq_numer_fat = 67999978802
				AND a.seq_numer_prs = d.seq_numer_prs
				AND a.num_tarif = 91
				AND a.cod_cnpj_embarcador IS NOT NULL
				AND a.cod_cnpj_embarcador = avb.cod_cnpj_tomador
				AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
				AND avb.seq_numer_avb = d.seq_numer_avb
				AND d.seq_numer_prs = c.seq_numer_prs
				AND d.seq_numer_avb = c.seq_numer_avb
				AND avb.COD_CNPJ_TOMADOR = a.cod_cnpj_embarcador
		)x 
		GROUP BY x.cod_cnpj_embarcador;
	   
	   
	   
	   
	   


	SELECT 'p_seq_numer_fat',cod_cnpj_embarcador, num_tarif, 'E', sum(total), CURRENT timestamp, 'p_cod_user'
	FROM ( 
        SELECT cc1.num_tarif, e.COD_CNPJ_EMBARCADOR AS cod_cnpj_embarcador, SUM(aa1.vlr_tarif_prs) total
         FROM bilhet.tbil_relac_visao_propt aa1
         	, bilhet.tbil_vigencia_taxa_cliente bb1
         	, bilhet.tbil_relac_taxa_proposta cc1
         	, bilhet.tbil_relac_averb_propt dd1
         	, bilhet.tbil_averbacao avb
         	 , bilhet.TBIL_RELAC_TAXA_PROPOSTA e
         WHERE aa1.seq_numer_prs = 505036
--           AND dd1.seq_numer_fat IS NULL
           AND dd1.seq_numer_fat = 67999978802
		   AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31')
		   AND cc1.NUM_TARIF = 91
		   AND e.SEQ_NUMER_PRS = aa1.SEQ_NUMER_PRS 
           AND avb.seq_numer_avb = dd1.seq_numer_avb
           AND cc1.num_seque_tar = bb1.num_seque_tar
           AND aa1.num_seque_vig = bb1.num_seque_vig
           AND aa1.seq_numer_prs = dd1.seq_numer_prs
           AND aa1.seq_numer_avb = dd1.seq_numer_avb
           AND avb.COD_CNPJ_TOMADOR = e.COD_CNPJ_EMBARCADOR 
         GROUP BY aa1.seq_numer_prs, e.COD_CNPJ_EMBARCADOR, cc1.num_tarif
)
GROUP BY cod_cnpj_embarcador, num_tarif

         union
         
         SELECT 91,'Demais' AS cod_cnpj_embarcador,  sum(trvp.vlr_tarif_prs) AS total
	   		FROM 
			bilhet.TBIL_RELAC_VISAO_PROPT trvp
			INNER JOIN bilhet.TBIL_VIGENCIA_TAXA_CLIENTE tvtc 
			ON TVTC.NUM_SEQUE_VIG = TRVP.NUM_SEQUE_VIG 
			INNER JOIN bilhet.TBIL_RELAC_TAXA_PROPOSTA trtp 
			ON trtp.NUM_SEQUE_TAR = tvtc.NUM_SEQUE_TAR 
			INNER JOIN bilhet.TBIL_AVERBACAO avb
			ON avb.SEQ_NUMER_AVB = TRVP.SEQ_NUMER_AVB 
			INNER JOIN bilhet.TBIL_RELAC_AVERB_PROPT trap
			ON (trap.seq_numer_prs, trap.seq_numer_avb) = (trvp.seq_numer_prs, trvp.seq_numer_avb)
			WHERE trvp.SEQ_NUMER_PRS =  505036
			AND trap.seq_numer_fat  = 67999978802 
			AND trtp.NUM_TARIF = 16
			AND TRUNC(avb.dhr_embar) <= LAST_DAY('2023-05-31') 
 			AND (avb.COD_CNPJ_TOMADOR IS NULL OR avb.COD_CNPJ_TOMADOR NOT IN (SELECT cod_cnpj_embarcador 
																				FROM bilhet.TBIL_RELAC_TAXA_PROPOSTA trtp 
																				WHERE SEQ_NUMER_PRS = trvp.SEQ_NUMER_PRS 
																				AND num_tarif = 91))
        GROUP BY trap.seq_numer_prs
)
GROUP BY cod_cnpj_embarcador
