;-----------------------------------------------------------------------------------------------------------------------------------------------------------------емтупо 2-----------------------------------------------------------------------------------------------------------------------------------------------------------;

;пкгхос емеяцым летаптувиайым жоитгтым поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг леса сто ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS; 

select metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from (metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode
                       where metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) group by 1,2,3 order by 1,2,3;

;емеяцои летаптувиайои жоитгтес поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг леса сто ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS 
;йаи дем евоум йатавыяглемо жуко г етос цеммгсгс; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,sex,birthdate from (metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode
                       where metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) order by 4,5,6,2,3;

;пкгхос емеяцым летаптувиайым жоитгтым поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг леса сто ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS 
;йаи евоум лиа тоукавистом еццяажг сто ай етос амафгтгсгс; 

select metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,@year(birthdate) as year_birth,count (distinct met.mitroo||metprogram.progcode||@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex))) as SYNOLO 
                        from ((metegr inner join metprogram on metegr.progcode = metprogram.progcode) inner join met on met.mitroo = metegr.mitroo) inner join metstuprog on metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode 
                        where metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) group by 1,2,3 order by 1,2,3;

;емеяцои летаптувиайои жоитгтес поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг леса сто ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS йаи дем евоум йатавыяглемо жуко г етос цеммгсгс;
;йаи евоум лиа тоукавистом еццяажг сто ай етос; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,birthdate
                        from ((metegr inner join metprogram on metegr.progcode = metprogram.progcode) inner join met on met.mitroo = metegr.mitroo) inner join metstuprog on metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode 
                        where metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) order by 4,5,6,2,3;


;пкгхос меоеисавхемтым летаптувиайым жоитгтым поу дем еимаи жоитгтес ERASMUS йата жуко йаи етос цеммгсгс; 

select metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from (metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode
                       where metstuprog.ak =:1  and (met.erasmus is null or met.erasmus ='2')  group by 1,2,3 order by 1,2,3;

;емеяцои меоеисавхемтес летаптувиайои жоитгтес поу дем еимаи жоитгтес ERASMUS йаи дем евоум йатавыяглемо жуко г етос цеммгсгс; 

select met.mitroo,met.epvn,met.onoma,progcode,sex,birthdate from metstuprog inner join met on metstuprog.mitroo = met.mitroo 
                       where metstuprog.ak =:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) order by 4,5,6,2,3;

;пкгхос амацояеулемым летаптувиайым жоитгтым сто ай етос амафгтгсгс поу дем еимаи жоитгтес ERASMUS йата жуко йаи етос цеммгсгс; 

select metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from (metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode
                       where metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) group by 1,2,3 order by 1,2,3;

;амацояеулемои летаптувиайои жоитгтес сто ай етос амафгтгсгс поу дем еимаи жоитгтес ERASMUS йаи дем евоум йатавыяглемо жуко г етос цеммгсгс; 

select met.mitroo, met.epvn, met.onoma,metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,birthdate from (metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode
                       where metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) and (sex is null or birthdate is null) order by 4,5,6,2,3;


;-----------------------------------------------------------------------------------------------------------------------------------------------------------------емтупо 3-----------------------------------------------------------------------------------------------------------------------------------------------------------;

;пкгхос емеяцым летаптувиайым жоитгтым поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг леса сто ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS йаи евоум гдг летаптувиайо; 

select metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from ((metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode) 
			inner join metptyx on metstuprog.mitroo = metptyx.mitroo
                       where metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;емеяцои летаптувиайои жоитгтес поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг леса сто ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS йаи евоум гдг летаптувиайо
;йаи дем евоум йатавыяглемо жуко г етос цеммгсгс; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,birthdate from ((metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode) 
                       inner join metptyx on metstuprog.mitroo = metptyx.mitroo
                       where metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview ='3' order by 4,5,6,2,3;

;пкгхос емеяцым летаптувиайым жоитгтым поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг леса сто ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS 
;йаи евоум лиа тоукавистом еццяажг сто ай етос амафгтгсгс йаи евоум гдг летаптувиайо; 

select metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,@year(birthdate) as year_birth,count (distinct met.mitroo||metprogram.progcode||@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex))) as SYNOLO 
                        from (((metegr inner join metprogram on metegr.progcode = metprogram.progcode) inner join met on met.mitroo = metegr.mitroo) inner join metstuprog on metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode) 
                        inner join metptyx on metstuprog.mitroo = metptyx.mitroo
                        where metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;емеяцои летаптувиайои жоитгтес поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг леса сто ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS йаи дем евоум йатавыяглемо жуко г етос цеммгсгс;
;йаи евоум лиа тоукавистом еццяажг сто ай етос йаи евоум гдг летаптувиайо; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,birthdate 
                        from (((metegr inner join metprogram on metegr.progcode = metprogram.progcode) inner join met on met.mitroo = metegr.mitroo) inner join metstuprog on metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode)
                        inner join metptyx on metstuprog.mitroo = metptyx.mitroo
                        where metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview ='3' order by 4,5,6,2,3;


;пкгхос амацояеулемым летаптувиайым жоитгтым сто ай етос амафгтгсгс поу дем еимаи жоитгтес ERASMUS йата жуко йаи етос цеммгсгс; 

select metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from ((metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode)
                       inner join metptyx on metstuprog.mitroo = metptyx.mitroo
                       where metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;амацояеулемои летаптувиайои жоитгтес сто ай етос амафгтгсгс поу дем еимаи жоитгтес ERASMUS йаи дем евоум йатавыяглемо жуко г етос цеммгсгс; 

select met.mitroo, met.epvn, met.onoma,metprogram.titlos,@if(1-sex,'хгкеис',@if(2-sex,'аяяемес',sex)) as sex,@year(birthdate) as year_birth from ((metstuprog inner join met on metstuprog.mitroo = met.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode)
                       inner join metptyx on metstuprog.mitroo = metptyx.mitroo
                       where metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) and (sex is null or birthdate is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' order by 4,5,6,2,3;



