SELECT * FROM VEICULO
WHERE NUM_MCT = 797768


SELECT * FROM MODELO_VEICULO
WHERE CTL_MODEL = 2185


SELECT * FROM GENERO_VEICULO
WHERE CTL_GENER = 3


SELECT * FROM SUB_SERVICO_SISTEMA
SELECT * FROM SERVICO_SISTEMA



INSERT INTO SUB_SERVICO_SISTEMA VALUES(SQ_CTL_SERVI_SUB.NEXTVAL,1,'Comunicador Autotrac',sysdate,to_date('31/01/2008 01:00:01','dd/mm/yyyy hh24:mi:ss'), null,'COMUNICADOR',SYSDATE,'PAMSIST',NULL,NULL,326,NULL)
