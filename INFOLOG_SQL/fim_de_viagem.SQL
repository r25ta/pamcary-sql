SELECT RM.ctl_plvia, RM.ctl_rtmot, RM.ctl_parad,
to_char(PV.dhr_plvia_ini,'dd/mm/yyyy hh24:mi:ss') AS dhr_plvia_ini,
to_char(PV.dhr_plvia_ter,'dd/mm/yyyy hh24:mi:ss') AS dhr_plvia_ter,
to_char(RM.dhr_efeti_rea,'dd/mm/yyyy hh24:mi:ss') AS dhr_efeti_rea,
PV.sit_plvia, SPV.des_situa, PV.ctl_user,
RM.sta_telef, RM.sit_fase_rea, RM.cod_user
FROM ROTEIRO_MOTORISTA RM, PLANO_VIAGEM PV, SITUACAO_PLANO_VIAGEM SPV
WHERE RM.ctl_plvia = PV.ctl_plvia
AND PV.sit_plvia = SPV.sit_plvia
AND PV.ctl_plvia = 234144
AND RM.ctl_parad = 12
