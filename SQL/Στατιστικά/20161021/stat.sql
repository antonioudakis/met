;===================пяосовг паяалетяо бафете то етос 2015===================================================

;емеяцои меоеисавхемтес летаптувиайои жоитгтес поу дем еимаи жоитгтес ERASMUS;

select metprogram.titlos,count(*) from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak =:1  and (met.erasmus is null or met.erasmus ='2') group by 1 order by 1;

;пкгхос емеяцым летаптувиайым жоитгтым поу дем евоум амацояеухеи леса сто ай етос амафгтгсгс йаи дем евоум паяеи диацяажг левяи йаи то ай етос амафгтгсгс йаи дем еимаи жоитгтес ERASMUS; 

select metprogram.titlos,count(*) as SYNOLO from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) group by 1 order by 1;	


;пкгхос амацояеулемым летаптувиайым жоитгтым сто ай етос амафгтгсгс поу дем еимаи жоитгтес ERASMUS;

select metprogram.titlos,count(*) as SYNOLO from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) group by 1 order by 1;

