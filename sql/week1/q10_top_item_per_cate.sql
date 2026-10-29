with item_qty as(
    select pc.category_id as top_category_id,
           oi.item_id,
           sum(oi.quantity) as qty
    from order_items oi 
    join orders o on oi.order_id = o.order_id
    join items i on oi.item_id = i.item_id
    join categories sc on sc.category_id = i.category_id
    join categories pc on pc.category_id = sc.parent_id
    where o.status <> 'cancelled'
    group by pc.category_id, oi.item_id
) 
select top_category_id, item_id, qty, rn 
from (
    select item_qty.*,
        row_number() over(partition by top_category_id order by qty desc, item_id) as rn
    from item_qty
) ranked
where rn <= 3
order by top_category_id, rn;