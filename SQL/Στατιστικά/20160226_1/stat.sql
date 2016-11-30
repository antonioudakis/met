select count(*),progcode from metstuprog where dateanag  between '01-JAN-'||:1 and '31-DEC-'||:1 group by progcode;

select count(*),progcode from metstuprog where ak = :1 group by progcode;

;Statistika Enarxeos;
select count(*),progcode from metstuprog where (dateanag is null or dateanag > '01-OCT-'||@string(:1-1,0)) and mitroo not in (select mitroo from metdiakop where dateeos is null and dateapo <= '01-OCT-'||@string(:1-1,0) and metdiakop.progcode = metstuprog.progcode) group by progcode;


