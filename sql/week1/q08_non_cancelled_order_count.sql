select u.user_id, count(o.order_id) as orders
from users u 
left join orders o on o.user_id = u.user_id
                   and o.status <> 'cancelled'
group by u.user_id
order by u.user_id