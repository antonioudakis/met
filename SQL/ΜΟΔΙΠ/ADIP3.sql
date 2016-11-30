select count(*) from metstuprog where ak = 2010 and progcode = :1;
;Μέγιστη διάρκεια 2 χρόνια
select count(*) from metstuprog where progcode = :1 and h_egr < 1-SEP-2006  and ( dateanag is null  or (dateanag is not null and dateanag - h_egr> 1460 and dateanag between '1-SEP-2009' and '31-AUG-2010) 
			or (mitroo in (select mitroo  from metdiakop where progcode =:1 AND dateapo between '1-SEP-2009' and '31-AUG-2010)) ) ;
;Μέγιστη διάρκεια 2,5 χρόνια
select count(*) from metstuprog where progcode = :1 and h_egr < 1-SEP-2005 and (dateanag is null  or (dateanag is not null and dateanag - h_egr> 1825) or (dateanag is not null and mitroo in (select mitroo  from metdiakop where progcode =:1 and dateapo <1-SEP-2005 and dateeos is null )));

;ΜΕΓΙΣΤΗ ΔΙΑΡΚΕΙΑ 2 ΕΤΗ
select count(*) from metstuprog where progcode = :1 AND ( (h_egr < '1-SEP-'|| (:2+1-4 )  AND DATEANAG IS NULL)  OR ( h_egr < '1-SEP-'|| (:2-4 ) AND dateanag is not null and dateanag between '1-SEP-'|| (:2-1) and '31-AUG-'|| (:2)   )  
OR ( h_egr < '1-SEP-'|| (:2-4 )  AND Mitroo in (select mitroo  from metdiakop where progcode =:1 AND dateapo between '1-SEP-2009' and '31-AUG-2010' )  )   ) ;

;ΜΕΓΙΣΤΗ ΔΙΑΡΚΕΙΑ 2,5 ΕΤΗ
select count(*) from metstuprog where progcode = :1 AND ( (h_egr < '1-SEP-'|| (:2+1-5 )  AND DATEANAG IS NULL)  OR ( h_egr < '1-SEP-'|| (:2-5 ) AND dateanag is not null and dateanag between '1-SEP-'|| (:2-1) and '31-AUG-'|| (:2)   )  
OR ( h_egr < '1-SEP-'|| (:2-5 )  AND Mitroo in (select mitroo  from metdiakop where progcode =:1 AND dateapo between '1-SEP-2009' and '31-AUG-2010' )  )   ) ;

;ΜΕΓΙΣΤΗ ΔΙΑΡΚΕΙΑ 3 ΕΤΗ
select count(*) from metstuprog where progcode = :1 AND ( (h_egr < '1-SEP-'|| (:2+1-6 )  AND DATEANAG IS NULL)  OR ( h_egr < '1-SEP-'|| (:2-6 ) AND dateanag is not null and dateanag between '1-SEP-'|| (:2-1) and '31-AUG-'|| (:2)   )  
OR ( h_egr < '1-SEP-'|| (:2-6 )  AND Mitroo in (select mitroo  from metdiakop where progcode =:1 AND dateapo between '1-SEP-2009' and '31-AUG-2010' )  )   ) ;



select count(*) from metstuprog where progcode = :1 and h_egr < '1-SEP-'|| (:2-4 )  AND Mitroo in (select mitroo  from metdiakop where progcode =:1 AND dateapo between '1-SEP-2009' and '31-AUG-2010' ) ;


select count(*) from metstuprog where progcode = :1 AND ( (h_egr < '1-SEP-'|| (:2+1-4 )  AND DATEANAG IS NULL)  );

select MITROO, H_EGR, DATEANAG  from metstuprog where progcode = :1 AND ( h_egr < '1-SEP-'|| (:2-4 ) AND dateanag is not null and dateanag between '1-SEP-'|| (:2-1) and '31-AUG-'|| (:2)   )  ;



SELECT * FROM METSTUPROG WHERE PROGCODE = 3 ORDER BY DATEANAG DESC ;


