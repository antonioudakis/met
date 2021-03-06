CREATE TABLE METANATHIST (CODESYN REAL NOT NULL,TMIMACODE INTEGER NOT NULL,DATEANATH DATE NOT NULL, THEMA VARCHAR(250), TITLOSMAU VARCHAR(250) );

SELECT CODESYN||TMIMACODE||DATEANATH FROM METANATHESI GROUP BY 1 HAVING COUNT(CODESYN||TMIMACODE||DATEANATH) >1;

INSERT INTO METANATHIST SELECT CODESYN,TMIMACODE,DATEANATH,THEMA,TITLOSMAU FROM METANATHESI;

CREATE TABLE METANATHESI_TMP1 (CODESYN REAL,TMIMACODE INTEGER,DATEINS DATE, DATEEJET DATE, DATEANATH DATE, THEMA VARCHAR(250), TITLOSMAU VARCHAR(250));

INSERT INTO METANATHESI_TMP1 SELECT CODESYN,TMIMACODE,DATEINS,DATEEJET,DATEANATH,THEMA,TITLOSMAU FROM METANATHESI;

CREATE TABLE METANATHESI_TMP2 (CODESYN REAL,TMIMACODE INTEGER, DATEANATH DATE,DATEINS DATE);

INSERT INTO METANATHESI_TMP2 SELECT CODESYN,TMIMACODE,MAX(DATEANATH),MIN(DATEINS) FROM METANATHESI GROUP BY 1,2;

UNLOAD SQL Cl\BACKUP\METANATHESI.SQL METANATHESI;

DELETE FROM METANATHESI;

'GIA NA DO TIN SEIRA TON KOLONON;

SELECT * FROM METANATHESI;

DROP TRIGGER METANATHESI_DEL;
DROP TRIGGER METANATHESI_INS;
DROP TRIGGER METANATHESI_UPDT;
DROP TRIGGER METANATHESI_INS_SN;

ALTER TABLE METANATHESI DROP METANATHESI_SEQNO;
ALTER TABLE METANATHESI DROP SEQNO;
ALTER TABLE METANATHESI DROP MITROO;
ALTER TABLE METANATHESI DROP PROGCODE;
ALTER TABLE METANATHESI DROP DATEANAG;

INSERT INTO METANATHESI SELECT METANATHESI_TMP2.CODESYN,METANATHESI_TMP2.DATEINS,METANATHESI_TMP2.TMIMACODE,METANATHESI_TMP2.DATEANATH,
METANATHESI_TMP1.DATEEJET,METANATHESI_TMP1.THEMA,METANATHESI_TMP1.TITLOSMAU
FROM METANATHESI_TMP1,METANATHESI_TMP2 
WHERE METANATHESI_TMP1.CODESYN = METANATHESI_TMP2.CODESYN AND METANATHESI_TMP1.TMIMACODE = METANATHESI_TMP2.TMIMACODE 
AND METANATHESI_TMP1.DATEANATH = METANATHESI_TMP2. DATEANATH;

DROP TABLE METANATHESI_TMP1;
DROP TABLE METANATHESI_TMP2;

SELECT * FROM METANATHESI ORDER BY CODESYN;
SELECT * FROM METANATHIST ORDER BY CODESYN;

DROP INDEX METANATHE_IDX;

ALTER TABLE METANATHESI MODIFY DATEANATH NOT NULL;

CREATE UNIQUE INDEX METANATHE_IDX ON METANATHESI(CODESYN,TMIMACODE); 

UPDATE STATISTICS ON INDEX METANATHE_IDX;

CREATE UNIQUE INDEX METANATHIST_IDX ON METANATHIST(CODESYN,TMIMACODE,DATEANATH);

UPDATE STATISTICS ON INDEX METANATHIST_IDX;

CREATE TRIGGER SYSADM.METANATHIST_INS AFTER INSERT ON METANATHIST
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

CREATE TRIGGER SYSADM.METANATHIST_DEL AFTER DELETE ON METANATHIST
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

CREATE TRIGGER SYSADM.METANATHIST_UPDT AFTER UPDATE ON METANATHIST
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









