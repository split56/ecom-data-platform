create table if not exists ecom.dwd_user_behavior (
    user_id bigint,
    item_id bigint,
    category_id bigint,
    behavior string,
    ts bigint,
    event_time timestamp
)
partitioned by (dt string)
stored as orc;

set hive.exec.dynamic.partition.mode = nonstrict;

insert overwrite table ecom.dwd_user_behavior partition (dt)
select user_id, item_id, category_id, behavior, ts, cast(event_time as timestamp), dt
from ecom.ods_user_behavior;

show partitions ecom.dwd_user_behavior