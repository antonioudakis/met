select metprogram.titlos,'^',met.mitroo,'^',epvn,'^',onoma,'^',email from (met inner join metstuprog on met.mitroo = metstuprog.mitroo) inner join metprogram on metstuprog.progcode = metprogram.progcode 
	where metstuprog.progcode != 1 and metstuprog.ak = :1 order by titlos,epvn,onoma;
