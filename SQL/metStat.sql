;ΤΜΗΜΑ.χls
;ΔΕΛΤΙΟ Φ2: ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΦΟΙΤΗΤΕΣ ΚΑΙ ΑΠΟΦΟΙΤΟΙ ΤΟΥ ΤΜΗΜΑΤΟΣ
;=================================================================================================================================================================
;1. ΜΕΤΑΠΤΥΧΙΑΚΟΣ ΦΟΙΤΗΤΙΚΟΣ ΠΛΗΘΥΣΜΟΣ ΚΑΤΑ ΦΥΛΟ, ΗΛΙΚΙΑ ΚΑΙ ΕΠΙΠΕΔΟ ΣΠΟΥΔΩΝ
;=================================================================================================================================================================
;Ενεργοί Υποψήφιοι διδάκτορες ανά φύλο και ηλικία
;Δεν έχουν αναγορευτεί ή έχουν αναγορευτεί μετά το ακαδημαϊκό έτος αναζήτησης  και δεν έχουν πάρει οριστική διαγραφή ή έχουν πάρει μετά το ακαδημαϊκό έτος αναζήτησης 
;Ακαδημαϊκό έτος ξεκινάει την 1η  Σεπτεμβρίου και τελειώνει  31 Αυγούστου

;=================================================================================================================================================================
;'Ελεγχος για ΥΔ που πληρούν τις προϋποθέσεις αλλά δεν έχουν ημερομηνία γέννησης ή φύλο
;
select metstuprog.mitroo, sex, birthdate
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
and (birthdate is null or sex is null);

;=================================================================================================================================================================
;Εκτύπωση κατάστασης ενεργών ΥΔ ανά φύλο και ηλικία
;
select count(metstuprog.mitroo) ,@year(sysdate) - @year(birthdate) as age, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
group by 2,3 order by 2,3;

;=================================================================================================================================================================
;Ενεργοί μεταπτυχιακοί φοιτητές ανά φύλο και ηλικία
;Δεν έχουν αναγορευτεί ή έχουν αναγορευτεί μετά το ακαδημαϊκό έτος αναζήτησης  και δεν έχουν πάρει οριστική διαγραφή ή έχουν πάρει μετά το ακαδημαϊκό έτος αναζήτησης 
;Ακαδημαϊκό έτος ξεκινάει την 1η  Σεπτεμβρίου και τελειώνει  31 Αυγούστου

;'Ελεγχος για μεταπτυχιακούς φοιτητές που πληρούν τις προϋποθέσεις αλλά δεν έχουν ημερομηνία γέννησης ή φύλο
;
select metstuprog.mitroo, sex, birthdate
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
and (birthdate is null or sex is null);

;=================================================================================================================================================================
;Εκτύπωση κατάστασης ενεργών μεταπτυχιακών φοιτητών ανά φύλο και ηλικία
;
select count(metstuprog.mitroo), @year(sysdate) - @year(birthdate) as age, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
group by 2,3 order by 2,3;

;=================================================================================================================================================================
;2. ΦΟΙΤΗΤΙΚΟΣ ΠΛΗΘΥΣΜΟΣ ΥΠΟΨΗΦΙΩΝ ΔΙΔΑΚΤΟΡΩΝ ΚΑΤΑ ΕΤΟΣ ΣΠΟΥΔΩΝ ΚΑΙ ΦΥΛΟ
;=================================================================================================================================================================

;'Ελεγχος για ΥΔ  που πληρούν τις προϋποθέσεις αλλά δεν έχουν ακαδημαϊκό έτος πρώτης εγγραφής ή φύλο
;
select metstuprog.mitroo,metstuprog.ak, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
and (metstuprog.ak <=:1 and sex is null) or (metstuprog.ak is null);


;=================================================================================================================================================================
;Εκτύπωση κατάστασης ενεργών ΥΔ ανά έτος σπουδών και φύλο;
;
select count(metstuprog.mitroo) ,:1-metstuprog.ak+1 as etos, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
and metstuprog.ak <=:1
group by 2,3 order by 2,3;

;=================================================================================================================================================================
;4. ΑΡΙΘΜΟΣ ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΑΠΟΦΟΙΤΩΝ ΣΤΟ ΤΕΛΕΥΤΑΙΟ ΗΜΕΡΟΛΟΓΙΑΚΟ ΕΤΟΣ ΚΑΤΑ ΦΥΛΟ, ΗΛΙΚΙΑ ΚΑΙ ΕΠΙΠΕΔΟ ΣΠΟΥΔΩΝ
;=================================================================================================================================================================


