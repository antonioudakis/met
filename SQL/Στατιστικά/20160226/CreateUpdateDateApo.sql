select 'update metdiakop set dateapo = '||@char(39)||dateapo||@char(39)||' where mitroo = '||@char(39)||mitroo||@char(39)||' and seqno = '||seqno||';' from metdiakop  where dateapo is not null 

union 

select 'update metdiakop set dateapo = null'||' where mitroo = '||@char(39)||mitroo||@char(39)||' and segno = '||seqno||';' from metdiakop  where dateapo is null;


