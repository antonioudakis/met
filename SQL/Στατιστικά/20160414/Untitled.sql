select met.mitroo,'^',epvn,'^',onoma,'^',h_egr,'^',dateanag,'^',@int((dateanag-h_egr)/365) from met inner join metstuprog on met.mitroo = metstuprog.mitroo where progcode = 1 and dateanag between '01-OCT-'||@STRING(:1-1,0) and '30-SEP-'||:1 order by 11,3,5;

