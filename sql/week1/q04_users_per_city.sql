select coalesce(city, 'Unknown') as city, count(*) as users
from users 
group by coalesce(city, 'Unknown')
having count(*) >= 2
order by users desc;