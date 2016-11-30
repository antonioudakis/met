 
SELECTS ;
SELECT 'GRANT SELECT ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%'   )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   )
UNION
SELECT 'GRANT SELECT ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
 and ( name like '%_IST'  or  name  like '%WEB%' )
AND NAME NOT LIKE '%_PROS' 
 AND NAME NOT LIKE 'WEBAIT_DIL'  
 AND NAME NOT LIKE 'WEBAIT_EGR'   ;

INSERTS ;
SELECT 'GRANT INSERT ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%'   )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   );

UPDATES ;
SELECT 'GRANT UPDATE ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%'   )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   );

DELETES ;
SELECT 'GRANT DELETE ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%'   )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   );


** OLA SE ENA SELECT **  ME UNION ** ;
SELECT 'GRANT SELECT ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%'   )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   )
UNION
SELECT 'GRANT SELECT ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
 and ( name like '%_IST'  or  name  like '%WEB%' )
AND NAME NOT LIKE '%_PROS' 
 AND NAME NOT LIKE 'WEBAIT_DIL'  
 AND NAME NOT LIKE 'WEBAIT_EGR'   
UNION
SELECT 'GRANT INSERT ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%'   )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   )
UNION
SELECT 'GRANT UPDATE ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%'   )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   )
UNION
SELECT 'GRANT DELETE ON SYSADM.' ||''||NAME||''|| ' TO stefania ;'  FROM SYSTABLES WHERE CREATOR = 'SYSADM' 
and ( name not like 'SYS%' 
 and name NOT like '%_IST' 
AND  name NOT  like '%WEB%'   )
OR ( NAME LIKE '%_PROS' 
OR NAME LIKE 'WEBAIT_DIL'  
 OR NAME LIKE 'WEBAIT_EGR'   );
