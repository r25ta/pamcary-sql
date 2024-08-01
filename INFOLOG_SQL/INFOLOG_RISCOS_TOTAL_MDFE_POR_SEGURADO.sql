/*TOTAL DE MDF-E POR SEGURADO*/

SELECT DOC_TRANSPORTADOR as CNPJ_TRANSPORTADOR, NOM_TRANSPORTADOR AS SUBSTR, COUNT(*) AS Total_Embarques
FROM inf_viagem_mdfe
WHERE dhr_embar between '2024-06-01 00:00:00' and '2024-06-30 23:59:59'
GROUP BY DOC_TRANSPORTADOR, NOM_TRANSPORTADOR;


