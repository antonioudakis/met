select metprogram.titlos,count(*) from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak =:1  and (met.erasmus is null or met.erasmus ='2') and metprogram.progcode = 1 group by 1 order by 1;


select metprogram.titlos,count(*) as SYNOLO from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null)
		       and metprogram.progcode = 1 group by 1 order by 1;

select metprogram.titlos,count(*) as SYNOLO from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null)
		       and metprogram.progcode = 1 and metstuprog.mitroo in (select mitroo from metprood where metprood.mitroo = metstuprog.mitroo and xarakthrism = '1' and metprood.progcode = 1 and  dateprod < '01-SEP-'||@string(:1,0) and dateprod >= '01-SEP-'||@string(:1-1,0)) 
                       group by 1 order by 1;	

select metprogram.titlos,count(*) as SYNOLO from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) 
                       and metprogram.progcode = 1 group by 1 order by 1;


