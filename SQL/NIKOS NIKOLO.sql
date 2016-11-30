select k_tm||';'||period||';'||@trim(epvn)||';'||@trim(onoma)||';'||@trim(patr)||';'||birthdate||';'||@trim(pltext)||';'||etosdipl||';'||ardipl from hst_f ,pltab
where etosdipl = 2006 and plcolumn = 'TOPOSG' and plcode = poliorig and pllang = 'G' order by period,epvn,onoma,patr;

Select k_tm||';'||period||';'||@trim(epvn)||';'||@trim(onoma)||';'||@trim(patr)||';'||birthdate||';'||etosdipl||';'||ardipl from hst_f 
where etosdipl = 2006 AND  poliorig IS NULL order by period  ,epvn,onoma,patr;

select k_tm||';'||period||';'||@trim(epvn)||';'||@trim(onoma)||';'||@trim(patr)||';'||@trim(pltext)||';'||perioxi||';'||odos||';'||tt||';'||tel1||';'||tel2 from hst_f ,pltab
where etosdipl = 2006 and plcolumn = 'POLI' and plcode = polikat and pllang = 'G' order by period,epvn,onoma,patr;


