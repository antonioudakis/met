select * from metstuprog where h_egr>= '01-SEP-'||@string(:1-1,0) and ak is null ;

select progcode,count(*) from metstuprog where ak = :1 group by 1;

select metstuprog.progcode,count(*) from metstuprog inner join met on met.mitroo = metstuprog.mitroo where metstuprog.ak<=:1 
		and (dateanag is null or dateanag >  '01-SEP-'||@string(:1-1,0))
		and metstuprog.mitroo not in (select mitroo from metdiakop where dateeos is null and dateapo <= '01-SEP-'||@string(:1-1,0) and metdiakop.progcode = metstuprog.progcode) 
		and ((met.erasmus is null) or (met.erasmus=2)) group by 1;
		
select progcode,count(*) from metstuprog where dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0) group by 1;




