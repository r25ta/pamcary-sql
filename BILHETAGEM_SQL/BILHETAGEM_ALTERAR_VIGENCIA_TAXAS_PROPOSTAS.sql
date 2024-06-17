select * from bilhet.tbil_proposta
where seq_numer_prs = 503978

COMMIT 


select * from bilhet.TBIL_VIGENCIA_TAXA_CLIENTE tvtc  
where NUM_SEQUE_TAR in (
select NUM_SEQUE_TAR  from bilhet.TBIL_RELAC_TAXA_PROPOSTA trtp 
where seq_numer_prs = 505976
)


update bilhet.TBIL_VIGENCIA_TAXA_CLIENTE set
DAT_fim_VIG = '2023-02-28'
where NUM_SEQUE_VIG in (
1210529
)

COMMIT 