=====================================================================================================================;

							        ΕΛΕΓΧΟΙ ΓΙΑ ΠΟΙΟ ΑΞΙΟΠΙΣΤΗ ΣΥΛΛΟΓΗ ΣΤΑΤΙΣΤΙΚΩΝ

1. Ελέγχω ποιοί φοιτητές δεν έχουν φύλο;

select mitroo from met where sex is null;

2. Ελέγχο ποιοί φοιτητές δεν έχουν ημερομηνία γέννησης;

select mitroo from met where birthdate is null;

=====================================================================================================================;

Γ2 Μεταπτυχιακοί φοιτητές κατά φύλο και επίπεδο σπουδών;

Το ακαδημαϊκό έτος μπαίνει σαν παράμεντρος στο ερώτημα και η διάρκεια του είναι από 1η Σεπτεμβρίου 
του προηγούμενου έτους από αυτό που δώσατε σαν παράμετρο έως 31 Αυγούστου του έτους που δώσατε
Για παράδειγμα αν δώσετε 2009 η διάρκεια υπολογισμού είναι από 1 Σεπτεμβίου 2008 έως 31 Αυγούστου 2009;

select progcode as "ΠΡΟΓΡΑΜΜΑ",@if(@value(sex)-1,'Θήλεις','Άρρενες') as "ΦΥΛΟ", count(met.mitroo)  as "ΠΛΗΘΟΣ" from met,metstuprog 
where met.mitroo = metstuprog.mitroo and (dateanag is null or dateanag >='01-SEP-'||@string(:1,0) ) 
and met.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null)
group by 1,2;



=======================================================================================================================;
     

                                                    Δ' ΦΟΙΤΗΤΕΣ - ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ;

Δ3 Μεταπτυχιακοί φοιτητές κατά φύλο, επίπεδο σπουδών και έτος γέννησης;

Το ακαδημαϊκό έτος μπαίνει σαν παράμεντρος στο ερώτημα και η διάρκεια του είναι από 1η Σεπτεμβρίου 
του προηγούμενου έτους από αυτό που δώσατε σαν παράμετρο έως 31 Αυγούστου του έτους που δώσατε
Για παράδειγμα αν δώσετε 2009 η διάρκεια υπολογισμού είναι από 1 Σεπτεμβίου 2008 έως 31 Αυγούστου 2009;

select progcode as "ΠΡΟΓΡΑΜΜΑ",@if(@value(sex)-1,'Θήλεις','Άρρενες') as "ΦΥΛΟ",@mid(birthdate,0,4) as "ΕΤΟΣ ΓΕΝΝΗΣΗΣ", count(met.mitroo)  as "ΠΛΗΘΟΣ" from met,metstuprog 
where met.mitroo = metstuprog.mitroo and (dateanag is null or dateanag >='01-SEP-'||@string(:1,0) ) 
and met.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null)
group by 1,2,3 order by 1,2,3 desc;




=======================================================================================================================;

                                                                          Ε' ΠΤΥΧΙΟΥΧΟΙ;

E1 Αριθμός φοιτητών που πήραν μεταπτυχιακό ή διδακτορικό δίπλωμα του Ακαδημαϊκού έτους;

Το ακαδημαϊκό έτος μπαίνει σαν παράμεντρος στο ερώτημα και η διάρκεια του είναι από 1η Σεπτεμβρίου 
του προηγούμενου έτους από αυτό που δώσατε σαν παράμετρο έως 31 Αυγούστου του έτους που δώσατε
Για παράδειγμα αν δώσετε 2009 η διάρκεια υπολογισμού είναι από 1 Σεπτεμβίου 2008 έως 31 Αυγούστου 2009;

select progcode as "ΠΡΟΓΡΑΜΜΑ", @if(@value(sex)-1,'Θήλεις','Άρρενες') as "ΦΥΛΟ", count(met.mitroo) as "ΠΛΗΘΟΣ" from met, metstuprog
where met.mitroo = metstuprog.mitroo 
and dateanag >'31-AUG-'||@string(:1-1,0) and dateanag <'01-SEP-'||@string(:1,0) and dateanag is not null 
group by progcode,sex;


=============================================================================================================;

D2.;
select * from met;
SELECT * FROM PLTAB WHERE PLCOLUMN = 'YPHK' ORDER BY PLTEXT;
select @mid(birthdate,0,4),count(metstuprog.mitroo),metstuprog.progcode,sex from met,metstuprog where
met.mitroo = metstuprog.mitroo and dateanag  >= '01-SEP-2004' and dateanag <='31-AUG-2005' group by 3,4,1 order by 3,4,1;
CREATE TABLE DIAKOPTMP ( MITROO VARCHAR(8) NOT NULL);
INSERT INTO DIAKOPTMP select mitroo from METDIAKOP where (DATEAPO <=  '31-AUG-2005' or dateapo is null) and  (DATEEOS is  null OR DATEEOS > '31-AUG-2005');
delete from birthtmp;
CREATE TABLE BIRTHTMP(MITROO VARCHAR(8) NOT NULL, BIRTHDATE DATE);
INSERT INTO BIRTHTMP SELECT METSTUPROG.MITROO,BIRTHDATE FROM MET, METSTUPROG  
WHERE  METSTUPROG.PROGCODE = 1  AND SEX = 2
 and METSTUPROG.MITROO = MET.MITROO and 2005 >= METSTUPROG.AK 
 AND dateanag is  null OR DATEANAG > '31-AUG-2005' 
 and MET.TMIMACODE =  4;
select * from birthtmp where birthdate is null;
DELETE FROM BIRTHTMP WHERE MITROO IN (SELECT MITROO FROM  DIAKOPTMP);
select mitroo from birthtmp where birthdate > '01-JAN-2006';
SELECT @MID(BIRTHDATE,0,4),COUNT(MITROO)
FROM BIRTHTMP
GROUP BY 1   ORDER BY 1;
select * from metdiakop where dateapo is null and progcode =1;
DROP TABLE DIAKOPTMP;
DROP TABLE BIRTHTMP;
select * from met where coorig = '0099';
delete from coorig;
create table coorig (mitroo varchar(8), coorig varchar(4),sex varchar(1));
insert into coorig select mitroo,;
delete from coorig;
INSERT INTO coorig SELECT METSTUPROG.MITROO,coorig,sex FROM MET, METSTUPROG  
WHERE  (METSTUPROG.PROGCODE = 2 or  METSTUPROG.PROGCODE =3  or metstuprog.progcode =1) AND SEX = 2
 and METSTUPROG.MITROO = MET.MITROO and 2005 >= METSTUPROG.AK 
 AND (dateanag is  null OR DATEANAG > '31-AUG-2005') and coorig != '0099' and coorig !='0222'
 and MET.TMIMACODE =  4;

INSERT INTO coorig SELECT METSTUPROG.MITROO,coorig,sex FROM MET, METSTUPROG  
WHERE ( metstuprog.progcode =2 or   metstuprog.progcode =3 ) AND SEX = 2
 and METSTUPROG.MITROO = MET.MITROO and 2005 >= METSTUPROG.AK 
 AND (dateanag is  null OR DATEANAG > '31-AUG-2005') and coorig != '0099' and coorig !='0222'
 and MET.TMIMACODE =  4;

delete from coorig;
delete from coorig where mitroo in (select mitroo from diakoptmp);

select * from coorig;


DROP TABLE DIAKOPTMP;
DROP TABLE BIRTHTMP;
DROP TABLE COORIG;


;ΑΡΙΘΜΟΣ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΦΟΙΤΗΤΩΝ ΠΟΥ ΕΓΓΡΑΦΟΝΤΑΙ ΓΙΑ ΔΕΥΤΕΡΟ ΜΕΤΑΠΤΥΧΙΑΚΟ ΤΙΤΛΟ ΣΠΟΥΔΩΝ ΚΑΤΑ ΦΥΛΟ ΚΑΙ ΕΠΙΠΕΔΟ ΣΠΟΥΔΩΝ
;(ΠΕΡΙΛΑΜΒΑΝΕΙ ΜΟΝΟ ΑΥΤΟΥΣ ΠΟΥ ΕΧΟΥΝ ΚΑΝΕΙ ΜΕΤΑΠΤΥΧΙΑΚΟ ΣΤΗΝ ΙΔΙΑ ΣΧΟΛΗ)

select count(met.mitroo),sex
from metstuprog,met
where met.mitroo = metstuprog.mitroo and metstuprog.progcode = :1 
and dateanag is null 
and met.mitroo not in (select mitroo from metdiakop where dateapo < sysdate and (dateeos is null or dateeos > sysdate) and progcode=:1) 
and met.mitroo in ( select mitroo from metstuprog where dateanag is not null and progcode!=:1) group by 2;

;ΑΡΙΘΜΟΣ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΑΠΟΦΟΙΤΩΝ ΚΑΤΑ ΦΥΛΟ, ΗΛΙΚΙΑ ΚΑΙ ΕΠΙΠΕΔΟ ΣΠΟΥΔΩΝ
;(ΠΕΡΙΛΑΜΒΑΝΕΙ ΜΟΝΟ ΑΥΤΟΥΣ ΠΟΥ ΕΧΟΥΝ ΚΑΝΕΙ ΜΕΤΑΠΤΥΧΙΑΚΟ ΣΤΗΝ ΙΔΙΑ ΣΧΟΛΗ)

select count(met.mitroo),@year(sysdate)-@year(birthdate),sex
from metstuprog,met
where met.mitroo = metstuprog.mitroo and metstuprog.progcode = :1 
and dateanag is null 
and met.mitroo not in (select mitroo from metdiakop where dateapo < sysdate and (dateeos is null or dateeos > sysdate) and progcode=:1) 
and met.mitroo in ( select mitroo from metstuprog where dateanag is not null and progcode!=:1) group by 3,2;
