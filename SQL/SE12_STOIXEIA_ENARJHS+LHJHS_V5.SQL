* PROSOXH STO ZHTOYMENO AK. ETOS, GIA TA STATISTIKA ENARJHS EINAI DIAFORETIKO APO THS LHJHS *


===================================================================================;
==============  SE-12b - STOIXEIA *E N A R J H S * AK. ETOYS   ===============================;
===================================================================================;


C1a. AR. FOITHTVN POY FOITOYN SE EJAMHNA SPOYDVN KATA THN ENARJH TOY AK. ETOYS (EJ<'09');
select  EGRAFI.EJ, SEX, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'  and sex is not null   AND egrafi.EJ IS NOT NULL
and egrafi.ej<'09' 
 and  egrafi.EJ IN ( '01', '02', '03', '04','05', '06','07', '08','09','10' )GROUP BY 1 ,2 ;

C1b. AR. FOITHTVN POY FOITOYN SE EJAMHNA SPOYDVN KATA THN ENARJH TOY AK. ETOYS (EJ='09');
(PRVTOEGGEGRAMMENOI STO 9o );
select  EGRAFI.EJ, SEX, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'  and sex is not null   AND egrafi.EJ IS NOT NULL
and egrafi.ej= '09' AND ST_F.K_F NOT IN (SELECT K_F FROM EGRAFI WHERE AK < :1 AND EJ = '09'  )
 and  egrafi.EJ IN ( '01', '02', '03', '04','05', '06','07', '08','09','10' )GROUP BY 1 ,2 ;

C1c. AR. FOITHTVN POY FOITOYN SE EJAMHNA SPOYDVN KATA THN ENARJH TOY AK. ETOYS (EJ='09');
(SYNOLIKA STO 9o );
select  EGRAFI.EJ, SEX, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'  and sex is not null   AND egrafi.EJ IS NOT NULL
and egrafi.ej= '09' 
 and  egrafi.EJ IN ( '01', '02', '03', '04','05', '06','07', '08','09','10' )GROUP BY 1 ,2 ;

C1d. AR. FOITHTVN POY FOITOYN SE EJAMHNA SPOYDVN KATA THN ENARJH TOY AK. ETOYS (EJ='09');
(PERAN TVN KANONIKVN EJAMHNVN );

C1c - C1b;


 -- C2 METAPTYXIAKOI FOITHTES -- ;

===================================================================================;
FOITHTIKOS PLHTHYSMOS KATA FYLO KAI EPIPEDO SPOYDVN
PARAMETROI 	:1 TO AK. ETOS 
		:2 O KVDIKOS THS SXOLHS
===================================================================================;

select sex, metstuprog.progcode as progcode, count(metstuprog.mitroo) 
from met,metstuprog
where met.mitroo = metstuprog.mitroo and (metstuprog.dateanag  is null or metstuprog.dateanag>='01-OCT-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-OCT-'||@string(:1,0) and dateeos is null 
	and progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2
group by 2,1 order by 2,1;


FOITHTES STOYS OPOIOYS DEN EXEI KATAXVRITHEI FYLO ;
select sex, metstuprog.progcode as progcode, metstuprog.mitroo
from met,metstuprog
where met.mitroo = metstuprog.mitroo and (metstuprog.dateanag  is null or metstuprog.dateanag>='01-OCT-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-OCT-'||@string(:1,0) and dateeos is null 
	and progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2 and sex is null
order by 2,1;

FOITHTES OI OPOIOI DEN EXOYN AK. ETOS A EGGRAFHS;
select sex, metstuprog.progcode as progcode, metstuprog.mitroo
from met,metstuprog
where met.mitroo = metstuprog.mitroo and (metstuprog.dateanag  is null or metstuprog.dateanag>='01-OCT-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-OCT-'||@string(:1,0) and dateeos is null 
	and progcode = metstuprog.progcode)
	and metstuprog.ak is null and met.tmimacode = :2 
order by 2,1;



=====================================================================================
=========================== SE-12 - STOIXEIA * L H J H S * AK. ETOYS ======================== ;
=====================================================================================;

:1 AK. ETOS POY ZHTOYNTAI TA STOIXEIA

######  P R O S O X H   STA BIND DATA VAZOYME GIA TO AK. ETOS 2011-12 :   2012,1982  #######
TO 2012-13 THA AYJHSETE KATA 1 ... ;



--------------------------------------------------------------------------------
===============   D.  F O I T H T E S    ==============
-------------------------------------------------------------------------------- ;


D1. ARITHMOS FOITHTVN KATA EJAMHNO SPOYDVN, FYLO KAI ETOS GENNHSHS

(PERILAMVANONTAI OSOI EGGRAFIKAN KAI METAGGRAFHKAN APO ALLO TMHMA , 
OXI OMVS OSOI PHRAN METEGGRAFH SE ALLO TMHMA)

						( EROTIMA 1 TOY STATIS.EXE )
=========================================================================;

======================================================================;
D1-1.0 EGGEGRAMMENOI ANDRES OLA TA EJAMHNA  (ATHROISMATA ANA EJAMHNO) ;
======================================================================;
select count(egrafi.k_f) AS ANDRES_EGGEGR_OLOI,  egrafi.ej AS EJAMHNO
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1' and egrafi.ak = :1 and tropos != '020'
  and egrafi.xu = '2' AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
 and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL
  group by 2 order by 2 ;

select * from st_f where @mid(birthdate,0,4) = 1994 and k_f in (select k_f from egrafi where ak = 2013) ;

=============================================================;
D1-1.0  EGGEGRAMMENOI ANDRES OLA TA EJAMHNA  ANA ETOS GENNHSHS;
=============================================================;

select count(egrafi.k_f) AS ANDRES_EGGEGR_OLOI,  egrafi.ej AS EJAMHNO, 
@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1' and egrafi.ak = :1  and tropos != '020' 
  and egrafi.xu = '2'  AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL 
  group by 2,3 order by 2, 3 desc ;

--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------

========================================================================;
D1-2.0 EGGEGRAMMENOI GYNAIKES OLA TA EJAMHNA (ATHROISMATA ANA EJAMHNO) ;
========================================================================;

select count(egrafi.k_f) AS GYNAIKES_EGGEGR_OLES,  egrafi.ej AS EJAMHNO
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '2' and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2'  AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL  
  group by 2 order by 2 ;

===============================================================;
D1-2.0 EGGEGRAMMENES GYNAIKES OLA TA EJAMHNA  ANA ETOS GENNHSHS;
===============================================================;

select count(egrafi.k_f) AS GYNAIKES_EGGEGR_OLES,  egrafi.ej AS EJAMHNO, 
@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 
 'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '2' and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL  
  group by 2,3 order by 2, 3 desc ;

------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
D1-1.1  PRWTOEGGEGRAMMENOI ANDRES STO 10o EJAMHNO  (ATHROISMA) ;
 
select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1'  and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '10' and ak < :1)
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL ;

D1-1.1   PRWTOEGGEGRAMMENOI ANDRES STO 10o EJAMHNO  ANA ETOS GENNHSHS;

select count(egrafi.k_f), 
@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) ,  'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1' and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '10' and ak < :1) 
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL 
group by 2;

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
D1-2.1 PRWTOEGGEGRAMMENES GYNAIKES STO 10o EJAMHNO  (ATHROISMA) ;
 
select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '2' and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '10' and ak < :1)
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL ;

D1-2.1 PRWTOEGGEGRAMMENES GYNAIKES STO 10o EJAMHNO ANA ETOS GENNHSHS;

select count(egrafi.k_f), 
@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) ,  'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '2' and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '10' and ak < :1)
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL 
group by 2;

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

================================================================; 
D1. ANDRES + GYNAIKES   PERAN  TVN KANONIKVN EJAMHNVN   FOITHSHS;
================================================================; 

create table egg9 (fylo varchar(1), synegg integer, ybirth varchar(30)  ) ;
create table protoegg9 (fylo varchar(1),  protegg integer, ybirth varchar(30)  ) ;
delete from egg9;
delete from protoegg9 ;


insert into egg9 
select  sex, count(egrafi.k_f),
@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) ,
  'DEN EXOYN HM/NIA GENNHSHS'  ) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL 
  group by 1,3 ;


insert into protoegg9 
select  sex, count(egrafi.k_f), 
@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 
 'DEN EXOYN HM/NIA GENNHSHS'  ) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and sex is not null  and birthdate is not null  AND egrafi.EJ IS NOT NULL 
  and egrafi.k_f not in (select k_f from egrafi where ej = '10' and ak < :1)  group by 1,3  ;


TO SELECT POY DINEI TO EPITHYMHTO APOTELESMA ;

select @if ( e.fylo - 2, 'ANDRES', 'GYNAIKES' ) AS FYLO, @if ( @ISNA(p.ybirth) , synegg, @if ( @ISNA(e.ybirth), protegg, synegg - protegg   )  )    as EGG_Pano_Apo_5_ETH , 
 e.ybirth as ETOS_GENHSHS from egg9 e, protoegg9 p where e.fylo = p.fylo and e.ybirth = p.ybirth
union
select @if ( e.fylo - 2, 'ANDRES', 'GYNAIKES' ), @if ( @ISNA(p.ybirth) , synegg, @if ( @ISNA(e.ybirth), protegg, synegg - protegg   )  )  ,
 e.ybirth from egg9 e, protoegg9 p where e.fylo    = p.fylo (+) and e.ybirth    = p.ybirth (+)  
union 
select @if ( e.fylo - 2, 'ANDRES', 'GYNAIKES' ), @if ( @ISNA(p.ybirth) , synegg, @if ( @ISNA(e.ybirth), protegg, synegg - protegg   )  )  , 
e.ybirth from egg9 e, protoegg9 p where e.fylo (+)  = p.fylo  and e.ybirth (+)  = p.ybirth    order by 1, 3 ;




========================================================================================;
D2. ALLODAPOI , OMOGENEIS SPOYDASTES ME JENH YPHKOOTHTA, KATA FYLO KAI XVRA YPHKOOTHTAS
							( EROTIMA 2 TOY STATIS.EXE )
========================================================================================;

select  sex, count(egrafi.k_f) AS AR.FOIT, yphk, PLTEXT AS XVRA from egrafi,st_f , PLTAB
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = 2  and yphk != '0099' 
AND PLTAB.PLCOLUMN = 'YPHK' AND PLCODE = YPHK
and sex is not null  and YPHK is not null  
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
group by  yphk , PLTEXT, sex order by PLTEXT ;

*** XVRIS LEKTIKO KAI XVRIS ELEGXO GIA FYLO KAI YPHKOOTHTA (APO AYTO ELEGXOYME TA ELLIPH STOIXEIA ) ***
========================================================================================;

select yphk, sex, count(egrafi.k_f) from egrafi,st_f 
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = 2  and yphk != '0099' 
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
 group by  yphk , sex order by yphk ;


========================================================================================;
D3. METAPTYXIAKOI FOITHTES KATA FYLO, EPIPEDO SPOYDVN KAI ETOS GENNHSHS ;
					( EROTIMA 9 TOY STATIS.EXE )
========================================================================================;
OPOY
 :1  AK. ETOS POY ZHTOYNTAI TA STOIXEIA, 
 :2  TO ETOS GENNHSHS APO TO OPOIO ATHROIZONTAI OLA TA MIKROTERA  KAI
 :3 KVDIKOS SXOLHS ;

######  P R O S O X H   STA BIND DATA VAZOYME GIA TO AK. ETOS 2011-12 :   2012,1978  #######
TO 2012-13 THA AYJHSETE KATA 1  KLP ...
 
=== D3.A + D3.B ====
===============
NEOEISELTHONTES
=============== ;
--  DIDAKTORES --- ;

SELECT COUNT(DISTINCT MET.MITROO) AS AR.FOIT , SEX, 

@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 
 'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS

                       FROM MET, METSTUPROG
WHERE MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL AND BIRTHDATE IS NOT NULL
AND METSTUPROG.progcode =1  and :1 = METSTUPROG.AK AND
 ( DATEANAG IS NULL OR ( DATEANAG IS  NOT NULL  AND DATEANAG > '08/31/'||:1 ) )
AND MET.MITROO NOT IN ( SELECT MITROO FROM METDIAKOP
               WHERE  ( DATEEOS IS NULL OR DATEEOS >  '08/31/'||:1 ) 
and ( DATEAPO < '08/31/'||:1 OR DATEAPO IS NULL ) AND PROGCODE = 1 )  AND
  MET.TMIMACODE = :3 GROUP BY 2,3 order by 2,3 DESC ;


--  METAPTYXIAKOI --- ;

SELECT COUNT(DISTINCT MET.MITROO) AS AR.FOIT, SEX, 

@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 
 'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS

                       FROM MET, METSTUPROG
WHERE MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL AND BIRTHDATE IS NOT NULL
AND METSTUPROG.progcode <> 1  and :1 = METSTUPROG.AK AND
 ( DATEANAG IS NULL OR ( DATEANAG IS  NOT NULL  AND DATEANAG > '08/31/'||:1 ) )
AND MET.MITROO NOT IN ( SELECT MITROO FROM METDIAKOP
               WHERE  ( DATEEOS IS NULL OR DATEEOS >  '08/31/'||:1 ) 
and ( DATEAPO < '08/31/'||:1 OR DATEAPO IS NULL ) AND PROGCODE <> 1 )  AND
  MET.TMIMACODE = :3 GROUP BY 2,3 order by 2,3 DESC ;




 === D3.C + D3.D ====
==============
HDH FOITOYNTES
============== ;

-- D3.1 DIDAKTORES ;

SELECT COUNT(DISTINCT MET.MITROO) AS AR.FOIT , SEX, 

@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 
 'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS

                       FROM MET, METSTUPROG
WHERE MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL AND BIRTHDATE IS NOT NULL
AND METSTUPROG.progcode =1  and :1 >= METSTUPROG.AK AND
 ( DATEANAG IS NULL OR ( DATEANAG IS  NOT NULL  AND DATEANAG > '08/31/'||:1 ) )
AND MET.MITROO NOT IN ( SELECT MITROO FROM METDIAKOP
               WHERE  ( DATEEOS IS NULL OR DATEEOS >  '08/31/'||:1 ) 
and ( DATEAPO < '08/31/'||:1 OR DATEAPO IS NULL ) AND PROGCODE = 1 )  AND
  MET.TMIMACODE = :3 GROUP BY 2,3 order by 2,3 DESC ;


 -- D3.2 METAPTYXIAKOI ;

SELECT COUNT(DISTINCT MET.MITROO) AS AR.FOIT, SEX, 

@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 
 'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS

                       FROM MET, METSTUPROG
WHERE MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL AND BIRTHDATE IS NOT NULL
AND METSTUPROG.progcode <> 1  and :1 >= METSTUPROG.AK AND
 ( DATEANAG IS NULL OR ( DATEANAG IS  NOT NULL  AND DATEANAG > '08/31/'||:1 ) )
AND MET.MITROO NOT IN ( SELECT MITROO FROM METDIAKOP
               WHERE  ( DATEEOS IS NULL OR DATEEOS >  '08/31/'||:1 ) 
and ( DATEAPO < '08/31/'||:1 OR DATEAPO IS NULL ) AND PROGCODE <> 1 )  AND
  MET.TMIMACODE = :3 GROUP BY 2,3 order by 2,3 DESC ;


-----------------------------------------------------------------------------------
===============  E.  P T Y X I O Y X O I ============== ; 
-----------------------------------------------------------------------------------;

========================================================================================;
E1.  ARITHMOS FOITHTVN POY PHRAN PTYXIO KAI FOITHTVN POY PHRAN METAPTYXIAKO KATA FYLO,
									STH DIARKEIA TOY AK. ETOYS.
								( EROTIMATA 5 KAI 10 TOY STATIS.EXE )
========================================================================================;

  == E1.1 ==

'ARISTA' ;
select  sex , 'ARISTA', count(k_f) AS AR.FOIT FROM  hst_f
where ((etosdipl =  :1-1 and period like 'ойт%' )
or (etosdipl = :1  and (period like 'жеб%'  or period like 'иоу%')))
 and gradeapof >= 9
 group by 1,2 order by 1,2  ;

 'LIAN KALVS' ;
select  sex , 'LIAN KALVS', count(k_f)  AS AR.FOIT  FROM  hst_f 
where ((etosdipl = :1-1  and period like 'ойт%' )
or (etosdipl = :1  and (period like 'жеб%'  or period like 'иоу%')))
and gradeapof >= 7 and gradeapof < 9  
group by 1,2 order by 1,2 ;

'KALVS' ;
select  sex , 'KALVS', count(k_f)  AS AR.FOIT FROM  hst_f 
where ((etosdipl = :1-1  and period like 'ойт%' )
or (etosdipl = :1 and (period like 'жеб%'  or period like 'иоу%')))
and gradeapof < 7
 group by 1 order by 1,2 ;




   === E1.2 === ;

OPOY 
:1 TO AK. ETOS POY ZHTOYN TA STOIXEIA ;

DIDAKTORIKO;
select  metstuprog.progcode AS PROGRAM, sex , count(met.mitroo) AS AR.FOIT  FROM  met,metstuprog 
where dateanag  >=  '09/01/'||@STRING(:1-1,0) and DATEANAG <= '08/31/'||@STRING(:1,0)  
and met.mitroo = metstuprog.mitroo  and metstuprog.progcode = 1
 group by 1,2 order by 1,2; 

MDE ;
select  metstuprog.progcode AS PROGRAM, ,sex , count(met.mitroo) AS AR.FOIT  FROM  met,metstuprog 
where dateanag  >=  '09/01/'||@STRING(:1-1,0) and DATEANAG <= '08/31/'||@STRING(:1,0)  
and met.mitroo = metstuprog.mitroo  and metstuprog.progcode <> 1
 group by 1,2 order by 1,2; 

========================================================================================;
E2.  ARITHMOS FOITHTVN POY PHRAN PTYXIO KATA FYLO KAI ETOS GENNHSHS
						( EROTIMA 4 TOY STATIS.EXE )
========================================================================================;

OPOY
 :1  AK. ETOS POY ZHTOYNTAI TA STOIXEIA, 
 :2  TO ETOS GENNHSHS APO TO OPOIO ATHROIZONTAI OLA TA MIKROTERA  
######  P R O S O X H   STA BIND DATA VAZOYME GIA TO AK. ETOS 2011-12 :   2012,1981  #######
TO 2012-13 THA AYJHSETE KATA 1  KLP ... ;

select  sex , count(k_f)  AS AR.FOIT, 
@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 
 'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS
FROM  hst_f 
where ((etosdipl = :1-1 and period like  'ойт%'  )
or (etosdipl =  :1 and (period LIKE 'жеб%'  or period LIKE 'иоу%')))
 group by 1, 3 order by 1,3 DESC ;


========================================================================================;
E3.  ARITHMOS METAPTYXIAKVN FOITHTVN POY PHRAN PTYXIO KATA FYLO EPIPEDO SPOYDVN KAI ETOS GENNHSHS
						( EROTIMA 4 TOY STATIS.EXE )
========================================================================================;
OPOY 
:1 TO AK. ETOS POY ZHTOYN TA STOIXEIA 
:2 TO MIKROTERO AK ETOS GENNHSHS
:3 TO PROGRAMMA ;

== DIDAKTORIKO H' MDE ==  ;


SELECT 
COUNT(DISTINCT MET.MITROO) AS AR.FOIT,metstuprog.progcode as PROG, SEX,
@if( @mid(birthdate,0,4),  @if ( @mid(birthdate,0,4) - :2 + @ABS(@mid(birthdate,0,4) - :2 ), @mid(birthdate,0,4),  :2 || ' KAI PRIN'  ) , 
 'DEN EXOYN HM/NIA GENNHSHS'  )  as ETOS_GENNHSHS

                        FROM MET, METSTUPROG
			WHERE MET.MITROO = METSTUPROG.MITROO AND SEX IS NOT NULL AND BIRTHDATE IS NOT NULL
AND METSTUPROG.progcode= :3
and dateanag between '01-SEP-'|| @string(:1-1,0) and '31-AUG-'|| @string(:1,0)  

 group by 4,2,3 order by 3, 4 desc ;




******************************************************************************************************************;

 =======  PVS VRISKO TOYS FOITHTES XVRIS KATAXORHMENH HM/NIA GENNHSHS ======= ;

SELECT @if ( S.SEX - 2, 'ANDRES', 'GYNAIKES' ) AS FYLO, E.EJ AS EJAMHNO,   S.K_F AS KVDIKOS, EPVN,ONOMA,PATR 
FROM ST_F S, EGRAFI E WHERE E.EJ IN ('02', '04', '06', '08', '10' ) 
AND E.AK = :1 AND S.K_F = E.K_F AND BIRTHDATE IS NULL ORDER BY S.SEX, E.EJ, E.K_F ;
******************************************************************************************************************** ;






