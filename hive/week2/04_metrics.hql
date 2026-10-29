select dt, count(distinct user_id) as dau
from ecom.dwd_user_behavior
group by dt
order by dt;

select dt, count(distinct case when behavior = 'pv' then user_id end) as view_users,
           count(distinct case when behavior = 'cart' then user_id end) as cart_users,
           count(distinct case when behavior = 'buy' then user_id end) as buy_users,
           round(100 * count(distinct case when behavior = 'buy' then user_id end) / count(distinct case when behavior = 'pv' then user_id end), 1) as view_to_buy_pct
from ecom.dwd_user_behavior
group  by dt 
order by dt;

select category_id, count(*) as buys 
from ecom.dwd_user_behavior
where behavior = 'buy'
group by category_id
order by buys desc, category_id
limit 10;


select hour(event_time) as hour_bj,
       count(*) as events,
       round (100 * count(*) / sum(count(*)) over(), 1) as pct
from ecom.dwd_user_behavior
group by hour(event_time)
order by hour_bj;