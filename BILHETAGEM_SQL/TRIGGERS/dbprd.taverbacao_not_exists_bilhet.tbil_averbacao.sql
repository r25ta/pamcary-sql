SELECT a.CTL_AVERB AS averbacao
	, b.NUM_PROPT AS proposta
	,(SELECT COD_DOCUM  FROM DOC_VINCULADO WHERE CTL_VINCD = b.CTL_VINCD_SED) AS documento
	,(SELECT NOM_VINCD FROM VINCULADO  WHERE CTL_VINCD  = b.CTL_VINCD_SED) AS nome
	, b.SIT_AVERB 
	,(SELECT des_situa_avb FROM TSITUACAO_AVERBACAO WHERE sit_averb = b.SIT_AVERB)
	, b.SIT_TRANS
	,(SELECT des_situa_trm FROM TSITUACAO_TRANSM WHERE sit_trans = b.SIT_TRANS)
	, c.TIP_ISENC_SEG 
	, (SELECT des_isenc_seg FROM TTIPO_ISENCAO_SEG WHERE tip_isenc_seg = c.TIP_ISENC_SEG)
	, a.DHR_AVERB 
	, a.DHR_ENTRA 
	, a.DHR_LIBER 
	, a.DHR_ALTER
	, a.COD_USER 
FROM TAVERBACAO a
, TAVERBACAO_INDICE b
, TITEM_DESTINO c
WHERE a.CTL_AVERB = b.CTL_AVERB
AND a.CTL_AVERB = c.CTL_AVERB 
AND (
	( b.sit_trans   = 0  and  b.sit_averb = 4  ) or
    ( b.sit_trans   = 1  and  b.sit_averb = 4  ) or
	( b.sit_trans   = 0  and  b.sit_averb = 10 ) or
    ( b.sit_trans   = 1  and  b.sit_averb = 10 ) or
	( b.sit_trans   = 0  and  b.sit_averb = 11 ) or
    ( b.sit_trans   = 1  and  b.sit_averb = 11 )
)
AND c.TIP_ISENC_SEG <> 5
AND b.CTL_VINCD_SED NOT IN (2561, 2830, 518946, 500312, 500008, 502211, 505324)
AND a.DHR_AVERB BETWEEN '2022-06-01 00:00:00' AND '2022-06-23 23:59:59'
AND NOT EXISTS (SELECT * FROM BILHET.TBIL_AVERBACAO ta WHERE ta.NUM_AVERB_PAM = a.CTL_AVERB)
