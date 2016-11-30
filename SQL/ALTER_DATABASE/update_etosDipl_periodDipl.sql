update metstuprog set etosDipl = @year(dateanag)+1900
            where dateanag is not null and etosDipl is null;

update metstuprog set periodDipl=@if(@abs(@month(dateanag)-5)-(@month(dateanag)-5),'1', @if(@abs(@month(dateanag)-9)-(@month(dateanag)-9),'2','3')) 
            where dateanag is not null and periodDipl is null;

update metanathesi set season = @if(@abs(@month(dateejet) -5)-(@month(dateejet) -5),'1', @if(@abs(@month(dateejet) -9)-(@month(dateejet) -9),'2','3')) where dateejet is not null and season is null;

