select aa,ar_prot,upload,ent_ada from entalma where ent_ada is null;

select aa,ar_prot,upload,ent_ada from entalma where ar_prot =  '�21-'||:1||'/2011';

update entalma  set ent_ada = ent_ada||'�' where  ar_prot =  '�21-'||:1||'/2011';

select aa,ar_prot,upload,ent_ada from entalma where ar_prot =  '�01-'||:1||'/2011';

update entalma  set ent_ada = ent_ada||'�' where  ar_prot =  '�0  1-'||:1||'/2011';

select useaa,globserie,globcnt,dvgada from anpaymnt where useaa = 83 and globserie = '�21' and globcnt =:1;

update anpaymnt set dvgada = dvgada||'�' where  useaa = 83 and globserie = '�21' and globcnt =:1;

;
����� ������ ANDVGBUDGET

regnum		������� �����������
issuedate		���������� �������
emailaddr		Email
orgid		������
subject		����
typeid		����� ������
totalvalue		���� �� �.�.�
iecode		������� �.�.�
fisyear		���������� ����
dvgbdgcat	��������� ������������� (0 - null, 1 - �������������� �������, 2 - ������� ��������������)
orgunitid		������
signerid		������� ���������
sectionid		�������� �������
filename		������ pdf
relatedada	����������� ���
;

select status, regnum,ada from andvgbudget where ada is null;
select status, regnum,issuedate,emailaddr,orgid,subject,typeid,totalvalue,iecode,fisyear,dvgbdgcat,orgunitid,signerid,sectionid,filename,relatedada from andvgbudget;
