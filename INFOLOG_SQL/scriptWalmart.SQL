select * from plano_controle
where ctl_plano_ctl = 17475

select e.ctl_plano_ctl, e.num_event_pln, e.ctl_vincd, fc_vinculado_nom_guerr(e.ctl_vincd),
e.ctl_parad, s.sig_parad, to_char(dhr_event,'dd/mm/yyyy hh24:mi') from evento_plano_controle e, tipo_parada s
where ctl_plano_ctl = 17479
and s.ctl_parad = e.ctl_parad

/*SITUACAO PLANO CONTROLE*/
select r.tip_situa, r.sit_plano_ctl, s.des_situa_pln
from relac_plano_controle_situa r, situacao_plano_controle s
where s.sit_plano_ctl = r.sit_plano_ctl
and s.tip_situa = r.tip_situa
and r.ctl_plano_ctl = 17479

select * from plano_viagem
where ctl_plvia = 860999

select max(ctl_plvia) from plano_viagem



select to_char(dhr_event,'dd/mm/yyyy hh24:mi'), e.* from evento_indevido_plano_contr e
where ctl_plano_ctl = 17479
order by dhr_event

select to_char(dhr_event,'dd/mm/yyyy hh24:mi'), e.* from evento_plano_controle e
where ctl_plano_ctl = 17479
order by dhr_event

select * from evento_plano_controle

select sta_procs, to_char(dhr_event,'dd/mm/yyyy hh24:mi:ss'), p.* from posicao_dispositivo p
where ctl_posic_dio in (1012264,1012075,1008956,1008921,997717,994011, 844305,905151,850979,844374)
and num_base_col <> 622
order by num_lote desc


update posicao_dispositivo set
sta_procs='N',
dhr_event = TO_DATE('050820081620','DDMMYYYYHH24MI')
where ctl_posic_dio = 850979



iv - 1008921
ch - 1008956

tc - 1012264
ic -1012075

ch-844374
fv-850979

select * from plano_controle
where ctl_plano_ctl = 17461


SELECT * FROM VEICULO
WHERE CTL_VEICU = 1607




SELECT PC.ctl_plano_ctl AS plano_controle,
       FC_VINCULADO_NOM_GUERR(PC.ctl_vincd) AS unidade_operacao,
       TP.sig_parad AS sigla_evento,
       NVL(PCE.nom_fants,'-') AS nome_doca,
       TO_CHAR(EVPC.dhr_event,'DD/MM/YYYY HH24:MI') AS data_hora_event,
       TO_CHAR(EVPC.dhr_alter,'DD/MM/YYYY HH24:MI') AS data_hora_inc
FROM EVENTO_INDEVIDO_PLANO_CONTR EVPC,
     TIPO_PARADA TP,
     EVENTO_PLANO_CONTROLE PC,
     PONTO_CONTR_ETAPA PCE
WHERE PC.ctl_plano_ctl = 17475
AND PC.ctl_plano_ctl = EVPC.ctl_plano_ctl
AND TP.ctl_parad = EVPC.ctl_parad
AND EVPC.ctl_parad = PC.ctl_parad
AND PCE.ctl_contr_epa(+) = EVPC.ctl_contr_epa
ORDER BY data_hora_event




select * from posicao_dispositivo
where ctl_posic_dio = 991095

update posicao_dispositivo set
ctl_dispo_rst = 1045
where ctl_posic_dio = 987199


SELECT * FROM EVENTO_INDEVIDO_PLANO_VIAGEM

select * from ponto_contr_etapa
where 

ATUALIZAÇÃO TRANSPONDER

ctl_dispo_rst = 1045
ctl_posic_dio = 859288 - ENTRADA - CH código 24

update posicao_dispositivo set
sta_procs='N',
num_contr_epa = 14,
ctl_dispo_rst = 1045,
dhr_event = SYSDATE
where ctl_posic_dio = 991095


SAIDA IV CODIGO 10

update posicao_dispositivo set
sta_procs='N',
num_contr_epa = 14,
ctl_dispo_rst = 1045,
dhr_event = SYSDATE
where ctl_posic_dio = 1008921

update posicao_dispositivo set
sta_procs='N',
num_contr_epa = 14,
ctl_dispo_rst = 1045,
dhr_event = SYSDATE
where ctl_posic_dio = 991325


/*
ATUALIZAÇÃO EVENTO CHEGADA CH

update posicao_dispositivo set
sta_procs='N',
dhr_event = SYSDATE
where ctl_posic_dio = 859288
********************************************************

ATUALIZAÇÃO CONTROLADOR DE ETAPA

ctl_dispo_rst = 1053


ctl_posic_dio = 987199 - PASSAGEM - EU ENTRADA UNIDADE 17 - num_contr_epa = 10

ATUALIZAÇÃO EVENTO ENTRADA UNIDADE EU

update posicao_dispositivo set
sta_procs='N',
num_contr_epa = 14,
dhr_event = SYSDATE
where ctl_posic_dio = 987199

*******************************************************************

ATUALIZAÇÃO CONTROLADOR DE ETAPA

ctl_dispo_rst = 1053


ctl_posic_dio = 991095 - INICIO PERMANENCIA - IC INICIO CARGA 26  - num_contr_epa = 10

ATUALIZAÇÃO EVENTO INICIO DE CARGA IC
update posicao_dispositivo set
sta_procs='N',
num_contr_epa = 14,
dhr_event = SYSDATE
where ctl_posic_dio = 991095

************************************************************************

ATUALIZAÇÃO CONTROLADOR DE ETAPA

ctl_dispo_rst = 1053


ctl_posic_dio = 991325 - FIM PERMANENCIA - TC TERMINO CARGA 20 - num_contr_epa = 10


ATUALIZAÇÃO EVENTO TERMINO DE CARGA TC
update posicao_dispositivo set
sta_procs='N',
num_contr_epa = 14,
ctl_dispo_rst = 1045,
dhr_event = SYSDATE
where ctl_posic_dio = 991325

*************************************************************************

ATUALIZAÇÃO CONTROLADOR DE ETAPA

ctl_dispo_rst = 1053


ctl_posic_dio = 992441 - PASSAGEM - SU SAIDA UNIDADE 18 - num_contr_epa = 10

ATUALIZAÇÃO EVENTO SAIDA UNIDADE SU
update posicao_dispositivo set
sta_procs='N',
dhr_event = SYSDATE
where ctl_posic_dio = 992441




*/

SELECT distinct(d.ctl_dispo_rst)
FROM veiculo v, dispositivo d, relac_veiculo_dispositivo r, modelo_dispositivo m,
      doc_vinculado dv, perfil_alerta_veiculo p
 WHERE v.ctl_veicu = r.ctl_veicu
 AND d.ctl_dispo_rst = r.ctl_dispo_rst
 AND m.ctl_model_dio = d.ctl_model_dio
 AND d.ctl_prove_tec = 14
 AND dv.ctl_vincd = v.ctl_trnsp
 AND v.ctl_veicu = p.ctl_veicu
 AND r.sta_ativo='S'
 AND p.ctl_vincd = 51214
 AND d.ctl_dispo_rst in ( 1046,1246)



 SELECT * FROM PERFIL_ALERTA_VEICULO
 WHERE CTL_VEICU in (1046,1246)


select * from relac_veiculo_dispositivo
where ctl_veicu = 142194

select * from veiculo
where ctl_veicu = 142194

SELECT  P.*, P.ctl_parad_ent,  P.ctl_parad_sai FROM BASE_COLETORA B, PARADA_VINCULADO P
WHERE B.num_base_col = P.num_base_col  AND P.num_base_col = 622
AND P.ctl_opera_tip = 239





SELECT * FROM EVENTO_PLANO_CONTROLE
WHERE CTL_PLANO_CTL = 17475


select * from REF_EVENT_INFOL_PONTO_ETAPA REIPE


SELECT * FROM POSICAO_DISPOSITIVO
SELECT * FROM PONTO_CONTR_ETAPA



select * from evento_plano_controle

SELECT * FROM TIPO_OPERACAO
WHERE CTL_VINCD_EMB = 51214


select * from usuario_internet
where usr_name like '%WALMAR%'



select * from relac_veiculo_dispositivo
where ctl_veicu = 1607


select * from posicao_dispositivo
where ctl_dispo_rst in (1045)
and num_base_col <> 622

select * from tipo_operacao


select * from plano_viagem
where ctl_opera_tip = 247



 SELECT DISTINCT PC.CTL_PLANO_CTL, PC.CTL_CARRE, PC.CTL_VEICU, PC.CTL_VINCD,  PC.DES_UTMO_POS, PC.COD_USER, PC.DHR_ALTER  FROM PLANO_CONTROLE PC  JOIN RELAC_VEICULO_DISPOSITIVO RVD ON pc.ctl_veicu = rvd.ctl_veicu  or pc.ctl_carre= rvd.ctl_veicu  JOIN RELAC_PLANO_CONTROLE_SITUA RPCS ON PC.CTL_PLANO_CTL = RPCS.CTL_PLANO_CTL  JOIN SITUACAO_PLANO_CONTROLE SPC ON SPC.SIT_PLANO_CTL = RPCS.SIT_PLANO_CTL  WHERE (RPCS.tip_situa=1 AND RPCS.sit_plano_ctl <> 2)  AND RVD.STA_ATIVO='S'  AND RVD.ctl_dispo_rst = 1045
