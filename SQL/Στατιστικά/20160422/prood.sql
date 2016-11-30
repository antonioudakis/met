select met.mitroo,'^',met.epvn,'^',met.onoma,'^',met.patr,'^',metprood.dateprod,'^',@if(@int(xarakthrism)-2,'»≈‘… «','¡—Õ«‘… «'),'^',sxolia 
from met inner join metprood on met.mitroo = metprood.mitroo and metprood.progcode = '1' 
where dateprod between '01-SEP-2014' and '31-AUG-2015' order by dateprod desc,epvn,onoma,patr;
