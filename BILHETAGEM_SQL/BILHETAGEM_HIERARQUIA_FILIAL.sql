/*BUSCAR FILIAIS NÃO TEM RETORNO ESPERADO*/

SELECT tp.seq_numer_prs, 
		tp.num_apoli 
	   ,tp.num_propt
	   ,tf.num_fatur_cia
	   ,tfn.num_filia_neg 
	   ,tfn.nom_filia_neg 
	   ,tfn.sig_filia_neg 
FROM BILHET.TBIL_PROPOSTA tp
	INNER JOIN BILHET.TBIL_FATURA tf
		ON tp.SEQ_NUMER_PRS = tf.SEQ_NUMER_PRS
	INNER JOIN BILHET.TBIL_HIERQ_PRODR_PROPT th 
		ON tp.SEQ_NUMER_PRS = th.SEQ_NUMER_PRS
	INNER JOIN PAMAIS.TCRP_HIERARQUIA_COMERCIAL thc
		ON th.num_hierq = thc.num_hierq
	INNER JOIN PAMAIS.TCRP_PRODUTOR tpr 
		ON tpr.ctl_prodr = th.ctl_prodr 
	INNER JOIN PAMAIS.TCRP_COLABORADOR_PAMCARY tcpp 
		ON tcpp.ctl_pefis_clb = tpr.ctl_pefis_clb 
	INNER JOIN PAMAIS.TCRP_FILIAL_PAMCARY tfp 
		ON tfp.ctl_filia_pam = tcpp.CTL_FILIA_PAM 
	INNER JOIN PAMAIS.TCRP_FILIAL_NEGOCIO tfn 
		ON tfn.num_filia_neg = tfp.num_filia_neg 
WHERE tp.NUM_PROPT in (19005208
					,19007061
					,20001503
					,20003431
					,20001220
)
AND tf.NUM_FATUR_CIA in(20001103798
,20001112174
,20001117391
,20001123826
,20001085462
)



/*BUSCA FILIAIS RETORNO ESPERADO*/
SELECT t1.num_apoli AS num_apolice 
	,t1.num_propt AS num_proposta
	,t2.num_fatur_cia AS num_fatura_cia
	,t9.num_hierq
    ,t9.ctl_prodr
    ,t91.nom_hierq AS Filal
    ,t92.nom_pesso 
FROM bilhet.TBIL_PROPOSTA t1
	INNER JOIN BILHET.TBIL_FATURA t2
		ON t1.SEQ_NUMER_PRS = t2.SEQ_NUMER_PRS
	LEFT JOIN bilhet.tbil_hierq_prodr_propt t9
		ON t9.seq_numer_prs = t1.seq_numer_prs
	LEFT JOIN aplbil.v_crp_hierarquia_comec_prodr t91
		ON t9.num_hierq = t91.num_hierq
        AND t9.ctl_prodr = t91.ctl_prodr
   	LEFT JOIN aplbil.v_crp_gecon_produto t92
		ON t9.num_hierq = t92.num_hierq
        AND t9.ctl_prodr = t92.ctl_prodr
	LEFT JOIN PAMAIS.V_CRP_HIERARQUIA_COMERCIAL t93
		ON t9.num_hierq = t93.num_hierq
        AND t93.TIP_SETOR = 2
WHERE t1.NUM_PROPT IN (19005208
						,19007061
						,20001503
						,20003431
						,20001220 )
AND t2.NUM_FATUR_CIA in(20001103798
,20001112174
,20001117391
,20001123826
,20001085462)





SELECT * FROM bilhet.V_BIL_PROPOSTA
WHERE SEQ_NUMER_PRS =498642
