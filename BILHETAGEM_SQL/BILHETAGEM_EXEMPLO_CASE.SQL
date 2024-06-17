  SELECT DISTINCT periodofat.nom_perio_fat
			 ,CASE
			        WHEN UPPER(periodofat.nom_perio_fat) = 'MENSAL' THEN 'C.MENSAL'
			        ELSE periodofat.nom_perio_fat
			    END AS periodo
       FROM
           APLBIL.BIL_PERIODO_FATURA periodofat
       WHERE
           periodofat.num_perio_fat IN (1,2,3,4)   