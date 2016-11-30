select * from metprogram;

select met.mitroo,'^',met.epvn,'^',met.onoma,'^',met.email,'^',metstuprog.dateanag from metstuprog inner join met on metstuprog.mitroo = met.mitroo where metstuprog.progcode = 3 and dateanag is not null order by metstuprog.dateanag desc, met.epvn,met.onoma;
