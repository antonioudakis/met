abcd to prosorino password ;

GRANT CONNECT TO VERA IDENTIFIED BY vera ;
GRANT RESOURCE TO VERA ;
INSERT INTO TREXON (K_TM, AK , XU, USERNAME) VALUES (2, 2017,1,'VERA')  ;
commit;

 @@@ ;
---- FTIAXNOYN TA SELECT ,INSERTS, UPDATES KAI DELETES OLVN TVN PINAKVN POY THA KATAXVRITHOYN DIKAIVMATA GIA TON XRHSTH ---- ;
---- ME TO POY THA TREXEIS TO KATHENA THA ANTIGRAFEIS STO PROXEIRO TO OUTPUT KAI THA TO TREXEIS APO ALLO PARATHYRO TOY SQLTALK ----- ;

SELECTS ;
SELECT 'GRANT SELECT ON SYSADM.' ||''||NAME||''|| ' TO VOUTOU ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%' 
AND NAME not LIKE 'HELP%'  )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   )
UNION
SELECT 'GRANT SELECT ON SYSADM.' ||''||NAME||''|| ' TO VOUTOU ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
 and ( name like '%_IST'  or  name  like '%WEB%' )
AND NAME NOT LIKE '%_PROS' 
 AND NAME NOT LIKE 'WEBAIT_DIL'  
 AND NAME NOT LIKE 'WEBAIT_EGR'   ;

INSERTS ;
SELECT 'GRANT INSERT ON SYSADM.' ||''||NAME||''|| ' TO VOUTOU ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%' 
AND NAME not LIKE 'HELP%'  )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   );

UPDATES ;
SELECT 'GRANT UPDATE ON SYSADM.' ||''||NAME||''|| ' TO VOUTOU ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%' 
AND NAME not LIKE 'HELP%'  )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   );

DELETES ;
SELECT 'GRANT DELETE ON SYSADM.' ||''||NAME||''|| ' TO VOUTOU ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%' 
AND NAME not LIKE 'HELP%'  )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   );



===== MONO AN THELEIS NA AFAIRESEIS DIKAIVMATA ======;

===== REVOKE OPERATION ======= ;



REVOKE RESOURCE FROM VOUTOU ;

--- FTIAXNOYN TA SELECT OLVN TVN PINAKVN POY EXOYN KATAXVRITHEI DIKAIVMATA GIA TON XRHSTH ---- ;

SELECT 'REVOKE INSERT ON SYSADM.' ||''||TTNAME||''|| ' FROM VOUTOU ;'  FROM SYSTABAUTH  WHERE TCREATOR = 'SYSADM'  AND  GRANTEE = 'VOUTOU'   AND INSERTAUTH = 'Y' ;
SELECT 'REVOKE DELETE ON SYSADM.' ||''||TTNAME||''|| ' FROM VOUTOU ;'  FROM SYSTABAUTH  WHERE TCREATOR = 'SYSADM'  AND  GRANTEE = 'VOUTOU'   AND DELETEAUTH = 'Y' ;
SELECT 'REVOKE UPDATE ON SYSADM.' ||''||TTNAME||''|| ' FROM VOUTOU ;'  FROM SYSTABAUTH  WHERE TCREATOR = 'SYSADM'  AND  GRANTEE = 'VOUTOU'   AND UPDATEAUTH = 'Y' ;



==== GIA NA DEIS TO APOTELESMA ===== ;

SELECT * from SYSUSERAUTH	 ;

SELECT * FROM SYSTABAUTH WHERE GRANTEE = 'VOUTOU' ORDER BY GRANTEE	 ;




