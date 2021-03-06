
   						                	metuniv
___________________________________________________________________________________;

drop index metuniv_idx;
create unique index metuniv_idx on metuniv (univcode);
update statistics on index metuniv_idx;
alter table metuniv modify univcode not null;
alter table metuniv modify titlos not null;
alter table metuniv drop primary key;
alter table metuniv primary key (univcode);
alter table metuniv foreign key pryt_fk(am_pryt) references dep on delete restrict;
alter table metuniv foreign key ant1_fk(am_ant1) references dep on delete restrict;
alter table metuniv foreign key ant2_fk(am_ant2) references dep on delete restrict;
alter table metuniv foreign key gram_fk(am_gram) references ypal on delete restrict;



   									tmhma
___________________________________________________________________________________;

drop index tmhma_idx;
create unique index tmhma_idx on tmhma(k_tm);
update statistics on index tmhma_idx;
alter table tmhma modify k_tm  not null;
insert into tmhma (k_tm,titlos) values (1,'ΠΟΛΙΤΙΚΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into tmhma (k_tm,titlos) values (2,'ΜΗΧΑΝΟΛΟΓΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into tmhma (k_tm,titlos) values (3,'ΗΛΕΚΤΡΟΛΟΓΩΝ ΜΗΧΑΝΙΚΩΝ ΚΑΙ ΜΗΧΑΝΙΚΩΝ ΥΠΟΛΟΓΙΣΤΩΝ');
insert into tmhma (k_tm,titlos) values (4,'ΑΡΧΙΤΕΚΤΟΝΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into tmhma (k_tm,titlos) values (5,'ΧΗΜΙΚΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into tmhma (k_tm,titlos) values (6,'ΑΓΡΟΝΟΜΩΝ ΚΑΙ ΤΟΠΟΓΡΑΦΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into tmhma (k_tm,titlos) values (7,'ΜΗΧΑΝΙΚΩΝ ΜΕΤΑΛΛΕΙΩΝ ΜΕΤΑΛΛΟΥΡΓΩΝ');
insert into tmhma (k_tm,titlos) values (8,'ΝΑΥΠΗΓΩΝ ΜΗΧΑΝΟΛΟΓΩΝ ΜΗΧΑΝΙΚΩΝ');
insert into tmhma (k_tm,titlos) values (9,'ΕΦΑΡΜΟΣΜΕΝΩΝ ΜΗΧΑΝΙΚΩΝ ΚΑΙ ΦΥΣΙΚΩΝ ΕΠΙΣΤΗΜΩΝ');
alter table tmhma drop primary key;
alter table tmhma primary key (k_tm);




   									dep
___________________________________________________________________________________;

drop index dep_idx;
create unique index dep_idx on dep (am_dep);
update statistics on index dep_idx;
alter table dep modify am_dep not null;
alter table dep modify epvn not null;
select * from dep where epvn is null;
delete from dep where epvn is null;
alter table dep modify onoma not null;
alter table dep drop primary key;
alter table dep primary key (am_dep);


   									ypal
___________________________________________________________________________________;

drop index ypal_idx;
create unique index ypal_idx on ypal (k_ypal);
update statistics on index ypal_idx;
alter table ypal modify k_ypal not null;
alter table ypal modify k_tm not null;
update ypal set k_tm = :1 where k_tm is null;
alter table ypal modify epvn not null;
alter table ypal modify onoma not null;
alter table ypal drop primary key;
alter table ypal primary key (k_ypal);
alter table ypal foreign key tmhma_fk (k_tm) references tmhma on delete restrict;



   									mettmima
___________________________________________________________________________________;

drop index mettmima_idx;
create unique index mettmima_idx on mettmima (tmimacode);
update statistics on index mettmima_idx;
alter table mettmima modify tmimacode not null;
alter table mettmima modify titlos not null;
alter table mettmima modify univcode not null;
alter table mettmima drop primary key;
alter table mettmima primary key (tmimacode);
alter table mettmima foreign key metuniv_fk (univcode) references metuniv on delete restrict;
alter table mettmima foreign key pro_fk (am_pro) references dep on delete restrict;
alter table mettmima foreign key anpro_fk (am_anpro) references dep on delete restrict;
alter table mettmima foreign key gram_fk (am_gram) references ypal on delete restrict;
alter table mettmima foreign key angram_fk (am_angram) references ypal on delete restrict;



								


   									met_ist
___________________________________________________________________________________;

drop index met_ist_idx;
create unique index met_ist_idx on met_ist (mitroo,datemodif);
update statistics on index met_ist_idx;
alter table met_ist modify mitroo not null;
alter table met_ist modify datemodif not null;
alter table met_ist modify patr varchar(30);
alter table met_ist modify mhtr varchar(30);
alter table met_ist modify email varchar(50);
alter table met_ist modify ar_t varchar(8);
alter table met_ist modify tel1 varchar(30);
alter table met_ist modify usrname varchar(30);
or;
alter table met_ist add usrname1 varchar(30);
update met_ist set usrname1 = usrname;
alter table met_ist drop usrname;
alter table met_ist rename usrname1 usrname;

alter table met_ist add ofeiles varchar(10);
alter table met_ist add paravolo varchar(1);
alter table met_ist add mhxanik varchar(1);
alter table met_ist add work varchar(1);
alter table met_ist add dimoskinot integer;
alter table met_ist drop comment;
alter table met_ist add erasmus varchar(1);
alter table met_ist drop primary key;
alter table met_ist primary key (mitroo,datemodif);




   									met_web
___________________________________________________________________________________;

drop index met_web_idx;
create unique index met_web_idx on met_web (mitroo,datemodif);
update statistics on index met_web_idx;
alter table met_web modify mitroo not null;
alter table met_web modify datemodif not null;
alter table met_web modify patr varchar(30);
alter table met_web modify mhtr varchar(30);
alter table met_web modify email varchar(50);
alter table met_web modify ar_t varchar(8);
alter table met_web modify tel1 varchar(30);
alter table met modify  usrname varchar(30);
or;
alter table met_web add usrname1 varchar(30);
update met_web set usrname1 = usrname;
alter table met_web drop usrname;
alter table met_web rename usrname1 usrname;

alter table met_web add ofeiles varchar(10);
alter table met_web add paravolo varchar(1);
alter table met_web add mhxanik varchar(1);
alter table met_web add work varchar(1);
alter table met_web add dimoskinot integer;
alter table met_web drop comment;
alter table met_web add erasmus varchar(1);
alter table met_web primary key (mitroo,datemodif);



								met
___________________________________________________________________________________;

drop index met_idx;
create unique index met_idx on met (mitroo);
update statistics on index met_idx;
drop trigger met_del;
drop trigger met_ins;
drop trigger met_updt;
drop trigger met_ins_sn;
alter table met modify mitroo not null;
alter table met modify tmimacode not null;
update met set tmimacode = :1 where tmimacode is null;
alter table met modify epvn not null;
select * from met where epvn is null;
delete from met where epvn is null;
alter table met modify onoma not null;
alter table met modify patr varchar(30);
alter table met modify mhtr varchar(30);
alter table met modify email varchar(50);
alter table met modify ar_t varchar(8);
alter table met modify tel1 varchar(30);
alter table met modify  usrname varchar(30);
or ;
alter table met add usrname1 varchar(30);
update met set usrname1 = usrname;
alter table met drop usrname;
alter table met rename usrname1 usrname;

alter table met add ofeiles varchar(10);
alter table met add paravolo varchar(1);

erase met_proc;

store met_proc
procedure met_proc static
 	parameters
   		string   	 	: modiftype
   		string    		: mitroo
   		number 		: tmimacode
   		string    		: ar_t
   		string    		: epvn
   		string    		: onoma
   		string    		: patr
   		string    		: mhtr
   		string    		: sex
   		string    		: yphk
   		string    		: coorig
   		string    		: nomosorig
  		string    		: poliorig
   		date/time 		: birthdate
   		string    		: nomosmhtr
   		string    		: polimhtr
   		number		: dimoskinot
   		string	    		: dimotologio
   		string 	   	: cokat
   		string  	  	: nomoskat
   		string   	 	: polikat
  		string   	 	: perioxi
   		string   	 	: odos
   		string   	 	: tt
   		string   	 	: tel1
   		string   	 	: tel2
   		string   	 	: email
		string   	 	: work
		string   	 	: mhxanik
		string   	 	: usrname
		string   	 	: ofeiles
		string   	 	: paravolo
		string 		: erasmus
 	local variables
   		sql handle: hsql1
   		sql handle: hsql2
 	actions
   		on procedure startup
    			call sqlconnect( hsql1 )
    			call sqlconnect( hsql2 )
   		on procedure execute
			call sqlprepare( hsql1 , 'insert into met_web(
										datemodif, modiftype, mitroo, tmimacode, ar_t, epvn, onoma, patr, mhtr, sex, yphk, coorig, nomosorig, 
										poliorig, birthdate, nomosmhtr, polimhtr, dimoskinot, dimotologio, cokat, nomoskat, polikat, perioxi, odos, tt, tel1, 
										tel2, email, work, mhxanik, usrname, ofeiles,paravolo,erasmus)
     							      	       values(
										sysdatetime, :modiftype, :mitroo, :tmimacode, :ar_t, :epvn, :onoma, :patr, :mhtr, :sex, :yphk, :coorig, :nomosorig,
										:poliorig, :birthdate, :nomosmhtr, :polimhtr,  :dimoskinot, :dimotologio, :cokat, :nomoskat, :polikat, :perioxi, :odos, :tt, :tel1,
										:tel2, :email,  :work, :mhxanik, :usrname, :ofeiles, :paravolo,  :erasmus )' )
    			call sqlexecute( hsql1 )
    			call sqlprepare( hsql2 , 'insert into met_ist(
										username, datemodif, modiftype, mitroo, tmimacode, ar_t, epvn, onoma, patr, mhtr, sex, yphk, coorig, nomosorig, 
										 poliorig, birthdate, nomosmhtr, polimhtr, dimoskinot, dimotologio, cokat, nomoskat, polikat, perioxi, odos, tt, tel1, 
										tel2, email, work,mhxanik, usrname, ofeiles,paravolo, erasmus)
     							               values(
										user, sysdatetime, :modiftype, :mitroo, :tmimacode, :ar_t, :epvn, :onoma, :patr, :mhtr, :sex, :yphk, :coorig, :nomosorig,
										:poliorig, :birthdate, :nomosmhtr, :polimhtr,  :dimoskinot, :dimotologio, :cokat, :nomoskat, :polikat, :perioxi, :odos, :tt, :tel1,
										:tel2, :email,  :work, :mhxanik, :usrname, :ofeiles, :paravolo,  :erasmus ) ' )
    			call sqlexecute( hsql2 )
   		on procedure close
    			call sqldisconnect( hsql1 )
    			call sqldisconnect( hsql2 );

create trigger sysadm.met_ins after insert on met
	( execute met_proc (
				'i', met.mitroo, met.tmimacode, met.ar_t, met.epvn, met.onoma, met.patr, met.mhtr, met.sex, met.yphk, met.coorig, met.nomosorig, 
				met.poliorig, met.birthdate, met.nomosmhtr, met.polimhtr, met.dimoskinot, met.dimotologio, met.cokat, met.nomoskat, met.polikat, 
				met.perioxi, met.odos, met.tt, met.tel1, met.tel2, met.email, met.work, met.mhxanik, met.usrname, met.ofeiles,  met.paravolo, met.erasmus) )
for each row;


create trigger sysadm.met_del after delete on met
	( execute met_proc (
				'd', met.mitroo, met.tmimacode, met.ar_t, met.epvn, met.onoma, met.patr, met.mhtr, met.sex, met.yphk, met.coorig, met.nomosorig, 
				met.poliorig, met.birthdate, met.nomosmhtr, met.polimhtr, met.dimoskinot, met.dimotologio, met.cokat, met.nomoskat, met.polikat, 
				met.perioxi, met.odos, met.tt, met.tel1, met.tel2, met.email, met.work, met.mhxanik, met.usrname, met.ofeiles,  met.paravolo, met.erasmus) )
for each row;


create trigger sysadm.met_updt after update on met referencing old as old_met new as new_met
  	( execute met_proc (
				'u', met.mitroo, met.tmimacode, met.ar_t, met.epvn, met.onoma, met.patr, met.mhtr, met.sex, met.yphk, met.coorig, met.nomosorig, 
				met.poliorig, met.birthdate, met.nomosmhtr, met.polimhtr, met.dimoskinot, met.dimotologio, met.cokat, met.nomoskat, met.polikat, 
				met.perioxi, met.odos, met.tt, met.tel1, met.tel2, met.email, met.work, met.mhxanik, met.usrname, met.ofeiles,  met.paravolo, met.erasmus) )
for each row;

alter table met drop primary key;
alter table met primary key (mitroo);
alter table met foreign key mettmima_fk (tmimacode) references mettmima on delete restrict;



   									metlang
___________________________________________________________________________________;

drop index metlang_idx;
create unique index metlang_idx on metlang (mitroo,seqno);
update statistics on index metlang_idx;
alter table metlang modify mitroo not null;
alter table metlang modify seqno not null;
alter table metlang modify langcode not null;
select * from metlang where langcode is null;
delete from metlang where langcode is null;


select plcode,pltext from pltab where plcolumn = 'LANGCODE';

insert into pltab values ('LANGCODE',1,'g',null,'ΑΓΓΛΙΚΑ');
insert into pltab values ('LANGCODE',2,'g',null,'ΓΑΛΛΙΚΑ');
insert into pltab values ('LANGCODE',3,'g',null,'ΓΕΡΜΑΝΙΚΑ');
insert into pltab values ('LANGCODE',4,'g',null,'ΙΤΑΛΙΚΑ');
insert into pltab values ('LANGCODE',5,'g',null,'ΙΣΠΑΝΙΚΑ');
insert into pltab values ('LANGCODE',6,'g',null,'ΚΙΝΕΖΙΚΑ');


alter table metlang drop primary key;
alter table metlang primary key (mitroo,seqno);
alter table metlang foreign key met_fk (mitroo) references met on delete restrict;




   									metptyx
___________________________________________________________________________________;

drop index metptyx_idx;
create unique index metptyx_idx on metptyx (mitroo,seqno);
update statistics on index metptyx_idx;
alter table metptyx modify mitroo not null;
alter table metptyx modify seqno not null;
alter table metptyx drop primary key;
alter table metptyx primary key (mitroo,seqno);
alter table metptyx foreign key met_fk (mitroo) references met on delete restrict;



   									metprogram
___________________________________________________________________________________;

drop index metprog_idx;
drop index metprogram_idx;
create unique index metprogram_idx on metprogram (progcode);
update statistics on index metprogram_idx;
alter table metprogram modify progcode not null;
alter table metprogram modify tmimacode not null;
alter table metprogram modify titlos not null;
alter table metprogram drop limit;
alter table metprogram drop wdipl;
alter table metprogram drop arcourdipl;
alter table metprogram drop limitdipl;
alter table metprogram drop roundmo;
alter table metprogram drop lectper;
alter table metprogram drop primary key;
alter table metprogram primary key (progcode);
alter table metprogram foreign key mettmima_fk (tmimacode) references mettmima on delete restrict;
alter table metprogram foreign key dep_fk (am_dep) references dep on delete restrict;
alter table metprogram foreign key an_dep_fk (am_an_dep) references dep on delete restrict;



   									metprogat
___________________________________________________________________________________;

drop index metprogat_idx;
create unique index metprogat_idx on metprogat (ak,progcode);
update statistics on index metprogat_idx;
alter table metprogat modify tmimacode not null;
alter table metprogat modify progcode not null;
alter table metprogat modify ak not null;
alter table metprogat drop primary key;
alter table metprogat primary key (ak,progcode);
alter table metprogat foreign key metprogram_fk  (progcode) references metprogram on delete restrict;



   									metprocorp
___________________________________________________________________________________;

drop index metprocorp_idx;
create unique index metprocorp_idx on metprocorp (progcode,corpcode);
update statistics on index metprocorp_idx;
alter table metprocorp modify tmimacode not null;
alter table metprocorp modify progcode not null;
alter table metprocorp modify corpcode not null;
alter table metprocorp drop primary key;
alter table metprocorp primary key (progcode,corpcode);
alter table metprocorp foreign key metprogram_fk (progcode) references metprogram on delete restrict;
alter table metprocorp foreign key metcorp_fk  (corpcode) references mettmima on delete restrict;
alter table metprocorp foreign key metuniv_fk  (univcode) references metuniv on delete restrict;


   									metkatef
___________________________________________________________________________________;

select 'select kat from '||name||';' from systables where name like 'MET%';

;column kat must be in the following tables;
select kat from metkatef;
select kat from metprospu;
select kat from metstuprog;
select kat from metstuprog_ist;
select kat from metstuprog_web;
select kat from met_kart_disk;

drop index metkat_idx;
drop index metkatef_idx;
create unique index metkatef_idx on  metkatef (kat);

alter table metkatef drop primary key;

update metkatef set kat = '10' where kat = '00' and progcode = 1; 
update metprospu set kat = '10' where kat = '00' and progcode = 1; 
update metstuprog set kat = '10' where kat = '00' and progcode = 1; 
update metstuprog_ist set kat = '10' where kat = '00' and progcode = 1; 
update metstuprog_web set kat = '10' where kat = '00' and progcode = 1; 
update met_kart_disk set kat = '10' where kat = '00' and progcode = 1; 

update metkatef set kat = '20' where kat = '00' and progcode = 2; 
update metprospu set kat = '20' where kat = '00' and progcode = 2; 
update metstuprog set kat = '20' where kat = '00' and progcode = 2; 
update metstuprog_ist set kat = '20' where kat = '00' and progcode = 2; 
update metstuprog_web set kat = '20' where kat = '00' and progcode = 2; 
update met_kart_disk set kat = '20' where kat = '00' and progcode = 2; 

update metkatef set kat = '30' where kat = '00' and progcode = 3; 
update metprospu set kat = '30' where kat = '00' and progcode = 3; 
update metstuprog set kat = '30' where kat = '00' and progcode = 3; 
update metstuprog_ist set kat = '30' where kat = '00' and progcode = 3; 
update metstuprog_web set kat = '30' where kat = '00' and progcode = 3; 
update met_kart_disk set kat = '30' where kat = '00' and progcode = 3; 

update statistics on index metkatef_idx;
alter table  metkatef modify kat not null;
alter table  metkatef modify progcode not null;
alter table  metkatef modify tmimacode not null;
alter table  metkatef modify titlos not null;

alter table metkatef drop primary key;
alter table  metkatef primary key (kat);
alter table  metkatef foreign key metprogram_fk  (progcode) references metprogram on delete restrict;
alter table  metkatef foreign key dep_fk (depcode) references dep on delete restrict;


   									mettomeis
___________________________________________________________________________________;

drop index mettomeis_idx;
create unique index mettomeis_idx on  mettomeis (tomcode);
update statistics on index mettomeis_idx;
alter table  mettomeis modify tomcode not null;
alter table  mettomeis modify tmimacode not null;
alter table  mettomeis modify titlos not null;
alter table  mettomeis drop univcode;
alter table mettomeis add am_dep integer;
alter table mettomeis drop primary key;
alter table  mettomeis primary key (tomcode);
alter table  mettomeis foreign key mettmima_fk  (tmimacode) references mettmima on delete restrict;
alter table  mettomeis foreign key dep_fk  (am_dep) references dep on delete restrict;




   									metstuprog_ist
___________________________________________________________________________________;

alter table metstuprog_ist add etosdipl integer;
update metstuprog_ist set etosdipl = (select etosdipl from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.etosdipl is null;
alter table metstuprog_ist add perioddipl varchar(1);
update metstuprog_ist set perioddipl = (select perioddipl from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.perioddipl is null;
alter table metstuprog_ist add dateede varchar(10);
update metstuprog_ist set dateede = (select dateede from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.dateede is null;
alter table metstuprog_ist add kat varchar(2);
update metstuprog_ist set kat = (select kat from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.kat is null;
alter table metstuprog_ist add tomcode integer;
update metstuprog_ist set tomcode = (select tomcode from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.tomcode is null;
alter table metstuprog_ist add depcode integer;
update metstuprog_ist set depcode = (select depcode from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.depcode is null;
alter table metstuprog_ist add ak integer;
update metstuprog_ist set ak = (select ak from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.ak is null;
alter table metstuprog_ist add ej varchar(2);
update metstuprog_ist set ej = (select ej from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.ej is null;
alter table metstuprog_ist add praxh varchar(10);
update metstuprog_ist set praxh = (select praxh from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.praxh is null;
alter table metstuprog_ist add ardipl varchar(10);
update metstuprog_ist set ardipl = (select ardipl from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.ardipl is null;
alter table metstuprog_ist add ekp_dipl varchar(1);
update metstuprog_ist set ekp_dipl = (select ekp_dipl from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.ekp_dipl is null;
alter table metstuprog_ist add h_egr datetime;
update metstuprog_ist set h_egr = (select h_egr from metstuprog where metstuprog.mitroo = metstuprog_ist.mitroo  and metstuprog.progcode = metstuprog_ist.progcode) where metstuprog_ist.h_egr is null;


drop index metstuprog_ist_idx;
create unique index metstuprog_ist_idx on metstuprog_ist (mitroo, progcode,datemodif);
update statistics on index metstuprog_ist_idx;
alter table metstuprog_ist modify mitroo not null;
alter table metstuprog_ist modify progcode not null;
alter table metstuprog_ist modify datemodif not null;
alter table metstuprog_ist primary key (mitroo,progcode,datemodif);


   									metstuprog_web
___________________________________________________________________________________;

alter table metstuprog_web add etosdipl integer;
update metstuprog_web set etosdipl = (select etosdipl from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.etosdipl is null;
alter table metstuprog_web add perioddipl varchar(1);
update metstuprog_web set perioddipl = (select perioddipl from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.perioddipl is null;
alter table metstuprog_web add dateede varchar(10);
update metstuprog_web set dateede = (select dateede from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.dateede is null;
alter table metstuprog_web add kat varchar(2);
update metstuprog_web set kat = (select kat from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.kat is null;
alter table metstuprog_web add tomcode integer;
update metstuprog_web set tomcode = (select tomcode from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.tomcode is null;
alter table metstuprog_web add depcode integer;
update metstuprog_web set depcode = (select depcode from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.depcode is null;
alter table metstuprog_web add ak integer;
update metstuprog_web set ak = (select ak from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.ak is null;
alter table metstuprog_web add ej varchar(2);
update metstuprog_web set ej = (select ej from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.ej is null;
alter table metstuprog_web add praxh varchar(10);
update metstuprog_web set praxh = (select praxh from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.praxh is null;
alter table metstuprog_web add ardipl varchar(10);
update metstuprog_web set ardipl = (select ardipl from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.ardipl is null;
alter table metstuprog_web add ekp_dipl varchar(1);
update metstuprog_web set ekp_dipl = (select ekp_dipl from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.ekp_dipl is null;
alter table metstuprog_web add h_egr datetime;
update metstuprog_web set h_egr = (select h_egr from metstuprog where metstuprog.mitroo = metstuprog_web.mitroo  and metstuprog.progcode = metstuprog_web.progcode) where metstuprog_web.h_egr is null;

drop index metstuprog_web_idx;
create unique index metstuprog_web_idx on metstuprog_web (mitroo,progcode,datemodif);
update statistics on index metstuprog_web_idx;
alter table metstuprog_web modify mitroo not null;
alter table metstuprog_web modify progcode not null;
alter table metstuprog_web modify datemodif not null;
alter table metstuprog_web primary key (mitroo,progcode,datemodif);

								
							metstuprog
___________________________________________________________________________________;

select mitroo||progcode from metdsynerg group by 1 having count(mitroo||progcode ) >1;
select * from metdsynerg where mitroo =:1;
select * from metdsynerg where codesyn  =:1;
select * from metstuprog where mitroo= :1;
select * from metdsynerg where mitroo= :1;
select * from metanathesi where codesyn= :1;
select * from metdiplgrade where codesyn= :1;
delete from metanathesi where codesyn=:1;
delete from metdiplgrade where codesyn =:1;
delete from metdsynerg where mitroo= :1 and codesyn != :2;

drop index metstuprog_idx;
create unique index metstuprog_idx on  metstuprog (mitroo,progcode);
update statistics on index metstuprog_idx;
drop trigger metstuprog_del;
drop trigger metstuprog_ins;
drop trigger metstuprog_updt;
drop trigger metstuprog_ins_sn;
alter table metstuprog modify mitroo not null;
alter table metstuprog modify progcode not null;
alter table metstuprog drop primary key;
alter table metstuprog primary key (mitroo,progcode);

select mitroo from metstuprog where mitroo not in (select mitroo from met);
delete from metstuprog where mitroo not in (select mitroo from met);

alter table  metstuprog foreign key met_fk (mitroo) references met on delete restrict;

alter table  metstuprog foreign key metkatef_fk (kat) references metkatef on delete restrict;
alter table  metstuprog foreign key mettomeis_fk (tomcode) references mettomeis on delete restrict;
alter table  metstuprog foreign key metprogram_fk  (progcode) references metprogram on delete restrict;
alter table  metstuprog foreign key dep_fk (depcode) references dep on delete restrict;

erase metstuprog_proc;

store metstuprog_proc
procedure metstuprog_proc static
 	parameters
   		string   	 	: modiftype
   		string    		: mitroo
		number 		: progcode
   		string    		: kat
		number 		: tomcode
		number 		: depcode
		number 		: ak
		string    		: ej
   		string    		: praxh
		number 		: totbau
		string    		: ardipl
		string    		: ekp_dipl
		date/time		: h_egr
		date/time		: dateanag
		string			: dateede
		number 		: etosdipl
		string			: perioddipl
 	local variables
   		sql handle: hsql1
   		sql handle: hsql2
 	actions
   		on procedure startup
    			call sqlconnect( hsql1 )
    			call sqlconnect( hsql2 )
   		on procedure execute
			call sqlprepare( hsql1 , 'insert into metstuprog_web(
										datemodif, modiftype, mitroo, progcode, kat, tomcode, depcode, ak, ej, praxh, totbau, ardipl, ekp_dipl, h_egr, dateanag, dateede, etosdipl, perioddipl)
     							      	       values(
										sysdatetime, :modiftype, :mitroo, :progcode, :kat, :tomcode, :depcode, :ak, :ej, :praxh, :totbau, :ardipl, :ekp_dipl, 	:h_egr, :dateanag, :dateede, :etosdipl, :perioddipl )' )
    			call sqlexecute( hsql1 )
    			call sqlprepare( hsql2 , 'insert into metstuprog_ist(
										username, datemodif, modiftype, mitroo, progcode, kat, tomcode, depcode, ak, ej, praxh, totbau, ardipl, ekp_dipl, h_egr, dateanag, dateede, etosdipl, perioddipl)
     							               values(
										user, sysdatetime, :modiftype, :mitroo, :progcode, :kat, :tomcode, :depcode, :ak, :ej, :praxh, :totbau, :ardipl, :ekp_dipl, :h_egr, :dateanag, :dateede, :etosdipl, :perioddipl )' )
    			call sqlexecute( hsql2 )
   		on procedure close
    			call sqldisconnect( hsql1 )
    			call sqldisconnect( hsql2 );


create trigger sysadm.metstuprog_ins after insert on metstuprog
	( execute metstuprog_proc ( 'i', mitroo, progcode, kat, tomcode, depcode, ak, ej, praxh, totbau, ardipl, ekp_dipl, h_egr, dateanag, dateede, etosdipl, perioddipl) )
for each row;

create trigger sysadm.metstuprog_del after delete on metstuprog
	( execute metstuprog_proc ( 'd', mitroo, progcode, kat, tomcode, depcode, ak, ej, praxh, totbau, ardipl, ekp_dipl, h_egr, dateanag, dateede, etosdipl, perioddipl) )
for each row;

create trigger sysadm.metstuprog_updt after update on metstuprog referencing old as old_metstuprog new as new_metstuprog
	( execute metstuprog_proc ('u',  mitroo, progcode, kat, tomcode, depcode, ak, ej, praxh, totbau, ardipl, ekp_dipl, h_egr, dateanag, dateede, etosdipl, perioddipl) )
for each row;


								metanathesi
___________________________________________________________________________________;

drop index metanathe_idx;
drop index metanathesi_idx;
create unique index metanathesi_idx on metanathesi (codesyn,dateanath);
update statistics on index metanathesi_idx;

drop trigger metanathesi_ins;
drop trigger metanathesi_del;
drop trigger metanathesi_updt;

alter table metanathesi modify codesyn not null;
alter table metanathesi modify tmimacode not null;
alter table metanathesi modify dateanath not null;
select * from metanathesi where dateanath is null;
delete from metanathesi where dateanath is null;

alter table metanathesi drop primary key;
alter table metanathesi primary key (codesyn,dateanath);


								metdiplgrade
-------------------------------------------------------------------------------------------------------------------------------------------------;

drop index metdiplgrade_idx;
create unique index metdiplgrade_idx on metdiplgrade (codesyn,depcode,typedep,dateins);
update statistics on index metdiplgrade_idx;
drop trigger metdiplgrade_del;
drop trigger metdiplgrade_ins;
drop trigger metdiplgrade_updt;
drop trigger metdiplgrade_ins_sn;
alter table metdiplgrade modify codesyn not null;
alter table metdiplgrade modify depcode not null;
alter table metdiplgrade modify typedep not null;
alter table metdiplgrade modify dateins not null;
alter table metdiplgrade drop primary key;
alter table metdiplgrade primary key (codesyn,depcode,typedep,dateins);
alter table metdiplgrade foreign key dep_fk (depcode) references dep on delete restrict;
select * from metdiplgrade where depcode not in (select am_dep from dep);
delete from metdiplgrade where depcode not in (select am_dep from dep);


   									metdsynerg
___________________________________________________________________________________;


drop index metdsynerg_idx;
create unique index metdsynerg_idx on metdsynerg(codesyn,mitroo,progcode);
update statistics on index metdsynerg_idx;
drop trigger metdsynerg_ins_sn;
alter table metdsynerg modify mitroo not null;
alter table metdsynerg modify progcode not null;
select * from metdsynerg where progcode is null;
update metdsynerg set progcode = (select progcode from metstuprog where metstuprog.mitroo = metdsynerg.mitroo) where metdsynerg.progcode is null;
select count(*) from metstuprog where mitroo = :1;

alter table metdsynerg modify codesyn not null;

create trigger metdsynerg_ins_sn before insert on metdsynerg
		   ( execute inline ( codesyn)
	procedure: metdsynerg_ins_sn static
		parameters
			receive number : seqno
		local variables
			sql handle: hsqlcur
			sql handle: hsqlcur2
			number : nnext
		actions
			on procedure startup
				call sqlconnect( hsqlcur )
				call sqlconnect( hsqlcur2 )
				when sqlerror
					call sqlimmediate('rollback')
					call sqlclearimmediate()
				call sqlprepare(hsqlcur, 'select nextsn from tablesn where tablename= \'metdsynerg\' into :seqno' )
				when sqlerror
					call sqlimmediate('rollback')
					call sqlclearimmediate()
				call sqlprepare(hsqlcur2, 'update  tablesn set nextsn = :seqno + 1  where tablename = \'metdsynerg\' ' )
			on procedure execute
				call sqlexecute( hsqlcur )
				call sqlfetchnext( hsqlcur,nnext )
				call sqlexecute( hsqlcur2 )
    			on procedure close
				call sqldisconnect( hsqlcur )
				call sqldisconnect( hsqlcur2 )
  )
for each row;

alter table  metdsynerg drop primary key;
alter table  metdsynerg primary key (codesyn,mitroo,progcode);
alter table  metdsynerg foreign key metstuprog_fk(mitroo,progcode) references metstuprog on delete restrict;
select * from metdsynerg where mitroo||progcode not in (select mitroo||progcode from metstuprog);
select * from met where mitroo =:1;
select * from metstuprog where mitroo =:1;
select * from metdsynerg where mitroo = :1;
select * from metanathesi where codesyn = :1;
select * from metdiplgrade where codesyn = :1;


   									metegr
___________________________________________________________________________________;

drop index metegr_idx;
create unique index metegr_idx on metegr (mitroo,progcode,seqno);
update statistics on index metegr_idx;
alter table metegr modify mitroo not null;
alter table metegr modify tmimacode not null;
alter table metegr modify progcode not null;
alter table metegr modify seqno not null;
alter table metegr modify ak not null;
select * from metegr where ak is null;
alter table metegr modify period not null;
select * from metegr where period is null;

alter table metegr primary key (mitroo,progcode,seqno);
alter table metegr foreign key metstuprog_fk (mitroo,progcode) references metstuprog on delete restrict;

select * from metegr where mitroo||progcode not in (select mitroo||progcode from metstuprog);
delete from metegr where progcode = :1 and mitroo = :2;
   								

   									metprood
___________________________________________________________________________________;

drop index metprood_idx;
select mitroo||progcode||dateprod from metprood  group by 1 having count(mitroo||progcode||dateprod) >1;
select * from metprood where mitroo = :1 and progcode = :2;
select * from metprood where dateprod is null;
delete from metprood where dateprod is null;
delete from metprood where mitroo =:1 and progcode =:2 and seqno =:3;
create unique index metprood_idx on metprood (mitroo,progcode,dateprod);
update statistics on index metprood_idx;
alter table metprood modify mitroo not null;
alter table metprood modify progcode not null;
alter table metprood modify dateprod not null;
select * from metprood where dateprod is null;
delete from metprood where dateprod is null and xarakthrism is null;
alter table metprood modify xarakthrism not null;
select * from metprood where xarakthrism is null;
update metprood set xarakthrism = '2' where xarakthrism is null;
alter table metprood drop primary key;
alter table metprood primary key (mitroo,progcode,dateprod);
alter table metprood foreign key metstuprog_fk (mitroo,progcode) references metstuprog on delete restrict;




   									metdiakop
___________________________________________________________________________________;

drop index metdiakop_idx;
create unique index metdiakop_idx on metdiakop (mitroo,progcode,dateapo);
select mitroo||progcode||dateapo from metdiakop  group by 1 having count(mitroo||progcode||dateapo) >1;
select * from metdiakop where mitroo = :1 and progcode =:2;

update statistics on index metdiakop_idx;
alter table metdiakop modify mitroo not null;
alter table metdiakop modify progcode not null;
alter table metdiakop modify dateapo not null;
select * from metdiakop where dateapo is null;
delete from metdiakop where dateapo is null and gsdatediak is null and aitiologia is null;
update metdiakop set dateapo = gsdatediak where dateapo is null;
alter table metdiakop drop primary key;
alter table metdiakop primary key (mitroo,progcode,dateapo);
alter table metdiakop foreign key metstuprog_fk (mitroo,progcode) references metstuprog on delete restrict;


   									metxrhma
___________________________________________________________________________________;

drop index metxrhma_idx;
create unique index metxrhma_idx on metxrhma (mitroo,progcode,seqno);
update statistics on index metxrhma_idx;
alter table metxrhma modify mitroo not null;
alter table metxrhma modify progcode not null;
alter table metxrhma modify seqno not null;
alter table metxrhma drop primary key;
alter table metxrhma primary key (mitroo,progcode,seqno);
alter table metxrhma foreign key metstuprog_fk (mitroo,progcode) references metstuprog on delete restrict;


   									metkrisi
___________________________________________________________________________________;

drop index metkrisi_idx;
create unique index metkrisi_idx on metkrisi(mitroo,progcode,datekrisi);
update statistics on index metkrisi_idx;
alter table metkrisi modify mitroo not null;
alter table metkrisi modify progcode not null;
alter table metkrisi modify datekrisi not null;
alter table metkrisi modify xarakthrism not null;
alter table metkrisi drop primary key;
alter table metkrisi primary key (mitroo,progcode,datekrisi);
alter table metkrisi foreign key metstuprog_fk(mitroo,progcode) references metstuprog on delete restrict;


   									metkrisidep
___________________________________________________________________________________;

drop index metkrisidep_idx;
create unique index metkrisidep_idx on metkrisidep(mitroo,progcode,am_dep);
update statistics on index metkrisidep_idx;
alter table metkrisidep modify mitroo not null;
alter table metkrisidep modify progcode not null;
alter table metkrisidep modify am_dep not null;
alter table metkrisidep drop primary key;
alter table metkrisidep primary key (mitroo,progcode,am_dep);
alter table metkrisidep foreign key metstuprog_fk(mitroo,progcode) references metstuprog on delete restrict;
alter table metkrisidep foreign key dep_fk(am_dep) references dep on delete restrict;

   									metteach
___________________________________________________________________________________;

drop index metteach_idx;
create unique index metteach_idx on metteach (mitroo,progcode,k_m,ej,ak);
update statistics on index metteach_idx;
alter table metteach modify mitroo not null;
alter table metteach modify progcode not null;
alter table metteach modify k_m not null;
alter table metteach modify ej not null;
alter table metteach modify ak not null;
alter table metteach primary key(mitroo,progcode,k_m,ej,ak);
alter table metteach foreign key metstuprog_fk (mitroo,progcode) references metstuprog on delete restrict;

   									metcourse
___________________________________________________________________________________;

drop index metcour_idx;
drop index metcourse_idx;
create unique index metcourse_idx on   metcourse (courcode,ak);
select courcode||ak from metcourse group by 1 having count(courcode||ak) >1;
select * from metcourse where courcode=:1 and ak =:2;
delete from metcourse where courcode=:1 and ak =:2 and period = '02';
update statistics on index metcourse_idx;
alter table   metcourse modify courcode not null;
alter table   metcourse modify ak not null;
alter table   metcourse modify tmimacode not null;
alter table   metcourse modify titlos not null;
select * from metcourse where titlos is null;
delete from metcourse where titlos is null;
alter table   metcourse drop univcode;

alter table   metcourse primary key (courcode,ak);
alter table   metcourse foreign key mettmima_fk  (tmimacode) references mettmima on delete restrict;
alter table   metcourse foreign key mettmimacodepar_fk  (tmimacodepar) references mettmima on delete restrict;
alter table   metcourse foreign key mettomeis_fk  (tomcodepar) references mettomeis on delete restrict;


   									metdepma
___________________________________________________________________________________;

drop index metdepma_idx;
create unique index metdepma_idx on metdepma (courcode,ak,am_dep);
update statistics on index metdepma_idx;
alter table metdepma modify courcode not null;
alter table metdepma modify ak not null;
alter table metdepma modify am_dep not null;
alter table metdepma drop primary key;
alter table metdepma primary key (courcode,ak,am_dep);
alter table metdepma foreign key metcourse_fk (courcode,ak) references metcourse on delete restrict;
select courcode||ak from metdepma where courcode||ak not in (select courcode||ak from metcourse);
select courcode,ak from metdepma where courcode =:1;
select courcode,ak  from metcourse where courcode =:1;
delete from metdepma where courcode not in (select courcode from metcourse);
delete from metdepma where courcode||ak not in (select courcode||ak from metcourse);
alter table metdepma foreign key dep_fk (am_dep) references dep on delete restrict;


   									metsygr
___________________________________________________________________________________;

drop index metsygr_idx;
create unique index metsygr_idx on metsygr (k_sygr);
update statistics on index metsygr_idx;
alter table metsygr modify k_sygr not null;
alter table metsygr modify titlos not null;
alter table metsygr primary key (k_sygr);


   									metsygrama
___________________________________________________________________________________;

drop index metsygrama_idx;
create unique index metsygrama_idx on metsygrama (courcode,ak,k_sygr);
update statistics on index metsygrama_idx;
alter table metsygrama modify courcode not null;
alter table metsygrama modify ak not null;
alter table metsygrama modify k_sygr not null;
alter table metsygrama primary key (courcode,ak,k_sygr);
alter table metsygrama foreign key metcourse_fk (courcode,ak) references metcourse on delete restrict;
alter table metsygrama foreign key metsygr_fk(k_sygr) references metsygr on delete restrict;



   									metepiblma
___________________________________________________________________________________;

drop index metepiblma_idx;
create unique index metepiblma_idx on metepiblma (courcode,ak,am_dep);
update statistics on index metepiblma_idx;
alter table metepiblma modify courcode not null;
alter table metepiblma modify ak not null;
alter table metepiblma modify am_dep not null;
alter table metepiblma primary key (courcode,ak,am_dep);
alter table metepiblma foreign key metcourse_fk (courcode,ak) references metcourse on delete restrict;
delete from metepiblma where courcode||ak not in (select courcode||ak from metcourse);
alter table metepiblma foreign key dep_fk (am_dep) references dep on delete restrict;


   									metprospu
___________________________________________________________________________________;

drop index metprospu_idx;
create unique index metprospu_idx on   metprospu (courcode,ak,progcode,kat);
select courcode||ak||progcode||kat from metprospu group by 1 having count(courcode||ak||progcode||kat) >1;
select * from metprospu where courcode =:1 and ak = :2;
select * from metkartl where courcode =:1 and ak =:2 and period =:3;
delete from metprospu where courcode =:1 and ak =:2 and period =:3;
update statistics on index metprospu_idx;
alter table   metprospu modify courcode not null;
alter table   metprospu modify ak not null;
alter table   metprospu modify tmimacode not null;
alter table   metprospu modify progcode not null;
alter table   metprospu modify kat not null;
alter table   metprospu modify period not null;
alter table   metprospu modify eidosma not null;
alter table   metprospu primary key (courcode,ak,progcode,kat);
alter table   metprospu foreign key metcourse_fk  (courcode,ak) references metcourse on delete restrict;
select courcode||ak from metprospu where courcode||ak not in (select courcode||ak from metcourse);
select * from metcourse where courcode = :1;
select * from metprospu where courcode = :1;
select * from metkartl where courcode = :1 and ak = :2;
delete from metprospu where courcode||ak not in (select courcode||ak from metcourse);
alter table   metprospu foreign key metkatef_fk  (kat) references metkatef on delete restrict;



   									metkartl_web
___________________________________________________________________________________;

drop index metkartl_web_idx;
alter table metkartl_web add kat varchar(2);
update metkartl_web set kat = (select kat from metstuprog where metkartl_web.mitroo = metstuprog.mitroo and metkartl_web.progcode = metstuprog.progcode) where kat is null;
create unique index metkartl_web_idx on metkartl_web (mitroo,courcode, ak,progcode,kat, datemodif);
select mitroo||courcode||ak||progcode||kat||datemodif from metkartl_web group by 1 having count( mitroo||courcode||ak||progcode||kat||datemodif) >1;
select * from metkartl_web where mitroo =:1 and courcode = :2 and ak = :3 order by mitroo,progcode,kat,courcode,ak,datemodif;
update statistics on index metkartl_web_idx;
alter table   metkartl_web modify mitroo not null;
alter table   metkartl_web modify courcode not null;
alter table   metkartl_web modify ak not null;
alter table   metkartl_web modify tmimacode not null;
alter table   metkartl_web modify progcode not null;
alter table   metkartl_web modify kat not null;
alter table   metkartl_web modify period not null;
alter table   metkartl_web modify datemodif not null;

alter table metkartl_web primary key (mitroo,courcode, ak, tmimacode, progcode, kat,datemodif);


   									metkartl_ist
___________________________________________________________________________________;


drop index metkartl_ist_idx;
alter table metkartl_web add kat varchar(2);
update metkartl_ist set kat = (select kat from metstuprog where metkartl_ist.mitroo = metstuprog.mitroo and metkartl_ist.progcode = metstuprog.progcode) where kat is null; 
create unique index metkartl_ist_idx on metkartl_ist (mitroo,courcode, ak, progcode, kat,datemodif);
select mitroo||courcode||ak||progcode||kat||datemodif from metkartl_ist group by 1 having count( mitroo||courcode||ak||progcode||kat||datemodif) >1;
update statistics on index metkartl_ist_idx;
alter table   metkartl_ist modify mitroo not null;
alter table   metkartl_ist modify courcode not null;
alter table   metkartl_ist modify ak not null;
alter table   metkartl_ist modify tmimacode not null;
alter table   metkartl_ist modify progcode not null;
alter table   metkartl_ist modify kat not null;
alter table   metkartl_ist modify period not null;
alter table   metkartl_ist modify datemodif  not null;

alter table metkartl_ist primary key (mitroo,courcode, ak, tmimacode, progcode, kat,datemodif);
select * from metprospu where courcode =:1 and ak =:2 and progcode =:3 and kat=:4; 

   									metkartl
___________________________________________________________________________________;

drop index metkartl_idx;
update metkartl set kat = (select kat from metstuprog where metkartl.mitroo = metstuprog.mitroo  and metkartl.progcode = metstuprog.progcode) where kat is null;
create unique index metkartl_idx on   metkartl (mitroo, courcode,ak,progcode,kat);
select mitroo||courcode||ak||progcode||kat from metkartl group by 1 having count( mitroo||courcode||ak||progcode||kat)>1;
select * from metkartl where mitroo =:1 and courcode =:2 and ak =:3;
delete from metkartl where mitroo =:1 and courcode =:2 and ak =:3 and period =:4;
update statistics on index metkartl_idx;
drop trigger metkartl_del;
drop trigger metkartl_ins;
drop trigger metkartl_updt;
drop trigger metkartl_ins_sn;
alter table   metkartl modify mitroo not null;
alter table   metkartl modify courcode not null;
alter table   metkartl modify ak not null;
alter table   metkartl modify tmimacode not null;
alter table   metkartl modify progcode not null;
alter table   metkartl modify kat not null;
alter table   metkartl modify period not null;
alter table   metkartl modify kat not null;


create trigger metkartl_ins_sn before insert on metkartl
		   ( execute inline (metkartl_seqno)
	procedure: met_kart_ins_seqno static
		parameters		
			receive number : nseqno
		local variables
			sql handle: hsqlcur
			sql handle: hsqlcur2
			number : nnext
		actions
			on procedure startup
				call sqlconnect( hsqlcur )
				call sqlconnect( hsqlcur2 )
				when sqlerror
					call sqlimmediate('rollback')
					call sqlclearimmediate()
				call sqlprepare(hsqlcur, 'select nextsn from tablesn where tablename = \'metkartl\' into :nseqno' )
				when sqlerror
					call sqlimmediate('rollback')
					call sqlclearimmediate()
				call sqlprepare(hsqlcur2, 'update tablesn set nextsn = :nseqno + 1  where tablename = \'metkartl\' ' )
			on procedure execute
				call sqlexecute( hsqlcur )
				call sqlfetchnext( hsqlcur,nnext )
				call sqlexecute( hsqlcur2 )
    			on procedure close
				call sqldisconnect( hsqlcur )
				call sqldisconnect( hsqlcur2 )
  )
for each row;

erase metkartl_proc;

store metkartl_proc
procedure metkartl_proc static
 	parameters
   		string   	 	: modiftype
   		number 		: courcode
   		number 		: ak
   		number 		: tmimacode
		number 		: progcode
   		string    		: kat
   		string    		: periodaniki
   		string    		: typos
   		string    		: period
		number 		: gradenor
		number 		: gradepan
		string    		: apalag
   		string    		: epepil
		date/time		: datedel
   		number 		: metkartl_segno
 	local variables
   		sql handle: hsql1
   		sql handle: hsql2
 	actions
   		on procedure startup
    			call sqlconnect( hsql1 )
    			call sqlconnect( hsql2 )
   		on procedure execute
			call sqlprepare( hsql1 , 'insert into metkartl_web(
										datemodif, modiftype, courcode, ak, tmimacode, progcode, kat, periodaniki, typos, period, gradenor, gradepan, apalag, epepil, datedel,metkartl_seqno)
     							      	       values(
										sysdatetime, :modiftype, :courcode, :ak, :tmimacode, :progcode, :kat, :periodaniki, :typos, :period, :gradenor, :gradepan, :apalag, :epepil, :datedel, :metkartl_segno )' )
    			call sqlexecute( hsql1 )
    			call sqlprepare( hsql2 , 'insert into metkartl_ist(
										username, datemodif, modiftype, courcode, ak, tmimacode, progcode, kat, periodaniki, typos, period, gradenor, gradepan, apalag, epepil, datedel,metkartl_seqno)
     							               values(
										user, sysdatetime, :modiftype, :courcode, :ak, :tmimacode, :progcode, :kat, :periodaniki, :typos, :period, :gradenor, :gradepan, :apalag, :epepil, :datedel, :metkartl_segno )' )
    			call sqlexecute( hsql2 )
   		on procedure close
    			call sqldisconnect( hsql1 )
    			call sqldisconnect( hsql2 );

create trigger sysadm.metkartl_ins after insert on metkartl
	( execute metkartl_proc (
				'i',  courcode, ak, tmimacode, progcode, kat, periodaniki, typos, period, gradenor, gradepan, apalag, epepil, datedel,metkartl_seqno))
for each row;

create trigger sysadm.metkartl_del after delete on metkartl
	( execute metkartl_proc (
				'd',  courcode, ak, tmimacode, progcode, kat, periodaniki, typos, period, gradenor, gradepan, apalag, epepil, datedel,metkartl_seqno))
for each row;

create trigger sysadm.metkartl_updt after update on metkartl referencing old as old_metkartl new as new_metkartl
	( execute metkartl_proc (
				'u',  courcode, ak, tmimacode, progcode, kat, periodaniki, typos, period, gradenor, gradepan, apalag, epepil, datedel,metkartl_seqno))
for each row;

alter table  metkartl  primary key (mitroo,courcode, ak,progcode, kat);
alter table  metkartl foreign key metstuprog (mitroo,progcode) references metstuprog on delete restrict;
alter table  metkartl foreign key metprospu (courcode,ak,progcode,kat) references metprospu on delete restrict;
select courcode,ak,tmimacode,progcode,kat from metkartl where courcode||ak||progcode||kat not in (select courcode||ak||progcode||kat from metprospu) order by courcode;
update metkartl set kat = (select kat from metprospu where metkartl.courcode = metprospu.courcode and metkartl.progcode = metprospu.progcode and metkartl.ak = metprospu.ak) ;
select *  from metprospu where courcode = :1 and progcode =:2 and ak = :3;
insert into metprospu (progcode,courcode,ak,period,tmimacode,kat,eidosma) select progcode,courcode,ak,period,tmimacode,:5,eidosma from metprospu where courcode = :1 and tmimacode = :2 and progcode =:3 and ak = :4;


drop trigger metkartl_ins;














