 SELECT rm.ctl_rtmot  ,rm.ctl_ptopd  ,FC_VINCULADO_NOM_GUERR(rm.ctl_ptopd) as des_entidade  
 ,FC_RELATORIO_DOC_VINCULADO(rm.ctl_ptopd) as cnpj_entidade  ,( SELECT dfc.cod_docum_fis           
 FROM RELAC_PLVIA_DOCUMENTO rpd,           DOCUMENTO_FISCAL_CLIENTE dfc           
 WHERE dfc.tip_docum_fis = 7            
 AND rpd.ord_desti = 0             
 AND rpd.ctl_plvia =rm.ctl_plvia            
 AND rpd.ctl_desti = rm.ctl_ptopd            
 AND rpd.ctl_docum_cli = dfc.ctl_docum_cli         ) as documento_proprio 
 ,( SELECT rvc.cod_clien_ext           
 FROM REF_VINCULADO_CLIENTE rvc           
 WHERE rvc.ctl_vincd = (SELECT tp.ctl_vincd_emb                                   
 FROM TIPO_OPERACAO tp,                                         
 PLANO_VIAGEM pv                                   
 WHERE pv.ctl_plvia = rm.ctl_plvia                                     
 AND pv.ctl_opera_tip = tp.ctl_opera_tip)                                    
 AND rvc.ctl_vincd_rld= rm.ctl_ptopd) as codigo_externo      
 ,rm.ord_desti as ord_desti       ,rm.ctl_parad as ctl_parad       
 ,tp.sig_parad as sig_parad       ,rm.dhr_previ_sis       ,rm.dhr_efeti_rea       
 ,NVL((         SELECT CASE           WHEN sig_ordem_eve = 'C'              THEN 'CARGA'           
 WHEN sig_ordem_eve = 'DC'              THEN 'DESCARGA-CARGA'           WHEN sig_ordem_eve = 'D'             
 THEN 'DESCARGA'           WHEN sig_ordem_eve = 'CD'             THEN 'DESCARGA'           ELSE               
 'DESCARGA'         END       FROM DESTINATARIO_PLANO_VIAGEM          WHERE ctl_plvia = rm.ctl_plvia            
 AND ctl_desti = rm.ctl_ptopd            AND ord_desti = rm.ord_desti       ),'CARGA') as tipo_janela      
 ,rm.sta_telef       ,rm.sit_fase_rea       ,rm.num_seque       ,rm.dhr_previ_mot       ,rm.dhr_tende_chg       
 ,rm.dhr_manut       ,rm.cod_user  FROM ROTEIRO_MOTORISTA rm   ,TIPO_PARADA tp  
 WHERE tp.ctl_parad = rm.ctl_parad 
 AND rm.ctl_plvia = 9904171  
 AND rm.sit_fase_rea IN('R','T') 
 ORDER BY rm.ord_desti, rm.dhr_previ_sis
 
 
 select * from inf_tipo_motorista
 SELECT * FROM DOC_VINCULADO
 WHERE CTL_VINCD = 1638126
 SELECT * FROM TIPO_OPERACAO