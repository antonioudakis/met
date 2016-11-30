drop index DEP_IDX;
create unique index DEP_IDX on DEP (AM_DEP);
update statistics on index DEP_IDX;
alter table DEP modify AM_DEP not null;
alter table DEP primary key (AM_DEP);


drop index METUNIV_IDX;
create unique index METUNIV_IDX on    METUNIV (UNIVCODE);
update statistics on index METUNIV_IDX;
alter table  METUNIV modify UNIVCODE not null;
alter table  METUNIV primary key (UNIVCODE);


drop index METTMIMA_IDX;
alter table METANATHESI drop DATEANAG;
create unique index METTMIMA_IDX on METTMIMA (TMIMACODE);
update statistics on index METTMIMA_IDX;
alter table METTMIMA modify TMIMACODE not null;
alter table METTMIMA primary key (TMIMACODE);
alter table METTMIMA foreign key METUNIV (UNIVCODE) references METUNIV on delete restrict;
alter table METTMIMA foreign key DEP_AM_PRO (AM_PRO) references DEP on delete restrict;
alter table METTMIMA foreign key DEP_AM_ANPRO (AM_ANPRO) references DEP on delete restrict;
alter table METTMIMA foreign key DEP_AM_GRAM (AM_GRAM) references DEP on delete restrict;
alter table METTMIMA foreign key DEP_AM_ANGRAM (AM_ANGRAM) references DEP on delete restrict;



drop index MET_IDX;
create unique index MET_IDX on MET (MITROO,TMIMACODE);
update statistics on index MET_IDX;
drop trigger MET_DEL;
drop trigger MET_INS;
drop trigger MET_UPDT;
drop trigger MET_INS_SN;
alter table MET modify MITROO not null;
alter table MET modify TMIMACODE not null;
create trigger MET_INS_SN before insert on MET
		 ( EXECUTE INLINE ( MET_SEQNO)
	PROCEDURE: MET_INS_SEQNO STATIC
		PARAMETERS
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
create trigger MET_INS after insert on MET
( EXECUTE INLINE 	( MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN,MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.COORIG, MET.NOMOSORIG, MET.POLIORIG, 
				MET. BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, MET.PERIOXI, MET.ODOS, MET.TT, 
				MET.TEL1, MET.TEL2, MET.EMAIL, MET.MET_SEQNO)
  PROCEDURE: MET_INS_PROC STATIC
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
      Number  : nMET_SEQNO
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      set MOD_TYPE = 'i'
      Call SqlPrepare( hSql , 'INSERT INTO MET_WEB( MODIFTYPE,DATEMODIF,MITROO,TMIMACODE,AR_T, EPVN,ONOMA,PATR,MHTR,SEX,YPHK,COORIG,NOMOSORIG,POLIORIG,BIRTHDATE,
					   NOMOSMHTR,POLIMHTR,DIMOTOLOGIO,COKAT,NOMOSKAT,POLIKAT,PERIOXI,ODOS,TT,TEL1,TEL2,EMAIL,MET_SEQNO)
       					  VALUES	(:MOD_TYPE,SYSDATETIME,:sMITROO,:nTMIMACODE,:sAR_T,:sEPVN,:sONOMA,:sPATR,:sMHTR,:sSEX,:sYPHK,:sCOORIG,:sNOMOSORIG,:sPOLIORIG,:dBIRTHDATE,
								:sNOMOSMHTR,:sPOLIMHTR,:sDIMOTOLOGIO,:sCOKAT,:sNOMOSKAT,:sPOLIKAT, :sPERIOXI,:sODOS,:sTT,:sTEL1,:sTEL2,:sEMAIL, :nMET_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger MET_DEL after delete on MET
( EXECUTE INLINE 	( MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN,MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.COORIG, MET.NOMOSORIG, MET.POLIORIG, 
				MET. BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, MET.PERIOXI, MET.ODOS, MET.TT, 
				MET.TEL1, MET.TEL2, MET.EMAIL,MET.MET_SEQNO)
  PROCEDURE: MET_DEL_PROC STATIC
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
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      set MOD_TYPE = 'd'
      Call SqlPrepare( hSql , 'INSERT INTO MET_WEB( MODIFTYPE,DATEMODIF,MITROO,TMIMACODE,AR_T, EPVN,ONOMA,PATR,MHTR,SEX,YPHK,COORIG,NOMOSORIG,POLIORIG,BIRTHDATE,
					   NOMOSMHTR,POLIMHTR,DIMOTOLOGIO,COKAT,NOMOSKAT,POLIKAT,PERIOXI,ODOS,TT,TEL1,TEL2,EMAIL,MET_SEQNO)
       					  VALUES	(:MOD_TYPE,SYSDATETIME,:sMITROO,:nTMIMACODE,:sAR_T,:sEPVN,:sONOMA,:sPATR,:sMHTR,:sSEX,:sYPHK,:sCOORIG,:sNOMOSORIG,:sPOLIORIG,:dBIRTHDATE,
								:sNOMOSMHTR,:sPOLIMHTR,:sDIMOTOLOGIO,:sCOKAT,:sNOMOSKAT,:sPOLIKAT, :sPERIOXI,:sODOS,:sTT,:sTEL1,:sTEL2,:sEMAIL, :nMET_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger MET_UPDT after update on MET referencing OLD as OLD_MET NEW as NEW_MET
 ( EXECUTE INLINE 	( MET.MITROO, MET.TMIMACODE, MET.AR_T, MET.EPVN,MET.ONOMA, MET.PATR, MET.MHTR, MET.SEX, MET.YPHK, MET.COORIG, MET.NOMOSORIG, MET.POLIORIG, 
				MET. BIRTHDATE, MET.NOMOSMHTR, MET.POLIMHTR, MET.DIMOTOLOGIO, MET.COKAT, MET.NOMOSKAT, MET.POLIKAT, MET.PERIOXI, MET.ODOS, MET.TT, 
				MET.TEL1, MET.TEL2, MET.EMAIL,MET.MET_SEQNO)
  PROCEDURE: MET_UPDT_PROC STATIC
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
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      set MOD_TYPE = 'u'
      Call SqlPrepare( hSql , 'INSERT INTO MET_WEB( MODIFTYPE,DATEMODIF,MITROO,TMIMACODE,AR_T, EPVN,ONOMA,PATR,MHTR,SEX,YPHK,COORIG,NOMOSORIG,POLIORIG,BIRTHDATE,
					   NOMOSMHTR,POLIMHTR,DIMOTOLOGIO,COKAT,NOMOSKAT,POLIKAT,PERIOXI,ODOS,TT,TEL1,TEL2,EMAIL, MET_SEQNO)
       					  VALUES	(:MOD_TYPE,SYSDATETIME,:sMITROO,:nTMIMACODE,:sAR_T,:sEPVN,:sONOMA,:sPATR,:sMHTR,:sSEX,:sYPHK,:sCOORIG,:sNOMOSORIG,:sPOLIORIG,:dBIRTHDATE,
								:sNOMOSMHTR,:sPOLIMHTR,:sDIMOTOLOGIO,:sCOKAT,:sNOMOSKAT,:sPOLIKAT, :sPERIOXI,:sODOS,:sTT,:sTEL1,:sTEL2,:sEMAIL, :nMET_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
alter table MET primary key (MITROO,TMIMACODE);
alter table MET foreign key METTMIMA (TMIMACODE) references METTMIMA on delete restrict;


alter table METLANG add TMIMACODE integer ;
update METLANG set TMIMACODE = ;
drop index METLANG_IDX;
create unique index METLANG_IDX on METLANG (MITROO,TMIMACODE,LANGCODE);
update statistics on index METTMIMA_IDX;
alter table METLANG modify MITROO not null;
alter table METLANG modify TMIMACODE not null;
alter table METLANG modify LANGCODE not null;
alter table METLANG primary key (MITROO,TMIMACODE,LANGCODE);
alter table METLANG foreign key MET (MITROO,TMIMACODE) references MET on delete restrict;
alter table METLANG drop SEQNO;


alter table METPTYX add TMIMACODE integer ;
update METPTYX set TMIMACODE = ;
drop index METPTYX_IDX;
create unique index METPTYX_IDX on METPTYX (MITROO,TMIMACODE,SEQNO);
update statistics on index METPTYX_IDX;
alter table METPTYX modify MITROO not null;
alter table METPTYX modify TMIMACODE not null;
alter table METPTYX modify SEQNO not null;
alter table METPTYX primary key (MITROO,TMIMACODE,SEQNO);
alter table METPTYX foreign key MET (MITROO,TMIMACODE) references MET on delete restrict;


drop index METPROG_IDX;
create unique index METPROGRAM_IDX on METPROGRAM (TMIMACODE,PROGCODE);
update statistics on index METPROGRAM_IDX;
alter table METPROGRAM modify TMIMACODE not null;
alter table METPROGRAM modify PROGCODE not null;
alter table METPROGRAM primary key (TMIMACODE,PROGCODE);
alter table METPROGRAM foreign key METTMIMA (TMIMACODE) references METTMIMA on delete restrict;


drop index METEGR_IDX;
create unique index METEGR_IDX on METEGR (MITROO,TMIMACODE,PROGCODE,SEQNO);
update statistics on index METEGR_IDX;
alter table METEGR modify MITROO not null;
alter table METEGR modify TMIMACODE not null;
alter table METEGR modify PROGCODE not null;
alter table METEGR modify SEQNO not null;
alter table METEGR primary key (MITROO,TMIMACODE,PROGCODE,SEQNO);
alter table METEGR foreign key MET (MITROO,TMIMACODE) references MET on delete restrict;
alter table METEGR foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;


alter table METPROOD add TMIMACODE integer ;
update METPROOD set TMIMACODE = ;
drop index METPROOD_IDX;
create unique index METPROOD_IDX on METPROOD (MITROO,TMIMACODE,PROGCODE,DATEPROD);
update statistics on index METPROOD_IDX;
alter table METPROOD modify MITROO not null;
alter table METPROOD modify TMIMACODE not null;
alter table METPROOD modify PROGCODE not null;
alter table METPROOD modify DATEPROD not null;
alter table METPROOD primary key (MITROO,TMIMACODE,PROGCODE,DATEPROD);
alter table METPROOD foreign key MET (MITROO,TMIMACODE) references MET on delete restrict;
alter table METPROOD foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;
alter table METPROOD drop SEQNO;


alter table METXRHMA add TMIMACODE integer ;
update METXRHMA set TMIMACODE = ;
drop index METXRHMA_IDX;
create unique index METXRHMA_IDX on METXRHMA (MITROO,TMIMACODE,PROGCODE,DATEAPO);
update statistics on index METXRHMA_IDX;
alter table METXRHMA modify MITROO not null;
alter table METXRHMA modify TMIMACODE not null;
alter table METXRHMA modify PROGCODE not null;
alter table METXRHMA modify DATEAPO not null;
alter table METXRHMA primary key (MITROO,TMIMACODE,PROGCODE,DATEAPO);
alter table METXRHMA foreign key MET (MITROO,TMIMACODE) references MET on delete restrict;
alter table METXRHMA foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;
alter table METXRHMA drop SEQNO;


alter table METDIAKOP add TMIMACODE integer ;
update METDIAKOP set TMIMACODE = ;
drop index METDIAKOP_IDX;
create unique index METDIAKOP_IDX on METDIAKOP (MITROO,TMIMACODE,PROGCODE,DATEAPO);
update statistics on index METDIAKOP_IDX;
alter table METDIAKOP modify MITROO not null;
alter table METDIAKOP modify TMIMACODE not null;
alter table METDIAKOP modify PROGCODE not null;
alter table METDIAKOP modify DATEAPO not null;
alter table METDIAKOP primary key (MITROO,TMIMACODE,PROGCODE,DATEAPO);
alter table METDIAKOP foreign key MET (MITROO,TMIMACODE) references MET on delete restrict;
alter table METDIAKOP foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;
alter table METDIAKOP DROP SEQNO;


drop index METPROGAT_IDX;
create unique index METPROGAT_IDX on METPROGAT (TMIMACODE,PROGCODE,AK);
update statistics on index METPROGAT_IDX;
alter table METPROGAT modify TMIMACODE not null;
alter table METPROGAT modify PROGCODE not null;
alter table METPROGAT modify AK not null;
alter table METPROGAT primary key (TMIMACODE,PROGCODE,AK);
alter table METPROGAT foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;


drop index METPROCORP_IDX;
create unique index METPROCORP_IDX on METPROCORP (TMIMACODE,PROGCODE,CORPCODE);
update statistics on index METPROCORP_IDX;
alter table METPROCORP modify TMIMACODE not null;
alter table METPROCORP modify PROGCODE not null;
alter table METPROCORP modify CORPCODE not null;
alter table METPROCORP primary key (TMIMACODE,PROGCODE,CORPCODE);
alter table METPROCORP foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;
alter table METPROCORP foreign key METTMIMA  (TMIMACODE) references METTMIMA on delete restrict;


drop index METKATEF_IDX;
create unique index METKATEF_IDX on  METKATEF (TMIMACODE,PROGCODE,KAT);
update statistics on index METKATEF_IDX;
alter table  METKATEF modify TMIMACODE not null;
alter table  METKATEF modify PROGCODE not null;
alter table  METKATEF modify KAT not null;
alter table  METKATEF primary key (TMIMACODE,PROGCODE,KAT);
alter table  METKATEF foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;


drop index METTOMEIS_IDX;
create unique index METTOMEIS_IDX on  METTOMEIS (TMIMACODE,TOMCODE);
update statistics on index METTOMEIS_IDX;
alter table  METTOMEIS modify TMIMACODE not null;
alter table  METTOMEIS modify TOMCODE not null;
alter table  METTOMEIS primary key (TMIMACODE,TOMCODE);
alter table  METTOMEIS foreign key METTMIMA  (TMIMACODE) references METTMIMA on delete restrict;


alter table METSTUPROG add TMIMACODE integer ;
update METSTUPROG set TMIMACODE = ;
alter table METSTUPROG_WEB add TMIMACODE integer;
update METSTUPROG_WEB set TMIMACODE = ;
alter table METSTUPROG add CODESYN real;
select MITROO||PROGCODE||TMIMACODE||CODESYN from METDSYNERG group by 1 having count(MITROO||PROGCODE||TMIMACODE||CODESYN ) >1;
update METSTUPROG set CODESYN = (select CODESYN from METDSYNERG where METSTUPROG.MITROO = METDSYNERG.MITROO AND METSTUPROG.PROGCODE = METDSYNERG.PROGCODE
		AND METSTUPROG.TMIMACODE = METDSYNERG.TMIMACODE)  where MITROO||PROGCODE||TMIMACODE in (SELECT MITROO||PROGCODE||TMIMACODE from METDSYNERG);
select PROGCODE||MITROO||TMIMACODE from METSTUPROG group by 1 having count(PROGCODE||MITROO||TMIMACODE)>1;
delete from TABLESN where TABLENAME = 'METANATHESI';
select MAX(CODESYN) from METANATHESI;
update TABLESN set TABLENAME='METANATHESI',NEXTSN= where TABLENAME ='METDSYNERG';
create unique index TABLESN_IDX on TABLESN (TABLENAME);
drop index METSTUPROG_IDX;
create unique index METSTUPROG_IDX on  METSTUPROG (MITROO,TMIMACODE,PROGCODE);
update statistics on index METSTUPROG_IDX;
drop trigger METSTUPROG_DEL;
drop trigger METSTUPROG_INS;
drop trigger METSTUPROG_UPDT;
drop trigger METSTUPROG_INS_SN;
alter table  METSTUPROG modify MITROO not null;
alter table  METSTUPROG modify TMIMACODE not null;
alter table  METSTUPROG modify PROGCODE not null;
create trigger METSTUPROG_INS_SN before insert on METSTUPROG
		   ( EXECUTE INLINE ( METSTUPROG_SEQNO)
	PROCEDURE: MET_STUP_INS_SEQNO STATIC
		PARAMETERS
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
create trigger METSTUPROG_INS after insert on METSTUPROG
 ( EXECUTE INLINE 	( METSTUPROG.MITROO,METSTUPROG.PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
  PROCEDURE: STUPROG_INS_PROC STATIC
  PARAMETERS
      String        : sMITROO
      Number     : nPROGCODE
      Number     : nTMIMACODE
      Number     : nTOTBAU
      Date/Time : dDateAnag
      Number : nMETSTUPROG_SEQNO
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      set MOD_TYPE = 'i'
      Call SqlPrepare( hSql , 'INSERT INTO METSTUPROG_WEB(MODIFTYPE,DATEMODIF,MITROO,PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
       					  VALUES(:MOD_TYPE,SYSDATETIME,:sMITROO,:nPROGCODE,:nTMIMACODE, :nTOTBAU,:dDateAnag,:nMETSTUPROG_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger METSTUPROG_DEL after delete on METSTUPROG
 ( EXECUTE INLINE 	( METSTUPROG.MITROO,METSTUPROG.PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
  PROCEDURE: STUPROG_DEL_PROC STATIC
  PARAMETERS
      String        : sMITROO
      Number     : nPROGCODE
      Number     : nTMIMACODE
      Number     : nTOTBAU
      Date/Time : dDateAnag
      Number : nMETSTUPROG_SEQNO
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      set MOD_TYPE = 'd'
      Call SqlPrepare( hSql , 'INSERT INTO METSTUPROG_WEB( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
       					  VALUES (:MOD_TYPE,SYSDATETIME,:sMITROO,:nPROGCODE, :nTMIMACODE, :nTOTBAU,:dDateAnag,:nMETSTUPROG_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger METSTUPROG_UPDT after update on METSTUPROG referencing OLD as OLD_METSTUPROG NEW as NEW_METSTUPROG
 ( EXECUTE INLINE 	( MITROO,PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
  PROCEDURE: STUPROG_UPDT_PROC STATIC
  PARAMETERS
      String        : sMITROO
      Number     : nPROGCODE
      Number     : nTMIMACODE
      Number     : nTOTBAU
      Date/Time : dDateAnag
      Number : nMETSTUPROG_SEQNO
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
        set MOD_TYPE = 'u'
        Call SqlPrepare( hSql , 'INSERT INTO METSTUPROG_WEB( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,TMIMACODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
       					  VALUES	(:MOD_TYPE,SYSDATETIME,:sMITROO,:nPROGCODE, :nTMIMACODE, :nTOTBAU,:dDateAnag,:nMETSTUPROG_SEQNO)' )
        Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
alter table  METSTUPROG primary key (MITROO,TMIMACODE,PROGCODE);
alter table  METSTUPROG foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;
alter table  METSTUPROG foreign key MET  (MITROO,TMIMACODE) references MET on delete restrict;
alter table  METSTUPROG foreign key METKATEF  (TMIMACODE,PROGCODE,KAT) references METKATEF on delete restrict;
alter table  METSTUPROG foreign key METTOMEIS  (TMIMACODE,TOMCODE) references METTOMEIS on delete restrict;
 

drop index METCOUR_IDX;
create unique index METCOURSE_IDX on   METCOURSE (COURCODE,AK,TMIMACODE);
update statistics on index METCOURSE_IDX;
alter table   METCOURSE modify COURCODE not null;
alter table   METCOURSE modify AK not null;
alter table   METCOURSE modify TMIMACODE not null;
alter table   METCOURSE primary key (COURCODE,AK,TMIMACODE);
alter table   METCOURSE foreign key METTMIMA  (TMIMACODE) references METTMIMA on delete restrict;


drop index METPROSPU_IDX;
create unique index METPROSPU_IDX on   METPROSPU (COURCODE,AK,TMIMACODE,PROGCODE,PERIOD,KAT);
update statistics on index METPROSPU_IDX;
alter table   METPROSPU modify COURCODE not null;
alter table   METPROSPU modify AK not null;
alter table   METPROSPU modify TMIMACODE not null;
alter table   METPROSPU modify PROGCODE not null;
alter table   METPROSPU modify PERIOD not null;
alter table   METPROSPU modify KAT not null;
alter table   METPROSPU primary key (COURCODE,AK,TMIMACODE,PROGCODE,PERIOD,KAT);
alter table   METPROSPU foreign key METCOURSE  (COURCODE,AK,TMIMACODE) references METCOURSE on delete restrict;
alter table   METPROSPU foreign key METKATEF  (TMIMACODE,PROGCODE,KAT) references METKATEF on delete restrict;
alter table   METPROSPU foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM on delete restrict;


drop index METKARTL_IDX;
create unique index METKARTL_IDX on   METKARTL (MITROO,TMIMACODE,COURCODE,AK,PERIOD,PROGCODE);
update statistics on index METKARTL_IDX;
drop trigger METKARTL_DEL;
drop trigger METKARTL_INS;
drop trigger METKARTL_UPDT;
drop trigger METKARTL_INS_SN;
alter table   METKARTL modify MITROO not null;
alter table   METKARTL modify TMIMACODE not null;
alter table   METKARTL modify COURCODE not null;
alter table   METKARTL modify AK not null;
alter table   METKARTL modify PERIOD not null;
alter table   METKARTL modify PROGCODE not null;
create trigger METKARTL_INS_SN before insert on METKARTL
		   ( EXECUTE INLINE (.METKARTL_SEQNO)
	PROCEDURE: MET_KART_INS_SEQNO STATIC
		PARAMETERS		
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
create trigger METKARTL_INS  after insert  on METKARTL
( EXECUTE INLINE ( METKARTL.MITROO, METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE, METKARTL.TMIMACODE,METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL_SEQNO)
  PROCEDURE: METKARTL_INS_PROC STATIC
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
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      Set MOD_TYPE = 'i'
      Call SqlPrepare( hSql , 'INSERT INTO METKARTL_WEB  ( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,AK,PERIOD,COURCODE,TMIMACODE,TYPOS,GRADENOR,GRADEPAN,APALAG,PERIODANIKI,METKARTL_SEQNO) 
					   VALUES(:MOD_TYPE , SYSDATETIME , :sMITROO , :nPROGCODE , :nAK , :sPERIOD, :nCOURCODE, :nTMIMACODE ,:sTYPOS , :nGRADENOR, :nGRADEPAN , :sAPALAG , :sPERIODANIKI, :nMETKARTL_SEQNO ) ' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger METKARTL_DEL  after  delete  on METKARTL
( EXECUTE INLINE ( METKARTL.MITROO,METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE,METKARTL.TMIMACODE,  METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL.METKARTL_SEQNO)
  PROCEDURE: METKARTL_DEL_PROC STATIC
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
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      Set MOD_TYPE = 'd'
      Call SqlPrepare( hSql , 'INSERT INTO METKARTL_WEB  ( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,AK,PERIOD,COURCODE,TMIMACODE,TYPOS,GRADENOR,GRADEPAN,APALAG,PERIODANIKI,METKARTL_SEQNO) 
					   VALUES(:MOD_TYPE , SYSDATETIME , :sMITROO ,:nPROGCODE , :nAK , :sPERIOD, :nCOURCODE, :nTMIMACODE ,:sTYPOS , :nGRADENOR, :nGRADEPAN , :sAPALAG , :sPERIODANIKI, :nMETKARTL_SEQNO ) ' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger METKARTL_UPDT  after update  on METKARTL  referencing OLD as OLD_METKARTL NEW as NEW_METKARTL
( EXECUTE INLINE ( METKARTL.MITROO, METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE, METKARTL.TMIMACODE,METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL.METKARTL_SEQNO)
  PROCEDURE: METKARTL_UPDT_PROC STATIC
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
  LOCAL VARIABLES
    SQL HANDLE: hSql
    String : MOD_TYPE
  ACTIONS
    On Procedure Startup
      Call SqlConnect( hSql )
    On Procedure Execute
      Set MOD_TYPE = 'u'
      Call SqlPrepare( hSql , 'INSERT INTO METKARTL_WEB  ( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,AK,PERIOD,COURCODE,TMIMACODE,TYPOS,GRADENOR,GRADEPAN,APALAG,PERIODANIKI,METKARTL_SEQNO)  VALUES(:MOD_TYPE , SYSDATETIME , :sMITROO , :nPROGCODE , :nAK , :sPERIOD, :nCOURCODE,:nTMIMACODE ,:sTYPOS , :nGRADENOR, :nGRADEPAN , :sAPALAG , :sPERIODANIKI, :nMETKARTL_SEQNO ) ' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
alter table METKARTL primary key (MITROO,TMIMACODE,COURCODE,AK,PERIOD,PROGCODE);
alter table METKARTL foreign key METCOURSE  (COURCODE,AK,TMIMACODE) references METCOURSE on delete restrict;
alter table METKARTL foreign key METSTUPROG  (MITROO,TMIMACODE,PROGCODE) references METSTUPROG on delete restrict;


drop index YPAL_IDX;
create unique index YPAL_IDX on   YPAL (K_YPAL,K_TM);
update statistics on index YPAL_IDX;
alter table YPAL modify K_YPAL not null;
alter table YPAL modify K_TM not null;
alter table YPAL primary key (K_YPAL,K_TM);
alter table YPAL foreign key METTMIMA  (K_TM) references METTMIMA on delete restrict;


create table METANATHIST (CODESYN real,TMIMACODE integer,DATEANATH date, THEMA varchar(250), TITLOSMAU varchar(250) );
select CODESYN||TMIMACODE||DATEANATH from METANATHESI group by 1 having count(CODESYN||TMIMACODE||DATEANATH) >1;
select * from METANATHESI where CODESYN is null;
select * from METANATHESI where TMIMACODE is null;
select * from METANATHESI where DATEANATH is null;
insert into METANATHIST select CODESYN,TMIMACODE,DATEANATH,THEMA,TITLOSMAU from METANATHESI;
create table METANATHESI_TMP1 (CODESYN real,TMIMACODE integer,DATEINS date, DATEEJET date, DATEANATH date, THEMA varchar(250), TITLOSMAU varchar(250));
insert into METANATHESI_TMP1 select CODESYN,TMIMACODE,DATEINS,DATEEJET,DATEANATH,THEMA,TITLOSMAU FROM METANATHESI;
create table METANATHESI_TMP2 (CODESYN real,TMIMACODE integer, DATEANATH date,DATEINS date);
insert into METANATHESI_TMP2 select CODESYN,TMIMACODE,MAX(DATEANATH),MIN(DATEINS) from METANATHESI group by 1,2;
'UNLOAD SQL Cl\BACKUP\METANATHESI.SQL METANATHESI;
delete from METANATHESI;
drop trigger METANATHESI_DEL;
drop trigger METANATHESI_INS;
drop trigger METANATHESI_UPDT;
drop trigger METANATHESI_INS_SN;
alter table METANATHESI drop METANATHESI_SEQNO;
alter table METANATHESI drop SEQNO;
alter table METANATHESI drop MITROO;
alter table METANATHESI drop PROGCODE;
alter table METANATHESI drop DATEANAG;
'WATCH THE COLUMN SEQUENCE OF TABLE METANATHESI;
select * from METANATHESI;
insert into METANATHESI select METANATHESI_TMP2.CODESYN,METANATHESI_TMP2.DATEINS,METANATHESI_TMP2.TMIMACODE,METANATHESI_TMP2.DATEANATH,
METANATHESI_TMP1.DATEEJET,METANATHESI_TMP1.THEMA,METANATHESI_TMP1.TITLOSMAU
from METANATHESI_TMP1,METANATHESI_TMP2 
where METANATHESI_TMP1.CODESYN = METANATHESI_TMP2.CODESYN and METANATHESI_TMP1.TMIMACODE = METANATHESI_TMP2.TMIMACODE 
and METANATHESI_TMP1.DATEANATH = METANATHESI_TMP2. DATEANATH;
drop table METANATHESI_TMP1;
drop table METANATHESI_TMP2;


drop index METANATHE_IDX;
create unique index METANATHESI_IDX on METANATHESI (CODESYN,TMIMACODE);
update statistics on index METANATHESI_IDX;
alter table METANATHESI modify CODESYN not null;
alter table METANATHESI modify TMIMACODE not null;
alter table METANATHESI primary key (CODESYN,TMIMACODE);
alter table METANATHESI foreign key METTMIMA  (TMIMACODE) references METTMIMA on delete restrict;


drop index METANATHIST_IDX;
create unique index METANATHIST_IDX on METANATHIST (CODESYN,TMIMACODE,DATEANATH);
update statistics on index METANATHIST_IDX;
alter table METANATHIST modify CODESYN not null;
alter table METANATHIST modify TMIMACODE not null;
alter table METANATHIST modify DATEANATH not null;
create trigger METANATHIST_INS after insert on METANATHIST
		 ( EXECUTE INLINE ( METANATHIST.CODESYN,METANATHIST.TMIMACODE)
	PROCEDURE: METANATHIST_INS STATIC
		PARAMETERS
			Number: nCodesyn
			Number: nTmimacode	      	
	      	LOCAL VARIABLES
			SQL HANDLE: hSqlCur
			SQL HANDLE: hSqlCur2
			Number : nNext
			Date/Time:dDateanath
			String: sThema
	      		String: sTitlosmau
			Date/Time: dDateins
			Date/Time: dDateejet
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCur )
				Call SqlConnect( hSqlCur2 )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur, 'SELECT THEMA,TITLOSMAU,DATEANATH FROM METANATHIST  WHERE CODESYN = :nCodesyn AND TMIMACODE = :nTmimacode ORDER BY DATEANATH DESC INTO :sThema, :sTitlosMau, :dDateanath' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur2, 'UPDATE METANATHESI SET DATEANATH = :dDateanath,THEMA=:sThema, TITLOSMAU=:sTitlosmau WHERE CODESYN= :nCodesyn AND TMIMACODE = :nTmimacode' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;
create trigger METANATHIST_DEL after delete on METANATHIST
		 ( EXECUTE INLINE ( METANATHIST.CODESYN,METANATHIST.TMIMACODE)
	PROCEDURE: METANATHIST_DEL STATIC
		PARAMETERS
			Number: nCodesyn
			Number: nTmimacode	      	
	      	LOCAL VARIABLES
			SQL HANDLE: hSqlCur
			SQL HANDLE: hSqlCur2
			Number : nNext
			Number : nRows
			Date/Time:dDateanath
			String: sThema
	      		String: sTitlosmau
			Date/Time: dDateins
			Date/Time: dDateejet
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCur )
				Call SqlConnect( hSqlCur2 )

				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur, 'SELECT THEMA,TITLOSMAU,DATEANATH FROM METANATHIST  WHERE CODESYN = :nCodesyn AND TMIMACODE = :nTmimacode ORDER BY DATEANATH DESC INTO :sThema, :sTitlosMau, :dDateanath' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlImmediate( 'SELECT COUNT(*) FROM METANATHIST WHERE CODESYN= :nCodesyn AND TMIMACODE = :nTmimacode INTO :nRows' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				if nRows=0
					Call SqlPrepare(hSqlCur2, 'UPDATE METANATHESI SET DATEANATH = NULL,THEMA= NULL, TITLOSMAU=NULL WHERE CODESYN= :nCodesyn AND TMIMACODE = :nTmimacode' )
				else
					Call SqlPrepare(hSqlCur2, 'UPDATE METANATHESI SET DATEANATH = :dDateanath,THEMA= :sThema, TITLOSMAU= :sTitlosMau WHERE CODESYN= :nCodesyn AND TMIMACODE = :nTmimacode' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;
create trigger METANATHIST_UPDT after update on METANATHIST
		 ( EXECUTE INLINE ( METANATHIST.CODESYN,METANATHIST.TMIMACODE)
	PROCEDURE: METANATHIST_INS STATIC
		PARAMETERS
			Number: nCodesyn
			Number: nTmimacode	      	
	      	LOCAL VARIABLES
			SQL HANDLE: hSqlCur
			SQL HANDLE: hSqlCur2
			Number : nNext
			Date/Time:dDateanath
			String: sThema
	      		String: sTitlosmau
			Date/Time: dDateins
			Date/Time: dDateejet
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCur )
				Call SqlConnect( hSqlCur2 )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur, 'SELECT THEMA,TITLOSMAU,DATEANATH FROM METANATHIST  WHERE CODESYN = :nCodesyn AND TMIMACODE = :nTmimacode ORDER BY DATEANATH DESC INTO :sThema, :sTitlosMau, :dDateanath' )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur2, 'UPDATE METANATHESI SET DATEANATH = :dDateanath,THEMA=:sThema, TITLOSMAU=:sTitlosmau WHERE CODESYN= :nCodesyn AND TMIMACODE = :nTmimacode' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				Call SqlFetchNext( hSqlCur,nNext )
				Call SqlExecute( hSqlCur2 )
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 )
  )
FOR EACH ROW;
alter table METANATHIST primary key (CODESYN,TMIMACODE,DATEANATH);
alter table METANATHIST foreign key METANATHESI  (CODESYN,TMIMACODE) references METANATHESI on delete restrict;


alter table METDEPMA add TMIMACODE integer ;
update METDEPMA set TMIMACODE = ;
drop index METDEPMA_IDX;
create unique index METDEPMA_IDX on METDEPMA (TMIMACODE,COURCODE,AK,AM_DEP);
update statistics on index METDEPMA_IDX;
alter table METDEPMA modify TMIMACODE not null;
alter table METDEPMA modify COURCODE not null;
alter table METDEPMA modify AK not null;
alter table METDEPMA modify AM_DEP not null;
alter table METDEPMA primary key (TMIMACODE,COURCODE,AK,AM_DEP);
alter table METDEPMA foreign key METCOURSE (COURCODE,AK,TMIMACODE) references METCOURSE on delete restrict;
alter table METDEPMA foreign key DEP (AM_DEP) references DEP on delete restrict;


alter table METEPIBLMA add TMIMACODE integer ;
update METEPIBLMA set TMIMACODE = ;
drop index METEPIBLMA_IDX;
create unique index METEPIBLMA_IDX on METEPIBLMA (TMIMACODE,COURCODE,AK,AM_DEP);
update statistics on index METEPIBLMA_IDX;
alter table METEPIBLMA modify TMIMACODE not null;
alter table METEPIBLMA modify COURCODE not null;
alter table METEPIBLMA modify AK not null;
alter table METEPIBLMA modify AM_DEP not null;
alter table METEPIBLMA primary key (TMIMACODE,COURCODE,AK,AM_DEP);
alter table METEPIBLMA foreign key METCOURSE (COURCODE,AK,TMIMACODE) references METCOURSE on delete restrict;
alter table METEPIBLMA foreign key DEP (AM_DEP) references DEP on delete restrict;


alter table METDIPLGRADE add TMIMACODE integer ;
update METDIPLGRADE set TMIMACODE = ;
drop index METDIPL_IDX;
create unique index METDIPLGRADE_IDX on METDIPLGRADE (CODESYN,TMIMACODE,DEPCODE,DATEINS);
update statistics on index METDIPLGRADE_IDX;
alter table METDIPLGRADE modify CODESYN not null;
alter table METDIPLGRADE modify TMIMACODE not null;
alter table METDIPLGRADE modify DEPCODE not null;
alter table METDIPLGRADE modify DATEINS not null;
alter table METDIPLGRADE primary key (CODESYN,TMIMACODE,DEPCODE,DATEINS);
alter table METDIPLGRADE foreign key DEP (DEPCODE) references DEP on delete restrict;
alter table METDIPLGRADE foreign key METANATHESI (CODESYN,TMIMACODE) references METANATHESI on delete restrict;


alter table METTEACH add TMIMACODE integer ;
update METTEACH set TMIMACODE = ;
drop index METTEACH_IDX;
create unique index METTEACH_IDX on METTEACH (MITROO,TMIMACODE,PROGCODE,K_M,EJ,AK);
update statistics on index METTEACH_IDX;
alter table METTEACH modify MITROO not null;
alter table METTEACH modify TMIMACODE not null;
alter table METTEACH modify PROGCODE not null;
alter table METTEACH modify K_M not null;
alter table METTEACH modify EJ not null;
alter table METTEACH modify AK not null;
alter table METTEACH primary key(MITROO,TMIMACODE,PROGCODE,K_M,EJ,AK);
alter table METTEACH foreign key METSTUPROG (MITROO,TMIMACODE,PROGCODE) references METSTUPROG on delete restrict;
