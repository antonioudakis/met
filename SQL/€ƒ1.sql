select count(*) from metstuprog where ak = 2010 and progcode = :1;
;Μέγιστη διάρκεια 2 χρόνια
select count(*) from metstuprog where progcode = :1 and (h_egr < 1-SEP-2006 and dateanag is null)  or (dateanag is not null and dateanag - h_egr> 1460 and dateanag between '1-SEP-2009' and '31-AUG-2010) or (dateanag is not null and mitroo in (select mitroo  from metdiakop where progcode =:1 and dateapo <1-SEP-2006 and dateeos is null )));
;Μέγιστη διάρκεια 2,5 χρόνια
select count(*) from metstuprog where progcode = :1 and h_egr < 1-SEP-2005 and (dateanag is null  or (dateanag is not null and dateanag - h_egr> 1825) or (dateanag is not null and mitroo in (select mitroo  from metdiakop where progcode =:1 and dateapo <1-SEP-2005 and dateeos is null )));



