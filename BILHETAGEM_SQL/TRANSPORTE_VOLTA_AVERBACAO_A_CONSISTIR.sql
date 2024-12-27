SELECT count(1) FROM apltrans.AVERBACAO_CONSISTENCIA 
WHERE CTL_AVERB IN (SELECT ai.ctl_averb FROM AVERBACAO_INDICE ai INNER JOIN AVERBACAO a 
	ON a.CTL_AVERB = ai.CTL_AVERB 
	WHERE ai.CTL_PESSO = 1107534
	AND ai.NUM_RAMO =1
	AND ai.SIT_AVERB in(5)
	AND dat_embar BETWEEN '2024-10-01' AND CURRENT timestamp 
)


SELECT * FROM apltrans.AVERBACAO_ERRO 
WHERE CTL_AVERB IN (
922332537,
922334627,
922335056,
922363125,
922454160,
922456894,
922462108,
922467207,
922467497,
922485489,
922527699,
922528689,
922528753,
922528811,
922529410,
922540798,
922541245,
922541571,
922542096,
922545338,
922546006,
922547934,
922548100,
922619392,
922634886,
922636925,
922637000,
922643503,
922653620,
922701690,
922701804,
922701944,
922702578,
922723012,
922723683,
922723858,
922724399,
922734029,
922734064,
922785015,
922840453,
922844249,
922869117,
922874667,
922886701

)


SELECT * FROM apltrans.AVERBACAO_INDICE 
WHERE CTL_AVERB IN (
922332537,
922334627,
922335056,
922363125,
922454160,
922456894,
922462108,
922467207,
922467497,
922485489,
922527699,
922528689,
922528753,
922528811,
922529410,
922540798,
922541245,
922541571,
922542096,
922545338,
922546006,
922547934,
922548100,
922619392,
922634886,
922636925,
922637000,
922643503,
922653620,
922701690,
922701804,
922701944,
922702578,
922723012,
922723683,
922723858,
922724399,
922734029,
922734064,
922785015,
922840453,
922844249,
922869117,
922874667,
922886701

)

COMMIT

delete FROM apltrans.AVERBACAO_CONSISTENCIA 
WHERE CTL_AVERB IN (
SELECT ai.ctl_averb FROM AVERBACAO_INDICE ai INNER JOIN AVERBACAO a 
	ON a.CTL_AVERB = ai.CTL_AVERB 
	WHERE ai.CTL_PESSO = 1107534
	AND ai.NUM_RAMO =1
	AND ai.SIT_AVERB in(5)
	AND dat_embar BETWEEN '2024-10-01' AND CURRENT timestamp 
)


DELETE apltrans.AVERBACAO_ERRO 
WHERE CTL_AVERB IN (
SELECT ai.ctl_averb FROM AVERBACAO_INDICE ai INNER JOIN AVERBACAO a 
	ON a.CTL_AVERB = ai.CTL_AVERB 
	WHERE ai.CTL_PESSO = 1107534
	AND ai.NUM_RAMO =1
	AND ai.SIT_AVERB in(5)
	AND dat_embar BETWEEN '2024-10-01' AND CURRENT timestamp 
)


INSERT INTO AVERBACAO_CONSISTENCIA 
(CTL_AVERB ,CTL_USER ,DHR_ALTER , SIT_AVERB ,NUM_SEQ)
SELECT CTL_AVERB, 15, CURRENT timestamp, 0, 0 
FROM APLTRANS.AVERBACAO 
WHERE CTL_AVERB IN ( 
SELECT ai.ctl_averb FROM AVERBACAO_INDICE ai INNER JOIN AVERBACAO a 
	ON a.CTL_AVERB = ai.CTL_AVERB 
	WHERE ai.CTL_PESSO = 1107534
	AND ai.NUM_RAMO =1
	AND ai.SIT_AVERB in(5)
	AND dat_embar BETWEEN '2024-10-01' AND CURRENT timestamp 
)



update APLTRANS.AVERBACAO_INDICE SET 
SIT_AVERB = 0 
,NUM_PROPT = NULL 
WHERE CTL_AVERB IN (
SELECT ai.ctl_averb FROM AVERBACAO_INDICE ai INNER JOIN AVERBACAO a 
	ON a.CTL_AVERB = ai.CTL_AVERB 
	WHERE ai.CTL_PESSO =1107534
	AND ai.NUM_RAMO =1
	AND ai.SIT_AVERB in(5)
	AND dat_embar BETWEEN '2024-10-01' AND CURRENT timestamp 
)







COMMIT 