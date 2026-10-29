with per_order as(
    select order_id, count(*) as distinct_items, sum(quantity) as total_qty  
    from order_items 
    group by order_id
)
select round(avg(distinct_items), 2) as avg_distinct_items,
       round(avg(total_qty)) as avg_quantity
from per_order; 