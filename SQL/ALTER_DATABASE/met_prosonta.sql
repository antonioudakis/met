insert into pltab (plcolumn,plcode,pllang,pltext) values ('PROSONTA','1','G','дипкылатоувос');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('PROSONTA','2','G','птувиоувос');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('PROSONTA','3','G','летаптувиайо дипкыла.');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('PROSONTA','4','G','дидайтояийг диатяибг');
insert into pltab (plcolumn,plcode,pllang,pltext) values ('PROSONTA','5','G','коипа пяосомта');

update met set mhxanik = 1 where mhxanik = 3;
delete from pltab where plcolumn ='MHXANIK' and plcode =3;
update pltab set pltext = 'дипкылатоувос' where plcode = 1 and plcolumn ='MHXANIK';

update metptyx set ptyxview = 3 where ptyxview = 2;
update metptyx set ptyxview = 1 where mitroo in (select met.mitroo from met where mhxanik = 1) and metptyx.ptyxview !=3;
update metptyx set ptyxview = 1 where mitroo in (select met.mitroo from met where mhxanik = 1) and metptyx.ptyxview is null;
update metptyx set ptyxview = 2 where mitroo in (select met.mitroo from met where (mhxanik = 2 or mhxanik is null)) and metptyx.ptyxview !=3;
update metptyx set ptyxview = 2 where mitroo in (select met.mitroo from met where (mhxanik = 2 or mhxanik is null)) and metptyx.ptyxview is null;
update metptyx set ptyxview = null where ptyxview = 3;


