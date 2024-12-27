commit

SELECT * FROM bilhet.tbil_averbacao
WHERE num_averb_pam = 927163165

DELETE FROM bilhet.tbil_averbacao
WHERE num_averb_pam = 925424154

SELECT * FROM bilhet.TBIL_AVERBACAO_INDICE tai 
WHERE num_averb_pam = 925424154

DELETE FROM bilhet.TBIL_AVERBACAO_INDICE tai 
WHERE num_averb_pam = 925424154

SELECT * FROM bilhet.TBIL_RELAC_AVERB_PROPT
where seq_numer_avb = 1240908563



DELETE FROM bilhet.TBIL_RELAC_AVERB_PROPT
where seq_numer_avb = 1240908563

SELECT * FROM bilhet.TBIL_PROPOSTA tp 
WHERE SEQ_NUMER_PRS IN (506376,506377)



SELECT * FROM PAMAIS.crp_pessoa
WHERE ctl_pesso = 15141