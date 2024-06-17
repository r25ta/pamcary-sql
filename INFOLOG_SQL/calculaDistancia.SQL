
select V.ctl_vincd, V.nom_guerr, EV.des_latit, EV.des_longi from endereco_vinculado EV, vinculado V
where V.ctl_vincd = EV.ctl_vincd
AND EV.des_latit is not null

select round(fc_distancia(12107,233251,463810),2) from dual
