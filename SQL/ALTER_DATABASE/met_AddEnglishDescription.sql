alter table metcourse add titlosEng varchar(250);
alter table metanathesi add themaEng varchar(250);

alter table mettomeis add titlosEng varchar(100);
alter table metkatef add titlosEng varchar(150);
alter table mettmima add titlosEng varchar(50);
alter table metprogram add titlosEng varchar(100);
alter table metprogat add miniEng varchar(20);
alter table metprogat add maxiEng varchar(20);

update metprogat set maxiEng = @if(@exact(@mid(maxi,@scan(maxi,' ')+1,@length(maxi)),'ΕΤΗ'),@mid(maxi,0,@scan(maxi,' ')+1)||'YEARS',maxiEng) ;
update metprogat set maxiEng = @if(@exact(@mid(maxi,@scan(maxi,' ')+1,@length(maxi)),'ΕΤΟΣ'),@mid(maxi,0,@scan(maxi,' ')+1)||'YEAR',maxiEng) ;
update metprogat set maxiEng =  @if(@exact(@mid(maxi,@scan(maxi,' ')+1,@length(maxi)),'ΕΞΑΜΗΝΟ'),@mid(maxi,0,@scan(maxi,' ')+1)||'SIX MONTH TERM',maxiEng);
update metprogat set maxiEng =  @if(@exact(@mid(maxi,@scan(maxi,' ')+1,@length(maxi)),'ΕΞΑΜΗΝΑ'),@mid(maxi,0,@scan(maxi,' ')+1)||'SIX MONTH TERMS',maxiEng) ;
update metprogat set maxiEng =  @if(@exact(@mid(maxi,@scan(maxi,' ')+1,@length(maxi)),'ΤΕΤΡΑΜΗΝΟ'),@mid(maxi,0,@scan(maxi,' ')+1)||'FOUR MONTH TERM',maxiEng);
update metprogat set maxiEng =  @if(@exact(@mid(maxi,@scan(maxi,' ')+1,@length(maxi)),'ΤΕΤΡΑΜΗΝΑ'),@mid(maxi,0,@scan(maxi,' ')+1)||'FOUR MONTH TERMS',maxiEng) ;
update metprogat set maxiEng =  @if(@exact(@mid(maxi,@scan(maxi,' ')+1,@length(maxi)),'ΤΡΙΜΗΝΟ'),@mid(maxi,0,@scan(maxi,' ')+1)||'THREE MONTH TERM',maxiEng) ;
update metprogat set maxiEng =  @if(@exact(@mid(maxi,@scan(maxi,' ')+1,@length(maxi)),'ΤΡΙΜΗΝΑ'),@mid(maxi,0,@scan(maxi,' ')+1)||'THREE MONTH TERMS',maxiEng) ;

update metprogat set miniEng =  @if(@exact(@mid(mini,@scan(mini,' ')+1,@length(mini)),'ΕΤΗ'),@mid(mini,0,@scan(mini,' ')+1)||'YEARS',miniEng) ;
update metprogat set miniEng =  @if(@exact(@mid(mini,@scan(mini,' ')+1,@length(mini)),'ΕΤΟΣ'),@mid(mini,0,@scan(mini,' ')+1)||'YEAR',miniEng) ;
update metprogat set miniEng =  @if(@exact(@mid(mini,@scan(mini,' ')+1,@length(mini)),'ΕΞΑΜΗΝΟ'),@mid(mini,0,@scan(mini,' ')+1)||'SIX MONTH TERM',miniEng) ;
update metprogat set miniEng =  @if(@exact(@mid(mini,@scan(mini,' ')+1,@length(mini)),'ΕΞΑΜΗΝΑ'),@mid(mini,0,@scan(mini,' ')+1)||'SIX MONTH TERMS',miniEng) ;
update metprogat set miniEng =  @if(@exact(@mid(mini,@scan(mini,' ')+1,@length(mini)),'ΤΕΤΡΑΜΗΝΟ'),@mid(mini,0,@scan(mini,' ')+1)||'FOUR MONTH TERM',miniEng) ;
update metprogat set miniEng =  @if(@exact(@mid(mini,@scan(mini,' ')+1,@length(mini)),'ΤΕΤΡΑΜΗΝΑ'),@mid(mini,0,@scan(mini,' ')+1)||'FOUR MONTH TERMS',miniEng) ;
update metprogat set miniEng =  @if(@exact(@mid(mini,@scan(mini,' ')+1,@length(mini)),'ΤΡΙΜΗΝΟ'),@mid(mini,0,@scan(mini,' ')+1)||'THREE MONTH TERM',miniEng) ;
update metprogat set miniEng =  @if(@exact(@mid(mini,@scan(mini,' ')+1,@length(mini)),'ΤΡΙΜΗΝΑ'),@mid(mini,0,@scan(mini,' ')+1)||'THREE MONTH TERMS',miniEng) ;

CREATE TABLE METCOURSEENG (COURCODE INTEGER,TITLOS VARCHAR(250),TITLOSENG VARCHAR(250));
INSERT INTO METCOURSEENG SELECT COURCODE,TITLOS,TITLOSENG FROM METCOURSE WHERE AK = :1 AND TITLOSENG IS NOT NULL;
UPDATE METCOURSE SET TITLOSENG = (SELECT TITLOSENG FROM METCOURSEENG WHERE METCOURSEENG.COURCODE = METCOURSE.COURCODE) WHERE METCOURSE.AK =:1;
DROP TABLE METCOURSEENG;


UPDATE METKATEF SET TITLOSENG = 'NOT SPECIFIED' WHERE KAT = '00'; 
UPDATE METKATEF SET TITLOSENG = 'TECHNOLOGY MANAGEMENT SYSTEMS' WHERE KAT = '32'; 
UPDATE METKATEF SET TITLOSENG = 'PRODUCTION MANAGEMENT SYSTEMS' WHERE KAT = '33'; 

UPDATE METTMIMA SET TITLOSENG = 'ELECTRICAL AND COMPUTER ENGINEERING' WHERE TMIMACODE =3; 

UPDATE METPROGRAM SET TITLOSENG = 'DOCTORAL CANDIDATES' WHERE PROGCODE = 1;
UPDATE METPROGRAM SET TITLOSENG = 'ENERGY PRODUCTION AND MANAGEMENT' WHERE PROGCODE =2;
UPDATE METPROGRAM SET TITLOSENG = 'TECHNO-ECONOMIC SYSTEMS' WHERE PROGCODE =3;

insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG01','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF CIVIL ENGINEERING');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG02','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF MECHANICAL ENGINEERING');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG03','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF ELECTRICAL AND COMPUTER ENGINEERING');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG04','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF ARCHITECTURE');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG05','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF CHEMICAL ENGINEERING');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG06','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF RURAL AND SURVEYING ENGINEERING');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG07','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF MINING METALLURGICAL ENGINEERING');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG08','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF NAVAL ARCHITECTURE AND MARINE ENGINEERING');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('IDRYMA','ENG09','G','NATIONAL TECHNICAL UNIVERSITY OF ATHENS, SCHOOL OF APPLIED MATHEMATICAL AND PHYSICAL SCIENCE');



