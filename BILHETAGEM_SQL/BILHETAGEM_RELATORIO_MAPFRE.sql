SELECT DISTINCT F.SEQ_NUMER_FAT AS FATURA,
        P.NUM_APOLI AS APOLICE,
        R.SIG_RAMO AS RAMO,
        CIA.NOM_PESSO AS SEGURADORA,
        F.NUM_FATUR_CIA AS NR_FATURA_CIA,
        CLI.NOM_FANTS AS SEGURADO,
        TO_CHAR(F.DAT_VENCI_FAT,'DD/MM/YYYY') AS VENCIMENTO,
        CASE WHEN P.TIP_NEGOC =1 THEN 'Pamcary' ELSE 'Pamcorp' END AS NEGOCIO,
        TO_CHAR(F.DHR_ALTER,'DD/MM/YYYY') AS ULTIMA_ALTERACAO,
        F.NUM_MES_CPT AS COMPETENCIA,
        (SELECT ST.VLR_CALCU FROM APLBIL.BIL_VALOR_SOMA_TIPO_TARIFA ST WHERE ST.SEQ_NUMER_FAT = F.SEQ_NUMER_FAT AND ST.NUM_TARIF = 61 FETCH FIRST 1 ROWS ONLY) AS PREMIO_LIQUIDO,
        F.COD_USER AS USUARIO
FROM APLBIL.BIL_FATURA F 
INNER JOIN APLBIL.BIL_PROPOSTA P ON (F.SEQ_NUMER_PRS = P.SEQ_NUMER_PRS)
INNER JOIN PAMAIS.V_CRP_PESSOA CIA ON (P.CTL_PEJUR_CIA = CIA.CTL_PESSO AND CIA.TIP_PESSO = 1)
INNER JOIN PAMAIS.V_CRP_PESSOA CLI ON (P.CTL_PESSO_CLI = CLI.CTL_PESSO AND CLI.TIP_PESSO = 1) 
INNER JOIN PAMAIS.V_CRP_RAMO_SEGURO  R ON (P.NUM_RAMO_SEG = R.NUM_RAMO_SEG)   
WHERE F.SEQ_NUMER_FAT IN(
7000151326,
7000151612,
7000151699,
7000153839,
7000152960,
7000152959,
7000151787,
7000152139,
7000152138,
7000151973,
7000152617,
7000152615,
7000153891,
7000151879,
7000151345,
7000151361,
7000151822,
7000151936,
7000153432,
7000151788,
7000152213,
7000153322,
7000152443,
7000151789,
7000152207,
7000152618,
7000151790,
7000153546,
7000153860,
7000151913,
7000151322,
7000153181,
7000152593,
7000152242,
7000152417,
7000153298,
7000151424,
7000151791,
7000153404,
7000151704,
7000153503,
7000152212,
7000153789,
7000152272,
7000151916,
7000151875,
7000153189,
7000152916,
7000152390,
7000152311,
7000153085,
7000152938,
7000152937,
7000151595,
7000151421,
7000153637,
7000151792,
7000151954,
7000153195,
7000151300,
7000152451,
7000151583,
7000151389,
7000151428,
7000153711,
7000153360,
7000152619,
7000152388,
7000152309,
7000153112,
7000151264,
7000151793,
7000153064,
7000153059,
7000153824,
7000153823,
7000152599,
7000151564,
7000152097,
7000151847,
7000151915,
7000151205,
7000151204,
7000151457,
7000152300,
7000152385,
7000151394,
7000153493,
7000152768,
7000151431,
7000153753,
7000151228,
7000153576,
7000151314,
7000152769,
7000152279,
7000151974,
7000153428,
7000151458,
7000151500,
7000151244,
7000151243,
7000153388,
7000151337,
7000153346,
7000152287,
7000151408,
7000151415,
7000153066,
7000153863,
7000153323,
7000151273,
7000152463,
7000152449,
7000153541,
7000153540,
7000151260,
7000152480,
7000151535,
7000153081,
7000153080,
7000151652,
7000151527,
7000151794,
7000153455,
7000151444,
7000151392,
7000152949,
7000151553,
7000151396,
7000151340,
7000151383,
7000151365,
7000153128,
7000150836,
7000151403,
7000151380,
7000151941,
7000151342,
7000151407,
7000151397,
7000151409,
7000151338,
7000151325,
7000151384,
7000151982,
7000153562,
7000151294,
7000152944,
7000152945,
7000151758,
7000152065,
7000153287,
7000151435,
7000151459,
7000152918,
7000151159,
7000153871,
7000154109,
7000151657,
7000153874,
7000151274,
7000152438,
7000152597,
7000152595,
7000152089,
7000151836,
7000150046,
7000151862,
7000153324,
7000151563,
7000154224,
7000154223,
7000151945,
7000151449,
7000153307,
7000148594,
7000151857,
7000153280,
7000151310,
7000153697,
7000153696,
7000153650,
7000153648,
7000151942,
7000151600,
7000153271,
7000153446,
7000153257,
7000151349,
7000153290,
7000153325,
7000153311,
7000151944,
7000152850,
7000153297,
7000151662,
7000153491,
7000152184,
7000152017,
7000151668,
7000151453,
7000152973,
7000152907,
7000151518,
7000152419,
7000153443,
7000151439,
7000153048,
7000151423,
7000148984,
7000148878,
7000148985,
7000148879,
7000151242,
7000151211,
7000154158,
7000154159,
7000153383,
7000153382,
7000152389,
7000152310,
7000153389,
7000152956,
7000152582,
7000152401,
7000152948,
7000152584,
7000152185,
7000153942,
7000153941,
7000153520,
7000153519,
7000151436,
7000150615,
7000152441,
7000153352,
7000152132,
7000153256,
7000151955,
7000153228,
7000152196,
7000153400,
7000152911,
7000148732,
7000152396,
7000152081,
7000151824,
7000151860,
7000152402,
7000152090,
7000151837,
7000151232,
7000153733,
7000152141,
7000151461,
7000153067,
7000153065,
7000153063,
7000151917,
7000153056,
7000152614,
7000152613,
7000153301,
7000152403,
7000152243,
7000151931,
7000151158,
7000152181,
7000153585,
7000151313,
7000153728,
7000151305,
7000152915,
7000152765,
7000151742,
7000154186,
7000152751,
7000152391,
7000153449,
7000152158,
7000152262,
7000152434,
7000153744,
7000153743,
7000151979,
7000152259,
7000151312,
7000151387,
7000151328,
7000152140,
7000151376,
7000152913,
7000152903,
7000151248,
7000151420,
7000152425,
7000151934,
7000153545,
7000153862,
7000151462,
7000153264,
7000151433,
7000152249,
7000153647,
7000151495,
7000153548,
7000153867,
7000153754,
7000153372,
7000152077,
7000151777,
7000153429,
7000151402,
7000153260,
7000153549,
7000153868,
7000150205,
7000153787,
7000151508,
7000152005,
7000151643,
7000152904,
7000152219,
7000153183,
7000153586,
7000152494,
7000153678,
7000151296,
7000151287,
7000152341,
7000152183,
7000152303,
7000152469,
7000151901,
7000152404,
7000153184,
7000153182,
7000151953,
7000153879,
7000153877,
7000153875,
7000151681,
7000151070,
7000151751,
7000152220,
7000152470,
7000153326,
7000151268,
7000153284,
7000151277,
7000151284,
7000151528,
7000151821,
7000153415,
7000153414,
7000151413,
7000152036,
7000151707,
7000151443,
7000153812,
7000153811,
7000154269,
7000154270,
7000154271,
7000150121,
7000153686,
7000153684,
7000153809,
7000153808,
7000153806,
7000153805,
7000154302,
7000154303,
7000154304,
7000154305,
7000152124,
7000151352,
7000151635,
7000151610,
7000153296,
7000153603,
7000153091,
7000153845,
7000153337,
7000151336,
7000151254,
7000153327,
7000151544,
7000151515,
7000151465,
7000153305,
7000153766,
7000153767,
7000152759,
7000151307,
7000151970,
7000152143,
7000152142,
7000153295,
7000153328,
7000152114,
7000151876,
7000151956,
7000151900,
7000153141,
7000153140,
7000151907,
7000152972,
7000153522,
7000152190,
7000151795,
7000153286,
7000152744,
7000152659,
7000151513,
7000153547,
7000150271,
7000154043,
7000154042,
7000153408,
7000151763,
7000151584,
7000152952,
7000152940,
7000151299,
7000152161,
7000151899,
7000152586,
7000153721,
7000152927,
7000152325,
7000152324,
7000150111,
7000149978,
7000149977,
7000149976,
7000149975,
7000153890,
7000151589,
7000151759,
7000152221,
7000152304,
7000151869,
7000152932,
7000151890,
7000151775,
7000152929,
7000152173,
7000152971,
7000152222,
7000153550,
7000153869,
7000151796,
7000153777,
7000153775,
7000153513,
7000151362,
7000151529,
7000152096,
7000151843,
7000151659,
7000153345,
7000153299,
7000152086,
7000151832,
7000153512,
7000152612,
7000152416,
7000153207,
7000153206,
7000152942,
7000153568,
7000152012,
7000151654,
7000151568,
7000153391,
7000153390,
7000153794,
7000151980,
7000152144,
7000152001,
7000151636,
7000152076,
7000151774,
7000151893,
7000153402,
7000152167,
7000151570,
7000152200,
7000153651,
7000153511,
7000152010,
7000151650,
7000151546,
7000153622,
7000151309,
7000151558,
7000151426,
7000152878,
7000153553,
7000153876,
7000151251,
7000151414,
7000153315,
7000152153,
7000151304,
7000153474,
7000153092,
7000153090,
7000152223,
7000153330,
7000151270,
7000151603,
7000153355,
7000153354,
7000152224,
7000153232,
7000151984,
7000153098,
7000153097,
7000152003,
7000151640,
7000152002,
7000151639,
7000151798,
7000152018,
7000151670,
7000152344,
7000152203,
7000152357,
7000152241,
7000153343,
7000151552,
7000151615,
7000151885,
7000152117,
7000153152,
7000153151,
7000153164,
7000153163,
7000153174,
7000153173,
7000151286,
7000153760,
7000153759,
7000152101,
7000151855,
7000152471,
7000151427,
7000152762,
7000151653,
7000153730,
7000151367,
7000152194,
7000153241,
7000152367,
7000152258,
7000152549,
7000154261,
7000154260,
7000151501,
7000152316,
7000151908,
7000151688,
7000153873,
7000153331,
7000151289,
7000152392,
7000152313,
7000152969,
7000153506,
7000151271,
7000152764,
7000152348,
7000152209,
7000151318,
7000154257,
7000154256,
7000153441,
7000151927,
7000151447,
7000152447,
7000152460,
7000152452,
7000153557,
7000154075,
7000153885,
7000153880,
7000153716,
7000151319,
7000151301,
7000151411,
7000151972,
7000151288,
7000152488,
7000151532,
7000150021,
7000151978,
7000153108,
7000153475,
7000152164,
7000153347,
7000152446,
7000151055,
7000151952,
7000152225,
7000153433,
7000152039,
7000151711,
7000152405,
7000153439,
7000153212,
7000151344,
7000153510,
7000152071,
7000151765,
7000152202,
7000151469,
7000153313,
7000151919,
7000151395,
7000151769,
7000151649,
7000153221,
7000153693,
7000153666,
7000154034,
7000150865,
7000150864,
7000150854,
7000150853,
7000150845,
7000150842,
7000152226,
7000152011,
7000151651,
7000152358,
7000152244,
7000152596,
7000151631,
7000153608,
7000151256,
7000151764,
7000152070,
7000152943,
7000151562,
7000151573,
7000153236,
7000152934,
7000152933,
7000154367,
7000151434,
7000152587,
7000151588,
7000151947,
7000151493,
7000151957,
7000151502,
7000152941,
7000152406,
7000152590,
7000153222,
7000153223,
7000151905,
7000153251,
7000151470,
7000152407,
7000151958,
7000153320,
7000152293,
7000151779,
7000151599,
7000152486,
7000152346,
7000152205,
7000151911,
7000151799,
7000153242,
7000153418,
7000151316,
7000152288,
7000153460,
7000153224,
7000152099,
7000151850,
7000152589,
7000153560,
7000154076,
7000153561,
7000154097,
7000154283,
7000154284,
7000151950,
7000151399,
7000151943,
7000152408,
7000151655,
7000152968,
7000153308,
7000151331,
7000151445,
7000151638,
7000153333,
7000151874,
7000151315,
7000153597,
7000151516,
7000152343,
7000152191,
7000151303,
7000153225,
7000151253,
7000151275,
7000153185,
7000152078,
7000151785,
7000151717,
7000152195,
7000153217,
7000153336,
7000152472,
7000153312,
7000152270,
7000152283,
7000151904,
7000152382,
7000152297,
7000151977,
7000151441,
7000151471,
7000151290,
7000151448,
7000152334,
7000152174,
7000151432,
7000153203,
7000153204,
7000152377,
7000152280,
7000152091,
7000151838,
7000153109,
7000153106,
7000153226,
7000151800,
7000151586,
7000151726,
7000151554,
7000153610,
7000153607,
7000152062,
7000151753,
7000151545,
7000151601,
7000152061,
7000151750,
7000153278,
7000151928,
7000151504,
7000152055,
7000151738,
7000152278,
7000151437,
7000152455,
7000151820,
7000151454,
7000152355,
7000152239,
7000153230,
7000151801,
7000152087,
7000151833,
7000151317,
7000153765,
7000153244,
7000153243,
7000152365,
7000152256,
7000151834,
7000153110,
7000151378,
7000151930,
7000151590,
7000151844,
7000153281,
7000151597,
7000152364,
7000152253,
7000153592,
7000154182,
7000151534,
7000151388,
7000153799,
7000152409,
7000152410,
7000152227,
7000151575,
7000152286,
7000152165,
7000151773,
7000151985,
7000151373,
7000151602,
7000153227,
7000151259,
7000150113,
7000153817,
7000151671,
7000152479,
7000152228,
7000151706,
7000152019,
7000151672,
7000153365,
7000153314,
7000152229,
7000152133,
7000153358,
7000151455,
7000151683,
7000151266,
7000152127,
7000153107,
7000153105,
7000152095,
7000151842,
7000153563,
7000154092,
7000151429,
7000151898,
7000153523,
7000152485,
7000152361,
7000152247,
7000151728,
7000151903,
7000152050,
7000151733,
7000152230,
7000153385,
7000153384,
7000151630,
7000153294,
7000151933,
7000152037,
7000151708,
7000153566,
7000154094,
7000153458,
7000153424,
7000153567,
7000151269,
7000152473,
7000151909,
7000152411,
7000152112,
7000151873,
7000151802,
7000151530,
7000151951,
7000154171,
7000154170,
7000151803,
7000152038,
7000151710,
7000153302,
7000151723,
7000151261,
7000152496,
7000151385,
7000153465,
7000153247,
7000152188,
7000151846,
7000151291,
7000151306,
7000151298,
7000151521,
7000152092,
7000151839,
7000152093,
7000151840,
7000153457,
7000151700,
7000152032,
7000152057,
7000151741,
7000152238,
7000153714,
7000152094,
7000151841,
7000153229,
7000152412,
7000151442,
7000151780,
7000153798,
7000153797,
7000153796,
7000151946,
7000151412,
7000151718,
7000152044,
7000151948,
7000152379,
7000152290,
7000151724,
7000152340,
7000152180,
7000152497,
7000153214,
7000151674,
7000153213,
7000154077,
7000152152,
7000153618,
7000151475,
7000151533,
7000152041,
7000151713,
7000153920,
7000152573,
7000153309,
7000151311,
7000151498,
7000151684,
7000151555,
7000153881,
7000154102,
7000154006,
7000151525,
7000151519,
7000153235,
7000154054,
7000151391,
7000152121,
7000153456,
7000152275,
7000151363,
7000152464,
7000153602,
7000153601,
7000151476,
7000151490,
7000153427,
7000153079,
7000153233,
7000151988,
7000151374,
7000153680,
7000152198,
7000151364,
7000153438,
7000151333,
7000151556,
7000153410,
7000153237,
7000153565,
7000151353,
7000151531,
7000151355,
7000151341,
7000153486,
7000151335,
7000151375,
7000153275,
7000151404,
7000151350,
7000153727,
7000151370,
7000151356,
7000151405,
7000151371,
7000151339,
7000152906,
7000152928,
7000151406,
7000153838,
7000151348,
7000151368,
7000151359,
7000151366,
7000153496,
7000151372,
7000151354,
7000151393,
7000151327,
7000151283,
7000151379,
7000154160,
7000151390,
7000152163,
7000153087,
7000153570,
7000154233,
7000153303,
7000153784,
7000152284,
7000152115,
7000151877,
7000153077,
7000152166,
7000153259,
7000152849,
7000152908,
7000153462,
7000153571,
7000153461,
7000151845,
7000152474,
7000151929,
7000152193,
7000153338,
7000151745,
7000152350,
7000152214,
7000151805,
7000151386,
7000152448,
7000151806,
7000151438,
7000151867,
7000152110,
7000152339,
7000152179,
7000151781,
7000153061,
7000151506,
7000151624,
7000152285,
7000152378,
7000152215,
7000152351,
7000152216,
7000151265,
7000151263,
7000151258,
7000154244,
7000152029,
7000151693,
7000151807,
7000153572,
7000154103,
7000153795,
7000152475,
7000154246,
7000154343,
7000151346,
7000151358,
7000154155,
7000152231,
7000153078,
7000153778,
7000153231,
7000153359,
7000151416,
7000153201,
7000153261,
7000153833,
7000152393,
7000152314,
7000152260,
7000151776,
7000153319,
7000152027,
7000151690,
7000153406,
7000152397,
7000152282,
7000151499,
7000153220,
7000153219,
7000154116,
7000154101,
7000151430,
7000151808,
7000152356,
7000152240,
7000153342,
7000151520,
7000153349,
7000153505,
7000151910,
7000151343,
7000151369,
7000153544,
7000152103,
7000151859,
7000152756,
7000151543,
7000153710,
7000153310,
7000152375,
7000152271,
7000151715,
7000153289,
7000151329,
7000152958,
7000152591,
7000151949,
7000151509,
7000153614,
7000153187,
7000153194,
7000152045,
7000151719,
7000152413,
7000151924,
7000153849,
7000153577,
7000154107,
7000153664,
7000152611,
7000152610,
7000153706,
7000153663,
7000152946,
7000152395,
7000151932,
7000153437,
7000151784,
7000152400,
7000153252,
7000149341,
7000149339,
7000151598,
7000152328,
7000152160,
7000152585,
7000151720,
7000149226,
7000151330,
7000153316,
7000153628,
7000152042,
7000151714,
7000152374,
7000152268,
7000151351,
7000153129,
7000152963,
7000152484,
7000151748,
7000151809,
7000151676,
7000153392,
7000151596,
7000151377,
7000151511,
7000153339,
7000151605,
7000151257,
7000152917,
7000153434,
7000153239,
7000151417,
7000153255,
7000153254,
7000153127,
7000152235,
7000153837,
7000153417,
7000152289,
7000151975,
7000153292,
7000153334,
7000153332,
7000153329,
7000153579,
7000151295,
7000151056,
7000152299,
7000151854,
7000152176,
7000152336,
7000152218,
7000152353,
7000153340,
7000151701,
7000152491,
7000152967,
7000151585,
7000151810,
7000152067,
7000151761,
7000153341,
7000152006,
7000151644,
7000153238,
7000153111,
7000153776,
7000153772,
7000152936,
7000151752,
7000151811,
7000151812,
7000152487,
7000151308,
7000153578,
7000154110,
7000151594,
7000151637,
7000152345,
7000152204,
7000153055,
7000152394,
7000151778,
7000152056,
7000151740,
7000152060,
7000151746,
7000153274,
7000153273,
7000153272,
7000151550,
7000152281,
7000153285,
7000151446,
7000151937,
7000151622,
7000153407,
7000151579,
7000152399,
7000153713,
7000153895,
7000153894,
7000152197,
7000151722,
7000151819,
7000151613,
7000152269,
7000151398,
7000153810,
7000152383,
7000152298,
7000152467,
7000152035,
7000151814,
7000153500,
7000153394,
7000153395,
7000153393,
7000153440,
7000152277,
7000153580,
7000150874,
7000150686,
7000154111,
7000152954,
7000152305,
7000151749,
7000151481,
7000153131,
7000153188,
7000153135,
7000152129,
7000151976,
7000152476,
7000152022,
7000151677,
7000153574,
7000153573,
7000153581,
7000154121,
7000153248,
7000153866,
7000153865,
7000151709,
7000151483,
7000152109,
7000151866,
7000153584,
7000154124,
7000151959,
7000153589,
7000150870,
7000154178,
7000151686,
7000151618,
7000152131,
7000151660,
7000153893,
7000151514,
7000152291,
7000152338,
7000152178,
7000152030,
7000151694,
7000153202,
7000151853,
7000152294,
7000153726,
7000152414,
7000151177,
7000152440,
7000151621,
7000153593,
7000154108,
7000151912,
7000151608,
7000151547,
7000152384,
7000152295,
7000153304,
7000153283,
7000151656,
7000151488,
7000151450,
7000153126,
7000152957,
7000153317,
7000151489,
7000152477,
7000152376,
7000152276,
7000153351,
7000151935,
7000152436,
7000153583,
7000153582,
7000152192,
7000152468,
7000152330,
7000152169,
7000152232,
7000153627,
7000153626,
7000152252,
7000153878,
7000154104,
7000151896,
7000151983,
7000153587,
7000154128,
7000153249,
7000151981,
7000151517,
7000153300,
7000152418,
7000151561,
7000151522,
7000153629,
7000153113,
7000153117,
7000152758,
7000152953,
7000152930,
7000153291,
7000151661,
7000154037,
7000151782,
7000152453,
7000153123,
7000153551,
7000152970,
7000151815,
7000152592,
7000151739,
7000151925,
7000152466,
7000152098,
7000151591,
7000151816,
7000152749,
7000153840,
7000153841,
7000152598,
7000152233,
7000153124,
7000153125,
7000153250,
7000152761,
7000152760,
7000151987,
7000152594,
7000152465,
7000151965,
7000151964,
7000152616,
7000153595,
7000151505,
7000151321,
7000152490,
7000152489,
7000151381,
7000153075,
7000153758,
7000151400,
7000153813,
7000151698,
7000153265,
7000153262,
7000151771,
7000153405,
7000153403,
7000153604,
7000153494,
7000151297,
7000152047,
7000151729,
7000152757,
7000152126,
7000153804,
7000153803,
7000153801,
7000153800,
7000153387,
7000153386,
7000153447,
7000152601,
7000153502,
7000153501,
7000152255,
7000153060,
7000152398,
7000153293,
7000151830,
7000152016,
7000151666,
7000152033,
7000151702,
7000152905,
7000152481,
7000153487,
7000152026,
7000151689,
7000152100,
7000151852,
7000152387,
7000152306,
7000151497,
7000153306,
7000151401,
7000152104,
7000151861,
7000151679,
7000152920,
7000152251,
7000151938,
7000151357,
7000152767,
7000152766,
7000151828,
7000154165,
7000151332,
7000152931,
7000153712,
7000151817,
7000152368,
7000152261,
7000150978,
7000153350,
7000151818,
7000152064,
7000151756,
7000152750,
7000152745,
7000151894,
7000151240,
7000151592,
7000151440,
7000153481,
7000153480,
7000152748,
7000151721,
7000153598,
7000154190,
7000153518,
7000152415,
7000151678
)
