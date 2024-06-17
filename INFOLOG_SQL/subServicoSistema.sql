SELECT * FROM SUB_SERVICO_SISTEMA
ORDER BY CTL_SERVI


insert into sub_servico_sistema (ctl_servi_sub,ctl_servi,des_servi_sub,dhr_ultim_pro,dhr_toler,cod_user,dhr_alter,des_respo)
                          values(sq_ctl_servi_sub.nextval,82,'Leitura de Mensagens Irisat',sysdate,to_date('20060424010001','yyyymmddhh24miss'),'RESTAURAJAVA',SYSDATE,'PAMSIST')

select * from servico_sistema


UPDATE SUB_SERVICO_SISTEMA SET
ctl_servi = 1
where ctl_servi_sub in (142,143,144,145,146,147,148,149)


select * from tipo_operacao

select fc_vinculado_nom_guerr(ctl_vincd_rld), r.* from relacionamento_vinculado r
where ctl_vincd = 50720
and tip_relac = 2


select fc_vinculado_nom_guerr(ctl_ptopd), TO_CHAR(DHR_EFETI_REA,'DD/MM/YYYY HH24:MI:SS'), to_char(dhr_previ_sis,'DD/MM/YYYY HH24:MI:SS'), r.* from roteiro_motorista r
where ctl_plvia = 914550
order by num_seque

select to_char(dhr_event,'dd/mm/yyyy hh24:mi:ss'), to_char(dhr_alter,'dd/mm/yyyy hh24:mi:ss'), m.* from monitora_terminal m
order by dhr_alter desc

select NUM_TERMN, to_char(dhr_event,'dd/mm/yyyy hh24:mi:ss') AS TERMINAL,
TO_CHAR(DHR_INCLU_CGA,'DD/MM/YYYY HH24:MI:SS') AS OPENTECH,
TO_CHAR(DHR_ALTER,'DD/MM/YYYY HH24:MI:SS') AS PAMCARY, tip_event_ter, DES_EVENT, NUM_PLACA_TRD AS NUM_PLACA,
NUM_CONTR_CGA AS CDMSG, l.*
FROM log_monitora_terminal l
where num_termn = 497242941
and tip_event_ter IN( 43, 12 )
order by dhr_event desc


select * from log_monitora_terminal_det
where num_seque_ter = 9187447


select * from vinculado
where nom_guerr like '%MLC%'

SELECT * FROM ENDERECO_VINCULADO
WHERE CTL_VINCD = 10

225757,465947

SELECT distinct P.ctl_plvia, P.ctl_remet, fc_vinculado_nom_guerr(P.ctl_remet) as remet,
P.ctl_motot, P.ctl_trnsp, P.ctl_desti, fc_vinculado_nom_guerr(P.ctl_desti) as desti
FROM PLANO_VIAGEM P , VEICULO_PLANO_VIAGEM V 
WHERE V.num_mct = 803599
AND P.ctl_plvia = V.ctl_plvia 
AND P.sit_plvia in (2,3,4,9,12) 
AND P.ctl_opera_tip = 20
ORDER BY ctl_plvia DESC



SELECT ctl_desti,sig_ordem_eve, SIT_PLVIA FROM DESTINATARIO_PLANO_VIAGEM
WHERE ctl_plvia = 913210
AND sit_plvia in (2,3,4,9,12)
ORDER BY ord_desti

SELECT * FROM PLANO_VIAGEM
WHERE ctl_plvia = 914478


SELECT PEO.ctl_vincd, PEO.ctl_desti, PEO.ctl_remet,  TPC.tip_prazo_cli, TPC.des_prazo_cli, TPT.tip_prazo_tmp, TPT.des_prazo_tmp, PEO.num_prazo, PEO.qtd_klm  FROM PRAZO_ENTREGA_ORIGEM PEO, TIPO_PRAZO_CLIENTE TPC, TIPO_PRAZO_TEMPO TPT  WHERE PEO.ctl_vincd =50720 AND PEO.ctl_desti =10 AND PEO.ctl_remet =78510 AND TPC.tip_prazo_cli = 4 AND TPC.tip_prazo_cli = PEO.tip_prazo_cli  AND TPT.tip_prazo_tmp = PEO.tip_prazo_tmp 

 SELECT PEM.ctl_vincd, PEM.cod_praca_ori,  PEM.cod_praca_des, PEM.tip_prazo, PEM.num_prazo  FROM PRAZO_ENTREGA_MERCADORIA PEM,  ENDERECO_VINCULADO EV  WHERE PEM.ctl_vincd = 50720 AND PEM.cod_praca_ori = 3997 AND PEM.cod_praca_des = 3096 AND PEM.cod_praca_ori = EV.cod_praca  AND PEM.cod_praca_des = EV.cod_praca
SELECT * FROM SITUACAO_PLANO_VIAGEM

select * from veiculo_plano_viagem
where num_mct = 817471
order by ctl_plvia desc


SELECT ctl_desti, ord_desti, NVL(num_janel_rec, '999' ) AS num_janel_rec,
TO_CHAR(dhr_plvia_ter,'YYYYMMDDHH24MISS') AS dhr_plvia_ter, 
NVL(FC_VINCULADO_NOM_GUERR(ctl_desti),' ') AS nom_desti, num_consi_mer,
NVL(FC_VINCULADO_NOM_GUERR(num_consi_mer),' ') AS NOM_CONSI_MER, sit_plvia, NVL(sig_ordem_eve,'NAO_EXISTE') AS SIG_ORDEM_EVE
FROM DESTINATARIO_PLANO_VIAGEM 
WHERE ctl_plvia = 913123
AND sit_plvia IN ( 0, 1 )
ORDER BY ord_desti


SELECT ctl_plvia FROM ROTEIRO_MOTORISTA 
WHERE ctl_plvia = 913123
AND ctl_ptopd = 149593
AND dhr_previ_sis = TO_DATE('20060423202827','YYYYMMDDHH24MISS')
AND num_seque <= 8


select * from vinculado
where nom_guerr like '%UNILEVER%'

SELECT * FROM DOC_VINCULADO
WHERE CTL_VINCD = 149593



select count(1) from monitora_cartao_detalhe
where sta_procs = 'N'
and to_char(dhr_passa_cao,'yyyymmdd') <='20060424'




select to_char(dhr_alter,'dd/mm/yyyy hh24:mi:ss') as dhr_alter, r.* from ref_veiculo r
where sta_situa_vei = 'A'



update ref_veiculo set
sta_situa_vei = 'R',
dhr_alter = sysdate
where sta_situa_vei = 'A'
and sta_respl_prc = 'P'

order by dhr_passa_cao desc

update destinatario_plano_viagem set
sit_plvia = 12
where ctl_plvia = 913222
SELECT distinct P.ctl_plvia, P.ctl_remet, P.ctl_motot, P.ctl_trnsp, P.ctl_desti  FROM PLANO_VIAGEM P , VEICULO_PLANO_VIAGEM V  WHERE V.num_mct = 816173 AND P.ctl_plvia = V.ctl_plvia  AND P.sit_plvia in (2,3,4,9,12)  AND P.ctl_opera_tip = 20 ORDER BY ctl_plvia DESC 

SELECT ctl_desti,sig_ordem_eve FROM DESTINATARIO_PLANO_VIAGEM
WHERE ctl_plvia = 913222
AND sit_plvia in (2,3,4,9,12)  ORDER BY ord_desti 



 SELECT DISTINCT PV.ctl_plvia, PV.ctl_trnsp, PV.ctl_remet, PV.ctl_motot, PV.ctl_opera_tip, PV.ctl_rtvia, PV.sit_plvia, TO_CHAR(PV.dhr_plvia_ini,'YYYYMMDDHH24MISS') AS dhr_plvia_ini, NVL(sta_circu_etc,'N') AS sta_circu_etc FROM PLANO_VIAGEM PV, VEICULO_PLANO_VIAGEM VPV WHERE PV.sit_plvia IN(0,1)
 AND VPV.num_mct = 'MCU0790'
 AND VPV.ctl_plvia =



   PV.ctl_plvia
   
   
   
   
   SELECT TO_CHAR(DHR_MANUT,'DD/MM/YYYY HH24:MI:SS'), V.* FROM VEICULO_PLANO_VIAGEM V
   WHERE NUM_MCT = 816173
   ORDER BY CTL_PLVIA DESC
   
SELECT * FROM PLANO_VIAGEM
WHERE CTL_PLVIA =  913222
