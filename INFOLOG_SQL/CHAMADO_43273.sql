Criar uma view que traga os dados de evento da viagem dos últimos sete dias. Os dados são:

ok - CTL_OPERA_TIP - numero da operação
ok - CTL_PLVIA - numero do plano de iagem
ok - DOCUMENTO PROPRIO DO CLIENTE 
ok - DES_OPERA_TIP - tipo de operação
ok - CNPJ_TRANSPORTADOR - documento do transportador
ok - CNPJ_ENTIDADE - documento da entidade onde o evento foi realizado.
ok - TIPO ATIVIDADE - tipo de atividade (cliente monitoramento, transportador, terminal vazio, porto,...)
ok - EVENTO - codigo do evento
ok - DATA_HORA_EVENTO - data e hora do evento
TIP_EFETI_REA - indica se foi realizado ou é previsão ainda (se tiver realizado não precisa do previsto)
DATA_HORA_ALTERAÇÃO - data e hora do registro do evento
NUM_PLACA - placa do veiculo
/* CHAMADO 43273*/
SELECT PV.ctl_opera_tip AS CTL_OPERA_TIP,
 
       PV.ctl_plvia AS CTL_PLVIA,

       FC_RELATORIO_DOCUMENTO_CLIENTE(PV.ctl_plvia) AS DOCUMENTO_PROPRIO_CLIENTE,
 
       TOV.des_opera_vie AS DES_OPERA_TIP,

       NVL(( SELECT DVT.cod_docum FROM DOC_VINCULADO DVT
            WHERE DVT.ctl_vincd = PV.ctl_remet ),'000000000000000') AS CNPJ_TRANSPORTADOR,
 
       ( SELECT DVR.cod_docum FROM ROTEIRO_MOTORISTA RME, DOC_VINCULADO DVR
            WHERE DVR.ctl_vincd = RME.ctl_PTOPD
                AND RME.ctl_rtmot = RM.ctl_rtmot) AS CNPJ_ENTIDADE,

       ( SELECT ATE.des_ativi FROM ROTEIRO_MOTORISTA RMA, VINCULADO VA, ATIVIDADE ATE
            WHERE VA.ctl_vincd = RMA.ctl_PTOPD
                AND ATE.cod_ativi = VA.cod_ativi
                AND RMA.ctl_rtmot = RM.ctl_rtmot ) AS TIPO_ATIVIDADE,

       ( SELECT ATE.des_ativi FROM ROTEIRO_MOTORISTA RME, VINCULADO VA, ATIVIDADE ATE
            WHERE VA.ctl_vincd = RME.ctl_PTOPD
                AND ATE.cod_ativi = VA.cod_ativi
                AND RME.ctl_rtmot = RM.ctl_rtmot ) AS EVENTO,

        FC_RELATORIO_DATA_EVENTO_REAL(RM.CTL_RTMOT) AS DATA_HORA_EVENTO,
               
        RM.sit_fase_rea AS TIP_EFETI_REA,

        to_char(RM.dhr_manut,'DD/MM/YYYY HH24:MI:SS') AS DATA_HORA_ALTERACAO,
        
        (SELECT V.num_placa FROM VEICULO V, VEICULO_PLANO_VIAGEM VPV
            WHERE V.ctl_veicu = VPV.ctl_veicu
            AND VPV.ord_veicu = 1
            AND VPV.ctl_plvia = PV.ctl_plvia) AS NUM_PLACA,

        PV.obs_plvia

FROM PLANO_VIAGEM PV, 
     ROTEIRO_MOTORISTA RM, 
     TIPO_OPERACAO_VIAGEM TOV
WHERE PV.ctl_plvia = RM.ctl_plvia
AND TOV.tip_opera_vie = PV.tip_opera_vie
AND RM.sit_fase_rea IN ('R','T')
AND PV.sit_plvia <> 10
AND PV.dhr_inclu >= SYSDATE - 7



SELECT count(rm.ctl_rtmot)
FROM PLANO_VIAGEM PV, 
     ROTEIRO_MOTORISTA RM, 
     TIPO_OPERACAO_VIAGEM TOV
WHERE PV.ctl_plvia = RM.ctl_plvia
AND TOV.tip_opera_vie = PV.tip_opera_vie
AND RM.sit_fase_rea IN ('R','T')
AND PV.sit_plvia <> 10
AND PV.dhr_inclu >= SYSDATE - 7



SELECT TO_CHAR(SYSDATE-7,'DD/MM/YYYY HH24:MI:SS'), TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS') FROM DUAL


select * from roteiro_motorista
where ctl_plvia = 2557330

    
select * from veiculo_plano_viagem
SELECT * FROM VINCULADO
SELECT * FROM ATIVIDADE
SELECT * FROM DOC_VINCULADO
select * from roteiro_motorista
select * from tipo_operacao_viagem

select * from roteiro_motorista
where sit_fase_rea = 'R'
order by ctl_plvia desc


select * from plano_viagem
order by ctl_plvia desc