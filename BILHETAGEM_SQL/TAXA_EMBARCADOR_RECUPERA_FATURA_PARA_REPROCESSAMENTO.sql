SELECT * FROM pamais.CRP_RAMO_SEGURO 

SELECT * FROM bilhet.TBIL_SITUACAO_FATURA tsf 
SELECT * FROM bilhet.TBIL_SITUACAO_PROPOSTA tsp 
SELECT * FROM bilhet.TBIL_FATURA tf 
WHERE SEQ_NUMER_FAT = 67999978788
AND SIT_FATUR = 2
AND SIT_ENVIO_FAT = 1
AND STA_ENVIO_AVI = 'N'

ORDER BY SEQ_NUMER_FAT DESC 

WHERE SEQ_NUMER_FAT = 7000285501

SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE SEQ_NUMER_PRS = 502360

/*RECUPWRA FATURA PARA REPROCESSAMENTO*/
SELECT DISTINCT tf.SEQ_NUMER_PRS, ta.num_apoli FROM BILHET.TBIL_FATURA tf, bilhet.tbil_proposta ta 
WHERE ta.seq_numer_prs = tf.seq_numer_prs  
AND ta.SIT_TIPO_PRS = 1
AND tf.SIT_FATUR = 2
AND tf.SIT_ENVIO_FAT = 1
AND tf.STA_ENVIO_AVI = 'N'
AND ta.NUM_RAMO_SEG IN (1,2,66)
AND ta.SEQ_NUMER_PRS IN 
(
499577,
499907,
499909,
501787,
501829,
501902,
501926,
501932,
502101,
502103,
502360,
502367,
502621,
502708,
502710,
502745,
502747,
502770,
502807,
503044,
503049,
503072,
503271,
503695,
503777,
503779,
503781,
503782,
503949,
503968,
504092,
504185,
504186,
504223,
504224,
504286,
504287,
504445,
504446,
504447,
504448,
504483,
504484,
504512,
504514,
504522,
504660,
504661,
504663,
504708,
504709,
504716,
504723,
504724,
504729,
504730,
504786,
504787,
504918,
504965,
505036,
505037,
505070,
505075,
505076,
505091,
505111,
505112,
505113,
505114,
505146,
505156,
505162,
505163,
505200,
505201,
505211,
505213,
505214,
505241,
505253,
505278,
505279,
505288,
505289,
505549,
505620,
505621,
505622,
505636,
505656,
505657,
505685,
505699,
505749,
505794,
505795,
505802,
505806,
505822,
505824,
505825,
505858,
505859,
505883,
505898,
505900,
505909,
505910,
505949,
505950,
505963,
505964,
505968,
505979,
505992,
505993,
506011,
506013,
506015,
506021,
506022,
506122,
506145,
506157,
506158,
506205,
506206,
506207,
506208,
506271,
506272,
506273,
506274,
506308,
506322,
506323,
506324,
506339,
506345,
506365,
506370,
506371,
506372,
506374,
506375,
506411,
506412,
506413,
506443,
506445,
506446,
506473,
506493,
506494,
506553,
506554,
506567,
506568,
506591,
506619,
506625,
506626,
506638,
506639,
506647,
506648,
506652,
506654,
506671,
506672,
506674,
506684,
506710,
506724,
506750,
506774,
506775,
506777,
506778,
506792,
506798,
506799,
506815,
506817,
506835,
506836,
506842,
506843,
506894,
506908,
506916,
506917,
506922,
506929,
506930,
507042,
507075,
507076,
507114
)



/*BUSCA AVERBA��O PARA FATURAMENTO*/
SELECT TRAP.SEQ_NUMER_AVB, TRAP.SEQ_NUMER_PRS, TA.NUM_AVERB_PAM, TA.COD_CNPJ_TOMADOR, (SELECT NOM_PESSO FROM PAMAIS.TCRP_PESSOA WHERE COD_DOCUM_PRI = TA.COD_CNPJ_TOMADOR) AS TOMADOR 
FROM BILHET.TBIL_RELAC_AVERB_PROPT trap
, BILHET.TBIL_AVERBACAO ta 
WHERE TA.SEQ_NUMER_AVB = TRAP.SEQ_NUMER_AVB
--AND TA.COD_CNPj_TOMADOR IS NOT NULL 
AND TRAP.SEQ_NUMER_PRS = 505036
AND TRAP.SEQ_NUMER_FAT = 7000287308



