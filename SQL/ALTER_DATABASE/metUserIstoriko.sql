============================================================================;
================    PUBLIC SYNONYMS FOR USERS    ============================;
============================================================================;

CREATE PUBLIC SYNONYM MET FOR SYSADM.MET ;
CREATE PUBLIC SYNONYM MET_WEB FOR SYSADM.MET_WEB;
CREATE PUBLIC SYNONYM METANATHESI FOR SYSADM.METANATHESI;
CREATE PUBLIC SYNONYM METANATHESI_WEB FOR SYSADM.METANATHESI_WEB;
CREATE PUBLIC SYNONYM METCOURSE FOR SYSADM.METCOURSE;
CREATE PUBLIC SYNONYM METDEPMA FOR SYSADM.METDEPMA;
CREATE PUBLIC SYNONYM METDIAKOP FOR SYSADM.METDIAKOP;
CREATE PUBLIC SYNONYM METDIM FOR SYSADM.METDIM;
CREATE PUBLIC SYNONYM METDIPLGRADE FOR SYSADM.METDIPLGRADE;
CREATE PUBLIC SYNONYM METDSYNERG FOR SYSADM.METDSYNERG;
CREATE PUBLIC SYNONYM METEGR FOR SYSADM.METEGR;
CREATE PUBLIC SYNONYM METEPIBLMA FOR SYSADM.METEPIBLMA;
CREATE PUBLIC SYNONYM METKARTL FOR SYSADM.METKARTL;
CREATE PUBLIC SYNONYM METKARTL_WEB FOR SYSADM.METKARTL_WEB;
CREATE PUBLIC SYNONYM METKATEF FOR SYSADM.METKATEF;
CREATE PUBLIC SYNONYM METKRISI FOR SYSADM.METKRISI;
CREATE PUBLIC SYNONYM METKRISIDEP FOR SYSADM.METKRISIDEP;
CREATE PUBLIC SYNONYM METLANG FOR SYSADM.METLANG;
CREATE PUBLIC SYNONYM METPROCORP FOR SYSADM.METPROCORP;
CREATE PUBLIC SYNONYM METPROGAT FOR SYSADM.METPROGAT;
CREATE PUBLIC SYNONYM METPROGRAM FOR SYSADM.METPROGRAM;
CREATE PUBLIC SYNONYM METPROOD FOR SYSADM.METPROOD;
CREATE PUBLIC SYNONYM METPROSPU FOR SYSADM.METPROSPU;
CREATE PUBLIC SYNONYM METPTYX FOR SYSADM.METPTYX;
CREATE PUBLIC SYNONYM METSTUPROG FOR SYSADM.METSTUPROG;
CREATE PUBLIC SYNONYM METSTUPROG_WEB FOR SYSADM.METSTUPROG_WEB;
CREATE PUBLIC SYNONYM METSYGR FOR SYSADM.METSYGR;
CREATE PUBLIC SYNONYM METSYGRAMA FOR SYSADM.METSYGRAMA;
CREATE PUBLIC SYNONYM METTEACH FOR SYSADM.METTEACH;
CREATE PUBLIC SYNONYM METTMIMA FOR SYSADM.METTMIMA;
CREATE PUBLIC SYNONYM METTOMEIS FOR SYSADM.METTOMEIS;
CREATE PUBLIC SYNONYM METUNIV FOR SYSADM.METUNIV;
CREATE PUBLIC SYNONYM METXRHMA FOR SYSADM.METXRHMA;
CREATE PUBLIC SYNONYM MET_KART_DISK FOR SYSADM.MET_KART_DISK;
CREATE PUBLIC SYNONYM DEP FOR SYSADM.DEP ;
CREATE PUBLIC SYNONYM PLTAB FOR SYSADM.PLTAB;
CREATE PUBLIC SYNONYM TABLESN FOR SYSADM.TABLESN;
CREATE PUBLIC SYNONYM TMHMA FOR SYSADM.TMHMA;
CREATE PUBLIC SYNONYM TREXON FOR SYSADM.TREXON;
CREATE PUBLIC SYNONYM UNIVERSITY FOR SYSADM.UNIVERSITY;
CREATE PUBLIC SYNONYM USERTAB FOR SYSADM.USERTAB;
CREATE PUBLIC SYNONYM WEB_FILE_MET FOR SYSADM.WEB_FILE_MET;
CREATE PUBLIC SYNONYM YPAL FOR SYSADM.YPAL;
CREATE PUBLIC SYNONYM METWEBAITPISTOP FOR SYSADM.METWEBAITPISTOP;
CREATE PUBLIC SYNONYM METWEBKINDPISTOP FOR SYSADM.METWEBKINDPISTOP ;



============================================================================;
================    CREATE TABLES ISTORIKOY   ================================;
============================================================================;


--------------------------------------------------------------------------------------------------------------------------------------------------------;
1. MET;
--------------------------------------------------------------------------------------------------------------------------------------------------------;
ALTER TABLE MET ADD USRNAME VARCHAR(250);
ALTER TABLE MET_WEB ADD USRNAME VARCHAR(250);

CREATE TABLE MET_IST (
		USERNAME VARCHAR (10), DATEMODIF TIMESTAMP, MODIFTYPE VARCHAR (1),  MITROO VARCHAR(8) NOT NULL, TMIMACODE INTEGER, AR_T VARCHAR(10),
		EPVN VARCHAR(40), ONOMA VARCHAR(30), PATR VARCHAR(30), MHTR VARCHAR(30), SEX VARCHAR(1), YPHK VARCHAR(4), XU VARCHAR(1), COORIG VARCHAR(6),
		NOMOSORIG VARCHAR(6),  POLIORIG VARCHAR(6), BIRTHDATE DATE, NOMOSMHTR VARCHAR(6), POLIMHTR VARCHAR(6), DIMOSKINOT INTEGER, DIMOTOLOGIO
		VARCHAR(30), COKAT VARCHAR(6), NOMOSKAT VARCHAR(6), POLIKAT VARCHAR(6), PERIOXI VARCHAR(30), ODOS VARCHAR(38), TT VARCHAR(5), TEL1 VARCHAR(23),
		TEL2 VARCHAR(15), EMAIL VARCHAR(40), USRNAME VARCHAR(250),WORK VARCHAR(1), COMMENT VARCHAR(250), MHXANIK VARCHAR(1), MET_SEQNO INTEGER);


--------------------------------------------------------------------------------------------------------------------------------------------------------;
2. METSTUPROG;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

CREATE TABLE METSTUPROG_IST (
		USERNAME VARCHAR (10), DATEMODIF TIMESTAMP, MODIFTYPE VARCHAR (1),  PROGCODE INTEGER NOT NULL, MITROO VARCHAR(8) NOT NULL, DEPCODE INTEGER,
		TOMCODE INTEGER, KAT VARCHAR(2), AK INTEGER, H_EGR DATE, EJ VARCHAR(2), PRAXH VARCHAR(10), TOTBAU REAL, ARDIPL VARCHAR(10), H_AIT DATE,
		EKP_DIPL CHAR(1), DATEANAG DATE, PM VARCHAR(1), DATEANAGEST DATE, DATETELANAGEST DATE, METSTUPROG_SEQNO INTEGER);


--------------------------------------------------------------------------------------------------------------------------------------------------------;
3. METKARTL;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

CREATE TABLE METKARTL_IST (
		USERNAME VARCHAR (10), DATEMODIF TIMESTAMP, MODIFTYPE VARCHAR (1),  TMIMACODE INTEGER NOT NULL, PROGCODE INTEGER NOT NULL, 
		PERIOD VARCHAR(2) NOT NULL, AK INTEGER NOT NULL, COURCODE INTEGER NOT NULL, MITROO VARCHAR(8) NOT NULL, TYPOS VARCHAR(2),
		PERIODANIKI VARCHAR(2), GRADENOR FLOAT, GRADEPAN FLOAT, APALAG CHAR(1), EPEPIL VARCHAR(1), METKARTL_SEQNO INTEGER);


--------------------------------------------------------------------------------------------------------------------------------------------------------;
4. METDIPLGRADE;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

CREATE TABLE METDIPLGRADE_IST (
		USERNAME VARCHAR (10), DATEMODIF TIMESTAMP, MODIFTYPE VARCHAR (1), CODESYN REAL NOT NULL, DEPCODE INTEGER NOT NULL, DATEINS DATE NOT NULL,
		TYPEDEP VARCHAR(1) NOT NULL, GRADE REAL, GRADETEXT VARCHAR(15), DATEDEL DATE);
		

============================================================================;
=============    PUBLIC SYNONYMS FOR IST TABLES    ===========================;
============================================================================;

CREATE PUBLIC SYNONYM MET_IST FOR SYSADM.MET_IST;
CREATE PUBLIC SYNONYM METSTUPROG_IST FOR SYSADM.METSTUPROG_IST;
CREATE PUBLIC SYNONYM METKARTL_IST FOR SYSADM.METKARTL_IST;
CREATE PUBLIC SYNONYM METDIPLGRADE_IST FOR SYSADM.METDIPLGRADE_IST ;


============================================================================;
===========    CREATE INDEXES FOR TBLS ISTORIKOY   ===========================;
============================================================================;


--------------------------------------------------------------------------------------------------------------------------------------------------------;
1. MET_IST;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

CREATE INDEX MET_IST ON MET_IST(MITROO);
CREATE INDEX MET_IST_USD ON MET_IST(USERNAME, DATEMODIF, MODIFTYPE);


--------------------------------------------------------------------------------------------------------------------------------------------------------;
2. METSTUPROG_IST;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

CREATE INDEX METSTUPROG_IST ON METSTUPROG_IST(MITROO, PROGCODE);
CREATE INDEX METSTUPROG_IST_USD ON METSTUPROG_IST(USERNAME, DATEMODIF, MODIFTYPE);


--------------------------------------------------------------------------------------------------------------------------------------------------------;
3. METKARTL_IST;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

CREATE INDEX METKARTL_IST ON METKARTL_IST(MITROO, COURCODE, AK, PERIOD, PROGCODE, TMIMACODE);
CREATE INDEX METKATRL_IST_USD ON METKARTL_IST(USERNAME, DATEMODIF, MODIFTYPE);


--------------------------------------------------------------------------------------------------------------------------------------------------------;
4. METDIPLGRADE_IST;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

CREATE INDEX METDIPLGRADE_IST ON METDIPLGRADE_IST(CODESYN, DEPCODE, DATEINS);
CREATE INDEX METDIPLGRD_IST_USD ON METDIPLGRADE_IST(USERNAME, DATEMODIF, MODIFTYPE);


============================================================================;
======================  GRANT TABLE PRIVILEGES    ===========================;
============================================================================;

GRANT SELECT,INSERT,DELETE,UPDATE ON MET,METANATHESI,METCOURSE,METDEPMA,METDIAKOP,METDIPLGRADE,METDSYNERG,METEGR,METEPIBLMA,METKARTL,METKATEF,METKRISI,METKRISIDEP,METLANG, 
					METPROCORP,METPROGAT,METPROGRAM,METPROOD,METPROSPU,METPTYX,METSTUPROG,METSYGR,METSYGRAMA,METTEACH,METTMIMA,METTOMEIS,METUNIV,
					METWEBAITPISTOP,METWEBKINDPISTOP,METXRHMA,MET_KART_DISK,WEB_FILE_MET,DEP,PLTAB,TABLESN,TMHMA,TREXON,USERTAB,YPAL,METWEBAITPISTOP,METWEBKINDPISTOP,
					MET_IST,METDIPLGRADE_IST,METKARTL_IST,METSTUPROG_IST,MET_WEB,METKARTL_WEB,METSTUPROG_WEB TO ;


============================================================================;
======================  REVOKE TABLE PRIVILEGES    ===========================;
============================================================================;

REVOKE INSERT,DELETE,UPDATE ON MET_IST,METDIPLGRADE_IST,METKARTL_IST,METSTUPROG_IST,MET_WEB,METKARTL_WEB,METSTUPROG_WEB FROM ;


============================================================================;
==  ARXIKA INSERTS TVN  DEDOMENVN STOYS PINAKES TVN ISTORIKVN STOIXEIVN ==;
============================================================================;


--------------------------------------------------------------------------------------------------------------------------------------------------------;
1. MET_IST;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

INSERT INTO MET_IST(
		USERNAME, DATEMODIF, MODIFTYPE,  MITROO, TMIMACODE, AR_T, EPVN, ONOMA, PATR, MHTR, SEX, YPHK, XU, COORIG, NOMOSORIG,  POLIORIG, BIRTHDATE, 
		NOMOSMHTR, POLIMHTR, DIMOSKINOT, DIMOTOLOGIO, COKAT, NOMOSKAT, POLIKAT, PERIOXI, ODOS, TT, TEL1, TEL2, EMAIL, USRNAME, WORK, COMMENT, MHXANIK, MET_SEQNO)
SELECT
		USER, SYSDATETIME, 'i', MITROO, TMIMACODE, AR_T, EPVN, ONOMA, PATR, MHTR, SEX, YPHK, XU, COORIG, NOMOSORIG,  POLIORIG, BIRTHDATE, 
		NOMOSMHTR, POLIMHTR, DIMOSKINOT, DIMOTOLOGIO, COKAT, NOMOSKAT, POLIKAT, PERIOXI, ODOS, TT, TEL1, TEL2, EMAIL, USRNAME, WORK, COMMENT, MHXANIK, MET_SEQNO
FROM MET;


--------------------------------------------------------------------------------------------------------------------------------------------------------;
2. METSTUPROG_IST;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

INSERT INTO METSTUPROG_IST(
		USERNAME, DATEMODIF, MODIFTYPE, PROGCODE, MITROO, DEPCODE, TOMCODE, KAT, AK, H_EGR, EJ, PRAXH, TOTBAU, ARDIPL, H_AIT,
		EKP_DIPL, DATEANAG, PM, DATEANAGEST, DATETELANAGEST, METSTUPROG_SEQNO)
SELECT
		USER, SYSDATETIME, 'i', PROGCODE, MITROO, DEPCODE, TOMCODE, KAT, AK, H_EGR, EJ, PRAXH, TOTBAU, ARDIPL, H_AIT,
		EKP_DIPL, DATEANAG, PM, DATEANAGEST, DATETELANAGEST, METSTUPROG_SEQNO
FROM METSTUPROG;



--------------------------------------------------------------------------------------------------------------------------------------------------------;
3. METKARTL_IST;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

INSERT INTO METKARTL_IST(
		USERNAME, DATEMODIF, MODIFTYPE, TMIMACODE, PROGCODE, PERIOD, AK, COURCODE, MITROO, TYPOS, PERIODANIKI, GRADENOR, GRADEPAN, 
		APALAG, EPEPIL, METKARTL_SEQNO)
SELECT
		USER, SYSDATETIME, 'i', TMIMACODE, PROGCODE, PERIOD, AK, COURCODE, MITROO, TYPOS, PERIODANIKI, GRADENOR, GRADEPAN, 
		APALAG, EPEPIL, METKARTL_SEQNO
FROM METKARTL;


--------------------------------------------------------------------------------------------------------------------------------------------------------;
4. METDIPLGRADE_IST;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

INSERT INTO METDIPLGRADE_IST(
		USERNAME, DATEMODIF, MODIFTYPE, CODESYN, DEPCODE, DATEINS, TYPEDEP, GRADE, GRADETEXT, DATEDEL)
SELECT
		USER, SYSDATETIME, 'i', CODESYN, DEPCODE, DATEINS, TYPEDEP, GRADE, GRADETEXT, DATEDEL
FROM METDIPLGRADE;



============================================================================;
================     PROCEDURES FOR ISTORIKO AND WEB     ====================;
============================================================================;

--------------------------------------------------------------------------------------------------------------------------------------------------------;
1. MET;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

STORE  MET_PROC
PROCEDURE: MET_PROC STATIC
 	PARAMETERS
   		String   	 	: sMODIFTYPE
   		String    		: sMITROO
   		Number 		: nTMIMACODE
   		String    		: sAR_T
   		String    		: sEPVN
   		String    		: sONOMA
   		String    		: sPATR
   		String    		: sMHTR
   		String    		: sSEX
   		String    		: sYPHK
   		String    		: sXU
   		String    		: sCOORIG
   		String    		: sNOMOSORIG
  		String    		: sPOLIORIG
   		Date/Time 	: dBIRTHDATE
   		String    		: sNOMOSMHTR
   		String    		: sPOLIMHTR
   		Number		: nDIMOSKINOT
   		String	    	: sDIMOTOLOGIO
   		String 	   	: sCOKAT
   		String  	  	: sNOMOSKAT
   		String   	 	: sPOLIKAT
  		String   	 	: sPERIOXI
   		String   	 	: sODOS
   		String   	 	: sTT
   		String   	 	: sTEL1
   		String   	 	: sTEL2
   		String   	 	: sEMAIL
		String   	 	: sUSRNAME
   		String   	 	: sWORK
   		String   	 	: sCOMMENT
   		String   	 	: sMHXANIK
   		Number 		: nMET_SEQNO 
 	LOCAL VARIABLES
   		SQL HANDLE: hSql1
   		SQL HANDLE: hSql2
 	ACTIONS
   		On Procedure Startup
    			Call SqlConnect( hSql1 )
    			Call SqlConnect( hSql2 )
   		On Procedure Execute
			Call SqlPrepare( hSql1 , 'INSERT INTO MET_WEB(
										DATEMODIF, MODIFTYPE, MITROO, TMIMACODE, AR_T, EPVN, ONOMA, PATR, MHTR, SEX, YPHK, COORIG, NOMOSORIG, 
										POLIORIG, BIRTHDATE, NOMOSMHTR, POLIMHTR, DIMOTOLOGIO, COKAT, NOMOSKAT, POLIKAT, PERIOXI, ODOS, TT, TEL1, 
										TEL2, EMAIL, USRNAME, MET_SEQNO)
     							       VALUES(
										SYSDATETIME, :sMODIFTYPE, :sMITROO, :nTMIMACODE, :sAR_T, :sEPVN, :sONOMA, :sPATR, :sMHTR, :sSEX, :sYPHK, :sCOORIG, :sNOMOSORIG,
										:sPOLIORIG, :dBIRTHDATE, :sNOMOSMHTR, :sPOLIMHTR, :sDIMOTOLOGIO, :sCOKAT, :sNOMOSKAT, :sPOLIKAT, :sPERIOXI, :sODOS, :sTT, :sTEL1,
										:sTEL2, :sEMAIL, :sUSRNAME, :nMET_SEQNO )' )
    			Call SqlExecute( hSql1 )
    			Call SqlPrepare( hSql2 , 'INSERT INTO MET_IST(
										USERNAME, DATEMODIF, MODIFTYPE, MITROO, TMIMACODE, AR_T, EPVN, ONOMA, PATR, MHTR, SEX, YPHK, XU, COORIG, NOMOSORIG, 
										 POLIORIG, BIRTHDATE, NOMOSMHTR, POLIMHTR, DIMOSKINOT, DIMOTOLOGIO, COKAT, NOMOSKAT, POLIKAT, PERIOXI, ODOS, TT, TEL1, 
										TEL2, EMAIL, USRNAME,WORK, COMMENT, MHXANIK, MET_SEQNO)
     							       VALUES(
										USER, SYSDATETIME, :sMODIFTYPE, :sMITROO, :nTMIMACODE, :sAR_T, :sEPVN, :sONOMA, :sPATR, :sMHTR, :sSEX, :sYPHK, :sXU, :sCOORIG, :sNOMOSORIG,
										:sPOLIORIG, :dBIRTHDATE, :sNOMOSMHTR, :sPOLIMHTR, :nDIMOSKINOT, :sDIMOTOLOGIO, :sCOKAT, :sNOMOSKAT, :sPOLIKAT, :sPERIOXI, :sODOS, :sTT, :sTEL1,
										:sTEL2, :sEMAIL, :sUSRNAME, :sWORK, :sCOMMENT, :sMHXANIK, :nMET_SEQNO )' )
    			Call SqlExecute( hSql2 )
   		On Procedure Close
    			Call SqlDisconnect( hSql1 )
    			Call SqlDisconnect( hSql2 );


--------------------------------------------------------------------------------------------------------------------------------------------------------;
2. METSTUPROG;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

STORE  METSTUPROG_PROC
PROCEDURE: METSTUPROG_PROC STATIC
 	PARAMETERS
   		String   	 	: sMODIFTYPE
   		Number 		: nPROGCODE
   		String    		: sMITROO
   		Number		: nDEPCODE
   		Number		: nTOMCODE
   		String    		: sKAT
   		Number		: nAK
    		Date/Time 	: dH_EGR
   		String    		: sEJ
   		String    		: sPRAXH
   		Number		: nTOTBAU
 		String    		: sARDIPL
    		Date/Time 	: dH_AIT
 		String    		: sEKP_DIPL
    		Date/Time 	: dDATEANAG
 		String    		: sPM
    		Date/Time 	: dDATEANAGEST
    		Date/Time 	: dDATETELANAGEST
   		Number 		: nMETSTUPROG_SEGNO
 	LOCAL VARIABLES
   		SQL HANDLE: hSql1
   		SQL HANDLE: hSql2
 	ACTIONS
   		On Procedure Startup
    			Call SqlConnect( hSql1 )
    			Call SqlConnect( hSql2 )
   		On Procedure Execute
			Call SqlPrepare( hSql1 , 'INSERT INTO METSTUPROG_WEB(
										DATEMODIF, MODIFTYPE, PROGCODE, MITROO, TOTBAU, DATEANAG, METSTUPROG_SEQNO)
     							       VALUES(
										SYSDATETIME, :sMODIFTYPE, :nPROGCODE, :sMITROO, :nTOTBAU, :dDATEANAG, :nMETSTUPROG_SEGNO)' )
    			Call SqlExecute( hSql1 )
    			Call SqlPrepare( hSql2 , 'INSERT INTO METSTUPROG_IST(
										USERNAME, DATEMODIF, MODIFTYPE, PROGCODE, MITROO, DEPCODE, TOMCODE, KAT, AK, H_EGR, EJ, PRAXH, TOTBAU, ARDIPL, H_AIT,
										EKP_DIPL, DATEANAG, PM, DATEANAGEST, DATETELANAGEST, METSTUPROG_SEQNO )
     							       VALUES(
										USER, SYSDATETIME, :sMODIFTYPE, :nPROGCODE, :sMITROO, :nDEPCODE, :nTOMCODE, :sKAT, :nAK, :dH_EGR, :sEJ, :sPRAXH, :nTOTBAU, :sARDIPL, :dH_AIT,
										:sEKP_DIPL, :dDATEANAG, :sPM, :dDATEANAGEST, :dDATETELANAGEST, :nMETSTUPROG_SEGNO)' )
    			Call SqlExecute( hSql2 )
   		On Procedure Close
    			Call SqlDisconnect( hSql1 )
    			Call SqlDisconnect( hSql2 );



--------------------------------------------------------------------------------------------------------------------------------------------------------;
3. METKARTL;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

ALTER TABLE METKARTL_WEB ADD EPEPIL VARCHAR(1);

STORE  METKARTL_PROC
PROCEDURE: METKARTL_PROC STATIC
 	PARAMETERS
   		String   	 	: sMODIFTYPE
   		Number 		: nTMIMACODE
   		Number 		: nPROGCODE
   		String    		: sPERIOD
   		Number		: nAK
   		Number		: nCOURCODE
   		String    		: sMITROO
   		String    		: sTYPOS
   		String    		: sPERIODANIKI
   		Number		: nGRADENOR
   		Number		: nGRADEPAN
   		String    		: sAPALAG
   		String    		: sEPEPIL
   		Number		: nMETKARTL_SEQNO
 	LOCAL VARIABLES
   		SQL HANDLE: hSql1
   		SQL HANDLE: hSql2
 	ACTIONS
   		On Procedure Startup
    			Call SqlConnect( hSql1 )
    			Call SqlConnect( hSql2 )
   		On Procedure Execute
			Call SqlPrepare( hSql1 , 'INSERT INTO METKARTL_WEB(
										DATEMODIF, MODIFTYPE, TMIMACODE, PROGCODE, PERIOD, AK, COURCODE, MITROO, TYPOS, PERIODANIKI, GRADENOR, GRADEPAN,
										APALAG, EPEPIL, METKARTL_SEQNO)
     							       VALUES(
										SYSDATETIME, :sMODIFTYPE, :nTMIMACODE, :nPROGCODE, :sPERIOD, :nAK, :nCOURCODE, :sMITROO, :sTYPOS, :sPERIODANIKI, :nGRADENOR, :nGRADEPAN,
										:sAPALAG, :sEPEPIL, :nMETKARTL_SEQNO)' )
    			Call SqlExecute( hSql1 )
    			Call SqlPrepare( hSql2 , 'INSERT INTO METKARTL_IST(
										USERNAME, DATEMODIF, MODIFTYPE, TMIMACODE, PROGCODE, PERIOD, AK, COURCODE, MITROO, TYPOS, PERIODANIKI, GRADENOR, GRADEPAN,
										APALAG, EPEPIL, METKARTL_SEQNO)
     							       VALUES(
										USER, SYSDATETIME, :sMODIFTYPE, :nTMIMACODE, :nPROGCODE, :sPERIOD, :nAK, :nCOURCODE, :sMITROO, :sTYPOS, :sPERIODANIKI, :nGRADENOR, :nGRADEPAN,
										:sAPALAG, :sEPEPIL, :nMETKARTL_SEQNO)' )
    			Call SqlExecute( hSql2 )
   		On Procedure Close
    			Call SqlDisconnect( hSql1 )
    			Call SqlDisconnect( hSql2 );


--------------------------------------------------------------------------------------------------------------------------------------------------------;
4. METDIPLGRADE;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

STORE  METDIPLGRADE_PROC
PROCEDURE: METDIPLGRADE_PROC STATIC
 	PARAMETERS
   		String   	 	: sMODIFTYPE
   		Number 		: nCODESYN
   		Number 		: nDEPCODE
		Date/Time 	: dDATEINS
		String    		: sTYPEDEP
   		Number		: nGRADE
   		String    		: sGRADETEXT
		Date/Time 	: dDATEDEL
 	LOCAL VARIABLES
   		SQL HANDLE: hSql
 	ACTIONS
   		On Procedure Startup
    			Call SqlConnect( hSql )
   		On Procedure Execute
    			Call SqlPrepare( hSql, 'INSERT INTO METDIPLGRADE_IST(
										USERNAME, DATEMODIF, MODIFTYPE, CODESYN, DEPCODE, DATEINS, TYPEDEP, GRADE, GRADETEXT, DATEDEL)
     							       VALUES(
										USER, SYSDATETIME, :sMODIFTYPE, :nCODESYN, :nDEPCODE, :dDATEINS, :sTYPEDEP, :nGRADE, :sGRADETEXT, :dDATEDEL)' )
    			Call SqlExecute( hSql )
   		On Procedure Close
    			Call SqlDisconnect( hSql );



============================================================================;
==============     CREATE TRIGGERS FOR ISTORIKO AND WEB     ==================;
============================================================================;


--------------------------------------------------------------------------------------------------------------------------------------------------------;
1. MET;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

DROP TRIGGER MET_INS; 

CREATE TRIGGER SYSADM.MET_INS AFTER INSERT ON MET
	( EXECUTE MET_PROC (
				'i', MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN, MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.XU, MET.COORIG, MET.NOMOSORIG, 
				MET.POLIORIG, MET.BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOSKINOT, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, 
				MET.PERIOXI, MET.ODOS, MET.TT, MET.TEL1, MET.TEL2, MET.EMAIL, MET.USRNAME, MET.WORK, MET.COMMENT, MET.MHXANIK, MET.MET_SEQNO) )
FOR EACH ROW;

DROP TRIGGER MET_DEL;

CREATE TRIGGER SYSADM.MET_DEL AFTER DELETE ON MET
	( EXECUTE MET_PROC (
				'd', MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN, MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.XU, MET.COORIG, MET.NOMOSORIG, 
				MET.POLIORIG, MET.BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOSKINOT, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, 
				MET.PERIOXI, MET.ODOS, MET.TT, MET.TEL1, MET.TEL2, MET.EMAIL, MET.USRNAME, MET.WORK, MET.COMMENT, MET.MHXANIK, MET.MET_SEQNO) )
FOR EACH ROW;

DROP TRIGGER MET_UPDT;

CREATE TRIGGER SYSADM.MET_UPDT AFTER UPDATE ON MET REFERENCING OLD AS OLD_MET NEW AS NEW_MET
  	( EXECUTE MET_PROC (
				'u', MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN, MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.XU, MET.COORIG, MET.NOMOSORIG, 
				MET.POLIORIG, MET.BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOSKINOT, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, 
				MET.PERIOXI, MET.ODOS, MET.TT, MET.TEL1, MET.TEL2, MET.EMAIL, MET.USRNAME, MET.WORK, MET.COMMENT, MET.MHXANIK, MET.MET_SEQNO) )
FOR EACH ROW;



--------------------------------------------------------------------------------------------------------------------------------------------------------;
2. METSTUPROG;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

DROP TRIGGER METSTUPROG_INS; 

CREATE TRIGGER SYSADM.METSTUPROG_INS AFTER INSERT ON METSTUPROG
	( EXECUTE METSTUPROG_PROC (
				'i', METSTUPROG.PROGCODE, METSTUPROG.MITROO, METSTUPROG.DEPCODE, METSTUPROG.TOMCODE, METSTUPROG.KAT, METSTUPROG.AK, 
				METSTUPROG.H_EGR, METSTUPROG.EJ, METSTUPROG.PRAXH, METSTUPROG.TOTBAU, METSTUPROG.ARDIPL, METSTUPROG.H_AIT,
				METSTUPROG.EKP_DIPL, METSTUPROG.DATEANAG, METSTUPROG.PM, METSTUPROG.DATEANAGEST, METSTUPROG.DATETELANAGEST, 
				METSTUPROG.METSTUPROG_SEQNO) )
FOR EACH ROW;

DROP TRIGGER METSTUPROG_DEL;

CREATE TRIGGER SYSADM.METSTUPROG_DEL AFTER DELETE ON METSTUPROG
	( EXECUTE METSTUPROG_PROC (
				'd', METSTUPROG.PROGCODE, METSTUPROG.MITROO, METSTUPROG.DEPCODE, METSTUPROG.TOMCODE, METSTUPROG.KAT, METSTUPROG.AK, 
				METSTUPROG.H_EGR, METSTUPROG.EJ, METSTUPROG.PRAXH, METSTUPROG.TOTBAU, METSTUPROG.ARDIPL, METSTUPROG.H_AIT,
				METSTUPROG.EKP_DIPL, METSTUPROG.DATEANAG, METSTUPROG.PM, METSTUPROG.DATEANAGEST, METSTUPROG.DATETELANAGEST, 
				METSTUPROG.METSTUPROG_SEQNO) )
FOR EACH ROW;

DROP TRIGGER METSTUPROG_UPDT;

CREATE TRIGGER SYSADM.METSTUPROG_UPDT AFTER UPDATE ON METSTUPROG REFERENCING OLD AS OLD_METSTUPROG NEW AS NEW_METSTUPROG
  	( EXECUTE METSTUPROG_PROC (
				'u', METSTUPROG.PROGCODE, METSTUPROG.MITROO, METSTUPROG.DEPCODE, METSTUPROG.TOMCODE, METSTUPROG.KAT, METSTUPROG.AK, 
				METSTUPROG.H_EGR, METSTUPROG.EJ, METSTUPROG.PRAXH, METSTUPROG.TOTBAU, METSTUPROG.ARDIPL, METSTUPROG.H_AIT,
				METSTUPROG.EKP_DIPL, METSTUPROG.DATEANAG, METSTUPROG.PM, METSTUPROG.DATEANAGEST, METSTUPROG.DATETELANAGEST, 
				METSTUPROG.METSTUPROG_SEQNO) )
FOR EACH ROW;


--------------------------------------------------------------------------------------------------------------------------------------------------------;
3. METKARTL;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

DROP TRIGGER METKARTL_INS; 

CREATE TRIGGER SYSADM.METKATRL_INS AFTER INSERT ON METKARTL
	( EXECUTE METKARTL_PROC (
				'i', METKARTL.TMIMACODE, METKARTL.PROGCODE, METKARTL.PERIOD, METKARTL.AK, METKARTL.COURCODE, METKARTL.MITROO, METKARTL.TYPOS, 
				METKARTL.PERIODANIKI, METKARTL.GRADENOR, METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.EPEPIL, METKARTL.METKARTL_SEQNO) )
FOR EACH ROW;

DROP TRIGGER METKARTL_DEL;

CREATE TRIGGER SYSADM.METKARTL_DEL AFTER DELETE ON METKARTL
	( EXECUTE METKARTL_PROC (
				'd', METKARTL.TMIMACODE, METKARTL.PROGCODE, METKARTL.PERIOD, METKARTL.AK, METKARTL.COURCODE, METKARTL.MITROO, METKARTL.TYPOS, 
				METKARTL.PERIODANIKI, METKARTL.GRADENOR, METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.EPEPIL, METKARTL.METKARTL_SEQNO) )
FOR EACH ROW;

DROP TRIGGER METKARTL_UPDT;

CREATE TRIGGER SYSADM.METKARTL_UPDT AFTER UPDATE ON METKARTL REFERENCING OLD AS OLD_METKARTL NEW AS NEW_METKARTL
  	( EXECUTE METKARTL_PROC (
				'u', METKARTL.TMIMACODE, METKARTL.PROGCODE, METKARTL.PERIOD, METKARTL.AK, METKARTL.COURCODE, METKARTL.MITROO, METKARTL.TYPOS, 
				METKARTL.PERIODANIKI, METKARTL.GRADENOR, METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.EPEPIL, METKARTL.METKARTL_SEQNO) )
FOR EACH ROW;


--------------------------------------------------------------------------------------------------------------------------------------------------------;
4. METDIPLGRADE;
--------------------------------------------------------------------------------------------------------------------------------------------------------;

CREATE TRIGGER SYSADM.METDIPLGRADE_INS AFTER INSERT ON METDIPLGRADE
	( EXECUTE METDIPLGRADE_PROC (
				'i', METDIPLGRADE.CODESYN, METDIPLGRADE.DEPCODE, METDIPLGRADE.DATEINS, METDIPLGRADE.TYPEDEP, METDIPLGRADE.GRADE, METDIPLGRADE.GRADETEXT, 
				METDIPLGRADE.DATEDEL) )
FOR EACH ROW;

CREATE TRIGGER SYSADM.METDIPLGRADE_DEL AFTER DELETE ON METDIPLGRADE
	( EXECUTE METDIPLGRADE_PROC (
				'd', METDIPLGRADE.CODESYN, METDIPLGRADE.DEPCODE, METDIPLGRADE.DATEINS, METDIPLGRADE.TYPEDEP, METDIPLGRADE.GRADE, METDIPLGRADE.GRADETEXT, 
				METDIPLGRADE.DATEDEL) )
FOR EACH ROW;

CREATE TRIGGER SYSADM.METDIPLGRADE_UPDT AFTER UPDATE ON METDIPLGRADE REFERENCING OLD AS OLD_METDIPLGRADE NEW AS NEW_METDIPLGRADE
  	( EXECUTE METDIPLGRADE_PROC (
				'u', METDIPLGRADE.CODESYN, METDIPLGRADE.DEPCODE, METDIPLGRADE.DATEINS, METDIPLGRADE.TYPEDEP, METDIPLGRADE.GRADE, METDIPLGRADE.GRADETEXT, 
				METDIPLGRADE.DATEDEL) )
FOR EACH ROW;
