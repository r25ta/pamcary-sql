select *
from painel.v_ods_gp_sinistro_mapa vogsm 
where processo in (
463733
,463766
,463774
,463778
,463783
,463792
,463795
,463797
,463802
,463803
,463814
,463815
,463818
) 


select * 
from painel.v_ods_gp_sinistro_painel vogsp 
where processo in (
463733
,463766
,463774
,463778
,463783
,463792
,463795
,463797
,463802
,463803
,463814
,463815
,463818
) 

select * from painel.v_ods_gp_sinistro_completo vogsc 
where processo in
(
463733
,463766
,463774
,463778
,463783
,463792
,463795
,463797
,463802
,463803
,463814
,463815
,463818

) 




SELECT v.* FROM painel.v_ods_gp_sinistro_completo v 
                                               WHERE (
                                                               (v.grupo_evento IN ('Acidente', 'Acidente Ambiental','Roubo', 'Forte Suspeita') AND v.dhr_termino_atendimento IS NULL ) 
                                                               OR 
                                                               (v.grupo_evento = 'Forte Suspeita' AND v.data_hora_evento >= NOW() - INTERVAL '24 HOURS')
                                               ) 
                                               AND v.tipo_cliente IN ('Segurado','Usuario','Estatistico') 
                                               AND date(data_hora_evento) > '2020-04-01'

                                               
SELECT COUNT(*) AS contador FROM painel.v_ods_gp_sinistro_completo v
			WHERE v.evento IN ('Abalroamento', 'Colisao', 'Tombamento', 'Capotagem', 'Incendio', 'Explosao')
			AND v.data_evento >= current_date - INTERVAL '30 DAYS'                                               