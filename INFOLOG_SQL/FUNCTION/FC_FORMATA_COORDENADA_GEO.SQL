create or replace FUNCTION FC_FORMATA_COORDENADA_GEO
(GRAUS NUMBER, MINUTOS NUMBER, SEGUNDOS NUMBER)
RETURN
VARCHAR2 AS
RETORNO VARCHAR2(6);
VGRAUS VARCHAR2(2);
V1GRAUS VARCHAR2(2);
VMINUTOS VARCHAR2(2);
VSEGUNDOS VARCHAR2(2);
BEGIN
	IF INSTR(GRAUS,'-') > 0 THEN
		V1GRAUS := SUBSTR(GRAUS,2,LENGTH(GRAUS));
	ELSE
		V1GRAUS := GRAUS;
	END IF;

	IF LENGTH(V1GRAUS)<2 THEN
		VGRAUS := '0' || V1GRAUS;
	ELSE
		VGRAUS := V1GRAUS;
	END IF;
	IF LENGTH(MINUTOS)<2 THEN
		VMINUTOS := '0' || MINUTOS;
	ELSE
		VMINUTOS := MINUTOS;
	END IF;	
	IF LENGTH(SEGUNDOS)<2 THEN
		VSEGUNDOS := '0' || SEGUNDOS;
	ELSE
		VSEGUNDOS := SEGUNDOS;
	END IF;
	RETORNO:= VGRAUS || VMINUTOS || VSEGUNDOS;
	RETURN RETORNO;
END;