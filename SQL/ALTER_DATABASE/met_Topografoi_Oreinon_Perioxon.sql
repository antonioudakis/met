select * from metkatef;

update metkatef set kat = '01' where kat = '00' and progcode = 3;

update metkatef set titlos ='пеяибакком йаи амаптунг' where kat='01' and progcode = 3;

update metprospu set kat = '01' where kat = '00' and progcode = 3;

update metstuprog set kat = '01' where kat = '00' and progcode = 3;

insert into metkatef (kat,titlos,tmimacode,progcode) values ('02','пеяибакком йаи амаптунг ояеимым пеяиовым',6,3);

insert into metcourse (courcode,tmimacode,univcode,tmimacodepar,titlos,period,krg,e_k,maxfoit,vr_upar,vr_apar,vr_epar,prakpar,ak,monades,tomcodepar) select courcode,tmimacode,univcode,tmimacodepar,titlos,period,krg,e_k,maxfoit,vr_upar,vr_apar,vr_epar,prakpar,2009,monades,tomcodepar from metcourse where ak = 2008;

insert into metprospu (progcode,courcode,ak,period,tmimacode,kat,eidosma) select progcode,courcode,2009,period,tmimacode,kat,eidosma from metprospu where ak = 2008;

insert into metdepma (courcode,am_dep,ak) select courcode,am_dep,2009 from metdepma where ak = 2008;

insert into metepiblma (courcode,am_dep,ak) select courcode,am_dep,2009 from metepiblma where ak = 2008;



