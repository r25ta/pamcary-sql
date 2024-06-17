/*Ano/Mês / Num NF / Num Plvia / Nome Cliente NF / Nome do Cliente PV Destino / Data de Emissão da NF
OBS: Enviar PV mesmo que a NF não tenha sido enviada pela Caraíba Metais ou apresentar a NF mesmo que não exista PV.*/

/*notas com plano*/
select nf.num_ntfis, nf.num_plvia, pv.ctl_plvia,
       nfc.nom_clien, nf.dat_emiss_nf, fc_vinculado_nom_guerr(pv.ctl_desti)
from nota_fiscal nf, nota_fiscal_cliente nfc, plano_viagem pv
where nf.ctl_ntfis = nfc.ctl_ntfis
and substr(nf.dat_emiss_nf,4,2) = '04'
and substr(nf.dat_emiss_nf,7,4) = '2003'
and nf.num_plvia = to_char(pv.ctl_plvia(+))
order by substr(nf.dat_emiss_nf,1,2) || substr(nf.dat_emiss_nf,4,2) || substr(nf.dat_emiss_nf,7,4)

/*notas sem plano*/
select '200303', nf.num_ntfis, nf.num_plvia, nfc.nom_clien, nf.dat_emiss_nf
from nota_fiscal nf, nota_fiscal_cliente nfc
where nf.ctl_ntfis = nfc.ctl_ntfis
and nf.num_plvia is null
and substr(nf.dat_emiss_nf,4,2) = '04'
and substr(nf.dat_emiss_nf,7,4) = '2003'
order by substr(nf.dat_emiss_nf,1,2) || substr(nf.dat_emiss_nf,4,2) || substr(nf.dat_emiss_nf,7,4)

/*Planos com Nota*/
select pv.*, nf.*
from nota_fiscal nf, plano_viagem pv
where pv.ctl_plvia = TO_NUMBER(NVL(NUM_PLVIA, 0))
and to_char(dhr_inclu, 'yyyymm') = '200304'
and pv.ctl_opera_tip = 3

/*Planos sem Nota*/
SELECT CTL_PLVIA FROM PLANO_VIAGEM
WHERE CTL_OPERA_TIP = 3
AND TO_CHAR(DHR_INCLU,'YYYYMM') = '200304'
AND SIT_PLVIA <> 10
MINUS
SELECT TO_NUMBER(NVL(NUM_PLVIA, 0)) FROM NOTA_FISCAL



