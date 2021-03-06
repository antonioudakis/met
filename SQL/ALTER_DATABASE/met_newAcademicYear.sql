;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
;--------------------------------------------------------------------------------------------ΜΕΤΑΒΑΣΗ ΑΠΟ ΤΟ ΠΑΛΙΟ ΑΚΑΔΗΜΑΪΚΟ ΕΤΟΣ  ΣΤΟ ΝΕΟ-----------------------------------------------------------------------------------------------;
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
;
; Δημιουργείται το νέο πρόγραμμα σπουδών,τα νέα μαθήματα, οι ιδιότητες του κάθε προγράμματος οι καθηγητές και οι επιβλέποντες των μαθημάτων τα οποίο είναι 
; αντίγραφα του αμέσως προηγούμενου ακαδημαϊκού έτους;
; Οι επιμέρους αλλαγές γίνονται χειροκίνητα. Τα παρακάτω sql έχουν μια παράμετρο η οποία είναι το νέο ακαδημαϊκό έτος;
; ΠΡΟΣΟΧΗ. Σαν Ακαδημαϊκό έτος βάζουμε το έτος λήξεως. Για παράδειγμα για το ακαδημαϊκό έτος 2008-2009 βάζουμε 2009, για το 2009-2010 βάζουμε 2010 κ.λ.π; 
;Τέλος θα πρέπει ο κάθε χρήστης με την σύνδεση του στο σύστημα να αλλάξει το τρέχον ακαδημαϊκό του έτος;
;
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;

select * from metcourse where ak = :1;

insert into metcourse (courcode,tmimacode,univcode,tmimacodepar,titlos,period,krg,e_k,maxfoit,vr_upar,vr_apar,vr_epar,prakpar,monades,tomcodepar,ak) 
select courcode,tmimacode,univcode,tmimacodepar,titlos,period,krg,e_k,maxfoit,vr_upar,vr_apar,vr_epar,prakpar,monades,tomcodepar,:1 from metcourse where ak = :1-1;

select * from metprospu where ak = :1;

insert into metprospu (progcode,courcode,period,tmimacode,kat,eidosma,ak)
select progcode,courcode,period,tmimacode,kat,eidosma,:1 from metprospu where ak = :1-1;

select * from metprogat where ak = :1;

insert into metprogat (tmimacode,progcode,limit,limitdipl,roundmo,wdipl,arcourdipl,mini,maxi,lectper,ypapof,ak)
select tmimacode,progcode,limit,limitdipl,roundmo,wdipl,arcourdipl,mini,maxi,lectper,ypapof,:1 from metprogat where ak = :1-1;

select * from metdepma where ak = :1;

insert into metdepma (courcode,am_dep,ak) 
select courcode,am_dep,:1 from metdepma where ak = :1-1 ;

select * from  metepiblma where ak = :1;

insert into metepiblma (courcode,am_dep,ak)
select courcode,am_dep,:1 from metepiblma where ak = :1-1;

