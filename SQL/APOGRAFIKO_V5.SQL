@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
@@@@@@  APOGRAFIKH EREYNA PANEPISTHMIVN GIA TO PROHGOYMENO AK. ETOS @@@@@@@@@@@@;
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
@@@@@ Sta "Bind Data" bazoume to ak. etos liksis dhl: gia to 2007-2008 grafoume 2008 @@@@@@@@@@@@@@@@@@@@@;


  ....  a. XVRIS DIPLVMATOYXOYS ETOYS ANAZHTHSHS KAI PISV,
	b. XVRIS NA ELEGXETAI AN EXOYN EGGRAFH STO ETOS ANAZHTHSHS,
	c. XVRIS APOFOITOYS ETOYS ANAZHTHSHS KAI PISV,
	d. XVRIS DIAGRAFENTES ETOYS ANAZHTHSHS KAI PISV,
	e. NA EXOYN TOYLAXISTON 1 EGGRAFH,
	f.  NA EXOYN ENHMERVMENO TO ETOS A' EGGRAFHS,
	g. NA EXOYN ENHMERVMENO TO FYLO,
	h. NA EXOYN EJAMHNO PRVTHS EGRAFHS,
	i. NA EXOYN VALID EGRAFI EJAMHNOY STON EGRAFI.
	

ж1 1. PLHUOS EGGEGRAMMENVN PROPTYXIAKVN FOITHTVN KATA ETOS SPOYDVN KAI FYLO ;


select count(k_f) AS AR.FOIT , @if ( @ABS (:1+1 - st_f.ak - 10) + (:1+1 -st_f.ak-10) , '>= 11 ETH',  :1+1 -st_f.ak || ' ETH' ) AS AR.ETVN, sex As FYLO
from ST_F
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) AND ST_F.AK IS NOT NULL AND ST_F.AK <= :1 group by 2,3 order by 3 , 2 ;


ж1 2.1. STA KANONIKA EJAMHNA FOITHSHS ;

select  count(ST_F.k_f)  AS AR.FOIT, SEX AS FYLO
from  ST_F
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1)
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) and sex is not null AND ST_F.EJ IS NOT NULL

AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1 
and  ( (ST_F.AK > :1-5 and st_f.ej in ('01','02'))
        or   (ST_F.AK > :1-4 and st_f.ej in ('03','04'))
        or   (ST_F.AK > :1-3 and st_f.ej in ('05','06'))
        or   (ST_F.AK > :1-2 and st_f.ej in ('07','08'))
        or   (ST_F.AK > :1-1 and st_f.ej in ('09','10')) )
GROUP BY 2;

ж1 2.2.  PERAN TVN KANONIKVN EJAMHNVN ;

select  count(ST_F.k_f) AS AR.FOIT, SEX AS FYLO
from  st_f
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1)
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) and sex is not null AND ST_F.EJ IS NOT NULL
 AND  ST_F.AK IS NOT NULL AND ST_F.AK <= :1

and  ( (ST_F.AK <= :1-5 and st_f.ej in ('01','02'))
        or   (ST_F.AK <= :1-4 and st_f.ej in ('03','04'))
        or   (ST_F.AK <= :1-3 and st_f.ej in ('05','06'))
        or   (ST_F.AK <= :1-2 and st_f.ej in ('07','08'))
        or   (ST_F.AK <= :1-1 and st_f.ej in ('09','10')) )
GROUP BY 2 ;



ж1 3.1 FOITHTIKOS PLHTHYSMOS KATA FYLO KAI HLIKIA ( SE OLA TA ETH SPOYDVN ) ;

SELECT COUNT(K_F) AS AR.FOIT,  :1 - @MID(BIRTHDATE,0,4) AS HLIKIA, SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
GROUP BY 2,3 ORDER BY 3, 2;

** EPALHTHEYSH 3.1 **;

SELECT COUNT(K_F) AS AR.FOIT,  SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
GROUP BY 2 ORDER BY  2;


ж1 3.2 FOITHTIKOS PLHTHYSMOS KATA FYLO KAI HLIKIA (STO A ETOS SPOYDVN) ;

SELECT COUNT(K_F) AS AR.FOIT,  :1 - @MID(BIRTHDATE,0,4) AS HLIKIA, SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  AND ST_F.AK IS NOT NULL  AND ST_F.AK = :1
GROUP BY 2,3 ORDER BY 3, 2;


** EPALHTHEYSH 3.2 **;

SELECT COUNT(K_F) AS AR.FOIT,  SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafiWHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  AND ST_F.AK IS NOT NULL AND ST_F.AK = :1 
GROUP BY 2 ORDER BY  2;



ж1 4. ARITHMOS APOFOITVN KATA FYLO & HLIKIA;

select count(k_f), etosdipl-@mid(birthdate,0,4),sex  from hst_f where etosdipl = :1  group by 2,3  order by 3,2;



======================================================================================;
==========================================   ж.2   =======================================;
======================================================================================;



======================================================================================;
========================================     ж.2.1.a     =====================================;
======================================================================================;


------------------------------------------------------------------------------------------------------------;
METAPTYXIAKOS FOIT. PLHUYSMOS KATA FYLO HLIKIA KAI EPIPEDO SPOYDVN 
( M.D.E ) ,  ( OPOY :1 TO AK. ETOS APOGRAFHS KAI :2 O KVD. THS SXOLHS);
------------------------------------------------------------------------------------------------------------;

SELECT SEX, :1-@MID(BIRTHDATE,0,4),COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL 
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
GROUP BY 1,2 ORDER BY 2,1;



======================================================================================;
===============================     ELEGXOS    ж.2.1.a    ==================================;
======================================================================================;


-------------------------------------------------------------------------------------------------------------;
ENTOPIZO TOYS  METAPTYXIAKOI FOITHTES POY DEN EXOUN KATAXORHMENH HMEROMHNIA 
GENNHSHS H FYLO;
-------------------------------------------------------------------------------------------------------------;

SELECT MET.MITROO, MET.EPVN, MET.ONOMA
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2) AND (BIRTHDATE IS NULL OR SEX IS NULL)
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
ORDER BY 2,3;



======================================================================================;
======================================     ж.2.1.b     =====================================;
======================================================================================;


------------------------------------------------------------------------------------------------------------;
METAPTYXIAKOS FOIT. PLHUYSMOS KATA FYLO HLIKIA KAI EPIPEDO SPOYDVN 
		( Y.D ) ;
------------------------------------------------------------------------------------------------------------;

SELECT SEX, :1-@MID(BIRTHDATE,0,4),COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL 
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
GROUP BY 1,2 ORDER BY 1,2;



======================================================================================;
===============================     ELEGXOS    ж.2.1.b    ========================================;
======================================================================================;


-------------------------------------------------------------------------------------------------------------;
ENTOPIZO TOYS  YPOPSIFIOUS DIDAKTORES  POY DEN EXOUN KATAXORHMENH HMEROMHNIA 
GENNHSHS H FYLO;
-------------------------------------------------------------------------------------------------------------;

SELECT MET.MITROO, MET.EPVN, MET.ONOMA
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2) AND (SEX IS NULL OR BIRTHDATE IS NULL)
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
ORDER BY 2,3;



======================================================================================;
======================================      ж.2.2       ========================================;
======================================================================================;


------------------------------------------------------------------------------------------------------------;
FOITHTIKOS PLHUYSMOS Y.D. KATA ETOS SPOYDVN KAI FYLO;
------------------------------------------------------------------------------------------------------------;
		
SELECT SEX, :1-METSTUPROG.AK+1, COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
GROUP BY 1,2 ORDER BY 2,1;



======================================================================================;
======================================     ж.2.3     ========================================;
======================================================================================;


------------------------------------------------------------------------------------------------------------;
-------------------------------------------         PROSOXH      --------------------------------------------------;
------------------------------------------------------------------------------------------------------------;

GIA NA FENETAI AN EXEI ENAS FOITHTHS EXEI APOKTHSEI M.D.E. PREPEI NA EXETE 
KATAXVRHSEI STA PROSONTA TOY STO PEDIO EIDIKOTHTA OTIDHPOTE POY NA ARXIZEI ME MIA
APO TIS PARAKATV GRAMATASEIRES:

MASTER
л.д.е
лде
летаптувиайо

DEN EXEI SHMASIA AN EINAI ME MIKRA H KEFALAIA

ANTISTOIXA GIA NA FENETAI AN EXEI ENAS FOITHTHS EXEI APOKTHSEI  DIDAKTORIKA PREPEI NA EXETE 
KATAXVRHSEI STA PROSONTA TOY STO PEDIO EIDIKOTHTA OTIDHPOTE POY NA ARXIZEI ME MIA
APO TIS PARAKATV GRAMATASEIRES:

DOCTOR
дидайтояийо
дидайтыя

DEN EXEI SHMASIA AN EINAI ME MIKRA H KEFALAIA
----------------------------------------------------------------------------------------------------------------;



======================================================================================;
======================================     ж.2.3.1.a     ===================================;
======================================================================================;

-----------------------------------------------------------------------------------------------------------------;
ARIUMOS METAPTYXIAKVN FOITHTVN ME M.D.E  KATA FYLO;
----------------------------------------------------------------------------------------------------------------;

SELECT SEX, COUNT(MET.MITROO)
FROM MET,METSTUPROG, METPTYX
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO AND MET.MITROO = METPTYX.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL 
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
	AND (@UPPER(EIDIKOTHTA) LIKE 'MASTER%' OR @UPPER(EIDIKOTHTA) LIKE 'л.д.е%' OR @UPPER(EIDIKOTHTA) LIKE 'лде%' OR @UPPER(EIDIKOTHTA) LIKE 'летаптувиайо%')
GROUP BY 1;



======================================================================================;
======================================     ж.2.3.1.b     ===================================;
======================================================================================;


---------------------------------------------------------------------------------------------------------------;
ARIUMOS METAPTYXIAKVN FOITHTVN ME DIDAKTORIKO  KATA FYLO;
---------------------------------------------------------------------------------------------------------------;

SELECT SEX, COUNT(MET.MITROO)
FROM MET,METSTUPROG, METPTYX
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO AND MET.MITROO = METPTYX.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL 
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
	AND (@UPPER(EIDIKOTHTA) LIKE 'DOCTOR%' OR @UPPER(EIDIKOTHTA) LIKE 'дидайтояийо%' OR @UPPER(EIDIKOTHTA) LIKE 'дидайтыя%')
GROUP BY 1;



======================================================================================;
======================================     ж.2.3.2.a     ===================================;
======================================================================================;

------------------------------------------------------------------------------------------------------------;
ARIUMOS YPOPSIFION DIDAKTORVN ME M.D.E  KATA FYLO;
------------------------------------------------------------------------------------------------------------;

SELECT SEX, COUNT(MET.MITROO)
FROM MET,METSTUPROG, METPTYX
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO AND MET.MITROO = METPTYX.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL 
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
	AND (@UPPER(EIDIKOTHTA) LIKE 'MASTER%' OR @UPPER(EIDIKOTHTA) LIKE 'лде%' OR @UPPER(EIDIKOTHTA) LIKE 'л.д.е%' OR @UPPER(EIDIKOTHTA) LIKE 'летаптувиайо%')
GROUP BY 1;



======================================================================================;
======================================     ж.2.3.2.b     ===================================;
======================================================================================;


-----------------------------------------------------------------------------------------------------------;
ARIUMOS YPOPSIFION DIDAKTORVN ME DIDAKTORIKO  KATA FYLO;
-----------------------------------------------------------------------------------------------------------;

SELECT SEX, COUNT(MET.MITROO)
FROM MET,METSTUPROG, METPTYX
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO AND MET.MITROO = METPTYX.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL 
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
	AND (@UPPER(EIDIKOTHTA) LIKE 'DOCTOR%' OR @UPPER(EIDIKOTHTA) LIKE 'дидайтояийо%' OR @UPPER(EIDIKOTHTA) LIKE 'дидайтыя%')
GROUP BY 1;


======================================================================================;
======================================     ж.2.4     ======================================;
======================================================================================;



======================================================================================;
======================================     ж.2.4.a     =====================================;
======================================================================================;


-------------------------------------------------------------------------------------------------------------;
ARIUMOS METAPTYXIAKVN APOFOITVN KATA FYLO, HLIKIA KAI EPIPEDO SPOYDVN;
------------------------------------------------------------------------------------------------------------;

SELECT SEX, :1-@MID(BIRTHDATE,0,4),COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1
GROUP BY 1,2 ORDER BY 2,1;


======================================================================================;
===============================     ELEGXOS    ж.2.4.a    ========================================;
======================================================================================;


-------------------------------------------------------------------------------------------------------------;
ENTOPIZO TOYS APOFOITOYS METAPTYXIAKOYS  POY DEN EXOUN KATAXORHMENO FYLO;
-------------------------------------------------------------------------------------------------------------;

SELECT MET.MITROO, EPVN,ONOMA
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1
ORDER BY  2,3;


======================================================================================;
======================================     ж.2.4.b     =====================================;
======================================================================================;


------------------------------------------------------------------------------------------------------------;
ARIUMOS DIDAKTORIKVN APOFOITVN KATA FYLO, HLIKIA KAI EPIPEDO SPOYDVN;
------------------------------------------------------------------------------------------------------------;

SELECT SEX, :1-@MID(BIRTHDATE,0,4),COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1
GROUP BY 1,2 ORDER BY 2,1;



======================================================================================;
===============================     ELEGXOS    ж.2.4.b    ========================================;
======================================================================================;


-------------------------------------------------------------------------------------------------------------;
ENTOPIZO TOYS DIDAKTORES  POY DEN EXOUN KATAXORHMENO FYLO;
-------------------------------------------------------------------------------------------------------------;

SELECT MET.MITROO, EPVN,ONOMA
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1
ORDER BY 2,3;

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

ж3.1 = ж3.1_а1.1 + ж3.1_а1.2 + ж3.1_а2.1 + ж3.1_а2.2 + ж3.1_б1.1 + ж3.1_б1.2 + ж3.1_б2.1 + ж3.1_б2.2 ;


ж3.1_A1.1. ARIUMOS PROPTYXIAKVN FOITHTVN ANA YPHKOOTHTA (YPHK NOT NULL);
select  count(k_f), PLTEXT  from st_f, PLTAB 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi)  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
 AND YPHK = PLCODE AND PLCOLUMN = 'YPHK' AND YPHK IS NOT NULL
GROUP BY 2 ORDER BY 2 ;

ж3.1_A1.2. ARIUMOS PROPTYXIAKVN FOITHTVN ANA YPHKOOTHTA (YPHK NULL);

SELECT  count(k_f),  COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS from st_f 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi)  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
 AND YPHK IS NULL
group by 2,3,4,5,6,7,8,9  order by 2;


EPALHTHEYSH ( ж3.1_A1.1 +  ж3.1_A1.2 );
SELECT COUNT(K_F) AS AR.FOIT
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi)  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1;



ж3.1_A2.1. ARIUMOS PROPTYXIAKVN APOFOITVN ANA YPHKOOTHTA (YPHK NOT NULL);
select  count(k_f),PLTEXT from hst_f, PLTAB 
where etosdipl = :1 AND YPHK = PLCODE AND PLCOLUMN = 'YPHK' AND YPHK IS NOT NULL group by 2  order by 2;

ж3.1_A2.2. ARIUMOS PROPTYXIAKVN APOFOITVN ANA YPHKOOTHTA (YPHK NULL);

SELECT count(k_f), COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS  from hst_f 
where etosdipl = :1  AND YPHK IS NULL group by 2,3,4,5,6,7,8,9  order by 2;


EPALHTHEYSH ( ж3.1_A2.1 +  ж3.1_A2.2 );
select count (k_f) from hst_f where etosdipl = :1 ;



ж3.1_B1.1  ARIUMOS METAPTYXIAKVN ENERGVN ANA YPHKOOTHTA ( YPHK NOT NULL );

SELECT  COUNT(MET.MITROO), PLTEXT FROM MET,METSTUPROG, PLTAB
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO 
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2) AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
AND PLCODE = YPHK AND PLCOLUMN = 'YPHK'
GROUP BY 2 ORDER BY 2;

ж3.1_B1.2  ARIUMOS METAPTYXIAKVN ENERGVN ANA YPHKOOTHTA ( YPHK NULL ) ;
AYTO GIA NA BREITE LOIPA STOIXEIA POY MPOREI NA BOHTHISOYN STHN KATATAJH;

SELECT  COUNT(MET.MITROO), COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO 
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2) AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
AND YPHK IS NULL
GROUP BY 2,3,4,5,6,7,8,9 ORDER BY 2;

** EPALHTHEYSH ( ж3.1_B1.1 +  ж3.1_B1.2 ) ** ;
SELECT COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2) AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
;



ж3.1_B2.1  ARIUMOS METAPTYXIAKVN APOFOITVN ANA YPHKOOTHTA ( YPHK NOT NULL );

SELECT COUNT(MET.MITROO), PLTEXT  FROM MET,METSTUPROG, PLTAB
WHERE METSTUPROG.PROGCODE !=1 
	AND PLCODE = YPHK AND PLCOLUMN = 'YPHK'
	 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1
GROUP BY 2 ORDER BY 2;

ж3.1_B2.2 ARIUMOS METAPTYXIAKVN APOFOITVN ANA YPHKOOTHTA ( YPHK NULL ) ;
AYTO GIA NA BREITE LOIPA STOIXEIA POY MPOREI NA BOHTHISOYN STHN KATATAJH;

SELECT COUNT(MET.MITROO), COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL AND YPHK IS NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1
GROUP BY 2,3,4,5,6,7,8,9 ORDER BY 2;

** EPALHTHEYSH ( ж3.1_B2.1 +  ж3.1_B2.2 ) ** ;
SELECT COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1;


ж3.1 = ж3.1_а1.1 + ж3.1_а1.2 + ж3.1_а2.1 + ж3.1_а2.2 + ж3.1_б1.1 + ж3.1_б1.2 + ж3.1_б2.1 + ж3.1_б2.2 ;
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;

ж3.2 = ж3.2а1 + ж3.2а2 + ж3.2б1 + ж3.2б2;

ж3.2A1. ARIUMOS DIDAKTORVN  * ENERGVN * ANA YPHKOOTHTA ( YPHK NOT NULL )  ;

SELECT COUNT(MET.MITROO), PLTEXT FROM MET,METSTUPROG, PLTAB
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
AND PLCODE = YPHK AND PLCOLUMN = 'YPHK' 
GROUP BY 2 ORDER BY 2;


ж3.2A2 ARIUMOS DIDAKTORVN * ENERGVN * ANA YPHKOOTHTA (YPHK NULL) ;
AYTO GIA NA BREITE LOIPA STOIXEIA POY MPOREI NA BOHTHISOYN STHN KATATAJH;

SELECT COUNT(MET.MITROO), COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
AND YPHK IS NULL
GROUP BY 2,3,4,5,6,7,8,9 ORDER BY 2;

** EPALHTHEYSH ( ж3.2_A1 +  ж3.2_A2 ) ** ;
SELECT COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-'|| :1 AND DATEEOS IS NULL 
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1) ;



ж3.2B1 . ARIUMOS DIDAKTORVN APOFOITVN ANA YPHKOOTHTA ( YPHK NOT NULL )  ;

SELECTCOUNT(MET.MITROO), PLTEXT  FROM MET,METSTUPROG, PLTAB
WHERE METSTUPROG.PROGCODE =1 	
	AND PLCODE = YPHK AND PLCOLUMN = 'YPHK' 
	AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1
GROUP BY 2 ORDER BY 2;


ж3.2B2 ARIUMOS DIDAKTORVN APOFOITVN ANA YPHKOOTHTA (YPHK NULL) ;
AYTO GIA NA BREITE LOIPA STOIXEIA POY MPOREI NA BOHTHISOYN STHN KATATAJH;

SELECT  COUNT(MET.MITROO), COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL AND YPHK IS NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1
GROUP BY 2,3,4,5,6,7,8,9 ORDER BY 2;

** EPALHTHEYSH ( ж3.2_B1 +  ж3.2_B2 ) ** ;
SELECT COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1  AND MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL
	AND METSTUPROG.DATEANAG IS NOT NULL AND METSTUPROG.DATEANAG BETWEEN '01-SEP-' || (:1-1) AND '31-AUG-' || :1 ;






ж3.2 = ж3.2а1 + ж3.2а2 + ж3.2б1 + ж3.2б2 ;
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;






































