create table epidosi (ak number,progcode number,courcode number,eggegrammenoi number, proselthontes number,epitixontes number, titlos varchar(200)) ;

;EGGEGRAMMENOI;

insert into epidosi (ak,progcode,courcode, eggegrammenoi, titlos) select metkartl.ak,metkartl.progcode,metkartl.courcode,count(*),titlos from metkartl inner join metcourse on metkartl.courcode = metcourse.courcode and metkartl.ak = metcourse.ak where metkartl.ak = :1
	group by metkartl.ak,metkartl.progcode,titlos,metkartl.courcode ;

;PROSELTHONTES;

update epidosi set proselthontes = (select count(*) from metkartl inner join metcourse on metkartl.courcode = metcourse.courcode and metkartl.ak = metcourse.ak where metkartl.ak = :1 and (gradenor is not null or gradepan is not null ) 
	and epidosi.courcode = metkartl.courcode and epidosi.ak = metkartl.ak  and epidosi.progcode = metkartl.progcode group by metkartl.ak,metkartl.progcode,titlos,metkartl.courcode) ;

;EPITYXONTES;

update epidosi set epitixontes = (select count(*) from metkartl inner join metcourse on metkartl.courcode = metcourse.courcode and metkartl.ak = metcourse.ak where metkartl.ak = :1 and (gradenor >=5 or gradepan >=5 ) 
	and epidosi.courcode = metkartl.courcode and epidosi.ak = metkartl.ak  and epidosi.progcode = metkartl.progcode group by metkartl.ak,metkartl.progcode,titlos,metkartl.courcode) ;

select ak,';',progcode,';',courcode,';',eggegrammenoi,';',proselthontes,';',epitixontes,';',titlos from epidosi;

drop table epidosi;

selects

;EGGEGRAMMENOI;

select metkartl.ak,metkartl.progcode,metkartl.courcode,count(*),titlos from metkartl inner join metcourse on metkartl.courcode = metcourse.courcode and metkartl.ak = metcourse.ak where metkartl.ak = :1
	group by metkartl.ak,metkartl.progcode,titlos,metkartl.courcode order by metkartl.progcode,metkartl.courcode;

;PROSELTHONTES;

select metkartl.ak,metkartl.progcode,metkartl.courcode,count(*),titlos from metkartl inner join metcourse on metkartl.courcode = metcourse.courcode and metkartl.ak = metcourse.ak where metkartl.ak = :1 and (gradenor is not null or gradepan is not null ) 
	group by metkartl.ak,metkartl.progcode,titlos,metkartl.courcode order by metkartl.progcode,metkartl.courcode;

;EPITYXONTES;

select metkartl.ak,metkartl.progcode,metkartl.courcode,count(*),titlos from metkartl inner join metcourse on metkartl.courcode = metcourse.courcode and metkartl.ak = metcourse.ak where metkartl.ak = :1 and (gradenor >=5 or gradepan >=5 ) 
	group by metkartl.ak,metkartl.progcode,titlos,metkartl.courcode order by metkartl.progcode,metkartl.courcode;
