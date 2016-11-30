select * from metprogram; 

select count(*) from metstuprog where ak = :1 and progcode = 2;

select count(*) from metegr where progcode = 2 and ak =:1 and period = 1;

select * from metegr where progcode = 2 and ak =:1 and period = 1 order by mitroo;

select mitroo from metegr where progcode = 2 and ak =:1 and period = 1 and mitroo not in (select mitroo from metstuprog where progcode = 2 and ak =:1);

select * from metstuprog where mitroo = '02113103';
update metstuprog set ak = 2014 where mitroo ='02113103' and progcode = 2;

select count(*) from metstuprog where progcode = 2 and etosdipl = :1;

select * from metstuprog where progcode = 2 and etosdipl = :1 and totbau is not null;

