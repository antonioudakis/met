;Epidi enonontas ola mazi me to thema den bgainei to select logo megalou string yparxoun oi dio parakatw liseis ; O diaxorismos sto excel ginete me to ellhniko erotimatiko

;1os tropos : se periptosi pou exei allaxei kapoios to thema tha ton emfanisei dio fores , i mia kato apo tin alli. Meta emfanizoume to thema mono tou ksexorista (2o select) kai to kanoume copy paste;

select met.mitroo||';'||met.epvn||';'||met.onoma||';'||h_egr||';'||mettomeis.titlos||';'||dep.epvn||';'||dep.onoma||';'||pltext||';'||dateanath  from met,metstuprog,mettomeis,metdsynerg,metanathesi,metdiplgrade,dep,pltab where met.mitroo = metstuprog.mitroo and metstuprog.progcode = 1 and metstuprog.dateanag  is null 
                             and met.mitroo not in (select mitroo from metdiakop where dateapo < sysdate and dateeos is null and progcode = 1) and mettomeis.tomcode=metstuprog.tomcode
                             and metstuprog.mitroo= metdsynerg.mitroo and metstuprog.progcode= metdsynerg.progcode and met.tmimacode= metdsynerg.tmimacode
                             and metdsynerg.codesyn = metanathesi.codesyn 
                             and metdsynerg.codesyn = metdiplgrade.codesyn and typedep !=3 and datedel is null
                             and metdiplgrade.depcode = dep.am_dep
                             and pltab.plcode = metdiplgrade.typedep and pltab.plcolumn = 'MPROPERT' 
                             order by h_egr desc,met.epvn,met.onoma,dateanath,pltext;


select thema  from met,metstuprog,mettomeis,metdsynerg,metanathesi,metdiplgrade,dep,pltab where met.mitroo = metstuprog.mitroo and metstuprog.progcode = 1 and metstuprog.dateanag  is null 
                             and met.mitroo not in (select mitroo from metdiakop where dateapo < sysdate and dateeos is null and progcode = 1) and mettomeis.tomcode=metstuprog.tomcode
                             and metstuprog.mitroo= metdsynerg.mitroo and metstuprog.progcode= metdsynerg.progcode and met.tmimacode= metdsynerg.tmimacode
                             and metdsynerg.codesyn = metanathesi.codesyn 
                             and metdsynerg.codesyn = metdiplgrade.codesyn and typedep !=3 and datedel is null
                             and metdiplgrade.depcode = dep.am_dep
                             and pltab.plcode = metdiplgrade.typedep and pltab.plcolumn = 'MPROPERT' 
                             order by h_egr desc,met.epvn,met.onoma,dateanath,pltext;

;2os tropos : se periptosi pou exei allaxei thema emfanizei to pio prosfato. Epidi  omos den mporo na xrisimopoiiso to group by se deutero select mono me to thema tha emfanistoun mazi oi kolones ymerominia anathesis teleutaiou thematos me to thema. Etsi exete meta problima sto excel. Dialekste kai parte;


select met.mitroo||';'||met.epvn||';'||met.onoma||';'||h_egr||';'||mettomeis.titlos||';'||dep.epvn||';'||dep.onoma||';'||pltext||';'||max(dateanath),thema from met,metstuprog,mettomeis,metdsynerg,metanathesi,metdiplgrade,dep,pltab where met.mitroo = metstuprog.mitroo and metstuprog.progcode = 1 and metstuprog.dateanag  is null 
                             and met.mitroo not in (select mitroo from metdiakop where dateapo < sysdate and dateeos is null and progcode = 1) and mettomeis.tomcode=metstuprog.tomcode
                             and metstuprog.mitroo= metdsynerg.mitroo and metstuprog.progcode= metdsynerg.progcode and met.tmimacode= metdsynerg.tmimacode
                             and metdsynerg.codesyn = metanathesi.codesyn 
                             and metdsynerg.codesyn = metdiplgrade.codesyn and typedep !=3 and datedel is null
                             and metdiplgrade.depcode = dep.am_dep
                             and pltab.plcode = metdiplgrade.typedep and pltab.plcolumn = 'MPROPERT' 
                             group by met.mitroo,met.epvn,met.onoma,h_egr,mettomeis.titlos,dep.epvn,dep.onoma,pltext,thema
                             order by h_egr desc,met.epvn,met.onoma,pltext;





