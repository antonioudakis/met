;-----------------------------------------------------------------------------------------------------------------------------------------------------------------������ 2-----------------------------------------------------------------------------------------------------------------------------------------------------------;

;������ ������� ������������� �������� ��� ��� ����� ����������� ���� ��� �� ���� ���������� ��� ��� ����� ����� �������� ���� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS; 

select metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) group by 1,2,3 order by 1,2,3;

;������� ������������� �������� ��� ��� ����� ����������� ���� ��� �� ���� ���������� ��� ��� ����� ����� �������� ���� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS 
;��� ��� ����� ������������ ���� � ���� ��������; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,sex,birthdate from metstuprog, met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) order by 4,5,6,2,3;

;������ ������� ������������� �������� ��� ��� ����� ����������� ���� ��� �� ���� ���������� ��� ��� ����� ����� �������� ���� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS 
;��� ����� ��� ����������� ������� ��� �� ���� ����������; 

select metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,@year(birthdate) as year_birth,count (distinct met.mitroo||metprogram.progcode||@if(1-sex,'������',@if(2-sex,'�������',sex))) as SYNOLO 
                        from metegr,metprogram,met,metstuprog
                        where metegr.progcode = metprogram.progcode and met.mitroo = metegr.mitroo and metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode 
                       and metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) group by 1,2,3 order by 1,2,3;

;������� ������������� �������� ��� ��� ����� ����������� ���� ��� �� ���� ���������� ��� ��� ����� ����� �������� ���� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS ��� ��� ����� ������������ ���� � ���� ��������;
;��� ����� ��� ����������� ������� ��� �� ����; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,birthdate
                        from metegr,metprogram,met,metstuprog
                        where  metegr.progcode = metprogram.progcode and met.mitroo = metegr.mitroo and metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode 
                       and metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) order by 4,5,6,2,3;


;������ �������������� ������������� �������� ��� ��� ����� �������� ERASMUS ���� ���� ��� ���� ��������; 

select metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak =:1  and (met.erasmus is null or met.erasmus ='2')  group by 1,2,3 order by 1,2,3;

;������� �������������� ������������� �������� ��� ��� ����� �������� ERASMUS ��� ��� ����� ������������ ���� � ���� ��������; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,birthdate from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak =:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) order by 4,5,6,2,3;

;������ ������������� ������������� �������� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS ���� ���� ��� ���� ��������; 

select metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) group by 1,2,3 order by 1,2,3;

;������������� ������������� �������� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS ��� ��� ����� ������������ ���� � ���� ��������; 

select met.mitroo, met.epvn, met.onoma,metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,birthdate from metstuprog,met,metprogram
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) and (sex is null or birthdate is null) order by 4,5,6,2,3;


;-----------------------------------------------------------------------------------------------------------------------------------------------------------------������ 3-----------------------------------------------------------------------------------------------------------------------------------------------------------;

;������ ������� ������������� �������� ��� ��� ����� ����������� ���� ��� �� ���� ���������� ��� ��� ����� ����� �������� ���� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS ��� ����� ��� ������������; 

select metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog,met,metprogram,metptyx
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;������� ������������� �������� ��� ��� ����� ����������� ���� ��� �� ���� ���������� ��� ��� ����� ����� �������� ���� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS ��� ����� ��� ������������
;��� ��� ����� ������������ ���� � ���� ��������; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,birthdate from metstuprog,met,metprogram,metptyx
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metstuprog.ak <=:1  and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview ='3' order by 4,5,6,2,3;

;������ ������� ������������� �������� ��� ��� ����� ����������� ���� ��� �� ���� ���������� ��� ��� ����� ����� �������� ���� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS 
;��� ����� ��� ����������� ������� ��� �� ���� ���������� ��� ����� ��� ������������; 

select metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,@year(birthdate) as year_birth,count (distinct met.mitroo||metprogram.progcode||@if(1-sex,'������',@if(2-sex,'�������',sex))) as SYNOLO 
                        from metegr,metprogram,met,metstuprog,metptyx
                        where metegr.progcode = metprogram.progcode and met.mitroo = metegr.mitroo and metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;������� ������������� �������� ��� ��� ����� ����������� ���� ��� �� ���� ���������� ��� ��� ����� ����� �������� ���� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS ��� ��� ����� ������������ ���� � ���� ��������;
;��� ����� ��� ����������� ������� ��� �� ���� ��� ����� ��� ������������; 

select met.mitroo,met.epvn,met.onoma,metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,birthdate 
                        from metegr,metprogram,met,metstuprog,metptyx
                        where metegr.progcode = metprogram.progcode and met.mitroo = metegr.mitroo and metstuprog.mitroo = metegr.mitroo and metstuprog.progcode = metegr.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metegr.ak = :1 and (met.erasmus is null or met.erasmus ='2') and (sex is null or birthdate is null) and (metstuprog.dateanag is null or metstuprog.dateanag >= '01-SEP-'||@string(:1,0)) 
                       and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.progcode = metstuprog.progcode and dateapo < '01-SEP-'||@string(:1,0) and dateeos is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview ='3' order by 4,5,6,2,3;


;������ ������������� ������������� �������� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS ���� ���� ��� ���� �������� ��� ����� ��� ������������; 

select metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,@year(birthdate) as year_birth,count(*) as SYNOLO from metstuprog,met,metprogram,metptyx
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' group by 1,2,3 order by 1,2,3;

;������������� ������������� �������� ��� �� ���� ���������� ��� ��� ����� �������� ERASMUS ��� ��� ����� ������������ ���� � ���� �������� ��� ����� ��� ������������; 

select met.mitroo, met.epvn, met.onoma,metprogram.titlos,@if(1-sex,'������',@if(2-sex,'�������',sex)) as sex,@year(birthdate) as year_birth from metstuprog,met,metprogram,metptyx
                       where metstuprog.mitroo = met.mitroo and metstuprog.progcode = metprogram.progcode and metstuprog.mitroo = metptyx.mitroo
                       and metstuprog.ak <=:1 and (met.erasmus is null or met.erasmus ='2')  and (metstuprog.dateanag between '01-SEP-'||@string(:1-1,0) and '31-AUG-'||@string(:1,0)) and (sex is null or birthdate is null) 
                       and metstuprog.progcode !=1 and metptyx.ptyxview = '3' order by 4,5,6,2,3;



