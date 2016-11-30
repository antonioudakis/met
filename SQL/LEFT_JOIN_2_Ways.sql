select metstuprog.mitroo,epvn,onoma,codesyn 
from (met inner join metstuprog on met.mitroo = metstuprog.mitroo and metstuprog.progcode = 1) left join metdsynerg on met.mitroo = metdsynerg.mitroo and  metdsynerg.progcode = metstuprog.progcode 
where  metstuprog.dateanag is null and metstuprog.mitroo not in (select mitroo from metdiakop where progcode  = 1  and dateapo <= sysdate and (dateeos is null or dateeos >= sysdate))  ;

select metstuprog.mitroo,epvn,onoma,codesyn 
from met,metstuprog,metdsynerg 
where met.mitroo = metstuprog.mitroo and met.mitroo = metdsynerg.mitroo(+) and metstuprog.progcode = 1  and metstuprog.progcode = metdsynerg.progcode(+) and
            metstuprog.dateanag is null and metstuprog.mitroo not in (select mitroo from metdiakop where progcode  = 1  and dateapo <= sysdate and (dateeos is null or dateeos >= sysdate))  ;
