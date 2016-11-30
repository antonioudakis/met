select met.epvn||'$'||met.onoma||'$'||dep.epvn||'$'||dep.onoma||'$'||max(dateanath),'$',metanathesi.thema
from ((((met 
left join metstuprog on (met.mitroo = metstuprog.mitroo) ) 
left join metdsynerg on (metstuprog.mitroo = metdsynerg.mitroo and metstuprog.progcode = metdsynerg.progcode))
left join metanathesi on metdsynerg.codesyn = metanathesi.codesyn)
left join metdiplgrade on metdsynerg.codesyn = metdiplgrade.codesyn)
left join dep on dep.am_dep = metdiplgrade.depcode
where metstuprog.progcode = 1 and metstuprog.dateanag is null and met.mitroo not in (select mitroo from metdiakop where dateeos is null and metdiakop.progcode = 1) and ((typedep = 1 or typedep = 2) and datedel is null) 
group by met.epvn,met.onoma,metanathesi.thema,dep.epvn,dep.onoma,metdiplgrade.typedep
order by met.epvn,met.onoma,metdiplgrade.typedep;
