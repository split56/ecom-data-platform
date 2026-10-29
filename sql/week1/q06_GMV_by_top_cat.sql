select c.category_id,
       c.name,
       sum(oi.quantity * oi.unit_price) as gmv
from order_items oi
join orders o on o.order_id = oi.order_id
join items i on i.item_id = oi.item_id
join categories c on c.category_id = oi.category_id
where o.paid_at is not null and o.status <> 'cancelled'
group by c.category_id, c.name
order by gmv desc;
