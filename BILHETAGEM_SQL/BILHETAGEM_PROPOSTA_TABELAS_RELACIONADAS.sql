/*LEVANTAMENTO DE TODAS AS TABELAS RELACIONADAS COM PROPOSTA*/

select * from bilhet.tbil_proposta
where seq_numer_prs in (495754,500541)

select * from bilhet.tbil_relac_taxa_proposta
where seq_numer_prs in (495754,500541)


select * from bilhet.tbil_relac_tecnico_proposta
where seq_numer_prs in (495754,500541)

select * from bilhet.tbil_vencimento_fatura_propt
where seq_numer_prs in (495754,500541)

delete bilhet.tbil_vencimento_fatura_propt
where seq_numer_prs = in (495754,500541)

