create table metepiblma (courcode integer not null,am_dep integer not null,ak integer not null);
create unique index metepiblma_idx on metepiblma(courcode,am_dep,ak);

