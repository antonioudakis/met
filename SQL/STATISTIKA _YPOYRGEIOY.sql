PINAKAS B2 STOIXEIA FOITHTWN TOY TMHMATOS 
========================================================================
B2.1. SYNOLO EGGEGRAMMENWN;

select egrafi.ej, sex, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'
and egrafi.ej<'09'
group by egrafi.ej, sex ;
------------------------------------------------------------------------------------------------------------------------------------------------
1. PRWTOEGGEGRAMMENOI ANDRES STO 9o;
 
select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1'  and egrafi.ak = :1 
  and egrafi.xu = '1' and egrafi.ej = '09' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < :1);

* PRWTOEGGEGRAMMENOI ANDRES STO 9o ANA ETOS GENNHSHS;

select count(egrafi.k_f), @mid(birthdate,0,4) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '1' and egrafi.ak = :1 
  and egrafi.xu = '1' and egrafi.ej = '09' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < :1) 
group by 2;

------------------------------------------------------------------------------------------------------------------------------------------------------------
1. PRWTOEGGEGRAMMENES GYNAIKES STO 9o;
 
select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '2' and egrafi.ak = :1 
  and egrafi.xu = '1' and egrafi.ej = '09' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < :1);

*PRWTOEGGEGRAMMENES GYNAIKES STO 9o ANA ETOS GENNHSHS;

select count(egrafi.k_f), @mid(birthdate,0,4) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f and sex = '2' and egrafi.ak = :1 
  and egrafi.xu = '1' and egrafi.ej = '09' 
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < :1)
group by 2;

------------------------------------------------------------------------------------------------------------------------------------------------------------
B2. 1.1 - 1.3     GIA KYPRIOYS TROPOS '002' GIA OMOGENEIS  '003' KAI GIA ALLOGENEIS '004' ; 

select tropos,egrafi.ej, sex, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'
and tropos in ( '002','003','004' ) and egrafi.ej < '09'
group by egrafi.ej, sex ,tropos order by tropos, egrafi.ej, sex;

*PRWTOEGGEGRAMMENOI STO 9o ME TROPO EISAGVGHS;
 
select tropos,sex, count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = :1 
  and egrafi.xu = '1' and egrafi.ej = '09' and tropos in ( '002','003','004' )
  and egrafi.k_f not in (select k_f from egrafi where ej = '09' and ak < :1) group by tropos, sex;
------------------------------------------------------------------------------------------------------------------------------------------------------------
B2. 1.4       FOITHTES POY METEGRAFHSAN SE DOSMENO AK. ETOS APO ALLO TMHMA H SXOLH ;

select egrafi.ej, sex, COUNT(EGRAFI.EJ)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'
and st_f.ak = :1 and (tropos = '005' or tropos = '009' or tropos = '019'  )
 group by egrafi.ej, sex ;

------------------------------------------------------------------------------------------------------------------------------------------------------------
B2. 1.5      FOITHTES POY METEGRAFHSAN TO AK. ETOS 2001 SE ALLO TMHMA H SXOLH ;

select count(st_f.k_f), sex, apofoit.ej 
from st_f, apofoit
where st_f.k_f = apofoit.k_f and apofoit.ak = :1
  group by sex, apofoit.ej;
------------------------------------------------------------------------------------------------------------------------------------------------------------
B2. 1.6, 1.7  PTYXIOYXOI AEI TEI EGGEGRAMMENOI GIA 2o PTYXIO SE DOSMENO AK. ETOS (GIA PRWTH FORA)
                 kvdikoi '014' kai '015';

select TROPOS, egrafi.ej, sex, count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'
and st_f.ak = :1 and tropos IN ( '014', '015')
 group by TROPOS, egrafi.ej, sex ;
------------------------------------------------------------------------------------------------------------------------------------------------------------
B2. 2. ARITHMOS EGGEGRAMMENWN FOITHTWN PERAN TWN KANONIKWN EJAMHNWN FOITHSHS ANA FYLO POY FOITOYN;
            (GIA GYNAIKES SEX = '2');

select sex,  count(egrafi.k_f)  
from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = :1 and st_f.ak  <= :1-5
and egrafi.xu = '1' and egrafi.ej <= '09' 
and st_f.k_f  in (select k_f from kartella where ak = :1 and (gradenor >=0 or gradepan >=0 or gradexari>= 0) ) group by sex;

 * ARITHMOS EGGEGRAMMENWN FOITHTWN PERAN TWN KANONIKWN EJAMHNWN FOITHSHS  ANA FYLO KAI ETOS GENNHSHS POY FOITOYN;           

select count(egrafi.k_f) , @mid(birthdate,0,4) , sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = :1 and st_f.ak  <= :1-5
and egrafi.xu = '1' and egrafi.ej <= '09' 
and st_f.k_f  in (select k_f from kartella where ak = :1 and (gradenor >=0 or gradepan >=0 or gradexari>= 0) ) group by 3, 2;

B2. 3. ARITHMOS EGGEGRAMMENWN FOITHTWN PERAN TWN KANONIKWN EJAMHNWN FOITHSHS ANA FYLO POY DEN FOITOYN (LIMNAZONTES);

select sex, count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = :1 and st_f.ak <= :1-5
and egrafi.xu = '1' and egrafi.ej <= '09' 
and st_f.k_f  NOT in (select k_f from kartella where ak = :1 and (gradenor >=0 or gradepan >=0 or gradexari>= 0) ) group by sex;

  * ARITHMOS EGGEGRAMMENWN FOITHTWN PERAN TWN KANONIKWN EJAMHNWN FOITHSHS ANA ETOS GENNHSHS KAI FYLO POY DEN FOITOYN (LIMNAZONTES);

select count(egrafi.k_f) , @mid(birthdate,0,4) , sex
from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = :1 and st_f.ak <= :1-5
and egrafi.xu = '1' and egrafi.ej <= '09' 
and st_f.k_f  NOT in (select k_f from kartella where ak = :1 and (gradenor >=0 or gradepan >=0 or gradexari>= 0) ) group by 3, 2;


DIEYKRINHSH GIA 5 H' 7 ETH;
------------------------------------------------------------------------------------------------------------------------------------------------------------


PINAKAS B3   STOIXEIA GIA TOYS ALLOGENEIS FOITHTES TOY TMHMATOS GIA DOSMENO AK. ETOS
=======================================================================================
B3. ;
select egrafi.ej, sex, count(egrafi.k_f), pltext
from egrafi, st_f, pltab
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'
  and pllang = 'G' and plcolumn = 'YPHK' and plcode = yphk
group by pltext, egrafi.ej,  sex ;
------------------------------------------------------------------------------------------------------------------------------------------------------------

PINAKAS B4  STOIXEIA GIA TOYS PTYXIOYXOYS
============================================
B4. 1. ARITHMOS PTYXIOYXWN;

select count(k_f), sex, etosdipl 
from hst_f 
where etosdipl >= :1 
group by etosdipl,sex;

B4. 2.,3. ARITHMOS PTYXIOYXWN POY ELABAN METAPTYXIAKO DIPLWMA H DIDAKTORIKO;

select METDSYNERG.PROGCODE, SEX, count(met.mitroo) from met, metanathesi,metdsynerg,metptyx  
where met.mitroo = metanathesi.mitroo and met.mitroo = metdsynerg.mitroo
and met.mitroo = metptyx.mitroo and metdsynerg.codesyn = metanathesi.codesyn 
and (metdsynerg.progcode IN (1,2,3) )
and dateanag >:1-1||'-08-31'and dateanag <:1||'-09-01' and dateanag is not null 
and idryma =:2 GROUP BY METDSYNERG.PROGCODE, SEX;

(GIA TOYS ARXITEKTONES O KWDIKOS IDRYMATOS EINAI '00231');

===============================================================================================================+;
===============================================================================================================+;

1A.* MESOS OROS DIARKEIAS FOITHSHS ANA ETOS DIPLVMATOS;

select  avg((hst_f.etosdipl+1) - st_f.ak) from hst_f,st_f where hst_f.etosdipl = :1 and st_f.k_f = hst_f.k_f;

1B.* DIARKEIA FOITHSHS FOITHTVN ANA ETOS DIPLVMATOS;

select st_f.k_f, SUM((hst_f.etosdipl+1) - st_f.ak) from hst_f,st_f where hst_f.etosdipl = :1 
and st_f.k_f = hst_f.k_f group by st_f.k_f;

===============================================================================================================+;

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

================================================================================================================;

3A.* ENERGOI FOITHTES  ME DIARKEIA FOITHSHS MESA STO PROBLEPOMENO DIASTHMA TVN 5 ETVN;

select  count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1' and egrafi.ej<='09'  
and ST_F.AK > :1-5 ;

3B.* ENERGOI FOITHTES ME DIARKEIA FOITHSHS APO 5 EVS 7 XRONIA;

select  count(egrafi.k_f)
from egrafi, st_f
where st_f.k_f = egrafi.k_f and egrafi.ak = :1 and egrafi.xu = '1'  AND ST_F.AK IN (:1-6, :1-5)
and egrafi.ej <='09'  ;

3C.* LIMNAZONTES FOITHTES ME DIARKEIA FOITHSHS MEGALYTERH APO 7 XRONIA;

select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = :1 and st_f.ak <= :1-7
and egrafi.xu = '1' and egrafi.ej <= '09' 
 and st_f.k_f  not in (select k_f from kartella where ak = :1 and (gradenor >=0 or gradepan >=0 or gradexari>= 0) );

3D.* ENERGOI FOITHTES ME DIARKEIA FOITHSHS MEGALYTERH APO  7 XRONIA;

select count(egrafi.k_f) 
from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = :1 and st_f.ak <= :1-7
and egrafi.xu = '1' and egrafi.ej <= '09' 
and st_f.k_f  in (select k_f from kartella where ak = :1 and (gradenor >=0 or gradepan >=0 or gradexari>= 0) ) ;

3E.* EGGEGRAMMENOI FOITHTES  (ATHROISMA ENERGVN KAI LIMNAZONTVN);

select count(egrafi.k_f)from egrafi, st_f 
where egrafi.k_f = st_f.k_f  and egrafi.ak = :1 and egrafi.xu = '1' ;
==============================================================================================================;

4A. * PRVTOEGGEGRAMENOI EPITYXONTES ANA MATHIMA SYNOLIKA GIA OLA TA MATHIMATA TOY ETOUS;
create table math (k_m integer);
insert into math 
select distinct k_m from kartella where ak = :1;

select math.k_m,count(k_f) from kartella,math 
where   math.k_m = kartella.k_m and ak = 2001
and (gradenor > 4 or gradepan >4 or gradexari>4)  and k_f not in (select k_f from kartella where ak <:1 and kartella.k_m = math.k_m)
 group by 1;

4B. * PRVTOEGGEGRAMENOI (APOTYXONTES KAI MH PROSELTHONTES) SYNOLIKA GIA OLA TA MATHIMATA TOY ETOUS;
select math.k_m,count(k_f) from kartella,math 
where   math.k_m = kartella.k_m and ak = 2001
and ((gradenor <= 4 or gradenor is null) and (gradepan <=4 or gradepan is null) and (gradexari<=4 or gradexari is null))  
and k_f not in (select k_f from kartella where ak <:1 and kartella.k_m = math.k_m)
 group by 1;

===============================================================================================================;
5. * ENERGOI Y.D. GIA DOSMENO ETOS ANA FYLO KAI ETOS GENNHSHS;
     (STO PARADEIGMA, Y.D. THS SEMFE ENERGOI GIA TO 2007);


SELECT SEX,@MID(BIRTHDATE,0,4),COUNT(MET.MITROO)
FROM MET,METSTUPROG
WHERE METSTUPROG.PROGCODE=1 AND METSTUPROG.TMIMACODE = 6 AND METSTUPROG.AK<=2007 AND MET.MITROO = METSTUPROG.MITROO
AND METSTUPROG.MITROO NOT IN (SELECT MITROO FROM METDIAKOP WHERE DATEAPO<'31-AUG-2007' AND (DATEEOS IS NULL OR DATEEOS>'31-AUG-2007') AND METDIAKOP.PROGCODE = 1 AND TMIMACODE = 6)
AND METSTUPROG.DATEANAG IS NULL
GROUP BY 1,2 ORDER BY 2,1;

(GIA M.D.E  DINOYME TIMH STO PROGCODE ANALOGA ME TON KVDIKO TOY PROGRAMMATOS);

===============================================================================================================;
6A. * DIPLVMATOYXOI ANA PERIODO DIPLVMATIKHS GIA DOSMENO ETOS APOFOITHSHS; (NIKOS)
select k_tm||';'||period||';'||@trim(epvn)||';'||@trim(onoma)||';'||@trim(patr)||';'||sex||';'||birthdate||';'||@trim(pltext)||';'||etosdipl||';'||ardipl||';'||gradeapof from hst_f ,pltab
where etosdipl = :1  and plcolumn = 'TOPOSG' and plcode = poliorig and pllang = 'G' order by period  ,epvn,onoma,patr;

6B. * DIPLVMATOYXOI ANA PERIODO DIPLVMATIKHS GIA DOSMENO ETOS APOFOITHSHS XVRIS POLH GENNHSHS ; (NIKOS)
Select k_tm||';'||period||';'||@trim(epvn)||';'||@trim(onoma)||';'||@trim(patr)||';'||sex||';'||birthdate||';'||etosdipl||';'||ardipl||';'||gradeapof  from hst_f 
where etosdipl = :1 AND  poliorig IS NULL order by period  ,epvn,onoma,patr;
(6A + 6B) PLHRES.

6C. * DIPLVMATOYXOI ANA PERIODO DIPLVMATIKHS ME THEMA, TRIMELH EPITROPH, HM.EJETASHS K.L.P;

select hst_f.period||';'||hst_f.k_f||';'||@trim(hst_f.epvn)||' '||@trim(hst_f.onoma)||';'||dep.onoma, dep.epvn||';'||
hst_f.titlosmau,hst_f.thema||';'||hst_f.moana||';'||hst_f.dateejet  
from hst_f,diplgrade,dep,anathesi,diplsynerg
where diplgrade.codesyn = diplsynerg.codesyn and diplsynerg.codesyn = anathesi.codesyn and diplsynerg.k_f = hst_f.k_f 
and dep.am_dep = diplgrade.am_dep
and etosdipl = :1 and hst_f.k_tm =  'KVDIKOS TMHMATOS'  order by hst_f.period, hst_f.epvn,hst_f.onoma ;

===============================================================================================================;

7. ENERGOI ALLODAPOI FOITHTES EGGEGRAMMENOI STO TREXON ETOS;

SELECT TROP_EIS.PLTEXT||';'||XVRA_YPHK.PLTEXT||';'||ORIGIN.PLTEXT||';'||COUNT(K_F)
FROM ST_F, PLTAB XVRA_YPHK, PLTAB TROP_EIS, PLTAB ORIGIN WHERE ST_F.K_TM = "ANTISTOIXOS KVDIKOS" 
and TROPOS IN ('004','003', '022') and TROP_EIS.plcode = ST_F.TROPOS
and TROP_EIS.PLCOLUMN= 'TROPOS'
and XVRA_YPHK.PLCOLUMN= 'YPHK' and XVRA_YPHK.PLCODE= ST_F.YPHK AND ORIGIN.PLCOLUMN = 'YPHK' AND ORIGIN.PLCODE = ST_F.COORIG
and (stustatus != 'DI' or stustatus is null) and ( st_f.status != '01' or status is null) and k_f in (select k_f from egrafi where ak = "TREXON ETOS")
GROUP BY TROP_EIS.PLTEXT,XVRA_YPHK.PLTEXT,ORIGIN.PLTEXT ;

============================================================================================================================;
============================================================================================================================;

8. AR. FOITHTVN ANA ETOS THN TEL. 10ETIA;
select ak||';'||count(k_f) from st_f where k_f > '0'||:1||'094000' group by ak order by ak desc;

============================================================================================================================;

9. AR. SPOYDASTVN ANA ETOS KAI ANA TROPO EISAGVGHS GIA THN TEL. 10ETIA;
select pltext||';'||ak||';'||count(k_f) from st_f,pltab where k_f > '0'||:1||'094000' and plcolumn = 'TROPOS' and plcode = tropos
group by pltext, ak order by AK , PLTEXT;

============================================================================================================================;

10. AR. EGGEGR. FOITHTVN ANA MATHIMA;
select  st_m.k_m||';'||@trim(titlos)||';'||count(kartella.k_f) from kartella, st_m  where kartella.ak = 'TREXON ETOS' and kartella.k_m = st_m.k_m and kartella.ak = st_m.ak 
and st_m.xu = kartella.xu group by  st_m.k_m, titlos order by st_m.titlos;

============================================================================================================================;

11. MESH BATHMOLOGIA FOITHTVN ANA MATHIMA ANA TROPO EISAGVGHS;
A. KANONIKHS;
select KARTELLA.k_m||';'||@trim(ST_M.TITLOS)||';'||pltext||';'||@round(avg(gradenor),2)||';'||count(st_f.k_f) from kartella, st_f, pltab, ST_M 
where kartella.ak = 'TREXON ETOS' and plcolumn= 'TROPOS' and plcode = tropos
and kartella.xu = 'TREXON XU' and Kartella.k_f = st_f.k_f AND gradenor >= 0 AND ST_M.K_M = KARTELLA.K_M 
AND KARTELLA.AK = ST_M.AK group by pltext, KARTELLA.k_m, st_m.titlos 
order by ST_m.titlos ,PLTEXT ;
B. EPANALHPTIKHS;
select KARTELLA.k_m||';'||@trim(ST_M.TITLOS)||';'||pltext||';'||@round(avg(gradepan),2)||';'||count(st_f.k_f) from kartella, st_f, pltab, ST_M 
where kartella.ak = 'TREXON ETOS' and plcolumn= 'TROPOS' and plcode = tropos
and kartella.xu = 'TREXON XU' and Kartella.k_f = st_f.k_f AND gradepan >= 0 AND ST_M.K_M = KARTELLA.K_M 
AND KARTELLA.AK = ST_M.AK group by pltext, KARTELLA.k_m, st_m.titlos 
order by ST_m.titlos ,PLTEXT ;

============================================================================================================================;

12. MESOS AR. EKSETASEVN ANA MATHIMA & ANA TROPO EISAGVGHS ;
create table km05 (km integer);
insert into km05
select distinct k_m from kartella where ak = 'ETOS';

create table kf05 (kf varchar(8) , km integer);
insert into kf05
select k_f,k_m from kartella,km05 where ak =  'ETOS' and k_m = km
and k_f in (select k_f from kartella where k_m = km and  (gradenor >4 or gradepan > 4 or gradexari >4) and ak = 'ETOS' ) ;

create table kmtimes (kf varchar(8), km integer, times integer, tr varchar(3) );
insert into kmtimes 
select kf, km, count(kf), null from kartella,kf05 where k_m = km and k_f = kf group by 1, 2, 4 ; 

update kmtimes set tr = (select tropos from st_f where k_f = kf );

select pltext||';'||km||';'||@trim(titlos)||';'||@round(avg(times), 2) from kmtimes, pltab, st_m where plcolumn = 'TROPOS' and plcode = tr  and k_m = km and ak = 'ETOS'
group by pltext , titlos, km order by titlos, km,  pltext;

DROP TABLE KM05;
DROP TABLE KF05;
DROP TABLE KMTIMES;

============================================================================================================================;
============================================================================================================================;








