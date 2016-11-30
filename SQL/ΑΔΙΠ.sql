select * from metprogram;
select * from metstuprog where ak = 2010;
select * from metprospu where ak = 2010 and progcode !=1;


;---------------------------------------------------------------------------------------------------------------;
; ------------------                       Σελίδα 6                  ------------------------------------;
;---------------------------------------------------------------------------------------------------------------;

create table page6 (aa integer,titlos varchar(250),courcode integer,web integer,page integer,dep varchar(254),type varchar(2),type1 varchar(3),period varchar(2), periodLekt varchar(5),egrno integer, partno integer, passno integer,ajiologisi varchar(1));
insert into page6 (courcode,period,periodLekt) select distinct metprospu.courcode,metprospu.period,@if(@mod(@value(metprospu.period),2),'Χειμ.','Εαρ.') from metprospu,metcourse where metcourse.courcode = metprospu.courcode and metprospu.ak = metcourse.ak and metprospu.ak = :1 and metprospu.progcode = :2;
update page6 set titlos = (select titlos from metcourse where page6.courcode = metcourse.courcode and metcourse.ak = :1);
update page6 set type = (select distinct eidosma from metprospu where page6.courcode = metprospu.courcode and metprospu.ak = :1 and metprospu.period = page6.period);
update page6 set egrno= (select count(*) from metkartl where ak = :1 and page6.courcode = metkartl.courcode);

store type
PROCEDURE: type
		PARAMETERS
			Receive Number: nCourCode
                        Receive String: sType


		LOCAL VARIABLES
			SQL HANDLE: hSqlCourses
                        SQL HANDLE: hSqlUpdate
                        Number: nFetch
                        Number: nFetch1
                        Number: nFetch2
                        
                        
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCourses)
                                Call SqlConnect( hSqlUpdate )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
!
!				Βρίσκω τα μαθήματα και τον τύπο του μαθήματος
!
				Call SqlPrepare(hSqlCourses, 'select courcode,type from page6   into  :nCourCode, :sType' )


			On Procedure Execute
				Call SqlExecute( hSqlCourses )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()


			On Procedure Fetch
					If NOT SqlFetchNext( hSqlCourses,nFetch )
						Return 1
					Else
!
!						Ενημερώνω τον πίνακα με την  τιμή του type1 για το συγκεκριμένο μάθημα
!
						If (sType = 'YX')
							Set sType = 'Y'
						Else
							If (sType = 'KY')
								Set sType = 'Y'	 
							Else
								If (sType = 'EP')
									Set sType = 'EE'
								Else
									Set sType =''	 					
						Call SqlPrepareAndExecute(hSqlUpdate, 'update page6 set type = :sType where courcode = :nCourCode')
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCourses)
				Call SqlDisconnect( hSqlUpdate );


execute type
\
,,
/
erase type;

store type1
PROCEDURE: type1
		PARAMETERS
			Number: nAk
			Receive Number: nCourCode
			Receive Number: nVr_upar
                        Receive Number: nVr_apar
                        Receive Number: nVr_epar
                        Receive String: sType


		LOCAL VARIABLES
			SQL HANDLE: hSqlCourses
                        SQL HANDLE: hSqlUpdate
                        Number: nFetch
                        Number: nFetch1
                        Number: nFetch2
                        
                        
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCourses)
                                Call SqlConnect( hSqlUpdate )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
!
!				Βρίσκω τα μαθήματα και τις ώρες θεωρίας , ασκήσεων και εργαστηρίου
!
				Call SqlPrepare(hSqlCourses, 'select page6.courcode,vr_upar,vr_apar,vr_epar from metcourse,page6  where metcourse.ak = :nAk and metcourse.courcode = page6.courcode into  :nCourCode, :nVr_upar, :nVr_apar, :nVr_epar' )


			On Procedure Execute
				Call SqlExecute( hSqlCourses )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()


			On Procedure Fetch
					If NOT SqlFetchNext( hSqlCourses,nFetch )
						Return 1
					Else
!
!						Ενημερώνω τον πίνακα με την  τιμή του type1 για το συγκεκριμένο μάθημα
!
						If (nVr_upar >0)
							if (nVr_apar>0)
								if (nVr_epar>0)
									Set sType = 'ΔΦΕ'
								Else
									Set sType = 'ΔΦ'
							Else
								if (nVr_epar>0)
									Set sType = 'ΔΕ'
								Else
									Set sType = 'Δ'
						Else
							if (nVr_apar>0)
								if (nVr_epar>0)
									Set sType = 'ΦΕ'
								Else
									Set sType = 'Φ'
							Else
								if (nVr_epar>0)
									Set sType = 'Ε'
								Else
									Set sType = ''
						Call SqlPrepareAndExecute(hSqlUpdate, 'update page6 set type1 = :sType where courcode = :nCourCode')
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCourses)
				Call SqlDisconnect( hSqlUpdate );


execute type1
\
2010,,,,,,
/
erase type1;


store courses
PROCEDURE: courses
		PARAMETERS
           		Number: nAk
			Receive Number: nCourCode
                        Receive Number: nAM_Dep
                        Receive String: sDep
                        Receive String: sEpvn
                        Receive String: sOnoma
                        Receive String: sBathmida


		LOCAL VARIABLES
			SQL HANDLE: hSqlCourses
			SQL HANDLE: hSqlDepInfo
                        SQL HANDLE: hSqlDep
                        SQL HANDLE: hSqlDepUpdate
                        Number: nFetch
                        Number: nFetch1
                        Number: nFetch2
                        
                        
		ACTIONS
			On Procedure Startup
				Call SqlConnect( hSqlCourses)
				Call SqlConnect( hSqlDepInfo )
                                Call SqlConnect( hSqlDep )
                                Call SqlConnect( hSqlDepUpdate )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()
!
!				Βρίσκω τα μαθήματα και τα μητώα των μελών ΔΕΠ που έχουν τα αντίστοιχα μαθήματα για το συγκεκριμένο έτος από τον πίνακα metdepma (ταξινόμηση με βάση τον κωδικό του μαθήματας και την βαθμίδα)
!
				Call SqlPrepare(hSqlCourses, 'select metdepma.courcode,metdepma.am_dep from metdepma,dep,page6  where metdepma.ak = :nAk and metdepma.am_dep = dep.am_dep and metdepma.courcode = page6.courcode order by metdepma.courcode,level into  :nCourCode, :nAM_Dep' )


			On Procedure Execute
				Call SqlExecute( hSqlCourses )
				When SqlError
					Call SqlImmediate('ROLLBACK')
					Call SqlClearImmediate()


			On Procedure Fetch
					If NOT SqlFetchNext( hSqlCourses,nFetch )
						Return 1
					Else
!
!						Βρίσκω το επώνυμο το όνομα και την βαθμίδα για το τρέχων μέλος ΔΕΠ
!
                                                Call SqlPrepare(hSqlDepInfo, 'select @trim(epvn),@trim(onoma),@trim(pltext) from dep,pltab  where am_dep = :nAM_Dep and plcolumn = \'LEVEL\' and pltab.plcode = dep.level into  :sEpvn, :sOnoma, :sBathmida' )
                                                Call SqlExecute(hSqlDepInfo)
                                                Call SqlFetchNext(hSqlDepInfo,nFetch1)
!
!						Βρίσκω τα μέλη ΔΕΠ που έχουν καταχωρηθεί προηγουμένως στο συγκεκριμένο μάθημα
!
                                                Call SqlPrepare(hSqlDep, 'select dep from page6  where courcode = :nCourCode into  :sDep' )
                                                Call SqlExecute(hSqlDep)
                                                Call SqlFetchNext(hSqlDep,nFetch2)
!
!						Ελέγχω αν είναι η πρώτη εγγραφή για το συγκεκριμένο μάθημα
!
                                                If sDep =  STRING_Null
							Set sDep = sEpvn||' '||sOnoma||' ('||sBathmida||')'
						Else
                                                	Set sDep = sDep||', '||sEpvn||' '||sOnoma||' ('||sBathmida||')'
!
!						Ενημερώνω τον πίνακα με την νέα τιμή τον μελών ΔΕΠ που έχω βρει μέχρι τώρα για το συγκεκριμένο μάθημα
!
						Call SqlPrepareAndExecute(hSqlDepUpdate, 'update page6 set dep  = :sDep where courcode = :nCourCode')
						Return 0
    			On Procedure Close
				Call SqlDisconnect( hSqlCourses)
                                Call SqlDisconnect( hSqlDepInfo )
                                Call SqlDisconnect( hSqlDep )
				Call SqlDisconnect( hSqlDepUpdate );


execute courses
\
2010,,,,,,,
/
erase courses;

select '^'||titlos||'^'||courcode||'^'||'^'||'^'||dep||'^'||type||'^'||type1||'^'||periodLekt||'^'||egrno from page6 order by periodLekt desc,titlos ;

drop table page6;


;---------------------------------------------------------------------------------------------------------------;
; ------------------                       Σελίδα 7                  ------------------------------------;
;---------------------------------------------------------------------------------------------------------------;

create table page7 (aa integer,titlos varchar(250),courcode integer,hours integer, aehours integer, monades integer,multipleprint varchar(1), period varchar(2));
insert into page7 (courcode,period) select distinct metprospu.courcode,metprospu.period from metprospu,metcourse where metcourse.courcode = metprospu.courcode and metprospu.ak = metcourse.ak and metprospu.ak = :1 and metprospu.progcode = :2;
update page7 set (titlos,hours,aehours,monades) = (select titlos,@if(@isna(vr_upar),0,vr_upar)+@if(@isna(vr_apar),0,vr_apar)+@if(@isna(vr_epar),0,vr_epar), @if(@isna(vr_apar),0,vr_apar)+@if(@isna(vr_epar),0,vr_epar),monades from metcourse where page7.courcode = metcourse.courcode and metcourse.ak = :1);

select '^'||titlos||'^'||courcode||'^'||hours||'^'||aehours||'^'||monades||'^'||'^'||period from page7 order by period,titlos;

drop table page7;

;---------------------------------------------------------------------------------------------------------------;
; ------------------                       Σελίδα 8                   ------------------------------------;
;---------------------------------------------------------------------------------------------------------------;

select count(*) from metstuprog where progcode =:2 and ak <= :1 and (dateanag is null or dateanag > '31-AUG-'||:1) and mitroo not in (select mitroo from metdiakop where metstuprog.progcode = metdiakop.progcode and dateapo <= '31-AUG-'||:1 and dateeos is null);

select count(*) from metstuprog where progcode =:2 and ak <= :1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1;

;---------------------------------------------------------------------------------------------------------------;
; ------------------                       Σελίδα 9                   ------------------------------------;
;---------------------------------------------------------------------------------------------------------------;

select count(*) from metstuprog where progcode = :2 and ak <=:1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1;
select count(*) from metstuprog where progcode = :2 and ak <=:1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1 and totbau >=5 and totbau < 6;
select count(*) from metstuprog where progcode = :2 and ak <=:1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1 and totbau >=6 and totbau < 7;
select count(*) from metstuprog where progcode = :2 and ak <=:1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1 and totbau >=7 and totbau < 8.5;
select count(*) from metstuprog where progcode = :2 and ak <=:1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1 and totbau >=8.5;

select avg(totbau) from metstuprog where progcode = :2 and ak <=:1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1 and totbau>=5;
select avg(totbau) from metstuprog where progcode = :2  and dateanag is not null and dateanag between '01-SEP-'||@string(:1-4,0) and '31-AUG-'||:1 and totbau>=5;


;---------------------------------------------------------------------------------------------------------------;
; ------------------                       Σελίδα 10                ------------------------------------;
;---------------------------------------------------------------------------------------------------------------;

select count(*) from metstuprog where progcode =1 and ak <= :1 and (dateanag is null or dateanag > '31-AUG-'||:1) and mitroo not in (select mitroo from metdiakop where metstuprog.progcode = metdiakop.progcode and dateapo <= '31-AUG-'||:1 and dateeos is null);

select count(*) from metstuprog where progcode =1 and ak <= :1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1;

create table page10 (mitroo varchar(8), ak integer, dateanag date, yearanag integer, sub integer);

insert into page10(mitroo,ak,dateanag,yearanag) select mitroo,ak,dateanag,@yearno(dateanag) from metstuprog where progcode =1 and ak <= :1 and dateanag is not null and dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||:1;
update page10 set yearanag = yearanag + 1 where dateanag between '01-SEP-'||yearanag and '31-DEC-'||yearanag;
update page10 set sub = yearanag - ak;
select avg(sub) from page10;
drop table page10;







