select num_mct, cod_macro_ult, to_char(dhr_posic,'dd/mm/yyyy hh24:mi:ss') AS dhr_posic,
to_char(dhr_inici_rea,'dd/mm/yyyy hh24:mi:ss') as dhr_inici_rea, to_char(dhr_termi_rea,'dd/mm/yyyy hh24:mi:ss') as dhr_termi_rea
from posicao_id_terminal
order by dhr_inici_rea desc
