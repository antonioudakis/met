create table metkrisi (mitroo varchar(8) not null, progcode integer not null, tmimacode integer not null, datekrisi date not null, xarakthrism varchar(1) not null, 
dateaitisi date,sxolia varchar(250), 
primary key (mitroo,progcode,tmimacode,datekrisi));

create unique index metkrisi_idx on metkrisi (mitroo,progcode,tmimacode,datekrisi);

create table metkrisidep (mitroo varchar(8) not null,am_dep integer not null,progcode integer not null, tmimacode integer not null, 
primary key (mitroo, am_dep, progcode, tmimacode));

create unique index metkrisidep_idx on metkrisidep(mitroo, am_dep, progcode, tmimacode);

