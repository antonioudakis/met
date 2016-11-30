select aa,ar_prot,upload,ent_ada from entalma where ent_ada is null;

select aa,ar_prot,upload,ent_ada from entalma where ar_prot =  'Ε21-'||:1||'/2011';

update entalma  set ent_ada = ent_ada||'Π' where  ar_prot =  'Ε21-'||:1||'/2011';

select aa,ar_prot,upload,ent_ada from entalma where ar_prot =  'Ε01-'||:1||'/2011';

update entalma  set ent_ada = ent_ada||'Π' where  ar_prot =  'Ε0  1-'||:1||'/2011';

select useaa,globserie,globcnt,dvgada from anpaymnt where useaa = 83 and globserie = 'Ε21' and globcnt =:1;

update anpaymnt set dvgada = dvgada||'Π' where  useaa = 83 and globserie = 'Ε21' and globcnt =:1;

;
Πεδία πίνακα ANDVGBUDGET

regnum		Αριθμός πρωτοκόλλου
issuedate		Ημερομηνία έκδοσης
emailaddr		Email
orgid		Φορέας
subject		Θέμα
typeid		Είδος Πράξης
totalvalue		Ποσό με Φ.Π.Α
iecode		Αριθμός Κ.Α.Ε
fisyear		Οικονομικό Έτος
dvgbdgcat	Κατηγορία Προϋπολογιμού (0 - null, 1 - Προϋπολογισμός Δαπάνης, 2 - Ετήσιος Προϋπολογισμός)
orgunitid		Μονάδα
signerid		Τελικός Υπογράφων
sectionid		Θεματική Περιοχή
filename		Αρχείο pdf
relatedada	Σχετιζόμενο ΑΔΑ
;

select status, regnum,ada from andvgbudget where ada is null;
select status, regnum,issuedate,emailaddr,orgid,subject,typeid,totalvalue,iecode,fisyear,dvgbdgcat,orgunitid,signerid,sectionid,filename,relatedada from andvgbudget;
