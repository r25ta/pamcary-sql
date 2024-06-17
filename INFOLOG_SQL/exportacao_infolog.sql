/*INFORMAÇÕES DA VIAGEM*/
SELECT 
pv.ctl_plvia as viagem,
tv.des_viage_tip as tipo_viagem,
pv.tip_opera_vie as tip_rast,
tov.des_opera_vie,
mpv.des_model_plv AS imagem,
dv.cod_docum as doc_trnsp,
FC_VINCULADO_NOM_GUERR(pv.ctl_trnsp) as trnsp,
TO_CHAR(mt.dhr_event,'DD/MM/YYYY HH24:MI') AS dhr_ult_posic,
mt.des_event AS des_ult_posic,
mt.num_latit AS latitude,
mt.num_longi AS longitude,
mt.idt_ignic_vei AS ignicao,
pv.obs_plvia,
TO_CHAR(pv.dhr_inclu,'DD/MM/YYYY HH24:MI') AS dhr_inclusao,
spv.des_situa AS situacao_viagem

FROM PLANO_VIAGEM pv, 
     TIPO_OPERACAO_VIAGEM tov, 
     TIPO_VIAGEM tv,
     MODELO_PLANO_VIAGEM mpv,
     DOC_VINCULADO dv, 
     MONITORA_TERMINAL mt,
     SITUACAO_PLANO_VIAGEM spv
WHERE tov.tip_opera_vie = pv.tip_opera_vie
AND tv.tip_viage(+) = pv.tip_viage
AND mpv.ctl_model_plv(+) = pv.ctl_model_plv
AND dv.ctl_vincd(+) = pv.ctl_trnsp
AND pv.ctl_plvia = mt.ctl_plvia(+)
AND spv.sit_plvia = pv.sit_plvia
AND pv.ctl_plvia = 1354974

select * from situacao_plano_viagem
select * from provedor_tecnologia
select * from monitora_terminal
select * from plano_viagem
select * from modelo_plano_viagem
select * from tipo_documento_fiscal
SELECT * FROM RELAC_PLVIA_DOCUMENTO
SELECT * FROM DOCUMENTO_FISCAL_CLIENTE

/*VEICULO(S)*/
SELECT v.num_placa as placa, NVL(d.cod_dispo_rst,'0') as terminal, vpv.ord_veicu
FROM VEICULO v, VEICULO_PLANO_VIAGEM vpv, RELAC_VEICULO_DISPOSITIVO rvd, DISPOSITIVO d, TIPO_OPERACAO_VIAGEM tov
WHERE v.ctl_veicu = vpv.ctl_veicu
AND d.ctl_dispo_rst = rvd.ctl_dispo_rst
AND v.ctl_veicu = rvd.ctl_veicu
AND tov.tip_opera_vie = pv.tip_opera_vie
--AND rvd.sta_ativo = 'S'
AND vpv.ctl_plvia = 1354974
order by ord_veicu

/*MOTORISTA(S)*/
SELECT mpv.ctl_plvia,FC_VINCULADO_NOM_GUERR(mpv.ctl_motot) AS motorista, dv.cod_docum, tm.des_motot_tip 
FROM MOTORISTA_PLANO_VIAGEM mpv, TIPO_MOTORISTA tm, DOC_VINCULADO dv
WHERE dv.ctl_vincd = mpv.ctl_motot
AND tm.tip_motot = mpv.tip_motot
AND mpv.ctl_plvia = 1328686


/*ORIGEM DA VIAGEM*/
SELECT rm.ord_desti, 
       dv.cod_docum, 
       fc_vinculado_nom_guerr(rm.ctl_ptopd), 
       to_char(dhr_previ_sis,'DD/MM/YYYY HH24:MI') AS previsao, 
       to_char(dhr_efeti_rea,'DD/MM/YYYY HH24:MI') AS real
FROM ROTEIRO_MOTORISTA rm, DOC_VINCULADO dv
WHERE dv.ctl_vincd = rm.ctl_ptopd
AND rm.ctl_parad = 10
AND rm.ord_desti = 0
AND rm.ctl_plvia=1354974
       
/*DESTINO(S) DA VIAGEM*/
SELECT dv1.cod_docum AS cnpj_destino,
       FC_VINCULADO_NOM_GUERR(dpv.ctl_desti) AS destino,
       dv2.cod_docum AS cnpj_consignatario,
       FC_VINCULADO_NOM_GUERR(dpv.num_consi_mer) AS consignatario,
       sig_ordem_eve AS tipo_evento,
       to_char(rm.dhr_previ_sis,'DD/MM/YYYY HH24:MI') AS previsao, 
       to_char(rm.dhr_efeti_rea,'DD/MM/YYYY HH24:MI') AS real,
       rm.ctl_parad,
       tp.des_parad,
       num_seque
FROM DESTINATARIO_PLANO_VIAGEM dpv, ROTEIRO_MOTORISTA rm, TIPO_PARADA tp, DOC_VINCULADO dv1, DOC_VINCULADO dv2
WHERE rm.ctl_plvia = dpv.ctl_plvia
AND rm.ord_desti > 0
AND tp.ctl_parad = rm.ctl_parad
AND dv1.ctl_vincd = dpv.ctl_desti
AND dv2.ctl_vincd = dpv.num_consi_mer
AND rm.ctl_plvia=1354974

select * from destinatario_plano_viagem
where ctl_plvia = 1354974

select * from roteiro_motorista
where ctl_plvia = 1354974




select * from motorista_plano_viagem
select * from tipo_motorista
select * from tipo_viagem
select * from tipo_operacao_viagem
SELECT * FROM RELAC_VEICULO_DISPOSITIVO

SELECT * FROM VEICULO_PLANO_VIAGEM
ctl_plvia = 1354974

select * from plano_viagem
WHERE ctl_plvia = 1354974