alter table tablesn add met_seqno integer;
alter table met add met_seqno integer;
alter table metkartl add metkartl_seqno integer;
alter table metstuprog add metstuprog_seqno integer;

store seqno_met
PROCEDURE: SEQNO_MET
		PARAMETERS
			Receive Number : SEQNO
			Receive String : sMitroo


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
				Call SqlPrepare(hSqlCur, 'SELECT mitroo FROM MET order by mitroo INTO :sMitroo' )
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
						Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE met  SET met_seqno  = :SEQNO  WHERE  mitroo = :sMitroo' )
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 );

execute seqno_met
\
,,
/


insert into  tablesn values ('MET',null,);

CREATE TRIGGER SYSADM.MET_INS_SN BEFORE INSERT ON met
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
				Call SqlPrepare(hSqlCur, 'SELECT MET_SEQNO FROM TABLESN WHERE TABLENAME = \'MET\' INTO :nSEQNO' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur2, 'UPDATE TABLESN SET MET_SEQNO = :nSEQNO + 1  WHERE TABLENAME = \'MET\' ' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;

store seqno_metkartl
PROCEDURE: SEQNO_METKARTL
		PARAMETERS
			Receive Number : SEQNO
			Receive String : sMitroo
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
				Call SqlPrepare(hSqlCur, 'SELECT courcode,progcode,mitroo,ak,period FROM METKARTL order by tmimacode, progcode, mitroo, ak,period INTO :nCourcode,:nProgcode,:sMitroo,:nAk,:sPeriod' )
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
						Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE metkartl  SET metkartl_seqno  = :SEQNO  WHERE progcode=:nProgcode AND mitroo = :sMitroo AND (ak = :nAk or ak is null) AND period = :sPeriod AND courcode =:nCourcode' )
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 );

execute seqno_metkartl
\
,,,,,,
/


insert into  tablesn values ('METKARTL',null,);

CREATE TRIGGER SYSADM.METKARTL_INS_SN BEFORE INSERT ON metkartl
		   ( EXECUTE INLINE ( METKARTL.TMIMACODE, METKARTL.MITROO, METKARTL.PERIOD, 	       METKARTL.COURCODE, METKARTL.TYPOS,
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
				Call SqlPrepare(hSqlCur, 'SELECT MET_SEQNO FROM TABLESN WHERE TABLENAME = \'METKARTL\' INTO :nSEQNO' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur2, 'UPDATE TABLESN SET MET_SEQNO = :nSEQNO + 1  WHERE TABLENAME = \'METKARTL\' ' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;

store seqno_metstuprog
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
				Call SqlPrepare(hSqlCur, 'SELECT PROGCODE,MITROO FROM METSTUPROG 
				order by progcode, mitroo INTO :nProgcode,:sMitroo' )
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
						Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE metstuprog  SET 
						metstuprog_seqno  = :SEQNO  WHERE progcode=:nProgcode AND mitroo = :sMitroo' )
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 );

execute seqno_metstuprog
\
,,,
/

insert into  tablesn values ('METSTUPROG',null,);

CREATE TRIGGER SYSADM.METSTUPROG_INS_SN BEFORE INSERT ON metstuprog
		   ( EXECUTE INLINE ( PROGCODE,DEPCODE,TOMCODE,MITROO,KAT,AK,H_EGR,EJ,PRAXH,TOTBAU,ARDIPL,H_AIT,EKT_DIPL,EKP_DIPL,DATEANAG,METSTUPROG_SEQNO)
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
			String : sEkt_dipl
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
				Call SqlPrepare(hSqlCur, 'SELECT MET_SEQNO FROM TABLESN WHERE TABLENAME = \'METSTUPROG\' INTO :SEQNO' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur2, 'UPDATE TABLESN SET MET_SEQNO = :SEQNO + 1  WHERE TABLENAME = \'METSTUPROG\' ' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;
