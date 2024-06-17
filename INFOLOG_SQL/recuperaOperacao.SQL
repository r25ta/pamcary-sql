select * from tipo_operacao
where ctl_opera_tip = 183

select * from doc_vinculado
where ctl_vincd = 12680

select * from plano_viagem
where ctl_opera_tip = 183
order by ctl_plvia desc

select * from roteiro_motorista
where ctl_plvia = 860258

select * from destinatario_plano_viagem
where ctl_plvia = 860258

select * from veiculo_plano_viagem
where ctl_plvia = 860258

select * from motorista_plano_viagem
where ctl_plvia = 860258

/*QUERY PARA RECUPERAR A OPERAÇÃO*/
SELECT PP.ctl_vincd,PP.tip_recal_prv, PP.sta_reini_vie, PP.sta_retor_ifm,
       PP.sta_integ_pst, PP.sta_integ_pac,
       PP.sta_envio_msg, T.ctl_opera_tip
FROM PERFIL_PARAMETRO_INFOLOG PP, TIPO_OPERACAO T
WHERE PP.ctl_vincd = T.ctl_vincd_emb
AND T.ctl_opera_tip = 183

select * from tipo_operacao
WHERE CTL_OPERA_TIP = 183

SELECT * FROM PERFIL_PARAMETRO_INFOLOG

12680
