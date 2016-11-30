alter table metprogram add tel varchar(40);
update metprogram set tel = (select tel from mettmima where mettmima.tmimacode=metprogram.tmimacode );
alter table metprogram add fax varchar(15);
update metprogram set fax = (select fax from mettmima where mettmima.tmimacode=metprogram.tmimacode );
