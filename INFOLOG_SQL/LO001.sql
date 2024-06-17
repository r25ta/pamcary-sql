
SELECT PV.ctl_plvia  from ROTEIRO_MOTORISTA RM, PLANO_VIAGEM PV  
WHERE PV.ctl_plvia = RM.ctl_plvia 
AND RM.IDT_ENVIO_MSG = 'P'
and PV.CTL_OPERA_TIP =744 
AND PV.sit_plvia <> 10  
ORDER BY RM.dhr_manut


select * from roteiro_motorista
where ctl_plvia = 1358294

update roteiro_motorista set
idt_envio_msg = 'P'
where ctl_rtmot = 8265629

commit

/*REGISTRO 002*/
select PV.CTL_PLVIA as CTL_PLVIA,  

    PV.TIP_RASTR, 

    (SELECT des_tipo_rst FROM TIPO_RASTREAMENTO 
         WHERE tip_rastr = PV.tip_rastr) AS DES_TIPO_RST,  

    NVL(FC_RELATORIO_PROVEDOR_CODIGO(PV.CTL_PLVIA),'0') AS NUM_TERMN,  

    NVL(FC_RELATORIO_PROVEDOR_CODIGO(PV.CTL_PLVIA),'0') AS ID_TERMINAL_VEICULO,  

    NVL( (select des_LATIT  from ENDERECO_VINCULADO EV1, ROTEIRO_MOTORISTA RM1  
            where EV1.CTL_VINCD = RM1.CTL_PTOPD  
            and RM1.CTL_RTMOT in (select max(CTL_RTMOT) from ROTEIRO_MOTORISTA  
                                    where SIT_FASE_REA in ('R','T')  
                                    and CTL_PLVIA = PV.CTL_PLVIA )),' ' ) as NUM_LATIT, 

    NVL( (select DES_LONGI  from ENDERECO_VINCULADO EV2, ROTEIRO_MOTORISTA RM1  
            where EV2.CTL_VINCD = RM1.CTL_PTOPD  
            and RM1.CTL_RTMOT in (select max(CTL_RTMOT) from ROTEIRO_MOTORISTA 
                                    where SIT_FASE_REA in ('R','T') 
                                    and CTL_PLVIA = PV.CTL_PLVIA )),' ' ) as NUM_LONGI,

    (select dhr_efeti_rea from ROTEIRO_MOTORISTA 
        where CTL_RTMOT in (select max(CTL_RTMOT) from ROTEIRO_MOTORISTA 
                                where SIT_FASE_REA in ('R','T') 
                                and CTL_PLVIA = PV.ctl_plvia) ) AS DHR_EVENT, 

    NVL(PV.DES_PRACA_ULT,'POSICAO DESCONHECIDA') as DES_EVENT, 

    (select ctl_parad from ROTEIRO_MOTORISTA 
        where CTL_RTMOT in (select max(CTL_RTMOT)  from ROTEIRO_MOTORISTA 
                                where SIT_FASE_REA in ('R','T') 
                                and CTL_PLVIA = PV.ctl_plvia) ) AS TIP_EVENT_TER, 

    NVL( (SELECT V.num_placa  FROM RELAC_VEICULO_DISPO_PLANO RVDP, VEICULO V, MODELO_VEICULO MV, GENERO_VEICULO GV 
            WHERE v.ctl_veicu = RVDP.ctl_veicu 
            AND MV.ctl_model = V.ctl_model 
            AND GV.ctl_gener = MV.ctl_gener 
            AND GV.ctl_veicu_tip IN (2, 5, 6, 7) 
            AND RVDP.ctl_plvia = PV.ctl_plvia),'0000000') AS PLACA_DO_VEICULO , 

    NVL(FC_RELATORIO_TRANSPONDER_VEIC(PV.CTL_PLVIA),0) as ID_TRANSPONDER, 

    NVL(PV.NUM_PCARD,' ') as NUM_PCARD, 

    NVL( (SELECT V.num_placa FROM RELAC_VEICULO_DISPO_PLANO RVDP, VEICULO V, MODELO_VEICULO MV, GENERO_VEICULO GV 
            WHERE v.ctl_veicu = RVDP.ctl_veicu 
            AND MV.ctl_model = V.ctl_model 
            AND GV.ctl_gener = MV.ctl_gener 
            AND GV.ctl_veicu_tip = 4 
            and RVDP.CTL_PLVIA = PV.CTL_PLVIA),'0000000') as PLACA_CARRETA, 

    NVL ((select PT.CTL_PROVE_TEC  from DISPOSITIVO D, RELAC_VEICULO_DISPO_PLANO RVDP, PROVEDOR_TECNOLOGIA PT 
            where RVDP.CTL_PLVIA = PV.CTL_PLVIA 
            and D.CTL_DISPO_RST = RVDP.CTL_DISPO_RST 
            and D.CTL_PROVE_TEC = PT.CTL_PROVE_TEC),0) as CTL_PROVE_TEC,  

    NVL(FC_RELATORIO_PROVEDOR_NOME(PV.CTL_PLVIA),' ') as DES_PROVE_TEC, 

    NVL( (select COD_DOCUM  from DISPOSITIVO D1, RELAC_VEICULO_DISPO_PLANO RVDP1, PROVEDOR_TECNOLOGIA PT1 
            where RVDP1.CTL_PLVIA = PV.CTL_PLVIA 
            and D1.CTL_DISPO_RST = RVDP1.CTL_DISPO_RST 
            and D1.CTL_PROVE_TEC = PT1.CTL_PROVE_TEC),'00000000000000') AS CNPJ_PROVE_TEC, 

    NVL((select SIG_parad from tipo_parada 
            where ctl_parad in (select ctl_parad from ROTEIRO_MOTORISTA 
                                    where CTL_RTMOT in (select max(CTL_RTMOT) from ROTEIRO_MOTORISTA 
                                                            where SIT_FASE_REA in ('R','T') 
                                                            and CTL_PLVIA = PV.CTL_PLVIA) ) ),' ') as SIG_PARAD, 

    NVL( (select COD_DOCUM from DOC_VINCULADO DV1, ROTEIRO_MOTORISTA RM1 
            where DV1.CTL_VINCD = RM1.CTL_PTOPD 
            and RM1.CTL_RTMOT in (select max(CTL_RTMOT) from ROTEIRO_MOTORISTA 
                                    where SIT_FASE_REA in ('R','T') 
                                    and CTL_PLVIA = PV.CTL_PLVIA )),'000000000000000' ) as CNPJ_LOCAL, 

    (select dhr_previ_sis from ROTEIRO_MOTORISTA 
        where CTL_RTMOT in (select max(CTL_RTMOT) from ROTEIRO_MOTORISTA 
                                where SIT_FASE_REA in ('R','T') 
                                and CTL_PLVIA = PV.CTL_PLVIA) ) as DHR_PREVI_SIS, 

    PV.TIP_OPERA_VIE ,
    rm2.ord_desti


FROM PLANO_VIAGEM PV, ROTEIRO_MOTORISTA RM2
WHERE PV.CTL_PLVIA = RM2.CTL_PLVIA
AND PV.CTL_OPERA_TIP = 744
AND RM2.IDT_ENVIO_MSG = 'N'


select * from evento_gerenciadora_risco








FROM PLANO_VIAGEM PV, ROTEIRO_MOTORISTA RM 


WHERE PV.ctl_plvia = RM.CTL_PLVIA
IF (UNITARIO)
    AND PV.CTL_PLVIA =2585686

ELSE
    AND RM.IDT_ENVIO_MSG = 'P' -- sistema pesquisa todos eventos pendentes de envio
    AND PV.ctl_opera_tip = 
END IF



select NVL(DV.COD_DOCUM,'000000000000000') as COD_DOCUM,  
    DPV.CTL_DESTI,  
    RM.DHR_PREVI_SIS as DHR_PLVIA_TER,  
    RM.ORD_DESTI,  
    DPV.CTL_DESTI,  
    RM.DHR_EFETI_REA,  
    RM.DES_DIFER_DAT,  
    DPV.SIT_PLVIA AS SIT_PLVIA 
FROM        
    DOC_VINCULADO, DV inner join               
    DESTINATARIO_PLANO_VIAGEM DPV on DV.CTL_VINCD = DPV.CTL_DESTI inner join               
    ROTEIRO_MOTORISTA RM on DPV.CTL_PLVIA = RM.CTL_PLVIA and RM.ORD_DESTI = DPV.ORD_DESTI  
WHERE RM.STA_ENVIO_MSG = 'S'
    AND DPV.CTL_PLVIA = 1358294 
ORDER BY DPV.ORD_DESTI  


/* REGISTRO 003 */
select NVL(DV.COD_DOCUM,'000000000000000') as COD_DOCUM,  
    RM.CTL_PTOPD,  
    RM.DHR_PREVI_SIS as DHR_PLVIA_TER,  
    RM.ORD_DESTI,  
    RM.DHR_EFETI_REA,  
    RM.DES_DIFER_DAT,  
    PV.SIT_PLVIA AS SIT_PLVIA 
FROM        
    DOC_VINCULADO DV,
    ROTEIRO_MOTORISTA RM,
    PLANO_VIAGEM PV
WHERE PV.CTL_PLVIA = 2585686
    AND DV.ctl_vincd = RM.ctl_ptopd
    AND PV.ctl_plvia = RM.ctl_plvia
    AND RM.CTL_PARAD in (10, 12)  
    AND PV.sit_plvia <> 10
ORDER BY RM.ORD_DESTI  


UPDATE ROTEIRO_MOTORISTA SET
idt_ENVIO_MSG = 'E'
WHERE CTL_PLVIA = 




select * from roteiro_motorista