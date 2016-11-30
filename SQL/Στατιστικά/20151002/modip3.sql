select * from metprogram;

create table statt (tmimacode integer, progcode integer, mitroo varchar(8),ak integer, codesyn integer, grade float);
create table statt1 (codesyn integer, grade float);

insert into statt (codesyn,progcode,tmimacode,mitroo) select codesyn,progcode,tmimacode,mitroo from metdsynerg where progcode = :2 and mitroo in (select mitroo from metstuprog where dateanag  between '01-JAN-'||:1 and '31-DEC-'||:1 and progcode =:2);

insert into statt1 (codesyn,grade) select codesyn,avg(grade) from metdiplgrade where grade is not null group by codesyn;
update statt set statt.grade = (select statt1.grade from statt1 where statt.codesyn = statt1.codesyn);

select progcode, count(*), '[5-7) Καλώς' from statt where  grade<7 group by 1
union
select progcode,count(*),'[7-9) Λίαν Καλώς'  from statt where  (grade >=7 and grade<9) group by 1
union
select progcode,count(*),'[9-10.0] Αριστα'  from statt where  (grade>=9 and grade<=10) group by 1 order by 1,3;

select progcode, count(*), '[5-6)' from metstuprog where  totbau <6 and dateanag between  '01-JAN-'||:1 and '31-DEC-'||:1 and progcode = :2 group by 1
union
select progcode,count(*),'[6-7)'  from metstuprog where  (totbau >=6 and totbau <7) and dateanag between  '01-JAN-'||:1 and '31-DEC-'||:1 and progcode = :2 group by 1
union
select progcode,count(*),'[7-8.5)'  from metstuprog where  (totbau >=7 and totbau <8.5) and dateanag between  '01-JAN-'||:1 and '31-DEC-'||:1 and progcode = :2 group by 1
union
select progcode,count(*),'[8.5-10.0]'  from metstuprog where  (totbau >=8.5 and totbau <=10) and dateanag between  '01-JAN-'||:1 and '31-DEC-'||:1 and progcode = :2 group by 1 order by 1,3;


drop table statt;
drop table statt1;



