select * from metstuprog where dateanag is null and ((etosdipl is not null) or (perioddipl is not null));

select * from metstuprog where dateanag is not null and ((etosdipl is null) or (perioddipl is null));

