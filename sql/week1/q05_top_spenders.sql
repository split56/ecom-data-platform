SELECT user_id,
       COUNT(*)                    AS orders,
       SUM(total_amount)           AS total_spent,
       ROUND(AVG(total_amount), 2) AS avg_order_value
FROM   orders
WHERE  status <> 'cancelled'
GROUP  BY user_id
ORDER  BY total_spent DESC