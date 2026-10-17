select date(created_at) as order_date, count(*) as orders
from orders
group by date(created_at)
order by order_date;