select metstuprog.mitroo,epvn,onoma,count(distinct courcode) from metkartl,metstuprog,met
where metkartl.mitroo = metstuprog.mitroo and  metstuprog.progcode = 1 and dateanag is null 
and metstuprog.mitroo not in (select mitroo from metdiakop where dateeos is null )
and metstuprog.mitroo = met.mitroo
group by 1,2,3 having count(distinct courcode) >8 order by 4,1;


