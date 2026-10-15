-- create table users (
--     user_id bigint primary key,
--     name varchar(100) not null,
--     gender enum('M','F','U') not null default 'u',
--     birth_date date,
--     city varchar(50),
--     member_level tinyint not null default 1,
--     created_at datetime not null,
--     updated_at datetime not null
-- );

-- create table categories(
--     category_id bigint primary key,
--     name varchar(100) not null,
--     parent_id bigint null,
--     constraint fk_cat_parent foreign key (parent_id) references categories(category_id)
-- );

-- create table items(
--     item_id bigint primary key,
--     category_id bigint not null,
--     name varchar(200) not null,
--     price decimal(10,2) not null,
--     created_at datetime not null,
--     constraint fk_item_cat foreign key (category_id) references categories(category_id)
-- );

-- create table orders(
--     order_id bigint primary key,
--     user_id bigint not null,
--     status enum('created','paid','shipped','completed','cancelled') not null,
--     total_amount decimal(12,2) not null,
--     created_at datetime not null,
--     paid_at datetime null,
--     updated_at datetime not null,
--     constraint fk_order_user foreign key (user_id) references users (user_id)
-- );

-- create table order_items(
--     order_id bigint not null,
--     item_id bigint not null,
--     quantity int not null,
--     unit_price decimal(10,2) not null,
--     primary key (order_id, item_id),
--     constraint fk_oi_order foreign key (order_id) references orders (order_id),
--     constraint fk_oi_item foreign key (item_id) references items (item_id),
--     constraint chk_oi_qty check (quantity > 0)
-- );


