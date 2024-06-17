select rv.num_placa "Placa Veiculo",v.des_veicu_cor "Cor Veiculo",pt.des_prove_tec "Provedor Tec.",
v.num_mct "ID MCT",
mo.des_model "Modelo", ma.des_marca "Marca", gv.des_gener "Genero", tv.des_veicu_tip "Tipo",
rv.ctl_veicu"Cod Pamcary",rv.num_veicu_ope "Cod Opentech",rv.sta_situa_vei "Status", rv.sta_respl_prc"Resp. Proc.",
to_char(rv.dhr_procs_vei,'dd/mm/yyyy hh24:mm:ss') "Data/Hora atualização",rv.cod_user "Usuário cadstro",
to_char(rv.dhr_alter,'dd/mm/yyyy hh24:mm:ss') "Data/Hora   cadastro"
from ref_veiculo rv, veiculo v, modelo_veiculo mo, marca_veiculo ma, genero_veiculo gv,
tipo_veiculo tv, provedor_tecnologia pt
where rv.sta_situa_vei='E' and rv.sta_respl_prc='O'
and rv.ctl_veicu=v.ctl_veicu and v.ctl_model=mo.ctl_model(+) and mo.ctl_marca=ma.ctl_marca(+)
and mo.ctl_gener=gv.ctl_gener(+) and gv.ctl_veicu_tip=tv.ctl_veicu_tip(+) and
v.ctl_prove_tec=pt.ctl_prove_tec(+)

select * from ref_veiculo rv, v_veiculo vv
where sta_situa_vei='E' and sta_respl_prc='O' and rv.num_placa=vv.num_placa(+)
AND DES_MARCA<>'NAO INFORMADO' AND DES_MODELO<>'NAO INFORMADO'
AND DES_GENERO<>'NAO TEM' AND DES_TIPO_VEICULO<>'NAO INFORMADO'
AND DES_COR_VEICULO<>'*NAO INFORMADA*'
ORDER BY DHR_ALTER DESC

select count(1) from ref_veiculo where sta_situa_vei in ('R') and sta_respl_prc='O'

