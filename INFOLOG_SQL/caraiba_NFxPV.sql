 SELECT ctl_plvia, ctl_desti, ctl_trnsp,
 NVL(FC_VINCULADO_NOM_GUERR(ctl_trnsp),'') AS nom_trnsp,
 NVL(FC_VINCULADO_NOM_GUERR(ctl_desti),'')AS nom_desti,
 TO_CHAR(FC_DHR_INICIO_VIAGEM(ctl_plvia), 'dd/mm/yyyy hh24:mi') AS dhr_inici_rea,
 TO_CHAR(dhr_inclu, 'dd/mm/yyyy hh24:mi') AS dhr_inclu
 FROM PLANO_VIAGEM
 WHERE ctl_plvia IN (    SELECT ctl_plvia    FROM PLANO_VIAGEM
                         WHERE ctl_opera_tip = 3
                         AND to_char(dhr_inclu,'yyyymmdd') >='20030401'
                         AND sit_plvia <> 10
                         MINUS
                         SELECT To_number(NVL(num_plvia,0)) FROM nota_fiscal)
                         ORDER BY nom_desti, ctl_plvia Desc


SELECT DISTINCT PV.ctl_plvia AS PV, NF.num_plvia AS NF, TO_NUMBER(NVL(NF.num_ntfis,0)) AS num_ntfis,
    PV.ctl_desti, PV.ctl_trnsp,
    NVL(FC_VINCULADO_NOM_GUERR(PV.ctl_trnsp),'') AS nom_trnsp,
    NVL(FC_VINCULADO_NOM_GUERR(PV.ctl_desti),'')AS nom_desti,
    TO_CHAR(FC_DHR_INICIO_VIAGEM(PV.ctl_plvia), 'dd/mm/yyyy hh24:mi') AS dhr_inici_rea,
    TO_CHAR(PV.dhr_inclu, 'dd/mm/yyyy hh24:mi') AS dhr_inclu
FROM PLANO_VIAGEM PV, NOTA_FISCAL NF
WHERE PV.ctl_plvia = to_number(nvl(NF.num_plvia,0))
    and PV.ctl_opera_tip = 3
    AND to_char(PV.dhr_inclu,'yyyymmdd') >='20030401'
    AND PV.sit_plvia <> 10
GROUP BY PV.ctl_plvia, NF.num_plvia,NF.num_ntfis,PV.ctl_desti, PV.ctl_trnsp,PV.dhr_inclu
ORDER BY nom_desti, PV.ctl_plvia, num_ntfis Desc

select * from NOTA_FISCAL
where ctl_vincd in(25123,41143)

SELECT NF.num_ntfis AS num_ntfis, NF.num_plvia AS nf, NFC.nom_clien AS nom_clien,
       NF.dat_emiss_nf AS dat_emiss, NFC.num_cgc_cli1 AS num_cgc_cli1,
       V.ctl_vincd AS ctl_vincd, V.nom_vincd AS nom_vincd
FROM NOTA_FISCAL NF, NOTA_FISCAL_CLIENTE NFC, VINCULADO V, DOC_VINCULADO DV
WHERE NF.ctl_ntfis = NFC.ctl_ntfis
AND V.ctl_vincd = DV.ctl_vincd
AND DV.cod_docum = NFC.num_cgc_cli1
AND NF.num_plvia IS NULL
AND SUBSTR(NF.dat_emiss_nf,4,2) = '04'
AND SUBSTR(NF.dat_emiss_nf,7,4) = '2003'
ORDER BY SUBSTR(NF.dat_emiss_nf,1,2) || SUBSTR(NF.dat_emiss_nf,4,2) || SUBSTR(NF.dat_emiss_nf,7,4)

SELECT ctl_plvia, ctl_desti, ctl_trnsp,
 NVL(FC_VINCULADO_NOM_GUERR(ctl_trnsp),'') AS nom_trnsp,
 NVL(FC_VINCULADO_NOM_GUERR(ctl_desti),'')AS nom_desti,
 TO_CHAR(FC_DHR_INICIO_VIAGEM(ctl_plvia), 'dd/mm/yyyy hh24:mi') AS dhr_inici_rea,
 TO_CHAR(dhr_inclu, 'dd/mm/yyyy hh24:mi:ss') AS dhr_inclu
FROM PLANO_VIAGEM
WHERE ctl_desti = 41143
and ctl_opera_tip = 3
and to_char(dhr_inclu,'DD/MM/YYYY') = '04/04/2003'
order by ctl_plvia desc

and ctl_plvia NOT IN ( select to_number(nvl(num_plvia,0)) AS ctl_plvia From nota_fiscal where num_plvia is not null)
     
select to_number(nvl(num_plvia,0)) AS ctl_plvia From nota_fiscal where num_plvia  is not null 

SELECT NF.*
FROM NOTA_FISCAL NF
WHERE PV.ctl_plvia = to_number(nvl(NF.num_plvia,0))
    and PV.ctl_opera_tip = 3
    AND to_char(PV.dhr_inclu,'yyyymmdd') >='20030401'
    aND PV.sit_plvia <> 10
ORDER BY nom_desti, PV.ctl_plvia Desc


select * from plano_viagem
where ctl_opera_tip = 3
and sit_plvia <> 10
and ctl_trnsp = 12684
and to_char(dhr_inclu,'yyyymmdd') > = '20030401'

update plano_viagem set 
ctl_trnsp = 39979
where ctl_opera_tip = 3
and sit_plvia <> 10
and ctl_trnsp = 12684
and to_char(dhr_inclu,'yyyymmdd') > = '20030401'


select * from nota_fiscal
