select mitroo,epvn,onoma,pl1.pltext,pl2.pltext from ((met left join pltab pl1 on pl1.plcode =poliorig) left join pltab pl2 on  pl2.plcode=nomosorig) 
	where pl1.plcolumn='POLI' and pl2.plcolumn = 'NOMOI' 
union select mitroo,epvn,onoma,pl1.pltext,null from ((met left join pltab pl1 on pl1.plcode =poliorig) left join pltab pl2 on  pl2.plcode=nomosorig) 
	where pl1.plcolumn='POLI' and pl2.plcolumn = 'NOMOI' and nomosorig is null 
union select mitroo,epvn,onoma,null, pl2.pltext from ((met left join pltab pl1 on pl1.plcode =poliorig) left join pltab pl2 on  pl2.plcode=nomosorig) 
	where pl1.plcolumn='POLI' and pl2.plcolumn = 'NOMOI' and poliorig is null 
union select mitroo,epvn,onoma,null,null from met where poliorig is null and nomosorig is null order by 2,3;

