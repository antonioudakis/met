select met.mitroo,'^',met.epvn,'^',met.onoma,'^',met.email,'^',metstuprog.etosdipl from met inner join metstuprog on met.mitroo = metstuprog.mitroo where metstuprog.progcode = 1 and metstuprog.etosdipl in (2012,2013,2014) order by metstuprog.etosdipl,epvn,onoma;


