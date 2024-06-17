select * from aviso_embarque
where sit_envio = 0

select ctl_plvia, ctl_desti, to_char(dhr_plvia_ter,'dd/mm/yyyy hh24:mi:ss') AS dhr_plvia_ter, ord_desti
from destinatario_plano_viagem
where ctl_plvia = 279675
order by ord_desti

SELECT ctl_desti FROM DESTINATARIO_PLANO_VIAGEM WHERE ctl_plvia = 279675 AND ctl_desti = 50803


select * from analise_plano_viagem
where ctl_plvia = 279675



select ctl_plvia, ctl_rtmot, ctl_parad, to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss')
from  roteiro_motorista
where ctl_plvia = 279675
