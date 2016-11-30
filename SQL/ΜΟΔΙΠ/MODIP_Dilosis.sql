select * from metprogram;

select '6'||';'||'2'||';'||progcode||';'||ak||';'||periodaniki||';'||metkartl.courcode||';'||metkartl.mitroo||';'||@TRIM(met.email)||';' from metkartl inner join met on metkartl.mitroo = met.mitroo 
          where ak = 2016 and progcode != 1 and periodaniki in ('02','04') order by progcode,periodaniki,metkartl.courcode;

select distinct met.mitroo||'^'||epvn||'^'||onoma||'^'||metprogram.titlos from (met inner join metkartl on met.mitroo = metkartl.mitroo) inner join metprogram on metkartl.progcode = metprogram.progcode 
          where ak = 2016 and metkartl.progcode !=1 and periodaniki in  ('02','04') and email is null order by metkartl.progcode,periodaniki,metkartl.courcode;

select '6'||';'||'2'||';'||progcode||';'||ak||';'||periodaniki||';'||metkartl.courcode||';'||metkartl.mitroo||';'||@TRIM(met.email)||';' from metkartl inner join met on metkartl.mitroo = met.mitroo 
          where ak = 2016 and progcode != 1 and periodaniki in ('02','04') and email is not null order by progcode,periodaniki,metkartl.courcode;

UPDATE `ww_2016_ear_met04_diloseis` INNER JOIN COURSE ON ww_2016_ear_met04_diloseis.COURCODE = COURSE.CODE SET COURSE_ID = ID WHERE EDUCATION_LEVEL_ID = 2 AND SCHOOL_ID = 4;

SELECT * FROM `ww_2016_ear_met04_diloseis` WHERE COURSE_ID = 0;

insert into students (course_id,email,education_lvl_id) select course_id,email,educ_lvl from ww_2016_ear_met04_diloseis;

insert into `ww_2016_ear_met_diloseis` (tmimacode,educ_lvl,progcode,ak,periodaniki,courcode,mitroo,email,course_id) select tmimacode,educ_lvl,progcode,ak,periodaniki,courcode,mitroo,email,course_id from ww_2016_ear_met04_diloseis;