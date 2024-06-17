
       SELECT DISTINCT * FROM bilhet.tbil_relac_visao_propt a
					 ,bilhet.tbil_vigencia_taxa_cliente b
					 ,bilhet.tbil_relac_taxa_proposta c
       WHERE a.num_seque_vig = b.num_seque_vig 
       AND b.NUM_SEQUE_TAR = c.NUM_SEQUE_TAR 
       AND a.SEQ_NUMER_PRS = 505036
	   AND c.NUM_TARIF = 91
	   ORDER BY b.NUM_SEQUE_TAR 
	   
		SELECT * FROM bilhet.tbil_vigencia_taxa_cliente bb1
		WHERE NUM_SEQUE_TAR = 1536754
		
        SELECT * FROM  bilhet.tbil_relac_taxa_proposta cc1
       	WHERE SEQ_NUMER_PRS = 505036
		AND NUM_TARIF = 91
		
        SELECT * FROM  bilhet.tbil_relac_averb_propt dd1
       	WHERE SEQ_NUMER_PRS = 505036

        SELECT * FROM  bilhet.tbil_averbacao
	    WHERE seq_numer_prs = 505036

	    
	    SELECT * FROM bilhet.TBIL_VALOR_SOMA_TIPO_TARIFA tvstt 
        WHERE SEQ_NUMER_FAT = 67999978800
	    WHERE NUM_TARIF = 91
	    
	    
	    SELECT * FROM bilhet.TBIL_TIPO_TARIFA_PROPOSTA tttp 
	    ORDER BY NUM_TARIF 

		SELECT * FROM bilhet.TBIL_PROPOSTA tp	    
	   	WHERE seq_numer_prs = 499907

	   	
	   	SELECT *  FROM bilhet.TBIL_AVERBACAO ta 
	   	WHERE COD_CNPJ_TOMADOR  IN ('00095840000185','00095840000266')
	   	ORDER BY COD_CNPJ_TOMADOR 

	   	SELECT * FROM PAMAIS.V_CRP_PESSOA vcp 
	   	WHERE COD_DOCUM_PRI IN ('00095840000185','00095840000266')
499907 '00095840000185'
	   	
	   	SELECT * FROM bilhet.TBIL_RELAC_AVERB_PROPT trap
	   	INNER JOIN bilhet.tbil_averbacao a ON trap.SEQ_NUMER_AVB = a.SEQ_NUMER_AVB 
	   	WHERE trap.SEQ_NUMER_PRS = 499907
	   	and trap.SEQ_NUMER_FAT IS NULL 
	   	AND a.DHR_EMBAR BETWEEN '20230501000000' AND '20230531235959'
	 
	   	

