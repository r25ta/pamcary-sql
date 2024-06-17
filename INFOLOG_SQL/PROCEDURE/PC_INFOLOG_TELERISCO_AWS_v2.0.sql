/*ESCOPO:
    PROCEDURE RESPOSNSAVEL POR RETORNAR O MOVIMENTO DE VIAGENS INFOLOG RISCOS DO DIA
  MUDANÇA: 18-12-2019
    RETIRADA DAS LINHAS HEADER E TRAILLER -> pedido: "Anteriormente os arquivos Viagens Infolog, 
                                                      vinham com linhas de READER e TRAILER, 
                                                      no futuro sistema  estes registros 
                                                      deixam de ser necessários."
*/
create or replace PROCEDURE    pc_mntcarga_telerisco_aws
AS
a_infolog_ultimo_process UTL_FILE.FILE_TYPE;
a_infolog_telerisco      UTL_FILE.FILE_TYPE;
I_buffer                  VARCHAR2(1000);
I_file                    VARCHAR2(40);
I_file_dhr_process        VARCHAR2(16);
I_file_dhr_termino        VARCHAR2(16);
I_CpfMotorista            VARCHAR2(11);
I_DatInclusao             VARCHAR2(8);
I_UfOrigemInfo            VARCHAR2(10);
I_Nreg                    NUMBER := 0 ;
i                         NUMBER := 0;
I_file_directory          VARCHAR2(30);
I_file_last_process       VARCHAR2(40);
pdt_ultimo_process        VARCHAR2(100);
I_ValidarDataInclusao     BOOLEAN;
I_ViagemInfolog           NUMBER := 0;
--
CURSOR c1 is
  --VIAGENS INFOLOG
  SELECT
      NVL(MOT.cod_docum_mot,'0')                                              AS cpfMotorista
      ,NVL(MOT.nom_motorista,' ')                                             AS nomeMotorista
      ,NVL(pv.ctl_trnsp,0)                                                    AS codTransportadora
      ,NVL(fc_vinculado_documento(pv.ctl_trnsp,1),'0')                        AS cnpjTransportadora
      ,NVL(FC_VINCULADO_NOM_GUERR(pv.ctl_trnsp),' ')                          AS nomeTransportadora
      ,NVL(FC_RELATORIO_PLACA_VEICULO(pv.ctl_plvia),' ')                      AS numPlaca
--
      ,NVL((SELECT PROVEDOR.COD_DOCUM_PRI
                    FROM
                      SUPERVISOR.PLANO_VIAGEM PLANO,
                      SUPERVISOR.TINF_RELAC_VEICU_DISPO_PLANO travelPlan,
                      SUPERVISOR.TINF_DISPOSITIVO DI,
                      PAMAIS_PRD.V_CRP_PROVEDOR_TECNOLOGIA PROVEDOR,
                      PAMAIS_PRD.V_CRP_VEICULO V,
            SUPERVISOR.TINF_RELAC_PROVE_RASTR_DISPO PRD
            ,SUPERVISOR.TINF_RELAC_VEICU_DISPO RVD
                    WHERE PLANO.CTL_PLVIA = pv.ctl_plvia
                      AND PLANO.CTL_PLVIA         = TRAVELPLAN.CTL_PLVIA
                      AND TRAVELPLAN.CTL_DISPO_RST    = DI.CTL_DISPO_RST
                      AND DI.CTL_DISPO_RST = PRD.CTL_DISPO_RST
                      AND PRD.CTL_PROVE_TEN = PROVEDOR.CTL_PROVE_TEN
                      AND RVD.CTL_DISPO_RST = travelPlan.CTL_DISPO_RST
                      AND RVD.CTL_VEICU = travelPlan.CTL_VEICU
                      AND RVD.STA_ATIVO = 'S'
                      AND travelPlan.CTL_VEICU = V.CTL_VEICU(+)
                      AND V.NUM_CATEG_VEI <> 3
            AND PRD.TIP_RASTR NOT IN (4)
            AND ROWNUM = 1 ),'0')                                             AS cnpjProvedor
--
      ,NVL((SELECT PROVEDOR.NOM_FANTS
                    FROM
                      SUPERVISOR.PLANO_VIAGEM PLANO,
                      SUPERVISOR.TINF_RELAC_VEICU_DISPO_PLANO travelPlan,
                      SUPERVISOR.TINF_DISPOSITIVO DI,
                      PAMAIS_PRD.V_CRP_PROVEDOR_TECNOLOGIA PROVEDOR,
                      PAMAIS_PRD.V_CRP_VEICULO V,
            SUPERVISOR.TINF_RELAC_PROVE_RASTR_DISPO PRD
            ,SUPERVISOR.TINF_RELAC_VEICU_DISPO RVD
                    WHERE PLANO.CTL_PLVIA = pv.ctl_plvia
                      AND PLANO.CTL_PLVIA         = TRAVELPLAN.CTL_PLVIA
                      AND TRAVELPLAN.CTL_DISPO_RST    = DI.CTL_DISPO_RST
                      AND DI.CTL_DISPO_RST = PRD.CTL_DISPO_RST
                      AND PRD.CTL_PROVE_TEN = PROVEDOR.CTL_PROVE_TEN
                      AND RVD.CTL_DISPO_RST = travelPlan.CTL_DISPO_RST
                      AND RVD.CTL_VEICU = travelPlan.CTL_VEICU
                      AND RVD.STA_ATIVO = 'S'
                      AND travelPlan.CTL_VEICU = V.CTL_VEICU(+)
                      AND V.NUM_CATEG_VEI <> 3
            AND PRD.TIP_RASTR NOT IN (4)
            AND ROWNUM = 1 ),' ')                                             AS nomeProvedor
--
      , NVL((SELECT  DI.COD_DISPO_RST
                    FROM
                      SUPERVISOR.PLANO_VIAGEM PLANO,
                      SUPERVISOR.TINF_RELAC_VEICU_DISPO_PLANO travelPlan,
                      SUPERVISOR.TINF_DISPOSITIVO DI,
                      PAMAIS_PRD.V_CRP_PROVEDOR_TECNOLOGIA PROVEDOR,
                      PAMAIS_PRD.V_CRP_VEICULO V,
            SUPERVISOR.TINF_RELAC_PROVE_RASTR_DISPO PRD
            ,SUPERVISOR.TINF_RELAC_VEICU_DISPO RVD
                    WHERE PLANO.CTL_PLVIA = pv.ctl_plvia
                      AND PLANO.CTL_PLVIA         = TRAVELPLAN.CTL_PLVIA
                      AND TRAVELPLAN.CTL_DISPO_RST    = DI.CTL_DISPO_RST
                      AND DI.CTL_DISPO_RST = PRD.CTL_DISPO_RST
                      AND PRD.CTL_PROVE_TEN = PROVEDOR.CTL_PROVE_TEN
                      AND RVD.CTL_DISPO_RST = travelPlan.CTL_DISPO_RST
                      AND RVD.CTL_VEICU = travelPlan.CTL_VEICU
                      AND RVD.STA_ATIVO = 'S'
                      AND travelPlan.CTL_VEICU = V.CTL_VEICU(+)
                      AND V.NUM_CATEG_VEI <> 3
            AND PRD.TIP_RASTR NOT IN (4)
            AND ROWNUM = 1),'0')                                          AS idProvedor
--
      ,(SELECT NVL(num_renav,0)
        FROM PAMAIS_PRD.v_crp_veiculo v,
        SUPERVISOR.Tinf_veicu_plano_viagem vpv
          WHERE v.ctl_veicu = vpv.ctl_veicu
          AND v.num_categ_vei <> 3
          AND vpv.ctl_plvia = pv.ctl_plvia
          AND ROWNUM = 1 )                                                    AS renavam
  --
      ,NVL((SELECT v.ctl_local
        FROM PAMAIS_PRD.v_crp_veiculo v,
        SUPERVISOR.Tinf_veicu_plano_viagem vpv
          WHERE v.ctl_veicu = vpv.ctl_veicu
          AND v.num_categ_vei <> 3
          AND ctl_plvia = pv.ctl_plvia
          AND ROWNUM = 1),0)                                                  AS cidadeEmplacamento
  --
      ,NVL((SELECT pr.cod_unfed
        FROM PRACA pr,
        PAMAIS_PRD.v_crp_veiculo v,
        SUPERVISOR.Tinf_veicu_plano_viagem vpv
          WHERE v.ctl_veicu = vpv.ctl_veicu
          AND pr.cod_praca = v.ctl_local
          AND v.num_categ_vei <> 3
          AND vpv.ctl_plvia = pv.ctl_plvia
          AND ROWNUM = 1),0)                                                  AS ufEmplacamento
  --
      ,NVL(( SELECT doc.cod_docum
        FROM SUPERVISOR.Tinf_veicu_propr_motot iv,
        PAMAIS_PRD.v_crp_veiculo v,
        SUPERVISOR.Tinf_veicu_plano_viagem vpv,
        DOC_VINCULADO doc
          WHERE v.num_categ_vei <> 3
          AND iv.ctl_veicu = v.ctl_veicu
          AND vpv.ctl_veicu = v.ctl_veicu
          AND iv.ctl_motot = doc.ctl_vincd
          AND vpv.ctl_plvia = pv.ctl_plvia ),'0')                             AS cnpjProprietario
  --
       ,NVL((SELECT FC_VINCULADO_NOM_GUERR(iv.ctl_motot)
          FROM SUPERVISOR.Tinf_veicu_propr_motot iv,
          PAMAIS_PRD.v_crp_veiculo v,
          SUPERVISOR.Tinf_veicu_plano_viagem vpv
            WHERE v.num_categ_vei <> 3
            AND iv.ctl_veicu = v.ctl_veicu
            AND vpv.ctl_veicu = v.ctl_veicu
            AND vpv.ctl_plvia =pv.ctl_plvia),' ')                             AS nomeProprietario
  --
        ,NVL((SELECT cod_praca
          FROM ENDERECO_VINCULADO e
            WHERE e.ctl_vincd = pv.ctl_remet),0)                              AS cidadeOrigem
  --
        ,NVL(FC_VINCULADO_ENDERECO_UF(pv.ctl_remet, 1),0)                     AS ufOrigem
        ,NVL(pv.ctl_desti, 0)                                                 AS ctlDestino
  --
        ,NVL((SELECT cod_praca
          FROM ENDERECO_VINCULADO e
            WHERE e.ctl_vincd = pv.ctl_desti),0)                              AS cidadeDestino
  --
        ,NVL(FC_VINCULADO_ENDERECO_UF(pv.ctl_desti, 1),0)                     AS ufDestino
        ,PV.ctl_plvia                                                         AS numeroViagem
        ,NVL(IMC.des_meio_cmu,' ')                                            AS tipoMonitoramento
  --
        ,NVL((SELECT TO_CHAR(dhr_efeti_rea,'YYYYMMDDHH24MISS')
          FROM ROTEIRO_MOTORISTA
            WHERE ctl_plvia = PV.ctl_plvia
            AND ord_desti=0
            AND ctl_parad = 10), ' ')                                         AS dhrInicio
  --
        ,NVL(TO_CHAR(pv.dhr_plvia_ter,'YYYYMMDDHH24MISS'),' ')                AS dhrTerminoPrevisto
  --
        ,NVL(TO_CHAR(pv.dhr_atvie_pln, 'YYYYMMDD'), ' ')                      AS dataInclusao
        ,NVL(FC_RELATORIO_DISTANCIA_TOTAL(pv.ctl_plvia),0)                    AS kmTotalPrevisto
  --
        ,NVL( (SELECT d.cod_docum
          FROM DOC_VINCULADO d,
          TIPO_OPERACAO t
            WHERE d.ctl_vincd = t.ctl_vincd_emb
            AND t.ctl_opera_tip = pv.ctl_opera_tip),'0')                      AS cnpjEmbarcador
  --
        ,NVL( (SELECT FC_VINCULADO_NOM_GUERR(t.ctl_vincd_emb)
          FROM TIPO_OPERACAO t
            WHERE t.ctl_opera_tip = pv.ctl_opera_tip),' ')                    AS nomeEmbarcador
  --
        ,NVL((SELECT VCMP.num_merca_pam
          FROM SUPERVISOR.TINF_RELAC_MERCA_GRPNO_PLVIA IRMGP,
          PAMAIS_PRD.V_CRP_MERCADORIA_PAMCARY VCMP
            WHERE VCMP.num_merca_pam = IRMGP.num_merca_pam
            AND IRMGP.ctl_plvia = pv.ctl_plvia
            AND IRMGP.ctl_desti = pv.ctl_desti
            AND ROWNUM = 1),0)                                              AS codMercadoria
  --
        ,NVL(pv.vlr_total_emb,0)                                              AS valorCarregamento
  --
        ,NVL((SELECT DISTINCT r.cod_consu_tlr
          FROM SUPERVISOR.TRECON_TELER_VINCD_PLVIA r
            WHERE r.ctl_plvia = pv.ctl_plvia
            AND r.ctl_motot = mpv.ctl_motot
            AND ROWNUM = 1),0)                                                AS numeroConsultaTelerisco
        ,10                                                                   AS origemInfo
  --
    FROM SUPERVISOR.plano_viagem               pv
    ,SUPERVISOR.TINF_MOTORISTA_PLANO_VIAGEM    mpv
    ,PAMAIS_PRD.V_CRP_MOTORISTA                MOT
    ,SUPERVISOR.TINF_MEIO_COMUNICACAO          IMC
  --
    WHERE pv.ctl_plvia = mpv.ctl_plvia(+)
    AND MOT.ctl_motot(+) = MPV.ctl_motot
    AND MOT.tip_docum_pes = 2
    AND PV.tip_rastr = IMC.tip_meio_cmu
    AND pv.sit_plvia not in(10,14,19,20,16)
    AND to_char(pv.dhr_atvie_pln, 'YYYYMMDDHH24MISS') BETWEEN Pdt_Ultimo_Process AND to_char(SYSDATE, 'YYYYMMDDHH24MISS')
  --
    ORDER BY cpfMotorista, dataInclusao;
--
BEGIN
  I_file_directory := '/work/viagenstelerisco/aws';
  I_file_last_process := 'ULTIMO_PROCESSAMENTO_INFOLOG.INI';
  Pdt_Ultimo_Process := '';
  DBMS_Output.Enable (buffer_size => NULL);
  Dbms_Output.Put_Line('PROCESSO INICIADO!');
  --
  --ABRE ARQUIVO COM DATA DO ULTIMO PROCESSAMENTO NO FORMATO YYYYMMDDHH24MISS
  --
  a_infolog_ultimo_process := UTL_FILE.FOPEN(I_file_directory, I_file_last_process,'r');
  UTL_FILE.GET_LINE(a_infolog_ultimo_process, pdt_ultimo_process);
  UTL_FILE.FCLOSE(a_infolog_ultimo_process);
  dbms_output.put_line('LEITURA DO ARQUIVO ' || I_file_last_process);
  --
  --DEFINE NOME DO ARQUIVO e HEADER
  --SISTEMA ARMAZENA A DATA/HORA DA GERACAO DO ARQUIVO I_FILE_DHR_PROCESS
  SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
    INTO I_file_dhr_process
    FROM dual;
  --
  SELECT 'MTR'||pdt_ultimo_process||I_file_dhr_process||'.TXT'
    INTO I_file
    FROM dual;
  --
  --CRIA/ABRE ARQUIVO DE SAIDA TXT
  --
  a_infolog_telerisco := UTL_FILE.FOPEN(I_file_directory,I_file,'w');
  Dbms_Output.Put_Line('CRIANDO ARQUIVO -> ' || I_file);
  --
  --HEADER
  --I_buffer := RPAD('0'||SUBSTR(pdt_ultimo_process,1,14)
  --                    ||SUBSTR(I_file_dhr_process,1,14),480,' ') ;
  --
  --Dbms_Output.Put_Line('HEADER DO ARQUIVO -> ' || I_buffer);
  --UTL_FILE.PUT_LINE(a_infolog_telerisco, I_buffer);
  --
  --PROCESSAMENTO
  --
  I_Nreg := 0;
  I_CpfMotorista := '00000000000';
  I_DatInclusao  := '19700101';
  I_UfOrigemInfo   := '';
  I_ValidarDataInclusao := false;
  --
  FOR i IN c1 loop
    --
    I_UfOrigemInfo := i.uforigem;
    I_ViagemInfolog := i.numeroViagem;
    --
    dbms_output.put_line('********** VIAGEM INFOLOG ->'|| i.numeroViagem || ' **********');
    --
    IF fc_valida_cpf(NVL(i.cpfMotorista,'0')) = 'TRUE'  AND
      i.cnpjTransportadora != '0' AND
      i.numPlaca           != ' ' AND
      I_UfOrigemInfo       != '0' AND
      i.ufDestino          != '0' THEN
      --
      IF i.cpfMotorista != I_CpfMotorista THEN
        I_CpfMotorista := i.cpfMotorista;
        I_ValidarDataInclusao := true;
        --
      ELSE
        IF i.dataInclusao != I_DatInclusao THEN
          I_DatInclusao  := i.dataInclusao;
          I_ValidarDataInclusao := true;
          --
        ELSE
          I_ValidarDataInclusao := false;
          --
        END IF;
        --
      END IF;
      --
    ELSE
      I_ValidarDataInclusao := false;
      --
    END IF;
    --
    IF I_ValidarDataInclusao THEN
      I_buffer := '1'||LPAD(i.cpfMotorista,11,'0')
        ||RPAD(i.nomeMotorista,50,' ')
        ||LPAD(i.cnpjTransportadora,15,'0')
        ||RPAD(i.nomeTransportadora,50,' ')
        ||RPAD(i.numPlaca,7,' ')
        ||RPAD(i.cnpjProvedor,15,'0')
        ||RPAD(i.nomeProvedor,50,' ')
        ||LPAD(i.idProvedor,15,'0')
        ||RPAD(i.renavam,9,' ')
        ||LPAD(i.cidadeEmplacamento,5,'0')
        ||LPAD(i.ufEmplacamento,3,'0')
        ||LPAD(i.cnpjProprietario,15,'0')
        ||RPAD(i.nomeProprietario,50,' ')
        ||LPAD(i.numeroViagem,10,'0')
        ||RPAD(i.tipoMonitoramento,15,' ')
        ||LPAD(i.cidadeOrigem,5,'0')
        ||LPAD(I_UfOrigemInfo,3,'0')
        ||LPAD(i.cidadeDestino,5,'0')
        ||LPAD(i.ufDestino,3,'0')
        ||i.dhrInicio
        ||i.dhrTerminoPrevisto
        ||i.dataInclusao
        ||LPAD(i.kmTotalPrevisto,10,'0')
        ||LPAD(i.cnpjEmbarcador,15,'0')
        ||RPAD(i.nomeEmbarcador,50,' ')
        ||RPAD(i.codMercadoria,10,' ')
        ||LPAD(i.valorCarregamento,11,'0')
        ||LPAD(i.numeroConsultaTelerisco,9,'0')
        ||i.origemInfo;
      --
      UTL_FILE.PUT_LINE(a_infolog_telerisco, I_buffer);
      I_Nreg := I_Nreg + 1;
      dbms_output.put_line('VIAGEM '|| i.numeroViagem ||' -> '||i.nomeMotorista||' CPF '||i.cpfMotorista);
      dbms_output.put_line('INCLUIR REGISTRO!');
      --
    ELSE
      dbms_output.put_line('VIAGEM '|| i.numeroViagem ||' -> '||i.nomeMotorista||' CPF '||i.cpfMotorista);
      dbms_output.put_line('NAO INCLUIR REGISTRO!');
      --
    END IF;
    --
    dbms_output.put_line('***************************** FIM ****************************');
    --
  END LOOP;
  --
  --TRAILER
  --
  --SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MI') INTO I_file_dhr_termino
  --FROM dual;
  --I_buffer := RPAD('9'||I_file_dhr_termino||LPAD(I_Nreg,10,0),480,' ');
  --UTL_FILE.PUT_LINE(a_infolog_telerisco, I_buffer);
  --
  --dbms_output.put_line('TRAILER DO ARQUIVO -> '|| I_file_dhr_termino );
  --FECHA ARQUIVO TXT
  --
  UTL_FILE.FCLOSE(a_infolog_telerisco);
  --
  --GRAVACAO DA DATA DO ULTIMO PROCESSAMENTO FORMATO YYYYMMDDHH24MISS
  --SISTEMA ARMAZENA A DATA/HORA DA GERAÃÂÃÂO DO ARQUIVO I_FILE_DHR_PROCESS
  a_infolog_ultimo_process := UTL_FILE.FOPEN(I_file_directory, I_file_last_process,'w');
  UTL_FILE.PUT_LINE(a_infolog_ultimo_process, I_file_dhr_process);
  UTL_FILE.FCLOSE(a_infolog_ultimo_process);
  --
  dbms_output.put_line('ARQUIVO ' || I_file || ' GRAVADO EM -> ' || I_file_directory);
  dbms_output.put_line('PROCESSO FINALIZADO!');
  --
  EXCEPTION
    WHEN utl_file.invalid_operation THEN
      dbms_output.put_line('OPERACAO INVALIDA VIAGEM INFOLOG RISCOS ' || I_ViagemInfolog);
      utl_file.fclose(a_infolog_ultimo_process);
END pc_mntcarga_telerisco_aws;