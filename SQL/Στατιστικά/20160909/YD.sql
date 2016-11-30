create table tmp (mitroo varchar(8), epvn varchar(254),onoma varchar(254));

alter table tmp add progcode  integer;

update tmp set progcode = 1;

insert into tmp (mitroo,epvn,onoma) select met.mitroo,met.epvn,met.onoma from met inner join metstuprog on met.mitroo = metstuprog.mitroo where metstuprog.progcode = 1;

alter table tmp add status varchar(12);

alter table tmp modify status varchar(13);

update tmp set status = 'емеяцос';

alter table tmp add datediakop date;

update tmp set tmp.datediakop = (select min(metdiakop.dateapo) from metdiakop where metdiakop.mitroo = tmp.mitroo and metdiakop.progcode = 1 and metdiakop.dateeos is null) ;

update tmp set status = 'диецяаллемос' where datediakop is not null;

alter table tmp add dateanag date;

update tmp set tmp.dateanag = (select dateanag from metstuprog where metstuprog.mitroo = tmp.mitroo and metstuprog.progcode = 1);

update tmp set status = 'амацояеулемос' where dateanag is not null;

alter table tmp add codesyn int;

update tmp set tmp.codesyn = (select min(codesyn) from metdsynerg where metdsynerg.mitroo = tmp.mitroo and metdsynerg.progcode = 1 and codesyn is not null);

alter table tmp add  dateins date;

update tmp set tmp.dateins = (select min(dateins) from metanathesi inner join metdsynerg on metdsynerg.codesyn = metanathesi.codesyn where metdsynerg.progcode = 1 and metdsynerg.mitroo = tmp.mitroo);

alter table tmp add  dateanath date;

update tmp set tmp.dateanath = (select max(dateanath) from metanathesi inner join metdsynerg on metdsynerg.codesyn = metanathesi.codesyn where metdsynerg.progcode = 1 and metdsynerg.mitroo = tmp.mitroo);

alter table tmp add thema varchar(254);

update tmp set tmp.thema = (select thema from metanathesi where metanathesi.codesyn=tmp.codesyn and metanathesi.dateanath =  tmp.dateanath);

select mitroo,'$',epvn,'$',onoma,'$',dateins,'$',dateanag,'$',datediakop,'$',status,'$',thema from tmp order by dateins desc,epvn,onoma;

select mitroo,'$',tmp.epvn,'$',tmp.onoma,'$',tmp.dateins,'$',status,'$',dep.epvn||' '||dep.onoma,'$',metdiplgrade.dateins from (tmp inner join metdiplgrade on tmp.codesyn = metdiplgrade.codesyn) inner join dep on dep.am_dep = metdiplgrade.depcode where typedep = 1 and datedel is null order by tmp.dateins desc,tmp.epvn,tmp.onoma,metdiplgrade.dateins desc;

select mitroo,'$',tmp.epvn,'$',tmp.onoma,'$',tmp.dateins,'$',status,'$',dep.epvn||' '||dep.onoma,'$',metdiplgrade.dateins from (tmp inner join metdiplgrade on tmp.codesyn = metdiplgrade.codesyn) inner join dep on dep.am_dep = metdiplgrade.depcode where typedep = 2 and datedel is null order by tmp.dateins desc,tmp.epvn,tmp.onoma,metdiplgrade.dateins desc;

drop table tmp;
