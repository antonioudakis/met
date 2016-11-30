;=========================================================================;
1.Πριν γίνει η ενέργεια 2 πρέπει να αφαιρέσω τους ΤRIGGERS από τον πίνακα METKARTL;
;=========================================================================;

DROP TRIGGER METKARTL_DEL;
DROP TRIGGER METKARTL_INS;
DROP TRIGGER METKARTL_UPDT;
DROP TRIGGER METKARTL_INS_SN;



;=========================================================================;
2.Προσθέτω την κολόνα DATEDEL στον πίνακα METKARTL ;
;=========================================================================;

ALTER TABLE METKARTL ADD DATEDEL DATE;



;=========================================================================;
3.Προσθέτω την κολόνα DATEDEL στον πίνακα METKARTL_IST ;
;=========================================================================;

ALTER TABLE METKARTL_IST ADD DATEDEL DATE;



;=========================================================================;
4. Προσθέτω την κολόνα DATEDEL στον πίνακα METKARTL_WEB ;
;=========================================================================;

ALTER TABLE METKARTL_WEB ADD DATEDEL DATE;



;=========================================================================;
4. Δημιουργώ τον TRIGGER METKARTL_INS_SN ο οποίος παίρνει τον επόμενο διαθέσιμο 
    σειριακό αριθμό από τον πίνακα TABLESN για τον πίνακα METKARTL;
;=========================================================================;

CREATE TRIGGER METKARTL_INS_SN BEFORE INSERT ON METKARTL
		   ( EXECUTE INLINE ( METKARTL.TMIMACODE, METKARTL.MITROO, METKARTL.PERIOD, METKARTL.COURCODE, METKARTL.TYPOS,
                     	     METKARTL.GRADENOR, METKARTL.AK ,METKARTL.GRADEPAN,METKARTL.APALAG, METKARTL.PERIODANIKI, METKARTL.PROGCODE, 
    		     	     METKARTL.EPEPIL, METKARTL.DATEDEL,METKARTL.METKARTL_SEQNO)
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
			String : sEPEPIL
			Date/Time:dDATEDEL			
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




;=========================================================================;
5. Διαγράφω την procedure METKARTL_PROC;
;=========================================================================;

ERASE METKARTL_PROC;



;=========================================================================;
6. Καταχωρώ την procedure METKARTL_PROC;
;=========================================================================;

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
		Date/Time	: dDATEDEL
   		Number		: nMETKARTL_SEQNO
 	LOCAL VARIABLES
   		SQL HANDLE: hSql1
   		SQL HANDLE: hSql2
 	ACTIONS
   		On Procedure Startup
    			Call SqlConnect( hSql1 )
    			Call SqlConnect( hSql2 )
   		On Procedure Execute
			Call SqlPrepare( hSql1 , 'INSERT INTO METKARTL_WEB	(
                                                                                 DATEMODIF, MODIFTYPE, TMIMACODE, PROGCODE, PERIOD, AK, COURCODE, MITROO, TYPOS, PERIODANIKI, GRADENOR, GRADEPAN,
									      APALAG, EPEPIL, DATEDEL, METKARTL_SEQNO)
     							            VALUES	(
                                                                                 SYSDATETIME, :sMODIFTYPE, :nTMIMACODE, :nPROGCODE, :sPERIOD, :nAK, :nCOURCODE, :sMITROO, :sTYPOS, :sPERIODANIKI, :nGRADENOR, :nGRADEPAN,
									        :sAPALAG, :sEPEPIL, :dDATEDEL, :nMETKARTL_SEQNO)' )
    			Call SqlExecute( hSql1 )
    			Call SqlPrepare( hSql2 , 'INSERT INTO METKARTL_IST(
                                                                                USERNAME, DATEMODIF, MODIFTYPE, TMIMACODE, PROGCODE, PERIOD, AK, COURCODE, MITROO, TYPOS, PERIODANIKI, GRADENOR, GRADEPAN,
									     APALAG, EPEPIL, DATEDEL, METKARTL_SEQNO)
     							          VALUES	(
                                                                                USER, SYSDATETIME, :sMODIFTYPE, :nTMIMACODE, :nPROGCODE, :sPERIOD, :nAK, :nCOURCODE, :sMITROO, :sTYPOS, :sPERIODANIKI, :nGRADENOR, :nGRADEPAN,
									      :sAPALAG, :sEPEPIL, :dDATEDEL, :nMETKARTL_SEQNO)' )
    			Call SqlExecute( hSql2 )
   		On Procedure Close
    			Call SqlDisconnect( hSql1 )
    			Call SqlDisconnect( hSql2 );


;==============================================================================;
7. Δημιουργώ τους TRIGGERS εισαγωγής, διαγραφής και τροποποίησης του πίνακαMETKARTL
    μέσω των οποίων θα καταχωρούνται οι εγγραφές στον πίνακα METKARTL_WEB και METKARTL_IST;
;==============================================================================;

CREATE TRIGGER METKARTL_INS AFTER INSERT ON METKARTL
	( EXECUTE METKARTL_PROC (
				'i', METKARTL.TMIMACODE, METKARTL.PROGCODE, METKARTL.PERIOD, METKARTL.AK, METKARTL.COURCODE, METKARTL.MITROO, METKARTL.TYPOS, 
				METKARTL.PERIODANIKI, METKARTL.GRADENOR, METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.EPEPIL, DATEDEL, METKARTL.METKARTL_SEQNO) )
FOR EACH ROW;

CREATE TRIGGER METKARTL_DEL AFTER DELETE ON METKARTL
	( EXECUTE METKARTL_PROC (
				'd', METKARTL.TMIMACODE, METKARTL.PROGCODE, METKARTL.PERIOD, METKARTL.AK, METKARTL.COURCODE, METKARTL.MITROO, METKARTL.TYPOS, 
				METKARTL.PERIODANIKI, METKARTL.GRADENOR, METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.EPEPIL, DATEDEL, METKARTL.METKARTL_SEQNO) )
FOR EACH ROW;

CREATE TRIGGER METKARTL_UPDT AFTER UPDATE ON METKARTL REFERENCING OLD AS OLD_METKARTL NEW AS NEW_METKARTL
  	( EXECUTE METKARTL_PROC (
				'u', METKARTL.TMIMACODE, METKARTL.PROGCODE, METKARTL.PERIOD, METKARTL.AK, METKARTL.COURCODE, METKARTL.MITROO, METKARTL.TYPOS, 
				METKARTL.PERIODANIKI, METKARTL.GRADENOR, METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.EPEPIL, DATEDEL, METKARTL.METKARTL_SEQNO) )
FOR EACH ROW;


