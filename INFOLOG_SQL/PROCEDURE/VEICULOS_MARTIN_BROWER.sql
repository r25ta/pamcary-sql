select a.num_termn as id_terminal
	,a.num_placa_trd
	,to_char(a.dhr_event,'dd/mm/yyyy hh24:mi') as data_hora
	,a.num_latit as latitude
	,a.num_longi as longitude
	,a.des_event as des_posicao
	,a.num_faixa_tem as temperatura
	,a.idt_ignic_vei as ignicao
	,a.num_veloc	
from supervisor.thist_log_monitora_terminal a
, supervisor.tinf_dispositivo b
--, pamais_prd.tcrp_veiculo c
--, supervisor.tinf_relac_veicu_dispo d
where a.num_termn b.cod_dispo_rst 
--and b.ctl_dispo_rst = d.ctl_dispo_rst
--and c.ctl_veicu = d.ctl_veicu
and a.dhr_event between '2023-06-01 00:00:00' and '2023-06-30 23:59:59'



select * from supervisor.tinf_relac_prove_rastr_dispo trprd 
select * from supervisor.tinf_dispositivo td 
select * from supervisor.tinf_relac_veicu_dispo trvd  
select * from supervisor.tinf_dispositivo td 

select * from supervisor.tmonitora_terminal tt 

select 
	d.num_termn as id_terminal
	,c.cod_placa
	,to_char(d.dhr_event,'dd/mm/yyyy hh24:mi') as data_hora
	,d.num_latit as latitude
	,d.num_longi as longitude
	,d.des_event as des_posicao
	,d.num_faixa_tem as temperatura
	,d.idt_ignic_vei as ignicao
	,d.num_veloc
from supervisor.tinf_relac_veicu_dispo a
			, supervisor.tinf_dispositivo b
			, pamais_prd.tcrp_veiculo c
			, supervisor.thist_log_monitora_terminal d
where (b.cod_dispo_rst::bigint =  d.num_termn) 
and c.ctl_veicu = a.ctl_veicu  
and a.ctl_dispo_rst = b.ctl_dispo_rst 
and a.ctl_veicu in (
select ctl_veicu from pamais_prd.tcrp_veiculo tv 
where cod_placa IN ('GKD3099',
'FLZ6511',
'FSL0211',
'GJB3918',
'GHT5623',
'GHL9662',
'GGK9539',
'GFS7783',
'GDV7828',
'GBX5441',
'FSU7303',
'FLZ6513',
'FJS4851',
'GBU6852',
'FLZ6554',
'GAJ1875',
'FZR9632',
'FYR6078',
'FVC2616',
'FTF3696',
'FPW3104',
'FPC6577',
'FOV7360',
'FOI2796',
'FAQ4689',
'EMU3979',
'EMU3982',
'EKH9390',
'FDB5041',
'EKH9392',
'EKH9283',
'EKH9384',
'CVP9225',
'EKH9387',
'EKH9395',
'EKH9393',
'EKH9396',
'EKH9391',
'EKH9405',
'EKH9414',
'EKH9274',
'EKH9385',
'EKH9386',
'EKH9398',
'EKH9404',
'EKH9408',
'EKH9410',
'EKH9413',
'EKH9417',
'EKH9419',
'EKH9420',
'EKH9421',
'EKH9422',
'EKH9426',
'FCP8602',
'FDB5046',
'FDB5052',
'FDB5056',
'FDB5065',
'FDB5066',
'FLZ6514',
'FLZ6516',
'FLZ6522',
'FLZ6524',
'FLZ6526',
'FLZ6532',
'FLZ6534',
'FLZ6546',
'FQP1466',
'FQX2815',
'FRG3571',
'FRG8399',
'FRP4801',
'FSD8186',
'FSJ4910',
'FSJ8793',
'FUB8577',
'GEK3350',
'GCQ5978',
'GDX9434',
'GEX6017',
'GGR6193',
'GAH5251',
'GIH3749',
'EKH9264',
'FWB1961',
'EKH9241',
'EKH9244',
'EKH8224',
'EKH9252',
'EGJ8737',
'EKH9242',
'EKH9256',
'EKH8231',
'EKH8225',
'EKH9257',
'EKH7436',
'GFQ1635',
'EKH9269',
'EKH8222',
'EKH8227',
'EKH7430',
'GFM2799',
'CVP9001',
'CVP9281',
'FSV6221',
'CVP8942',
'CVP8513',
'EKH7433',
'EMU4003',
'CVP9274',
'CVP8514',
'EKH7425',
'CVP8515',
'EKH7426',
'CVP8516',
'EGJ8727',
'EKH7427',
'EMU3977',
'CVP9257',
'EGJ8728',
'EKH7428',
'CVP8978',
'EGJ7719',
'EKH7429',
'EGJ8729',
'EMU4002',
'FLZ6542',
'FLZ6544',
'FZO4A86',
'GAI4D75',
'FRL0I24',
'FON2G16',
'FRI7551',
'FRI5305',
'FPS6736',
'EKH9279',
'FTU8739',
'DKH2I24',
'FYH7F91',
'GFD7G21',
'GJT4J11',
'FYQ4G12',
'GBY4I93',
'GGP1E16',
'FYB5A84',
'GGV6F64',
'FZU3D71',
'ELY0D63',
'FWR7E31',
'FVZ6B01',
'GAJ4E65',
'FUC6A23',
'FRK9I36',
'DEI9F75',
'FUF5E46',
'GFU6E12',
'FKE9545',
'RHW4J88',
'RHW4H82' )
)
and d.dhr_event between '2023-06-01 00:00:00' and '2023-06-30 23:59:59'
 
