insert into pltab (plcolumn,plcode,pllang,pltext) values ('OFEILES',1,'G','4 ΜΕΤ/ΚΑ ΜΑΘ/ΤΑ');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('OFEILES',2,'G','6 ΜΕΤ/ΚΑ ΜΑΘ/ΤΑ');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('OFEILES',3,'G','6 ΜΕΤ/ΚΑ + 4 ΠΡΟΠ/ΚΑ ΜΑΘ/ΤΑ');

alter table met add OFEILES varchar(10);
alter table met_web add OFEILES varchar(10);

delete from pltab where plcolumn = 'MHXANIK' and plcode = 3;
delete from pltab where plcolumn = 'MHXANIK' and plcode = 4;
delete from pltab where plcolumn = 'MHXANIK' and plcode = 5;
