select date_format(paid_at, '%Y-%m') as pay_month, 
       sum(total_amount) as gmv
from orders
where paid_at is not null
      and status <> 'cancelled'
group by date_format(paid_at, '%Y-%m')
order by pay_month;