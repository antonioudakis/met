select courcode,max(@if(gradenor-gradepan,@if(@abs(gradenor-gradepan) - (gradenor-gradepan),gradepan,gradenor),gradenor)) as vathmos,period from metkartl where mitroo ='03001667'  group by courcode,period  order by period;

