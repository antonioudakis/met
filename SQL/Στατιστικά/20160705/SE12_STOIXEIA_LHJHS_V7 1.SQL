				

	---- ΣΕ-12 ---- 	ΣΤΟΙΧΕΙΑ ΛΗΞΗΣ ΑΚΑΔΗΜΑΪΚΟΥ ΕΤΟΥΣ : 2014 - 15

	--------------------------------------
	1. -- Π Ρ Ο Π Τ Υ Χ Ι Α Κ Ο --
	--------------------------------------



	Δ1. Εγγεγραμμένοι προπτυχιακοί φοιτητές κατά εξάμηνο σπουδών, φύλο και έτος γέννησης
Τα στοιχεία αναφέρονται στη λήξη του ακαδημαϊκού έτους (τελευταία εβδομάδα του Μαΐου 2015).
Περιλαμβάνονται όσοι εγγράφηκαν και μεταγράφηκαν από άλλο Τμήμα, όχι όμως όσοι πήραν μεταγραφή για άλλο Τμήμα.

1997 - 1966 1961-65, 1956-60, 1951-55, 1950 και πριν 

Σημ. : Για γυναίκες βάζετε sex='2'
	Για άγνωστο έτος γέννησης γράφετε  birthdate is null 
	Στα bind data βάζετε 2015

======================================================================;
D1 EGGEGRAMMENOI OLA TA EJAMHNA  (ATHROISMATA ANA EJAMHNO) ;
======================================================================;
select count(egrafi.k_f) AS EGGEGR_OLOI,  egrafi.ej AS EJAMHNO, @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1 and tropos != '020'
  and egrafi.xu = '2' 
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
 AND egrafi.EJ IS NOT NULL
  group by 2,3 order by 3,2 ;


=============================================================;
D1 EGGEGRAMMENOI OLA TA EJAMHNA  ANA ETOS GENNHSHS;
=============================================================;

select count(egrafi.k_f) AS EGGEGR_OLOI, egrafi.ej AS EJAMHNO, 
@mid(birthdate,0,4)  as ETOS_GENNHSHS , @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020' 
  and egrafi.xu = '2'  
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
AND egrafi.EJ IS NOT NULL 
  group by 2,3,4 order by 4, 3 DESC, 2 ;

  
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

D1  PRWTOEGGEGRAMMENOI STO 10o EJAMHNO  (ATHROISMA) ;


select count(egrafi.k_f) AS PROTOEGG_10,  @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '10' and ak < :1)
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
AND egrafi.EJ IS NOT NULL  GROUP BY 2 ORDER BY 2 ;


D1   PRWTOEGGEGRAMMENOI STO 10o EJAMHNO  ANA ETOS GENNHSHS;

select count(egrafi.k_f) AS PROTOEGG_10,  
@mid(birthdate,0,4)  as ETOS_GENNHSHS, @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '10' and ak < :1) 
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
AND egrafi.EJ IS NOT NULL 
group by 2, 3 ORDER BY 3, 2 DESC ;


------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

================================================================; 
D1. ANDRES + GYNAIKES   PERAN  TVN KANONIKVN EJAMHNVN   FOITHSHS;
================================================================; 

create table egg9 (fylo varchar(1), synegg integer, ybirth varchar(30)  ) ;
create table protoegg9 (fylo varchar(1),  protegg integer, ybirth varchar(30)  ) ;
delete from egg9;
delete from protoegg9 ;

@;
insert into egg9 ; 
select  sex, count(egrafi.k_f),
@mid(birthdate,0,4)  as ETOS_GENNHSHS 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
AND egrafi.EJ IS NOT NULL 
  group by 1,3 ;


insert into protoegg9 
select  sex, count(egrafi.k_f), 
@mid(birthdate,0,4)  as ETOS_GENNHSHS 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020'
  and egrafi.xu = '2' and egrafi.ej = '10' 
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
 AND egrafi.EJ IS NOT NULL 
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

-------- ;


Δ2. Εγγεγραμμένοι προπτυχιακοί ΦΟΙΤΗΤΕΣ ΚΙΝΗΤΙΚΟΤΗΤΑΣ (mobile students), κατά εξάμηνο σπουδών, φύλο και έτος γέννησης
Δ3. Εγγεγραμμένοι προπτυχιακοί φοιτητές και εγγεγραμμένοι προπτυχιακοί ΦΟΙΤΗΤΕΣ ΚΙΝΗΤΙΚΟΤΗΤΑΣ (mobile students), 
κατέχοντες άλλο βασικό πτυχίο τριτοβάθμιας εκπαίδευσης, κατά φύλο
Δ4. Εγγεγραμμένοι προπτυχιακοί ΟΜΟΓΕΝΕΙΣ ΦΟΙΤΗΤΕΣ ΚΙΝΗΤΙΚΟΤΗΤΑΣ (mobile students), κατά φύλο
Δ5. Εγγεγραμμένοι προπτυχιακοί ΦΟΙΤΗΤΕΣ ΚΙΝΗΤΙΚΟΤΗΤΑΣ (mobile students),  κατά 
φύλο και χώρα κτήσης του απολυτηρίου β΄ κύκλου της δευτεροβάθμιας εκπαίδευσης

-------- ;


Δ6. Νεοεισαχθέντες προπτυχιακοί φοιτητές, κατά φύλο και έτος γέννησης


======================================================================;
D6 NEOEISAXTHENTES OLA TA EJAMHNA  (ATHROISMATA ANA EJAMHNO) ;
Μη κατέχοντες άλλο βασικό πτυχίο τριτοβάθμιας εκπαίδευσης
======================================================================;
select count(egrafi.k_f) AS NEOEIS,  egrafi.ej AS EJAMHNO,  @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1 and tropos != '020'  and egrafi.xu = '2'  
and  egrafi.k_f NOT IN (select k_f from egrafi where ak < :1) 
  AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
AND egrafi.EJ IS NOT NULL
 AND ST_F.AK IS NOT NULL  AND ST_F.AK = :1 
and tropos NOT in ('014', '015', '016')
  group by 2,3 order by 3, 2 ;

======================================================================;
D6 NEOEISAXTHENTES OLA TA EJAMHNA  (ATHROISMATA ANA EJAMHNO) ;
Κατέχοντες άλλο βασικό πτυχίο τριτοβάθμιας εκπαίδευσης
======================================================================;
select count(egrafi.k_f) AS NEOEIS_PTYX,  egrafi.ej AS EJAMHNO ,  @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1 and tropos != '020'  and egrafi.xu = '2'  
and  egrafi.k_f NOT IN (select k_f from egrafi where ak < :1) 
  AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
 AND egrafi.EJ IS NOT NULL
 AND ST_F.AK IS NOT NULL  AND ST_F.AK = :1 
and tropos in ('014', '015', '016')
  group by 2,3 order by 3,2 ;


=============================================================;
D6  NEOEISAXTHENTES OLA TA EJAMHNA  ANA ETOS GENNHSHS;
Μη κατέχοντες άλλο βασικό πτυχίο τριτοβάθμιας εκπαίδευσης
=============================================================;

select count(egrafi.k_f) AS NEOEIS, egrafi.ej AS EJAMHNO, 
@mid(birthdate,0,4)  as ETOS_GENNHSHS,   @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020' 
  and egrafi.xu = '2'  
and  egrafi.k_f NOT IN (select k_f from egrafi where ak < :1)
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
 AND egrafi.EJ IS NOT NULL 
AND ST_F.AK IS NOT NULL  AND ST_F.AK = :1 
and tropos NOT in ('014', '015', '016')
  group by 2,3,4 order by 4, 3 desc, 2 ;

=============================================================;
D6  NEOEISAXTHENTES OLA TA EJAMHNA  ANA ETOS GENNHSHS;
Kατέχοντες άλλο βασικό πτυχίο τριτοβάθμιας εκπαίδευσης
=============================================================;

select count(egrafi.k_f) AS NEOEIS_PTYX, egrafi.ej AS EJAMHNO, 
@mid(birthdate,0,4)  as ETOS_GENNHSHS,  @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and egrafi.ak = :1  and tropos != '020' 
  and egrafi.xu = '2'  
and  egrafi.k_f NOT IN (select k_f from egrafi where ak < :1)
AND ST_F.K_F NOT IN (SELECT K_F FROM APOFOIT WHERE AK = :1  )
and st_f.k_f not in (select k_f from diagrafentes  WHERE AK = :1 )
and st_f.k_f NOT IN  ( 
SELECT K_F FROM HST_F where ( (etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%') ) )      
)
AND egrafi.EJ IS NOT NULL 
AND ST_F.AK IS NOT NULL  AND ST_F.AK = :1 
and tropos in ('014', '015', '016')
  group by 2,3,4 order by 4, 3 desc, 2 ;


Δ7. Νεοεισαχθέντες προπτυχιακοί ΦΟΙΤΗΤΕΣ ΚΙΝΗΤΙΚΟΤΗΤΑΣ (mobile students), κατά φύλο και έτος γέννησης



	--- Ε. ΠΤΥΧΙΟΥΧΟΙ ---


========================================================================================;
Ε1. Αριθμός φοιτητών, που πήραν πτυχίο, κατά φύλο, στη διάρκεια του ακαδημαϊκού έτους
(1) Περιλαμβάνονται όσοι έλαβαν πτυχίο από 1-9-2014 μέχρι 31-8-2015, ακόμη και αν προέρχονται από προηγούμενα ακαδημαϊκά έτη
========================================================================================;

'ARISTA' ;
select  sex , 'ARISTA', count(k_f) AS AR.FOIT FROM  hst_f
where ((etosdipl =  :1-1 and period like 'ΟΚΤ%' )
or (etosdipl = :1  and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%')))
 and gradeapof >= 9
 group by 1,2 order by 1,2  ;

 'LIAN KALVS' ;
select  sex , 'LIAN KALVS', count(k_f)  AS AR.FOIT  FROM  hst_f 
where ((etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1  and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%')))
and gradeapof >= 7 and gradeapof < 9  
group by 1,2 order by 1,2 ;

'KALVS' ;
select  sex , 'KALVS', count(k_f)  AS AR.FOIT FROM  hst_f 
where ((etosdipl = :1-1  and period like 'ΟΚΤ%' )
or (etosdipl = :1 and (period like 'ΦΕΒ%'  or period like 'ΙΟΥ%')))
and gradeapof < 7
 group by 1 order by 1,2 ;


========================================================================================;
Ε2. Προπτυχιακοί φοιτητές που πήραν πτυχίο, κατά φύλο και έτος γέννησης
========================================================================================;

-- Μη κατέχοντες άλλο βασικό πτυχίο   τριτοβάθμιας εκπαίδευσης ;

select @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex , count(k_f)  AS AR.FOIT, 
@mid(birthdate,0,4)  as ETOS_GENNHSHS
FROM  hst_f 
where ((etosdipl = :1-1 and period like  'ΟΚΤ%'  )
or (etosdipl =  :1 and (period LIKE 'ΦΕΒ%'  or period LIKE 'ΙΟΥ%')))
and tropos NOT in ('014', '015', '016')
 group by 1, 3 order by 1,3 DESC ;

-- Κατέχοντες άλλο βασικό πτυχίο  τριτοβάθμιας εκπαίδευσης ;

select  @if(sex-1,'ΘΗΛΕΙΣ',@if(sex-2,'ΑΡΡΕΝΕΣ',sex)) as sex, count(k_f)  AS AR.FOIT_PTYX, 
@mid(birthdate,0,4)  as ETOS_GENNHSHS
FROM  hst_f 
where ((etosdipl = :1-1 and period like  'ΟΚΤ%'  )
or (etosdipl =  :1 and (period LIKE 'ΦΕΒ%'  or period LIKE 'ΙΟΥ%')))
and tropos in ('014', '015', '016')
 group by 1, 3 order by 1,3 DESC ;

Ε3. Προπτυχιακοί ΦΟΙΤΗΤΕΣ ΚΙΝΗΤΙΚΟΤΗΤΑΣ(mobile students) που πήραν πτυχίο, κατά φύλο και έτος γέννησης
Ε4. Προπτυχιακοί ΦΟΙΤΗΤΕΣ ΚΙΝΗΤΙΚΟΤΗΤΑΣ (mobile students) που πήραν πτυχίο, κατά 
φύλο και χώρα κτήσης του απολυτηρίου του β΄ κύκλου της δευτεροβάθμιας εκπαίδευσης
( Φοιτητές κινητικότητας (mobile students) είναι φοιτητές οι οποίοι είναι  κάτοχοι απολυτηρίου του β κύκλου της 
δευτεροβάθμιας εκπαίδευσης χώρας του εξωτερικού, ανεξαρτήτως υπηκοότητας  (περιλαμβάνονται και οι 
έλληνες απόφοιτοι ξένων λυκείων του εξωτερικού).)




	--------------------------------------
	2. -- Μ Ε Τ Α Π Τ Υ Χ Ι Α Κ Ο --
	--------------------------------------

;----------------------------------------------------------------------------------------ΕΝΤΥΠΟ 2---------------------------------------------------------------------------------------------------;

;ΠΛΗΘΟΣ ΕΝΕΡΓΩΝ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΠΟΥ ΔΕΝ ΕΧΟΥΝ ΑΝΑΓΟΡΕΥΘΕΙ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΠΑΡΕΙ ΔΙΑΓΡΑΦΗ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS; 

select metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) group by 1,2,3 order by 1,2,3;

;ΕΝΕΡΓΟΙ ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΠΟΥ ΔΕΝ ΕΧΟΥΝ ΑΝΑΓΟΡΕΥΘΕΙ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΠΑΡΕΙ ΔΙΑΓΡΑΦΗ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS 
;ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ Η ΕΤΟΣ ΓΕΝΝΗΣΗΣ; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,sex,birthdate from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) order by 4,5,6,2,3;

;ΠΛΗΘΟΣ ΕΝΕΡΓΩΝ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΠΟΥ ΔΕΝ ΕΧΟΥΝ ΑΝΑΓΟΡΕΥΘΕΙ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΠΑΡΕΙ ΔΙΑΓΡΑΦΗ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS 
;ΚΑΙ ΕΧΟΥΝ ΜΙΑ ΤΟΥΛΑΧΙΣΤΟΝ ΕΓΓΡΑΦΗ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ; 

select metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,@year(birthdate) as year_birth,count (distinct met.mitroo||metprogram.progcode||@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex))) as SYNOLO 
                        from metegr,metprogram,met,metstuprog
                        where metegr.progcode = metprogram.progcode and met.mitroo = metegr.mitroo and metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode 
                       and metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) group by 1,2,3 order by 1,2,3;

;ΕΝΕΡΓΟΙ ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΠΟΥ ΔΕΝ ΕΧΟΥΝ ΑΝΑΓΟΡΕΥΘΕΙ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΠΑΡΕΙ ΔΙΑΓΡΑΦΗ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ Η ΕΤΟΣ ΓΕΝΝΗΣΗΣ;
;ΚΑΙ ΕΧΟΥΝ ΜΙΑ ΤΟΥΛΑΧΙΣΤΟΝ ΕΓΓΡΑΦΗ ΣΤΟ ΑΚ ΕΤΟΣ; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,birthdate
                        from metegr,metprogram,met,metstuprog
                        where  metegr.progcode = metprogram.progcode and met.mitroo = metegr.mitroo and metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode 
                       and metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) order by 4,5,6,2,3;


;ΠΛΗΘΟΣ ΝΕΟΕΙΣΑΧΘΕΝΤΩΝ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΠΟΥ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΤΑ ΦΥΛΟ ΚΑΙ ΕΤΟΣ ΓΕΝΝΗΣΗΣ; 

select metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak =:1  and (met.erasmus is null or met.erasmus ='2')  group by 1,2,3 order by 1,2,3;

;ΕΝΕΡΓΟΙ ΝΕΟΕΙΣΑΧΘΕΝΤΕΣ ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΠΟΥ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ Η ΕΤΟΣ ΓΕΝΝΗΣΗΣ; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,birthdate from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak =:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) order by 4,5,6,2,3;

;ΠΛΗΘΟΣ ΑΝΑΓΟΡΕΥΜΕΝΩΝ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΠΟΥ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΤΑ ΦΥΛΟ ΚΑΙ ΕΤΟΣ ΓΕΝΝΗΣΗΣ; 

select metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) group by 1,2,3 order by 1,2,3;

;ΑΝΑΓΟΡΕΥΜΕΝΟΙ ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΠΟΥ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ Η ΕΤΟΣ ΓΕΝΝΗΣΗΣ; 

select met.mitroo, met.epvn, met.onoma,metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,birthdate from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) and (sex is null or birthdate is null) order by 4,5,6,2,3;


;----------------------------------------------------------------------------------ΕΝΤΥΠΟ 3--------------------------------------------------------------------------------------------------------;

;ΠΛΗΘΟΣ ΕΝΕΡΓΩΝ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΠΟΥ ΔΕΝ ΕΧΟΥΝ ΑΝΑΓΟΡΕΥΘΕΙ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΠΑΡΕΙ ΔΙΑΓΡΑΦΗ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΙ ΕΧΟΥΝ ΗΔΗ ΜΕΤΑΠΤΥΧΙΑΚΟ; 

select metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog,met,metprogram,metptyx
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;ΕΝΕΡΓΟΙ ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΠΟΥ ΔΕΝ ΕΧΟΥΝ ΑΝΑΓΟΡΕΥΘΕΙ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΠΑΡΕΙ ΔΙΑΓΡΑΦΗ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΙ ΕΧΟΥΝ ΗΔΗ ΜΕΤΑΠΤΥΧΙΑΚΟ
;ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ Η ΕΤΟΣ ΓΕΝΝΗΣΗΣ; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,birthdate from metstuprog,met,metprogram,metptyx
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview ='3' order by 4,5,6,2,3;

;ΠΛΗΘΟΣ ΕΝΕΡΓΩΝ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΠΟΥ ΔΕΝ ΕΧΟΥΝ ΑΝΑΓΟΡΕΥΘΕΙ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΠΑΡΕΙ ΔΙΑΓΡΑΦΗ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS 
;ΚΑΙ ΕΧΟΥΝ ΜΙΑ ΤΟΥΛΑΧΙΣΤΟΝ ΕΓΓΡΑΦΗ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΕΧΟΥΝ ΗΔΗ ΜΕΤΑΠΤΥΧΙΑΚΟ; 

select metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,@year(birthdate) as year_birth,count (distinct met.mitroo||metprogram.progcode||@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex))) as SYNOLO 
                        from metegr,metprogram,met,metstuprog,metptyx
                        where metegr.progcode = metprogram.progcode and met.mitroo = metegr.mitroo and metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;ΕΝΕΡΓΟΙ ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΠΟΥ ΔΕΝ ΕΧΟΥΝ ΑΝΑΓΟΡΕΥΘΕΙ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΠΑΡΕΙ ΔΙΑΓΡΑΦΗ ΜΕΣΑ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΚΑΙ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ Η ΕΤΟΣ ΓΕΝΝΗΣΗΣ;
;ΚΑΙ ΕΧΟΥΝ ΜΙΑ ΤΟΥΛΑΧΙΣΤΟΝ ΕΓΓΡΑΦΗ ΣΤΟ ΑΚ ΕΤΟΣ ΚΑΙ ΕΧΟΥΝ ΗΔΗ ΜΕΤΑΠΤΥΧΙΑΚΟ; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,birthdate 
                        from metegr,metprogram,met,metstuprog,metptyx
                        where metegr.progcode = metprogram.progcode and met.mitroo = metegr.mitroo and metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview ='3' order by 4,5,6,2,3;


;ΠΛΗΘΟΣ ΑΝΑΓΟΡΕΥΜΕΝΩΝ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΠΟΥ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΤΑ ΦΥΛΟ ΚΑΙ ΕΤΟΣ ΓΕΝΝΗΣΗΣ ΚΑΙ ΕΧΟΥΝ ΗΔΗ ΜΕΤΑΠΤΥΧΙΑΚΟ; 

select metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog,met,metprogram,metptyx
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;ΑΝΑΓΟΡΕΥΜΕΝΟΙ ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΣΤΟ ΑΚ ΕΤΟΣ ΑΝΑΖΗΤΗΣΗΣ ΠΟΥ ΔΕΝ ΕΙΝΑΙ ΦΟΙΤΗΤΕΣ ERASMUS ΚΑΙ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ Η ΕΤΟΣ ΓΕΝΝΗΣΗΣ ΚΑΙ ΕΧΟΥΝ ΗΔΗ ΜΕΤΑΠΤΥΧΙΑΚΟ; 

select met.mitroo, met.epvn, met.onoma,metprogram.titlos,@if(1-sex,'ΘΗΛΕΙΣ',@if(2-sex,'ΑΡΡΕΝΕΣ',sex)) as sex,@year(birthdate) as year_birth from metstuprog,met,metprogram,metptyx
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) and (sex is null or birthdate is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' order by 4,5,6,2,3;




