; ANAZHTHSH ME BASH THN HMEROMHNIA ANAGOREUSHS;

select sex, metstuprog.progcode as progcode, count(metstuprog.mitroo) 
from met,metstuprog
where met.mitroo = metstuprog.mitroo and (metstuprog.dateanag  is null or metstuprog.dateanag>='01-OCT-'||@string(:1,0)) 
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-OCT-'||@string(:1,0) and dateeos is null 
	and progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2
group by 2,1 order by 2,1;

;FOITHTES POU EXOUN HMEROMHNIA ANAGOREUSIS KAI DEN EXOUN AK ETOS ANAGOREUSIS;

select * from metstuprog where dateanag is not null and etosdipl is null;

;ANAZHTHSH ME BASH TO AK ETOS ANAGOREUSHS;

select sex, metstuprog.progcode as progcode, count(metstuprog.mitroo) 
from met,metstuprog
where met.mitroo = metstuprog.mitroo and (metstuprog.etosdipl is null or metstuprog.etosdipl>:1)
	and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-OCT-'||@string(:1,0) and dateeos is null 
	and progcode = metstuprog.progcode)
	and metstuprog.ak <=:1 and met.tmimacode = :2
group by 2,1 order by 2,1;



