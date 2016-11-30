
PINAKAS B2 STOIXEIA FOITHTWN TOY TMHMATOS AK. ETOYS 2001
=========================================================================
B2.1. SYNOLO EGGEGRAMMENWN;

select egrafi.ej, sex, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = 2001 and egrafi.xu = '1'
and egrafi.ej<'09'
group by egrafi.ej, sex ;
--------------------------------------------------------------------------------------------------------------------------------------------------------------
1. PRWTOEGGEGRAMMENOI ANDRES STO 9o;
 
select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1' and egrafi.ak = 2001 
  and egrafi.xu = '1' and egrafi.ej = '09' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < 2001);

* PRWTOEGGEGRAMMENOI ANDRES STO 9o ANA ETOS GENNHSHS;

select count(egrafi.k_f), @mid(birthdate,0,4) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1' and egrafi.ak = 2001 
  and egrafi.xu = '1' and egrafi.ej = '09' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < 2001) 
group by 2;

------------------------------------------------------------------------------------------------------------------------------------------------------------
1. PRWTOEGGEGRAMMENES GYNAIKES STO 9o;
 
select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '2' and egrafi.ak = 2001 
  and egrafi.xu = '1' and egrafi.ej = '09' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < 2001);

*PRWTOEGGEGRAMMENES GYNAIKES STO 9o ANA ETOS GENNHSHS;

select count(egrafi.k_f), @mid(birthdate,0,4) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '2' and egrafi.ak = 2001 
  and egrafi.xu = '1' and egrafi.ej = '09' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < 2001)
group by 2;

------------------------------------------------------------------------------------------------------------------------------------------------------------
B2. 1.1 - 1.3     GIA KYPRIOYS TROPOS '002' GIA OMOGENEIS  '003' KAI GIA ALLOGENEIS '004' ; 

select egrafi.ej, sex, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = 2001 and egrafi.xu = '1'
 and tropos = 'ANTISTOIXOS KWDIKOS'
 group by egrafi.ej, sex ;
------------------------------------------------------------------------------------------------------------------------------------------------------------
Â2. 1.4       FOITHTES POY METEGRAFHSAN TO AK. ETOS 2001 APO ALLO TMHMA H SXOLH ;

select egrafi.ej, sex, COUNT(EGRAFI.EJ)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = 2001 and egrafi.xu = '1'
and st_f.ak = 2001 and (tropos = '005' or tropos = '009' or tropos = '019'  )
 group by egrafi.ej, sex ;

------------------------------------------------------------------------------------------------------------------------------------------------------------
Â2. 1.5      FOITHTES POY METEGRAFHSAN TO AK. ETOS 2001 SE ALLO TMHMA H SXOLH ;

select count(st_f.k_f), sex, apofoit.ej 
from st_f, apofoit
where st_f.k_f = apofoit.k_f and apofoit.ak = 2001
  group by sex, apofoit.ej;
------------------------------------------------------------------------------------------------------------------------------------------------------------
B2. 1.6, 1.7  PTYXIOYXOI AEI TEI EGGEGRAMMENOI GIA 2o PTYXIO STO AK. ETOS 2001 (GIA PRWTH FORA)
                 kvdikoi '014' kai '015';

select egrafi.ej, sex, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = 2001 and egrafi.xu = '1'
and st_f.ak = 2001 and (tropos = 'ANTISTOIXOS KWDIKOS')
 group by egrafi.ej, sex ;
------------------------------------------------------------------------------------------------------------------------------------------------------------
B2. 2. ARITHMOS EGGEGRAMMENWN FOITHTWN PERAN TWN KANONIKWN EJAMHNWN FOITHSHS ;
            (GIA GYNAIKES SEX = '2');

select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1' and egrafi.ak = 2001 
  and egrafi.xu = '1' and egrafi.ej = '09' AND EGRAFI.K_F IN (SELECT K_F FROM EGRAFI WHERE EJ ='09' 
AND AK<2001 ) ;

 * ARITHMOS EGGEGRAMMENWN FOITHTWN PERAN TWN KANONIKWN EJAMHNWN FOITHSHS  ANA ETOS GENNHSHS;
            (GIA GYNAIKES SEX = '2');

select count(egrafi.k_f) , @mid(birthdate,0,4) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1' and egrafi.ak = 2001 
  and egrafi.xu = '1' and egrafi.ej = '09' AND EGRAFI.K_F IN (SELECT K_F FROM EGRAFI WHERE EJ ='09' 
AND AK<2001 ) group by 2;
------------------------------------------------------------------------------------------------------------------------------------------------------------


PINAKAS B3   STOIXEIA GIA TOYS ALLOGENEIS FOITHTES TOY TMHMATOS GIA TO AK. ETOS 2001
=======================================================================================
B3. ;
select egrafi.ej, sex, pltext, count(egrafi.k_f)
from egrafi, st_f, pltab
where st_f.k_f = egrafi.k_f and egrafi.ak = 2001 and egrafi.xu = '1'
  and pllang = 'G' and plcolumn = 'YPHK' and plcode = yphk
group by egrafi.ej, pltext, sex ;
------------------------------------------------------------------------------------------------------------------------------------------------------------

PINAKAS B4  STOIXEIA GIA TOYS PTYXIOYXOYS
============================================
B4. 1. ARITHMOS PTYXIOYXWN;

select count(k_f), sex, etosdipl 
from hst_f 
where etosdipl > 1996 
group by etosdipl,sex;

B4. 2.,3. ARITHMOS PTYXIOYXWN POY ELABAN METAPTYXIAKO DIPLWMA H DIDAKTORIKO;

select count(met.mitroo) from met, metanathesi,metdsynerg,metptyx  
where met.mitroo = metanathesi.mitroo and met.mitroo = metdsynerg.mitroo
and met.mitroo = metptyx.mitroo and metdsynerg.codesyn = metanathesi.codesyn 
and (metdsynerg.progcode = 'ANTISTOIXOS KWDIKOS'or metdsynerg.progcode = 'ANTISTOIXOS KWDIKOS')
 and sex = '2' and dateanag >'1997-08-31'and dateanag <'1998-09-01' and dateanag is not null 
and idryma ='ANTISTOIXOS KWDIKOS';

(GIA TOYS ARXITEKTONES O KWDIKOS IDRYMATOS EINAI '00231');

===============================================================================================================´;
===============================================================================================================´;

1A.* MESOS OROS DIARKEIAS FOITHSHS ANA ETOS DIPLVMATOS;

select  avg((hst_f.etosdipl+1) - st_f.ak) from hst_f,st_f where hst_f.etosdipl = 2001 and st_f.k_f = hst_f.k_f;

1B.* DIARKEIA FOITHSHS FOITHTVN ANA ETOS DIPLVMATOS;

select st_f.k_f, SUM((hst_f.etosdipl+1) - st_f.ak) from hst_f,st_f where hst_f.etosdipl = 2001 
and st_f.k_f = hst_f.k_f group by st_f.k_f;

===============================================================================================================´;

2A.* DIPLVMATOYXOI ALLODAPOI KAI OMOGENEIS ME ETOS DIPLVMATOS (STOIXEIA APO TON HST_F);
 
SELECT TROPOS||';'||@TRIM(COORIG)||';'||@TRIM(YPHK)||';'||K_F||';'||@TRIM(EPVN)||';'||@TRIM(ONOMA)||';'||
@TRIM(PATR)||';'||@TRIM(MHTR)||';'||@TRIM(BIRTHDATE)||';'||
@TRIM(ODOS)||';'||@TRIM(AK)||';'||ETOSDIPL FROM HST_F 
WHERE HST_F.TROPOS IN ('003','004','022')  
 ORDER BY TROPOS,YPHK,ETOSDIPL;

2B.* DIPLVMATOYXOI KAI APOFOITOI ALLODAPOI KAI OMOGENEIS  (STOIXEIA APO TON ST_F);

SELECT TROPOS||';'||@TRIM(COORIG)||';'||@TRIM(YPHK)||';'||K_F||';'||@TRIM(EPVN)||';'||@TRIM(ONOMA)||';'||
@TRIM(PATR)||';'||@TRIM(MHTR)||';'||@TRIM(BIRTHDATE)||';'||
@TRIM(ODOS)||';'||@TRIM(AK)||';'||ETOSDIPL FROM ST_F 
WHERE ST_F.TROPOS IN ('003','004','022')  AND (STUSTATUS = 'DI' OR STATUS = '01' ) 
 ORDER BY TROPOS,YPHK,ETOSDIPL;

2C.* DIPLVMATOYXOI KAI APOFOITOI ALLODAPOI KAI OMOGENEIS  (STOIXEIA APO TON ST_F ME TA LEKTIKA APO TO PLTAB
DEN FERNEI AYTOYS POY OI ANTISTOIXOI KVDIKOI EINAI KENOI ARA LIGOTERO PLHRES SE SXESH ME TO 2B);

SELECT K_F||';'||EPVN||';'||ONOMA||';'||PATR||';'||MHTR||';'||XVRA.PLTEXT||';'||YPHKO.PLTEXT||';'||
ST_F.tropos||';'||TROPO.PLTEXT||';'||ODOS||';'||BIRTHDATE||';'||AK
 FROM ST_F, PLTAB XVRA, PLTAB YPHKO, PLTAB TROPO
 WHERE (STUSTATUS = 'DI' OR STATUS = '01' ) 
AND XVRA.PLCOLUMN = 'YPHK' AND XVRA.PLCODE = ST_F.COORIG 
AND YPHKO.PLCOLUMN = 'YPHK' AND YPHKO.PLCODE = ST_F.YPHK
AND TROPO.PLCOLUMN = 'TROPOS' AND TROPO.PLCODE = ST_F.TROPOS 
AND ST_F.TROPOS IN ('003','004','022','007','018') ORDER BY ST_F.TROPOS ,ST_F.YPHK,COORIG;

===============================================================================================================´;

3A.* ENERGOI FOITHTES SYNOLIKA ANA ETOS (FOITHTES ME DIARKEIA FOITHSHS MESA STO PROBLEPOMENO DIASTHMA 5 XRONIA);

select  count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = 1998 and egrafi.xu = '1'
and egrafi.ej<='09' and egrafi.k_f not  in (select k_f from egrafi where ej = '09' and ak < 1998);


3B.* LIMNAZONTES FOITHTES SYNOLIKA ANA ETOS (FOITHTES ME DIARKEIA FOITHSHS MEGALYTERH APO TO PROBLEPOMENO DIASTHMA 5 XRONIA);

select  count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = 1998 and egrafi.xu = '1'
and egrafi.ej<='09' and egrafi.k_f in (select k_f from egrafi where ej = '09' and ak < 1998);

3C.* EGGEGRAMMENOI FOITHTES SYNOLIKA ANA ETOS (ATHROISMA ENERGVN KAI LIMNAZONTVN);

select count(egrafi.k_f)from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = 1998 and egrafi.xu = '1' ;

==============================================================================================================;

4A. * PRVTOEGGEGRAMENOI EPITYXONTES ANA MATHIMA SYNOLIKA GIA OLA TA MATHIMATA TOY ETOUS;
create table math (k_m integer);
insert into math 
select distinct k_m from kartella where ak = 2001;

select math.k_m,count(k_f) from kartella,math 
where   math.k_m = kartella.k_m and ak = 2001
and (gradenor > 4 or gradepan >4 or gradexari>4)  and k_f not in (select k_f from kartella where ak <2001 and kartella.k_m = math.k_m)
 group by 1;

4B. * PRVTOEGGEGRAMENOI (APOTYXONTES KAI MH PROSELTHONTES) SYNOLIKA GIA OLA TA MATHIMATA TOY ETOUS;
select math.k_m,count(k_f) from kartella,math 
where   math.k_m = kartella.k_m and ak = 2001
and ((gradenor <= 4 or gradenor is null) and (gradepan <=4 or gradepan is null) and (gradexari<=4 or gradexari is null))  
and k_f not in (select k_f from kartella where ak <2001 and kartella.k_m = math.k_m)
 group by 1;

===============================================================================================================;
5. * ENERGOI Y.D. GIA DOSMENO ETOS ANA FYLO KAI ETOS GENNHSHS;
     (STO PARADEIGMA, Y.D. TOY TEMFE ENERGOI GIA TO 2001);

SELECT met.mitroo,epvn,onoma,pltext
FROM MET, METSTUPROG,pltab
WHERE  METSTUPROG.PROGCODE = 3  and coorig <> '0099' and plcolumn = 'YPHK' and pltab.plcode = met.coorig
 and METSTUPROG.MITROO = MET.MITROO and 2004 >= METSTUPROG.AK and MET.MITROO not in
     (select METDSYNERG.MITROO from METANATHESI, METDSYNERG  where METANATHESI.CODESYN = METDSYNERG.CODESYN
 AND dateanag is not null AND DATEANAG < '31-AUG-2004' AND METDSYNERG.PROGCODE = 3 and METANATHESI.MITROO = METDSYNERG.MITROO )
 and  MET.mitroo not in
     (select mitroo from METDIAKOP where DATEAPO <  '31-AUG-2004' and  DATEEOS is  null and progcode = 3 )
 and MET.TMIMACODE =  4
 order by 4,2,3;

(GIA M.D.E  DINOYME TIMH STO PROGCODE ANALOGA ME TON KVDIKO TOY PROGRAMMATOS);

===============================================================================================================;
6A. * DIPLVMATOYXOI ANA PERIODO DIPLVMATIKHS GIA DOSMENO ETOS APOFOITHSHS; (NIKOS)
select k_tm||';'||period||';'||@trim(epvn)||';'||@trim(onoma)||';'||@trim(patr)||';'||sex||';'||birthdate||';'||@trim(pltext)||';'||etosdipl||';'||ardipl||';'||gradeapof from hst_f ,pltab
where etosdipl = 2000  and plcolumn = 'TOPOSG' and plcode = poliorig and pllang = 'G' order by period  ,epvn,onoma,patr;

6B. * DIPLVMATOYXOI ANA PERIODO DIPLVMATIKHS GIA DOSMENO ETOS APOFOITHSHS XVRIS POLH GENNHSHS ; (NIKOS)
Select k_tm||';'||period||';'||@trim(epvn)||';'||@trim(onoma)||';'||@trim(patr)||';'||sex||';'||birthdate||';'||etosdipl||';'||ardipl||';'||gradeapof  from hst_f 
where etosdipl = 2000 AND  poliorig IS NULL order by period  ,epvn,onoma,patr;
(6A + 6B) PLHRES.

6C. * DIPLVMATOYXOI ANA PERIODO DIPLVMATIKHS ME THEMA, TRIMELH EPITROPH, HM.EJETASHS K.L.P;

select hst_f.period||';'||hst_f.k_f||';'||@trim(hst_f.epvn)||' '||@trim(hst_f.onoma)||';'||dep.onoma, dep.epvn||';'||
hst_f.titlosmau,hst_f.thema||';'||hst_f.moana||';'||hst_f.dateejet  
from hst_f,diplgrade,dep,anathesi,diplsynerg
where diplgrade.codesyn = diplsynerg.codesyn and diplsynerg.codesyn = anathesi.codesyn and diplsynerg.k_f = hst_f.k_f 
and dep.am_dep = diplgrade.am_dep
and etosdipl = 2000 and hst_f.k_tm =  'KVDIKOS TMHMATOS'  order by hst_f.period, hst_f.epvn,hst_f.onoma ;

===============================================================================================================;

7. ENERGOI ALLODAPOI FOITHTES EGGEGRAMMENOI STO TREXON ETOS;

SELECT TROP_EIS.PLTEXT||';'||XVRA_YPHK.PLTEXT||';'||ORIGIN.PLTEXT||';'||COUNT(K_F)
FROM ST_F, PLTAB XVRA_YPHK, PLTAB TROP_EIS, PLTAB ORIGIN WHERE ST_F.K_TM = "ANTISTOIXOS KVDIKOS" 
and TROPOS IN ('004','003', '022') and TROP_EIS.plcode = ST_F.TROPOS
and TROP_EIS.PLCOLUMN= 'TROPOS'
and XVRA_YPHK.PLCOLUMN= 'YPHK' and XVRA_YPHK.PLCODE= ST_F.YPHK AND ORIGIN.PLCOLUMN = 'YPHK' AND ORIGIN.PLCODE = ST_F.COORIG
and (stustatus != 'DI' or stustatus is null) and ( st_f.status != '01' or status is null) and k_f in (select k_f from egrafi where ak = "TREXON ETOS")
GROUP BY TROP_EIS.PLTEXT,XVRA_YPHK.PLTEXT,ORIGIN.PLTEXT ;






