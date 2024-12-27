SELECT
count (*)
FROM
	BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB DW
WHERE
dw.sta_down = 'N'
AND DHR_ALTER < '2024-09-01 00:00:00'
AND 
	NOT EXISTS (
	SELECT
		NOM_ARQUI
	FROM
		DOWNLOAD_ARQUIVO DA
	WHERE DA.NOM_ARQUI = DW.NOM_ARQUI )
ORDER BY
	DHR_ALTER ASC

	
SELECT * FROM bilhet.TBIL_FILA_ARQUIVO_DOCUM_WEB tfadw	

SELECT * FROM bilhet.TBIL_PROPOSTA p
INNER JOIN bilhet.TBIL_FATURA f ON f.seq_numer_prs = p.seq_numer_prs
INNER JOIN bilhet.TBIL_ARQUIVO_DOCUMENTO_WEB a ON a.SEQ_NUMER_FAT = f.SEQ_NUMER_FAT 
WHERE p.NUM_RAMO_SEG = 69

SELECT * FROM bilhet.TBIL_ARQUIVO_DOCUMENTO_WEB tadw 
WHERE SEQ_NUMER_FAT = 7000336796
	
UPDATE bilhet.TBIL_ARQUIVO_DOCUMENTO_WEB SET 
	STA_DOWN = 'S'
WHERE SEQ_NUMER_FAT IN ( 
SELECT
	SEQ_NUMER_FAT	
FROM
	BILHET.TBIL_ARQUIVO_DOCUMENTO_WEB DW
WHERE
dw.sta_down = 'N'
AND DHR_ALTER < '2024-09-01 00:00:00'
AND 
	NOT EXISTS (
	SELECT
		NOM_ARQUI
	FROM
		DOWNLOAD_ARQUIVO DA
	WHERE DA.NOM_ARQUI = DW.NOM_ARQUI )

)
COMMIT



SELECT * FROM bilhet.TBIL_FATURA tf 
WHERE SIT_FATUR  IN (3,6)
ORDER BY DHR_ALTER DESC 