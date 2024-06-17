select * from bilhet.tbil_vigencia_proposta_credb
--where seq_credb_prs = 15044
order by dat_fim_vig desc


select * from bilhet.tbil_proposta_credito_debito
where seq_numer_prs = 495496


select * from bilhet.TBIL_VIGENCIA_PROPOSTA_CREDB 
where DAT_INICI_VIG >= '2020-10-01' and DAT_FIM_VIG = '2020-10-30';

select * from bilhet.TBIL_VIGENCIA_PROPOSTA_CREDB 
where DAT_INICI_VIG = '2020-10-01' and DAT_FIM_VIG <= '2020-10-31';


/*UPDATE DEBITO CREDITO*/
update bilhet.TBIL_VIGENCIA_PROPOSTA_CREDB 
  set DAT_INICI_VIG = '2020-10-01'
    , DAT_FIM_VIG = '2020-10-31' 
where DAT_INICI_VIG = '2020-10-01' and DAT_FIM_VIG = '2020-10-30';

COMMIT