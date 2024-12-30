--30-12-2024 SUBSTITUICAO DAS TABELAS DE:VINCULADO E DOC_VINCULADO PARA PESSOA
--30-12-2024 SUBSTITUICAO DA TABELA DE: APOLICE PARA: PROPOSTA_SEGURO
CREATE OR REPLACE PROCEDURE DBPROD.SP_INSERE_AVB_ATM
    (IN V_CTL_ATM BIGINT) RESULT SETS 1
---MODIFIES SQL DATA
NOT
DETERMINISTIC NULL CALL
LANGUAGE SQL EXTERNAL ACTION
BEGIN
DECLARE
    v_step smallint;


    --
    ----------------------------------------------------------
    -- INÍIO
    ----------------------------------------------------------	
    -- IníVariá
DECLARE
    X_CTL_AVERB BIGINT;


    --
    --
DECLARE
    X_CTL_VINCD BIGINT;


    --
DECLARE
    X_CTL_PESSO BIGINT;


    --
    --
DECLARE
    X_NUM_RAMO INTEGER;


    --
    --
DECLARE
    X_CTL_MOTOT BIGINT;


    --
    --
DECLARE
    X_DHR_ALTER TIMESTAMP;


    --
    --
DECLARE
    X_DAT_EMISS_DOC DATE;


    --
    --
DECLARE
    X_HOR_EMISS_DOC TIME;


    --
    --
DECLARE
    X_SIT_MONIT SMALLINT;


    --
    --
DECLARE
    X_SIT_ESCOL SMALLINT;


    --
    --
DECLARE
    X_NUM_LOCAL_DES SMALLINT;


    --
    --
DECLARE
    D_NUM_LOCAL_DES SMALLINT;


    --
    --
DECLARE
    X_NUM_LOCAL_ORI SMALLINT;


    --
    --
DECLARE
    X_DHR_EMBAR TIMESTAMP;


    --
    --
DECLARE
    X_TIP_ISENC_SEG SMALLINT;


    --
    --
DECLARE
    X_DAT_EMB DATE;


    --
    --
DECLARE
    X_HOR_EMB TIME;


    --
    --
DECLARE
    X_TIP_DOCUM_TRA SMALLINT;


    --
    --
DECLARE
    X_COD_PRACA_ORI INTEGER;


    --
    --
DECLARE
    X_COD_PRACA_DES INTEGER;


    --
    --
DECLARE
    X_PRACA_ORI_EXP INTEGER;


    --
    --
DECLARE
    X_PRACA_DES_EXP INTEGER;


    --
    --
DECLARE
    X_STA_COBER_RDC CHAR;


    --
    --
DECLARE
    X_ERROS SMALLINT;


    --
    --
DECLARE
    X_NUM_MOEDA SMALLINT;


    --
    --
DECLARE
    X_DUPLI1 BIGINT;


    --
    --
DECLARE
    X_DUPLI2 BIGINT;


    --
    --
DECLARE
    X_VLR_MERCA_COM_IMPOSTO FLOAT;


    --
    --    
DECLARE
    X_SIT_TRANS INTEGER;


    --
    --
DECLARE
    X_SIT_AVERB INTEGER;


    --
    --
DECLARE
    X_NUM_SEQUE_ITE INTEGER;


    --
    --
DECLARE
    X_NUM_CONHE INTEGER;


    --
    --
DECLARE
    X_COD_MANIF VARCHAR(30);


    --
    --
DECLARE
    X_NUM_NTFIS INTEGER;


    --
    --
DECLARE
    X_VLR_MERCA FLOAT;


    --
    --
DECLARE
    X_COD_CEP_ORI VARCHAR(8);


    --
    --
DECLARE
    X_COD_CEP_DES VARCHAR(8);


    --
    --
DECLARE
    X_COD_DUV VARCHAR (30);


    --
    --
DECLARE
    X_ORIGEM_EXP INTEGER;


    --
    --
DECLARE
    X_DESTINO_EXP INTEGER;


    --
    --
DECLARE
    X_VLR_MANIF FLOAT;


    --
    --
DECLARE
    X_SEG_DUP BIGINT;


    --
    --
DECLARE
    X_SIG_UFDES_CMT VARCHAR(2);


    --
    --
DECLARE
    X_COD_AVERB_OFC VARCHAR(40);


    --
DECLARE
    X_COD_OPERD_AVB VARCHAR(1);


    --
DECLARE
    X_COD_DOCUM_FIS VARCHAR(9);


    --
DECLARE
    X_COD_MODEL_FIS VARCHAR(2);


    --
DECLARE
    X_COD_SERIE_FIS VARCHAR(3);


    --
DECLARE
    X_COD_DOCUM_EMI VARCHAR(14);


    --
DECLARE
    X_COD_CIA_SSP VARCHAR(5);


    --
DECLARE
    X_COD_ANMES_FVI VARCHAR(4);


    --
DECLARE
    X_NUM_PROPT INTEGER;


    --
    ---
    ---
    ---
DECLARE
    v_err_sqlstate CHAR(5) DEFAULT '00000';


    --
DECLARE
    v_err_message VARCHAR(255) DEFAULT '';


    --
DECLARE
    SQLSTATE CHAR(5);


    --
DECLARE
    EXIT HANDLER FOR SQLEXCEPTION P1 :BEGIN SET v_err_sqlstate = SQLSTATE;


    --
    SET v_err_message = 'ERRO PROC: SP_GERA_FATURA - Passo: ' CONCAT RTRIM (LTRIM(CHAR(v_step))) CONCAT ' - SQLSTATE:' CONCAT v_err_sqlstate;


    --
END P1;


--
-- Fim Variaveis
---
FOR c_atm AS
SELECT
    CTL_ATM      ,
    COD_CNPJ_SEG ,
    COD_DOCUM_TRA,
    COD_MODAD_TRA,
    COD_RAMO     ,
    SIG_UF_ORI   ,
    SIG_UF_DES   ,
    STA_PERCU_URB,
    COD_MERCA    ,
    COD_CPF_MOT  ,
    COD_RG_MOT   ,
    COD_LIBER_MOT,
    STA_CARGA_DGA,
    STA_ICAME    ,
    STA_REMOC_INO,
    STA_TRNST_PRP,
    COD_MOVIM    ,
    DHR_AVERB    ,
    SIG_UFORI_CMT,
    SIG_UFDES_CMT,
    COD_IDENT_VEI,
    DHR_EMISS_DOC,
    DAT_CFAS     ,
    VLR_MERCA    ,
    STA_RCFDC    ,
    OBS_AVERB    ,
    NOM_FILIA    ,
    STA_RASTR    ,
    STA_ESCOL    ,
    STA_VEICU_PRP,
    VLR_CONER    ,
    VLR_ACESS    ,
    VLR_FRETE    ,
    VLR_DESPE    ,
    VLR_LUCRO    ,
    VLR_IMPOS    ,
    DHR_EMBAR    ,
    COD_ISENC    ,
    STA_MERCA_NOV,
    NUM_CEP_ORI  ,
    NUM_CEP_DES  ,
    COD_IMPOR_EPT,
    VLR_AVARI    ,
    COD_DANFE    ,
    VLR_DOCUM_DDR,
    COD_PRACA_ORI,
    COD_PRACA_DES,
    DAT_INCLU_ATM,
    COD_CNPJ_EMI ,
    COD_CNPJ_RMT ,
    COD_CNPJ_DES ,
    COD_CNPJ_TOM ,
    COD_CNPJ_REC ,
    COD_NTFIS    ,
    COD_SERIE_NF ,
    DHR_ALTER    ,
    DHR_CADAS    ,
    COD_PROTO_CAN,
    DAT_CANCE_SEF,
    HOR_CANCE_SEF,
    DAT_CANCE_ATM,
    HOR_CANCE_ATM,
    COD_DOCUM_RES,
    COD_AVERB_OFC,
    PROT_AVERB    
FROM
    TAVERBACAO_IMPOR_ATM
WHERE
    CTL_ATM = V_CTL_ATM DO ---
    --Cria DUV agregado
    IF
        c_atm.NOM_FILIA IS NOT NULL
    THEN
        SET X_COD_DUV = ( TRIM(c_atm.COD_NTFIS) || TRIM(c_atm.COD_SERIE_NF) || TRIM(c_atm.NOM_FILIA) );


        --
        --
    ELSE
        SET X_COD_DUV = ( TRIM(c_atm.COD_NTFIS) || TRIM(c_atm.COD_SERIE_NF) );


        --
        --
    END IF;


    --
    --
    --Verifica se tem Valor de Container
    IF
        c_atm.VLR_CONER > 0
    THEN
        SET X_VLR_MERCA = (c_atm.VLR_CONER + c_atm.VLR_MERCA);


        --
    ELSE
        SET X_VLR_MERCA = c_atm.VLR_MERCA;


        --
    END IF;
    --
    --Checa Duplicidade com COD_DANFE
    SET X_SEG_DUP =
    (
        --ANTIGO
        --VINCULADO
        /*
        SELECT
            CTL_VINCD
        FROM
            TDOC_VINCULADO
        WHERE
            COD_DOCUM = c_atm.COD_CNPJ_SEG
        FETCH FIRST 1 ROWS ONLY 
        */
        --NOVO
        --PESSOA
        SELECT
            CTL_PESSO
        FROM
            CRP_PESSOA
        WHERE
            COD_DOCUM_PRI = c_atm.COD_CNPJ_SEG
        FETCH FIRST 1 ROWS ONLY       
    );
 
    --
    SET X_DUPLI1 =
    (
        /*
        --ANTIGO
        --VINCULADO
        SELECT
            A.CTL_AVERB
        FROM
            TAVERBACAO_COMPLEM_ATM A,
            TAVERBACAO_INDICE      B
        WHERE
            A.CTL_AVERB     = B.CTL_AVERB
        AND A.COD_DANFE     = c_atm.COD_DANFE
        AND B.CTL_VINCD_SED = X_SEG_DUP
        AND B.SIT_AVERB NOT IN(3)
        AND LENGTH(A.COD_DANFE) = 44
        FETCH FIRST 1 ROWS ONLY );
        */
        --NOVO
        --PESSOA
        SELECT
            A.CTL_AVERB
        FROM
            TAVERBACAO_COMPLEM_ATM A,
            TAVERBACAO_INDICE      B
        WHERE
            A.CTL_AVERB     = B.CTL_AVERB
        AND A.COD_DANFE     = c_atm.COD_DANFE
        AND B.CTL_PESSO = X_SEG_DUP
        AND B.SIT_AVERB NOT IN(3)
        AND LENGTH(A.COD_DANFE) = 44
        FETCH FIRST 1 ROWS ONLY 
    );
    --
    --
    IF
        X_DUPLI1 IS NULL
    THEN
        SET X_DUPLI1 =
        (
            --ANTIGO
            --VIINCULADO
            /*
            SELECT
                A.CTL_AVERB
            FROM
                TAVERBACAO_COMPLEM_ATM A,
                TAVERBACAO_INDICE      B
            WHERE
                A.CTL_AVERB     = B.CTL_AVERB
            AND A.COD_DANFE     = c_atm.COD_DANFE
            AND B.CTL_VINCD_SED = X_SEG_DUP
            AND B.SIT_AVERB NOT IN(3)
            AND LENGTH(A.COD_DANFE) = 0
            FETCH FIRST 1 ROWS ONLY );
            */
            --NOVO
            --PESSOA
            SELECT
                A.CTL_AVERB
            FROM
                TAVERBACAO_COMPLEM_ATM A,
                TAVERBACAO_INDICE      B
            WHERE
                A.CTL_AVERB     = B.CTL_AVERB
            AND A.COD_DANFE     = c_atm.COD_DANFE
            AND B.CTL_PESSO = X_SEG_DUP
            AND B.SIT_AVERB NOT IN(3)
            AND LENGTH(A.COD_DANFE) = 0
            FETCH FIRST 1 ROWS ONLY 
        );

    END IF;



    /*************************************************************/
    /*2024-09-06 CONSISTIR AVB SEM CODIGO OFICIAL*/
    /*
    IF 
        c_ATM.VLR_IMPOS > 0

    THEN
        X_VLR_MERCA_COM_IMPOSTO = c_ATM.VLR_MERCA + c_ATM.VLR_IMPOS

    ELSE
        X_VLR_MERCA_COM_IMPOSTO = c_ATM.VLR_MERCA

    END IF;


    */
    IF 
        X_DUPLI1 IS NULL 
    THEN
        SET X_DUPLI1 = 
        (       
                --ANTIGO
                --VINCULADO
                /*
                SELECT A.CTL_AVERB
                FROM TAVERBACAO_INDICE A,
                    TAVERBACAO B,
                    TDOC_VINCULADO C
                WHERE A.CTL_AVERB = B.CTL_AVERB
                    AND A.CTL_VINCD_SED = C.CTL_VINCD
                    AND B.COD_MANIF = X_COD_DUV
                    AND A.CTL_VINCD_SED = X_SEG_DUP
                    AND B.DAT_EMBAR = DATE (c_atm.DHR_EMBAR)
                    --AND B.VLR_EMBAR = X_VLR_MERCA_COM_IMPOSTO
                    AND A.SIT_AVERB NOT IN (3) FETCH FIRST 1 ROW ONLY
                */    
                --NOVO
                --PESSOA
                SELECT A.CTL_AVERB
                FROM TAVERBACAO_INDICE A,
                    TAVERBACAO B,
                    CRP_PESSOA P
                WHERE A.CTL_AVERB = B.CTL_AVERB
                    AND A.CTL_PESSO = P.CTL_PESSO
                    AND B.COD_MANIF = X_COD_DUV
                    AND A.CTL_PESSO = X_SEG_DUP
                    AND B.DAT_EMBAR = DATE (c_atm.DHR_EMBAR)
                    --AND B.VLR_EMBAR = X_VLR_MERCA_COM_IMPOSTO
                    AND A.SIT_AVERB NOT IN (3) FETCH FIRST 1 ROW ONLY
        );
    END IF;

    IF
        X_DUPLI1 IS NOT NULL
        OR X_DUPLI1 <> 0
    THEN
        SET X_SIT_TRANS =
        (
            SELECT
                SIT_TRANS
            FROM
                TAVERBACAO_INDICE
            WHERE
                CTL_AVERB = X_DUPLI1 );


        --
        --
        IF
            c_atm.COD_MOVIM = '2'
        THEN
            IF
                X_SIT_TRANS    = 9
                OR X_SIT_TRANS = 10
                OR X_SIT_TRANS = 11
            THEN
                UPDATE
                    TAVERBACAO_INDICE
                SET
                    SIT_AVERB = 3
                WHERE
                    CTL_AVERB = X_DUPLI1;
                --
                --
                UPDATE
                    TAVERBACAO_COMPLEM_ATM
                SET
                    COD_PROTO_CAN = c_atm.COD_PROTO_CAN,
                    DAT_CANCE_SEF = c_atm.DAT_CANCE_SEF,
                    HOR_CANCE_SEF = c_atm.HOR_CANCE_SEF,
                    DAT_CANCE_ATM = c_atm.DAT_CANCE_ATM,
                    HOR_CANCE_ATM = c_atm.HOR_CANCE_ATM
                WHERE
                    CTL_AVERB = X_DUPLI1;
                --
                --
                INSERT INTO TRELAC_SITUA_AVERB_ATM
                    (
                        SIT_IMPOR_ATM,
                        CTL_ATM      ,
                        DHR_ALTER
                    )
                VALUES
                    (
                        31       ,
                        V_CTL_ATM,
                        CURRENT TIMESTAMP
                    )
                ;
                --
                --
                INSERT INTO TRELAC_AVERBACAO_ATM
                    (
                        CTL_ATM  ,
                        CTL_AVERB,
                        COD_USER ,
                        DHR_ALTER
                    )
                VALUES
                    (
                        c_atm.CTL_ATM,
                        X_DUPLI1     ,
                        'AT&M'       ,
                        CURRENT TIMESTAMP
                    )
                ;
                --
                --
            ELSE --Define SIT_TRANS a ser gravado
                IF
                    X_SIT_TRANS <> 1
                THEN
                    SET X_SIT_TRANS = 2;
                    --
                    --
                ELSE
                    SET X_SIT_TRANS = 0;
                    --
                    --
                END IF;
                --
                --
                --Fim SIT_TRANS
                UPDATE
                    TAVERBACAO_INDICE
                SET
                    SIT_AVERB = 3,
                    SIT_TRANS = X_SIT_TRANS
                WHERE
                    CTL_AVERB = X_DUPLI1;
                --
                --
                UPDATE
                    TAVERBACAO_COMPLEM_ATM
                SET
                    COD_PROTO_CAN = c_atm.COD_PROTO_CAN,
                    DAT_CANCE_SEF = c_atm.DAT_CANCE_SEF,
                    HOR_CANCE_SEF = c_atm.HOR_CANCE_SEF,
                    DAT_CANCE_ATM = c_atm.DAT_CANCE_ATM,
                    HOR_CANCE_ATM = c_atm.HOR_CANCE_ATM
                WHERE
                    CTL_AVERB = X_DUPLI1;
                --
                --
                INSERT INTO TRELAC_SITUA_AVERB_ATM
                    (
                        SIT_IMPOR_ATM,
                        CTL_ATM      ,
                        DHR_ALTER
                    )
                VALUES
                    (
                        28       ,
                        V_CTL_ATM,
                        CURRENT TIMESTAMP
                    );
                --
                --
                INSERT INTO TRELAC_AVERBACAO_ATM
                    (
                        CTL_ATM  ,
                        CTL_AVERB,
                        COD_USER ,
                        DHR_ALTER
                    )
                VALUES
                    (
                        c_atm.CTL_ATM,
                        X_DUPLI1     ,
                        'AT&M'       ,
                        CURRENT TIMESTAMP
                    );
                --
                --
            END IF;
            --
            --
        ELSE
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    26       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;
            --
            --
        END IF;
        --
        --
    ELSE -- CTL_AVERB
        SELECT
            NEXT VALUE FOR SQ_CTL_AVERB
        INTO
            X_CTL_AVERB
        FROM
            dual;
        --
        --
        -- DHR_ALTER
        SET X_DHR_ALTER = (CURRENT_TIMESTAMP);
        --ALTERAR REGRA ANTIGA
        --VINCULADO
        -- Seleciona segurado CTL_VINCD
        SET X_CTL_VINCD =
        (
            SELECT
                CTL_VINCD
            FROM
                TDOC_VINCULADO
            WHERE
                COD_DOCUM = c_atm.COD_CNPJ_SEG
            FETCH FIRST 1 ROW ONLY );

        --NOVO
        --PESSOA
        -- Seleciona segurado CTL_PESSO
        SET X_CTL_PESSO =
        (
            SELECT
                CTL_PESSO
            FROM
                APLAIS.CRP_PESSOA
            WHERE
                COD_DOCUM_PRI = c_atm.COD_CNPJ_SEG
            FETCH FIRST 1 ROW ONLY );

        --
        --REGRA ALTERADA PARA TABELA CRP_PESSOA
        IF
            --X_CTL_VINCD IS NULL
            X_CTL_PESSO IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    1        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        -- Seleciona Localidade NUM_LOCAL
        IF
            c_atm.SIG_UF_DES IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    4        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.SIG_UF_ORI IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    3        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        SET X_NUM_LOCAL_DES =
        (
            SELECT
                NUM_LOCAL
            FROM
                TLOCALIDADE
            WHERE
                SIG_LOCAL = c_atm.SIG_UF_DES
            AND NUM_LOCAL < 100 );


        --
        --
        IF
            X_NUM_LOCAL_DES IS NULL
        THEN
            SET X_NUM_LOCAL_DES = 0;


            --
            --
        END IF;


        --
        --
        SET X_NUM_LOCAL_ORI =
        (
            SELECT
                NUM_LOCAL
            FROM
                TLOCALIDADE
            WHERE
                SIG_LOCAL = c_atm.SIG_UF_ORI
            AND NUM_LOCAL < 100 );


        --
        --
        IF
            X_NUM_LOCAL_ORI IS NULL
        THEN
            SET X_NUM_LOCAL_ORI = 0;


            --
            --
        END IF;


        --
        --
        -- Seleciona Moeda
        IF
            c_atm.SIG_UFDES_CMT = 'CH'
        THEN
            SET X_SIG_UFDES_CMT = 'CL';


            --
            --
            ELSEIF c_atm.SIG_UFDES_CMT = 'EQ'
        THEN
            SET X_SIG_UFDES_CMT = 'EC';


            --
            --
            ELSEIF c_atm.SIG_UFDES_CMT = 'GU'
        THEN
            SET X_SIG_UFDES_CMT = 'GY';


            --
            --
            ELSEIF c_atm.SIG_UFDES_CMT = 'PU'
        THEN
            SET X_SIG_UFDES_CMT = 'PE';


            --
            --
            ELSEIF c_atm.SIG_UFDES_CMT = 'UG'
        THEN
            SET X_SIG_UFDES_CMT = 'UY';


            --
            --
            ELSEIF c_atm.SIG_UFDES_CMT = 'VZ'
        THEN
            SET X_SIG_UFDES_CMT = 'VE';


            --
            --
        ELSE
            SET X_SIG_UFDES_CMT = c_atm.SIG_UFDES_CMT;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.COD_RAMO    = 32
            OR c_atm.COD_RAMO = 44
        THEN
            SET X_NUM_MOEDA = 3;


            --
            --
            IF
                c_atm.COD_IMPOR_EPT = 1
            THEN
                SET X_ORIGEM_EXP =
                (
                    SELECT
                        NUM_UNFED
                    FROM
                        TUNIDADE_FEDERAL
                    WHERE
                        SIG_UNFED = X_SIG_UFDES_CMT
                    FETCH FIRST 1 ROWS ONLY );


                --
                --
                IF
                    X_ORIGEM_EXP IS NULL
                THEN
                    SET X_ORIGEM_EXP = 0;


                    --
                    --
                END IF;


                --
                --
                SET X_PRACA_ORI_EXP =
                (
                    SELECT
                        B.NUM_PRACA
                    FROM
                        TUNIDADE_FEDERAL A,
                        tPRACA           B
                    WHERE
                        A.NUM_UNFED BETWEEN 100 AND 111
                    AND A.NOM_UNFED = B.DES_PRACA
                    AND A.SIG_UNFED = X_SIG_UFDES_CMT
                    FETCH FIRST 1 ROWS ONLY );


                --
                --
                IF
                    X_PRACA_ORI_EXP IS NULL
                THEN
                    SET X_PRACA_ORI_EXP = 0;


                    --
                    --
                END IF;


                --
                --
                ELSEIF c_atm.COD_IMPOR_EPT = 2
            THEN
                SET X_DESTINO_EXP =
                (
                    SELECT
                        NUM_UNFED
                    FROM
                        TUNIDADE_FEDERAL
                    WHERE
                        SIG_UNFED = X_SIG_UFDES_CMT
                    FETCH FIRST 1 ROWS ONLY );


                --
                --
                IF
                    X_DESTINO_EXP IS NULL
                THEN
                    SET X_DESTINO_EXP = 0;


                    --
                    --
                END IF;


                --
                --
                SET X_PRACA_DES_EXP =
                (
                    SELECT
                        B.NUM_PRACA
                    FROM
                        TUNIDADE_FEDERAL A,
                        TPRACA           B
                    WHERE
                        A.NUM_UNFED BETWEEN 100 AND 111
                    AND A.NOM_UNFED = B.DES_PRACA
                    AND A.SIG_UNFED = X_SIG_UFDES_CMT
                    FETCH FIRST 1 ROWS ONLY );


                --
                --
                IF
                    X_PRACA_DES_EXP IS NULL
                THEN
                    SET X_PRACA_DES_EXP = 0;


                    --
                    --
                END IF;


                --
                --
            END IF;


            --
            --
            IF
                X_ORIGEM_EXP = 0
            THEN
                INSERT INTO TRELAC_SITUA_AVERB_ATM
                    (
                        SIT_IMPOR_ATM,
                        CTL_ATM      ,
                        DHR_ALTER
                    )
                VALUES
                    (
                        32       ,
                        V_CTL_ATM,
                        CURRENT TIMESTAMP
                    )
                ;


                --
                --
            END IF;


            --
            --
        ELSE
            SET X_NUM_MOEDA = 14;


            --
            --
        END IF;


        --
        --
        -- Seleciona Situaçonitoramento SIT_MONIT
        IF
            c_atm.STA_RASTR IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    23       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.STA_RASTR = 'S'
        THEN
            SET X_SIT_MONIT = 13;


            --
            --
        ELSE
            SET X_SIT_MONIT = 1;


            --
            --
        END IF;


        --
        --
        -- Seleciona Situaçe Escolta SIT_ESCOL
        IF
            c_atm.STA_ESCOL IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    24       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.STA_ESCOL = 'S'
        THEN
            SET X_SIT_ESCOL = 3;


            --
            --
        ELSE
            SET X_SIT_ESCOL = 2;


            --
            --
        END IF;


        --
        --
        -- Seleciona Ramo NUM_RAMO
        IF
            c_atm.COD_RAMO = 21
        THEN
            SET X_NUM_RAMO = 3;


            --
            --
            ELSEIF c_atm.COD_RAMO = 32
        THEN
            SET X_NUM_RAMO = 30;


            --
            --
            ELSEIF c_atm.COD_RAMO = 44
        THEN
            SET X_NUM_RAMO = 30;


            --
            --
            ELSEIF c_atm.COD_RAMO = 52
        THEN
            SET X_NUM_RAMO = 9;


            --
            --
            ELSEIF c_atm.COD_RAMO = 58
        THEN
            SET X_NUM_RAMO = 9;


            --
            --
            ELSEIF c_atm.COD_RAMO = 54
        THEN
            SET X_NUM_RAMO = 1;


            --
            --
            ELSEIF c_atm.COD_RAMO = 55
        THEN
            SET X_NUM_RAMO = 1;


            --
            --
            ELSEIF c_atm.COD_RAMO = 56
        THEN
            SET X_NUM_RAMO = 56;


            --
            --
            ELSEIF c_atm.COD_RAMO = 95
        THEN
            SET X_NUM_RAMO = 66;


            --
            --
            ELSEIF c_atm.COD_RAMO = 96
        THEN
            SET X_NUM_RAMO = 67;


            --
            --
            ELSEIF c_atm.COD_RAMO = 38
        THEN
            SET X_NUM_RAMO = 65;


            --
            --
        ELSE
            SET X_NUM_RAMO = 0;


            --
            --
        END IF;


        --
        --
        IF
            X_NUM_RAMO = 0
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    2        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        SET X_DAT_EMB = DATE(c_atm.DHR_EMBAR);


        --
        --
        SET X_HOR_EMB = TIME(c_atm.DHR_EMBAR);


        --
        --
        -- Extrai Data de Embarque DAT_EMB
        IF
            c_atm.DHR_EMBAR IS NULL
            OR c_atm.DHR_EMBAR IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    5        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        -- Verifica Valor da Mercadoria
        IF
            c_atm.VLR_MERCA IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    6        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        -- Verifica Campos tabela TAVERBACAO_COMPLEM_ATM
        IF
            c_atm.STA_REMOC_INO IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    12       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.STA_TRNST_PRP IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    13       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.VLR_CONER IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    14       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.VLR_ACESS IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    15       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.VLR_FRETE IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    16       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.VLR_DESPE IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    17       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.VLR_LUCRO IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    18       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.VLR_IMPOS IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    19       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.VLR_AVARI IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    20       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.STA_MERCA_NOV IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    25       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.VLR_DOCUM_DDR IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    22       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        -- Seleciona Tipo de Documento de Transporte TIP_DOCUM_TRA
        IF
            c_atm.COD_DOCUM_TRA IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    7        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.COD_DOCUM_TRA = '1'
        THEN
            SET X_TIP_DOCUM_TRA = 1;


            --
            --
            ELSEIF c_atm.COD_DOCUM_TRA = '2'
        THEN
            SET X_TIP_DOCUM_TRA = 5;


            --
            --
            ELSEIF c_atm.COD_DOCUM_TRA = '3'
        THEN
            SET X_TIP_DOCUM_TRA = 6;


            --
            --
            ELSEIF c_atm.COD_DOCUM_TRA = '4'
        THEN
            SET X_TIP_DOCUM_TRA = 11;


            --
            --
            ELSEIF c_atm.COD_DOCUM_TRA = '5'
        THEN
            SET X_TIP_DOCUM_TRA = 99;


            --
            --
            ELSEIF c_atm.COD_DOCUM_TRA = '7'
        THEN
            SET X_TIP_DOCUM_TRA = 14;


            --
            --
        ELSE
            SET X_TIP_DOCUM_TRA = 0;


            --
            --
        END IF;


        --
        --
        IF
            X_TIP_DOCUM_TRA = 0
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    8        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        -- Verifica Cóo Manifesto
        IF
            c_atm.COD_NTFIS IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    9        ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        --DEFINE PRAÇ IBGE (Origem e destino)
        IF
            c_atm.COD_PRACA_ORI IS NULL
        THEN
            SET X_COD_PRACA_ORI =
            (
                SELECT
                    NUM_PRACA
                FROM
                    TPRACA
                WHERE
                    DES_PRACA = 'NAO INFORMADA'
                AND NUM_UNFED = X_NUM_LOCAL_ORI );


            --
            --
            SET X_COD_CEP_ORI =
            (
                SELECT
                    COD_CEP
                FROM
                    TPRACA
                WHERE
                    DES_PRACA = 'NAO INFORMADA'
                AND NUM_UNFED = X_NUM_LOCAL_ORI );


            --
            --
        ELSE
            SET X_COD_PRACA_ORI =
            (
                SELECT
                    NUM_PRACA
                FROM
                    TPRACA
                WHERE
                    NUM_IBGE = INTEGER(c_atm.COD_PRACA_ORI) );


            --
            --
            SET X_COD_CEP_ORI =
            (
                SELECT
                    COD_CEP
                FROM
                    TPRACA
                WHERE
                    NUM_IBGE = INTEGER(c_atm.COD_PRACA_ORI) );


            --
            --
        END IF;


        --
        --
        IF
            X_COD_PRACA_ORI IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    29       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        IF
            c_atm.COD_PRACA_DES IS NULL
        THEN
            SET X_COD_PRACA_DES =
            (
                SELECT
                    NUM_PRACA
                FROM
                    TPRACA
                WHERE
                    DES_PRACA = 'NAO INFORMADA'
                AND NUM_UNFED = X_NUM_LOCAL_DES );


            --
            --
            SET X_COD_CEP_DES =
            (
                SELECT
                    COD_CEP
                FROM
                    TPRACA
                WHERE
                    DES_PRACA = 'NAO INFORMADA'
                AND NUM_UNFED = X_NUM_LOCAL_DES );


            --
            --
        ELSE
            SET X_COD_PRACA_DES =
            (
                SELECT
                    NUM_PRACA
                FROM
                    TPRACA
                WHERE
                    NUM_IBGE = INTEGER(c_atm.COD_PRACA_DES) );


            --
            --
            SET X_COD_CEP_DES =
            (
                SELECT
                    COD_CEP
                FROM
                    TPRACA
                WHERE
                    NUM_IBGE = INTEGER(c_atm.COD_PRACA_DES) );


            --
            --
        END IF;


        --
        --
        IF
            X_COD_PRACA_DES IS NULL
        THEN
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    30       ,
                    V_CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
        END IF;


        --
        --
        -- Seleciona Motorista
        SET X_CTL_MOTOT =
        (
            SELECT
                CTL_MOTOT
            FROM
                TMOTORISTA_MOVTO
            WHERE
                COD_DOCUM_MOT = c_atm.COD_CPF_MOT
            FETCH FIRST 1 ROW ONLY );


        --
        --
        IF
            c_atm.COD_CPF_MOT <> '00000000000'
            AND X_CTL_MOTOT IS NULL
        THEN
            SELECT
                NEXT VALUE FOR SQ_CTL_MOTOT
            INTO
                X_CTL_MOTOT
            FROM
                dual;


            --
            --
            INSERT INTO TMOTORISTA_MOVTO
                (
                    CTL_MOTOT    ,
                    TIP_DOCUM    ,
                    COD_DOCUM_MOT,
                    NOM_MOTOT    ,
                    COD_USER     ,
                    DHR_ALTER    ,
                    NUM_PAMCD
                )
            VALUES
                (
                    X_CTL_MOTOT      ,
                    2                ,
                    c_atm.COD_CPF_MOT,
                    null             ,
                    'AT&M'           ,
                    X_DHR_ALTER      ,
                    null
                )
            ;


            --
            --
        END IF;


        --
        --
        -- Extrai Data e Hora do DUV
        SET X_DAT_EMISS_DOC = DATE (c_atm.DHR_EMISS_DOC);


        --
        --
        SET X_HOR_EMISS_DOC = TIME(c_atm.DHR_EMISS_DOC);


        --
        --
        -- Seleciona Cóe IsençDDR)
        --ALTERAR REGRA ANTIGA
        IF
             (c_atm.COD_ISENC IS NULL)
            AND (c_atm.COD_RAMO = 54)
        THEN
            SET X_STA_COBER_RDC =
            (
                /*
                --REGRA ANTIGA
                --TABELA APOLICE
                SELECT
                    STA_COBER_RDC
                FROM
                    TAPOLICE
                WHERE
                    CTL_VINCD_SED = X_CTL_VINCD
                AND SIT_APOLI     = 1
                AND NUM_RAMO      = 1
                AND NUM_APOLI     <> 0
                ORDER BY
                    NUM_APOLI DESC
                FETCH FIRST 1 ROW ONLY );
                */
                --REGRA NOVA
                --SEG_PROPOSTA_SEGURO
                SELECT STA_COBER_RDC FROM SEG_PROPOSTA_SEGURO 
                WHERE CTL_CLIEN_PPS = X_CTL_PESSO
                AND TIP_PROPT = 1
                AND sit_tipo_prs IN (1, 2, 3, 6, 98)
                AND DAT_BAIXA_APO IS NOT NULL
                AND NUM_RAMO_SEG      = 1
                AND NUM_APOLI     <> 0
                ORDER BY NUM_APOLI DESC
                FETCH FIRST 1 ROW ONLY 


            --
            --
            IF
                X_STA_COBER_RDC = 'S'
            THEN
                SET X_TIP_ISENC_SEG = 7;


                --
                --
                ELSEIF X_STA_COBER_RDC = 'N'
            THEN
                SET X_TIP_ISENC_SEG = 1;


                --
                --
            END IF;


            --
            --
        END IF;


        --
        --
        IF
             (c_atm.COD_ISENC IS NULL)
            AND (c_atm.COD_RAMO = 55)
        THEN
            SET X_TIP_ISENC_SEG = 1;


            --
            --
            ELSEIF (c_atm.COD_ISENC = '1')
        THEN
            SET X_TIP_ISENC_SEG = 7;


            --
            --
            ELSEIF c_atm.COD_ISENC = '2'
        THEN
            SET X_TIP_ISENC_SEG = 1;


            --
            --
            ELSEIF c_atm.COD_ISENC = '3'
        THEN
            SET X_TIP_ISENC_SEG = 5;


            --
            --
            --	ELSEIF c_atm.COD_ISENC = '4' THEN -- incluído em 07/06/19 por Adriano e Geandro - Estipulação por vínculo na AT&M
            --         SET X_TIP_ISENC_SEG = 5
            --;


            --
            --
        ELSE
            SET X_TIP_ISENC_SEG = 1;


            --
            --
        END IF;


        SET X_ERROS =
        (
            SELECT
                COUNT(*)
            FROM
                TRELAC_SITUA_AVERB_ATM
            WHERE
                CTL_ATM       = V_CTL_ATM
            AND SIT_IMPOR_ATM <> 0 );


        --
        --
        IF
            X_ERROS = 0
        THEN --##################################		
            -- TAVERBACAO_INDICE
            IF
                c_atm.COD_MOVIM = '2'
            THEN
                SET X_SIT_AVERB = 3;


                --
                --
                SET X_SIT_TRANS = 2;


                --
                --
            ELSE
                SET X_SIT_AVERB = 0;


                --
                --
                SET X_SIT_TRANS = 0;


                --
                --
            END IF;


            --
            --
            SET X_NUM_PROPT = null;

            
            IF
                --ALTERAR REGRA ANTIGA
                --X_CTL_VINCD    = 500008
                --REGRA NOVA
                X_CTL_PESSO    = 15215
                AND X_NUM_RAMO = 1
            THEN -- Seleciona num_propt
                SET X_NUM_PROPT = 22000891;


                --
                SET X_SIT_AVERB = 4;


            END IF;

            IF
                --ALTERAR REGRA ANTIGA
                --X_CTL_VINCD    = 500008
                --REGRA NOVA
                X_CTL_PESSO    = 15215
                AND X_NUM_RAMO = 3
            THEN -- Seleciona num_propt
                SET X_NUM_PROPT = 22000893;


                --
                SET X_SIT_AVERB = 4;


            END IF;

            IF
                --ALTERAR REGRA ANTIGA
                --X_CTL_VINCD    = 518946
                --REGRA NOVA
                X_CTL_PESSO      = 517733
                AND X_NUM_RAMO = 3
            THEN -- Seleciona num_propt
                SET X_NUM_PROPT = 21005984;


                SET X_SIT_AVERB = 4;


            END IF;

            IF
                --ALTERAR REGRA ANTIGA
                --X_CTL_VINCD    = 518946
                --REGRA NOVA
                X_CTL_PESSO      = 517733
                AND X_NUM_RAMO = 1
            THEN -- Seleciona num_propt
                SET X_NUM_PROPT = 22005871;


                SET X_SIT_AVERB = 4;


            END IF;

            IF
                --ALTERAR REGRA ANTIGA
                --X_CTL_VINCD    = 2561
                --REGRA NOVA
                X_CTL_PESSO    = 16674
                AND X_NUM_RAMO = 1
            THEN -- Seleciona num_propt
                SET X_NUM_PROPT = 22007629;


                SET X_SIT_AVERB = 4;


                --
            END IF;

            IF
                --ALTERAR REGRA ANTIGA
                --X_CTL_VINCD    = 2561
                --REGRA NOVA
                X_CTL_PESSO    = 16674
                AND X_NUM_RAMO = 3
            THEN
                SET X_NUM_PROPT = 22007630;


                SET X_SIT_AVERB = 4;


            END IF;


            INSERT INTO TAVERBACAO_INDICE
                (
                    CTL_AVERB    ,
                    TIP_AVERB    ,
                    NUM_AVERB    ,
                    NUM_PROPT    ,
                    CTL_VINCD_SED,
                    NUM_RAMO     ,
                    NUM_LOTE     ,
                    SIT_AVERB    ,
                    SIT_TRANS    ,
                    TIP_ACAO_DVG ,
                    CTL_PESSO
                )
            VALUES
                (
                    X_CTL_AVERB,
                    0          ,
                    X_CTL_AVERB,
                    X_NUM_PROPT,
                    X_CTL_VINCD,
                    X_NUM_RAMO ,
                    null       ,
                    X_SIT_AVERB,
                    X_SIT_TRANS,
                    null       ,
                    X_CTL_PESSO
                )
            ;


            --
            --
            --##################################
            -- TRELAC_SITUA_AVERB_ATM
            INSERT INTO TRELAC_SITUA_AVERB_ATM
                (
                    SIT_IMPOR_ATM,
                    CTL_ATM      ,
                    DHR_ALTER
                )
            VALUES
                (
                    0            ,
                    c_atm.CTL_ATM,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
            --##################################
            -- TRELAC_AVERBACAO_ATM
            INSERT INTO TRELAC_AVERBACAO_ATM
                (
                    CTL_ATM  ,
                    CTL_AVERB,
                    COD_USER ,
                    DHR_ALTER
                )
            VALUES
                (
                    c_atm.CTL_ATM,
                    X_CTL_AVERB  ,
                    'AT&M'       ,
                    CURRENT TIMESTAMP
                )
            ;


            --
            --
            --##################################	
            -- TAVERBACAO
            IF
                c_atm.COD_ISENC    = 1
                OR c_atm.COD_ISENC = 3
            THEN
                IF
                    c_atm.VLR_CONER > 0
                THEN
                    SET X_VLR_MERCA = (c_atm.VLR_DOCUM_DDR + c_atm.VLR_CONER);


                    --
                ELSE
                    SET X_VLR_MERCA = c_atm.VLR_DOCUM_DDR;


                    --
                END IF;


                --
                --
            END IF;


            --
            --
            --- Inicio: Soma Imposto - Alterado em 10/02/2017 - Neide e Antonio
            --- regra alterada em 05/06/19 - Adriano, Edirlei e Geandro (anterior somava impostos apenas para documento do tipo 6 (nF))
            IF
                c_atm.VLR_IMPOS > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_IMPOS);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar o seguro do frete - 05/06/19 - Adriano, Edirlei e Geandro
            IF
                c_atm.VLR_FRETE > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_FRETE);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar as despesas - 21/08/19 - Adriano e Geandro
            IF
                c_atm.VLR_DESPE > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_DESPE);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar os acessórios - 21/08/19 - Adriano e Geandro
            IF
                c_atm.VLR_ACESS > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_ACESS);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar os lucros - 21/08/19 - Adriano e Geandro
            IF
                c_atm.VLR_LUCRO > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_LUCRO);


                --
            END IF;


            --
            --- Fim
            IF
                X_NUM_RAMO = 30
            THEN
                SET X_NUM_MOEDA = 3;


                --
                IF
                    c_atm.COD_IMPOR_EPT = 1
                THEN
                    SET X_NUM_LOCAL_ORI = X_ORIGEM_EXP;


                    --
                    --
                END IF;


                --
                --
            ELSE
                SET X_NUM_MOEDA = 14;


                --
            END IF;


            --
            --
            INSERT INTO TAVERBACAO_CONSISTENCIA
                (
                    CTL_AVERB,
                    CTL_USER ,
                    DHR_ALTER,
                    SIT_AVERB,
                    NUM_SEQ
                )
            VALUES
                (
                    X_CTL_AVERB,
                    22308      ,
                    X_DHR_ALTER,
                    0          ,
                    0
                )
            ;


            INSERT INTO TAVERBACAO
                (
                    CTL_AVERB    ,
                    COD_CEP      ,
                    CTL_VINCD_COG,
                    NUM_LOCAL_ORI,
                    NUM_PRACA_EMI,
                    NUM_PRACA_ORI,
                    NUM_PRACA_DES,
                    NUM_MERCA    ,
                    NUM_MOEDA    ,
                    TIP_MTSIT_AVB,
                    SIT_MOTOT    ,
                    NUM_TRANS_VIE,
                    DAT_EMBAR    ,
                    HOR_EMBAR    ,
                    DHR_AVERB    ,
                    DHR_ENTRA    ,
                    DHR_LIBER    ,
                    VLR_EMBAR    ,
                    TIP_DOCUM_TRA,
                    COD_MANIF    ,
                    STA_RCF      ,
                    STA_RFLUV    ,
                    NUM_SEQUE_HIS,
                    STA_RECUP    ,
                    COD_USER     ,
                    DHR_ALTER    ,
                    SIT_ESCOL    ,
                    SIT_MONIT    ,
                    TIP_MOTOT
                )
            VALUES
                (
                    X_CTL_AVERB    ,
                    X_COD_CEP_ORI  ,
                    null           ,
                    X_NUM_LOCAL_ORI,
                    X_COD_PRACA_ORI,
                    X_COD_PRACA_ORI,
                    X_COD_PRACA_DES,
                    99             ,
                    X_NUM_MOEDA    ,
                    null           ,
                    0              ,
                    null           ,
                    X_DAT_EMB      ,
                    X_HOR_EMB      ,
                    c_atm.DHR_AVERB,
                    c_atm.DHR_CADAS,
                    null           ,
                    X_VLR_MERCA    ,
                    X_TIP_DOCUM_TRA,
                    X_COD_DUV      ,
                    null           ,
                    null           ,
                    0              ,
                    null           ,
                    'AT&M'         ,
                    X_DHR_ALTER    ,
                    X_SIT_ESCOL    ,
                    X_SIT_MONIT    ,
                    null
                )
            ;


            --
            --
            --##################################	
            -- TAVERBACAO_COMPLEM_ATM
            INSERT INTO TAVERBACAO_COMPLEM_ATM
                (
                    CTL_AVERB    ,
                    NUM_MODAD_TRA,
                    COD_LIBER_MOT,
                    STA_REMOC_INO,
                    STA_TRNST_PRP,
                    DAT_CFAS     ,
                    OBS_AVERB    ,
                    NOM_FILIA    ,
                    VLR_CONER    ,
                    VLR_ACESS    ,
                    VLR_FRETE    ,
                    VLR_DESPE    ,
                    VLR_LUCRO    ,
                    VLR_IMPOS    ,
                    VLR_AVARI    ,
                    STA_MERCA_NOV,
                    COD_DANFE    ,
                    VLR_DOCUM_DDR,
                    COD_CNPJ_EMI ,
                    COD_CNPJ_RMT ,
                    COD_CNPJ_DES ,
                    COD_CNPJ_TOM ,
                    COD_CNPJ_REC ,
                    COD_USER     ,
                    DHR_ALTER    ,
                    COD_SERIE_NF ,
                    COD_PROTO_CAN,
                    DAT_CANCE_SEF,
                    HOR_CANCE_SEF,
                    DAT_CANCE_ATM,
                    HOR_CANCE_ATM,
                    COD_DOCUM_RES,
                    PROT_AVERB
                )
            VALUES
                (
                    X_CTL_AVERB        ,
                    c_atm.COD_MODAD_TRA,
                    c_atm.COD_LIBER_MOT,
                    c_atm.STA_REMOC_INO,
                    c_atm.STA_TRNST_PRP,
                    c_atm.DAT_CFAS     ,
                    c_atm.OBS_AVERB    ,
                    c_atm.NOM_FILIA    ,
                    c_atm.VLR_CONER    ,
                    c_atm.VLR_ACESS    ,
                    c_atm.VLR_FRETE    ,
                    c_atm.VLR_DESPE    ,
                    c_atm.VLR_LUCRO    ,
                    c_atm.VLR_IMPOS    ,
                    c_atm.VLR_AVARI    ,
                    c_atm.STA_MERCA_NOV,
                    c_atm.COD_DANFE    ,
                    c_atm.VLR_DOCUM_DDR,
                    c_atm.COD_CNPJ_EMI ,
                    c_atm.COD_CNPJ_RMT ,
                    c_atm.COD_CNPJ_DES ,
                    c_atm.COD_CNPJ_TOM ,
                    c_atm.COD_CNPJ_REC ,
                    'AT&M'             ,
                    c_atm.DHR_ALTER    ,
                    c_ATM.COD_SERIE_NF ,
                    c_ATM.COD_PROTO_CAN,
                    c_atm.DAT_CANCE_SEF,
                    c_atm.HOR_CANCE_SEF,
                    c_atm.DAT_CANCE_ATM,
                    c_atm.HOR_CANCE_ATM,
                    c_atm.COD_DOCUM_RES,
                    c_atm.PROT_AVERB
                )
            ;


            --
            --
            --##################################	
            -- TAVERBACAO_MOTOT
            INSERT INTO TAVERBACAO_MOTOT
                (
                    CTL_AVERB,
                    CTL_MOTOT,
                    COD_USER ,
                    DHR_ALTER,
                    TIP_MOTOT,
                    TIP_CATEG_MSG
                )
            VALUES
                (
                    X_CTL_AVERB,
                    X_CTL_MOTOT,
                    'AT&M'     ,
                    X_DHR_ALTER,
                    null       ,
                    null
                )
            ;


            --
            --
            --##################################	
            -- TAVERBACAO_VEICULO
            INSERT INTO TAVERBACAO_VEICULO
                (
                    CTL_AVERB    ,
                    NUM_SEQUE_VEI,
                    COD_IDENT_VEI,
                    TIP_VEICU    ,
                    NUM_RENAV    ,
                    COD_USER     ,
                    DHR_ALTER    ,
                    TIP_PROPR_VEI,
                    TIP_DOCUM_PRP,
                    COD_DOCUM_PRP
                )
            VALUES
                (
                    X_CTL_AVERB        ,
                    1                  ,
                    c_atm.COD_IDENT_VEI,
                    3                  ,
                    null               ,
                    'AT&M'             ,
                    X_DHR_ALTER        ,
                    null               ,
                    null               ,
                    null
                )
            ;


            --
            --
            --##################################	
            -- TAVERBACAO_COMPLEM
            INSERT INTO TAVERBACAO_COMPLEM
                (
                    CTL_AVERB    ,
                    DAT_PREVI_CHG,
                    HOR_PREVI_CHG,
                    DES_ITINE    ,
                    QTD_PEDAG    ,
                    QTD_TOTAL_KM ,
                    DHR_EMISS_MAN,
                    COD_USER     ,
                    DHR_ALTER    ,
                    DAT_EMISS_DUV,
                    HOR_EMISS_DUV,
                    STA_AGRAV    ,
                    STA_INFOL_AUT,
                    COD_FORMA_GER,
                    CTL_VERSA    ,
                    COD_VERSA_LAY
                )
            VALUES
                (
                    X_CTL_AVERB    ,
                    null           ,
                    null           ,
                    null           ,
                    null           ,
                    null           ,
                    null           ,
                    'AT&M'         ,
                    X_DHR_ALTER    ,
                    X_DAT_EMISS_DOC,
                    X_HOR_EMISS_DOC,
                    null           ,
                    null           ,
                    'D'            ,
                    null           ,
                    null
                )
            ;


            --
            --
            --##################################	
            -- TAVERBACAO_GEREN_RISCO
            INSERT INTO TAVERBACAO_GEREN_RISCO
                (
                    CTL_AVERB    ,
                    SIT_MONIT    ,
                    SIT_ESCOL    ,
                    COD_EQUIP_MON,
                    NUM_PROVE_TEN,
                    NOM_PREST_MON,
                    NOM_PREST_ESC,
                    COD_USER     ,
                    DHR_ALTER
                )
            VALUES
                (
                    X_CTL_AVERB,
                    X_SIT_MONIT,
                    X_SIT_ESCOL,
                    null       ,
                    null       ,
                    null       ,
                    null       ,
                    'AT&M'     ,
                    X_DHR_ALTER
                )
            ;


            --
            --
            --##################################	
            -- TDESTINO
            IF
                c_atm.STA_PERCU_URB = 'S'
            THEN
                SET D_NUM_LOCAL_DES = 99;


                --
            ELSE
                SET D_NUM_LOCAL_DES = X_NUM_LOCAL_DES;


                --
            END IF;


            --
            --
            IF
                X_NUM_RAMO              = 30
                AND c_atm.COD_IMPOR_EPT = 2
            THEN
                SET D_NUM_LOCAL_DES = X_DESTINO_EXP;


                --
                --
            END IF;


            --
            --
            IF
                c_atm.COD_ISENC    = 1
                OR c_atm.COD_ISENC = 3
            THEN
                IF
                    c_atm.VLR_CONER > 0
                THEN
                    SET X_VLR_MANIF = (c_atm.VLR_DOCUM_DDR + c_atm.VLR_CONER);


                    --
                ELSE
                    SET X_VLR_MANIF = c_atm.VLR_DOCUM_DDR;


                    --
                END IF;


                --
            ELSE
                SET X_VLR_MANIF = X_VLR_MERCA;


                --
            END IF;


            --
            --
            --- Inicio: Soma Imposto - Alterado em 10/02/2017 - Neide e Antonio
            --- Alterado de tipo = 6 para todos - 05/06/2019 - Adriano, Edirlei e Geandro
            IF
                c_atm.VLR_IMPOS > 0
                and ( c_atm.COD_ISENC = 1
                OR c_atm.COD_ISENC    = 3 )
            then
                set X_VLR_MANIF = (X_VLR_MANIF + c_atm.VLR_IMPOS);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar o seguro do frete - 05/06/19 - Adriano, Edirlei e Geandro
            IF
                c_atm.VLR_FRETE > 0
                and ( c_atm.COD_ISENC = 1
                OR c_atm.COD_ISENC    = 3 )
            then
                set X_VLR_MANIF = (X_VLR_MANIF + c_atm.VLR_FRETE);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar o seguro dos acessórios - 19/06/19 - Adriano e Geandro
            IF
                c_atm.VLR_ACESS > 0
                and ( c_atm.COD_ISENC = 1
                OR c_atm.COD_ISENC    = 3 )
            then
                set X_VLR_MANIF = (X_VLR_MANIF + c_atm.VLR_ACESS);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar o seguro das despesas - 19/06/19 - Adriano e Geandro
            IF
                c_atm.VLR_DESPE > 0
                and ( c_atm.COD_ISENC = 1
                OR c_atm.COD_ISENC    = 3 )
            then
                set X_VLR_MANIF = (X_VLR_MANIF + c_atm.VLR_DESPE);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar o seguro dos lucros - 19/06/19 - Adriano e Geandro
            IF
                c_atm.VLR_LUCRO > 0
                and ( c_atm.COD_ISENC = 1
                OR c_atm.COD_ISENC    = 3 )
            then
                set X_VLR_MANIF = (X_VLR_MANIF + c_atm.VLR_LUCRO);


                --
            END IF;


            --
            --- Fim
            INSERT INTO TDESTINO
                (
                    CTL_AVERB    ,
                    NUM_LOCAL    ,
                    VLR_MANIF    ,
                    COD_USER     ,
                    DHR_ALTER    ,
                    PCE_TAXA     ,
                    VLR_ISENC_OUT,
                    VLR_ISENC_DC ,
                    PCE_TARIF_CBR
                )
            VALUES
                (
                    X_CTL_AVERB    ,
                    D_NUM_LOCAL_DES,
                    X_VLR_MANIF    ,
                    'AT&M'         ,
                    X_DHR_ALTER    ,
                    0              ,
                    null           ,
                    null           ,
                    null
                )
            ;


            --
            --
            --##################################	
            -- TITEM_DESTINO
            SET X_NUM_SEQUE_ITE = 1;


            --
            --
            SET X_NUM_CONHE = 0;


            --
            --
            SET X_NUM_NTFIS = 0;


            --
            --
            SET X_COD_MANIF = '';


            --
            --
            IF
                X_NUM_RAMO              = 30
                AND c_atm.COD_IMPOR_EPT = 2
            THEN
                SET D_NUM_LOCAL_DES = X_DESTINO_EXP;


                --
                --
                SET X_COD_PRACA_DES = X_PRACA_DES_EXP;


                --
                --
            END IF;


            --
            --
            IF
                X_NUM_RAMO              = 30
                AND c_atm.COD_IMPOR_EPT = 1
            THEN
                SET X_COD_PRACA_ORI = X_PRACA_ORI_EXP;


                --
                --
            END IF;


            --
            --
            IF
                c_atm.COD_MODAD_TRA = '2'
            THEN
                SET X_NUM_CONHE = c_atm.COD_NTFIS;


                --
                ELSEIF c_atm.COD_MODAD_TRA = '3'
            THEN
                SET X_NUM_NTFIS = c_atm.COD_NTFIS;


                --
                --
            ELSE
                SET X_COD_MANIF = c_atm.COD_NTFIS;


                --
                --
            END IF;


            --
            --
            IF
                c_atm.COD_ISENC    = 1
                OR c_atm.COD_ISENC = 3
            THEN
                SET X_VLR_MERCA = c_atm.VLR_DOCUM_DDR;


                --
            ELSE
                SET X_VLR_MERCA = c_atm.VLR_MERCA;


                --
            END IF;


            --
            --
            --- Inicio: Soma Imposto - Alterado em 10/02/2017 - Neide e Antonio
            --- Alterado em 05/06/2019 - Adriano, Edirlei e Geandro
            IF
                c_atm.VLR_IMPOS > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_IMPOS);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar o seguro do frete - 05/06/19 - Adriano, Edirlei e Geandro
            IF
                c_atm.VLR_FRETE > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_FRETE);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar as despesas - 21/08/19 - Adriano e Geandro
            IF
                c_atm.VLR_DESPE > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_DESPE);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar os acessórios - 21/08/19 - Adriano e Geandro
            IF
                c_atm.VLR_ACESS > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_ACESS);


                --
            END IF;


            --
            --- Fim
            --- Regra criada para cobrar os lucros - 21/08/19 - Adriano e Geandro
            IF
                c_atm.VLR_LUCRO > 0
            then
                set X_VLR_MERCA = (X_VLR_MERCA + c_atm.VLR_LUCRO);


                --
            END IF;


            --
            --- Fim
            INSERT INTO TITEM_DESTINO
                (
                    CTL_AVERB    ,
                    NUM_LOCAL    ,
                    NUM_SEQUE_ITE,
                    COD_MANIF    ,
                    NUM_CONHE    ,
                    NUM_NTFIS    ,
                    NUM_PRACA    ,
                    NUM_ESPEI_MER,
                    TIP_TRNSP    ,
                    VLR_MERCA    ,
                    QTD_MERCA    ,
                    DES_ESPEI    ,
                    QTD_PESO     ,
                    TIP_ISENC_SEG,
                    QTD_VOLUM    ,
                    COD_USER     ,
                    DHR_ALTER    ,
                    NUM_SEQUE_MER,
                    DAT_EMISS_DOC,
                    HOR_EMISS_DOC,
                    STA_CARGA_DGA,
                    STA_ICAME    ,
                    STA_RFLUV    ,
                    STA_AUTLO    ,
                    TIP_FRETE    ,
                    NUM_PRACA_ORI,
                    TIP_EMBAL    ,
                    NUM_PRACA_EMI,
                    PCE_TARIF_CBR,
                    STA_TRECH
                )
            VALUES
                (
                    X_CTL_AVERB        ,
                    D_NUM_LOCAL_DES    ,
                    X_NUM_SEQUE_ITE    ,
                    X_COD_MANIF        ,
                    X_NUM_CONHE        ,
                    X_NUM_NTFIS        ,
                    X_COD_PRACA_DES    ,
                    355                ,
                    null               ,
                    X_VLR_MERCA        ,
                    null               ,
                    null               ,
                    null               ,
                    X_TIP_ISENC_SEG    ,
                    null               ,
                    'AT&M'             ,
                    CURRENT TIMESTAMP  ,
                    1                  ,
                    X_DAT_EMISS_DOC    ,
                    X_HOR_EMISS_DOC    ,
                    c_atm.STA_CARGA_DGA,
                    c_atm.STA_ICAME    ,
                    null               ,
                    c_atm.STA_VEICU_PRP,
                    0                  ,
                    X_COD_PRACA_ORI    ,
                    null               ,
                    null               ,
                    null               ,
                    null
                )
            ;


            --
            --
            IF
                c_atm.VLR_CONER <> 0
            THEN
                SET X_NUM_SEQUE_ITE = 2;


                --
                INSERT INTO TITEM_DESTINO
                    (
                        CTL_AVERB    ,
                        NUM_LOCAL    ,
                        NUM_SEQUE_ITE,
                        COD_MANIF    ,
                        NUM_CONHE    ,
                        NUM_NTFIS    ,
                        NUM_PRACA    ,
                        NUM_ESPEI_MER,
                        TIP_TRNSP    ,
                        VLR_MERCA    ,
                        QTD_MERCA    ,
                        DES_ESPEI    ,
                        QTD_PESO     ,
                        TIP_ISENC_SEG,
                        QTD_VOLUM    ,
                        COD_USER     ,
                        DHR_ALTER    ,
                        NUM_SEQUE_MER,
                        DAT_EMISS_DOC,
                        HOR_EMISS_DOC,
                        STA_CARGA_DGA,
                        STA_ICAME    ,
                        STA_RFLUV    ,
                        STA_AUTLO    ,
                        TIP_FRETE    ,
                        NUM_PRACA_ORI,
                        TIP_EMBAL    ,
                        NUM_PRACA_EMI,
                        PCE_TARIF_CBR,
                        STA_TRECH
                    )
                VALUES
                    (
                        X_CTL_AVERB        ,
                        D_NUM_LOCAL_DES    ,
                        X_NUM_SEQUE_ITE    ,
                        X_COD_MANIF        ,
                        X_NUM_CONHE        ,
                        X_NUM_NTFIS        ,
                        X_COD_PRACA_DES    ,
                        4643               ,
                        null               ,
                        c_atm.VLR_CONER    ,
                        null               ,
                        null               ,
                        null               ,
                        X_TIP_ISENC_SEG    ,
                        null               ,
                        'AT&M'             ,
                        CURRENT TIMESTAMP  ,
                        1                  ,
                        X_DAT_EMISS_DOC    ,
                        X_HOR_EMISS_DOC    ,
                        c_atm.STA_CARGA_DGA,
                        c_atm.STA_ICAME    ,
                        null               ,
                        c_atm.STA_VEICU_PRP,
                        0                  ,
                        X_COD_PRACA_ORI    ,
                        null               ,
                        null               ,
                        null               ,
                        null
                    )
                ;


                --
                --
            END IF;


            --
            --
            IF
                c_atm.COD_AVERB_OFC IS NOT NULL
                AND LENGTH (c_atm.COD_AVERB_OFC) = 40
            THEN
                SET X_COD_AVERB_OFC = c_atm.COD_AVERB_OFC;


                --
                SET X_COD_OPERD_AVB = substr(X_COD_AVERB_OFC, 38, 1);


                --
                --OPERADORA DE AVERBACAO
                SET X_COD_DOCUM_FIS = substr (X_COD_AVERB_OFC, 29, 9);


                --
                --NUMERO DO DOCUMENTO
                SET X_COD_MODEL_FIS = substr (X_COD_AVERB_OFC, 24, 2);


                --
                --MODELO DO DOCUMENTO
                SET X_COD_SERIE_FIS = substr (X_COD_AVERB_OFC, 26, 3);


                --
                --SERIE DO DOCUMENTO
                SET X_COD_DOCUM_EMI = substr (X_COD_AVERB_OFC, 10, 14);


                --
                --CNPJ DO EMISSOR DO DOCUMENTO
                SET X_COD_CIA_SSP = substr (X_COD_AVERB_OFC, 1, 5);


                --
                --CODIGO SUSEP OPERADORA
                SET X_COD_ANMES_FVI = substr (X_COD_AVERB_OFC, 6, 4);


                --
                --FIM DA VIGENCIA DA APOLICE
                INSERT INTO tAVERBACAO_OFICIAL
                    (
                        CTL_AVERB    ,
                        COD_AVERB_OFC,
                        COD_OPERD_AVB,
                        COD_DOCUM_FIS,
                        COD_MODEL_FIS,
                        COD_SERIE_FIS,
                        COD_DOCUM_EMI,
                        COD_CIA_SSP  ,
                        COD_ANMES_FVI,
                        COD_USER_INC ,
                        DHR_INCLU    ,
                        COD_USER_ALT ,
                        DHR_ALTER    ,
                        IDT_CONTR_INT
                    )
                VALUES
                    (
                        X_CTL_AVERB      ,
                        X_COD_AVERB_OFC  ,
                        X_COD_OPERD_AVB  ,
                        X_COD_DOCUM_FIS  ,
                        X_COD_MODEL_FIS  ,
                        X_COD_SERIE_FIS  ,
                        X_COD_DOCUM_EMI  ,
                        X_COD_CIA_SSP    ,
                        X_COD_ANMES_FVI  ,
                        'AT&M'           ,
                        CURRENT TIMESTAMP,
                        NULL             ,
                        NULL             ,
                        'N'
                    )
                ;


                --
            END IF;


            --
            --##################################	
        END IF;


        --
        --
    END IF;


    --
    --
    END FOR;


    --
    --
    --
    --
    END