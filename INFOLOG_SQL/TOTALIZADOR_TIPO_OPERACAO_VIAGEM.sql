/*TOTALIZADOR DE VIAGENS UNILEVER POR TIPO OPERACAO VIAGEM*/
select to_char(pv.dhr_inclu,'yyyy-mm') MES_INCLUSAO, 
       spv.des_opera_vie TOV ,
       count(pv.ctl_plvia) TOTAL
from plano_viagem pv, 
    tipo_operacao_viagem spv
where pv.ctl_opera_tip = 20
and spv.tip_opera_vie = pv.tip_opera_vie
group by to_char(pv.dhr_inclu,'yyyy-mm'), spv.des_opera_vie
order by to_char(pv.dhr_inclu,'yyyy-mm');