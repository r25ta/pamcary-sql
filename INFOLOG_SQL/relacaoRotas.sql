select * from plano_viagem
where ctl_plvia = 877555


select * from destinatario_plano_viagem
where ctl_plvia = 877555



select fc_vinculado_nom_guerr(ctl_ptopd), r.* from roteiro_motorista r
where ctl_plvia = 879215

select * from log_monitora_terminal
where num_termn = 783237
and tip_event_ter <> 99
order by dhr_event desc

select * from endereco_vinculado
where ctl_vincd = 41243

select FC_DISTANCIA_PONTOS_INFOLOG(124022,382015,123722,382151) from dual

select * from unidade_federal
where ctl_vincd = 198433




SELECT r.ctl_rota AS id_rota,
       r.des_rota AS nome_rota,
       rv.ctl_parad AS cod_parada,
       dv.cod_docum AS cnpj_parada,
       v.nom_guerr,
       v.nom_vincd AS nom_completo,
       ev.des_ender AS endereco,
       ev.des_compl_end AS complemento,
       p.num_cep,
       p.des_praca,
       uf.nom_unfed,
       uf.sig_unfed    
FROM ROTA r, ROTEIRO_VIAGEM rv, VINCULADO v, DOC_VINCULADO dv, ENDERECO_VINCULADO ev, PRACA p, UNIDADE_FEDERAL uf 
WHERE r.ctl_opera_tip = 183
AND r.ctl_rota = rv.ctl_rota
AND rv.ctl_ptopd = v.ctl_vincd
AND rv.ctl_ptopd = dv.ctl_vincd
AND rv.ctl_ptopd = ev.ctl_vincd
AND ev.cod_praca = p.cod_praca
AND p.cod_unfed = uf.cod_unfed
ORDER BY id_rota
