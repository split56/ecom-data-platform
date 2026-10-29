SELECT CASE
         WHEN total_amount < 50  THEN '1: <50'
         WHEN total_amount < 200 THEN '2: 50-199'
         WHEN total_amount < 500 THEN '3: 200-499'
         ELSE                         '4: 500+'
       END               AS band,
       COUNT(*)          AS orders,
       SUM(total_amount) AS gmv
FROM   orders
WHERE  status <> 'cancelled'
GROUP  BY band
ORDER  BY band;