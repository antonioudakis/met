alter table metwebaitpistop add pistoreplytmp long;
update metwebaitpistop set pistoreplytmp = pistoreply;
alter table metwebaitpistop add aitiotmp long;
update metwebaitpistop set aitiotmp = aitio;
alter table metwebaitpistop drop pistoreply;
alter table metwebaitpistop add pistoreply varchar(254);
alter table metwebaitpistop drop aitio;
alter table metwebaitpistop add aitio varchar(254);

