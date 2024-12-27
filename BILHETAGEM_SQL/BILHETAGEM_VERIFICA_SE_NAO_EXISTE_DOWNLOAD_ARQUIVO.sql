SELECT SEQ_NUMER_FAT, NOM_ARQUI 
FROM bilhet.TBIL_ARQUIVO_DOCUMENTO_WEB tadw
WHERE 1=1
--  AND NOM_ARQUI LIKE '%2020%'
  AND DHR_ALTER < '2024-06-01 00:00:00'
  AND STA_DOWN = 'N'
  AND NOT EXISTS (
    SELECT 1 
    FROM BILHET.TBIL_RETOR_FATURA_CIA trfc 
    WHERE trfc.SEQ_NUMER_FAT = tadw.SEQ_NUMER_FAT
  )
  AND EXISTS(
  	SELECT 1 
  	FROM DBPROD.DOWNLOAD_ARQUIVO DDA 
  	WHERE DDA.NOM_ARQUI = TADW.NOM_ARQUI 
  )		

  SELECT * FROM bilhet.TBIL_ARQUIVO_DOCUMENTO_WEB tadw 
  WHERE nom_arqui LIKE '%7000324224%'
  
  SELECT * FROM DOWNLOAD_ARQUIVO 
  WHERE NOM_ARQUI LIKE '%avi202402-MENSAL_07000324224_rcfdc_5500020149.pdf%'
  
  
commit  
 UPDATE BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB SET 
 STA_DOWN = 'S'
 WHERE SEQ_NUMER_FAT IN (
7000303176,
7000306771,
7000306771,
7000306769,
7000306772,
7000306772)

COMMIT