create or replace PROCEDURE            pc_infolog_telerisco
AS
a_infolog_ultimo_process UTL_FILE.FILE_TYPE;
a_infolog_telerisco      UTL_FILE.FILE_TYPE;
I_buffer                  VARCHAR2(1000);
I_file                    VARCHAR2(30);
I_file_dhr_inicio         VARCHAR2(14);
I_file_dhr_termino        VARCHAR2(14);
I_CpfMotorista            VARCHAR2(11);
I_DatInclusao             VARCHAR2(8);
I_UfOrigemInfo            VARCHAR2(10);
I_DhrInicioReal           VARCHAR2(08);
I_Nreg                    NUMBER;
i                         NUMBER := 0;
pdhr_inicio               VARCHAR2(8);
pdhr_termino              VARCHAR2(8);
pdt_ultimo_process        VARCHAR2(100);
--
CURSOR c1 is
    --VIAGENS INFOLOG
    SELECT    to_char(nvl(MOT.cod_docum_mot, ' '))                                 AS cpfmotorista
              ,nvl(MOT.nom_motorista, ' ')                                         AS nomemotorista
              ,to_char(pv.ctl_trnsp)                                               AS codtransportadora
              ,to_char(nvl(fc_vinculado_documento(pv.ctl_trnsp, 1), ' '))          AS cnpjtransportadora
              ,fc_vinculado_nom_guerr(pv.ctl_trnsp)                                AS nometransportadora
              ,nvl(fc_relatorio_placa_veiculo(pv.ctl_plvia), ' ')                  AS numplaca
              ,to_char(nvl(fc_vinculado_endereco_uf(pv.ctl_remet, 1), '0'))        AS uforigem
              ,to_char(nvl(dpv.ctl_desti, 0))                                      AS ctldestino
              ,to_char(nvl(fc_vinculado_endereco_uf(dpv.ctl_desti, 1), '0'))       AS ufdestino
              ,NVL((SELECT NVL(TO_CHAR(dhr_previ_sis,'yyyymmdd'),' ') 
                FROM ROTEIRO_MOTORISTA 
                WHERE ctl_plvia = PV.ctl_plvia 
                  AND ord_desti=0
                  AND ctl_parad = 10
                  AND ctl_ptopd = PV.ctl_remet ),' ')                                   AS dhrinicioprevisto
              ,NVL((SELECT NVL(TO_CHAR(dhr_efeti_rea,'yyyymmdd'), ' ') 
                FROM roteiro_motorista 
                WHERE ctl_plvia = PV.ctl_plvia 
                  AND ord_desti=0
                  AND ctl_parad = 10
                  AND ctl_ptopd = PV.ctl_remet
                  AND sit_fase_rea in ('R','T')),' ' )                                   AS dhrinicioreal
              ,IMC.des_meio_cmu                                                    AS tipomonitoramento
              ,NVL(to_char(pv.dhr_atvie_pln, 'YYYYMMDD'), ' ')                               AS datainclusao
              ,10                                                                  AS origeminfo
          FROM supervisor.plano_viagem              pv
              ,supervisor.TINF_MOTORISTA_PLANO_VIAGEM    mpv
              ,supervisor.destinatario_plano_viagem dpv
              ,PAMAIS_PRD.V_CRP_MOTORISTA MOT
              ,SUPERVISOR.TINF_MEIO_COMUNICACAO IMC
         WHERE pv.ctl_plvia = mpv.ctl_plvia(+)
           	AND MOT.ctl_motot(+) = MPV.ctl_motot  
           	AND MOT.tip_docum_pes = 2
           	AND pv.ctl_plvia = dpv.ctl_plvia
           	AND PV.tip_rastr = IMC.tip_meio_cmu
           	AND pv.sit_plvia not in(10,14,19,20,16)
           	AND to_char(pv.dhr_atvie_pln, 'YYYYMMDD') BETWEEN pdt_ultimo_process AND to_char(SYSDATE, 'YYYYMMDD') 
     		ORDER BY cpfMotorista, dataInclusao;
BEGIN
  --
  --ABRE ARQUIVO COM DATA DO ULTIMO PROCESSAMENTO PARA PROCESSAMENTO FORMATO YYYYMMDD
  --
  a_infolog_ultimo_process := UTL_FILE.FOPEN('/work/viagenstelerisco/','ULTIMO_PROCESSAMENTO_INFOLOG.INI','r');
  UTL_FILE.GET_LINE(a_infolog_ultimo_process, pdt_ultimo_process);
  UTL_FILE.FCLOSE(a_infolog_ultimo_process);
  --
  --DEFINE NOME DO ARQUIVO
  --
  SELECT TO_CHAR(SYSDATE,'YYYYMMDD')
    INTO pdhr_termino
    FROM dual;
--
  SELECT 'MTR'||pdt_ultimo_process||pdhr_termino||'.TXT'
    INTO I_file
    FROM dual;
  --
  --CRIA/ABRE ARQUIVO DE SAIDA TXT
  --
  a_infolog_telerisco := UTL_FILE.FOPEN('/work/viagenstelerisco/',I_file,'w');
  --
  --HEADER
  --
  SELECT SUBSTR(TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS'),1,14) INTO I_file_dhr_inicio
  FROM dual;
--
  I_buffer := RPAD('0'||I_file_dhr_inicio
                      ||pdhr_inicio
                      ||pdhr_termino,144,' ') ;
  UTL_FILE.PUT_LINE(a_infolog_telerisco, I_buffer);
  --
  --PROCESSAMENTO
  --
  I_Nreg := 0;
  I_CpfMotorista := '';
  I_DatInclusao  := '';
  I_UfOrigemInfo   := '';
--  
  FOR i IN C1 loop
--
    I_UfOrigemInfo:= i.uforigem;
    I_DhrInicioReal := i.dhrInicioReal;
    IF i.dhrInicioReal = ' ' THEN
       I_DhrInicioReal := i.dhrInicioPrevisto;
    END IF;
--
    IF fc_valida_cpf(NVL(i.cpfMotorista,' ')) = 'TRUE'  AND
       i.cnpjTransportadora != ' ' AND
       i.numPlaca           != ' ' AND
       I_UfOrigemInfo       != '0' AND
       i.ufDestino          != '0' THEN
--
       IF i.cpfMotorista = I_CpfMotorista THEN
          --CASO A DATA SEJA IGUAL, NAO GRAVA NO ARQUIVO
          IF i.dataInclusao != I_DatInclusao THEN
             I_buffer := '1'||LPAD(i.cpfMotorista,11,'0')
                            ||RPAD(i.nomeMotorista,50,' ')
                            ||LPAD(i.cnpjTransportadora,15,'0')
                            ||RPAD(i.nomeTransportadora,30,' ')
                            ||RPAD(i.numPlaca,7,' ')
                            ||LPAD(I_UfOrigemInfo,3,'0')
                            ||LPAD(i.ufDestino,3,'0')
                            ||I_DhrInicioReal
                            ||RPAD(i.tipoMonitoramento,15,' ')
                            ||i.origemInfo;
--
             UTL_FILE.PUT_LINE(a_infolog_telerisco, I_buffer);
             I_Nreg         := I_Nreg + 1;
             I_CpfMotorista := i.cpfMotorista;
             I_DatInclusao  := i.dataInclusao;
          END IF;
       ELSE
          I_buffer := '1'||LPAD(i.cpfMotorista,11,'0')
                         ||RPAD(i.nomeMotorista,50,' ')
                         ||LPAD(i.cnpjTransportadora,15,'0')
                         ||RPAD(i.nomeTransportadora,30,' ')
                         ||RPAD(i.numPlaca,7,' ')
                         ||LPAD(I_UfOrigemInfo,3,'0')
                         ||LPAD(i.ufDestino,3,'0')
                         ||I_DhrInicioReal
                         ||RPAD(i.tipoMonitoramento,15,' ')
                         ||i.origemInfo;
--
          UTL_FILE.PUT_LINE(a_infolog_telerisco, I_buffer);
          I_Nreg         := I_Nreg + 1;
          I_CpfMotorista := i.cpfMotorista;
          I_DatInclusao  := i.dataInclusao;
       END IF;
    END IF;
  END LOOP;
  --
  --TRAILER
  --
  SELECT SUBSTR(TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS'),1,14) INTO I_file_dhr_termino
  FROM dual;
  I_buffer := RPAD('9'||I_file_dhr_termino||LPAD(I_Nreg,10,0),144,' ');
  UTL_FILE.PUT_LINE(a_infolog_telerisco, I_buffer);
  --
  --FECHA ARQUIVO TXT
  --
  UTL_FILE.FCLOSE(a_infolog_telerisco);
  --
  --GRAVACAO DA DATA DO ULTIMO PROCESSAMENTO FORMATO YYYYMMDD
  --
  a_infolog_ultimo_process := UTL_FILE.FOPEN('/work/viagenstelerisco/','ULTIMO_PROCESSAMENTO_INFOLOG.INI','w');
  UTL_FILE.PUT_LINE(a_infolog_ultimo_process, TO_CHAR(SYSDATE,'YYYYMMDD'));
  UTL_FILE.FCLOSE(a_infolog_ultimo_process);
--
EXCEPTION
      WHEN utl_file.invalid_operation THEN
           dbms_output.put_line('Operacao invalida no arquivo.'||'ORIGEM: '||I_UfOrigemInfo||'  CpfMotorista: '||I_CpfMotorista);
           utl_file.fclose(a_infolog_ultimo_process);
END pc_infolog_telerisco;