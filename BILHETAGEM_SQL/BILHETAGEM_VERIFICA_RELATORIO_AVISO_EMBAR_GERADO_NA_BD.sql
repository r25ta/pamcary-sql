

SELECT * FROM bilhet.TBIL_ARQUIVO_DOCUMENTO_WEB tadw 
WHERE SEQ_NUMER_FAT IN (7000316044,7000319838,7000323548,7000327268,7000330233,7000333331,7000337935,7000340635)



SELECT * FROM bilhet.TBIL_RETOR_FATURA_CIA trfc 
WHERE SEQ_NUMER_FAT IN (7000316044,7000319838,7000323548,7000327268,7000330233,7000333331,7000337935,7000340635)


SELECT * FROM DBPROD.DOWNLOAD_ARQUIVO 
WHERE NOM_ARQUI LIKE '%7000340635%'

/*excluir */
DELETE FROM bilhet.TBIL_ARQUIVO_DOCUMENTO_WEB tadw 
WHERE SEQ_NUMER_FAT IN (7000316044,7000319838,7000323548,7000327268,7000330233,7000333331,7000337935,7000340635)


/*excluir*/
DELETE FROM DBPROD.DOWNLOAD_ARQUIVO 
WHERE num_arqui IN (823224,823225,827072,827073,832039,832040,836232,836233,838973,838974,842630,842631,848041,848042,851288,853731)

COMMIT

/*conferir se os relatórios serão gerados*/
SELECT * FROM (
			 	SELECT F.SEQ_NUMER_FAT as fatura,
			        P.NUM_APOLI as apolice,
			        P.NUM_RAMO_SEG as ramo,
			        F.NUM_MES_CPT as competencia,
			        F.NUM_PERIO_FAT as periodo,
			        '' as caminho,  
			        F.SIT_FATUR as situacao,  
			        (SELECT COUNT(D.SEQ_NUMER_FAT) FROM BIL_ARQUIVO_DOCUMENTO_WEB D WHERE D.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND D.NUM_ARQUI_RET =2) as aviso, 
			        CASE WHEN (SELECT COUNT(S.SEQ_NUMER_FAT) FROM BIL_VALOR_SOMA_TIPO_TARIFA S WHERE S.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND S.NUM_TARIF = 70 AND S.VLR_CALCU > 1 AND F.SIT_FATUR NOT IN(1,3,4,6))>0 THEN  
			         (SELECT COUNT(D.SEQ_NUMER_FAT) FROM BIL_ARQUIVO_DOCUMENTO_WEB D WHERE D.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND D.NUM_ARQUI_RET =1)
			        ELSE -1 END AS embarque, 
			        CASE WHEN (SELECT COUNT(S.SEQ_NUMER_FAT) FROM BIL_VALOR_SOMA_TIPO_TARIFA S WHERE S.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND S.NUM_TARIF = 27)>0 THEN  
			         (SELECT COUNT(D.SEQ_NUMER_FAT) FROM BIL_ARQUIVO_DOCUMENTO_WEB D WHERE D.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND D.NUM_ARQUI_RET =9) 
			        ELSE -1 END AS pamtax, 
			        COALESCE((SELECT V.CTL_VINCD FROM DBPROD.DOC_VINCULADO V WHERE V.COD_DOCUM = VP.COD_DOCUM_PRI AND VP.TIP_PESSO = 1),0) codigoVinculado, 
			        H.NUM_SETOR_PAM AS numeroFilial, 
			        CO.NUM_CORRE_PAM AS codigoCorretor, 
		            PR.CTL_PRODR AS codigoProdutor 
			 FROM BIL_FATURA F INNER JOIN BIL_PROPOSTA P ON (F.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS)   
			 INNER JOIN PAMAIS.V_CRP_PESSOA VP ON (P.CTL_PESSO_CLI = VP.CTL_PESSO AND VP.TIP_PESSO = 1) 
			 INNER JOIN PAMAIS.V_CRP_CORRETOR_PARCEIRO CO ON (P.CTL_CORRE = CO.CTL_CORRE) 
			 INNER JOIN BIL_HIERQ_PRODR_PROPT PR ON (P.SEQ_NUMER_PRS = PR.SEQ_NUMER_PRS) 
			 INNER JOIN APLBIL.V_CRP_HIERARQUIA_COMERCIAL H ON (PR.NUM_HIERQ = H.NUM_HIERQ AND H.TIP_SETOR = 2) 
			 LEFT JOIN BIL_ARQUIVO_DOCUMENTO_WEB D ON (F.SEQ_NUMER_FAT = D.SEQ_NUMER_FAT)  
			 WHERE F.SIT_FATUR NOT IN(1,3,6) AND F.NUM_FATUR_CIA > 0  
			 AND P.NUM_RAMO_SEG <> 69  --NAO RETORNAR RC-V
			 AND F.SEQ_NUMER_FAT 
				IN (7000316044,7000319838,7000323548,7000327268,7000330233,7000333331,7000337935,7000340635)
--			 AND F.NUM_MES_CPT BETWEEN '20240202' AND '20240229' 
		
			) A 
			WHERE codigovinculado > 0 
--					 AND AVISO = 0  --0 - não foram gerados
					 AND EMBARQUE = 0 
--					 AND PAMTAX = 0 
			 OPTIMIZE FOR 1 ROWS WITH UR

