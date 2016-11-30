create table met_kart_disk (tmimacode number not null, ltmimacode varchar(50), courcode number not null, lcourcode varchar(100), progcode number not null, lprogcode varchar(100), lectper varchar(9),
a_a number,mitroo varchar(8) not null, epvn varchar(60), onoma varchar(60), patr varchar(60), 
ak number not null, period varchar(2) , lperiod varchar(100), ejaniki varchar(2), ej varchar(2) not null, 
gradenor number, gradepan number, olgradenor varchar(20),olgradepan varchar(20),
ad number, kat varchar(2), lkat varchar(100), dep varchar(250), dep1 varchar(250), lock number,
primary key (tmimacode,courcode,progcode,mitroo,ak,ej));
create unique index met_kart_disk_idx on met_kart_disk(tmimacode,courcode,progcode,mitroo,ak,ej);

