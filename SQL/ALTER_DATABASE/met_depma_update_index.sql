drop index metdepma_idx;
create unique index metdepma_idx on metdepma(courcode,ak,am_dep);
