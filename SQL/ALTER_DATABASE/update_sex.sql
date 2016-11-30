select onoma from met where sex is null group by onoma order by onoma;

update met set sex = 1 where onoma like '%ΟΣ' and sex is null;
update met set sex = 1 where onoma like '%ΟΣ %' and sex is null;
update met set sex = 1 where onoma like '%ΑΣ' and sex is null;
update met set sex = 1 where onoma like '%ΗΣ' and sex is null;
update met set sex = 2 where onoma like '%Η' and sex is null;
update met set sex = 2 where onoma like '%Α' and sex is null;

update met set sex = 1 where onoma like 'ΘΕΡΑΠΩΝ%' and sex is null;

select count(*) from met where sex is null;



