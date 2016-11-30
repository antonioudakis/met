alter table metegr add seqno smallint;
store seqno_metegr
PROCEDURE: SEQNO_METEGR
		PARAMETERS
			Receive Number : SEQNO
			Receive String : sMitroo
		LOCAL VARIABLES
			SQL HANDLE: hSqlCur
			SQL HANDLE: hSqlCur2
			Number: nFetch
			Number: nTmimacode
			Number: nTmimacode1
			Number: nProgcode
			Number: nProgcode1
			String: sMitroo1
			Number: nAk
			String: sPeriod
   			Date/Time: dDateegr
     			Number: nStart
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCur )
				Call SqlConnect( hSqlCur2 )
				Set SEQNO = 0
   				Set nStart = 0
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
				Call SqlPrepare(hSqlCur, 'SELECT tmimacode,progcode,mitroo,ak,period,dateegr FROM METEGR order by tmimacode, progcode, mitroo, ak,period INTO :nTmimacode,:nProgcode,:sMitroo,:nAk,:sPeriod,:dDateegr' )
			On Procedure Execute
				Call SqlExecute( hSqlCur )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
			On Procedure Fetch
				If nStart = 0
  					Set nStart = 1
					If NOT SqlFetchNext( hSqlCur,nFetch )
						Return 1
					Else
						Set  SEQNO =  SEQNO+ 1
						If sPeriod =''
							Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE metegr SET seqno  = :SEQNO  WHERE tmimacode=:nTmimacode  AND progcode=:nProgcode AND mitroo = :sMitroo AND (ak = :nAk or ak is null) AND period is null AND (dateegr =:dDateegr or dateegr is null)' )
						Else
							Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE metegr SET seqno  = :SEQNO  WHERE tmimacode=:nTmimacode  AND progcode=:nProgcode AND mitroo = :sMitroo AND (ak = :nAk or ak is null) AND period = :sPeriod AND (dateegr =:dDateegr or dateegr is null)' )
						Return 0
				Else
					Set nTmimacode1=nTmimacode
 					Set nProgcode1=nProgcode
					Set sMitroo1=sMitroo
					If NOT SqlFetchNext( hSqlCur,nFetch )
						Return 1
					Else
						If nTmimacode = nTmimacode1 and nProgcode=nProgcode1 and sMitroo=sMitroo1
							Set  SEQNO =  SEQNO+ 1
						Else
							Set  SEQNO = 1
						If sPeriod = ''
							Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE metegr SET seqno  = :SEQNO  WHERE tmimacode=:nTmimacode  AND progcode=:nProgcode AND mitroo = :sMitroo AND (ak = :nAk or ak is null) AND period is null AND (dateegr =:dDateegr or dateegr is null)' )
						Else
							Call SqlPrepareAndExecute(hSqlCur2, 'UPDATE metegr SET seqno  = :SEQNO  WHERE tmimacode=:nTmimacode  AND progcode=:nProgcode AND mitroo = :sMitroo AND (ak = :nAk or ak is null) AND period = :sPeriod AND (dateegr =:dDateegr or dateegr is null)' )
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCur )
				Call SqlDisconnect( hSqlCur2 );

execute seqno_metegr
\
,,,
/

erase seqno_metegr;

drop index SYSADM."metegr_idx";
alter table metegr modify tmimacode not null, progcode not null, mitroo not null, seqno not null, ak null, period null;
create unique index metegr_idx on metegr (tmimacode,progcode,mitroo,seqno);
update statistics on index metegr_idx;

