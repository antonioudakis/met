create table metteach (mitroo varchar(8) not null, progcode integer not null, k_m integer not null, 
                                 ej varchar(2) not null, ak integer not null, ergo varchar(2),
primary key (mitroo,progcode,k_m,ej,ak));
create unique index metteach_idx on metteach (mitroo,progcode,k_m,ej,ak);
