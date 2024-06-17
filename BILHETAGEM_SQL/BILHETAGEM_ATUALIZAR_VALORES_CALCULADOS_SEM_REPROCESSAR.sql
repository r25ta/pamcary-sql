/*RECUPERA OS VALORES CALCULADOS POR TIPO DE TARIFA*/
select a.nom_tarif, b.* 
from bilhet.tbil_tipo_tarifa_proposta a,
     bilhet.tbil_valor_soma_tipo_tarifa b 
where a.num_tarif = b.num_tarif 
and b.seq_numer_fat = 7000176163
and b.num_tarif in (63,68)


/************************************
ATUALIZAR IOF 
      DE and vlr_calcu = 187390560.0000
      PARA vlr_calcu = 1152.45 
************************************/
update bilhet.tbil_valor_soma_tipo_tarifa set
vlr_calcu = 1152.45
where seq_numer_fat = 7000176163
and num_tarif = 63
--and vlr_calcu = 187390560.0000


/************************************
ATUALIZAR PREMIO TOTAL 
   DE and vlr_calcu =187406175.8800 
                PARA and vlr_calcu = 16768.33
*************************************/

update bilhet.tbil_valor_soma_tipo_tarifa set
vlr_calcu = 16768.33
where seq_numer_fat = 7000176163
and num_tarif = 68
--and vlr_calcu = 187406175.8800

COMMIT


select * from bilhet.tbil_fatura
where seq_numer_fat = 7000176163