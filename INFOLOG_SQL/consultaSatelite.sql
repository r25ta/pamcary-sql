/* SELECT PARA FAZER PAGINAÇÃO DE REGISTROS DIRETO NO BD
   ONDE O PRIMEIRO PARAMENTRO ROWNUM É INFORMADO A QTDE DE REGISTROS A SER APRESENTADO
   E O SEGUNDO PARAMENTRO RNUM SIGNIFICA A POSICAO DE INICIO */

SELECT * FROM
    (SELECT registros.*, rownum rnum FROM
        ( /*SELECT NORMAL DE SATELITES*/  
          SELECT LMT.num_seque_ter, NVL(LMT.num_contr_cga,0), LMT.num_termn,  LMT.num_latit,
            LMT.num_longi,LMT.des_event, TET.des_event_ter,  LMT.tip_event_ter, LMT.sta_event,
            LMT.sta_leitu, NVL(LMT.sta_leitu_cga,' '),  TO_CHAR(LMT.dhr_event,'DD/MM/YYYY HH24:MI:SS'),
            TO_CHAR(LMT.dhr_alter,'DD/MM/YYYY HH24:MI:SS'),  NVL(TO_CHAR(LMT.dhr_inclu_cga,'DD/MM/YYYY HH24:MI:SS'),' '),
            NVL(PT.des_prove_tec,' ') AS des_prove_tec , NVL(TET.sig_event_ter,' ') AS sig_event_ter
          FROM LOG_MONITORA_TERMINAL LMT, TIPO_EVENTO_TERMINAL TET, PROVEDOR_TECNOLOGIA PT
          WHERE TET.tip_event_ter = LMT.tip_event_ter
            AND PT.ctl_prove_tec = LMT.ctl_prove_tec
            AND LMT.num_termn = 1111111
            AND LMT.dhr_event BETWEEN TO_DATE('20050510000000','YYYYMMDDHH24MISS') AND TO_DATE('20051010235959','YYYYMMDDHH24MISS')
            AND LMT.tip_event_ter <> 99
          ORDER BY dhr_event DESC
        ) registros
        WHERE rownum <= 15 ) WHERE  rnum >= 1
