/*TERM X MACRO 62*/
select num_termn, count(1) from log_monitora_terminal
where cod_docum_trd = '003172874003210'
and to_char(dhr_alter,'yyyymmddhh24miss')  between '20070117000001' and '20070117235959'
and tip_event_ter = 62
group by num_termn
having count(1) > 1

/*TERM X PLANO VIAGEM*/
select vpv.num_mct, count(1)
from veiculO_plano_viagem vpv, plano_viagem p,veiculo v, modelo_veiculo mv, genero_veiculo gv
where p.ctl_plvia = vpv.ctl_plvia
and p.ctl_trnsp = 279856
and p.sit_plvia <> 10
and vpv.cod_user = 'COMUNICADOR'
and to_char(vpv.dhr_manut,'yyyymmddhh24miss') between '20070117000001' and '20070117235959'
and v.ctl_veicu = vpv.ctl_veicu
and mv.ctl_model = v.ctl_model
and mv.ctl_gener = gv.ctl_gener
and gv.ctl_veicu_tip <> 4
group by vpv.num_mct
having count(1) > 1


SELECT V.CTL_PLVIA,p.sit_plvia FROM VEICULO_PLANO_VIAGEM V, PLANO_VIAGEM P
WHERE P.CTL_PLVIA = V.CTL_PLVIA
AND V.NUM_MCT =819337
ORDER BY V.CTL_PLVIA DESC

AND P.sit_plvia in (2,3,4,9,12,8)
ORDER BY V.CTL_PLVIA DESC

SELECT FC_VINCULADO_NOM_GUERR(CTL_PTOPD),CTL_PTOPD,CTL_PARAD,ORD_DESTI,
to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss'), R.*
FROM ROTEIRO_MOTORISTA R
WHERE CTL_PLVIA = 1023920
ORDER BY NUM_SEQUE

SELECT * FROM DESTINATARIO_PLANO_VIAGEM
WHERE CTL_PLVIA = 1023920
ORDER BY ORD_DESTI



SELECT * FROM PLANO_VIAGEM
WHERE CTL_PLVIA =1023920
 

 select * from veiculo_plano_viagem
WHERE CTL_PLVIA =1023920

 
select d.ctl_plvia, p.sit_plvia
from destinatario_plano_viagem d, plano_viagem p
Where p.ctl_plvia = d.ctl_plvia
and p.sit_plvia not in (0,1,10)
and d.sit_plvia = 1
and p.ctl_opera_tip = 20 
and NOM_USER_INC = 'COMUNICADOR'
