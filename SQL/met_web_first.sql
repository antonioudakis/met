INSERT INTO MET_WEB	SELECT 'i',SYSDATETIME, MITROO, TMIMACODE, AR_T, EPVN,ONOMA,PATR, MHTR, SEX, YPHK, COORIG,NOMOSORIG, POLIORIG, BIRTHDATE, NOMOSMHTR,
                                                        POLIMHTR,DIMOTOLOGIO, COKAT, NOMOSKAT, POLIKAT, PERIOXI,ODOS, TT, TEL1, TEL2, EMAIL, MET_SEQNO FROM MET;
 
INSERT INTO METKARTL_WEB SELECT 'i',SYSDATETIME, MITROO,PROGCODE,AK, PERIOD,COURCODE, TMIMACODE, TYPOS,GRADENOR,GRADEPAN, APALAG, PERIODANIKI, METKARTL_SEQNO FROM METKARTL;

INSERT INTO METANATHESI_WEB SELECT 'i',SYSDATETIME,CODESYN,DATEANATH, TMIMACODE,MITROO,DATEANAG, METANATHESI_SEQNO FROM METANATHESI;

INSERT INTO METSTUPROG_WEB SELECT 'i',SYSDATETIME,MITROO,PROGCODE, METSTUPROG_SEQNO FROM METSTUPROG;
