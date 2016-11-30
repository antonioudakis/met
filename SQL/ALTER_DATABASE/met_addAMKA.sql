;=========================================================================;
;1. Drop triggers from table MET before process 2;
;=========================================================================;

DROP TRIGGER MET_DEL;
DROP TRIGGER MET_INS;
DROP TRIGGER MET_UPDT;
DROP TRIGGER MET_INS_SN;



;=========================================================================;
;2.  Change the size of AR_T on table MET;
;=========================================================================;

ALTER TABLE MET ADD AMKA VARCHAR(11);



;=========================================================================;
;3.  Change the size of AR_T on table MET_IST;
;=========================================================================;

ALTER TABLE MET_IST ADD AMKA VARCHAR(11);
ALTER TABLE MET_IST DROP COMMENT;



;=========================================================================;
;4.  Change the size of AR_T on table MET_WEB;
;=========================================================================;

ALTER TABLE MET_WEB ADD AMKA VARCHAR(11);



;=========================================================================;
;5. Create trigger MET_INS_SN which takes the next available serial number from table TABLESN to use on MET;
;=========================================================================;

CREATE TRIGGER SYSADM.MET_INS_SN BEFORE INSERT ON MET
		 ( EXECUTE INLINE ( MET.MITROO,MET.TMIMACODE , MET.AR_T , MET.EPVN , MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX , MET.YPHK, MET.XU,
		MET.COORIG, MET.NOMOSORIG, MET.POLIORIG,  MET.BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOSKINOT, MET.DIMOTOLOGIO, 
		MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, MET.PERIOXI, MET.ODOS, MET.TT, MET.TEL1, MET.TEL2, MET.EMAIL, MET.WORK, MET.COMMENT, 
		MET.MHXANIK,MET.USRNAME, MET.OFEILES,MET.PARAVOLO,MET.MET_SEQNO)
	PROCEDURE: MET_INS_SEQNO STATIC
		PARAMETERS
			String: sMitroo
			Number : nK_TM
			String : sAr_t
	      		String :sEpvn
	      		String :sOnoma
	      		String :sPatr
			String :sMhtr
	      		String :sSex
	      		String :sYphk
	      		String :sXU
	      		String :sCoorig
	      		String :sNomosorig
	      		String :sPoliorig	
			Date/Time:dBirthDate		
	      		String :sNomosmhtr
	      		String :sPolimhtr
	      		Number :nDimoskinot
	      		String :sDimotologio
	      		String :sCokat
	      		String :sNomoskat
	      		String :sPolikat
	      		String :sPerioxi
	      		String :sOdos
	      		String :sTT
	      		String :sTel1
	      		String :sTel2
	      		String :sEmail
	      		String :sWork
	      		String :sComment
	      		String :sMhxanik
			String :sUsrName
			String :sOfeiles
			String :sParavolo
			Receive Number : nSEQNO
		LOCAL VARIABLES
			SQL HANDLE: hSqlCur
			SQL HANDLE: hSqlCur2
			Number : nNext
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCur )
				Call SqlConnect( hSqlCur2 )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur, 'SELECT NEXTSN FROM TABLESN WHERE TABLENAME = \'MET\' INTO :nSEQNO' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur2, 'UPDATE TABLESN SET NEXTSN = :nSEQNO + 1  WHERE TABLENAME = \'MET\' ' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;



;=========================================================================;
;6. Erase procedure  MET_PROC;
;=========================================================================;

ERASE MET_PROC;


;=========================================================================;
;7. Store procedure MET_PROC;
;=========================================================================;

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
   		String   	 	: sWORK
   		String   	 	: sMHXANIK
   		String   	 	: sAMKA
		String   	 	: sUSRNAME
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
										TEL2, EMAIL, AMKA,  USRNAME, MET_SEQNO)
     							      	       VALUES(
										SYSDATETIME, :sMODIFTYPE, :sMITROO, :nTMIMACODE, :sAR_T, :sEPVN, :sONOMA, :sPATR, :sMHTR, :sSEX, :sYPHK, :sCOORIG, :sNOMOSORIG,
										:sPOLIORIG, :dBIRTHDATE, :sNOMOSMHTR, :sPOLIMHTR, :sDIMOTOLOGIO, :sCOKAT, :sNOMOSKAT, :sPOLIKAT, :sPERIOXI, :sODOS, :sTT, :sTEL1,
										:sTEL2, :sEMAIL, :sAMKA,  :sUSRNAME, :nMET_SEQNO )' )
    			Call SqlExecute( hSql1 )
    			Call SqlPrepare( hSql2 , 'INSERT INTO MET_IST(
										USERNAME, DATEMODIF, MODIFTYPE, MITROO, TMIMACODE, AR_T, EPVN, ONOMA, PATR, MHTR, SEX, YPHK, XU, COORIG, NOMOSORIG, 
										 POLIORIG, BIRTHDATE, NOMOSMHTR, POLIMHTR, DIMOSKINOT, DIMOTOLOGIO, COKAT, NOMOSKAT, POLIKAT, PERIOXI, ODOS, TT, TEL1, 
										TEL2, EMAIL, WORK, MHXANIK, AMKA, USRNAME, MET_SEQNO)
     							               VALUES(
										USER, SYSDATETIME, :sMODIFTYPE, :sMITROO, :nTMIMACODE, :sAR_T, :sEPVN, :sONOMA, :sPATR, :sMHTR, :sSEX, :sYPHK, :sXU, :sCOORIG, :sNOMOSORIG,
										:sPOLIORIG, :dBIRTHDATE, :sNOMOSMHTR, :sPOLIMHTR, :nDIMOSKINOT, :sDIMOTOLOGIO, :sCOKAT, :sNOMOSKAT, :sPOLIKAT, :sPERIOXI, :sODOS, :sTT, :sTEL1,
										:sTEL2, :sEMAIL, :sWORK, :sMHXANIK, :sAMKA,  :sUSRNAME, :nMET_SEQNO )' )
    			Call SqlExecute( hSql2 )
   		On Procedure Close
    			Call SqlDisconnect( hSql1 )
    			Call SqlDisconnect( hSql2 );


;==============================================================================;
;7. Create triggers which insert data on tables MET_WEB and MET_IST after changing table MET;
;==============================================================================;

CREATE TRIGGER SYSADM.MET_INS AFTER INSERT ON MET
	( EXECUTE MET_PROC (
				'i', MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN, MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.XU, MET.COORIG, MET.NOMOSORIG, 
				MET.POLIORIG, MET.BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOSKINOT, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, 
				MET.PERIOXI, MET.ODOS, MET.TT, MET.TEL1, MET.TEL2, MET.EMAIL, MET.WORK, MET.MHXANIK, MET.AMKA, MET.USRNAME, MET.MET_SEQNO) )
FOR EACH ROW;


CREATE TRIGGER SYSADM.MET_DEL AFTER DELETE ON MET
	( EXECUTE MET_PROC (
				'd', MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN, MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.XU, MET.COORIG, MET.NOMOSORIG, 
				MET.POLIORIG, MET.BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOSKINOT, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, 
				MET.PERIOXI, MET.ODOS, MET.TT, MET.TEL1, MET.TEL2, MET.EMAIL, MET.WORK, MET.MHXANIK, MET.AMKA, MET.USRNAME, MET.MET_SEQNO) )
FOR EACH ROW;


CREATE TRIGGER SYSADM.MET_UPDT AFTER UPDATE ON MET REFERENCING OLD AS OLD_MET NEW AS NEW_MET
  	( EXECUTE MET_PROC (
				'u', MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN, MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.XU, MET.COORIG, MET.NOMOSORIG, 
				MET.POLIORIG, MET.BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOSKINOT, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, 
				MET.PERIOXI, MET.ODOS, MET.TT, MET.TEL1, MET.TEL2, MET.EMAIL,MET.WORK, MET.MHXANIK, MET.AMKA,  MET.USRNAME, MET.MET_SEQNO) )
FOR EACH ROW;


