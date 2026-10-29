create database if not exists ecom;

create external table if not exists ecom.ods_user_behavior(
    user_id bigint,
    item_id bigint,
    category_id bigint,
    behavior string, 
    ts bigint, 
    event_time string, 
    dt string
)

row format delimited fields terminated by ','
stored as textfile
location 'tmp/ecom/ods_user_behavior'
tblproperties ('skip.header.line.count' = '1' );

select count(*) from ecom.ods_user_behavior;
select behavior, count(*) from ecom.ods_user_behavior group by behavior;