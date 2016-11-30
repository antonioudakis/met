;жоитгтийос пкгхуслос упоьгжиым дидайтояым йата етос споудым йаи жуко

select count(met.mitroo),2009-ak,sex
from met,metstuprog 
where met.mitroo=metstuprog.mitroo and metstuprog.progcode = 1 
and dateanag is null 
and met.mitroo not in (select mitroo from metdiakop where dateapo < sysdate and (dateeos is null or dateeos > sysdate) and progcode = 1) group by 2,3 order by 3,2;

;аяихлос летаптувиайым жоитгтым поу еццяажомтаи циа деутеяо летаптувиайо титко споудым йата жуко йаи епипедо споудым
;(пеяикалбамеи ломо аутоус поу евоум йамеи летаптувиайо стгм идиа свокг)

select count(met.mitroo),sex
from metstuprog,met
where met.mitroo = metstuprog.mitroo and metstuprog.progcode = :1 
and dateanag is null 
and met.mitroo not in (select mitroo from metdiakop where dateapo < sysdate and (dateeos is null or dateeos > sysdate) and progcode=:1) 
and met.mitroo in ( select mitroo from metstuprog where dateanag is not null and progcode!=:1) group by 2;

;аяихлос летаптувиайым апожоитым йата жуко, гкийиа йаи епипедо споудым
;(пеяикалбамеи ломо аутоус поу евоум йамеи летаптувиайо стгм идиа свокг)

select count(met.mitroo),@year(sysdate)-@year(birthdate),sex
from metstuprog,met
where met.mitroo = metstuprog.mitroo and metstuprog.progcode = :1 
and dateanag is null 
and met.mitroo not in (select mitroo from metdiakop where dateapo < sysdate and (dateeos is null or dateeos > sysdate) and progcode=:1) 
and met.mitroo in ( select mitroo from metstuprog where dateanag is not null and progcode!=:1) group by 3,2;



