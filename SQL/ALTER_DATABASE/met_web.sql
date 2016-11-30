0. Ενέργειες που απαιτούνται για την μετάδοση των εγγραφών των πινάκων MET,METKARTL,METSTUPROG στο WEB (1-23);

1. Δημιουργία πίνακα WEB_FILE_MET. Περιέχει τα ονόματα των τελευταίων αρχείων που έχουν σταλεί στο WEB; 

CREATE TABLE WEB_FILE_MET 	(FILENAME1 VARCHAR(50),FILENAME2 VARCHAR(50),FILENAME3 VARCHAR(50));

2. Πριν γίνει η ενέργεια 3 πρέπει να αφαιρέσω τους TRIGGERS από τον πίνακα MET;

DROP TRIGGER MET_DEL;
DROP TRIGGER MET_INS;
DROP TRIGGER MET_UPDT;
DROP TRIGGER MET_INS_SN;

3. Προσθέτω στον πίνακα MET την κολόνα MET_SEQNO η οποία δείχνει τον σειριακό αριθμό της κάθε εγγραφής του πίνακα MET;

ALTER TABLE MET ADD MET_SEQNO INTEGER;

4. Αποθηκεύω και εκτελώ την διαδικασία καταχώρησης σειριακών αριθμών MET_SEQNO στον πίνακα MET;

STORE SEQNO_MET
PROCEDURE: SEQNO_MET
		PARAMETERS
			Receive Number : SEQNO
			Receive String : sMitroo
			Receive Number : nTmimacode
		LOCAL VARIABLES
			SQL HANDLE: hSqlCur
			SQL HANDLE: hSqlCur2
			Number: nFetch
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCur )
				Call SqlConnect( hSqlCur2 )
				Set SEQNO = 0
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur, 'SELECT MITROO,TMIMACODE FROM MET ORDER BY MITROO,TMIMACODE INTO :sMitroo, :nTmimacode' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
			On Procedure Fetch
					If NOT SqlFetchNext( hSqlCur,nFetch )
						Return 1
					Else
						Set  SEQNO =  SEQNO+ 1
						Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE MET SET MET_SEQNO  = :SEQNO  WHERE  MITROO = :sMitroo and TMIMACODE =:nTmimacode' )
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 );

EXECUTE SEQNO_MET
\
,,,
/

5. Διαγράφω τον procedure SEQNO_MET;

ERASE SEQNO_MET;

6. Καταχωρώ στον πίνακα TABLESN τον επόμενο προς καταχώρηση σειριακό αριθμό που αφορά τον πίνακα MET;

INSERT INTO TABLESN VALUES ('ΜΕΤ',);

7. Δημιουργώ τον TRIGGER MET_INS_SN ο οποίος παίρνει τον επόμενο διαθέσιμο σειριακό αριθμό από τον πίνακα TABLESN για τον πίνακα MET;

CREATE TRIGGER SYSADM.MET_INS_SN BEFORE INSERT ON MET
		 ( EXECUTE INLINE ( MET.MITROO,MET.TMIMACODE , MET.AR_T , MET.EPVN , MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX , MET.YPHK, MET.XU,
		MET.COORIG, MET.NOMOSORIG, MET.POLIORIG,  MET.BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOSKINOT, MET.DIMOTOLOGIO, 
		MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, MET.PERIOXI, MET.ODOS, MET.TT, MET.TEL1, MET.TEL2, MET.EMAIL, MET.WORK, MET.COMMENT, 
		MET.MHXANIK,MET.MET_SEQNO)
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

8. Δημιουργώ τον πίνακα MET_WEB ο οποίος θα περιέχει τις εγγραφές εισαγωγής,διαγραφής και τροποποίησης του πίνακα MET;
drop table met_web;
CREATE TABLE MET_WEB		(MODIFTYPE VARCHAR(1),DATEMODIF TIMESTAMP, MITROO VARCHAR (8), TMIMACODE INTEGER , AR_T VARCHAR (10)  , EPVN VARCHAR (40)  , 
							ONOMA VARCHAR (30) , PATR VARCHAR (30)  , MHTR VARCHAR (30)  , SEX VARCHAR (1)  , YPHK VARCHAR (4) , COORIG VARCHAR (6)  , 
							NOMOSORIG VARCHAR (6)  , POLIORIG VARCHAR (6)  , BIRTHDATE DATE , NOMOSMHTR VARCHAR (6)  , POLIMHTR VARCHAR (6)  , 
							DIMOTOLOGIO VARCHAR (30)  , COKAT VARCHAR (6)  , NOMOSKAT VARCHAR (6)  , POLIKAT VARCHAR (6)  , PERIOXI VARCHAR (30)  , 
							ODOS VARCHAR (38)  , TT VARCHAR (5)  , TEL1 VARCHAR (23)  , TEL2 VARCHAR (15)  , EMAIL VARCHAR (40), MET_SEQNO INTEGER) PCTFREE 10;

9. Δημουργώ την procedure MET_WEB_PROC που αφορά την ενημέρωση του πίνακα MET_WEB;

STORE MET_WEB_PROC
  PROCEDURE: MET_WEB_PROC STATIC
  PARAMETERS
      String   : sMITROO
      Number    : nTMIMACODE
      String    : sAR_T
      String    : sEPVN
      String    : sONOMA
      String    : sPATR
      String    : sMHTR
      String    : sSEX
      String    : sYPHK
      String    : sCOORIG
      String    : sNOMOSORIG
      String    : sPOLIORIG
      Date/Time : dBIRTHDATE
      String    : sNOMOSMHTR
      String    : sPOLIMHTR
      String    : sDIMOTOLOGIO
      String    : sCOKAT
      String    : sNOMOSKAT
      String    : sPOLIKAT
      String    : sPERIOXI
      String    : sODOS
      String    : sTT
      String    : sTEL1
      String    : sTEL2
      String    : sEMAIL
      Number : nMET_SEQNO
      String    :sMOD_TYPE
  LOCAL VARIABLES
    SQL HANDLE: hSql
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      Call SqlPrepare( hSql , 'INSERT INTO MET_WEB( MODIFTYPE,DATEMODIF,MITROO,TMIMACODE,AR_T, EPVN,ONOMA,PATR,MHTR,SEX,YPHK,COORIG,NOMOSORIG,POLIORIG,BIRTHDATE,
					   NOMOSMHTR,POLIMHTR,DIMOTOLOGIO,COKAT,NOMOSKAT,POLIKAT,PERIOXI,ODOS,TT,TEL1,TEL2,EMAIL, MET_SEQNO)
       					  VALUES	(:sMOD_TYPE,SYSDATETIME,:sMITROO,:nTMIMACODE,:sAR_T,:sEPVN,:sONOMA,:sPATR,:sMHTR,:sSEX,:sYPHK,:sCOORIG,:sNOMOSORIG,:sPOLIORIG,:dBIRTHDATE,
								:sNOMOSMHTR,:sPOLIMHTR,:sDIMOTOLOGIO,:sCOKAT,:sNOMOSKAT,:sPOLIKAT, :sPERIOXI,:sODOS,:sTT,:sTEL1,:sTEL2,:sEMAIL, :nMET_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql );
  )
FOR EACH ROW;

10. Δημιουργώ τους TRIGGERS εισαγωγής,διαγραφής και τροποποίησης του πίνακα MET μέσω των οποίων θα καταχωρούνται οι εγγραφές στον πίνακα MET_WEB;

CREATE TRIGGER SYSADM.MET_WEB_UPDT  AFTER INSERT ON MET
( EXECUTE  MET_WEB_PROC  ( MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN,MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.COORIG, MET.NOMOSORIG, MET.POLIORIG, 
				MET. BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, MET.PERIOXI, MET.ODOS, MET.TT, 
				MET.TEL1, MET.TEL2, MET.EMAIL, MET.MET_SEQNO,'i')) FOR EACH ROW;
  
CREATE TRIGGER SYSADM.MET_WEB_DEL  AFTER DELETE ON MET
( EXECUTE MET_WEB_PROC  ( MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN,MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.COORIG, MET.NOMOSORIG, MET.POLIORIG, 
				MET. BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, MET.PERIOXI, MET.ODOS, MET.TT, 
				MET.TEL1, MET.TEL2, MET.EMAIL,MET.MET_SEQNO,'d')) FOR EACH ROW;

 CREATE TRIGGER SYSADM.MET_WEB_UPDT  AFTER UPDATE ON MET REFERENCING OLD AS OLD_MET NEW AS NEW_MET
 ( EXECUTE MET_WEB_PROC ( MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN,MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.COORIG, MET.NOMOSORIG, MET.POLIORIG, 
				MET. BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, MET.PERIOXI, MET.ODOS, MET.TT, 
				MET.TEL1, MET.TEL2, MET.EMAIL,MET.MET_SEQNO,'u')) FOR EACH ROW;

11. Πριν γίνει η ενέργεια 12 πρέπει να αφαιρέσω τους TRIGGERS από τον πίνακα METKARTL;

DROP TRIGGER METKARTL_DEL;
DROP TRIGGER METKARTL_INS;
DROP TRIGGER METKARTL_UPDT;
DROP TRIGGER METKARTL_INS_SN;

12. Προσθέτω στον πίνακα METKARTL την κολόνα METKARTL_SEQNO η οποία δείχνει το SEQNO της κάθε εγγραφής του πίνακα METKARTL;

ALTER TABLE METKARTL ADD METKARTL_SEQNO INTEGER;

13. Αποθηκεύω και εκτελώ την διαδικασία καταχώρησης σειριακών αριθμών METKARTL_SEQNO του πίνακα METKARTL;

STORE SEQNO_METKARTL
PROCEDURE: SEQNO_METKARTL
		PARAMETERS
			Receive Number : SEQNO
			Receive String : sMitroo
			Receive Number: nTmimacode
   			Receive Number: nCourcode
			Receive Number: nProgcode
			Receive Number: nAk
			Receive String: sPeriod

		LOCAL VARIABLES
			SQL HANDLE: hSqlCur
			SQL HANDLE: hSqlCur2
			Number: nFetch
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCur )
				Call SqlConnect( hSqlCur2 )
				Set SEQNO = 0
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur, 'SELECT MITROO,TMIMACODE,COURCODE,AK,PERIOD,PROGCODE FROM METKARTL ORDER BY MITROO,TMIMACODE,COURCODE,AK,PERIOD,PROGCODE INTO :sMitroo, :nTmimacode, :nCourcode,:nAk,:sPeriod,:nProgcode' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
			On Procedure Fetch
					If NOT SqlFetchNext( hSqlCur,nFetch )
						Return 1
					Else
						Set  SEQNO =  SEQNO+ 1
						Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE METKARTL  SET METKARTL_SEQNO  = :SEQNO  WHERE PROGCODE=:nProgcode AND TMIMACODE = :nTmimacode AND MITROO = :sMitroo AND (ak = :nAk or ak is null) AND PERIOD = :sPeriod AND COURCODE =:nCourcode' )
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 );

EXECUTE SEQNO_METKARTL
\
,,,,,,,
/

14. Διαγράφω την procedure SEQNO_METKARTL;

ERASE SEQNO_METKARTL;

15. Καταχωρώ στον πίνακα TABLESN τον επόμενο προς καταχώρηση σειριακό αριθμό που αφορά τον πίνακα METKARTL;

INSERT INTO TABLESN VALUES ('METKARTL',);

16. Δημιουργώ τον TRIGGER ο οποίος παίρνει τον επόμενο διαθέσιμο σειριακό αριθμό από τον πίνακα TABLESN και τον καταχωρεί στον πίνακα METKARTL;

CREATE TRIGGER SYSADM.METKARTL_INS_SN BEFORE INSERT ON METKARTL
		   ( EXECUTE INLINE ( METKARTL.TMIMACODE, METKARTL.MITROO, METKARTL.PERIOD, METKARTL.COURCODE, METKARTL.TYPOS,
                     METKARTL.GRADENOR, METKARTL.AK ,METKARTL.GRADEPAN,METKARTL.APALAG,
                     METKARTL.PERIODANIKI, METKARTL.PROGCODE, METKARTL.METKARTL_SEQNO)
	PROCEDURE: MET_KART_INS_SEQNO STATIC
		PARAMETERS
			Number : nK_TM
			String : sK_F
			String : sEJ
			Number : nK_M
			String : sTYPOS
			Number :nGRADENOR			
			Number : nAK
			Number : nGRADEPAN
			String : sAPALAG
			String : sPERIODANIKI
			Number : nPROGCODE			
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
				Call SqlPrepare(hSqlCur, 'SELECT NEXTSN FROM TABLESN WHERE TABLENAME = \'METKARTL\' INTO :nSEQNO' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur2, 'UPDATE TABLESN SET NEXTSN = :nSEQNO + 1  WHERE TABLENAME = \'METKARTL\' ' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;

17. Δημιουργώ τον πίνακα METKARTL_WEB ο οποίος θα περιέχει τις εγγραφές εισαγωγής, διαγραφής και μεταβολής του πίνακα METKARTL;

CREATE TABLE METKARTL_WEB 		( MODIFTYPE VARCHAR(1),DATEMODIF TIMESTAMP, MITROO VARCHAR (8),PROGCODE INTEGER,AK INTEGER, PERIOD VARCHAR(2), COURCODE INTEGER,
								TMIMACODE INTEGER, TYPOS VARCHAR (2)  , GRADENOR FLOAT , GRADEPAN FLOAT , APALAG CHAR (1)  , PERIODANIKI VARCHAR (2), METKARTL_SEQNO INTEGER ) PCTFREE 10;

18. Δημιουργώ την procedure METKARTL_WEB_PROC που αφορά την ενημέρωση του πίνακα METKARTL_WEB;

STORE METKARTL_WEB_PROC
PROCEDURE: METKARTL_WEB_PROC STATIC
  PARAMETERS
      String :sMITROO	
      Number : nPROGCODE
      Number : nAK
      String	 : sPERIOD
      Number : nCOURCODE
      Number : nTMIMACODE
      String : sTYPOS
      Number : nGRADENOR
      Number : nGRADEPAN
      String : sAPALAG
      String : sPERIODANIKI
      Number : nMETKARTL_SEQNO
      String : sMOD_TYPE
  LOCAL VARIABLES
    SQL HANDLE: hSql
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      Call SqlPrepare( hSql , 'INSERT INTO METKARTL_WEB  ( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,AK,PERIOD,COURCODE,TMIMACODE,TYPOS,GRADENOR,GRADEPAN,APALAG,PERIODANIKI,METKARTL_SEQNO) 
					   VALUES(:sMOD_TYPE , SYSDATETIME , :sMITROO , :nPROGCODE , :nAK , :sPERIOD, :nCOURCODE, :nTMIMACODE ,:sTYPOS , :nGRADENOR, :nGRADEPAN , :sAPALAG , :sPERIODANIKI, :nMETKARTL_SEQNO ) ' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql );

19. Δημιουργώ TRIGGERS εισαγωγής, διαγραφής και μεταβολής του πίνακα METKARTL μέσω των οποίων θα καταχωρούνται οι εγγραφές στον πίνακα METKARTL_WEB;

CREATE TRIGGER SYSADM.METKARTL_INS  AFTER INSERT  ON METKARTL
( EXECUTE METKARTL_WEB_PROC ( METKARTL.MITROO, METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE, METKARTL.TMIMACODE,METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL_SEQNO,'i')) FOR EACH ROW;

CREATE TRIGGER SYSADM.METKARTL_DEL  AFTER  DELETE  ON METKARTL
( EXECUTE METKARTL_WEB_PROC ( METKARTL.MITROO,METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE,METKARTL.TMIMACODE,  METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL_SEQNO,'d')) FOR EACH ROW;

CREATE TRIGGER SYSADM.METKARTL_UPDT  AFTER UPDATE  ON METKARTL  REFERENCING OLD AS OLD_METKARTL NEW AS NEW_METKARTL
( EXECUTE METKARTL_WEB_PROC ( METKARTL.MITROO, METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE, METKARTL.TMIMACODE,METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL_SEQNO,'u')) FOR EACH ROW;
 
20. Πριν γίνει η ενέργεια 21 πρέπει να αφαιρέσω τους TRIGGERS από τον πίνακα METSTUPROG;

DROP TRIGGER METSTUPROG_DEL;
DROP TRIGGER METSTUPROG_INS;
DROP TRIGGER METSTUPROG_UPDT;
DROP TRIGGER METSTUPROG_INS_SN;

21. Προσθέτω στον πίνακα METSTUPROG την κολόνα METSTUPROG_SEQNO η οποία δείχνει το SEQNO της κάθε εγγραφής του πίνακα METSTUPROG;

ALTER TABLE METSTUPROG ADD METSTUPROG_SEQNO INTEGER;

22. Αποθηκεύω και εκτελώ την διαδικασία καταχώρησης σειριακών αριθμών METSTUPROG_SEQNO στις εγγραφές του πίνακα METSTUPROG;

STORE SEQNO_METSTUPROG
PROCEDURE: SEQNO_METSTUPROG
		PARAMETERS
			Receive Number : SEQNO
   			Receive Number: nProgcode
			Receive String: sMitroo

		LOCAL VARIABLES
			SQL HANDLE: hSqlCur
			SQL HANDLE: hSqlCur2
			Number: nFetch
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCur )
				Call SqlConnect( hSqlCur2 )
				Set SEQNO = 0
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur, 'SELECT PROGCODE,MITROO FROM METSTUPROG ORDER BY MITROO,PROGCODE INTO :nProgcode, :sMitroo' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
			On Procedure Fetch
					If NOT SqlFetchNext( hSqlCur,nFetch )
						Return 1
					Else
						Set  SEQNO =  SEQNO+ 1
						Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE METSTUPROG  SET METSTUPROG_SEQNO  = :SEQNO  WHERE PROGCODE=:nProgcode AND MITROO = :sMitroo' )
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 );

EXECUTE SEQNO_METSTUPROG
\
,,,
/

23. Διαγράφω την procedure SEQNO_METSTUPROG;

ERASE SEQNO_METSTUPROG;

24. Καταχωρώ στον πίνακα TABLESN τον επόμενο προς καταχώρηση σειριακό αριθμό που αφορά τον πίνακα METSTUPROG;

INSERT INTO TABLESN VALUES ('METSTUPROG',);

25. Δημιουργώ τον TRIGGER ο οποίος παίρνει τον επόμενο διαθέσιμο σειριακό αριθμό από τον πίνακα TABLESN για τον πίνακα METSTUPROG;

CREATE TRIGGER SYSADM.METSTUPROG_INS_SN BEFORE INSERT ON METSTUPROG
		   ( EXECUTE INLINE ( PROGCODE,DEPCODE,TOMCODE,MITROO,KAT,AK,H_EGR,EJ,PRAXH,TOTBAU,ARDIPL,H_AIT,EKP_DIPL,DATEANAG,METSTUPROG_SEQNO)
	PROCEDURE: MET_STUP_INS_SEQNO STATIC
		PARAMETERS
			Number : nProgcode
			Number : nDepcode
			Number : nTomcode
			String : sMitroo
			String : sKat		
			Number : nAk
			Date/Time : dH_egr
			String : sEj
			String : sPraxh
			Number : nTotbau
			String : sArdipl
			Date/Time : dH_ait
			String : sEkp_dipl
			Date/Time : dDateAnag
			Receive Number : SEQNO
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
				Call SqlPrepare(hSqlCur, 'SELECT NEXTSN FROM TABLESN WHERE TABLENAME = \'METSTUPROG\' INTO :SEQNO' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur2, 'UPDATE TABLESN SET NEXTSN = :SEQNO + 1  WHERE TABLENAME = \'METSTUPROG\' ' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;
	
26. Δημιουργώ τον πίνακα METSTUPROG_WEB ο οποίος θα περιέχει τις εγγραφές εισαγωγής,διαγραφής και μεταβολής του πίνακα METSTUPROG; 

CREATE TABLE METSTUPROG_WEB 	(MODIFTYPE VARCHAR(1),DATEMODIF TIMESTAMP,MITROO VARCHAR(8), PROGCODE INTEGER, TMIMACODE INTEGER,TOTBAU REAL,DATEANAG DATE,METSTUPROG_SEQNO INTEGER);

27. Δημιουργώ την procedure METSTUPROG_WEB PROC η οποία αφορά την ενημέρωση του πίνακα METSTUPROG_WEB; 

STORE METSTUPROG_WEB_PRO
PROCEDURE: METSTUPROG_WEB_PRO STATIC
  PARAMETERS
      String        : sMITROO
      Number     : nPROGCODE
      Number     : nTMIMACODE
      Number     : nTOTBAU
      Date/Time : dDateAnag
      Number : nMETSTUPROG_SEQNO
      String : sMOD_TYPE
  LOCAL VARIABLES
    SQL HANDLE: hSql
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      Call SqlPrepare( hSql , 'INSERT INTO METSTUPROG_WEB(MODIFTYPE,DATEMODIF,MITROO,PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
       					  VALUES(:sMOD_TYPE,SYSDATETIME,:sMITROO,:nPROGCODE,:nTMIMACODE, :nTOTBAU,:dDateAnag,:nMETSTUPROG_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql );

28. Δημιουργώ τους TRIGGERS εισαγωγής, διαγραφής και μεταβολής του πίνακα METSTUPROG μέσω των οποίων θα καταχωρούνται οι εγγραφές στον πίνακα METSTUPROG_WEB;
SELECT * FROM METSTUPROG;
CREATE TRIGGER SYSADM.METSTUPROG_INS  AFTER INSERT ON METSTUPROG
 ( EXECUTE METSTUPROG_WEB_PRO	( METSTUPROG.MITROO,METSTUPROG.PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO,'i')) FOR EACH ROW;

CREATE TRIGGER SYSADM.METSTUPROG_DEL  AFTER DELETE ON METSTUPROG
 ( EXECUTE METSTUPROG_WEB_PROC   ( METSTUPROG.MITROO,METSTUPROG.PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO,'d')) FOR EACH ROW;
  
CREATE TRIGGER SYSADM.METSTUPROG_UPDT  AFTER UPDATE ON METSTUPROG REFERENCING OLD AS OLD_METSTUPROG NEW AS NEW_METSTUPROG
 ( EXECUTE METSTUPROG_WEB_PROC 	( METSTUPROG.MITROO,METSTUPROG.PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO,'u')) FOR EACH ROW;
select * from metstuprog_web;

29. Καταχωρώ τις αρχικές εγγραφές των πινάκων MET_WEB, METKARTL_WEB, METSTUPROG_WEB;

INSERT INTO MET_WEB	SELECT 'i',SYSDATETIME, MITROO, TMIMACODE, AR_T, EPVN,ONOMA,PATR, MHTR, SEX, YPHK, COORIG,NOMOSORIG, POLIORIG, BIRTHDATE, NOMOSMHTR,
                                                        POLIMHTR,DIMOTOLOGIO, COKAT, NOMOSKAT, POLIKAT, PERIOXI,ODOS, TT, TEL1, TEL2, EMAIL, MET_SEQNO FROM MET;
 
INSERT INTO METKARTL_WEB SELECT 'i',SYSDATETIME, MITROO,PROGCODE,AK, PERIOD,COURCODE, TMIMACODE, TYPOS,GRADENOR,GRADEPAN, APALAG, PERIODANIKI, METKARTL_SEQNO FROM METKARTL;

INSERT INTO METSTUPROG_WEB SELECT 'i',SYSDATETIME,MITROO,PROGCODE, TMIMACODE, TOTBAU,DATEANAG,METSTUPROG_SEQNO FROM METSTUPROG;

