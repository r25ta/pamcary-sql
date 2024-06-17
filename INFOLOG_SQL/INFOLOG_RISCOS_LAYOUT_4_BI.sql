/*INFORMA합ES DA VIAGEM */
SELECT PV.ctl_plvia AS plano
	   , (SELECT DFC.COD_DOCUM_FIS 
			FROM DOCUMENTO_FISCAL_CLIENTE DFC
				,RELAC_PLVIA_DOCUMENTO RPD 
				WHERE RPD.CTL_DOCUM_CLI = DFC.CTL_DOCUM_CLI 
					AND RPD.CTL_PLVIA = PV.CTL_PLVIA 
					AND RPD.ORD_DESTI = 0
					AND DFC.TIP_DOCUM_FIS = 7 ) AS doc_proprio_cliente
	,PV.des_praca_ult AS local_ultima_posicao
	,TO_CHAR(PV.dhr_posic_ult,'dd/mm/yyyy hh24:mi') AS data_hora
	,FC_VINCULADO_NOM_GUERR(PV.ctl_remet) AS origem
	,FC_VINCULADO_NOM_GUERR(PV.ctl_desti) AS ultimo_destino
	,SPV.des_situa AS etapa
	,PV.OBS_PLVIA 
FROM PLANO_VIAGEM PV
	,SITUACAO_PLANO_VIAGEM SPV
WHERE PV.sit_plvia = SPV.sit_plvia
AND PV.ctl_plvia =11409768

/*INFORMA합ES DOS VEICULOS*/
SELECT v.ctl_veicu
	   ,v.cod_placa
	   ,v.nom_categ_vei
FROM INF_VEICU_PLANO_VIAGEM IVPV 
	,V_CRP_VEICULO V
WHERE IVPV.ctl_veicu = V.ctL_veicu
AND IVPV.ctl_plvia = 11409768


/*INFORMA합ES DOS MOTORISTAS*/
SELECT IMPV.ord_motot
	  ,P.nom_pesso
	  ,IMPV.tip_vincu_mot 
FROM INF_MOTORISTA_PLANO_VIAGEM IMPV
	,V_CRP_PESSOA P
WHERE P.ctl_pesso = IMPV.ctl_motot
AND IMPV.ctl_plvia =11409768

/*INFORMA합ES DOS DESTINOS*/
SELECT RM.ctl_rtmot
	   ,RM.ctl_plvia
	   ,RM.ctl_parad
	   ,RM.ord_desti
	   ,FC_VINCULADO_NOM_GUERR(RM.ctl_parad) AS destino
	   ,TO_CHAR(RM.dhr_previ_sis, 'DD/MM/YYYY HH24:MI') AS dhr_previ
	   ,TO_CHAR(RM.dhr_efeti_rea, 'DD/MM/YYYY HH24:MI') AS dhr_real
FROM ROTEIRO_MOTORISTA RM 
WHERE RM.ctl_plvia = 11409768
AND RM.CTL_PARAD IN (24,10,12)
ORDER BY RM.ORD_DESTI 


/*DOCUMENTOS DESTINO*/
SELECT RPD.CTL_DESTI 
	  ,RPD.ORD_DESTI 
	  ,DFC.COD_DOCUM_FIS
	  ,TDF.DES_DOCUM_FIS 
FROM DOCUMENTO_FISCAL_CLIENTE DFC
	,RELAC_PLVIA_DOCUMENTO RPD 
	,TIPO_DOCUMENTO_FISCAL TDF
WHERE RPD.CTL_DOCUM_CLI = DFC.CTL_DOCUM_CLI 
	AND TDF.tip_docum_fis = DFC.TIP_DOCUM_FIS 
	AND RPD.ORD_DESTI > 0
	AND RPD.CTL_PLVIA = 11409768
ORDER BY RPD.ORD_DESTI	
	