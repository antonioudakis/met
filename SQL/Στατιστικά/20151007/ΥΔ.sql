select * from metstuprog where h_egr>= '01-SEP-'||@string(:1-1,0) and ak is null and progcode = 1;

select count(*) from metstuprog where progcode = 1 and ak = :1;

select metstuprog.progcode,count(*) from metstuprog inner join met on met.mitroo = metstuprog.mitroo where metstuprog.ak<=:1 and metstuprog.progcode = 1 and (dateanag is null or dateanag >  '01-SEP-'||@string(:1-1,0)) 
		and metstuprog.mitroo not in (select mitroo from metdiakop where dateeos is null and dateapo <= '01-SEP-'||@string(:1-1,0) and metdiakop.progcode =1) 
		and ((met.erasmus is null) or (met.erasmus=2)) group by 1;
		
select count(*) from metstuprog where progcode = 1 and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0);




