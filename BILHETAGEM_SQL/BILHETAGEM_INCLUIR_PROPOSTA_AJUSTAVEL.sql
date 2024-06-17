/*IDENTIFICAR O SEQ_NUMER_PRS ATRAV�S DO NUMERO DA APOLICE
* CASO A PROPOSTA RETORNE MAIS DE UM REGISTRO, CONFIRMAR O CNPJ DO CLIENTE PARA RECUPERAR O REGISTRO CORRETO
*/
select * from bilhet.tbil_proposta
WHERE --SEQ_NUMER_PRS = 508250
num_apoli in ( 1005400013648, 1005500006920 )


/*VERIFICAR CLIENTE*/
select * from pamais.v_crp_pessoa
where ctl_pesso = 1152418


/*CONSULTAR SE EXISTE SEQ_NUMER_PRS AJUSTAVEL*/
select pa.SEQ_NUMER_PRS
, tp.NUM_APOLI
,pa.NUM_PERIO
,pa.QTD_PARCE_SEG 
,pa.VLR_PREMI_FIX 
from bilhet.tbil_proposta_ajustavel pa 
INNER JOIN bilhet.TBIL_PROPOSTA tp 
	ON tp.SEQ_NUMER_PRS = pa.SEQ_NUMER_PRS 
where pa.seq_numer_prs in ( 509312,509313 )

/*INSERT NA PROPOSTA AJUSTAVEL UTILIZANDO O SEQ_NUMER_PRS DA APOLICE*/
insert into bilhet.tbil_proposta_ajustavel values (
509312,
3,
10,
0.0000,
current timestamp )


commit

SELECT * FROM bilhet.TBIL_PERIODO tp 