select * from metprogram;

select distinct metcourse.courcode, metdepma.am_dep from metcourse  left join metdepma on metcourse.courcode = metdepma.courcode and metcourse.ak = metdepma.ak 
	 where metcourse.ak = 2015 order by metcourse.courcode;

select distinct metcourse.courcode, metdepma.am_dep from (metprospu left join metcourse on metprospu.courcode = metcourse.courcode and metprospu.ak = metcourse.ak) left join metdepma on metcourse.courcode = metdepma.courcode and metcourse.ak = metdepma.ak 
	 where metcourse.ak = 2015 order by metcourse.courcode;

select distinct metcourse.courcode, metdepma.am_dep from ((metprospu left join metcourse on metprospu.courcode = metcourse.courcode and metprospu.ak = metcourse.ak) left join metdepma on metcourse.courcode = metdepma.courcode and metcourse.ak = metdepma.ak)
	 left join dep on metdepma.am_dep = dep.am_dep where metcourse.ak = 2015 order by metcourse.courcode;

select distinct metcourse.courcode, metdepma.am_dep from (((metprospu left join metcourse on metprospu.courcode = metcourse.courcode and metprospu.ak = metcourse.ak) left join metdepma on metcourse.courcode = metdepma.courcode and metcourse.ak = metdepma.ak)
	 left join dep on metdepma.am_dep = dep.am_dep) left join pltab on pltab.plcode = dep.level where plcolumn = 'LEVEL' and metcourse.ak = 2015 order by metcourse.courcode;

select distinct metcourse.courcode, metdepma.am_dep from ((((metprospu left join metcourse on metprospu.courcode = metcourse.courcode and metprospu.ak = metcourse.ak) left join metdepma on metcourse.courcode = metdepma.courcode and metcourse.ak = metdepma.ak)
	 left join dep on metdepma.am_dep = dep.am_dep) left join pltab on pltab.plcode = dep.level) inner join metprogram on metprogram.progcode = metprospu.progcode where plcolumn = 'LEVEL' and metcourse.ak = 2015 order by metcourse.courcode;

select distinct metprogram.titlos,dep.epvn,dep.onoma,pltext,metcourse.titlos from ((((metprospu inner join metcourse on metcourse.courcode = metprospu.courcode and metcourse.ak = metprospu.ak) 
          left join metdepma on metprospu.courcode =  metdepma.courcode and metprospu.ak = metdepma.ak) left join dep on dep.am_dep = metdepma.am_dep) inner join metprogram on metprogram.progcode = metprospu.progcode) left join pltab on pltab.plcode = dep.level where 
	  plcolumn = 'LEVEL' and metprospu.ak = 2015 order by 1,metcourse.titlos;

select distinct metprogram.titlos,'^',metcourse.titlos,'^',dep.epvn,'^',dep.onoma,'^',level from (((metprospu inner join metcourse on metcourse.courcode = metprospu.courcode and metcourse.ak = metprospu.ak) 
          left join metdepma on metprospu.courcode =  metdepma.courcode and metprospu.ak = metdepma.ak) left join dep on dep.am_dep = metdepma.am_dep) inner join metprogram on metprogram.progcode = metprospu.progcode where 
	  metprospu.ak = 2015 order by metprogram.titlos,metcourse.titlos,level;