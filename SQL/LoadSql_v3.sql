SET SERVER server1 ;
DROP DATABASE BASE05 ;
CREATE DATABASE BASE05 ;
SET SERVER OFF;
CONNECT BASE05 sysadm/sysadm;
SET RECOVERY OFF;
SET ERRORLEVEL 3;
LOCK DATABASE;
LOAD SQL C:\NTUARIS\BASES\BACKUP\base05_02OCT2012.uld  ON SERVER ;
COMMIT;
UPDATE STATISTICS ON DATABASE;
UNLOCK DATABASE;
SET RECOVERY ON;
DISCONNECT BASE05 ;

