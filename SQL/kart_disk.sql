create table kart_disk (k_tm number not null, ltmhma varchar(50), k_m number not null, lmathima varchar(100), a_a number, k_f varchar(8) not null, epvn varchar(60), 
onoma varchar(60), patr varchar(60),
xu varchar(2) not null, lxu varchar(100), ak number not null, ejaniki varchar(2), period varchar(2) , lperiod varchar(100), gradenor number, gradepan number, olgradenor varchar(20),
olgradepan varchar(20),ej varchar(2),
ad number, kat varchar(2), lkat varchar(100), deltio varchar(2), ldeltio varchar(20), dep varchar(200), veltiosi varchar(1), lock number,
primary key (k_tm,k_m,k_f,ak,xu));
create unique index idx_kart_disk on kart_disk(k_tm,k_m,k_f,ak,xu);

