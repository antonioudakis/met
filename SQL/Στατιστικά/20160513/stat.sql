drop table tmp;

create table tmp (mitroo varchar(8), epvn varchar(40), onoma varchar(30), patr varchar(30), tomeas varchar(50), ak integer, progcode integer);

insert into tmp select met.mitroo,epvn,onoma,patr, @TRIM(titlos),ak, progcode from (met  inner join metstuprog on met.mitroo = metstuprog.mitroo) inner join mettomeis on mettomeis.tomcode = metstuprog.tomcode where metstuprog.progcode <> 1 and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.mitroo = metstuprog.mitroo and metdiakop.progcode = metstuprog.progcode and dateeos is null);
select * from tmp;
alter table tmp add codesyn int;

update tmp set codesyn = (select codesyn from metdsynerg where metdsynerg.mitroo = tmp.mitroo and metdsynerg.progcode = tmp.progcode);

select * from tmp;

alter table tmp add seqno int;

update tmp set seqno = (select max(seqno) from metanathesi where tmp.codesyn = metanathesi.codesyn);

select * from tmp;

alter table tmp add dateanag date;

update tmp set tmp.dateanag = (select dateanag from metstuprog where tmp.mitroo = metstuprog.mitroo and tmp.progcode= metstuprog.progcode);

select * from tmp;

alter table tmp add totbau float;

update tmp set tmp.totbau = (select totbau from metstuprog where tmp.mitroo = metstuprog.mitroo and tmp.progcode= metstuprog.progcode);

select * from tmp;

alter table tmp add dateanath date;

update tmp set tmp.dateanath = (select max(dateanath) from metanathesi where tmp.codesyn = metanathesi.codesyn);

select * from tmp;

alter table tmp add thema varchar(250);

update tmp set tmp.thema = (select @TRIM(thema) from metanathesi where codesyn = tmp.codesyn and metanathesi.seqno = tmp.seqno);

select * from tmp;

alter table tmp add dateins date;

update tmp set tmp.dateins = (select min(dateins) from metdiplgrade where codesyn = tmp.codesyn and datedel is null);

select * from tmp;

alter table tmp add program varchar(250);

update tmp set tmp.program = (select titlos from metprogram where metprogram.progcode= tmp.progcode);

select * from tmp;

alter table tmp add grade float;

update tmp set tmp.grade = (select avg(metdiplgrade.grade) from metdiplgrade where metdiplgrade.codesyn= tmp.codesyn and metdiplgrade.datedel is null);

select * from tmp;

1;
select tmp.program,'^',tmp.mitroo,'^',tmp.epvn,'^',tmp.onoma,'^',tmp.patr,'^',metdiplgrade.dateins,'^',dep.epvn,'^',dep.onoma,'^',tmp.grade,'^',thema from (tmp inner join metdiplgrade on tmp.codesyn = metdiplgrade.codesyn and metdiplgrade.datedel is null and metdiplgrade.typedep = '1') inner join dep on dep.am_dep = metdiplgrade.depcode where metdiplgrade.dateins between '01-SEP-'||@string(:1-1,0) and  '31-AUG-'||@string(:1,0) order by tmp.program,metdiplgrade.dateins,tmp.ak desc,tmp.epvn,tmp.onoma,tmp.patr,metdiplgrade.dateins desc;

2;
select tmp.program,'^',tmp.mitroo,'^',tmp.epvn,'^',tmp.onoma,'^',tmp.patr,'^',tmp.dateanag,'^',tmp.totbau from tmp where dateanag between '01-SEP-'||@string(:1-1,0) and  '31-AUG-'||@string(:1,0) order by tmp.program,tmp.dateanag desc,tmp.epvn,tmp.onoma,tmp.patr;

select count(*),metkartl.courcode,metprogram.titlos,metkartl.ak from metkartl inner join metprogram on metkartl.progcode = metprogram.progcode where metkartl.ak = :1 and metprogram.progcode <>1 group by 2,3,4 order by 3,1 desc;

3;
select metprogram.titlos,'^',metcourse.titlos,'^',count(*),'^',metkartl.ak from (metkartl inner join metprogram on metkartl.progcode = metprogram.progcode) inner join metcourse on metkartl.courcode = metcourse.courcode and metkartl.ak = metcourse.ak where metkartl.ak = :1 and metprogram.progcode <>1 group by 1,2,3,4,6,7 order by 1,5 desc;

4;
select metprogram.titlos,'^',metcourse.titlos,'^',mitroo,'^',metkartl.ak,'^',@if(@abs((@nullvalue(gradenor,0)-@nullvalue(gradepan,0))-@nullvalue(gradenor,0)-@nullvalue(gradepan,0)),gradepan,gradenor) as grade from (metkartl inner join metprogram on metkartl.progcode = metprogram.progcode) inner join metcourse on metkartl.courcode = metcourse.courcode and metkartl.ak = metcourse.ak where metkartl.ak = :1 and metprogram.progcode <>1 and (gradenor is not null or gradepan is not null) order by 1,3,9 desc;

5;
select titlos,'^',count(*) from metstuprog inner join mettomeis on metstuprog.tomcode = mettomeis.tomcode where progcode = 1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and  '31-AUG-'||@string(:1,0) group by 1,2;

drop table tmp;






