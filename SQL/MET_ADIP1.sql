;Μεταπτυχιακοί που έχουν ημερομηνία αναγόρευσης (dateanag) και δεν έχουν ακαδημαϊκό έτος αναγόρευσης (etosdipl). Αυτοί πρέπει να ενημερωθούν. Διαφορετικά πρέπει να πάω με ημερομηνία αναγόρευσης (dateanag);

select progcode,mitroo,dateanag from metstuprog where  dateanag is not null and etosdipl is null order by 1;

;Έλεγχος μη καταχωρημένους ακαδημαϊκού 1ου έτος εγγραφής;

select * from metstuprog where ak is null;

select * from metprogram;

;Εξέλιξη φοιτητών. Αναζήτηση με βάση το έτος διπλώματος (etosdipl);

select progcode,count(*) from metstuprog where (etosdipl is null or etosdipl > :1) and ak <=:1 and mitroo not in (select mitroo from metdiakop where dateeos is null and dateapo < '08/31/'||@string(:1,0) and metdiakop.progcode = metstuprog.progcode ) and mitroo not in (select mitroo from met where erasmus = 1) group by 1;

;Πρωτοεγγεγραμμένοι μεταπτυχιακοί;

select progcode,count(*) from metstuprog,met where  met.mitroo = metstuprog.mitroo and (met.erasmus is null or met.erasmus =2) and ak = :1 group by 1;

;Πρωτοεγγεγραμμένοι αλλοδαποί;

select progcode,count(*) from metstuprog,met where  met.mitroo = metstuprog.mitroo and (met.erasmus is null or met.erasmus =2) and met.yphk is not null  and met.yphk != '0099' and ak = :1 group by 1;

;Αναγορευμένοι μεταπτυχιακοί;

select progcode,count(*) from metstuprog where etosdipl = :1 group by 1;

;Αναγορευμένοι αλλοδαποί;

select progcode,count(*) from metstuprog,met where met.mitroo= metstuprog.mitroo  and met.yphk is not null and met.yphk != '0099' and etosdipl = :1 group by 1;

;Μέση Διάρκεια φοίτησης μεταπτυχιακών;

;Με βάση το ακαδημαϊκό έτος εγγραφής;

select progcode,avg(etosdipl -ak + 1 ) from metstuprog where etosdipl=:1 and ak is not null and etosdipl is not null group by 1 order by 1; 

΄Με βάση την ημερομηνία εγγραφής και την ημερομηνία αναγόρευσης;

select progcode,avg((dateanag-h_egr)/365) from metstuprog where etosdipl=:1 and ak is not null and etosdipl is not null group by 1 order by 1; 

;Κατανομή βαθμολογίας μεταπτυχιακοί φοιτητές;

select progcode,count(*), '[5-6)' from metstuprog where etosdipl = :1 and totbau<6 group by 1
union
select progcode,count(*),'[6-7)'  from metstuprog where  etosdipl = :1 and totbau>=6 and totbau<7 group by 1
union
select progcode,count(*),'[7-8.5)'  from metstuprog where  etosdipl = :1 and totbau>=7 and totbau<8.5 group by 1
union
select progcode,count(*),'[8.5-10.0]'  from metstuprog where  etosdipl = :1 and totbau>=8.5 and totbau<=10 group by 1 order by 1,3;

;Μέσος όρος βαθμολογίας μεταπτυχιακοί φοιτητές;

select progcode,avg(totbau) from metstuprog where etosdipl = :1 and totbau is not null group by 1;


