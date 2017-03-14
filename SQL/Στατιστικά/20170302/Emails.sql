select metprogram.titlos,'^',metstuprog.ak,'^',met.mitroo,'^',met.epvn,'^',met.onoma,'^',met.email from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null)
		       order by titlos, metstuprog.ak desc, met.epvn,met.onoma;
	

select metprogram.titlos,'^',metstuprog.dateanag,'^',met.mitroo,'^',met.epvn,'^',met.onoma,'^',met.email from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag is not null) 
                       order by titlos,metstuprog.dateanag desc,met.epvn,met.onoma;
