STA BIND DATA VAZOYME TO IDIO AK. ETOS. SE OLA TA EROTIMATA P.X. GIA FETOS AK. 2011-2012 (GRAFOYME 2012)
PAROLO POY ZHTAME PTYXIOYXOYS PROHGOYMENOY ETOYS KAI ENERGOYS TOY TREXONTOS ETOYS 
VAZOYME TO IDIO XARIN EYKOLIAS (EXEI YPOLOGISTEI STO QUERY ) ;


=============================================================;
1.* NEOEGGRAFENTES FOITHTES (EGGEGRAMMENOI FOITHTES STO A ETOS SPOYDVN;
=============================================================;
=====    STOIXEIA ENARJHS AK. ETOYS ANAZHTHSHS =====================;

select  COUNT(ST_F.k_F) AS NEOEGGRAFENTES
from  ST_F
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL < :1  )
and k_f not in (select k_f from apofoit  WHERE AK < :1)
and k_f not in (select k_f from diagrafentes  WHERE AK < :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02') AND ak = :1)
and tropos != '020' 
AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1 ;


=============================================================;
2.* ENERGOI FOITHTES ME DIARKEIA FOITHSHS MEXRI KAI 5+2 XRONIA;
=============================================================;
=====    STOIXEIA ENARJHS AK. ETOYS ANAZHTHSHS =====================;

select  count(ST_F.k_f)  AS ENERGOI
from  ST_F
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL < :1  )
and k_f not in (select k_f from apofoit  WHERE AK < :1)
and k_f not in (select k_f from diagrafentes  WHERE AK < :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) 
and tropos != '020'

AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1 
and  ( (ST_F.AK > :1-7 and st_f.ej in ('01','02'))
        or   (ST_F.AK > :1-6 and st_f.ej in ('03','04'))
        or   (ST_F.AK > :1-5 and st_f.ej in ('05','06'))
        or   (ST_F.AK > :1-4 and st_f.ej in ('07','08'))
        or   (ST_F.AK > :1-3 and st_f.ej in ('09','10')) ) ;



========================================================================================;
3.* TAKTIKOI FOITHTES  ME DIARKEIA FOITHSHS MESA STO PROBLEPOMENO DIASTHMA TVN 5 ETVN;
========================================================================================;
=====    STOIXEIA ENARJHS AK. ETOYS ANAZHTHSHS =====================;

select  count(ST_F.k_f)  AS TAKTIKOI
from  ST_F
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL < :1  )
and k_f not in (select k_f from apofoit  WHERE AK < :1)
and k_f not in (select k_f from diagrafentes  WHERE AK < :1) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) 
and tropos != '020'

AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1 
and  ( (ST_F.AK > :1-5 and st_f.ej in ('01','02'))
        or   (ST_F.AK > :1-4 and st_f.ej in ('03','04'))
        or   (ST_F.AK > :1-3 and st_f.ej in ('05','06'))
        or   (ST_F.AK > :1-2 and st_f.ej in ('07','08'))
        or   (ST_F.AK > :1-1 and st_f.ej in ('09','10')) ) ;


=============================================================================================================;
4. * MH ENERGOI FOITHTES ME DIARKEIA FOITHSHS MEGALYTERH APO 7 XRONIA
	( APO TO 2011-12 SYMPERILAMVANONTAI STOYS MH ENERGOYS KAI AYTOI POY EXOYN EJETASTEI SE MATHIMATA
	KATA SYNEPEIA H KATHGORIA TVN HMI-ENERGVN KATARGEITAI )
=============================================================================================================;
=====    STOIXEIA ENARJHS AK. ETOYS ANAZHTHSHS =====================;

select  count(ST_F.k_f) AS MH_ENERGOI
from  st_f
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL < :1  )
and k_f not in (select k_f from apofoit  WHERE AK < :1)
and k_f not in (select k_f from diagrafentes  WHERE AK < :1)
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) and sex is not null AND ST_F.EJ IS NOT NULL
and tropos != '020'
 AND  ST_F.AK IS NOT NULL AND ST_F.AK <= :1

and  ( (ST_F.AK <= :1-7 and st_f.ej in ('01','02'))
        or   (ST_F.AK <= :1-6 and st_f.ej in ('03','04'))
        or   (ST_F.AK <= :1-5 and st_f.ej in ('05','06'))
        or   (ST_F.AK <= :1-4 and st_f.ej in ('07','08'))
        or   (ST_F.AK <= :1-3 and st_f.ej in ('09','10')) )
;


==================================================================;
5.* EGGEGRAMMENOI FOITHTES  (ATHROISMA ENERGVN KAI MH ENERGVN) ;
==================================================================;
=====    STOIXEIA ENARJHS AK. ETOYS ANAZHTHSHS =====================;

Select  count(ST_F.k_f) AS EGGEGR
from  st_f
where st_f.k_f  NOT IN (SELECT K_F FROM HST_F WHERE ETOSDIPL < :1  )
and k_f not in (select k_f from apofoit  WHERE AK < :1)
and k_f not in (select k_f from diagrafentes  WHERE AK < :1)
and k_f not in (select k_f from st_f where stustatus = 'DI' and k_f not in (select k_f from hst_f) )
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) and sex is not null AND ST_F.EJ IS NOT NULL
and tropos != '020'
 AND  ST_F.AK IS NOT NULL AND ST_F.AK <= :1 ;

==================================================================;
6.* NEOEGGRAFENTES METAPTYXIAKOI FOITHTES  ;
==================================================================;

select count(metstuprog.mitroo) AS NEOI_MET
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.ak = :1 and metstuprog.progcode != 1  and (dateanag  is null or dateanag>='01-Dec-'||@string(:1-1,0))
 and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0) 
and dateeos is null and progcode = metstuprog.progcode);

== OR == ; GIA OSOYS DEN TREXEI TO PROHGOYMENO ;

select count(metstuprog.mitroo) AS NEOI_MET
from met,metstuprog
where  met.mitroo = metstuprog.mitroo  and metstuprog.ak = :1 and metstuprog.progcode != 1 
and (dateanag  is null or dateanag>='01-Dec-'||@string(:1-1,0)) 
and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0) 
and dateeos is null and progcode = metstuprog.progcode);



==================================================================;
7.* ENERGOI METAPTYXIAKOI FOITHTES  ;
==================================================================;

select count(metstuprog.mitroo) AS ENERG_MET
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.ak <= :1 and metstuprog.progcode != 1  and (dateanag  is null or dateanag>='01-Dec-'||@string(:1-1,0))
 and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0) 
and dateeos is null and progcode = metstuprog.progcode);

== OR == ; GIA OSOYS DEN TREXEI TO PROHGOYMENO ;

select count(metstuprog.mitroo) AS ENERG_MET
from met,metstuprog
where  met.mitroo = metstuprog.mitroo  and metstuprog.ak <= :1 and metstuprog.progcode != 1 
and (dateanag  is null or dateanag>='01-Dec-'||@string(:1-1,0)) 
and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0) 
and dateeos is null and progcode = metstuprog.progcode);

==================================================================;
8.* NEOEGGRAFENTES YPOPSIFIOI DIDAKTORES ;
==================================================================;

select count(metstuprog.mitroo) AS NEOI_DID
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.ak = :1 and metstuprog.progcode = 1  and (dateanag  is null or dateanag>='01-Sep-'||@string(:1-1,0))
 and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0) 
and dateeos is null and progcode = metstuprog.progcode);

== OR == ; GIA OSOYS DEN TREXEI TO PROHGOYMENO ;

select count(metstuprog.mitroo) AS NEOI_DID
from met,metstuprog
where  met.mitroo = metstuprog.mitroo  and metstuprog.ak = :1 and metstuprog.progcode = 1 
and (dateanag  is null or dateanag>='01-Sep-'||@string(:1-1,0)) 
and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0) 
and dateeos is null and progcode = metstuprog.progcode);

==================================================================;
9.* ENERGOI DIDAKTORES FOITHTES  ;
==================================================================;

select count(metstuprog.mitroo) AS ENERG_DID
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where  metstuprog.ak <= :1 and metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1-1,0)) 
and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0) 
and dateeos is null and progcode =metstuprog.progcode);

== OR == ; GIA OSOYS DEN TREXEI TO PROHGOYMENO ;

select count(metstuprog.mitroo) AS ENERG_DID
from met,metstuprog
where   met.mitroo = metstuprog.mitroo  and metstuprog.ak <= :1 and  metstuprog.progcode = 1 
 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1-1,0)) 
and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0)
and dateeos is null and progcode =metstuprog.progcode);

select metstuprog.mitroo||';'||epvn||';'||onoma||';'||patr,dateanag
from met,metstuprog
where  met.mitroo = metstuprog.mitroo  and metstuprog.ak <= :1 and  metstuprog.progcode = 1 
 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1-1,0)) 
and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1-1,0)
and dateeos is null and progcode =metstuprog.progcode);

============================================================================;
10. * ARITHMOS PTYXIOYXVN AKAD. ETOYS :1-1 STA KANONIKA ETH SPOYDVN (5 ETH) ;
============================================================================;

select  count(ST_F.k_f)  AS PTYX_5
from  ST_F
where st_f.k_f  IN (SELECT K_F FROM HST_F WHERE ETOSDIPL = :1-1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1-1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1-1 ) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) 
and tropos != '020'

AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1-1 
and  ( (ST_F.AK > (:1-1)-5 and st_f.ej in ('01','02'))
        or   (ST_F.AK > (:1-1)-4 and st_f.ej in ('03','04'))
        or   (ST_F.AK > (:1-1)-3 and st_f.ej in ('05','06'))
        or   (ST_F.AK > (:1-1)-2 and st_f.ej in ('07','08'))
        or   (ST_F.AK > (:1-1)-1 and st_f.ej in ('09','10')) ) ;



========================================================================;
11. * ARITHMOS PTYXIOYXVN AKAD. ETOYS :1-1 ETH SPOYDVN > 5  KAI  <= 7 ;
========================================================================;


11A. MEXRI 7 ETH
==============;
select  count(ST_F.k_f)  AS PTYX_7
from  ST_F
where st_f.k_f  IN (SELECT K_F FROM HST_F WHERE ETOSDIPL = :1-1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1-1 )
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1-1 ) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) 
and tropos != '020'
AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1 
and  ( (ST_F.AK > (:1-1)-7 and st_f.ej in ('01','02'))
        or   (ST_F.AK > (:1-1)-6 and st_f.ej in ('03','04'))
        or   (ST_F.AK > (:1-1)-5 and st_f.ej in ('05','06'))
        or   (ST_F.AK > (:1-1)-4 and st_f.ej in ('07','08'))
        or   (ST_F.AK > (:1-1)-3 and st_f.ej in ('09','10')) ) ;


* PROKYPTEI TO APOTELESMA APO THN AFAIRESH;
11 = 11A - 10 ;

========================================================================;
12. * ARITHMOS PTYXIOYXVN AKAD. ETOYS :1-1 ETH SPOYDVN > 7 ;
========================================================================;

select  count(ST_F.k_f) AS PTYX_MEG_7
from  st_f
where st_f.k_f IN (SELECT K_F FROM HST_F WHERE ETOSDIPL = :1-1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1-1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1-1)
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) and sex is not null AND ST_F.EJ IS NOT NULL
and tropos != '020'
 AND  ST_F.AK IS NOT NULL AND ST_F.AK <= :1-1

and  ( (ST_F.AK <= (:1-1)-7 and st_f.ej in ('01','02'))
        or   (ST_F.AK <= (:1-1)-6 and st_f.ej in ('03','04'))
        or   (ST_F.AK <= (:1-1)-5 and st_f.ej in ('05','06'))
        or   (ST_F.AK <= (:1-1)-4 and st_f.ej in ('07','08'))
        or   (ST_F.AK <= (:1-1)-3 and st_f.ej in ('09','10')) ) ;


========================================================================;
13. * SYNOLO PTYXIOYXVN AKAD. ETOYS :1-1  ;
========================================================================;

select  count(ST_F.k_f)  AS PTYX
from  ST_F
where st_f.k_f  IN (SELECT K_F FROM HST_F WHERE ETOSDIPL = :1-1  )
and k_f not in (select k_f from apofoit  WHERE AK <= :1-1)
and k_f not in (select k_f from diagrafentes  WHERE AK <= :1-1 ) and sex is not null AND ST_F.EJ IS NOT NULL
and k_f in (select k_f from egrafi WHERE EJ IN ('01', '02', '03', '04', '05' ,'06', '07', '08', '09', '10') ) 
and tropos != '020'

AND ST_F.AK IS NOT NULL  AND ST_F.AK <= :1-1  ;


============================================================================;
14. * ARITHMOS DIPLVMATOYXVN METAPTYXIAKVN FOITHTVN AKAD. ETOYS :1-1 ;
============================================================================;

select count(metstuprog.mitroo) AS DIPL_MET
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1  and dateanag  between '01-Dec-'||@string((:1-1)-1,0) 
and  '30-Nov-'||@string(:1-1,0);

== OR == ; GIA OSOYS DEN TREXEI TO PROHGOYMENO ;

select count(metstuprog.mitroo)  AS DIPL_MET
from met,metstuprog
where met.mitroo = metstuprog.mitroo  and metstuprog.progcode != 1 
and dateanag  between '01-Dec-'||@string((:1-1)-1,0) and  '30-Nov-'||@string(:1-1,0);



============================================================================;
15. * ARITHMOS DIPLVMATOYXVN DIDAKTORVN FOITHTVN AKAD. ETOYS :1-1 ;
============================================================================;

select count(metstuprog.mitroo) AS DIPL_DID
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1  and dateanag  between '01-Sep-'||@string((:1-1)-1,0) and  '31-Aug-'||@string(:1-1,0);

== OR == ; GIA OSOYS DEN TREXEI TO PROHGOYMENO ;

select count(metstuprog.mitroo) AS DIPL_DID
from met,metstuprog
where  met.mitroo = metstuprog.mitroo  and metstuprog.progcode = 1 
and dateanag  between '01-Sep-'||@string((:1-1)-1,0) and  '31-Aug-'||@string(:1-1,0);


