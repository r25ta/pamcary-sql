SIT_ENVIO_FAT

1	Processada
2	Conferida
3	Enviada
4	Emitida
5	Cancelada
6	Cancelada após emissão



/* MOVER DO STATUS PARA PROCESSADA */

/* CONSULTAR */
SELECT * from bilhet.TBIL_MOVIM_FATURA
  where  1= 1
--  and NUM_TARIF >= 82
    and SEQ_NUMER_FAT in  (
7000173309
   )

/* DELETAR */
delete from bilhet.TBIL_MOVIM_FATURA
  where NUM_TARIF = 82
    and SEQ_NUMER_FAT in (
7000173309
)

commit

/* CONSULTAR */
select * from bilhet.tbil_fatura
  WHERE 1=1
--  and SIT_ENVIO_FAT = 3 
    and SEQ_NUMER_FAT in (
7000173309
)
order by NOM_ARQUI


/* DE CONFERIDA PARA PROCESSADA */
update bilhet.tbil_fatura set SIT_ENVIO_FAT = 1 , NOM_ARQUI = NULL
  WHERE SIT_ENVIO_FAT = 3 
    and SEQ_NUMER_FAT in (    
7000173309
)

    
    
commit



select * from bilhet.tbil_situacao_envio_fatura
select * from bilhet.tbil_situacao_fatura