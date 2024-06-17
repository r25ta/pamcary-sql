SELECT DISTINCT MM.num_mct AS id_device,
       'PAMSAT' AS sistema,
       '1' AS lote,
       DV.cod_docum AS codclipag,
       DV.cod_docum AS codcliex,
       DV.cod_docum AS codclilig,
       FC_VINCULADO_NOM_GUERR(MM.ctl_trnsp) AS nomvincd,
       'S' AS integraerp,
       'SP000' AS codpraca,
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') || '.000' AS dt_post,
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') || '.000' AS hr_post,
       TO_CHAR(SYSDATE,'YYYY-MM') ||'-01 ' || TO_CHAR(SYSDATE,'HH24:MI:SS') || '.000' AS competencia,
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') || '.000' AS dt_bilh,
       '04010001' AS produto,
       '1' AS qtde,
       '01' AS empresaorig,
       'S' AS origem
FROM mct_macro MM, doc_vinculado DV
WHERE TO_CHAR(MM.dhr_event,'YYYYMMDD') BETWEEN '20040101' AND '20040131'
    AND MM.ctl_trnsp = DV.ctl_vincd
GROUP BY cod_docum , num_mct ,  fc_vinculado_nom_guerr(ctl_trnsp), dhr_event
