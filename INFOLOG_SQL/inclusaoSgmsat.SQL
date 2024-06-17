select * from FUNCOES_SISTEMA WHERE COD_SISTI in (3,4)
select * from FUNCOES_SISTEMA WHERE COD_SISTI in (4) order by num_ordem
 
select * from senha_usuario_internet
delete senha_usuario_internet where ctl_user = 1223
 
select * from usuario_internet where ctl_user in (1223,642,1003,2864)
select * from usuario_internet where USR_NAME = 'BMZ.DURVAL'
select * from RELAC_PERFIL_USUARIO where cod_sisti = 3 and cod_funca = 10
select fc_placa_veiculo(p.ctl_plvia),p.* from plano_viagem p where ctl_trnsp = 119185 and sit_plvia not in (0,1,8,10) order by ctl_plvia desc
select * from veiculo_plano_viagem where ctl_plvia = 532804
 
SELECT to_char(sysdate, 'dd/mm/yyyy') as data_agora, ctl_vincd_rld as ctl_trnsp, fc_vinculado_nom_guerr(ctl_vincd_rld) as nom_trnsp FROM relacionamento_vinculado WHERE tip_relac = 2 AND ctl_vincd = 119184 ORDER BY fc_vinculado_nom_guerr(ctl_vincd_rld)
 
update FUNCOES_SISTEMA set num_ordem = 1 WHERE COD_SISTI in (3) and cod_funca = 8
update FUNCOES_SISTEMA set num_ordem = 2 WHERE COD_SISTI in (3) and cod_funca = 12
update FUNCOES_SISTEMA set num_ordem = 3 WHERE COD_SISTI in (3) and cod_funca = 1
update FUNCOES_SISTEMA set num_ordem = 4 WHERE COD_SISTI in (3) and cod_funca = 2
update FUNCOES_SISTEMA set num_ordem = 5 WHERE COD_SISTI in (3) and cod_funca = 5
update FUNCOES_SISTEMA set num_ordem = 6 WHERE COD_SISTI in (3) and cod_funca = 3
update FUNCOES_SISTEMA set num_ordem = 7 WHERE COD_SISTI in (3) and cod_funca = 10
 
select FS.des_funca, FS.sig_funca, RPU.ctl_user, RPU.cod_funca
from FUNCOES_SISTEMA FS, RELAC_PERFIL_USUARIO RPU
WHERE FS.COD_SISTI in ( 3, 4 ) AND FS.cod_funca = RPU.cod_funca
AND FS.cod_sisti = RPU.cod_sisti AND RPU.ctl_user = 1223
ORDER BY FS.num_ordem
 
 
 
select ctl_user, ctl_vincd, fc_vinculado_nom_guerr(ctl_vincd), usr_name, num_nivac
from usuario_internet where ctl_user in (
select ctl_user from usuario_internet
minus
select ctl_user from relac_perfil_usuario )
and ctl_vincd not in ( 13100, 22198 )
order by fc_vinculado_nom_guerr(ctl_vincd), usr_name
 
select * from tipo_operacao where ctl_vincd_emb in (35778,93395)
 
select * from relac_perfil_usuario where ctl_user in (4083,4087,4088)
 
select distinct (decode(r.cod_sisti,3,'INFOLOG',4,'SISTEMAS CERAR')), u.ctl_user, u.usr_name
from relac_perfil_usuario r, usuario_internet u
where u.ctl_user = r.ctl_user(+)
order by u.usr_name
 
select ui.ctl_user, ui.num_nivac, ui.usr_name, rv.ctl_vincd, rv.ctl_vincd_rld, tp.des_opera_tip, tp.ctl_vincd_emb from relacionamento_vinculado rv, tipo_operacao tp, usuario_internet ui Where rv.tip_relac = 4 and tp.ctl_vincd_emb = rv.ctl_vincd and ui.ctl_vincd = rv.ctl_vincd_rld order by tp.des_opera_tip, ui.usr_name
 
select count(*) from RELAC_PERFIL_USUARIO where cod_sisti = 3
 
delete RELAC_PERFIL_USUARIO where ctl_user = 1003
 
select * from vinculado where ctl_vincd = 108762
SELECT FC_VINCULADO_NOM_GUERR(CTL_VINCD), V.* FROM DOC_VINCULADO V WHERE COD_DOCUM = 46680617000104
 
SELECT fc_vinculado_nom_guerr(rv.CTL_VINCD_RLD) AS nom_guerr,rv.ctl_vincd, rv.ctl_vincd_rld, rv.tip_relac
FROM relacionamento_vinculado rv, doc_vinculado dv
WHERE rv.ctl_vincd = 35778 AND rv.ctl_vincd_rld = dv.ctl_vincd AND fc_vinculado_documento(rv.ctl_vincd_rld, 1) = 016322190000101
dv.cod_docum = 016322190000101
 

33183658000135
 
SELECT ctl_vincd_emb, fc_vinculado_nom_guerr(ctl_vincd_emb) AS nom_guerr, des_opera_tip
FROM tipo_operacao
ORDER BY nom_guerr
 
select ui.usr_name, rv.ctl_vincd, rv.ctl_vincd_rld, tp.ctl_vincd_emb
from relacionamento_vinculado rv, tipo_operacao tp, usuario_internet ui
where rv.tip_relac = 4
and tp.ctl_vincd_emb = rv.ctl_vincd
and ui.ctl_vincd = rv.ctl_vincd_rld
and tp.ctl_vincd_emb = 41243
order by rv.ctl_vincd
 

select * from usuario_internet where usr_name like '%PAMCARY.INFOLOG%'
 
select FC_VINCULADO_NOM_GUERR(CTL_DESTI), V.* from PLANO_VIAGEM V WHERE CTL_REMET <> 41243 AND CTL_DESTI <> 41243 AND CTL_OPERA_TIP = 3
 
SELECT UI.ctl_user, UI.ctl_vincd, RV.ctl_vincd AS mestre, UI.num_nivac, V.cod_ativi, V.nom_vincd
FROM USUARIO_INTERNET UI, VINCULADO V, relacionamento_vinculado RV
WHERE UI.usr_name = 'CERAR.ADM'
AND UI.cod_senha = 'BRPAMCARY'
AND UI.ctl_vincd = V.ctl_vincd
AND UI.ctl_vincd = RV.ctl_vincd_rld
AND RV.tip_relac = 4
 
select * from relacionamento_vinculado where ctl_vincd = 13100
select * from vinculado where ctl_vincd = 13100
insert into relacionamento_vinculado values (4,13100,13100, 'INFOLOG',sysdate)
 
UPDATE usuario_internet SET NOM_USER = 'RICARDO MONTEIRO' WHERE CTL_USER = 1003
 
insere plano_viagem - li 470
 
UPDATE 000573803
 
curitiba = 5 estrelas
47936118934
byf2228
5 estrelas/curitiba
5 estrelas/curitiba
5 estrelas/s paulo
bel - cwb
 
41 - 601-9200 - EDILSON
 

select tip_docum, cod_docum, count(*)
from doc_vinculado
group by tip_docum, cod_docum
having count(*) > 1
 
select * from doc_vinculado where cod_docum = '26782789809'
 
select FS.des_funca, FS.sig_funca, RPU.ctl_user, RPU.cod_funca
from FUNCOES_SISTEMA FS, RELAC_PERFIL_USUARIO RPU
WHERE FS.COD_SISTI = 3
AND FS.cod_funca = RPU.cod_funca
AND FS.cod_sisti = RPU.cod_sisti
AND RPU.ctl_user = 1223
 
update RELAC_PERFIL_USUARIO set cod_funca = 12 where ctl_perfi = 7
 
SELECT * FROM RELAC_PERFIL_USUARIO WHERE ctl_user = 1223
SELECT * FROM FUNCOES_SISTEMA WHERE COD_SISTI = 4
 
SELECT * FROM RELAC_PERFIL_USUARIO
WHERE ctl_user = 1223
and cod_funca in (5)
 
delete RELAC_PERFIL_USUARIO
WHERE ctl_user = 1223
and cod_funca in (5)
 

select * from funcoes_sistema where cod_funca in (8,12,3,2,5,1) and cod_sisti in ( 3,4)
delere
 
UPDATE FUNCOES_SISTEMA SET DES_FUNCA = 'INICIO DE CARREGAMENTO' WHERE DES_FUNCA = 'INICIO DE CARRGAMENTO'
COD_SISTI = 4 WHERE COD_SISTI = 3 AND COD_FUNCA IN (9,11,4,14)
 
SELECT UI.ctl_user, UI.ctl_vincd, UI.num_nivac, V.cod_ativi, V.nom_vincd,TI.ctl_vincd_emb AS embarca
FROM USUARIO_INTERNET UI, VINCULADO V, TIPO_OPERACAO TI
WHERE UI.usr_name = 'GO.SERGIO'
AND UI.cod_senha = 'GOIANIA'
AND UI.ctl_vincd = V.ctl_vincd
AND TI.ctl_vincd_emb = UI.ctl_vincd
 
SELECT UI.ctl_user, UI.ctl_vincd, RV.ctl_vincd AS mestre, UI.num_nivac, V.cod_ativi, V.nom_vincd
FROM USUARIO_INTERNET UI, VINCULADO V, relacionamento_vinculado RV
WHERE UI.ctl_vincd = V.ctl_vincd
AND UI.ctl_vincd = RV.ctl_vincd_rld
AND RV.tip_relac = 4
 
select * from relacionamento_vinculado where ctl_vincd_rld = 35778
 
SELECT * FROM FUNCOES_SISTEMA WHERE COD_SISTI = 3 ORDER BY COD_FUNCA
 
INSERT INTO FUNCOES_SISTEMA VALUES (3, 2, 'INICIO DE VIAGEM', SYSDATE, 'IVI')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 3, 'ENCERRAMENTO DE VIAGEM', SYSDATE, 'EVI')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 4, 'INICIO DE CARRGAMENTO', SYSDATE, 'ICA')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 5, 'MONITORAMENTO DE CARGAS', SYSDATE, 'MNT')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 6, 'SGMSAT', SYSDATE, 'SGM')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 7, 'ANALISE DO PLANO DE VIAGEM', SYSDATE, 'APV')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 8, 'CADASTRO DE CLIENTES', SYSDATE, 'CCL')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 9, 'CADASTRO DE EMAIL', SYSDATE, 'CEM')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 10, 'CORRECAO DE ENCERRAMENTO', SYSDATE, 'CEN')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 11, 'CADASTRO FOTOGRAFICO', SYSDATE, 'CFO')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 12, 'CADASTRO DE USUARIOS', SYSDATE, 'CUS')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 13, 'INFORMATIVO CERAR', SYSDATE, 'ICE')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 14, 'OFERTA DE VEICULOS', SYSDATE, 'OVE')
INSERT INTO FUNCOES_SISTEMA VALUES (3, 15, 'CADASTRO DE VEICULOS', SYSDATE, 'CVE',1)
INSERT INTO FUNCOES_SISTEMA VALUES (3, 16, 'CADASTRO DE TOLERANCIAS', SYSDATE, 'CTO',1)
INSERT INTO FUNCOES_SISTEMA VALUES (3, 17, 'DATA LIMITE DE ENTREGA', SYSDATE, 'DLE',21)
 

UPDATE FUNCOES_SISTEMA  SET NUM_ORDEM = 10 WHERE COD_SISTI = 3 AND COD_FUNCA = 8
select * from FUNCOES_SISTEMA  WHERE COD_SISTI IN (3) ORDER BY NUM_ORDEM
 
 
 
insert into sistemas values (4,'WEB CERAR')
 
select * from RELAC_PERFIL_USUARIO where ctl_user = 1223
 
select * from FUNCOES_SISTEMA where cod_sisti = 4
 
/*EMBARCADOR*/
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1223, 3, 1,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1223, 4, 2,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1223, 4, 3,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1223, 1, 5,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1223, 3, 8,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1223, 3, 10,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1223, 3, 12,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1223, 3, 15,'INFOLOG', SYSDATE )
15
 
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2863, 4, 14,'INFOLOG', SYSDATE,NULL )
select * from USUARIO_INTERNET
where usr_name like 'ANDRESSA.CSN%'
 
Select count(*) from RELAC_PERFIL_USUARIO
select * from RELAC_PERFIL_USUARIO
 
SELECT UI.ctl_user, UI.ctl_vincd, UI.num_nivac, V.cod_ativi, V.nom_vincd, TI.ctl_vincd_emb AS embarca
FROM USUARIO_INTERNET UI, VINCULADO V, TIPO_OPERACAO TI
WHERE UI.usr_name = 'TESTE_USUARIO'
AND UI.cod_senha = 'TESTE_SENHA'
AND UI.ctl_vincd = V.ctl_vincd
AND TI.ctl_vincd_emb = UI.ctl_vincd
 
select * from USUARIO_INTERNET
where ctl_user in (1003,1223,1443,3223)
 
select * from USUARIO_INTERNET where usr_name like '%CERAR.ADM%'
 
select * from USUARIO_INTERNET where CTL_rota = 4104
 
DELETE USUARIO_INTERNET WHERE CTL_USER = 4131
DELETE RELAC_PERFIL_USUARIO WHERE CTL_USER = 4131
 
select RPU.num_ordem, FS.des_funca, FS.sig_funca, RPU.ctl_user, RPU.cod_funca, ui.usr_name
from FUNCOES_SISTEMA FS, RELAC_PERFIL_USUARIO RPU, usuario_internet UI
WHERE FS.COD_SISTI in ( 3, 4 )
AND FS.cod_funca = RPU.cod_funca
AND FS.cod_sisti = RPU.cod_sisti
AND ui.ctl_user = rpu.ctl_user
order by USR_NAME
 
AND RPU.ctl_user = 1003
 
SELECT UI.ctl_user, UI.ctl_vincd, RV.ctl_vincd AS mestre, UI.num_nivac, V.cod_ativi, V.nom_vincd
FROM USUARIO_INTERNET UI, VINCULADO V, relacionamento_vinculado RV
WHERE UI.usr_name = 'GO.SANDRO' AND UI.cod_senha = 'GOIANIA' AND UI.ctl_vincd = V.ctl_vincd
AND UI.ctl_vincd = RV.ctl_vincd_rld AND RV.tip_relac = 4
 
update USUARIO_INTERNET set num_nivac = 1 where ctl_user = 1003
 
select * from rota where des_rota = 'SEM ROTA 3'
select fc_vinculado_nom_guerr(CTL_PTOPD), r.* from roteiro_viagem r where ctl_rota = 384
 
SELECT RV.ctl_rtvia, RV.ctl_rota, RV.ctl_ptopd, RV.ctl_parad, RV.num_seque_ord,
TO_CHAR(RV.hor_rtvia_qtd,'hh24:mi:ss') AS hor_rtvia_qtd, dia_rtvia_qtd, qtd_klm_tre,
NVL(RV.sta_contr_atr, ' ' ) AS sta_contr_atr,RT.des_rota, RT.des_itine, PP.nom_guerr AS des_ptopd, TP.sig_parad, PR.des_praca,UF.sig_unfed
FROM ROTEIRO_VIAGEM RV, ROTA RT, VINCULADO PP, ENDERECO_VINCULADO EV, TIPO_PARADA TP, PRACA PR, UNIDADE_FEDERAL UF
WHERE RV.ctl_rota = RT.ctl_rota
AND RV.ctl_ptopd = PP.ctl_vincd
AND PP.ctl_vincd = EV.ctl_vincd(+)
AND RV.ctl_parad = TP.ctl_parad
AND EV.cod_praca = PR.cod_praca(+)
AND PR.cod_unfed = UF.cod_unfed(+)
AND RV.ctl_rota = 373
ORDER BY RT.des_rota, RV.num_seque_ord
 
SELECT UI.ctl_user, UI.ctl_vincd, RV.ctl_vincd AS mestre, UI.num_nivac, V.cod_ativi, V.nom_vincd, TO_CHAR(UI.dhr_alter_sen,'dd/mm/yyyy') AS dhr_alter_sen, qtd_acess, qtd_acess_acu, sysdate AS data_atual FROM USUARIO_INTERNET UI, VINCULADO V, relacionamento_vinculado RV WHERE UI.usr_name = 'CERAR.ADM' AND UI.cod_senha = 'BRPAMCARY' AND UI.ctl_vincd = V.ctl_vincd AND UI.ctl_vincd = RV.ctl_vincd_rld AND RV.tip_relac = 4
 
select * from consulta where cpf = 11685425534
 
select * from usuario_internet where ctl_user not in (
SELECT ctl_user FROM RELAC_PERFIL_USUARIO
)
select * from relacionamento_vinculado where ctl_vincd_rld = 70469
insert into relacionamento_vinculado values ( 4, 50419, 70469, 'INFOLOG', SYSDATE )
update usuario_internet set dhr_alter_sen = to_date('20/10/2003 15:00:00', 'dd/mm/yyyy hh24:mi:ss') where ctl_user = 1223
 

SELECT NVL(TO_CHAR(dhr_event, 'dd/mm hh24:mi'), ' ') AS dhr_alert_mac,
    NVL(des_latit,' ') AS des_latit,
    NVL(des_longi,' ') AS des_longi,
    distinct(SUBSTR(des_local,11,29)) AS al1,
    SUBSTR(des_local,11,2) as al2,
    des_local, cod_user
FROM mct_macro
WHERE num_mct = 830659
AND num_macro = 90
AND TO_CHAR(dhr_event, 'yyyymmddhh24miss') >= '20040115201539'
ORDER BY dhr_event DESC
 

insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 390, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 19680, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 98913, 4, 14,'INFOLOG', SYSDATE )
 
/*EXCELSIOR*/
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 391, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 525, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 526, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 527, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 621, 4, 14,'INFOLOG', SYSDATE )
 
/*ANDRESSA*/
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2863, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2864, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2865, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2866, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2867, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2868, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2869, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2870, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2871, 4, 14,'INFOLOG', SYSDATE )
 
/*TORA*/
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 390, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 421, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 522, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 442, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 444, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 445, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 447, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 521, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 524, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1183, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1184, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2023, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 3143, 4, 14,'INFOLOG', SYSDATE )
 

DELETE RELAC_PERFIL_USUARIO WHERE CTL_PERFI = 1743
 
select * from USUARIO_INTERNET where USR_NAME like '%TORA%'
select * from USUARIO_INTERNET where CTL_USER = 390
 

SELECT COD_SISTI, COD_FUNCA, CTL_USER, COUNT(*)
FROM RELAC_PERFIL_USUARIO
GROUP BY COD_SISTI, COD_FUNCA, CTL_USER
HAVING COUNT(*) > 1
 
SELECT * FROM RELAC_PERFIL_USUARIO
where CTL_USER = 1735

/*Cerar Sgmsat*/ 
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 4744, 3, 1,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 4744, 4, 6,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 4744, 4, 7,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 4744, 4, 9,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 4744, 4, 13,'INFOLOG', SYSDATE )

select * from relac_perfil_usuario
where ctl_user = 4744
order by cod_funca

delete relac_perfil_usuario
where ctl_perfi in (2121,2126,2122,2127,2123,2128,2129,2130)

insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 445, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 447, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 521, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 524, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1183, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 1184, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 2023, 4, 14,'INFOLOG', SYSDATE )
insert into RELAC_PERFIL_USUARIO values ( SQ_CTL_PERFI.nextval, 3143, 4, 14,'INFOLOG', SYSDATE )
 
 
select * from usuario
SELECT * FROM FUNCOES_SISTEMA WHERE COD_SISTI IN (3,4)
