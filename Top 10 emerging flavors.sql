with cte as(
select trim(PARSENAME(REPLACE(Flavor, ';', '.'), 2)) as cl1,
       trim(PARSENAME(REPLACE(Flavor, ';', '.'), 1)) as cl2,
	   trim(PARSENAME(REPLACE(Flavor, ';', '.'), 3)) as cl3,*
from ['Product Launch Dataset$']
where Region = 'North America'),

cte2 as(
select cl1 as Flavor, year([Launch Date]) as Year
from cte
union all
select cl2, year([Launch Date])
from cte
union all
select cl3, year([Launch Date])
from cte
)

select Top 10 trim(Flavor) as Emerging_Flavors, count(*) as No_of_Flavor,
			  count(case when year = 2006 then Flavor end) as r06,
			  count(case when year = 2007 then Flavor end) as r07,
			  count(case when year = 2008 then Flavor end) as r08,
			  count(case when year = 2009 then Flavor end) as r09,
			  count(case when year = 2010 then Flavor end) as r10
from cte2
where Flavor is not null AND Flavor NOT IN ('Unflavored', 'na') and year > 2005
group by Flavor
order by No_of_Flavor Desc




