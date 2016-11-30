select * from metcourse where ak = 2005;
insert  into metcourse (courcode,tmimacode,univcode,tmimacodepar,titlos,period, krg, e_k, maxfoit, vr_upar, vr_apar, vr_epar, prakpar,ak,monades,tomcodepar) select courcode,tmimacode,univcode,tmimacodepar,titlos,period, krg, e_k, maxfoit, vr_upar, vr_apar, vr_epar, prakpar,2008,monades,tomcodepar from metcourse where ak = 2005;
select * from metprospu where ak = 2005;
insert into metprospu (progcode,courcode,period,tmimacode,kat,eidosma,ak) select progcode,courcode,period,tmimacode,kat,eidosma,2008 from metprospu where ak = 2005;





