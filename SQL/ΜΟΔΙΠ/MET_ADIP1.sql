select progcode,kat,count(*) from metstuprog where progcode != 1 and ak = :1 group by 1,2;
select progcode,count(*) from metstuprog where progcode != 1 and ak = :1 group by 1;

select progcode,kat,count(*) from metstuprog where ak <= :1 and (dateanag is null or dateanag >=  '10/01/'||@string(:1-1,0)) and mitroo not in (select mitroo from metdiakop where dateeos is null and dateapo < '10/01/'||@string(:1-1,0) and metdiakop.progcode = metstuprog.progcode) group by 1,2;

select progcode,kat,count(*) from metstuprog where progcode !=1 and dateanag between  '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) group by 1,2;

select progcode,kat,avg(totbau) from metstuprog where progcode !=1 and dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau is not null group by 1,2;

select progcode,avg(totbau) from metstuprog where progcode !=1 and dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau is not null group by 1;

select progcode,kat,count(*), '[5-6)' from metstuprog where progcode !=1 and  dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau<6 group by 1,2
union
select progcode,kat,count(*),'[6-7)'  from metstuprog where progcode !=1 and  dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau>=6 and totbau<7 group by 1,2
union
select progcode,kat,count(*),'[7-8.5)'  from metstuprog where progcode !=1 and  dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau>=7 and totbau<8.5 group by 1,2
union
select progcode,kat,count(*),'[8.5-10.0]'  from metstuprog where progcode !=1 and  dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau>=8.5 and totbau<=10 group by 1,2 order by 1,2,4;

select * from metstuprog where progcode = 5 and dateanag is not null and totbau is null;

select progcode,count(*), '[5-6)' from metstuprog where progcode !=1 and  dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau<6 group by 1
union
select progcode,count(*),'[6-7)'  from metstuprog where progcode !=1 and  dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau>=6 and totbau<7 group by 1
union
select progcode,count(*),'[7-8.5)'  from metstuprog where progcode !=1 and  dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau>=7 and totbau<8.5 group by 1
union
select progcode,count(*),'[8.5-10.0]'  from metstuprog where progcode !=1 and  dateanag between '01/01/'||@string(:1,0) and '12/31/'||@String(:1,0) and totbau>=8.5 and totbau<=10 group by 1 order by 1,3;

select * from metprogram order by progcode;
select * from metkatef order by progcode,kat;


