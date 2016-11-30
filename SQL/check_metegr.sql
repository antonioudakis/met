select count(*) from metegr;

select count(distinct tmimacode||progcode||mitroo||seqno) from metegr;

select  tmimacode||' '||progcode||' '||mitroo||' '||seqno from metegr group by 1 having count(tmimacode||progcode||mitroo||seqno)>1;
