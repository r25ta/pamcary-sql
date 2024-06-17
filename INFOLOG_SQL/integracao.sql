# MySQL-Front Dump 2.5
#
# Host: localhost   Database: integracao
# --------------------------------------------------------
# Server version 3.23.56-nt


#
# Table structure for table 'posicaoidterminal'
#

CREATE TABLE posicaoidterminal (
  numTerminal int(10) unsigned default '0',
  numLatit int(6) unsigned default '0',
  numLong int(6) unsigned default '0',
  staMotor int(1) unsigned default '0',
  dhrPosic varchar(14) default NULL,
  desPosic varchar(50) default NULL,
  codUser varchar(30) NOT NULL default '',
  dhrManut varchar(14) default NULL
) TYPE=MyISAM;



#
# Dumping data for table 'posicaoidterminal'
#

INSERT INTO posicaoidterminal VALUES("739508", "225232", "470751", "1", "020904091058", "0.34 Km S of SP 348 KM1", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("717902", "224206", "471822", "1", "020904091131", "Right at BALANCA GOODYEAR- AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("738367", "224318", "471745", "2", "020904091215", "Right at MATRIZ HIPERION-AMERICANA/SP.", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("719901", "235340", "462922", "1", "020904091158", "1.51 Km ONO of BAL IMIGRANTES", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("703461", "235725", "461833", "1", "020904091216", "1.17 Km SE of TERMINAL MARIMEX-SANTOS/SP.", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("683971", "235259", "462644", "1", "020904091158", "0.63 Km NO of ACS CUBATAO KM 55", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("683971", "235259", "462644", "1", "020904091218", "0.63 Km NO of ACS CUBATAO KM 55", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("738367", "224318", "471745", "2", "020904091258", "Right at MATRIZ HIPERION-AMERICANA/SP.", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("771431", "224356", "471829", "1", "020904091246", "0.49 Km SO of T TRANS-IGUACU/AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("683971", "235259", "462644", "1", "020904091340", "0.63 Km NO of ACS CUBATAO KM 55", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("717902", "224206", "471822", "1", "020904091320", "Right at BALANCA GOODYEAR- AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("683947", "224210", "471822", "1", "020904091102", "0.11 Km SSO of BALANCA GOODYEAR- AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("738367", "224318", "471745", "2", "020904091342", "Right at MATRIZ HIPERION-AMERICANA/SP.", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("717902", "224206", "471822", "1", "020904091406", "Right at BALANCA GOODYEAR- AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("684529", "224229", "471810", "2", "020904091411", "0.12 Km S of GOODYEAR AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("738367", "224318", "471745", "2", "020904091425", "Right at MATRIZ HIPERION-AMERICANA/SP.", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("719901", "235336", "462822", "1", "020904091500", "0.52 Km NNE of BAL IMIGRANTES", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("717902", "224206", "471822", "1", "020904091501", "Right at BALANCA GOODYEAR- AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("717902", "224206", "471822", "1", "020904091523", "Right at BALANCA GOODYEAR- AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("683947", "224411", "471656", "1", "020904091606", "0.25 Km S of POS 7 KM 123", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("195560", "224206", "471822", "1", "020904091806", "Right at BALANCA GOODYEAR- AMERICANA/SP", "COMUNICADORJAVA", "030915161901");
INSERT INTO posicaoidterminal VALUES("719901", "235259", "462736", "1", "020904091806", "1.95 Km ONO of ACS CUBATAO KM 55", "COMUNICADORJAVA", "030915161901");


#
# Table structure for table 'posicaomacro'
#

CREATE TABLE posicaomacro (
  ctlPosicaoMacro tinyint(10) unsigned NOT NULL default '0',
  numTerminal int(10) unsigned default '0',
  ctlTrnsp int(10) unsigned NOT NULL default '0',
  numEvento int(10) unsigned NOT NULL default '0',
  dhrEvent datetime NOT NULL default '0000-00-00 00:00:00',
  desOrige varchar(50) default NULL,
  desDesti varchar(50) default NULL,
  dhrPrevi datetime default NULL,
  dhrPreviTer datetime default NULL,
  desLocal varchar(100) default NULL,
  desLatiti varchar(6) default NULL,
  desLongi varchar(6) default NULL,
  codUser varchar(30) default NULL,
  dhrManut datetime default NULL,
  PRIMARY KEY  (ctlPosicaoMacro),
  KEY ctlPosicaoMacro (ctlPosicaoMacro)
) TYPE=MyISAM;



#
# Dumping data for table 'posicaomacro'
#

