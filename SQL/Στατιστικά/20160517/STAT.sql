ENARXEOS;

SELECT SEX, COUNT(MET.MITROO)
 FROM MET,METSTUPROG
 WHERE METSTUPROG.PROGCODE=3
 AND METSTUPROG.AK <=:1
 AND MET.MITROO = METSTUPROG.MITROO
 AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG >  '01-SEP-'||@string(:1-1,0) )  AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE  PROGCODE = 3 AND DATEAPO <=  '01-SEP-'||@string(:1-1,0) AND DATEEOS IS NULL)  GROUP BY 1;

SELECT SEX, MET.MITROO,METSTUPROG.AK
 FROM MET,METSTUPROG
 WHERE METSTUPROG.PROGCODE=3
 AND METSTUPROG.AK <=:1
 AND MET.MITROO = METSTUPROG.MITROO
 AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG >  '01-SEP-'||@string(:1-1,0) )  AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE  PROGCODE = 3 AND DATEAPO <=  '01-SEP-'||@string(:1-1,0) AND DATEEOS IS NULL)  ORDER BY SEX,AK DESC ;

LIXEOS;
SELECT SEX, COUNT(MET.MITROO)
 FROM MET,METSTUPROG
 WHERE METSTUPROG.PROGCODE=3
 AND METSTUPROG.AK <=:1
 AND MET.MITROO = METSTUPROG.MITROO
 AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG >  '01-SEP-'||@string(:1,0) )  AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE  PROGCODE = 3 AND DATEAPO <=  '01-SEP-'||@string(:1,0) AND DATEEOS IS NULL)  GROUP BY 1;

EGGEGRAMENOI;
SELECT SEX,PERIOD,COUNT(MET.MITROO)
FROM MET,METEGR,METSTUPROG
WHERE METEGR.PROGCODE = 3
AND METSTUPROG.AK <=:1
AND MET.MITROO= METEGR.MITROO
AND MET.MITROO = METSTUPROG.MITROO
AND METEGR.PROGCODE = METSTUPROG.PROGCODE
AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG >  '01-SEP-'||@string(:1-1,0) )  AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE  PROGCODE = 3 AND DATEAPO <=  '01-SEP-'||@string(:1-1,0) AND DATEEOS IS NULL) 
GROUP BY 1,2
ORDER BY 1,2;

