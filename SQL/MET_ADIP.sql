;=================================================================================================================================-;
;====================================================      ΠΙΝΑΚΑΣ 6      ==============================================================;
;=================================================================================================================================-;
;=============================       Μαθήματα μεταπτυχιακού προγράμματος σε συγκεκριμένο ακαδημαϊκό έτος     =============================;
;==================================================================================================================================;

;Οι παράμετροι της procedure καταχωρούνται στο τέλος και είναι οι εξής:

;1η Παράμετρος:	Ακαδημαϊκό Έτος
;2η Παράμετρος:	Κωδικός Προγράμματος

:Επιστρέφει την μεταβλητή output η οποία περιέχει όλες τις μεταβλητές χωρισμένες με τον ειδικό χαρακτήρα '#'. Συγκεκριμένα έχουμε:
;Τίτλος Μαθήματος#Κωδικός Μαθήματος#Ονοματεπώνυμο Μελών ΔΕΠ οι οοίοι είναι υπεύθυνοι για το μάθημα με την βαθμίδα τους#Είδος Μαθήματος#Διαλέξεις (Δ) ή Διαλέξεις και Εργαστήριο (Δ,Ε)#Εξάμηνο (Χειμερινό ή Θερινό)#Αριθμός φοιτητών που δήλωσαν το μάθημα#Αριθμός φοιτητών που έδωσαν το μάθημα#Αριθμός φοιτητών που πέρασαν το μάθημα;

procedure: course_proc
	parameters
		Number:			ak
		Number:			progcode
		Receive String:		output
 	local variables
   		Sql Handle: 		hSql1
		Sql Handle:		hSql2
		Sql Handle:		hSql3
		Sql Handle:		hSql4
		Sql Handle:		hSql5
		Number:			nInd
		Number:			courcode
		String:			depName
		Boolean:			firstRecord

		String:			titlos		
		String:			sCourcode
		String:			dep
		String:			eidosma
		String			vr_epar
		String:			period
		String:			ar_Diloseis
		String:			ar_Took_Exams
		String:			ar_Passed_Exams
 	actions
   		On Procedure Startup
    			Call SqlConnect( hSql1 )
			Call SqlConnect( hSql2 )
			Call SqlConnect( hSql3 )
			Call SqlConnect( hSql4 )
			Call SqlConnect( hSql5 )
   		On Procedure Execute
			Call SqlPrepare( hSql1, 'select distinct @trim(titlos),metcourse.courcode,eidosma,@if(vr_epar,\'Δ,E\',\'Δ\'),@if(@mod(metprospu.period,2),\'Χειμ.\',\'Θερ.\'),@String(metcourse.courcode,0) from metcourse,metprospu where metcourse.courcode = metprospu.courcode and metcourse.ak = metprospu.ak and metcourse.ak = :ak and metprospu.progcode =:progcode order by 5 desc,3 desc,1 into :titlos, :courcode, :eidosma, :vr_epar, :period, :sCourcode' )
			Call SqlPrepare( hSql2, 'select @trim(epvn)||\' \'||@trim(onoma)||\' \'||@trim(pltext) from (dep inner join metdepma on dep.am_dep = metdepma.am_dep) left join pltab on dep.level = pltab.plcode and plcolumn = \'LEVEL\' where courcode = :courcode and ak = :ak into :depName' )
			Call SqlPrepare( hSql3, 'select @String(count(*),0) from metkartl where ak = :ak and courcode = :courcode and progcode =:progcode into :ar_Diloseis')
			Call SqlPrepare( hSql4, 'select @String(count(*),0) from metkartl where ak = :ak and courcode = :courcode and progcode =:progcode and (gradenor is not null or gradepan is not null) into :ar_Took_Exams')
			Call SqlPrepare( hSql5, 'select @String(count(*),0) from metkartl where ak = :ak and courcode = :courcode and progcode =:progcode and (gradenor >= 5 or gradepan >= 5) into :ar_Passed_Exams')
    			Call SqlExecute( hSql1 )
		On Procedure Fetch
			If NOT SqlFetchNext( hSql1,nInd) 
				Return 1
			Else
				Set dep = STRING_Null
				Set firstRecord = True
				Call SqlExecute( hSql2 )
				While SqlFetchNext( hSql2, nInd )
					If firstRecord = True
						Set dep  = depName
						Set firstRecord = False
					Else
						Set dep  = dep||','||depName

				Call SqlExecute( hSql3 )
				Call SqlFetchNext( hSql3, nInd )

				Call SqlExecute( hSql4 )
				Call SqlFetchNext( hSql4, nInd )

				Call SqlExecute( hSql5 )
				Call SqlFetchNext( hSql5, nInd )

				Set output = titlos||'#'||sCourcode||'#'||dep||'#'||eidosma||'#'||vr_epar||'#'||period||'#'||ar_Diloseis||'#'||ar_Took_Exams||'#'||ar_Passed_Exams
				Return 0
   		On Procedure Close
    			Call SqlDisconnect( hSql1 )
			Call SqlDisconnect( hSql2 )
			Call SqlDisconnect( hSql3 )
			Call SqlDisconnect( hSql4 )
			Call SqlDisconnect( hSql5 )

\ 
2014,1,,
/

;=================================================================================================================================-;
;====================================================      ΠΙΝΑΚΑΣ 7      ==============================================================;
;=================================================================================================================================-;
;=============================       Μαθήματα μεταπτυχιακού προγράμματος σε συγκεκριμένο ακαδημαϊκό έτος     =============================;
;==================================================================================================================================;

;1η Παράμετρος:	Ακαδημαϊκό Έτος
;2η Παράμετρος:	Κωδικός Προγράμματος

:Επιστρέφει  όλες τις μεταβλητές χωρισμένες με τον ειδικό χαρακτήρα '#'. Συγκεκριμένα έχουμε:
;Τίτλος Μαθήματος#Κωδικός Μαθήματος#Ώρες Θεωρίας#Ώρες Εργαστηρίου#Διδακτικές Μονάδες#Εξάμηνο;

select distinct @trim(titlos)||'#'||@String(metcourse.courcode,0)||'#'||@String(vr_upar,0)||'#'||@String(vr_epar,0)||'#'||@String(monades,0)||'#'||metprospu.period from metcourse,metprospu where metcourse.courcode = metprospu.courcode and metcourse.ak = metprospu.ak and metcourse.ak = :1 and metprospu.progcode =:2 order by metprospu.period,titlos;

;=================================================================================================================================-;
;====================================================      ΠΙΝΑΚΑΣ 8      ==============================================================;
;=================================================================================================================================-;
;==========================        Αριθμός εισακτέων, αποφοίτων μεταπτυχιακών σε συγκεκριμένο ακαδημαϊκό έτος     ==========================;
;==================================================================================================================================;


;Μεταπτυχιακοί οι οποίοι δεν έχουν ακαδημαϊκό έτος 1ης εγγραφής;

select * from metstuprog where ak is null and progcode != 1;

;Μεταπτυχιακοί που έχουν ημερομηνία αναγόρευσης (dateanag) και δεν έχουν ακαδημαϊκό έτος αναγόρευσης (etosdipl). Αυτοί πρέπει να ενημερωθούν. Διαφορετικά πρέπει να πάω με ημερομηνία αναγόρευσης (dateanag);

select progcode,mitroo,dateanag from metstuprog where progcode != 1 and dateanag is not null and etosdipl is null order by 1;


;Παράμετρος : Ακαδημαϊκό έτος αναζήτησης;

;Πρωτοεγγεγραμμένοι μεταπτυχιακοί;

select progcode,count(*) from metstuprog where progcode != 1 and ak = :1 group by 1;

;1η Περίπτωση με βάση το έτος διπλώματος (etosDipl);

;Αναγορευμένοι μεταπτυχιακοί;

select progcode,count(*) from metstuprog where progcode !=1 and etosdipl = :1 group by 1;

select * from metstuprog where ak is null;


;Μέση Διάρκεια φοίτησης μεταπτυχιακών;

select progcode,avg(etosdipl -ak +1 ) from metstuprog where etosdipl=:1 and progcode != 1 and ak is not null and etosdipl is not null group by 1 order by 1; 


;2η Περίπτωση με βάση το έτος αναγόρευσης (dateanag);

;Αναγορευμένοι μεταπτυχιακοί;

select progcode,count(*) from metstuprog where progcode !=1 and dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0) group by 1;


;Μέση Διάρκεια φοίτησης μεταπτυχιακών;

select progcode,avg((dateanag-h_egr)/365) from metstuprog where progcode != 1 and h_egr is not null and  dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0) group by 1 order by 1; 


;=================================================================================================================================-;
;====================================================     ΠΙΝΑΚΑΣ 9     ==============================================================;
;=================================================================================================================================-;
;==========        Κατανομή βαθμολογίας και μέσος βαθμός πτυχίου μεταπτυχιακών αποφοίτων σε συγκεκριμένο ακαδημαϊκό έτος       ================;
;==================================================================================================================================;


;Μεταπτυχιακοί απόφοιτοι που έχουν ημερομηνία αναγόρευσης (dateanag) και δεν έχουν ακαδημαϊκό έτος αναγόρευσης (etosdipl). Αυτοί πρέπει να ενημερωθούν; Διαφορετικά πρέπει να πάω με ημερομηνία αναγόρευσης (dateanag);

select progcode,mitroo,dateanag from metstuprog where progcode != 1 and dateanag is not null and etosdipl is null order by 1;

;Παράμετρος: Ακαδημαϊκό έτος αναζήτησης;

;1η περίπτωση με βάση το έτος διπλώματος (etosDipl);

;Κατανομή βαθμολογίας μεταπτυχιακοί φοιτητές;

select progcode,count(*), '[5-6)' from metstuprog where progcode !=1 and etosdipl = :1 and totbau<6 group by 1
union
select progcode,count(*),'[6-7)'  from metstuprog where progcode !=1 and etosdipl = :1 and totbau>=6 and totbau<7 group by 1
union
select progcode,count(*),'[7-8.5)'  from metstuprog where progcode !=1 and etosdipl = :1 and totbau>=7 and totbau<8.5 group by 1
union
select progcode,count(*),'[8.5-10.0]'  from metstuprog where progcode !=1 and etosdipl = :1 and totbau>=8.5 and totbau<=10 group by 1 order by 1,3;


;Μέσος όρος βαθμολογίας μεταπτυχιακοί φοιτητές;

select progcode,avg(totbau) from metstuprog where progcode !=1 and etosdipl = :1 and totbau is not null group by 1;


;2η περίπτωση με βάση την ημερομηνία αναγόρευσης (dateanag);

;Κατανομή βαθμολογίας μεταπτυχιακοί φοιτητές;

select progcode,count(*), '[5-6)' from metstuprog where progcode !=1 and  dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0) and totbau<6 group by 1
union
select progcode,count(*),'[6-7)'  from metstuprog where progcode !=1 and  dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0) and totbau>=6 and totbau<7 group by 1
union
select progcode,count(*),'[7-8.5)'  from metstuprog where progcode !=1 and  dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0) and totbau>=7 and totbau<8.5 group by 1
union
select progcode,count(*),'[8.5-10.0]'  from metstuprog where progcode !=1 and  dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0) and totbau>=8.5 and totbau<=10 group by 1 order by 1,3;


;Μέσος όρος βαθμολογίας μεταπτυχιακοί φοιτητές;

select progcode,avg(totbau) from metstuprog where progcode !=1 and dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0) and totbau is not null group by 1;


;=================================================================================================================================-;
;====================================================     ΠΙΝΑΚΑΣ 10     ==============================================================;
;=================================================================================================================================-;
;=============        Αριθμός εισακτέων, αποφοίτων Διδάκτρορες και μέσος χρόνος φοίτητης σε συγκεκριμένο ακαδημαϊκό έτος       ================;
;==================================================================================================================================;


;ΥΔ οι οποίοι δεν έχουν ακαδημαϊκό έτος 1ης εγγραφής;

select * from metstuprog where ak is null and progcode = 1;


;ΥΔ που έχουν ημερομηνία αναγόρευσης (dateanag) και δεν έχουν ακαδημαϊκό έτος αναγόρευσης (etosdipl). Αυτοί πρέπει να ενημερωθούν;  Διαφορετικά πρέπει να πάω με ημερομηνία αναγόρευσης (dateanag);

select progcode,mitroo,dateanag from metstuprog where progcode = 1 and dateanag is not null and etosdipl is null order by 1;


;Παράμετρος Ακαδημαϊκό έτος αναζήτησης;


;Πρωτοεγγεγραμμένοι ΥΔ;

select count(*) from metstuprog where progcode = 1 and ak = :1;


;1η περίπτωση με βάση το έτος διπλώματος (etosDipl);

;Αναγορευμένοι Διδάκτορες;

select count(*) from metstuprog where progcode =1 and etosdipl = :1;


;Μέση Διάρκεια φοίτησης Διδακτόρων;

select avg(etosdipl -ak +1 ) from metstuprog where etosdipl=:1 and progcode = 1 and ak is not null and etosdipl is not null order by 1; 


;2η περίπτωση με βάση την ημερομηνία αναγόρευσης (dateanag);

;Αναγορευμένοι Διδάκτορες;

select count(*) from metstuprog where progcode =1 and dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0);


;Μέση Διάρκεια φοίτησης Διδακτόρων;

select avg((dateanag-h_egr)/365) from metstuprog where progcode = 1 and h_egr is not null and  dateanag between '11/01/'||@string(:1-1,0) and '10/31/'||@String(:1,0) order by 1; 



;=================================================================================================================================-;
;====================================================     ΠΙΝΑΚΑΣ 15     ==============================================================;
;=================================================================================================================================-;
;========================         Εξέλιξη των φοιτητών ανά έτος. Ψάχνω δηλαδή του εγγεγραμμένους         ====================================;
;==================================================================================================================================;


;Μμεταπτυχιακά προγράμματα της σχολής;

select * from metprogram;


;Φοιτητές που έχουν ημερομηνία αναγόρευσης (dateanag) και δεν έχουν ακαδημαϊκό έτος αναγόρευσης (etosdipl). Αυτοί πρέπει να ενημερωθούν;

select progcode,mitroo,dateanag from metstuprog where dateanag is not null and etosdipl is null order by 1;


;Παράμετρος Ακαδημαϊκό έτος αναζήτησης;


;Αναζήτηση με βάση το έτος διπλώματος (etosdipl);

select progcode,count(*) from metstuprog where (etosdipl is null or etosdipl > :1) and ak <=:1 and mitroo not in (select mitroo from metdiakop where dateeos is null and dateapo < '08/31/'||@string(:1,0) and metdiakop.progcode = metstuprog.progcode ) group by 1;


;Αναζήτηση με βάση την ημερομηνία αναγόρευσης (dateanag);

select progcode,count(*) from metstuprog where (dateanag is null or dateanag >  '08/31/'||@string(:1,0)) and ak <=:1 and mitroo not in (select mitroo from metdiakop where dateeos is null and dateapo < '08/31/'||@string(:1,0) and metdiakop.progcode = metstuprog.progcode) group by 1;
