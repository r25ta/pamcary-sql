select V.ctl_vincd, V.nom_guerr, V.nom_vincd, DV.cod_docum
from vinculado V, doc_vinculado DV
where V.cod_ativi = 8
and V.ctl_vincd = DV.ctl_vincd



select * from conta_rastreamento


select * from contato
select * from comunicacao_contato

select * from relacionamento_vinculado

select RC.*, CRC.*
from relac_contato RC, comunicacao_relac_contato CRC
where RC.ctl_relac_con = CRC.ctl_relac_con
order by RC.ctl_relac_con

SELECT * FROM RELAC_CONTATO

select * from comunicacao_relac_contato
order by ctl_relac_con

update relac_contato set
nom_contt = 'DJALMA FERNANDES'
WHERE CTL_RELAC_CON = 1706
AND NUM_SEQUE_CMU IN (3,4)

1401	41243	41059	FRANCISCO JUNIOR	2784	30	01141828507	1
1401	41243	41059	FRANCISCO JUNIOR	2785	30	FROTTA@COFIBAM.COM.BR	7
1402	41243	41059	DJALMA FERNANDES	2786	30	01141828504	1
1402	41243	41059	DJALMA FERNANDES	2787	30	DJALMA@COFIBAM.COM.BR	7
1410	41243	41059	LUIZ LOBO	2802	30	LUIZ.LOBO@PAMCARY.COM.BR	7




DELETE RELAC_CONTATO
WHERE CTL_RELAC_CON <> 181


DELETE comunicacao_relac_contato
WHERE CTL_RELAC_CON <> 181




SELECT distinct(C.ctl_contt),RV.ctl_vincd, RV.ctl_vincd_rld, C.ctl_vincd,  C.nom_contt,
CC.ctl_comun_cot, CC.tip_contt, CC.tip_contt, CC.des_comun, CC.tip_comun
FROM RELACIONAMENTO_VINCULADO RV, CONTATO C, COMUNIcaCAO_CONTATO CC
WHERE RV.ctl_vincd_rld = C.ctl_vincd
AND C.ctl_contt = CC.ctl_contt
AND C.ctl_vincd = CC.ctl_vincd
AND c.tip_contt = CC.tip_contt
ORDER BY CC.ctl_comun_cot




 SELECT distinct(C.ctl_contt), RV.ctl_vincd AS ctl_vincd,  RV.ctl_vincd_rld AS ctl_vincd_rld,
 C.nom_contt AS nom_contt, CC.ctl_comun_cot AS ctl_comun_cot,  CC.tip_contt AS tip_contt,
 CC.des_comun AS des_comun,  CC.tip_comun AS tip_comun
 FROM RELACIONAMENTO_VINCULADO RV,  CONTATO C, COMUNICACAO_CONTATO CC
 WHERE RV.ctl_vincd_rld = c.ctl_vincd
 AND C.ctl_contt = CC.ctl_contt
 AND C.ctl_vincd = CC.ctl_vincd
 AND C.tip_contt = CC.tip_contt
 AND CC. des_comun <> ' '
 AND C.nom_contt <> ' '
 ORDER BY RV.ctl_vincd, RV.ctl_vincd_rld, CC.tip_contt 
