/*pesquisaTarifaPropostaVigenciaPorPeriodo*/
select distinct vigenciata0_.NUM_SEQUE_VIG as NUM_SEQU1_14_0_, tarifaprop1_.NUM_SEQUE_TAR as NUM_SEQU1_6_1_, tipotarifa2_.NUM_TARIF as NUM_TARI1_11_2_, vigenciata0_.NUM_SEQUE_TAR as NUM_SEQU2_14_0_, vigenciata0_.VLR_TARIF as VLR_TARI3_14_0_, vigenciata0_.DAT_FIM_VIG as DAT_FIM_4_14_0_, vigenciata0_.DAT_INICI_VIG as DAT_INIC5_14_0_, tarifaprop1_.SEQ_NUMER_PRS as SEQ_NUME2_6_1_, tarifaprop1_.NUM_TARIF as NUM_TARI3_6_1_, tipotarifa2_.PCE_MULTI_TAR as PCE_MULT2_11_2_ from BILHET.TBIL_VIGENCIA_TAXA_CLIENTE vigenciata0_ inner join BILHET.TBIL_RELAC_TAXA_PROPOSTA tarifaprop1_ on vigenciata0_.NUM_SEQUE_TAR=tarifaprop1_.NUM_SEQUE_TAR inner join BILHET.TBIL_TIPO_TARIFA_PROPOSTA tipotarifa2_ on tarifaprop1_.NUM_TARIF=tipotarifa2_.NUM_TARIF 
where ((vigenciata0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (vigenciata0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
or (vigenciata0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (vigenciata0_.DAT_FIM_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
or (vigenciata0_.DAT_INICI_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (vigenciata0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59' ) 
or vigenciata0_.DAT_INICI_VIG<'2021-11-01 00:00:00' and vigenciata0_.DAT_FIM_VIG>'2021-11-30 23:59:59') 
and (tipotarifa2_.NUM_TARIF in (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 53, 36, 66, 74))



select tarifaperc0_.SEQ_NUMER_PEC as SEQ_NUME1_10_0_, tarifaperc1_.NUM_TARIF_PEC as NUM_TARI1_5_1_, tipotarifa2_.NUM_TARIF as NUM_TARI1_11_2_, localidade3_.SEQ_NUMER_LOC as SEQ_NUME1_16_3_, localidade4_.SEQ_NUMER_LOC as SEQ_NUME1_16_4_, tarifaperc0_.NUM_TARIF_PEC as NUM_TARI8_10_0_, tarifaperc0_.VLR_LIMIT_INF as VLR_LIMI2_10_0_, tarifaperc0_.VLR_LIMIT_SPE as VLR_LIMI3_10_0_, tarifaperc0_.DAT_FIM_VIG as DAT_FIM_4_10_0_, tarifaperc0_.DAT_INICI_VIG as DAT_INIC5_10_0_, tarifaperc0_.SEQ_NUMER_PRS as SEQ_NUME6_10_0_, tarifaperc0_.PCE_TARIF_PEC as PCE_TARI7_10_0_, tarifaperc1_.SEQ_LOCAL_DES as SEQ_LOCA2_5_1_, tarifaperc1_.SEQ_LOCAL_ORI as SEQ_LOCA3_5_1_, tarifaperc1_.NUM_TARIF as NUM_TARI4_5_1_, tipotarifa2_.PCE_MULTI_TAR as PCE_MULT2_11_2_, localidade3_.COD_IDENT_PAD as COD_IDEN2_16_3_, localidade3_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_3_, localidade3_.STA_NINFO as STA_NINF3_16_3_, localidade3_.STA_URSUB as STA_URSU4_16_3_, localidade3_.TIP_LOCAL as TIP_LOCA5_16_3_, localidade4_.COD_IDENT_PAD as COD_IDEN2_16_4_, localidade4_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_4_, localidade4_.STA_NINFO as STA_NINF3_16_4_, localidade4_.STA_URSUB as STA_URSU4_16_4_, localidade4_.TIP_LOCAL as TIP_LOCA5_16_4_ from BILHET.TBIL_TARIF_PERCU_PROPOSTA tarifaperc0_ inner join BILHET.TBIL_RELAC_TARIFA_PERCURSO tarifaperc1_ on tarifaperc0_.NUM_TARIF_PEC=tarifaperc1_.NUM_TARIF_PEC inner join BILHET.TBIL_TIPO_TARIFA_PROPOSTA tipotarifa2_ on tarifaperc1_.NUM_TARIF=tipotarifa2_.NUM_TARIF inner join BILHET.V_BIL_LOCALIDADE localidade3_ on tarifaperc1_.SEQ_LOCAL_ORI=localidade3_.SEQ_NUMER_LOC inner join BILHET.V_BIL_LOCALIDADE localidade4_ on tarifaperc1_.SEQ_LOCAL_DES=localidade4_.SEQ_NUMER_LOC 
where ((tarifaperc0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (tarifaperc0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
or (tarifaperc0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (tarifaperc0_.DAT_FIM_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
or (tarifaperc0_.DAT_INICI_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (tarifaperc0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
or tarifaperc0_.DAT_INICI_VIG<'2021-11-01 00:00:00' 
and tarifaperc0_.DAT_FIM_VIG>'2021-11-30 23:59:59') 
and (tipotarifa2_.NUM_TARIF in (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 53, 36, 66, 74))




select averbacao0_.SEQ_NUMER_AVB as SEQ_NUME1_4_0_
	, proposta1_.SEQ_NUMER_PRS as SEQ_NUME1_3_1_
	, fatura5_.SEQ_NUMER_FAT as SEQ_NUME1_2_2_
	, vencimento6_.SEQ_NUMER_PRS as SEQ_NUME1_13_3_
	, averbacaoi2_.NUM_AVERB_PAM as NUM_AVER1_1_4_
	, localidade3_.SEQ_NUMER_LOC as SEQ_NUME1_16_5_, localidade4_.SEQ_NUMER_LOC as SEQ_NUME1_16_6_, averbacao0_.NUM_ETAPA_AVB as NUM_ETAP2_4_0_, averbacao0_.SEQ_NUMER_PRS as SEQ_NUME4_4_0_, averbacao0_.VLR_IS as VLR_IS3_4_0_, averbacao0_1_.DHR_EMBAR as DHR_EMBA1_0_0_, averbacao0_1_.SEQ_LOCAL_DES as SEQ_LOC10_0_0_, averbacao0_1_.STA_AVARI as STA_AVAR2_0_0_, averbacao0_1_.IDT_TARIF as IDT_TARI3_0_0_, averbacao0_1_.STA_FLUVI as STA_FLUV4_0_0_, averbacao0_1_.NUM_AVERB_PAM as NUM_AVE11_0_0_, averbacao0_1_.SEQ_LOCAL_INT as SEQ_LOC12_0_0_, averbacao0_1_.SEQ_LOCAL_ORI as SEQ_LOC13_0_0_, averbacao0_1_.STA_PERNA_DES as STA_PERN5_0_0_, averbacao0_1_.STA_PERNA_ORI as STA_PERN6_0_0_, averbacao0_1_.IDT_CARGA_DSC as IDT_CARG7_0_0_, averbacao0_1_.TIP_ISENC_SEG as TIP_ISEN8_0_0_, averbacao0_1_.IDT_VEICU as IDT_VEIC9_0_0_, proposta1_.CTL_PEJUR_CIA as CTL_PEJU2_3_1_, proposta1_.NUM_COBER_BAS as NUM_COBE3_3_1_, proposta1_.CTL_PESSO_CLI as CTL_PESS4_3_1_, proposta1_.DAT_FIM_VIG as DAT_FIM_5_3_1_, proposta1_.NUM_APOLI as NUM_APOL6_3_1_, proposta1_.NUM_PERIO as NUM_PERI7_3_1_, proposta1_.NUM_RAMO_SEG as NUM_RAMO8_3_1_, proposta1_.NUM_ETAPA_PRS as NUM_ETAP9_3_1_, proposta1_.TIP_AVERB as TIP_AVE10_3_1_, proposta1_.TIP_NEGOC as TIP_NEG11_3_1_, fatura5_.DHR_FATUR as DHR_FATU2_2_2_, fatura5_.DAT_VENCI_FAT as DAT_VENC3_2_2_, fatura5_.NUM_MES_CPT as NUM_MES_4_2_2_, fatura5_.SIT_FATUR as SIT_FATU5_2_2_, fatura5_.SEQ_NUMER_PRS as SEQ_NUME6_2_2_, fatura5_.SEQ_NUMER_PRS as SEQ_NUME6_3_0__, fatura5_.SEQ_NUMER_FAT as SEQ_NUME1_2_0__, vencimento6_.NUM_DIA_VEC as NUM_DIA_2_13_3_, vencimento6_.NUM_PERIO_FAT as NUM_PERI3_13_3_, averbacaoi2_.SIT_TRANS as SIT_TRAN2_1_4_, averbacaoi2_.VLR_EMBAR_TOT as VLR_EMBA3_1_4_, averbacaoi2_.VLR_PAMTX as VLR_PAMT4_1_4_, localidade3_.COD_IDENT_PAD as COD_IDEN2_16_5_, localidade3_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_5_, localidade3_.STA_NINFO as STA_NINF3_16_5_, localidade3_.STA_URSUB as STA_URSU4_16_5_, localidade3_.TIP_LOCAL as TIP_LOCA5_16_5_, localidade4_.COD_IDENT_PAD as COD_IDEN2_16_6_, localidade4_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_6_, localidade4_.STA_NINFO as STA_NINF3_16_6_, localidade4_.STA_URSUB as STA_URSU4_16_6_, localidade4_.TIP_LOCAL as TIP_LOCA5_16_6_ 
from BILHET.TBIL_RELAC_AVERB_PROPT averbacao0_ 
	left outer join BILHET.TBIL_AVERBACAO averbacao0_1_ on averbacao0_.SEQ_NUMER_AVB=averbacao0_1_.SEQ_NUMER_AVB 
	inner join BILHET.TBIL_PROPOSTA proposta1_ on averbacao0_.SEQ_NUMER_PRS=proposta1_.SEQ_NUMER_PRS 
	left outer join BILHET.TBIL_FATURA fatura5_ on proposta1_.SEQ_NUMER_PRS=fatura5_.SEQ_NUMER_PRS 
	left outer join BILHET.TBIL_VENCIMENTO_FATURA_PROPT vencimento6_ 
	on fatura5_.SEQ_NUMER_PRS=vencimento6_.SEQ_NUMER_PRS 
	inner join BILHET.TBIL_AVERBACAO_INDICE averbacaoi2_ on averbacao0_1_.NUM_AVERB_PAM=averbacaoi2_.NUM_AVERB_PAM 
	left outer join BILHET.V_BIL_LOCALIDADE localidade3_ on averbacao0_1_.SEQ_LOCAL_ORI=localidade3_.SEQ_NUMER_LOC 
	left outer join BILHET.V_BIL_LOCALIDADE localidade4_ on averbacao0_1_.SEQ_LOCAL_DES=localidade4_.SEQ_NUMER_LOC 
where averbacao0_1_.DHR_EMBAR<= '2021-11-30 23:59:59'
and proposta1_.NUM_APOLI=5400027717
and averbacao0_.NUM_ETAPA_AVB=1 
and proposta1_.NUM_APOLI>0 
and proposta1_.NUM_PERIO=3 
and proposta1_.NUM_RAMO_SEG=1
ORDER BY  averbacao0_.SEQ_NUMER_AVB, fatura5_.SEQ_NUMER_FAT

/**AVERBAÇÕES CUSTOMIZADAS**/
select averbacao0_.SEQ_NUMER_AVB as SEQ_NUME1_4_0_
	, proposta1_.SEQ_NUMER_PRS as SEQ_NUME1_3_1_
	, averbacaoi2_.NUM_AVERB_PAM as NUM_AVER1_1_4_
	, localidade3_.SEQ_NUMER_LOC as SEQ_NUME1_16_5_
	, localidade4_.SEQ_NUMER_LOC as SEQ_NUME1_16_6_
	, averbacao0_.NUM_ETAPA_AVB as NUM_ETAP2_4_0_
	, averbacao0_.SEQ_NUMER_PRS as SEQ_NUME4_4_0_
	, averbacao0_.VLR_IS as VLR_IS3_4_0_
	, averbacao0_1_.DHR_EMBAR as DHR_EMBA1_0_0_, averbacao0_1_.SEQ_LOCAL_DES as SEQ_LOC10_0_0_, averbacao0_1_.STA_AVARI as STA_AVAR2_0_0_, averbacao0_1_.IDT_TARIF as IDT_TARI3_0_0_, averbacao0_1_.STA_FLUVI as STA_FLUV4_0_0_, averbacao0_1_.NUM_AVERB_PAM as NUM_AVE11_0_0_, averbacao0_1_.SEQ_LOCAL_INT as SEQ_LOC12_0_0_, averbacao0_1_.SEQ_LOCAL_ORI as SEQ_LOC13_0_0_, averbacao0_1_.STA_PERNA_DES as STA_PERN5_0_0_, averbacao0_1_.STA_PERNA_ORI as STA_PERN6_0_0_, averbacao0_1_.IDT_CARGA_DSC as IDT_CARG7_0_0_, averbacao0_1_.TIP_ISENC_SEG as TIP_ISEN8_0_0_, averbacao0_1_.IDT_VEICU as IDT_VEIC9_0_0_, proposta1_.CTL_PEJUR_CIA as CTL_PEJU2_3_1_, proposta1_.NUM_COBER_BAS as NUM_COBE3_3_1_, proposta1_.CTL_PESSO_CLI as CTL_PESS4_3_1_, proposta1_.DAT_FIM_VIG as DAT_FIM_5_3_1_, proposta1_.NUM_APOLI as NUM_APOL6_3_1_, proposta1_.NUM_PERIO as NUM_PERI7_3_1_, proposta1_.NUM_RAMO_SEG as NUM_RAMO8_3_1_, proposta1_.NUM_ETAPA_PRS as NUM_ETAP9_3_1_, proposta1_.TIP_AVERB as TIP_AVE10_3_1_, proposta1_.TIP_NEGOC as TIP_NEG11_3_1_, averbacaoi2_.SIT_TRANS as SIT_TRAN2_1_4_, averbacaoi2_.VLR_EMBAR_TOT as VLR_EMBA3_1_4_, averbacaoi2_.VLR_PAMTX as VLR_PAMT4_1_4_, localidade3_.COD_IDENT_PAD as COD_IDEN2_16_5_, localidade3_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_5_, localidade3_.STA_NINFO as STA_NINF3_16_5_, localidade3_.STA_URSUB as STA_URSU4_16_5_, localidade3_.TIP_LOCAL as TIP_LOCA5_16_5_, localidade4_.COD_IDENT_PAD as COD_IDEN2_16_6_, localidade4_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_6_, localidade4_.STA_NINFO as STA_NINF3_16_6_, localidade4_.STA_URSUB as STA_URSU4_16_6_, localidade4_.TIP_LOCAL as TIP_LOCA5_16_6_ 
from BILHET.TBIL_RELAC_AVERB_PROPT averbacao0_ 
	left outer join BILHET.TBIL_AVERBACAO averbacao0_1_ on averbacao0_.SEQ_NUMER_AVB=averbacao0_1_.SEQ_NUMER_AVB 
	inner join BILHET.TBIL_PROPOSTA proposta1_ on averbacao0_.SEQ_NUMER_PRS=proposta1_.SEQ_NUMER_PRS 
	inner join BILHET.TBIL_AVERBACAO_INDICE averbacaoi2_ on averbacao0_1_.NUM_AVERB_PAM=averbacaoi2_.NUM_AVERB_PAM 
	left outer join BILHET.V_BIL_LOCALIDADE localidade3_ on averbacao0_1_.SEQ_LOCAL_ORI=localidade3_.SEQ_NUMER_LOC 
	left outer join BILHET.V_BIL_LOCALIDADE localidade4_ on averbacao0_1_.SEQ_LOCAL_DES=localidade4_.SEQ_NUMER_LOC 
where averbacao0_1_.DHR_EMBAR BETWEEN '2021-12-01 00:00:00' AND '2021-12-31 23:59:59'
and proposta1_.NUM_APOLI=5400027717
and averbacao0_.NUM_ETAPA_AVB=1 
and proposta1_.NUM_APOLI>0 
and proposta1_.NUM_PERIO=3 
and proposta1_.NUM_RAMO_SEG=1
ORDER BY  averbacao0_.SEQ_NUMER_AVB


SELECT * FROM bilhet.TBIL_FATURA tf 
WHERE SEQ_NUMER_FAT = 7000170625

SELECT * FROM bilhet.TBIL_RELAC_AVERB_PROPT trap 
WHERE SEQ_NUMER_AVB = 894105231

SELECT * FROM bilhet.TBIL_RELAC_VISAO_PERCU_PADRA trvpp 
WHERE SEQ_NUMER_AVB  IN (
SELECT ta.SEQ_NUMER_AVB 
FROM bilhet.TBIL_AVERBACAO ta 
	INNER JOIN bilhet.TBIL_RELAC_AVERB_PROPT trap ON trap.SEQ_NUMER_AVB = ta.SEQ_NUMER_AVB
	INNER JOIN bilhet.TBIL_PROPOSTA tp ON tp.SEQ_NUMER_PRS = trap.SEQ_NUMER_PRS 
WHERE tp.NUM_APOLI = 5400023042
AND ta.DHR_EMBAR<= '2021-11-30 23:59:59'
AND trap.NUM_ETAPA_AVB =1
AND trap.SEQ_NUMER_FAT IS NULL )

ORDER BY ta.SEQ_NUMER_AVB 

SELECT * FROM bilhet.TBIL_FATURA tf 





/**Tarifa Mercado => Tarifa Percurso Vigencia pesquisarPorPeriodo**/
select tarifaperc0_.CTL_VIGEN_PEC as CTL_VIGE1_15_0_, tarifaperc1_.NUM_TARIF_PEC as NUM_TARI1_5_1_, tipotarifa2_.NUM_TARIF as NUM_TARI1_11_2_
	, localidade3_.SEQ_NUMER_LOC as SEQ_NUME1_16_3_, localidade4_.SEQ_NUMER_LOC as SEQ_NUME1_16_4_, tarifaperc0_.NUM_TARIF_PEC as NUM_TARI7_15_0_
	, tarifaperc0_.VLR_LIMIT_INF as VLR_LIMI2_15_0_, tarifaperc0_.VLR_LIMIT_SPE as VLR_LIMI3_15_0_, tarifaperc0_.DAT_FIM_VIG as DAT_FIM_4_15_0_
	, tarifaperc0_.DAT_INICI_VIG as DAT_INIC5_15_0_, tarifaperc0_.PCE_TARIF_PEC as PCE_TARI6_15_0_, tarifaperc1_.SEQ_LOCAL_DES as SEQ_LOCA2_5_1_
	, tarifaperc1_.SEQ_LOCAL_ORI as SEQ_LOCA3_5_1_, tarifaperc1_.NUM_TARIF as NUM_TARI4_5_1_, tipotarifa2_.PCE_MULTI_TAR as PCE_MULT2_11_2_
	, localidade3_.COD_IDENT_PAD as COD_IDEN2_16_3_, localidade3_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_3_, localidade3_.STA_NINFO as STA_NINF3_16_3_
	, localidade3_.STA_URSUB as STA_URSU4_16_3_, localidade3_.TIP_LOCAL as TIP_LOCA5_16_3_, localidade4_.COD_IDENT_PAD as COD_IDEN2_16_4_
	, localidade4_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_4_, localidade4_.STA_NINFO as STA_NINF3_16_4_, localidade4_.STA_URSUB as STA_URSU4_16_4_
	, localidade4_.TIP_LOCAL as TIP_LOCA5_16_4_ 
	from BILHET.TBIL_VIGEN_TARIFA_PERCURSO tarifaperc0_ 
		inner join BILHET.TBIL_RELAC_TARIFA_PERCURSO tarifaperc1_ on tarifaperc0_.NUM_TARIF_PEC=tarifaperc1_.NUM_TARIF_PEC 
		inner join BILHET.TBIL_TIPO_TARIFA_PROPOSTA tipotarifa2_ on tarifaperc1_.NUM_TARIF=tipotarifa2_.NUM_TARIF 
		inner join BILHET.V_BIL_LOCALIDADE localidade3_ on tarifaperc1_.SEQ_LOCAL_ORI=localidade3_.SEQ_NUMER_LOC 
		inner join BILHET.V_BIL_LOCALIDADE localidade4_ on tarifaperc1_.SEQ_LOCAL_DES=localidade4_.SEQ_NUMER_LOC 
	where ((tarifaperc0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
	and (tarifaperc0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or (tarifaperc0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
	and (tarifaperc0_.DAT_FIM_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or (tarifaperc0_.DAT_INICI_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
	and (tarifaperc0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or tarifaperc0_.DAT_INICI_VIG<'2021-11-01 00:00:00' and tarifaperc0_.DAT_FIM_VIG>'2021-11-30 23:59:59') 
and (tipotarifa2_.NUM_TARIF in (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 53, 36, 66, 74))
AND tarifaperc0_.CTL_VIGEN_PEC IN (186,645)




/**Tarifa Comercial -> pesquisaTarifaPropostaVigenciaPorPeriodo**/
select distinct vigenciata0_.NUM_SEQUE_VIG as NUM_SEQU1_14_0_, tarifaprop1_.NUM_SEQUE_TAR as NUM_SEQU1_6_1_
, tipotarifa2_.NUM_TARIF as NUM_TARI1_11_2_, vigenciata0_.NUM_SEQUE_TAR as NUM_SEQU2_14_0_, vigenciata0_.VLR_TARIF as VLR_TARI3_14_0_
, vigenciata0_.DAT_FIM_VIG as DAT_FIM_4_14_0_, vigenciata0_.DAT_INICI_VIG as DAT_INIC5_14_0_, tarifaprop1_.SEQ_NUMER_PRS as SEQ_NUME2_6_1_
, tarifaprop1_.NUM_TARIF as NUM_TARI3_6_1_, tipotarifa2_.PCE_MULTI_TAR as PCE_MULT2_11_2_ 
from BILHET.TBIL_VIGENCIA_TAXA_CLIENTE vigenciata0_ 
inner join BILHET.TBIL_RELAC_TAXA_PROPOSTA tarifaprop1_ on vigenciata0_.NUM_SEQUE_TAR=tarifaprop1_.NUM_SEQUE_TAR 
inner join BILHET.TBIL_TIPO_TARIFA_PROPOSTA tipotarifa2_ on tarifaprop1_.NUM_TARIF=tipotarifa2_.NUM_TARIF 
where ((vigenciata0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (vigenciata0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or (vigenciata0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (vigenciata0_.DAT_FIM_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or (vigenciata0_.DAT_INICI_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (vigenciata0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or vigenciata0_.DAT_INICI_VIG<'2021-11-01 00:00:00' and vigenciata0_.DAT_FIM_VIG>'2021-11-30 23:59:59') 
and (tipotarifa2_.NUM_TARIF in (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 53, 36, 66, 74))
AND tarifaprop1_.SEQ_NUMER_PRS = 502121


select tarifaperc0_.SEQ_NUMER_PEC as SEQ_NUME1_10_0_, tarifaperc1_.NUM_TARIF_PEC as NUM_TARI1_5_1_, tipotarifa2_.NUM_TARIF as NUM_TARI1_11_2_
, localidade3_.SEQ_NUMER_LOC as SEQ_NUME1_16_3_, localidade4_.SEQ_NUMER_LOC as SEQ_NUME1_16_4_, tarifaperc0_.NUM_TARIF_PEC as NUM_TARI8_10_0_
, tarifaperc0_.VLR_LIMIT_INF as VLR_LIMI2_10_0_, tarifaperc0_.VLR_LIMIT_SPE as VLR_LIMI3_10_0_, tarifaperc0_.DAT_FIM_VIG as DAT_FIM_4_10_0_
, tarifaperc0_.DAT_INICI_VIG as DAT_INIC5_10_0_, tarifaperc0_.SEQ_NUMER_PRS as SEQ_NUME6_10_0_, tarifaperc0_.PCE_TARIF_PEC as PCE_TARI7_10_0_
, tarifaperc1_.SEQ_LOCAL_DES as SEQ_LOCA2_5_1_, tarifaperc1_.SEQ_LOCAL_ORI as SEQ_LOCA3_5_1_, tarifaperc1_.NUM_TARIF as NUM_TARI4_5_1_
, tipotarifa2_.PCE_MULTI_TAR as PCE_MULT2_11_2_, localidade3_.COD_IDENT_PAD as COD_IDEN2_16_3_, localidade3_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_3_
, localidade3_.STA_NINFO as STA_NINF3_16_3_, localidade3_.STA_URSUB as STA_URSU4_16_3_, localidade3_.TIP_LOCAL as TIP_LOCA5_16_3_
, localidade4_.COD_IDENT_PAD as COD_IDEN2_16_4_, localidade4_.SEQ_LOCAL_PAI as SEQ_LOCA6_16_4_, localidade4_.STA_NINFO as STA_NINF3_16_4_
, localidade4_.STA_URSUB as STA_URSU4_16_4_, localidade4_.TIP_LOCAL as TIP_LOCA5_16_4_ 
from BILHET.TBIL_TARIF_PERCU_PROPOSTA tarifaperc0_ 
inner join BILHET.TBIL_RELAC_TARIFA_PERCURSO tarifaperc1_ on tarifaperc0_.NUM_TARIF_PEC=tarifaperc1_.NUM_TARIF_PEC 
inner join BILHET.TBIL_TIPO_TARIFA_PROPOSTA tipotarifa2_ on tarifaperc1_.NUM_TARIF=tipotarifa2_.NUM_TARIF 
inner join BILHET.V_BIL_LOCALIDADE localidade3_ on tarifaperc1_.SEQ_LOCAL_ORI=localidade3_.SEQ_NUMER_LOC 
inner join BILHET.V_BIL_LOCALIDADE localidade4_ on tarifaperc1_.SEQ_LOCAL_DES=localidade4_.SEQ_NUMER_LOC 
where ((tarifaperc0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (tarifaperc0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or (tarifaperc0_.DAT_INICI_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (tarifaperc0_.DAT_FIM_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or (tarifaperc0_.DAT_INICI_VIG not between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') 
and (tarifaperc0_.DAT_FIM_VIG between '2021-11-01 00:00:00' and '2021-11-30 23:59:59') or tarifaperc0_.DAT_INICI_VIG<'2021-11-01 00:00:00' and tarifaperc0_.DAT_FIM_VIG>'2021-11-30 23:59:59') 
and (tipotarifa2_.NUM_TARIF in (1, 2, 8, 3, 4, 5, 6, 7, 9, 10, 15, 16, 31, 32, 33, 34, 35, 37, 38, 39, 14, 53, 36, 66, 74))
AND tarifaperc0_.SEQ_NUMER_PRS = 502121
