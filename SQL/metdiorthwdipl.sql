drop index metprog_idx;
alter table metprogram drop wdipl;
alter table metprogram add wdipl number;
create unique index metprog_idx on metprogram (tmimacode,progcode);
update statistics on index metprog_idx;

