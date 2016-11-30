;�����.�ls
;������ �2: ������������� �������� ��� ��������� ��� ��������
;=================================================================================================================================================================
;1. ������������� ���������� ��������� ���� ����, ������ ��� ������� �������
;=================================================================================================================================================================
;������� ��������� ���������� ��� ���� ��� ������
;��� ����� ����������� � ����� ����������� ���� �� ���������� ���� ����������  ��� ��� ����� ����� �������� �������� � ����� ����� ���� �� ���������� ���� ���������� 
;���������� ���� �������� ��� 1�  ����������� ��� ���������  31 ���������

;=================================================================================================================================================================
;'������� ��� �� ��� ������� ��� ������������ ���� ��� ����� ���������� �������� � ����
;
select metstuprog.mitroo, sex, birthdate
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
and (birthdate is null or sex is null);

;=================================================================================================================================================================
;�������� ���������� ������� �� ��� ���� ��� ������
;
select count(metstuprog.mitroo) ,@year(sysdate) - @year(birthdate) as age, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
group by 2,3 order by 2,3;

;=================================================================================================================================================================
;������� ������������� �������� ��� ���� ��� ������
;��� ����� ����������� � ����� ����������� ���� �� ���������� ���� ����������  ��� ��� ����� ����� �������� �������� � ����� ����� ���� �� ���������� ���� ���������� 
;���������� ���� �������� ��� 1�  ����������� ��� ���������  31 ���������

;'������� ��� �������������� �������� ��� ������� ��� ������������ ���� ��� ����� ���������� �������� � ����
;
select metstuprog.mitroo, sex, birthdate
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
and (birthdate is null or sex is null);

;=================================================================================================================================================================
;�������� ���������� ������� ������������� �������� ��� ���� ��� ������
;
select count(metstuprog.mitroo), @year(sysdate) - @year(birthdate) as age, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode != 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and metdiakop.progcode = metstuprog.progcode)
group by 2,3 order by 2,3;

;=================================================================================================================================================================
;2. ���������� ��������� ��������� ���������� ���� ���� ������� ��� ����
;=================================================================================================================================================================

;'������� ��� ��  ��� ������� ��� ������������ ���� ��� ����� ���������� ���� ������ �������� � ����
;
select metstuprog.mitroo,metstuprog.ak, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
and (metstuprog.ak <=:1 and sex is null) or (metstuprog.ak is null);


;=================================================================================================================================================================
;�������� ���������� ������� �� ��� ���� ������� ��� ����;
;
select count(metstuprog.mitroo) ,:1-metstuprog.ak+1 as etos, sex
from met
join metstuprog
on  met.mitroo = metstuprog.mitroo 
where metstuprog.progcode = 1 and (dateanag  is null or dateanag>='01-Sep-'||@string(:1,0)) and metstuprog.mitroo not in (select mitroo from metdiakop where dateapo <'01-Sep-'||@string(:1,0) and dateeos is null and progcode = 1)
and metstuprog.ak <=:1
group by 2,3 order by 2,3;

;=================================================================================================================================================================
;4. ������� ������������� ��������� ��� ��������� ������������ ���� ���� ����, ������ ��� ������� �������
;=================================================================================================================================================================


