select * from evento_gerenciadora_risco
where 1=1
AND cod_user = 'SIMULADOR KRONA'
--AND IDT_TIPO_EVE = 'M'
ORDER BY DHR_ALTER DESC


select * from vinculado V, endereco_vinculado EV
where V.ctl_vincd = EV.ctl_vincd
AND nom_guerr like '%BRANCO/DOURADOS%'

/* BRASILIDADE
233950
463218

BRANCO DOURADOS
232511
464751
*/


SELECT FC_VINCULADO_NOM_GUERR(CTL_ptopd), r.* FROM ROTEIRO_MOTORISTA r
WHERE CTL_PLVIA = 0001349395


SELECT * FROM DESTINATARIO_PLANO_VIAGEM
WHERE CTL_PLVIA = 0001349395

SELECT * FROM PLANO_VIAGEM
WHERE CTL_PLVIA = 0001349395

select to_char(dhr_event,'DD/MM/YYYY HH24:MI:SS'), H.* from hist_log_monitora_terminal H
where cod_user = 'COMUNICADOR KRONA'
and num_termn = 203899
order by dhr_alter desc

select * from tipo_evento_terminal
order by dhr_alter desc

select * from tipo_parada
where sig_parad in ('IC', 'TC', 'ID','TD')


SELECT * FROM TIPO_EVENTO_TERMINAL
ORDER BY TIP_EVENT_TER

SELECT * FROM VINCULADO
WHERE ctl_vincd = 264646
SELECT * FROM TIPO_PARADA

 SELECT RPV.cod_parad_ref, RPV.ctl_parad
 FROM REF_PARADA_VINCULADO RPV,  PROVTECN_RELVINCD PR, PROVEDOR_TECNOLOGIA PT
 WHERE RPV.ctl_prove_vin = PR.ctl_prove_vin
 AND PT.ctl_prove_tec = PR.ctl_prove_tec
 AND PR.ctl_vincd = 264646
 AND PR.tip_relac = 2
 ORDER BY RPV.cod_parad_ref
 
 
 
 
/* INSERT RELACIONAMENTO VINCULADO - KRONA*/ 
 SELECT * FROM relacionamento_vinculado
 WHERE CTL_VINCD = 264646
 INSERT INTO RELACIONAMENTO_VINCULADO VALUES (2,271530,271530,'KRONA',SYSDATE)

/* INSERT PROVTECN RELVINCD - KRONA / PROVEDOR PAMCARY*/
 select * from PROVTECN_RELVINCD
 WHERE CTL_VINCD = 271530

 insert into PROVTECN_RELVINCD values ( 920, 15, 2, 271530,271530,null,'CARGA INICIAL KRONA',SYSDATE) 

 /* INSERT DE-PARA EVENTOS REF_PARADA_VINCULADO CONFORME LISTAGEM KRONA*/
select * from REF_PARADA_VINCULADO
where ctl_prove_vin = 920

INSERT INTO REF_PARADA_VINCULADO VALUES (920,20,13,'N',NULL,'CARGA INICIAL KRONA',SYSDATE)

delete REF_PARADA_VINCULADO
where ctl_prove_vin = 920
and cod_parad_ref = 2
SELECT ctl_parad, des_parad FROM tipo_parada  
order by ctl_parad
 
  
  
 SELECT * FROM REF_PARADA_VINCULADO
 
 
 
 SELECT * FROM PROVEDOR_TECNOLOGIA
 
 
 
 
 SELECT RPV.cod_parad_ref, RPV.ctl_parad, TP.sig_parad, TP.des_parad 
		FROM REF_PARADA_VINCULADO RPV,  PROVTECN_RELVINCD PR, TIPO_PARADA TP
		WHERE RPV.ctl_prove_vin = PR.ctl_prove_vin
    AND tp.ctl_parad = RPV.ctl_parad
		AND PR.ctl_vincd = 271530
		AND PR.tip_relac = 2
		ORDER BY TP. des_parad