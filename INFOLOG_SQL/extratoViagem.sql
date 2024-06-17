select h.num_termn, v.num_placa, to_char(dhr_event,'DD/MM/YYYY HH24:MI') AS dhr_event,
des_event, pt.des_prove_tec, h.tip_event_ter, tp.sig_parad, h.num_latit, h.num_longi
from hist_log_monitora_terminal h, provedor_tecnologia pt, tipo_parada tp, relac_veiculo_dispo_plano rvdp, veiculo v
where h.ctl_plvia = 1264532
and h.ctl_plvia = rvdp.ctl_plvia
and v.ctl_veicu = rvdp.ctl_plvia
and pt.ctl_prove_tec = h.ctl_prove_tec
and tp.ctl_parad = tip_event_ter

select * from usuario_internet
where usr_name like 'PAMCARY.PAMCARY'

select * from atividade
WHERE cod_ativi IN (7, 9, 10, 11, 13)


select * from relac_veiculo_dispo_plano
select * from veiculo
select * from hist_log_monitora_terminal
order by dhr_event desc
where ctl_plvia is not null

select * from provedor_tecnologia

select * from tipo_parada



select * from dispositivo
where cod_dispo_rst like '%10260%'
and ctl_prove_tec = 14


select * from relac_veiculo_dispositivo r, veiculo v, dispositivo d
where d.cod_dispo_rst like '%1033'
and v.ctl_veicu = r.ctl_veicu
and d.ctl_dispo_rst = r.ctl_dispo_rst




select * from plano_controle p, veiculo v 
where v.ctl_veicu = p.ctl_veicu
and v.ctl_veicu = p.ctl_carre
and v.num_placa = 'JXB4390'


select * from plano_controle where ctl_carre = 157586 order by ctl_plano_ctl desc

10092,
10123,
10260,10298,10307,1033,
26045,26707,
26729,
35829,
42425,
42428,
43707,
44049,
44166,
44252,
44272,
44275,
44279,
45640,
49680,
55690,
56376,
56385,
56914,
7156,
7162,
7204,
7214,7216,

select * from posicao_dispositivo_veiculo

select * from veiculo
where num_placa = 'MCK9271'

select * from dispositivo 
where ctl_dispo_rst = 1596

update dispositivo set 
ctl_model_dio = null
where ctl_dispo_rst = 1596


select * from relac_veiculo_dispo_plano
where ctl_veicu = 107838
order by ctl_plvia desc

select * from relac_veiculo_dispositivo
where ctl_veicu = 107838

select * from monitora_terminal
where num_termn = 501817
order by dhr_event desc


select * from dispositivo
where ctl_model_dio is not null
and ctl_prove_tec not in (2,14)


select * from dispositivo
where cod_dispo_rst = '15768'
and ctl_prove_tec = 3

1596
90262



1707308



select * from plano_viagem
order by ctl_plvia desc





select * from autotrac_evento
select * from hist_log_monitora_terminal
where ctl_plvia is not null


select * from atividade


SELECT H.num_seque_ter, H.num_termn AS num_termn, V.num_placa AS num_placa, H.dhr_event AS dhr_event,            
des_event AS des_event, PT.des_prove_tec AS des_prove_tec, H.tip_event_ter AS tip_event_ter,             
TP.sig_parad AS sig_parad, H.num_latit AS num_latit, H.num_longi AS num_longi           
FROM HIST_LOG_MONITORA_TERMINAL H, PROVEDOR_TECNOLOGIA PT, TIPO_PARADA TP,             
RELAC_VEICULO_DISPO_PLANO RVDP, VEICULO V                      
WHERE H.ctl_plvia =1286964       
AND H.ctl_plvia = RVDP.ctl_plvia        
AND V.ctl_veicu = RVDP.ctl_VEICU        
AND PT.ctl_prove_tec = H.ctl_prove_tec        
AND TP.ctl_parad = H.tip_event_ter 
order by dhr_event desc 




select v.ctl_veicu as ctlVeicu, v.ctl_model as ctlModel, uf.cod_unfed as codUnfed, uf.sig_unfed as estadoVeiculo, p.cod_praca as codPraca, 
p.des_praca as cidadeVeiculo, v.num_renav as renavam, ma.des_marca as desMarca, ma.ctl_marca as ctlMarca,
tv.ctl_veicu_tip as ctlVeiculoTipo, tv.des_veicu_tip as tipoVeiculo, gv.ctl_gener as ctlGenero, gv.des_gener as generoVeiculo, 
mv.des_model as modeloVeiculo, v.qtd_eixo as eixos, 
v.des_veicu_cor as corVeiculo, v.ano_veicu as anoVeiculo, NVL(dv.cod_docum, ' ') as documento, 
v.ctl_trnsp as ctlTrnsp, NVL(fc_vinculado_nom_guerr(v.ctl_trnsp), ' ') as razaoSocial,NVL(dv.tip_docum, '0') as tipoDocumento, 
NVL(TO_CHAR(apv.dhr_toler, 'hh24:mi'), '0') as toleranciaProprietario,  
pav.ctl_vincd as ctlVincdOperacao, NVL(fc_vinculado_nom_guerr(pav.ctl_vincd), ' ') AS desOperacao, 
pav.ctl_vincd_rld as ctlVincdRldOperacao, NVL(fc_vinculado_nom_guerr(pav.ctl_vincd_rld), ' ') AS desEntidade,
NVL(TO_CHAR(pav.dhr_toler, 'hh24:mi'), '0') AS toleranciaOperacao
from veiculo v, praca p, unidade_federal uf, modelo_veiculo mv, genero_veiculo gv, tipo_veiculo tv, doc_vinculado dv,
vinculado vi, alerta_proprietario_veiculo apv, perfil_alerta_veiculo pav, marca_veiculo ma
where 1 = 1
and v.num_placa = 'DAN7127'
and v.cod_praca = p.cod_praca
and p.cod_unfed = uf.cod_unfed
and v.ctl_model = mv.ctl_model
and mv.ctl_gener = gv.ctl_gener
and ma.ctl_marca = mv.ctl_marca
and gv.ctl_veicu_tip = tv.ctl_veicu_tip
and v.ctl_trnsp = dv.ctl_vincd(+)
and dv.ctl_vincd = vi.ctl_vincd(+)
and v.ctl_veicu = apv.ctl_veicu(+)
and v.ctl_veicu = pav.ctl_veicu(+)