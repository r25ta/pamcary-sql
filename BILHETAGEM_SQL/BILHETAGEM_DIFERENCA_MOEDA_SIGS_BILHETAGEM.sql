SELECT
	DISTINCT tp.SEQ_NUMER_PRS,
	tp.NUM_APOLI,
	tp.NUM_PROPT,
	tp.NUM_RAMO_SEG AS Sig_Ramo,
	r.sig_ramo AS Ramo,
	( CASE 
		WHEN (tp.NUM_MOEDA_PRS) = 3 THEN 'US$'
		ELSE 'R$'
	END ) AS bilhetagem,

	( CASE 
		WHEN (pp.NUM_MOEDA) = 3 THEN 'US$' 
		ELSE 'R$'
	END )  AS SIGS,
	
	tp.DAT_INICI_VIG,
	tp.DAT_FIM_VIG
FROM
	BILHET.TBIL_PROPOSTA tp
INNER JOIN pamais.crp_pessoa p ON
	p.CTL_PESSO = tp.CTL_PESSO_CLI 
INNER JOIN seguro.TSEG_PROPOSTA_SEGURO s ON	
	s.NUM_PROPT = tp.NUM_PROPT 
INNER JOIN seguro.TSEG_PROPOSTA_PREMIO pp ON
	pp.num_propt = s.num_propt
INNER JOIN RAMO r ON
	r.num_ramo = tp.num_ramo_seg
WHERE tp.NUM_RAMO_SEG IN (30,59)
ORDER BY tp.NUM_PROPT DESC 

SELECT * FROM SEGURO.TSEG_PROPOSTA_PREMIO tpp 
WHERE NUM_PROPT = 22003092
