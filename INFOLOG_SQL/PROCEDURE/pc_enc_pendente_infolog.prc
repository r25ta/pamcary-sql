CREATE OR REPLACE PROCEDURE SUPERVISOR.pc_enc_pendente_infolog
/********************************************************
 Sistema........: Infolog
 Descrição......: Realiza o encerramento de viagens
                  cuja a data e hora prevista de encerramento
                  ultrapasse a dois dias
 Responsável....: Rafael Madeira
 Ambiente.......: Produção (Diveo) / Desenv (Taurus)
 Versão/Criação.: V02 - 19/10/2005
 ConHelp........: 21077
 ********************************************************
 Histórico de Modificação:
 ********************************************************
 Data     Sigla   Comentários
 -------- ------- ---------------------------------------
*********************************************************/
 AS
 I_plano              number;
 plano                number;
 I_destino            number;
 I_destino1           number;
 I_destino2           number;
 I_destino3           number;
 I_destino4           number;
 I_destino5           number;
 I_situacao           number;
 I_Nreg               number;
 i                    number := 0;
--
CURSOR FINALIZA is
  SELECT PV.ctl_plvia, RM.ctl_ptopd, RM.sit_fase_rea, DPV.ord_desti, DPV.sit_plvia
    FROM PLANO_VIAGEM PV,
         ROTEIRO_MOTORISTA RM,
         DESTINATARIO_PLANO_VIAGEM DPV
   WHERE PV.ctl_plvia = RM.ctl_plvia
     AND PV.ctl_plvia = DPV.ctl_plvia
     AND RM.ctl_ptopd = DPV.ctl_desti
     AND PV.sit_plvia IN ( 0, 1 )
     AND RM.ctl_parad = 12
     AND RM.sit_fase_rea IN ( 'M', 'S' )
     AND PV.ctl_opera_tip NOT IN ( 13, 14 )
     AND RM.dhr_efeti_rea+2 < SYSDATE
ORDER BY PV.ctl_plvia;
--
CFINALIZA FINALIZA%ROWTYPE;
--
CURSOR C1 is
  SELECT ctl_plvia
    FROM PLANO_VIAGEM
   WHERE sit_plvia IN ( 0, 1 )
ORDER BY ctl_plvia;
--
RC1 C1%ROWTYPE;
--
CURSOR DSPLVIAGEM is
 SELECT NVL(sit_plvia, 8) as sit_plvia
 FROM DESTINATARIO_PLANO_VIAGEM
 WHERE ctl_plvia = plano;
--
cDSPLVIAGEM DSPLVIAGEM%ROWTYPE;
--
BEGIN
--
--Processamento
--
  OPEN FINALIZA;
  FETCH FINALIZA INTO cFINALIZA;
--
  LOOP
  EXIT WHEN FINALIZA%NOTFOUND;
--
     I_plano    := cFINALIZA.ctl_plvia;
     I_destino  := cFINALIZA.ctl_ptopd;
     I_destino1 := 99;
     I_destino2 := 99;
     I_destino3 := 99;
     I_destino4 := 99;
     I_destino5 := 99;
--
     WHILE I_plano = cFINALIZA.ctl_plvia LOOP
--
        UPDATE DESTINATARIO_PLANO_VIAGEM
           SET sit_plvia = 8
         WHERE ctl_plvia = I_plano
           AND ctl_desti = cFINALIZA.ctl_ptopd;
--
        COMMIT;
--
        FETCH FINALIZA INTO cFINALIZA;
        EXIT WHEN FINALIZA%NOTFOUND;
--
     END LOOP;
  END LOOP;
  CLOSE FINALIZA;
--
  OPEN C1;
  FETCH C1 INTO RC1;
--
  LOOP
  EXIT WHEN C1%NOTFOUND;
--
    FETCH C1 INTO RC1;
     IF C1%NOTFOUND THEN
        EXIT;
     END IF;
     plano := RC1.ctl_plvia;
-- 
     OPEN DSPLVIAGEM;
     FETCH DSPLVIAGEM INTO cDSPLVIAGEM;
     IF DSPLVIAGEM%FOUND THEN
        I_destino1 := cDSPLVIAGEM.sit_plvia;
        FETCH DSPLVIAGEM INTO cDSPLVIAGEM;
        IF DSPLVIAGEM%FOUND THEN
           I_destino2 := cDSPLVIAGEM.sit_plvia;
--
           FETCH DSPLVIAGEM INTO cDSPLVIAGEM;
           IF DSPLVIAGEM%FOUND THEN
              I_destino3 := cDSPLVIAGEM.sit_plvia;
--
              FETCH DSPLVIAGEM INTO cDSPLVIAGEM;
              IF DSPLVIAGEM%FOUND THEN
                 I_destino4 := cDSPLVIAGEM.sit_plvia;
--
                 FETCH DSPLVIAGEM INTO cDSPLVIAGEM;
                 IF DSPLVIAGEM%FOUND THEN
                    I_destino5 := cDSPLVIAGEM.sit_plvia;
                 END IF;
              END IF;
           END IF;
        END IF;
     END IF;
     CLOSE DSPLVIAGEM;
--
     I_situacao := 99;
--
     IF I_destino1 = 0 OR I_destino2 = 0 OR I_destino3 = 0 OR I_destino4 = 0 OR I_destino5 = 0 THEN
        I_situacao := 0;
--
     ELSIF I_destino1 = 1 OR I_destino2 = 1 OR I_destino3 = 1 OR I_destino4 = 1 OR I_destino5 = 1 THEN
        I_situacao := 1;
--
     ELSIF I_destino1 = 8 OR I_destino2 = 8 OR I_destino3 = 8 OR I_destino4 = 8 OR I_destino5 = 8 THEN
        I_situacao := 8;
--
     ELSE
        I_situacao := 2;
--
     END IF;
--
     IF I_situacao <> 99 THEN
        UPDATE PLANO_VIAGEM
           SET sit_plvia = I_situacao
         WHERE ctl_plvia = plano;
     END IF;
--
     COMMIT;
--


  END LOOP;
  CLOSE C1;
--
END PC_ENC_PENDENTE_INFOLOG;
/
