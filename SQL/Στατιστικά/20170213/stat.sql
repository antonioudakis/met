select metprogram.titlos,'^',metstuprog.ak,'^',metstuprog.h_egr,'^',met.mitroo,'^',met.epvn,'^',met.onoma,'^',met.patr,'^',met.tel1,'^',met.tel2,'^',met.email from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and (metstuprog.progcode = 6 or metstuprog.progcode = 7)
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and  dateeos is null) order by 1,5 desc,epvn,onoma;



