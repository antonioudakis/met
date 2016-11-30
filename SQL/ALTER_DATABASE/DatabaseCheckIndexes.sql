1.select count(*) from metegr;

1.select count(distinct tmimacode||progcode||mitroo||seqno) from metegr;

select  AM_DEP from DEP group by 1 having count(AM_DEP)>1;
select * from MET where tmimacode is null;
update MET set TMIMACODE = ;
select  MITROO||TMIMACODE from MET group by 1 having count(MET)>1;
select COURCODE||AK||TMIMACODE from METCOURSE group by 1 having count(COURCODE||AK||TMIMACODE)>1;
select AM_DEP||COURCODE||AK||TMIMACODE from METDEPMA group by 1 having count(AM_DEP||COURCODE||AK||TMIMACODE)>1;

select * from metdiakop order by mitroo;

