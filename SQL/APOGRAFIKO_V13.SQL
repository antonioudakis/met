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
	
==================================================================================;
Φ1 1. PLHUOS EGGEGRAMMENVN PROPTYXIAKVN FOITHTVN KATA ETOS SPOYDVN KAI FYLO ;
==================================================================================;

select count(k_f) AS AR.FOIT , @if ( @ABS (:1+1 - st_f.ak - 10) + (:1+1 -st_f.ak-10) , '>= 11 ETH',  :1+1 -st_f.ak || ' ETH' ) AS AR.ETVN, sex As FYLO
from ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )
AND ST_F.AK IS NOT NULL AND ST_F.AK <= :1 group by 2,3 order by 3 , 2 ;

===========================================;
Φ1 2.1. STA KANONIKA EJAMHNA FOITHSHS ;
===========================================;

*** AYTO GIA OMOIOGENEIA ME TO F1.1 **** ;

select  count(ST_F.k_f)  AS AR.FOIT, SEX AS FYLO
from  ST_F
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) 
AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1 
and  ( (ST_F.AK > :1-5 ) )
GROUP BY 2;

*** PALIO POY YPOLOGIZEI KAI TO EJ *** ;
select  count(ST_F.k_f)  AS AR.FOIT, SEX AS FYLO
from  ST_F
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) 

AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1 
and  ( (ST_F.AK > :1-5 and st_f.ej in ('01','02'))
        or   (ST_F.AK > :1-4 and st_f.ej in ('03','04'))
        or   (ST_F.AK > :1-3 and st_f.ej in ('05','06'))
        or   (ST_F.AK > :1-2 and st_f.ej in ('07','08'))
        or   (ST_F.AK > :1-1 and st_f.ej in ('09','10')) )
GROUP BY 2;

========================================;
Φ1 2.2.  PERAN TVN KANONIKVN EJAMHNVN ;
========================================;

*** AYTO GIA OMOIOGENEIA ME TO F1.1 **** ;

select  count(ST_F.k_f) AS AR.FOIT, SEX AS FYLO
from  st_f
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1)
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) 
and sex is not null AND ST_F.EJ IS NOT NULL
 AND  ST_F.AK IS NOT NULL AND ST_F.AK <= :1
and  ( (ST_F.AK <= :1-5 ) )
GROUP BY 2 ;

*** PALIO POY YPOLOGIZEI KAI TO EJ *** ;

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



Φ1 3.1 FOITHTIKOS PLHTHYSMOS KATA FYLO KAI HLIKIA ( SE OLA TA ETH SPOYDVN ) ;

SELECT COUNT(K_F) AS AR.FOIT,  :1 - @MID(BIRTHDATE,0,4) AS HLIKIA, SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )
 and ( :1 - @MID(BIRTHDATE,0,4) ) > 0 and birthdate is not null 
 AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
GROUP BY 2,3 ORDER BY 3, 2;
A;1479;
G;296;

* AGNVSTH HLIKIA * ;
SELECT COUNT(K_F) AS AR.FOIT,  :1 - @MID(BIRTHDATE,0,4) AS HLIKIA, SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )
and ( birthdate is null or ( :1 - @mid(birthdate,0,4))  <= 0 )
 AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
GROUP BY 2,3 ORDER BY 3, 2;
A;14;
G;4;

** EPALHTHEYSH 3.1 **;

		SELECT COUNT(K_F) AS AR.FOIT,  SEX AS FYLO
		 from ST_F
                        where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL  <= :1  )
                         and k_f not in (select k_f from apofoit  WHERE AK <=  :1  )
                       and k_f not in (select k_f from diagrafentes  WHERE AK <= :1  )
                        and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
                         and k_f in (select k_f from egrafi
                         WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )			 
                         and sex is not null  AND ST_F.EJ IS NOT NULL                         
                         AND ST_F.AK IS NOT NULL  AND ST_F.AK  <= :1
			 GROUP BY 2 ORDER BY  2  ;



=======================================================================;
Φ1 3.2 FOITHTIKOS PLHTHYSMOS KATA FYLO KAI HLIKIA (STO A ETOS SPOYDVN) ;
=======================================================================;

SELECT COUNT(K_F) AS AR.FOIT,  :1 - @MID(BIRTHDATE,0,4) AS HLIKIA, SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  
AND ST_F.AK IS NOT NULL  AND ST_F.AK = :1
 and @MID(BIRTHDATE,0,4) > 0 and birthdate is not null 
GROUP BY 2,3 ORDER BY 3, 2;

** AGNOSTI HLIKIA ** ;

SELECT COUNT(K_F) AS AR.FOIT,  :1 - @MID(BIRTHDATE,0,4) AS HLIKIA, SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  
AND ST_F.AK IS NOT NULL  AND ST_F.AK = :1
and ( birthdate is null or ( :1 - @mid(birthdate,0,4))  <= 0 )
GROUP BY 2,3 ORDER BY 3, 2;


** EPALHTHEYSH 3.2 **;

SELECT COUNT(K_F) AS AR.FOIT,  SEX AS FYLO
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  
AND ST_F.AK IS NOT NULL AND ST_F.AK = :1 
GROUP BY 2 ORDER BY  2;



Φ1 4. ARITHMOS APOFOITVN KATA FYLO & HLIKIA;

select count(k_f), etosdipl-@mid(birthdate,0,4),sex  from hst_f where etosdipl = :1  group by 2,3  order by 3,2;



===========================================================================================================;
===================================================   Φ.2   ===============================================;
===========================================================================================================;

------------------------------------------------------------------------------------------------------------;
							  ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΚΑΙ ΑΠΟΦΟΙΤΟΙ ΤΟΥ ΤΜΗΜΑΤΟΣ
------------------------------------------------------------------------------------------------------------;



============================================================================================================;
===============================================     Φ.2.1.α     ============================================;
============================================================================================================;


------------------------------------------------------------------------------------------------------------;
ΜΕΤΑΠΤΥΧΙΑΚΟΣ ΦΟΙΤΗΤΙΚΟΣ ΠΛΗΘΥΣΜΟΣ ΚΑΤΑ ΦΥΛΟ ΗΛΙΚΙΑ ΚΑΙ ΕΠΙΠΕΔΟ ΣΠΟΥΔΩΝ (Μ.Δ.Ε)
ΠΑΡΑΜΕΤΡΟΙ 	:1 TO AK. ΕΤΟΣ 
			:2 O ΚΩΔΙΚΟΣ TΗΣ ΣΧΟΛΗΣ
------------------------------------------------------------------------------------------------------------;

*** BIRTHDATE NOT NULL **** ;

select sex, :1-@mid(birthdate,0,4)  as age , count(metstuprog.mitroo)
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
	and metstuprog.ak <= :1 and met.tmimacode = :2 and met.birthdate is not null
group by 2,1 order by 2,1;

*** BIRTHDATE is NULL **** ;

select sex, :1-@mid(birthdate,0,4)  as age , count(metstuprog.mitroo)
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2 and met.birthdate is null
group by 2,1 order by 2,1;

------------------------------------------------------------------------------------------------------------;
ΕΛΕΓΧΟΣ ΓΙΑ ΜΕΤΑΠΤΥΧΙΑΚΟΥΣ ΦΟΙΤΗΤΕΣ ΠΟΥ ΠΛΗΡΟΥΝ ΤΙΣ ΠΡΟΫΠΟΘΕΣΕΙΣ ΑΛΛΑ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΗ ΗΜΕΡΟΜΗΝΙΑ 
ΓΕΝΝΗΣΗΣ, ΦΥΛΟ , ΤΜΗΜΑ H ΑΚΑΔΗΜΑΪΚΟ ΕΤΟΣ ΠΡΩΤΗΣ ΕΓΓΡΑΦΗΣ(Μ.Δ.Ε)
------------------------------------------------------------------------------------------------------------; 

select metstuprog.mitroo, met.tmimacode, sex, birthdate, metstuprog.ak
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
	and (birthdate is null or sex is null or met.tmimacode is null or metstuprog.ak is null);


============================================================================================================;
===============================================     Φ.2.1.β     ============================================;
============================================================================================================;

------------------------------------------------------------------------------------------------------------;
ΜΕΤΑΠΤΥΧΙΑΚΟΣ ΦΟΙΤΗΤΙΚΟΣ ΠΛΗΘΥΣΜΟΣ ΚΑΤΑ ΦΥΛΟ ΗΛΙΚΙΑ ΚΑΙ ΕΠΙΠΕΔΟ ΣΠΟΥΔΩΝ (Υ.Δ)
ΠΑΡΑΜΕΤΡΟΙ 	:1 TO AK. ΕΤΟΣ 
			:2 O ΚΩΔΙΚΟΣ TΗΣ ΣΧΟΛΗΣ
------------------------------------------------------------------------------------------------------------;

*** BIRTHDATE NOT NULL **** ;

select sex, :1-@mid(birthdate,0,4)  as age , count(metstuprog.mitroo)
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
	and metstuprog.ak <= :1 and met.tmimacode = :2 and met.birthdate is not null
group by 2,1 order by 2,1;

*** BIRTHDATE NULL **** ;

select sex, :1-@mid(birthdate,0,4)  as age , count(metstuprog.mitroo)
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
	and metstuporg.ak <= :1 and met.tmimacode = :2 and met.birthdate is null
group by 2,1 order by 2,1;

------------------------------------------------------------------------------------------------------------;
ΕΛΕΓΧΟΣ ΓΙΑ ΜΕΤΑΠΤΥΧΙΑΚΟΥΣ ΦΟΙΤΗΤΕΣ ΠΟΥ ΠΛΗΡΟΥΝ ΤΙΣ ΠΡΟΫΠΟΘΕΣΕΙΣ ΑΛΛΑ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΗ ΗΜΕΡΟΜΗΝΙΑ 
ΓΕΝΝΗΣΗΣ, ΦΥΛΟ, ΤΜΗΜΑ Η ΑΚΑΔΗΜΑΪΚΟ ΕΤΟΣ ΠΡΩΤΗΣ ΕΓΓΡΑΦΗΣ (Υ.Δ)
------------------------------------------------------------------------------------------------------------; 

select metstuprog.mitroo, met.tmimacode, sex, birthdate, metstuprog.ak
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
	and (birthdate is null or sex is null or met.tmimacode is null or metstuprog is null);


============================================================================================================;
===============================================     Φ.2.2       ============================================;
============================================================================================================;	
	
------------------------------------------------------------------------------------------------------------;
ΦΟΙΤΗΤΙΚΟΣ ΠΛΗΘΥΣΜΟΣ ΥΠΟΨΗΦΙΩΝ ΔΙΔΑΚΤΟΡΩΝ ΚΑΤΑ ΕΤΟΣ ΣΠΟΥΔΩΝ ΚΑΙ ΦΥΛΟ
ΠΑΡΑΜΕΤΡΟΙ 	:1 TO AK. ΕΤΟΣ 
			:2 O ΚΩΔΙΚΟΣ TΗΣ ΣΧΟΛΗΣ
------------------------------------------------------------------------------------------------------------;

select sex, :1-metstuprog.ak+1 as etos, count(metstuprog.mitroo) 
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
	and metstuprog.ak <=:1 and met.tmimacode = :2
group by 2,1 order by 2,1;


------------------------------------------------------------------------------------------------------------;
ΕΛΕΓΧΟΣ ΓΙΑ ΥΠΟΨΗΦΙΟΥΣ ΔΙΔΑΚΤΟΡΕΣ ΠΟΥ ΠΛΗΡΟΥΝ ΤΙΣ ΠΡΟΫΠΟΘΕΣΕΙΣ ΑΛΛΑ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΕΤΟΣ
ΠΡΩΤΗΣ ΕΓΓΡΑΦΗΣ, ΦΥΛΟ Η ΤΜΗΜΑ (Υ.Δ)
------------------------------------------------------------------------------------------------------------; 

select metstuprog.mitroo, met.tmimacode, metstuprog.ak, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
	and (metstuprog.ak is null or sex is null or met.tmimacode is null);


============================================================================================================;
===============================================     Φ.2.3       ============================================;
============================================================================================================;	

------------------------------------------------------------------------------------------------------------;
ΑΡΙΘΜΟΣ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΠΟΥ ΕΓΓΡΑΦΟΝΤΑΙ ΓΙΑ ΔΕΥΤΕΡΟ ΜΕΤΑΠΤΥΧΙΑΚΟ ΤΙΤΛΟ ΣΠΟΥΔΩΝ ΚΑΤΑ ΦΥΛΟ ΚΑΙ ΕΠΙΠΕΔΟ
ΣΠΟΥΔΩΝ
ΠΑΡΑΜΕΤΡΟΙ 	:1 TO AK. ΕΤΟΣ 
			:2 O ΚΩΔΙΚΟΣ TΗΣ ΣΧΟΛΗΣ
			
Η ΠΛΗΡΟΦΟΡΙΑ ΑΥΤΟΙ ΥΠΑΧΡΕΙ ΣΤΑ ΠΡΟΣΟΝΤΑ ΤΟΥ ΦΟΙΤΗΤΗ -> ΤΙΤΛΟΣ ΕΜΦΑΝΙΣΗΣ ΣΤΑ ΠΙΣΤΟΠΟΙΗΤΙΚΑ
------------------------------------------------------------------------------------------------------------;

============================================================================================================;
===============================================     Φ.2.3.1.α    ===========================================;
============================================================================================================;

------------------------------------------------------------------------------------------------------------;
ΑΡΙΘΜΟΣ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΚΑΤΟΧΟΙ ΜΕΤΑΠΤΥΧΙΑΚΟΥ ΤΙΤΛΟΥ ΣΠΟΥΔΩΝ ΚΑΤΑ ΦΥΛΟ ΚΑΙ ΕΠΙΠΕΔΟ
ΣΠΟΥΔΩΝ	
------------------------------------------------------------------------------------------------------------;

select sex, count(metstuprog.mitroo) 
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo
join metptyx
on  met.mitroo = metptyx.mitroo
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and  metdiakop.progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2 and ptyxview = 3
group by 1 order by 1;

============================================================================================================;
===============================================     Φ.2.3.1.β    ===========================================;
============================================================================================================;

------------------------------------------------------------------------------------------------------------;
ΑΡΙΘΜΟΣ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΚΑΤΟΧΟΙ ΔΙΔΑΚΤΟΡΙΚΟΥ ΚΑΤΑ ΦΥΛΟ 	
------------------------------------------------------------------------------------------------------------;

select sex, count(metstuprog.mitroo) 
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo
join metptyx
on  met.mitroo = metptyx.mitroo
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and  metdiakop.progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2 and ptyxview = 4
group by 1 order by 1;

------------------------------------------------------------------------------------------------------------;
ΕΛΕΓΧΟΣ ΓΙΑ ΜΕΤΑΠΤΥΧΙΑΚΟΥΣ ΦΟΙΤΗΤΕΣ ΠΟΥ ΠΛΗΡΟΥΝ ΤΙΣ ΠΡΟΫΠΟΘΕΣΕΙΣ ΑΛΛΑ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ, ΤΜΗΜΑ Η
ΑΚΑΔΗΜΑΪΚΟ ΕΤΟΣ ΠΡΩΤΗΣ ΕΓΓΡΑΦΗΣ
------------------------------------------------------------------------------------------------------------; 

select met.mitroo,met.tmimacode,sex,metstuprog.ak
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo
join metptyx
on  met.mitroo = metptyx.mitroo
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and  metdiakop.progcode = metstuprog.progcode)
	and (ptyxview = 3 or ptyxview = 4) and (met.tmimacode is null or sex is null or metstuprog.ak is null);

============================================================================================================;
===============================================     Φ.2.3.2.α    ===========================================;
============================================================================================================;

------------------------------------------------------------------------------------------------------------;
ΑΡΙΘΜΟΣ ΥΠΟΨΗΦΙΩΝ ΔΙΔΑΚΤΟΡΩΝ ΚΑΤΟΧΟΙ ΜΕΤΑΠΤΥΧΙΑΚΟΥ ΚΑΤΑ ΦΥΛΟ 
------------------------------------------------------------------------------------------------------------;

select sex, count(metstuprog.mitroo) 
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo
join metptyx
on  met.mitroo = metptyx.mitroo
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and  metdiakop.progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2 and ptyxview = 3
group by 1 order by 1;

============================================================================================================;
===============================================     Φ.2.3.1.β    ===========================================;
============================================================================================================;

------------------------------------------------------------------------------------------------------------;
ΑΡΙΘΜΟΣ ΥΠΟΨΗΦΙΩΝ ΔΙΔΑΚΤΟΡΩΝ ΚΑΤΟΧΟΙ ΔΙΔΑΚΤΟΡΙΚΟΥ ΚΑΤΑ ΦΥΛΟ 
------------------------------------------------------------------------------------------------------------;

select sex, count(metstuprog.mitroo) 
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo
join metptyx
on  met.mitroo = metptyx.mitroo
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and  metdiakop.progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2 and ptyxview = 4
group by 1 order by 1;

------------------------------------------------------------------------------------------------------------;
ΕΛΕΓΧΟΣ ΓΙΑ ΥΠΟΨΗΦΙΟΥΣ ΔΙΔΑΚΤΟΡΕΣ ΠΟΥ ΠΛΗΡΟΥΝ ΤΙΣ ΠΡΟΫΠΟΘΕΣΕΙΣ ΑΛΛΑ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ , ΤΜΗΜΑ Η 
ΑΚΑΔΗΜΑΪΚΟ ΕΤΟΣ ΠΡΩΤΗΣ ΕΓΓΡΑΦΗΣ 
------------------------------------------------------------------------------------------------------------; 

select met.mitroo,met.tmimacode,met.sex, metstuprog.ak
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo
join metptyx
on  met.mitroo = metptyx.mitroo
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and  metdiakop.progcode = metstuprog.progcode)
	and (ptyxview = 3 or ptyxview = 4) and (met.tmimacode is null or sex is null or metstuprog.ak is null);


============================================================================================================;
===============================================     Φ.2.4       ============================================;
============================================================================================================;	

------------------------------------------------------------------------------------------------------------;
ΑΡΙΘΜΟΣ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΑΠΟΦΟΙΤΩΝ ΣΤΟ ΤΕΛΕΥΤΑΙΟ ΗΜΕΡΟΛΟΓΙΑΚΟ ΕΤΟΣ ΚΑΤΑ ΦΥΛΟ, ΗΛΙΚΙΑ ΚΑΙ ΕΠΙΠΕΔΟ ΣΠΟΥΔΩΝ
(ΗΜΕΡΟΛΟΓΙΑΚΟ ΕΤΟΣ)
ΠΑΡΑΜΕΤΡΟΙ 	:1 TO AK. ΕΤΟΣ 
			:2 O ΚΩΔΙΚΟΣ TΗΣ ΣΧΟΛΗΣ
------------------------------------------------------------------------------------------------------------;


============================================================================================================;
===============================================     Φ.2.4.α     ============================================;
============================================================================================================;	

------------------------------------------------------------------------------------------------------------;
ΑΡΙΘΜΟΣ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΑΠΟΦΟΙΤΩΝ ΣΤΟ ΤΕΛΕΥΤΑΙΟ ΗΜΕΡΟΛΟΓΙΑΚΟ ΕΤΟΣ ΚΑΤΑ ΦΥΛΟ, ΗΛΙΚΙΑ 
------------------------------------------------------------------------------------------------------------;

*** BIRTHDATE NOT NULL **** ;

select sex, :1-@mid(birthdate,0,4)  as age , count(metstuprog.mitroo)
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is not null or dateanag between '01-Sep-'||@string(:1,0) and '31-dec-'||@string(:1,0)
	and met.tmimacode = :2 and met.birthdate is not null
group by 2,1 order by 2,1;

*** BIRTHDATE is NULL **** ;

select sex, :1-@mid(birthdate,0,4)  as age , count(metstuprog.mitroo)
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is not null or dateanag between '01-Sep-'||@string(:1,0) and '31-dec-'||@string(:1,0)
	and met.tmimacode = :2 and met.birthdate is null
group by 2,1 order by 2,1;


------------------------------------------------------------------------------------------------------------;
ΕΛΕΓΧΟΣ ΓΙΑ ΜΕΤΑΠΤΥΧΙΑΚΟΥΣ ΑΠΟΦΟΙΤΟΥΣ ΠΟΥ ΠΛΗΡΟΥΝ ΤΙΣ ΠΡΟΫΠΟΘΕΣΕΙΣ ΑΛΛΑ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ , ΤΜΗΜΑ
Η ΗΛΙΚΙΑ 
------------------------------------------------------------------------------------------------------------; 

select mitroo, sex, bithdate, met.tmimacode
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is not null or dateanag between '01-Sep-'||@string(:1,0) and '31-dec-'||@string(:1,0)
	and (met.tmimacode = is null or sex is null or birthdate is null);
	
============================================================================================================;
===============================================     Φ.2.4.β     ============================================;
============================================================================================================;	

------------------------------------------------------------------------------------------------------------;
ΑΡΙΘΜΟΣ ΑΝΑΓΟΡΕΥΜΕΝΩΝ ΥΠΟΨΗΦΙΩΝ ΔΙΔΑΚΤΟΡΩΝ ΣΤΟ ΤΕΛΕΥΤΑΙΟ ΗΜΕΡΟΛΟΓΙΑΚΟ ΕΤΟΣ ΚΑΤΑ ΦΥΛΟ, ΗΛΙΚΙΑ 
------------------------------------------------------------------------------------------------------------;

*** BIRTHDATE NOT NULL **** ;

select sex, :1-@mid(birthdate,0,4)  as age , count(metstuprog.mitroo)
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is not null or dateanag between '01-Sep-'||@string(:1,0) and '31-dec-'||@string(:1,0)
	and met.tmimacode = :2 and met.birthdate is not null
group by 2,1 order by 2,1;

*** BIRTHDATE is NULL **** ;

select sex, :1-@mid(birthdate,0,4)  as age , count(metstuprog.mitroo)
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is not null or dateanag between '01-Sep-'||@string(:1,0) and '31-dec-'||@string(:1,0)
	and met.tmimacode = :2 and met.birthdate is null
group by 2,1 order by 2,1;


------------------------------------------------------------------------------------------------------------;
ΕΛΕΓΧΟΣ ΓΙΑ ΑΝΑΓΟΡΕΥΜΕΝΟΥΣ ΔΙΔΑΚΤΟΡΕΣ  ΠΟΥ ΠΛΗΡΟΥΝ ΤΙΣ ΠΡΟΫΠΟΘΕΣΕΙΣ ΑΛΛΑ ΔΕΝ ΕΧΟΥΝ ΚΑΤΑΧΩΡΗΜΕΝΟ ΦΥΛΟ , ΤΜΗΜΑ
Η ΗΛΙΚΙΑ 
------------------------------------------------------------------------------------------------------------; 

select mitroo, sex, bithdate, met.tmimacode
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is not null or dateanag between '01-Sep-'||@string(:1,0) and '31-dec-'||@string(:1,0)
	and (met.tmimacode = is null or sex is null or birthdate is null);


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

						=============== ;
						===== Φ3.1 ===== ;
						=============== ;

Φ3.1 = Φ3.1_Α1.1 + Φ3.1_Α1.2 + Φ3.1_Α1.3 + Φ3.1_Β1.1 + Φ3.1_Β1.2 + Φ3.1_Β1.3  ;


Φ3.1_A1.1. ARIUMOS PROPTYXIAKVN FOITHTVN ANA YPHKOOTHTA (YPHK NOT NULL);
select  count(k_f), PLTEXT  from st_f, PLTAB 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
 AND YPHK = PLCODE AND PLCOLUMN = 'YPHK' AND YPHK IS NOT NULL
GROUP BY 2 ORDER BY 2 ;

Φ3.1_A1.2. ARIUMOS PROPTYXIAKVN FOITHTVN ANA YPHKOOTHTA (YPHK NOT NULL, alla o kodikos DEN yparxei ston PLTAB );

SELECT k_f, epvn, onoma, COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS from st_f 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
 AND YPHK IS NOT NULL and yphk not in (select plcode from pltab where plcolumn = 'YPHK')
  order by 2,3;

Φ3.1_A1.3. ARIUMOS PROPTYXIAKVN FOITHTVN ANA YPHKOOTHTA (YPHK NULL);

SELECT  k_f, epvn, onoma,  COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS from st_f 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1
 AND YPHK IS NULL
 order by 2,3;


EPALHTHEYSH ( Φ3.1_A1.1 +  Φ3.1_A1.2  +  Φ3.1_A1.3 );
SELECT COUNT(K_F) AS AR.FOIT
FROM ST_F 
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL <= :1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1) and sex is not null
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) ) 
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') )  AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1;
1793;





Φ3.1_B1.1  ARIUMOS METAPTYXIAKVN ENERGVN ANA YPHKOOTHTA ( YPHK NOT NULL );

SELECT  COUNT(MET.MITROO), PLTEXT FROM MET,METSTUPROG, PLTAB
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO 
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE 
	( DATEAPO<'31-AUG-'|| :1 OR DATEAPO IS NULL) AND ( DATEEOS IS NULL OR DATEEOS > '31-AUG-'|| :1)
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2) AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
AND PLCODE = YPHK AND PLCOLUMN = 'YPHK'
GROUP BY 2 ORDER BY 2;

Φ3.1_B1.2  ARIUMOS METAPTYXIAKVN ENERGVN ANA YPHKOOTHTA ( YPHK NOT NULL,  alla o kodikos DEN yparxei ston PLTAB ) ;
AYTO GIA NA BREITE LOIPA STOIXEIA POY MPOREI NA BOHTHISOYN STHN KATATAJH;

SELECT  MET.MITROO, EPVN, ONOMA, COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO 
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE 
	( DATEAPO<'31-AUG-'|| :1 OR DATEAPO IS NULL) AND ( DATEEOS IS NULL OR DATEEOS > '31-AUG-'|| :1) 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2) AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
 AND YPHK IS NOT NULL and yphk not in (select plcode from pltab where plcolumn = 'YPHK')
ORDER BY 2, 3;


Φ3.1_B1.3  ARIUMOS METAPTYXIAKVN ENERGVN ANA YPHKOOTHTA ( YPHK NULL ) ;
AYTO GIA NA BREITE LOIPA STOIXEIA POY MPOREI NA BOHTHISOYN STHN KATATAJH;

SELECT  MET.MITROO, EPVN, ONOMA, COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO 
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE 
	( DATEAPO<'31-AUG-'|| :1 OR DATEAPO IS NULL) AND ( DATEEOS IS NULL OR DATEEOS > '31-AUG-'|| :1) 
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2) AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
AND YPHK IS NULL
 ORDER BY 2,3;

** EPALHTHEYSH ( Φ3.1_B1.1 +  Φ3.1_B1.2 +  Φ3.1_B1.3 ) ** ;
SELECT COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE !=1 AND MET.TMIMACODE = :2  AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE
	( DATEAPO<'31-AUG-'|| :1 OR DATEAPO IS NULL) AND ( DATEEOS IS NULL OR DATEEOS > '31-AUG-'|| :1)
	AND METDIAKOP.PROGCODE != 1 AND TMIMACODE = :2) AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
;




Φ3.1 = Φ3.1_Α1.1 + Φ3.1_Α1.2 + Φ3.1_Α1.3 + Φ3.1_Β1.1 + Φ3.1_Β1.2 + Φ3.1_Β1.3  ;
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;

							================= ;
							====== Φ3.2 ====== ;
							================= ;

Φ3.2 = Φ3.2Α1 + Φ3.2Α2 + Φ3.2Α3 ;

Φ3.2A1. ARIUMOS DIDAKTORVN  * ENERGVN * ANA YPHKOOTHTA ( YPHK NOT NULL )  ;

SELECT COUNT(MET.MITROO), PLTEXT FROM MET,METSTUPROG, PLTAB
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE
	( DATEAPO<'31-AUG-'|| :1 OR DATEAPO IS NULL) AND ( DATEEOS IS NULL OR DATEEOS > '31-AUG-'|| :1)
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
AND PLCODE = YPHK AND PLCOLUMN = 'YPHK' 
GROUP BY 2 ORDER BY 2;

Φ3.2A2 ARIUMOS DIDAKTORVN * ENERGVN * ANA YPHKOOTHTA (YPHK NOT NULL ,  alla o kodikos DEN yparxei ston PLTAB ) ;
AYTO GIA NA BREITE LOIPA STOIXEIA POY MPOREI NA BOHTHISOYN STHN KATATAJH;

SELECT MET.MITROO, EPVN, ONOMA, COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE
	( DATEAPO<'31-AUG-'|| :1 OR DATEAPO IS NULL) AND ( DATEEOS IS NULL OR DATEEOS > '31-AUG-'|| :1)
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
 AND YPHK IS NOT NULL and yphk not in (select plcode from pltab where plcolumn = 'YPHK')
ORDER BY 2,3;

Φ3.2A3 ARIUMOS DIDAKTORVN * ENERGVN * ANA YPHKOOTHTA (YPHK NULL) ;
AYTO GIA NA BREITE LOIPA STOIXEIA POY MPOREI NA BOHTHISOYN STHN KATATAJH;

SELECT MET.MITROO, EPVN, ONOMA, COORIG, NOMOSORIG, POLIORIG, COKAT, NOMOSKAT, POLIKAT,PERIOXI,ODOS FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE
	( DATEAPO<'31-AUG-'|| :1 OR DATEAPO IS NULL) AND ( DATEEOS IS NULL OR DATEEOS > '31-AUG-'|| :1)
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1)
AND YPHK IS NULL
 ORDER BY 2,3;

** EPALHTHEYSH ( Φ3.2_A1 +  Φ3.2_A2 ) ** ;
SELECT COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE =1 AND MET.TMIMACODE = :2 AND METSTUPROG.AK IS NOT NULL
	AND METSTUPROG.AK <= :1 AND MET.MITROO = METSTUPROG.MITROO
	AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE
	( DATEAPO<'31-AUG-'|| :1 OR DATEAPO IS NULL) AND ( DATEEOS IS NULL OR DATEEOS > '31-AUG-'|| :1)
	AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = :2)  AND SEX IS NOT NULL
	AND (METSTUPROG.DATEANAG IS NULL OR METSTUPROG.DATEANAG>'31-AUG-'|| :1) ;






Φ3.2 = Φ3.2Α1 + Φ3.2Α2 + Φ3.2Α3 ;
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;






































