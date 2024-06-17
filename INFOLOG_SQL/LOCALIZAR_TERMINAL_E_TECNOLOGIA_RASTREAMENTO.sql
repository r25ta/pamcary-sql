select * from inf_dispositivo
where cod_dispo_rst = '295399'

select e.cod_dispo_rst, b.nom_fants, c.sta_ativo, d.cod_placa, a.* 
from inf_relac_prove_rastr_dispo a, 
    v_crp_provedor_tecnologia b, 
    inf_relac_veicu_dispo c, 
    v_crp_veiculo d,
    inf_dispositivo e
where b.ctl_prove_ten = a.ctl_prove_ten
and a.ctl_dispo_rst = c.ctl_dispo_rst
and d.ctl_veicu = c.ctl_veicu
and e.ctl_dispo_rst = a.ctl_dispo_rst
and a.ctl_dispo_rst in (488494,631013,631014)
order by cod_placa


select * from monitora_plano_viagem
where num_placa is null

ctl_plvia = 11284973
and num_placa is null

select * from v_crp_veiculo

select * from inf_relac_dispo_plano_viagem
where ctl_plvia = 11284973