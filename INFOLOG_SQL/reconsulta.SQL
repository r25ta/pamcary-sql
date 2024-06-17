select
fc_vinculado_nom_guerr(ctl_embar) Embarcador,
fc_vinculado_nom_guerr(ctl_trnsp) Transportadora, cpf,
motorista, placa_veiculo, placa_carreta, pamcard
from consulta
where to_char(data_cons,'yyyymmdd') = '20030122'
and ctl_embar is not null and
ctl_trnsp is not null
order by embarcador, transportadora  


SELECT * FROM CONSULTA
