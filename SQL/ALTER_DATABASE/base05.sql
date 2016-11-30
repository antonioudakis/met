;
;
;===========================METUNIV===============================;
;
drop index METUNI_IDX;
create unique index METUNIV_IDX on    METUNIV (UNIVCODE);
update statistics on index METUNIV_IDX;
alter table METUNIV modify UNIVCODE not null;
alter table METUNIV modify TITLOS not null;
alter table  METUNIV primary key (UNIVCODE);
insert into METUNIV (univcode,titlos) values (2,'ΕΘΝΙΚΟ ΚΑΙ ΚΑΠΟΔΙΣΤΡΙΑΚΟ ΠΑΝΕΠΙΣΤΗΜΙΟ ΑΘΗΝΩΝ');
insert into METUNIV (univcode,titlos) values (3,'ΟΙΚΟΝΟΜΙΚΟ ΠΑΝΕΠΙΣΤΗΜΙΟ ΑΘΗΝΩΝ (Α.Σ.Ο.Ε.Ε)');
insert into METUNIV (univcode,titlos) values (4,'ΟΙΚΟΝΟΜΙΚΟ ΠΑΝΕΠΙΣΤΗΜΙΟ ΠΕΙΡΑΙΑ');
insert into METUNIV (univcode,titlos) values (5,'ΕΚΕΦΕ ΔΗΜΟΚΡΙΤΟΣ');

drop index DEP_IDX;
alter table DEP modify AM_DEP not null;
create unique index DEP_IDX on DEP (AM_DEP);
update statistics on index DEP_IDX;
alter table DEP primary key (AM_DEP);

alter table METUNIV foreign key (AM_PRYT) references DEP;
alter table METUNIV foreign key (AM_ANT1) references DEP;
alter table METUNIV foreign key (AM_ANT2) references DEP;
alter table METUNIV foreign key (AM_GRAM) references DEP;







;=============================DEP==================================;
;
; SOS Τον πίνακα DEP δεν θα τον πειράξουμε γιατί είναι κοινός με το προπτυχιακό ;
;
alter table DEP modify EPVN not null;
alter table DEP modify ONOMA not null;

drop index TMHMA_IDX;
alter table TMHMA modify K_TM not null;
create unique index TMHMA_IDX on TMHMA (K_TM);

alter table TMHMA primary key (K_TM);

alter table DEP foreign key (K_TMPAR) references TMHMA;

;-------------------------------------------------------ERROR------------------------------------------------------------------;

select * from TMHMA;
insert into TMHMA (K_TM,TITLOS) values (2,'ΜΗΧΑΝΟΛΟΓΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into TMHMA (K_TM,TITLOS) values (4,'ΑΡΧΙΤΕΚΤΟΝΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into TMHMA (K_TM,TITLOS) values (6,'ΑΓΡΟΝΟΜΩΝ & ΤΟΠΟΓΡΑΓΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into TMHMA (K_TM,TITLOS) values (8,'ΝΑΥΠΗΓΩΝ ΜΗΧΑΝΟΛΟΓΩΝ ΜΗΧΑΝΙΚΩΝ');

;----------------------------------------------------ERROR OK--------------------------------------------------------------;






;============================YPAL==================================;
drop index YPAL_IDX;
alter table YPAL modify K_YPAL not null;
create unique index YPAL_IDX on   YPAL (K_YPAL);
update statistics on index YPAL_IDX;
alter table YPAL primary key (K_YPAL);
;
;
; SOS Τον πίνακα YPAL δεν θα τον πειράξουμε γιατί είναι κοινός με το προπτυχιακό ;
;

alter table YPAL modify K_TM not null;

;-------------------------------------------------------ERROR------------------------------------------------------------------;

select * from YPAL where K_TM is null;
update YPAL set K_TM = 5 where K_TM is null;

;----------------------------------------------------ERROR OK--------------------------------------------------------------;


alter table YPAL modify EPVN not null;

alter table YPAL foreign key  (K_TM) references TMHMA;






;=============================METTMIMA============================;

drop index METTMIMA_IDX;
alter table METTMIMA modify TMIMACODE not null;
create unique index METTMIMA_IDX on METTMIMA (TMIMACODE);
update statistics on index METTMIMA_IDX;

alter table METTMIMA modify TITLOS not null;
alter table METTMIMA modify UNIVCODE not null;

alter table METTMIMA primary key (TMIMACODE);
alter table METTMIMA foreign key METUNIV (UNIVCODE) references METUNIV;
alter table METTMIMA foreign key (AM_PRO) references DEP;
alter table METTMIMA foreign key (AM_ANPRO) references DEP;
alter table METTMIMA foreign key (AM_GRAM) references YPAL;
alter table METTMIMA foreign key (AM_ANGRAM) references YPAL;






;================================MET===============================;

drop index MET_IDX;
create unique index MET_IDX on MET (MITROO);
update statistics on index MET_IDX;
drop trigger MET_DEL;
drop trigger MET_INS;
drop trigger MET_UPDT;
drop trigger MET_INS_SN;
alter table MET modify MITROO not null;
alter table MET modify TMIMACODE not null;
alter table MET modify EPVN not null;
alter table MET drop XU;
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
alter table MET primary key (MITROO);
alter table MET foreign key METTMIMA (TMIMACODE) references METTMIMA;






;===========================METLANG================================;

drop index METLANG_IDX;
alter table METLANG modify MITROO not null;
alter table METLANG modify SEQNO not null;
create unique index METLANG_IDX on METLANG (MITROO,SEQNO);
update statistics on index METLANG_IDX;

alter table METLANG modify LANGCODE not null;

;-------------------------------------------------------ERROR------------------------------------------------------------------;

select * from METLANG where LANGCODE is null;
delete from METLANG where LANGCODE is null;

;----------------------------------------------------ERROR OK--------------------------------------------------------------;

alter table METLANG drop TMIMACODE;
alter table METLANG primary key (MITROO,SEQNO);
alter table METLANG foreign key MET (MITROO) references MET;
insert into PLTAB values ('LANGCODE',1,'G',NULL,'Αγγλικά');
insert into PLTAB values ('LANGCODE',2,'G',NULL,'Γαλλικά');
insert into PLTAB values ('LANGCODE',3,'G',NULL,'Γερμανικά');
insert into PLTAB values ('LANGCODE',4,'G',NULL,'Ιταλικά');
insert into PLTAB values ('LANGCODE',5,'G',NULL,'Ισπανικά');





;============================METPTYX===============================;
drop index METPTYX_IDX;
create unique index METPTYX_IDX on METPTYX (MITROO,SEQNO);
update statistics on index METPTYX_IDX;
alter table METPTYX modify MITROO not null;
alter table METPTYX modify SEQNO not null;
;
; SOS Να ερωτηθεί πρώτα η γραμματεία για την επόμενη διαγραφή;
;
delete  from METPTYX where IDRYMA is null and EIDIKOTHTA is null;
;

alter table METPTYX drop TMIMACODE;
alter table METPTYX primary key (MITROO,SEQNO);
alter table METPTYX foreign key MET (MITROO) references MET;




;=======================METPROGRAM==================================;

drop index METPROG_IDX;
create unique index METPROGRAM_IDX on METPROGRAM (TMIMACODE,PROGCODE);
update statistics on index METPROGRAM_IDX;
alter table METPROGRAM modify PROGCODE not null;
alter table METPROGRAM modify TMIMACODE not null;
alter table METPROGRAM modify TITLOS not null;
alter table METPROGRAM drop LIMIT;
alter table METPROGRAM drop WDIPL;
alter table METPROGRAM drop ARCOURDIPL;
alter table METPROGRAM drop LIMITDIPL;
alter table METPROGRAM drop ROUNDMO;

alter table METPROGRAM primary key (TMIMACODE,PROGCODE);
alter table METPROGRAM foreign key METTMIMA (TMIMACODE) references METTMIMA;
alter table METPROGRAM foreign key (AM_DEP) references DEP;
alter table METPROGRAM foreign key (AM_AN_DEP) references DEP;




'================================METPROGAT=========================;

drop index METPROGAT_IDX;
create unique index METPROGAT_IDX on METPROGAT (TMIMACODE,PROGCODE,AK);
update statistics on index METPROGAT_IDX;
alter table METPROGAT modify TMIMACODE not null;
alter table METPROGAT modify PROGCODE not null;
alter table METPROGAT modify AK not null;

alter table METPROGAT primary key (TMIMACODE,PROGCODE,AK);
alter table METPROGAT foreign key  METPROGRAM (TMIMACODE,PROGCODE) references METPROGRAM;




;=============================METPROCORP=============================;

drop index METPROCORP_IDX;
create unique index METPROCORP_IDX on METPROCORP (TMIMACODE,PROGCODE,CORPCODE);
update statistics on index METPROCORP_IDX;
alter table METPROCORP modify TMIMACODE not null;
alter table METPROCORP modify PROGCODE not null;
alter table METPROCORP modify CORPCODE not null;
alter table METPROCORP primary key (TMIMACODE,PROGCODE,CORPCODE);
alter table METPROCORP foreign key  METPROGRAM (TMIMACODE,PROGCODE) references METPROGRAM;
alter table METPROCORP foreign key  UNIVCODE (UNIVCODE) references METUNIV;
alter table METPROCORP foreign key  METTMIMA (CORPCODE) references METTMIMA;





;============================METKAT====================================;

drop index METKAT_IDX;
create unique index METKATEF_IDX on  METKATEF (TMIMACODE,PROGCODE,KAT);
update statistics on index METKATEF_IDX;

alter table  METKATEF modify KAT not null;
alter table  METKATEF modify PROGCODE not null;
alter table METKATEF modify TMIMACODE not null;
alter table  METKATEF modify TITLOS not null;
alter table  METKATEF primary key (TMIMACODE,PROGCODE,KAT);
alter table  METKATEF foreign key METPROGRAM (TMIMACODE,PROGCODE) references METPROGRAM;
alter table METKATEF foreign key (DEPCODE) references DEP;





;============================METTOMEIS==================================;

drop index METTOMEIS_IDX;
create unique index METTOMEIS_IDX on  METTOMEIS (TOMCODE);
update statistics on index METTOMEIS_IDX;
alter table  METTOMEIS modify TOMCODE not null;
alter table  METTOMEIS modify TMIMACODE not null;
alter table  METTOMEIS modify TITLOS not null;
alter table  METTOMEIS drop UNIVCODE;
ALTER TABLE METTOMEIS DROP PRIMARY KEY;
alter table  METTOMEIS primary key (TOMCODE);
alter table  METTOMEIS foreign key METTMIMA (TMIMACODE) references METTMIMA;




;=============================METSTUPROG=================================;

drop index METSTUPROG_IDX;
alter table METSTUPROG add TMIMACODE integer;
update METSTUPROG set TMIMACODE = 5;
drop trigger METSTUPROG_INS_SN;
drop trigger METSTUPROG_INS;
drop trigger METSTUPROG_DEL;
drop trigger METSTUPROG_UPDT;
alter table METSTUPROG modify TMIMACODE not null;
create unique index METSTUPROG_IDX on  METSTUPROG (TMIMACODE,PROGCODE,MITROO);
update statistics on index METSTUPROG_IDX;
alter table METSTUPROG modify MITROO not null;
alter table METSTUPROG modify PROGCODE not null;
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
 ( EXECUTE INLINE 	( METSTUPROG.MITROO,METSTUPROG.PROGCODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
  PROCEDURE: STUPROG_INS_PROC STATIC
  PARAMETERS
      String        : sMITROO
      Number     : nPROGCODE
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
      Call SqlPrepare( hSql , 'INSERT INTO METSTUPROG_WEB(MODIFTYPE,DATEMODIF,MITROO,PROGCODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
       					  VALUES(:MOD_TYPE,SYSDATETIME,:sMITROO,:nPROGCODE, :nTOTBAU,:dDateAnag,:nMETSTUPROG_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger METSTUPROG_DEL after delete on METSTUPROG
 ( EXECUTE INLINE 	( METSTUPROG.MITROO,METSTUPROG.PROGCODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
  PROCEDURE: STUPROG_DEL_PROC STATIC
  PARAMETERS
      String        : sMITROO
      Number     : nPROGCODE
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
      Call SqlPrepare( hSql , 'INSERT INTO METSTUPROG_WEB( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
       					  VALUES (:MOD_TYPE,SYSDATETIME,:sMITROO,:nPROGCODE, :nTOTBAU,:dDateAnag,:nMETSTUPROG_SEQNO)' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger METSTUPROG_UPDT after update on METSTUPROG referencing OLD as OLD_METSTUPROG NEW as NEW_METSTUPROG
 ( EXECUTE INLINE 	( MITROO,PROGCODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
  PROCEDURE: STUPROG_UPDT_PROC STATIC
  PARAMETERS
      String        : sMITROO
      Number     : nPROGCODE
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
        Call SqlPrepare( hSql , 'INSERT INTO METSTUPROG_WEB( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,TOTBAU,DATEANAG,METSTUPROG_SEQNO)
       					  VALUES	(:MOD_TYPE,SYSDATETIME,:sMITROO,:nPROGCODE, :nTOTBAU,:dDateAnag,:nMETSTUPROG_SEQNO)' )
        Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
alter table  METSTUPROG primary key (TMIMACODE,PROGCODE,MITROO);
alter table  METSTUPROG foreign key METPROGRAM (TMIMACODE,PROGCODE) references METPROGRAM;
alter table  METSTUPROG foreign key MET (MITROO) references MET; 
alter table  METSTUPROG foreign key DEP (DEPCODE) references DEP;

;--------------------------------------------------------------ERROR---------------------------------------------------------------------;

select MITROO from METSTUPROG where MITROO not in (select MITROO from MET);
;
; SOS Ζητάω άδεια για να διαγράψω τους ανύπαρκτους φοιτητές;
;
delete from METSTUPROG  where MITROO not in (select MITROO from MET);

;----------------------------------------------------------ERROR OK--------------------------------------------------------------------
;

ALTER TABLE METSTUPROG ADD KATMIMACODE integer;
ALTER TABLE METSTUPROG ADD KATPROGCODE integer;

update METSTUPROG set KATMIMACODE = TMIMACODE where KAT is not null;
update METSTUPROG set KATPROGCODE = PROGCODE where KAT is not null;

alter table  METSTUPROG foreign key METKATEF (KATMIMACODE,KATPROGCODE,KAT) references METKATEF;
alter table  METSTUPROG foreign key  METTOMEIS (TOMCODE) references METTOMEIS; 







;================================METEGR===================================;

drop index METEGR_IDX;
create unique index METEGR_IDX on METEGR (TMIMACODE,PROGCODE,MITROO,SEQNO);
update statistics on index METEGR_IDX;
alter table METEGR modify TMIMACODE not null;
alter table METEGR modify PROGCODE not null;
alter table METEGR modify MITROO not null;
alter table METEGR modify SEQNO not null;
alter table METEGR modify AK not null;
alter table METEGR modify PERIOD not null;
alter table METEGR primary key (TMIMACODE,PROGCODE,MITROO,SEQNO);
alter table METEGR foreign key METSTUPROG (TMIMACODE,PROGCODE,MITROO) references METSTUPROG;




;===============================METPROOD=================================;

drop index METPROOD_IDX;
alter table METPROOD add TMIMACODE INTEGER;
update METPROOD set TMIMACODE= 5;
create unique index METPROOD_IDX on METPROOD (TMIMACODE,PROGCODE,MITROO,DATEPROD);

;-----------------------------------------------------------------------ERROR------------------------------------------------------------------;

select tmimacode||'&'||progcode||'&'||mitroo||'&'||dateprod from metprood group by 1 having count (tmimacode||'&'||progcode||'&'||mitroo||'&'||dateprod)>1;
select * from METPROOD where DATEPROD is null and XARAKTHRISM is null;
delete from METPROOD where DATEPROD is null and XARAKTHRISM is null;
select * from METPROOD where DATEPROD is null;
select * from METPROOD where XARAKTHRISM is null;
update METPROOD set XARAKTHRISM = 2 where XARAKTHRISM is null;

;----------------------------------------------------------------------ERROR OK-------------------------------------------------------------;

update statistics on index METPROOD_IDX;
alter table METPROOD modify PROGCODE not null;
alter table METPROOD modify TMIMACODE not null;
alter table METPROOD modify MITROO not null;
alter table METPROOD modify DATEPROD not null;
alter table METPROOD modify XARAKTHRISM not null;
alter table METPROOD drop SEQNO;
alter table METPROOD primary key (TMIMACODE,PROGCODE,MITROO,DATEPROD);
alter table METPROOD foreign key METSTUPROG (TMIMACODE,PROGCODE,MITROO) references METSTUPROG;




;=================================METDIAKOP==============================;


drop index METDIAKOP_IDX;
alter table METDIAKOP add TMIMACODE integer;
update METDIAKOP set TMIMACODE = 5;
create unique index METDIAKOP_IDX on METDIAKOP (TMIMACODE,PROGCODE,MITROO,DATEAPO);
update statistics on index METDIAKOP_IDX;
alter table METDIAKOP modify TMIMACODE not null;
alter table METDIAKOP modify MITROO not null;
alter table METDIAKOP modify PROGCODE not null;
alter table METDIAKOP modify DATEAPO not null;

;------------------------------------------------------------------ERROR---------------------------------------------------------------------;

select * from METDIAKOP where DATEAPO is null;
alter table METDIAKOP DROP SEQNO;
select * from METDIAKOP where DATEAPO is null;
;
; SOS Ερώτηση στην γραμματεία;
;
delete from METDIAKOP where DATEAPO is null;

;----------------------------------------------------------------ERROR OK--------------------------------------------------------------;
;
alter table METDIAKOP primary key (TMIMACODE,PROGCODE,MITROO,DATEAPO);
alter table METDIAKOP foreign key METSTUPROG(TMIMACODE,PROGCODE,MITROO) references METSTUPROG;





;============================METXRHMA==================================;

drop index METXRHMA_IDX;
alter table METXRHMA add TMIMACODE integer;
update METXRHMA set TMIMACODE = 5;
create unique index METXRHMA_IDX on METXRHMA (TMIMACODE,PROGCODE,MITROO,DATEAPO);

;--------------------------------------------------------ERROR----------------------------------------------------------------------------;

SELECT  TMIMACODE||'&'||PROGCODE||'&'||MITROO||'&'||DATEAPO from METXRHMA group by 1 having count(TMIMACODE||'&'||PROGCODE||'&'||MITROO||'&'||DATEAPO) >1;
select * from METXRHMA where dateapo is null;
;
; SOS Ερώτηση στην γραμματεία;
;
delete from METXRHMA where DATEAPO is null;

;----------------------------------------------------ERROR OK--------------------------------------------------------------------------;

update statistics on index METXRHMA_IDX;
alter table METXRHMA modify TMIMACODE not null;
alter table METXRHMA modify MITROO not null;
alter table METXRHMA modify PROGCODE not null;
alter table METXRHMA modify DATEAPO not null;
alter table METXRHMA drop SEQNO;

alter table METXRHMA primary key (TMIMACODE,PROGCODE,MITROO,DATEAPO);
alter table METXRHMA foreign key METSTUPROG (TMIMACODE,PROGCODE,MITROO) references METSTUPROG;





;=========================METKRISI======================================;

drop index METKRISI_IDX;
create unique index METKRISI_IDX on METKRISI(TMIMACODE,PROGCODE,MITROO,DATEKRISI);
update statistics on index METKRISI_IDX;
alter table METKRISI modify MITROO not null;
alter table METKRISI modify PROGCODE not null;
alter table METKRISI modify DATEKRISI not null;
alter table METKRISI modify XARAKTHRISM not null;
alter table METKRISI modify TMIMACODE not null;

alter table METKRISI primary key (TMIMACODE,PROGCODE,MITROO,DATEKRISI);
alter table METKRISI foreign key METSTUPROG (TMIMACODE,PROGCODE,MITROO) references METSTUPROG;




;========================METKRISIDEP====================================;


drop index METKRISIDEP_IDX;
create unique index METKRISIDEP_IDX on METKRISIDEP(TMIMACODE,PROGCODE,MITROO,AM_DEP);
update statistics on index METKRISIDEP_IDX;
alter table METKRISIDEP modify MITROO not null;
alter table METKRISIDEP modify PROGCODE not null;
alter table METKRISIDEP modify AM_DEP not null;
alter table METKRISIDEP modify TMIMACODE not null;
alter table METKRISIDEP drop primary key;
alter table METKRISIDEP primary key (TMIMACODE,PROGCODE,MITROO,AM_DEP);
alter table METKRISIDEP foreign key METSTUPROG (TMIMACODE,PROGCODE,MITROO) references METSTUPROG;
alter table METKRISIDEP foreign key DEP (AM_DEP) references DEP;




;===================================METTEACH==============================;

drop index METTEACH_IDX;
alter table METTEACH add TMIMACODE integer;
update METTEACH set TMIMACODE = 5;
create unique index METTEACH_IDX on METTEACH (TMIMACODE,PROGCODE,MITROO,K_M,AK,EJ);
update statistics on index METTEACH_IDX;
alter table METTEACH modify MITROO not null;
alter table METTEACH modify TMIMACODE not null;
alter table METTEACH modify PROGCODE not null;
alter table METTEACH modify K_M not null;
alter table METTEACH modify EJ not null;
alter table METTEACH modify AK not null;
alter table METTEACH primary key(TMIMACODE, PROGCODE,MITROO,K_M,AK,EJ);
alter table METTEACH foreign key METSTUPROG (TMIMACODE,PROGCODE,MITROO) references METSTUPROG;






;=================================METANATHESI===============================;

drop index METANATHE_IDX;
create unique index METANATHESI_IDX on METANATHESI (TMIMACODE,CODESYN,DATEANATH);
update statistics on index METANATHESI_IDX;
alter table METANATHESI modify CODESYN not null;
alter table METANATHESI modify TMIMACODE not null;
alter table METANATHESI modify DATEANATH not null;
alter table METANATHESI primary key (TMIMACODE,CODESYN,DATEANATH);
alter table METANATHESI foreign key METTMIMA  (TMIMACODE) references METTMIMA;





;==================================METDIPL======================================;

drop index METDIPL_IDX;
alter table METDIPLGRADE add TMIMACODE integer;
update METDIPLGRADE set TMIMACODE = 5;
create unique index METDIPLGRADE_IDX on METDIPLGRADE (TMIMACODE,CODESYN,DEPCODE,DATEINS);
update statistics on index METDIPLGRADE_IDX;
alter table METDIPLGRADE modify TMIMACODE not null;
alter table METDIPLGRADE modify CODESYN not null;
alter table METDIPLGRADE modify DEPCODE not null;
alter table METDIPLGRADE modify DATEINS not null;
alter table METDIPLGRADE modify TYPEDEP not null;
alter table METDIPLGRADE primary key (TMIMACODE,CODESYN,DEPCODE,DATEINS);
alter table METDIPLGRADE foreign key DEP (DEPCODE) references DEP;



;---------------------------------------------------------------------ERROR----------------------------------------------------------------------------;

select * from METDIPLGRADE where DEPCODE not in (select AM_DEP from DEP);
;
; SOS Ερώτηση στην γραμματεία;
;
delete from METDIPLGRADE where DEPCODE not in (select AM_DEP from DEP);

;---------------------------------------------------------------------ERROR OK----------------------------------------------------------------------;





;==============================METCOURSE======================================;

drop index METCOUR_IDX;
create unique index METCOURSE_IDX on   METCOURSE (COURCODE,AK);
update statistics on index METCOURSE_IDX;
alter table   METCOURSE modify COURCODE not null;
alter table   METCOURSE modify AK not null;
alter table   METCOURSE modify TMIMACODE not null;
alter table   METCOURSE modify TITLOS not null;
alter table   METCOURSE drop UNIVCODE;
alter table   METCOURSE primary key (COURCODE,AK);
alter table   METCOURSE foreign key METMIMA  (TMIMACODE) references METTMIMA;
alter table   METCOURSE foreign key METMIMAPAR  (TMIMACODEPAR) references METTMIMA;
alter table   METCOURSE foreign key METTOMEISPAR  (TOMCODEPAR) references METTOMEIS;




;=================================METDEPMA=========================================;

drop index METDEPMA_IDX;
create unique index METDEPMA_IDX on METDEPMA (COURCODE,AK,AM_DEP);
update statistics on index METDEPMA_IDX;
alter table METDEPMA modify COURCODE not null;
alter table METDEPMA modify AK not null;
alter table METDEPMA modify AM_DEP not null;
alter table METDEPMA primary key (COURCODE,AK,AM_DEP);
alter table METDEPMA foreign key METCOURSE (COURCODE,AK) references METCOURSE;


;----------------------------------------------------------------------ERROR-----------------------------------------------------------------------------------;

select distinct(COURCODE||AK) from METDEPMA where COURCODE||AK not in (select COURCODE||AK from METCOURSE); 
;
; SOS Ερώτηση στην γραμματεία;
;
delete from METDEPMA where COURCODE||AK not in (select COURCODE||AK from METCOURSE);

;---------------------------------------------------------------------ERROR OK------------------------------------------------------------------------------;

alter table METDEPMA foreign key DEP (AM_DEP) references DEP;





;===================================METEPIBLMA=====================================;

drop index METEPIBLMA_IDX;
create unique index METEPIBLMA_IDX on METEPIBLMA (COURCODE,AK,AM_DEP);
update statistics on index METEPIBLMA_IDX;
alter table METEPIBLMA modify COURCODE not null;
alter table METEPIBLMA modify AK not null;
alter table METEPIBLMA modify AM_DEP not null;
alter table METEPIBLMA primary key (COURCODE,AK,AM_DEP);
alter table METEPIBLMA foreign key METCOURSE (COURCODE,AK) references METCOURSE;
alter table METEPIBLMA foreign key DEP (AM_DEP) references DEP on delete restrict;





;===================================METPROSPU=====================================;

drop index METPROSPU_IDX;
create unique index METPROSPU_IDX on   METPROSPU (TMIMACODE,PROGCODE,KAT,COURCODE,AK);
update statistics on index METPROSPU_IDX;
alter table   METPROSPU modify COURCODE not null;
alter table   METPROSPU modify AK not null;
alter table   METPROSPU modify TMIMACODE not null;
alter table   METPROSPU modify PROGCODE not null;
alter table   METPROSPU modify KAT not null;
alter table   METPROSPU modify PERIOD not null;
alter table   METPROSPU modify EIDOSMA not null;
alter table   METPROSPU primary key (TMIMACODE,PROGCODE,KAT,COURCODE,AK);
alter table   METPROSPU foreign key METCOURSE  (COURCODE,AK) references METCOURSE;

;------------------------------------------------------------------------ERROR-------------------------------------------------------------------------------;

select distinct(COURCODE||AK) from METPROSPU where COURCODE||AK not in (select COURCODE||AK from METCOURSE);

;
; SOS Nα γίνει ερώτηση στην γραμματεία;

delete from METPROSPU where COURCODE||AK not in (select COURCODE||AK from METCOURSE);

;-------------------------------------------------------------------ERROR OK-------------------------------------------------------------------------------;

alter table   METPROSPU foreign key METKATEF  (TMIMACODE,PROGCODE,KAT) references METKATEF;
alter table   METPROSPU foreign key METPROGRAM  (TMIMACODE,PROGCODE) references METPROGRAM;




;==================================METKARTL======================================;

drop index METKARTL_IDX;
drop trigger METKARTL_DEL;
drop trigger METKARTL_INS;
drop trigger METKARTL_UPDT;
drop trigger METKARTL_INS_SN;
alter table   METKARTL modify MITROO not null;
alter table  METKARTL  modify TMIMACODE not null;
alter table   METKARTL modify PROGCODE not null;
alter table   METKARTL modify COURCODE not null;
alter table   METKARTL modify AK not null;
alter table   METKARTL modify PERIOD not null;
alter table   METKARTL add KAT varchar(2);
update METKARTL set KAT= (select KAT from METSTUPROG where METSTUPROG.MITROO=METKARTL.MITROO);
alter table METKARTL modify KAT not null;

create unique index METKARTL_IDX on   METKARTL (TMIMACODE,PROGCODE,KAT,COURCODE,AK,MITROO,PERIOD);
update statistics on index METKARTL_IDX;

create trigger METKARTL_INS_SN before insert on METKARTL
		   ( EXECUTE INLINE (METKARTL_SEQNO)
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
( EXECUTE INLINE ( METKARTL.MITROO, METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE,METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL_SEQNO)
  PROCEDURE: METKARTL_INS_PROC STATIC
  PARAMETERS
      String :sMITROO	
      Number : nPROGCODE
      Number : nAK
      String	 : sPERIOD
      Number : nCOURCODE
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
      Call SqlPrepare( hSql , 'INSERT INTO METKARTL_WEB  ( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,AK,PERIOD,COURCODE,TYPOS,GRADENOR,GRADEPAN,APALAG,PERIODANIKI,METKARTL_SEQNO) 
					   VALUES(:MOD_TYPE , SYSDATETIME , :sMITROO , :nPROGCODE , :nAK , :sPERIOD, :nCOURCODE, :sTYPOS , :nGRADENOR, :nGRADEPAN , :sAPALAG , :sPERIODANIKI, :nMETKARTL_SEQNO ) ' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger METKARTL_DEL  after  delete  on METKARTL
( EXECUTE INLINE ( METKARTL.MITROO,METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE,  METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL.METKARTL_SEQNO)
  PROCEDURE: METKARTL_DEL_PROC STATIC
  PARAMETERS
      String :sMITROO	
      Number : nPROGCODE
      Number : nAK
      String	 : sPERIOD
      Number : nCOURCODE
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
      Call SqlPrepare( hSql , 'INSERT INTO METKARTL_WEB  ( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,AK,PERIOD,COURCODE,TYPOS,GRADENOR,GRADEPAN,APALAG,PERIODANIKI,METKARTL_SEQNO) 
					   VALUES(:MOD_TYPE , SYSDATETIME , :sMITROO ,:nPROGCODE , :nAK , :sPERIOD, :nCOURCODE ,:sTYPOS , :nGRADENOR, :nGRADEPAN , :sAPALAG , :sPERIODANIKI, :nMETKARTL_SEQNO ) ' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;
create trigger METKARTL_UPDT  after update  on METKARTL  referencing OLD as OLD_METKARTL NEW as NEW_METKARTL
( EXECUTE INLINE ( METKARTL.MITROO, METKARTL.PROGCODE,METKARTL.AK, METKARTL.PERIOD,METKARTL.COURCODE,METKARTL.TYPOS,METKARTL.GRADENOR, 
				METKARTL.GRADEPAN, METKARTL.APALAG, METKARTL.PERIODANIKI,METKARTL.METKARTL_SEQNO)
  PROCEDURE: METKARTL_UPDT_PROC STATIC
  PARAMETERS
      String :sMITROO	
      Number : nPROGCODE
      Number : nAK
      String	 : sPERIOD
      Number : nCOURCODE
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
      Call SqlPrepare( hSql , 'INSERT INTO METKARTL_WEB  ( MODIFTYPE,DATEMODIF,MITROO,PROGCODE,AK,PERIOD,COURCODE,TYPOS,GRADENOR,GRADEPAN,APALAG,PERIODANIKI,METKARTL_SEQNO)  
                                 VALUES(:MOD_TYPE , SYSDATETIME , :sMITROO , :nPROGCODE , :nAK , :sPERIOD, :nCOURCODE ,:sTYPOS , :nGRADENOR, :nGRADEPAN , :sAPALAG , :sPERIODANIKI, :nMETKARTL_SEQNO ) ' )
      Call SqlExecute( hSql )
    On Procedure Close
      Call SqlDisconnect( hSql )
  )
FOR EACH ROW;

alter table METKARTL primary key (TMIMACODE,PROGCODE,KAT,COURCODE,AK,MITROO,PERIOD);
alter table METKARTL foreign key METSTUPROG  (TMIMACODE,PROGCODE,MITROO) references METSTUPROG;
alter table METKARTL foreign key METPROSPU  (TMIMACODE,PROGCODE,KAT,COURCODE,AK) references METPROSPU;

;----------------------------------------------------------------------------ERROR--------------------------------------------------------------------------;

select distinct(TMIMACODE||PROGCODE||KAT||COURCODE||AK) from METKARTL WHERE TMIMACODE||PROGCODE||KAT||COURCODE||AK not in (select TMIMACODE||PROGCODE||KAT||COURCODE||AK from metprospu);
;
;SOS Να γίνει ερώτηση στην γραμματεία΄
;
delete from METKARTL WHERE TMIMACODE||PROGCODE||KAT||COURCODE||AK not in (select TMIMACODE||PROGCODE||KAT||COURCODE||AK from metprospu);

;-----------------------------------------------------------------------ERROR OK-------------------------------------------------------------------------;






;--------------------------------------------------------------------------------METDSYNERG-----------------------------------------------------------;

drop index METDSYN_IDX;
create unique index METDSYNERG_IDX on METDSYNERG (TMIMACODE,CODESYN,MITROO);
update statistics on index METDSYNERG_IDX;
alter table METDSYNERG modify TMIMACODE not null;
alter table METDSYNERG modify CODESYN not null;
alter table METDSYNERG modify MITROO not null;
alter table METDSYNERG primary key (TMIMACODE,CODESYN,MITROO);
alter table METDSYNERG foreign key METTMIMA (TMIMACODE) references METTMIMA;
alter table METDSYNERG foreign key MET (MITROO) references MET;

