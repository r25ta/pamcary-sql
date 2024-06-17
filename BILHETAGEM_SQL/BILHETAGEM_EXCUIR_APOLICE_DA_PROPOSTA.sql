/*DESVINCULANDO APOLICE DA PROPOSTA*/

select * from bilhet.tbil_proposta
where seq_numer_prs = 500541

update bilhet.tbil_proposta 
set num_apoli = 0
where seq_numer_prs = 500541
commit

