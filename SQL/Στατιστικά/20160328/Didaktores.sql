select count(*),@int((dateanag-h_egr)/365) from metstuprog where progcode = 1 and dateanag between '01-OCT-'||@STRING(:1-1,0) and '30-SEP-'||:1 group by 2 order by 2;
