/*ESTATISTICAS COMUNICADOR*/
SELECT HH.COD_DOCUM_PVT AS DOCUMENTO, PT.NOM_FANTS AS TECNOLOGIA, 
HH.QTD_LEITU AS QTD_LEITURA, HH.QTD_REPRV AS QTD_REPROVADOS, HH.QTD_APROV AS QTD_APROVADOS,
HH.PCE_LEITU AS PERC_LEITURA, DHR_ALTER
FROM HIST_ESTATISTICA_PROCESSAMENTO HH, V_CRP_PROVEDOR_TECNOLOGIA PT
WHERE DHR_ALTER BETWEEN TO_DATE('20190825000000','YYYYMMDDHH24MISS') AND TO_DATE('20190826235959','YYYYMMDDHH24MISS')
AND HH.COD_DOCUM_PVT = PT.COD_DOCUM_PRI
ORDER BY DHR_ALTER, PT.NOM_FANTS;

/*TOTALIZADOR POR TECNOLOGIA*/
SELECT PT.NOM_FANTS AS TECNOLOGIA, SUM(HH.QTD_LEITU) AS LEITURA
FROM HIST_ESTATISTICA_PROCESSAMENTO HH, V_CRP_PROVEDOR_TECNOLOGIA PT
WHERE DHR_ALTER BETWEEN TO_DATE('20180826000000','YYYYMMDDHH24MISS') AND TO_DATE('20180827235959','YYYYMMDDHH24MISS')
AND HH.COD_DOCUM_PVT = PT.COD_DOCUM_PRI
GROUP BY PT.NOM_FANTS;
