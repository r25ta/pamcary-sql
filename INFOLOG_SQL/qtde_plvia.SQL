select count(*), PV.ctl_empre_equ, PV.ctl_opera_tip, TIP.des_opera_tip
from HIST_plano_viagem PV, tipo_operacao TIP
where PV.sit_plvia <> 10
and PV.ctl_opera_tip = TIP.ctl_opera_tip
and to_char(PV.dhr_inclu,'YYYYMMDD') between '20030101' AND '20030131'
group by PV.ctl_empre_equ, PV.ctl_opera_tip, TIP.des_opera_tip

select * from provedor_tecnologia

SELECT * FROM TIPO_OPERACAO
