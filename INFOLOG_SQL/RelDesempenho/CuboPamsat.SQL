
SELECT PV.ctl_plvia AS PLVIA, NVL(FC_ID_VEICULO( pv.ctl_plvia ), 0 ) AS ID_TERMINAL, PV.sit_plvia AS SIT_PLVIA,
    pv.tip_rastr As tip_rastr, (DECODE(PV.tip_rastr,1,'SATELITE',2,'CARTAO',3,'TELEFONICO')) AS des_rastr, SPV.des_situa AS DES_SIT_PLVIA, PV.ctl_opera_tip TIP_OPER, TOP.des_opera_tip AS DES_TIP_OPER,
    NVL(pv.ctl_empre_equ,0) As PROVEDOR,
    MPV.ctl_motot, MO.nom_vincd as MOTORISTA,
    FC_VINCULADO_NOM_GUERR( pv.ctl_trnsp ) AS TRANSPORTADORA,
    PV.ctl_remet As CTL_REMET, FC_VINCULADO_NOM_GUERR( PV.ctl_remet ) AS REMET,
    PV.ctl_desti AS CTL_DESTI, FC_VINCULADO_NOM_GUERR( pv.ctl_desti) AS DESTI,
    PR.cod_praca AS COD_PRACA_DESTI, PR.des_praca AS DES_PRACA_DESTI,
    UF.sig_unfed AS SIG_UNFED_DESTI, to_char(PV.dhr_inclu,'DD/MM/YYYY HH24:MI') AS INCLUSAO, to_char(PV.dhr_plvia_ter,'DD/MM/YYYY HH24:MI') AS TERMINO,
    APV.cod_ocorr AS COD_OCORR, APV.des_anali_eve AS DES_ANALI_EVE, APV.nom_inclu_sup AS NOM_SUP, APV.nom_inclu AS NOM_USER
FROM plano_viagem PV, tipo_operacao TOP, motorista_plano_viagem MPV, vinculado MO,
    situacao_plano_viagem SPV, endereco_vinculado EV, praca PR, unidade_federal UF, 
    analise_plano_viagem APV
WHERE PV.ctl_opera_tip = TOP.ctl_opera_tip
AND to_char(PV.dhr_inclu, 'yyyymmdd') BETWEEN '20030601' AND '20030615'
AND PV.ctl_plvia = MPV.ctl_plvia
AND MPV.ord_motot = 1
AND MPV.ctl_motot = MO.ctl_vincd
AND PV.sit_plvia = SPV.sit_plvia
AND pv.ctl_remet = ev.ctl_vincd(+)
AND ev.cod_praca = pr.cod_praca(+)
AND pr.cod_unfed = uf.cod_unfed(+)
AND PV.ctl_plvia = APV.ctl_plvia
AND apv.cod_ocorr in ( 10112, 10122, 10212, 10222, 10312, 10322, 10412, 10422, 10712, 10722,
                       2011, 2012, 2013, 2014, 2021, 2022, 2023, 2024,
                       3011, 3012, 3013,  40, 50,
                       3021, 3022, 3023, 3024, 3025, 3031, 3032, 3033, 3041, 3042, 3043, 3026, 3027, 3091,
                       3071, 3072, 3073, 3074 )
