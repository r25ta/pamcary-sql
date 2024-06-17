/*
TABELA BILHET.TBIL_SITUACAO_FATURA
SIT_FATUR

1	N�o Processada
2	Processada
3	Cancelada
4	Inclus�o Manual
5	Pr�mio M�nimo
6	Cancelada
7	DCSIS
8	Processada Taxa Roubo
9	Parcela Fixa
10	Complementar
*/
/*
TABELA TBIL_MOTIVO_SITUACAO
NUM_MOTIV_SIT

1	REEMISS�O PARA ACERTO DE COMISS�O
2	AP�LICE CANCELADA
3	EMBARQUES EM DUPLICIDADE
4	AP�LICE REEMITIDA PARA ACERTO DE COMISS�O
5	VALOR DE MERCADORIA INCORRETO
6	FATURA EMITIDA EM DUPLICIDADE
8	CANCELAMENTO FINANCEIRO
9	VENCIMENTO INCORRETO
10	AP�LICE SUSPENSA
15	ACERTO CIA PR X SINISTRO
17	EMISS�O INDEVIDA
18	EXTRAVIO - REEMISS�O COM NOVO VENCIMENTO
19	AP�LICE CANCELADA, REEMISS�O COM PR. PROPORCIONAL
21	ALTERA��O DE ENDERE�O E OU RAZ�O SOCIAL
22	ERRO DE EMISS�O POR PARTE DA CIA
23	AP�LICE AJUST�VEL, CANC. REEMIS�O P/ AJUSTE DO PR�MIO
24	FATURAS EMITIDAS SEM COSSEGURO
25	INCORRE��O NO C�LCULO DO PR�MIO
26	AP�LICE AJUST�VEL - CANCELADA POR FALTA DE PAGAMENTO
27	FATURA CANCELADA POR FALTA DE PAGAMENTO
28	COBRAN�A INDEVIDA DE PR. FIXO PARA ISEN��O DA P.O.S
29	INCORRE��O NA COBRAN�A DO PR. FIXO PARA ISEN��O DA P.O.S
30	ALTERA��O RETROATIVA DE CRIT�RIO
31	DUPLICIDADE DE CONTA MENSAL
32	RCF-CA NAO E NECESS�RIO FAZER CARTA
33	FATURA SUPER ESTIMADA
34	FATURA CANCELADA,PARA EMISS�O COM VALOR REAL
35	FACE EXTR.REEM.COM NOVO VENCTO
36	CIA EMITIU SEM DESCONTO
37	SEGURADO POSSU� FATURAMENTO MENSAL
38	FATURA ESTIMADA, REEMITIDA COM VALOR REAL
39	APL REEMITIDA P/ ACERTO COMISS�O/SAS
40	REDU��O DE PR. M�NIMO
41	EMITIDA �NICA FATURA MENSAL
42	ALTERA��O RETROATIVA DE PR. M�NIMO
43	ALTERA��O DE VIG�NCIA DA AP�LICE
44	AUDITORIA, SINISTROS NEGADOS.
45	ACERTO PR�MIO/M�S
46	REEMISS�O/CIA CANC. POR FALTA DE PAGTO
47	INCORRE��O DE PR�MIO DE PAMTAX
48	FATURA EMITIDA EM R$, SENDO CORRETO U$
49	FATURA EMITIDA EM U$, SENDO CORRETO R$
50	ALTERA��O DE CORRETAGEM
51	CANCELAMENTO RETROATIVO DE AP�LICE
52	AVERBA��O FORA DO PRAZO BARE DEVOLVEU
53	SEM MOVTO, N�O EMITE FATURA COM PR�MIO M�NIMO
54	REEMISS�O NA SUCURSAL CORRETA
55	LAN�AMENTO INCORRETO CONTA NORMAL DEVERIA SER AJ
56	AP�LICE AJUSTAVEL PARCELAS REEMITIDAS ACERTOS DVS
57	APL CANC PARA ACERTO DE COMISS�O CHUBB
58	TRANSFERIDA PARA O BILHETAGEM, NAO CONSTOU NO IBM
59	FATURA INCLUSA NO BILHETAGEM
101	T�cnico
*/


/*LOCALIZAR FATURAS ATRAV�S DO N�MERO DA APOLICE*/
select * from bilhet.tbil_proposta
where --seq_numer_prs = 502908
num_apoli = 3836002205255

/*ATRAV�S DO SEQ_NUMER_PRS � POSSIVEL LOCALIZAR AS FATURAS NA TABELA TBIL_FATURA*/
seq_numer_prs = 502908
num_propt = 19005983


select f.seq_numer_fat
	, f.SEQ_NUMER_PRS
	, f.NUM_MES_CPT 
	,f.SIT_FATUR 
	,sf.DES_SITUA_FAT 
	,f.NUM_MOTIV_SIT 
	,ms.NOM_MOTIV_SIT 
	, f.dhr_fatur
from bilhet.tbil_fatura f
, bilhet.tbil_situacao_fatura sf
, bilhet.TBIL_MOTIVO_SITUACAO ms
where 1 = 1
AND sf.SIT_FATUR = f.SIT_FATUR
AND ms.NUM_MOTIV_SIT = f.NUM_MOTIV_SIT 
/*
and seq_numer_prs = 498011 
order by dhr_fatur desc
*/
and f.seq_numer_fat in (
7000329829
)



/*ATIVAR FATURA*/

update bilhet.TBIL_FATURA f set 
  f.SIT_FATUR = 2
, f.NUM_MOTIV_SIT = 5 
where 1=1 
and f.SEQ_NUMER_FAT in (
7000329829
)

COMMIT 

SELECT NUM_PROPT, NUM_APOLI, NUM_CIA_PAM  FROM SEGURO.TSEG_PROPOSTA_SEGURO tps 
WHERE NUM_APOLI IN (
SELECT NUM_APOLI  FROM BILHET.TBIL_PROPOSTA tp 
WHERE SEQ_NUMER_PRS IN (SELECT SEQ_NUMER_PRS FROM BILHET.TBIL_FATURA tf
WHERE seq_numer_fat IN (
SELECT NOSSO_NUMERO  FROM bilhet.V_BIL_ENVIA_COBRANCA 
WHERE cia = 367)))
