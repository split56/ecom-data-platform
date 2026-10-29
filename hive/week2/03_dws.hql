create table if not exists ecom.dws_behavior_1d (
    behavior string,
    events bigint, 
    users bigint
)
partitioned by (dt string)
stored as orc;

set hive.exec.dynamic.partition.mode = nonstrict;

insert overwrite table ecom.dws_behavior_1d partition (dt)
select behavior, count(*), count(distinct user_id), dt
from ecom.dwd_user_behavior
group by dt, behavior;
