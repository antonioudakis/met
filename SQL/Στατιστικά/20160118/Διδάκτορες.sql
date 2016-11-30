create table tmp (mitroo varchar(8), epvn varchar(40), onoma varchar(30), patr varchar(30), birthdate date, poliorigcode varchar(10), tomeas varchar(50),dateanag date);

insert into tmp select met.mitroo,epvn,onoma,patr,birthdate,poliorig,mettomeis.titlos,metstuprog.dateanag from (met  inner join metstuprog on met.mitroo = metstuprog.mitroo) inner join mettomeis on metstuprog.tomcode = mettomeis.tomcode  where metstuprog.progcode = 1 and metstuprog.dateanag  between '01-JAN-2014' and '31-DEC-2014' ;

select * from tmp;

alter table tmp add poliorig varchar(250); 

update tmp set poliorig = (select pltext from pltab where tmp.poliorigcode = pltab.plcode and plcolumn = 'POLI' and poliorigcode is not null);

select * from tmp;

alter table tmp add codesyn int;

update tmp set codesyn = (select codesyn from metdsynerg where metdsynerg.mitroo = tmp.mitroo and metdsynerg.progcode = 1);

select * from tmp;

alter table tmp add dateanath date;

update tmp set tmp.dateanath = (select max(dateanath) from metanathesi where tmp.codesyn = metanathesi.codesyn);

select * from tmp;

alter table tmp add thema varchar(250);

update tmp set tmp.thema = (select thema from metanathesi where codesyn = tmp.codesyn and dateanath = tmp.dateanath);

select * from tmp;

alter table tmp add dateejet date;

update tmp set tmp.dateejet = (select dateejet from metanathesi where codesyn = tmp.codesyn and dateanath = tmp.dateanath);

select mitroo,'^',epvn,'^',onoma,'^',patr,'^',birthdate,'^',poliorig,'^',thema,'^',dateanath,'^',tomeas,'^',dateejet from tmp order by epvn,onoma,patr;

select tmp.mitroo,'^',tmp.epvn,'^',tmp.onoma,'^',tmp.patr,'^',@if(metptyx.ptyxview -3,'птувио','лде') as type,'^',pltext from (tmp inner join metptyx on metptyx.mitroo = tmp.mitroo and (metptyx.ptyxview = '1' or metptyx.ptyxview ='2' or metptyx.ptyxview='3' or metptyx.ptyxview ='4') inner join pltab on pltab.plcode = metptyx.idryma and plcolumn = 'IDRYMA') order by tmp.epvn,tmp.onoma,tmp.patr,ptyxview;

select tmp.mitroo,'^',tmp.epvn,'^',tmp.onoma,'^',tmp.patr,'^',dep.epvn,'^',dep.onoma, '^','епибкепым' from (tmp inner join metdiplgrade on tmp.codesyn = metdiplgrade.codesyn and metdiplgrade.datedel is null and metdiplgrade.typedep = '1') inner join dep on dep.am_dep = metdiplgrade.depcode order by tmp.epvn,tmp.onoma,tmp.patr;

select tmp.mitroo,'^',tmp.epvn,'^',tmp.onoma,'^',tmp.patr,'^',dep.epvn,'^',dep.onoma, '^','лекос тяилекоус' from (tmp inner join metdiplgrade on tmp.codesyn = metdiplgrade.codesyn and metdiplgrade.datedel is null and metdiplgrade.typedep = '2') inner join dep on dep.am_dep = metdiplgrade.depcode order by tmp.epvn,tmp.onoma,tmp.patr;

select tmp.mitroo,'^',tmp.epvn,'^',tmp.onoma,'^',tmp.patr,'^',dep.epvn,'^',dep.onoma, '^','лекос епталекоус' from (tmp inner join metdiplgrade on tmp.codesyn = metdiplgrade.codesyn and metdiplgrade.datedel is null and metdiplgrade.typedep = '3') inner join dep on dep.am_dep = metdiplgrade.depcode order by tmp.epvn,tmp.onoma,tmp.patr;

drop table tmp;


