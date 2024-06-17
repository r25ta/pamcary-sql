INSERT INTO HIST_ANALISE_PLANO_VIAGEM
SELECT ctl_plvia,dhr_anali_eve,cod_ocorr,des_anali_eve,dhr_inclu,
nom_inclu,nom_inclu_sup
FROM ANALISE_PLANO_VIAGEM
WHERE TO_CHAR(dhr_inclu, 'YYYYMMDD') <= TO_CHAR(LAST_DAY(ADD_MONTHS(sysdate, - 5)),'YYYYMMDD')
order by dhr_inclu desc
