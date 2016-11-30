select 'update metdiakop set dateapo = '||@char(39)||dateapo||@char(39)||' where mitroo = '||@char(39)||mitroo||@char(39)||';' from metdiakop  where dateapo is not null

union 

select 'update metdiakop set dateapo = null'||' where mitroo = '||@char(39)||mitroo||@char(39)||';' from metdiakop  where dateapo is null;




