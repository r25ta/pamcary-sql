--CONSULTA SEGURADO

SELECT
	DISTINCT s.CTL_PESSO AS id,
	s.NOM_PESSO AS nome,
	s.NOM_FANTS AS nomeFantasia,
	s.DES_TIPO_PES AS descricaoTipoPessoa,
	s.DES_TIPO_DOC AS descricaoTipoDocumento,
	s.COD_DOCUM_PRI AS codigoDocumento,
	s.NOM_VISAO_PAM AS nomeVisaoPamcary
FROM
	aplseg.v_crp_pessoa s,
	seg_proposta_seguro b
WHERE
	s.NUM_VISAO_PAM IN (1, 2)
	AND s.CTL_PESSO = b.CTL_CLIEN_PPS
	AND UPPER(s.NOM_PESSO) LIKE UPPER('%TRANSUL%')
     