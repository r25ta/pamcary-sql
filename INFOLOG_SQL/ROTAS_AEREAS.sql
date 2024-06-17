SELECT ir.ctl_rota_gri, ir.nom_rota, FC_VINCULADO_NOM_GUERR(ir.ctl_vincd_ori) AS ORIGEM, ori.cod_docum, tdori.des_tipo_doc, 
FC_VINCULADO_ENDERECO_PRACA(ir.ctl_vincd_ori,1) AS PRACA_ORIGEM,
FC_VINCULADO_ENDERECO_SIGLAUF(ir.ctl_vincd_ori,1) AS UF_ORIGEM, 
FC_VINCULADO_NOM_GUERR(ir.ctl_vincd_des) AS DESTINO, des.cod_docum, tddes.des_tipo_doc, 
FC_VINCULADO_ENDERECO_PRACA(ir.ctl_vincd_des,1) AS PRACA_DESTINO,
FC_VINCULADO_ENDERECO_SIGLAUF(ir.ctl_vincd_des,1) AS UF_DESTINO, 
ir.cod_user AS USR_INCLUSAO, TO_CHAR(ir.dhr_alter,'DD/MM/YYYY HH24:MI:SS') AS DHR_INCLUSAO
FROM INF_ROTA ir, DOC_VINCULADO ori, DOC_VINCULADO des, TIPO_DOCUMENTO tdori, TIPO_DOCUMENTO tddes
where ir.ctl_vincd_ori = ori.ctl_vincd
and ir.ctl_vincd_des = des.ctl_vincd
and ori.tip_docum = tdori.tip_docum
and des.tip_docum = tddes.TIP_DOCUM
and ir.ctl_opera_tip = 20
and ir.sta_ativo = 'S'
and ir.nom_rota not like 'AUT - %'
and des_coord_rot like '%COORDENADAS%'
ORDER BY DHR_INCLUSAO DESC


select * from acesso_internet
order by dhr_acess desc