  /*LOCALIZAR NA TRBIL_RELAC_VISAO_PROPT NUMERO TARIFA*/ 
   
/*AVERBAÇÕES COM TAXA DE AVARIA*/   
SELECT count(1) FROM BILHET.TBIL_RELAC_VISAO_PROPT a
INNER JOIN bilhet.TBIL_VIGENCIA_TAXA_CLIENTE b 
ON b.NUM_SEQUE_VIG = a.NUM_SEQUE_VIG 
INNER JOIN bilhet.TBIL_RELAC_TAXA_PROPOSTA c 
ON c.NUM_SEQUE_TAR = b.NUM_SEQUE_TAR 
INNER JOIN BILHET.TBIL_RELAC_AVERB_PROPT d 
ON (d.SEQ_NUMER_PRS, d.SEQ_NUMER_AVB ) = ( a.SEQ_NUMER_PRS , a.SEQ_NUMER_AVB )
WHERE a.SEQ_NUMER_PRS = 506895
AND c.NUM_TARIF = 14
AND d.SEQ_NUMER_FAT IS NULL 

/*AVERBAÇÕES COM TAXA DE EMBARCADOR*/
SELECT count(1) FROM BILHET.TBIL_RELAC_VISAO_PROPT a
INNER JOIN bilhet.TBIL_VIGENCIA_TAXA_CLIENTE b 
ON b.NUM_SEQUE_VIG = a.NUM_SEQUE_VIG 
INNER JOIN bilhet.TBIL_RELAC_TAXA_PROPOSTA c 
ON c.NUM_SEQUE_TAR = b.NUM_SEQUE_TAR 
INNER JOIN BILHET.TBIL_RELAC_AVERB_PROPT d 
ON (d.SEQ_NUMER_PRS, d.SEQ_NUMER_AVB ) = ( a.SEQ_NUMER_PRS , a.SEQ_NUMER_AVB )
WHERE a.SEQ_NUMER_PRS = 506895
AND c.NUM_TARIF = 91
AND d.SEQ_NUMER_FAT IS NULL 