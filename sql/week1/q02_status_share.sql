select status, count(*) as orders, round(100 * count(*) / (select count(*) from orders),1) as pct
from orders
group by status
order by orders desc, status;