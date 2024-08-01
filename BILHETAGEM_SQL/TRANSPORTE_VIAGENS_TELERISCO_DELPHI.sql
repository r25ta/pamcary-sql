SELECT
	DISTINCT a.dat_embar,
	A.VLR_EMBAR,
	k.des_praca,
	A.CTL_AVERB,
	A.NUM_LOCAL_ORI,
	A.NUM_PRACA_EMI,
	C.NOM_MOTOT,
	C.COD_DOCUM_MOT,
	V.COD_IDENT_VEI,
	J.sig_unfed
FROM
	AVERBACAO A,
	PRACA K,
	AVERBACAO_VEICULO V,
	MOTORISTA_MOVTO C,
	UNIDADE_FEDERAL J,
	AVERBACAO_MOTOT M
WHERE
	A.CTL_AVERB NOT IN (SELECT CTL_AVERB FROM relac_averb_mdfe)
	AND A.CTL_AVERB = M.CTL_AVERB
	AND M.CTL_MOTOT = C.CTL_MOTOT
	AND A.CTL_AVERB = V.CTL_AVERB
	AND A.NUM_LOCAL_ORI = J.NUM_UNFED
AND C.COD_DOCUM_MOT <> '00000000000'
AND c.nom_motot <> 'NAO IDENTIFICADO'
AND a.num_praca_ori = k.num_praca

--Se tipo = automático
AND date(a.dhr_entra) BETWEEN '2024-07-01' AND '2024-07-01'
--Se não
--AND date(a.dhr_entra) BETWEEN '2024-07-01' AND '2024-07-11'

--Se averbações = com MDFE
--AND a.ctl_averb IN (901265071, 901267077)
--SubQuerys executadas no Looping da Query #1




--#1.1
SELECT
	vinc.cod_docum
FROM
	averbacao_indice ind,
	doc_vinculado vinc
WHERE
	ind.ctl_vincd_sed = vinc.ctl_vincd
	AND ind.ctl_averb = 

--#1.2
SELECT
	b.des_praca
FROM
	item_destino a,
	praca b
WHERE
	a.num_praca = b.num_praca
	AND a.ctl_averb = :query#1.CTL_AVERB

-- Query #2:
SELECT
	MANIF.COD_CHAVE_MAN AS CHAVE_MDFE,
	MANIF.CTL_MANIF AS CTL_MDFE,
	CAV.COD_PLACA_TCA AS PLACA_CAVALO,
	COALESCE(CAV.COD_RENAV_TCA, ' ' ) AS RENAVAM_CAVALO,
	COALESCE(CAV.COD_CPF_PRP, CAV.COD_CNPJ_PRP) AS DOCUMENTO_PROPRIETARIO,
	CAV.NOM_PROPR AS NOME_PROPRIETARIO,
	MANIF.SIG_UNFED_ORI AS UF_ORIGEM,
	MANIF.SIG_UNFED_DES AS UF_DESTINO,
	DATE(MANIF.DHR_CHANC_MAN) AS DATA_EMBARQUE,
	TIME(MANIF.DHR_CHANC_MAN) AS HORA_EMBARQUE,
	MANIF.VLR_CARGA AS VALOR_EMBARQUE,
	MANIF.COD_CNPJ_EMI_DEC
FROM
	MDFE.TMDFE_MANIFESTO MANIF ,
	MDFE.TMDFE_MANIF_RODOV_TRACAO CAV
WHERE
	MANIF.IDT_SITUA_MAN <> 'C'
	AND MANIF.CTL_MANIF = CAV.CTL_MANIF
	--Se averbações = sem MDFE
--	AND manif.ctl_manif = 8080579
	--Se tipo = automático
	AND DATE(MANIF.DHR_INCLU) BETWEEN '2024-07-01 00:00:00' AND '2024-07-01 23:59:59'
	--Se não
--	AND DATE(MANIF.DHR_INCLU) BETWEEN :dataInformadaEmTela AND :dataInformadaEmTela
GROUP BY
	MANIF.COD_CHAVE_MAN,
	MANIF.CTL_MANIF,
	CAV.COD_PLACA_TCA,
	CAV.COD_RENAV_TCA,
	COALESCE(CAV.COD_CPF_PRP, CAV.COD_CNPJ_PRP) ,
	CAV.NOM_PROPR,
	MANIF.SIG_UNFED_ORI,
	MANIF.SIG_UNFED_DES,
	DATE(MANIF.DHR_CHANC_MAN),
	TIME(MANIF.DHR_CHANC_MAN),
	MANIF.VLR_CARGA,
	MANIF.COD_CNPJ_EMI_DEC  
  OPTIMIZE FOR 1 ROWS WITH UR

--SubQuerys executadas no Looping da Query #2

--#2.1
SELECT
	num_praca_emi
FROM
	averbacao a,
	relac_averb_mdfe b
WHERE
	a.ctl_averb = b.ctl_averb
	AND b.ctl_manif = :query#2.CTL_MDFE

--#2.2
SELECT
	vinc.cod_docum
FROM
	averbacao_indice ind ,
	relac_averb_mdfe relac,
	doc_vinculado vinc
WHERE
	ind.ctl_averb = relac.ctl_averb
	AND ind.ctl_vincd_sed = vinc.ctl_vincd
	AND relac.ctl_manif = 13279185 

	
--#2.3
SELECT
	MAX(DOC.NOM_PRACA_DGA) AS CIDADE_DESTINO
FROM
	MDFE.TMDFE_MANIFESTO_DOC_CHAVE DOC
WHERE
	DOC.ctl_manif = :query#2.ctl_mdfe

-- Query #3:
SELECT
	MOT.CTL_MANIF,
	MOT.COD_DOCUM_MOT AS CPF_MOTORISTA,
	MOT.NOM_MOTOT AS NOME_MOTORISTA
FROM
	MDFE.TMDFE_MANIF_RODOV_MOTOT MOT
WHERE
	MOT.CTL_MANIF = :query#2.ctl_mdfe
--SubQuerys executadas no Looping da Query #3, dentro do looping da query #2 quando  query#3. ctl_manif = query#2. ctl_mdfe

--#2.3.1
SELECT
	MUNORI.CTL_MANIF,
	MUNORI.NOM_MUNIC_CARREG AS CIDADE_ORIGEM
FROM
	MDFE.TMDFE_MUNICIPIO_CARREGA MUNORI
WHERE
	MUNORI.ctl_manif = :query#2.ctl_mdfe


--Se query#2.3.1. ctl_manif = query#2.ctl_mdfe: Escreve arquivo para exportação
