select count(met.mitroo),sex from met inner join metstuprog on met.mitroo = metstuprog.mitroo where metstuprog.progcode = 1 and (metstuprog.dateanag  is null or metstuprog.dateanag >= '01-OCT-2015') and metstuprog.mitroo not in (select mitroo from metdiakop where metdiakop.mitroo = metstuprog.mitroo and metdiakop.progcode = metstuprog.progcode and dateeos is null) group by sex;

select met.mitroo,'^',epvn,'^',onoma,'^',patr from met inner join metstuprog on met.mitroo = metstuprog.mitroo where progcode = 1 and ak is null;


