select * from metprogram;

select count(*),progcode from metstuprog where ak = :1 group by progcode;

select count(*),progcode from metstuprog inner join met on metstuprog.mitroo = met.mitroo where ak = :1 and  yphk is not null and yphk <> '0099' group by progcode order by progcode;

select count(*),progcode from metstuprog where metstuprog.ak <=:1 and (metstuprog.dateanag is null or metstuprog.dateanag > '01-SEP-'||@string(:1-1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo <= '01-SEP-'||@string(:1-1,0) and dateeos is null) group by progcode;

select count(*),progcode from metstuprog inner join met on metstuprog.mitroo = met.mitroo where metstuprog.ak <=:1 and yphk is not null and yphk <> '0099' and (metstuprog.dateanag is null or metstuprog.dateanag > '01-SEP-'||@string(:1-1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo <= '01-SEP-'||@string(:1-1,0) and dateeos is null) group by progcode;

select count (distinct mitroo||progcode),progcode from metegr where ak = :1 group by progcode order by progcode;

select count (distinct metegr.mitroo||progcode),progcode from metegr inner join met on metegr.mitroo = met.mitroo where ak = :1 and yphk is not null and yphk <> '0099' group by progcode order by progcode;

select count(*),progcode from metstuprog where dateanag is not null and dateanag between '01-JAN-'||@string(:1,0) and '31-DEC-'||@string(:1,0) group by progcode order by progcode;

select count(*),progcode from metstuprog inner join met on metstuprog.mitroo = met.mitroo where yphk is not null and yphk <> '0099' 
                       and dateanag is not null and dateanag between '01-JAN-'||@string(:1,0) and '31-DEC-'||@string(:1,0) group by progcode order by progcode;

select count(*),progcode from metstuprog where dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0) group by progcode order by progcode;






