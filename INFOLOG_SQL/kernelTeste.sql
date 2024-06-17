select txt_event_ter, tip_event_ter, to_char(dhr_alter,'dd/mm/yyyy hh24:mi'), m.* from monitora_terminal m
where tip_event_ter <> 99
order by dhr_alter desc


where to_char(dhr_alter,'yyyymmddhh24mi') >= '200810031720'

 SELECT RV.ctl_vincd, RV.ctl_vincd_rld, NVL(FC_VINCULADO_NOM_GUERR(DV.ctl_vincd),' ') AS nom_guerr,  NVL(DV.cod_docum ,' ') as cod_docum
 FROM DOC_VINCULADO DV, RELACIONAMENTO_VINCULADO RV
 WHERE RV.tip_relac = 2  AND DV.ctl_vincd = RV.ctl_vincd_rld
 AND DV.ctl_vincd = 162784

select * from provedor_tecnologia
where cod_docum = 03585974000172

select * from posicao_dispositivo
where ctl_posic_dio in (1219221,925463,926853)


/*COMETA NATAL CH*/
update posicao_dispositivo set
dhr_event = to_date('200810141450','yyyymmddhh24mi'),
sta_procs = 'N',
ctl_rtmot = null,
CTL_DISPO_RST = 9963
where ctl_posic_dio=926484

/*COMETA NATAL IV*/
update posicao_dispositivo set
dhr_event = to_date('200810142000','yyyymmddhh24mi'),
sta_procs = 'N',
ctl_rtmot = null,
CTL_DISPO_RST = 9963
where ctl_posic_dio=1219221

/*POS 05 ESTRELAS*/
update posicao_dispositivo set
dhr_event = to_date('200810150200','yyyymmddhh24mi'),
sta_procs = 'N',
ctl_rtmot = null,
CTL_DISPO_RST = 9963
where ctl_posic_dio = 926853



/*COMETA MACEIO CH*/
update posicao_dispositivo set
dhr_event = to_date('200810111800','yyyymmddhh24mi'),
sta_procs = 'N',
ctl_rtmot = null,
CTL_DISPO_RST = 9963
where ctl_posic_dio = 924752


/*COMETA MACEIO IV*/
update posicao_dispositivo set
dhr_event = to_date('200810111800','yyyymmddhh24mi'),
sta_procs = 'N',
ctl_rtmot = null,
CTL_DISPO_RST = 9963
where ctl_posic_dio = 925463


RC - NATAL - VIT CONQUISTA - TRANSPONDER

select * from base_coletora
where ctl_vincd = 294460

select fc_vinculado_nom_guerr(ctl_ptopd), nvl(e.des_latit,0), nvl(e.des_longi,0),e.num_latit,e.num_longi,
to_char(dhr_efeti_rea,'dd/mm/yyyy hh24:mi') real,
to_char(dhr_previ_sis,'dd/mm/yyyy hh24:mi') prevista,
SIT_FASE_REA,
r.* from roteiro_motorista r, endereco_vinculado e
where ctl_plvia = 1343064
and r.ctl_ptopd = e.ctl_vincd
order by num_seque

SELECT FC_DISTANCIA_PONTOS_INFOLOG( 055321A , 51438A , 055321 , 351438 )

 SELECT RM.ctl_plvia AS ctl_plvia, RM.ctl_rtmot AS ctl_rtmot, RM.ctl_ptopd AS ctl_ptopd,
 PV.ctl_opera_tip, RM.num_seque, RM.ctl_parad, PV.sit_plvia, RM.sit_fase_rea,
 NVL(TO_CHAR(RM.dhr_efeti_rea ,'YYYYMMDDHH24MISS'),' ') AS dhr_efeti_rea,
 NVL(TO_CHAR(RM.dhr_previ_sis ,'YYYYMMDDHH24MISS'),' ') AS dhr_previ_sis,
 NVL(TO_CHAR(RM.dhr_previ_mot ,'YYYYMMDDHH24MISS'),' ') AS dhr_previ_mot,
 NVL(EV.des_latit,0) AS des_latit, NVL(EV.des_longi,0) AS des_longi,  NVL(EV.num_latit,0) AS num_latit,
 NVL(EV.num_longi,0) AS num_longi,  PR.des_praca AS des_praca,  UF.nom_unfed AS nom_unfed,
 NVL(RM.dia_rtvia_qtd,0) AS dia_rtvia_qtd,  NVL( TO_CHAR(RM.hor_rtvia_qtd,'HH24:MI:SS'),'00:00:01' ) AS hor_rtvia_qtd,
 NVL (RM.ord_desti,0) AS ord_desti
 FROM PLANO_VIAGEM PV, ROTEIRO_MOTORISTA RM,  ENDERECO_VINCULADO EV, PRACA PR, UNIDADE_FEDERAL UF
 WHERE PV.ctl_plvia = 1343036
 AND RM.ctl_parad = 0 AND PV.sit_plvia IN ( 0, 1 )  AND RM.sit_fase_rea IN ( 'S', 'M' )  AND PV.ctl_plvia = RM.ctl_plvia  AND RM.ctl_ptopd = EV.ctl_vincd  AND EV.cod_praca = PR.cod_praca  AND PR.cod_unfed = UF.cod_unfed
 ORDER BY RM.num_seque 

 SELECT DISTINCT PV.ctl_plvia, PV.ctl_trnsp, PV.ctl_remet, PV.ctl_motot, PV.ctl_opera_tip, PV.ctl_rtvia, PV.sit_plvia,
 TO_CHAR(PV.dhr_plvia_ini,'YYYYMMDDHH24MISS') AS dhr_plvia_ini, NVL(sta_circu_etc,'N') AS sta_circu_etc
 FROM PLANO_VIAGEM PV, VEICULO_PLANO_VIAGEM VPV
 WHERE PV.sit_plvia IN(0,1)  AND VPV.num_mct = 1111111 AND VPV.ctl_plvia = PV.ctl_plvia 
 

 SELECT RV.ctl_vincd, RV.ctl_vincd_rld, NVL(FC_VINCULADO_NOM_GUERR(DV.ctl_vincd),' ') AS nom_guerr,
 NVL(DV.cod_docum ,' ') as cod_docum
 FROM DOC_VINCULADO DV, RELACIONAMENTO_VINCULADO RV
 WHERE RV.tip_relac = 2  AND DV.ctl_vincd = RV.ctl_vincd_rld  AND DV.ctl_vincd = 162784
 
 
  SELECT RPV.cod_parad_ref, RPV.ctl_parad  FROM REF_PARADA_VINCULADO RPV,  PROVTECN_RELVINCD PR, PROVEDOR_TECNOLOGIA PT  WHERE RPV.ctl_prove_vin = PR.ctl_prove_vin  AND PT.ctl_prove_tec = PR.ctl_prove_tec  AND PR.ctl_vincd = 264646 AND PR.tip_relac = 2  ORDER BY RPV.cod_parad_ref 

055321, 351438
5,889166666667, 35,243888888889
select FC_CONV_COORDENADA_DEC_GEO('351438',2) from dual


for


select nvl(FC_DISTANCIA_PONTOS_INFOLOG(lat Ante,longi ant, lat Unid ,longi ant ),0) as distancia from dual


select FC_DISTANCIA_PONTOS_INFOLOG(FC_CONV_COORDENADA_DEC_GEO('-8,40833333333333',1),
                                   FC_CONV_COORDENADA_DEC_GEO('-35,2780555555556',1)


FC_CONV_COORDENADA_DEC_GEO('-8,40833333333333',1)

5,889166666667, 35,243888888889

select NVL(FC_DISTANCIA_PONTOS_INFOLOG( FC_CONV_COORDENADA_DEC_GEO('5,889166666777',1),
                                        FC_CONV_COORDENADA_DEC_GEO('35,243888888899',1),
                                        nvl(ev.des_latit,0),
                                        nvl(ev.des_longi,0)), '00') as dist, v.nom_guerr
from roteiro_motorista r, vinculado v, endereco_vinculado ev
where r.ctl_ptopd = v.ctl_vincd
and v.ctl_vincd = ev.ctl_vincd
and r.ctl_plvia = 1343007
--and (ev.num_latit is not null and ev.num_longi is not null)
order by dist


SELECT fc_vinculado_nom_guerr(rm.ctl_ptopd),RM.ctl_plvia AS ctl_plvia, RM.ctl_rtmot AS ctl_rtmot, RM.ctl_ptopd AS ctl_ptopd,
    	PV.ctl_opera_tip, RM.num_seque, RM.ctl_parad, PV.sit_plvia, RM.sit_fase_rea,
	    NVL(TO_CHAR(RM.dhr_efeti_rea ,'DDMMYYYYHH24MISS'),' ') AS dhr_efeti_rea,
	    NVL(TO_CHAR(RM.dhr_previ_sis ,'DDMMYYYYHH24MISS'),' ') AS dhr_previ_sis,
	    NVL(TO_CHAR(RM.dhr_previ_mot ,'DDMMYYYYHH24MISS'),' ') AS dhr_previ_mot,
	    NVL(EV.des_latit,0) AS des_latit, NVL(EV.des_longi,0) AS des_longi,
	    NVL(EV.num_latit,0) AS num_latit, NVL(EV.num_longi,0) AS num_longi,
	    PR.des_praca AS des_praca,
	    UF.nom_unfed AS nom_unfed,
	    NVL(RM.dia_rtvia_qtd,0) AS dia_rtvia_qtd,
	    NVL( TO_CHAR(RM.hor_rtvia_qtd,'HH24:MI:SS'),'00:00:01' ) AS hor_rtvia_qtd,
	    NVL( RM.ord_desti,0 ) AS ord_desti
	    FROM PLANO_VIAGEM PV, ROTEIRO_MOTORISTA RM,
	    ENDERECO_VINCULADO EV, PRACA PR, UNIDADE_FEDERAL UF
	    WHERE PV.ctl_plvia =1342994
	    AND RM.ctl_parad = 13
	    AND PV.sit_plvia IN ( 0, 1 )
	    AND RM.sit_fase_rea IN ( 'S', 'M' )
	    AND PV.ctl_plvia = RM.ctl_plvia
	    AND RM.ctl_ptopd = EV.ctl_vincd
	    AND EV.cod_praca = PR.cod_praca
	    AND PR.cod_unfed = UF.cod_unfed
	    ORDER BY RM.num_seque



select fc_vinculado_nom_guerr(ctl_vincd), e.* from endereco_vinculado e
where ctl_vincd = 271159
   SELECT FC_PRACA_MAIS_PROXIMA('055321','351438',1) FROM DUAL


SELECT des_latit, des_longi, NVL(EV.DES_ENDER,' ') AS DES_ENDER, NVL(EV.DES_BAIRR_END, ' ') AS DES_BAIRR_END,
NVL(EV.DES_NUMER_END, ' ') AS DES_NUMER_END, NVL(EV.DES_COMPL_END, ' ') AS DES_COMPL_END,
NVL(PR.DES_PRACA, '  ') AS DES_PRACA, NVL(UF.SIG_UNFED, ' ') AS SIG_UNFED, NVL(P.NOM_PAIS, ' ') AS NOM_PAIS
FROM PRACA PR, UNIDADE_FEDERAL UF, PAIS P, ENDERECO_VINCULADO EV
WHERE PR.COD_UNFED = UF.COD_UNFED
AND   UF.COD_PAIS = P.COD_PAIS
AND   EV.COD_PRACA = PR.COD_PRACA
AND EV.CTL_VINCD   = 271159

select * from base_coletora
where num_base_col = 910111


select * from endereco_vinculado
where ctl_vincd = 271171
select NVL(FC_DISTANCIA_PONTOS_INFOLOG( substr(").append(lt).append(",1,10), substr(").append(lg).append(",1,10), substr(ev.num_latit,1,10),substr(ev.num_longi,1,10) ), '0') as dist, v.nom_guerr
from roteiro_motorista r, vinculado v, endereco_vinculado ev
where r.ctl_ptopd = v.ctl_vincd
and v.ctl_vincd = ev.ctl_vincd
and r.ctl_plvia = 1343055
and (ev.num_latit is not null and ev.num_longi is not null)
order by dist


select * from endereco_vinculado
where ctl_vincd = 294460

select * from posicao_dispositivo
where num_base_col in (910111,588)
926484 - 588
924752 - 90111


select * from base_coletora
where num_base_col in (856,910111,588)


SELECT * FROM POSICAO_DISPOSITIVO
WHERE CTL_POSIC_DIO = 926484
