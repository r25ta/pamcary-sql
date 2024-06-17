select 
	v.*
from
	painel.v_ods_gp_sinistro_completo v
where
	((v.grupo_evento in ('Acidente', 'Acidente Ambiental', 'Roubo', 'Forte Suspeita')
		and v.dhr_termino_atendimento is null )
	or
		(v.grupo_evento = 'Forte Suspeita' and v.data_hora_evento >= NOW() - interval '24 HOURS'))
	and v.tipo_cliente in ('Segurado', 'Usuario', 'Estatistico')
	and date(data_hora_evento) > '2020-09-26'

select (NOW() - interval '24 HOURS') as x, a.* from painel.v_ods_gp_sinistro_completo a
where a.data_hora_evento >= NOW() - interval '24 HOURS'


select distinct grupo_evento --v.processo , v.grupo_evento , v.evento, v.ramo  
--	,v.* 
	from painel.v_ods_gp_sinistro_completo v 
where v.processo in (454396,455184, 455475)


select * from usuario_internet
where usr_name like 'TORRECONTROLE.PAMCA%'

