drop table tmp;

create table tmp (mitroo varchar(8), epvn varchar(40), onoma varchar(30), patr varchar(30), tel1 varchar(10), tel2 varchar(15), email varchar(50), tomeas varchar(50), ak integer);

insert into tmp select met.mitroo,epvn,onoma,patr,@TRIM(tel1),@TRIM(tel2),@TRIM(email),@TRIM(titlos),ak from (met  inner join metstuprog on met.mitroo = metstuprog.mitroo) inner join mettomeis on mettomeis.tomcode = metstuprog.tomcode where metstuprog.progcode = 1 and metstuprog.dateanag  is null and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.mitroo = metstuprog.mitroo and metdiakop.progcode = metstuprog.progcode and dateeos is null);

alter table tmp add codesyn int;

update tmp set codesyn = (select codesyn from metdsynerg where metdsynerg.mitroo = tmp.mitroo and metdsynerg.progcode = 1);

select * from tmp;

alter table tmp add dateanath date;

update tmp set tmp.dateanath = (select max(dateanath) from metanathesi where tmp.codesyn = metanathesi.codesyn);

select * from tmp;

alter table tmp add thema varchar(250);

update tmp set tmp.thema = (select @TRIM(thema) from metanathesi where codesyn = tmp.codesyn and dateanath = tmp.dateanath);

select * from tmp;

alter table tmp add dateins date;

update tmp set tmp.dateins = (select min(dateins) from metdiplgrade where codesyn = tmp.codesyn and datedel is null);

select * from tmp;

select mitroo,'^',epvn,'^',onoma,'^',patr,'^',tel1,'^',tel2,'^',email,'^',ak,'^',dateanath,'^',dateins,'^',tomeas,'^',thema from tmp  order by ak desc,epvn,onoma,patr;

select tmp.mitroo,'^',tmp.epvn,'^',tmp.onoma,'^',tmp.patr,'^',metdiplgrade.dateins,'^',dep.epvn,'^',dep.onoma, '^','епибкепым' from (tmp inner join metdiplgrade on tmp.codesyn = metdiplgrade.codesyn and metdiplgrade.datedel is null and metdiplgrade.typedep = '1') inner join dep on dep.am_dep = metdiplgrade.depcode  order by tmp.ak desc,tmp.epvn,tmp.onoma,tmp.patr,metdiplgrade.dateins desc;

select tmp.mitroo,'^',tmp.epvn,'^',tmp.onoma,'^',tmp.patr,'^',metdiplgrade.dateins,'^',dep.epvn,'^',dep.onoma, '^','лекос тяилекоус' from (tmp inner join metdiplgrade on tmp.codesyn = metdiplgrade.codesyn and metdiplgrade.datedel is null and metdiplgrade.typedep = '2') inner join dep on dep.am_dep = metdiplgrade.depcode order by tmp.ak desc, tmp.epvn,tmp.onoma,tmp.patr,metdiplgrade.dateins desc;

drop table tmp;


