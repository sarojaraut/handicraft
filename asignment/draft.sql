-- Shared Components

declare 
    l_order_id        my_order.id%type; 
begin
    if :p8_id is null then
        insert into  my_order(
            table_number
            ,customer_name
            ,customer_address
            ,status_id
        )
        values(
            :p8_table_number
            ,:p8_customer_name
            ,:p8_customer_address
            ,1 -- default status new
        )
        returning id into :p8_id;
    else 
        insert into  my_order_item(
            order_id
            ,item_id
            ,quantity
        )
        values(
            :p8_id
            ,:p8_item_id
            ,:p8_quantity
        )
        returning id into :p8_id;
    end if;


end;

create table my_order_item(
    id                  number          generated by default on null as identity(start with 1 nocache)
    ,order_id           number(10)
    ,item_id            number(4)
    ,quantity           number(2)


select distinct item_category d, item_category r from my_item;

select item_name, id from my_item where item_category = :P8_ITEM_CATEGORY

select distinct description d, id r from my_order_status;

Create a Wizard 
First form will be on the order table 
second form will be on order item table



----- Sql Scripts
create table my_order_status(
    id                  number(2)          generated by default on null as identity(start with 1 nocache)
    ,status             varchar2(30)
    ,description        varchar2(4000)
    ,created            timestamp
    ,created_by         varchar2(62)
    ,updated            timestamp
    ,updated_by         varchar2(62)
);

alter table my_order_status
add constraint pk_my_order_status
primary key (id);

alter table my_order_status
add constraint uk_my_order_status1
unique(status);

comment on table my_order_status is
'contains alllowable order statuses';

comment on column my_order_status.id          is 'This is a sequence generated primary key';
comment on column my_order_status.description is 'Overall description of the status';
comment on column my_order_status.created     is 'Datetimestamp when status is created';
comment on column my_order_status.created_by  is 'Username who created the order status';
comment on column my_order_status.updated     is 'Datetimestamp when order status is last updated';
comment on column my_order_status.updated_by  is 'Username who updated the order status';

insert into my_order_status(status, description)
values ('NEW', 'New');

insert into my_order_status(status, description)
values ('BEP', 'Being Prepared');

insert into my_order_status(status, description)
values ('DEL', 'Delivered/Served');

insert into my_order_status(status, description)
values ('CAN', 'Cancelled');

insert into my_order_status(status, description)
values ('COM', 'Completed');

create table my_item(
    id                  number(2)          generated by default on null as identity(start with 1 nocache)
    ,item_category      varchar2(64)
    ,item_name          varchar2(128)
    ,item_price         number(4,2)
    ,description        varchar2(4000)
    ,created            timestamp
    ,created_by         varchar2(62)
    ,updated            timestamp
    ,updated_by         varchar2(62)
);

alter table my_item
add constraint pk_my_item
primary key (id);

alter table my_item
add constraint uk_my_item1
unique(item_category,item_name);

comment on table my_item is
'All items';

comment on column my_item.id             is 'This is a sequence generated primary key';
comment on column my_item.item_category  is 'Item category';
comment on column my_item.item_name      is 'Item name';
comment on column my_item.item_price     is 'Item price in GBP';
comment on column my_item.created        is 'Datetimestamp when item is created';
comment on column my_item.created_by     is 'Username who created the item';
comment on column my_item.updated        is 'Datetimestamp when item is last updated';
comment on column my_item.updated_by     is 'Username who updated the item';


set define off;
insert into my_item(item_category, item_name, item_price) values('Starter','BBQ Spare Ribs','6.60');
insert into my_item(item_category, item_name, item_price) values('Starter','Capital Spare Ribs','6.60');
insert into my_item(item_category, item_name, item_price) values('Starter','Salt & Pepper Chips','3.80');
insert into my_item(item_category, item_name, item_price) values('Starter','Salt & Pepper Calamari','7.20');
insert into my_item(item_category, item_name, item_price) values('Starter','Salt & Pepper King Prawns','8.00');
insert into my_item(item_category, item_name, item_price) values('Starter','Salt & Pepper Chicken Wings','6.60');
-- insert into my_item(item_category, item_name, item_price) values('Starter','Salt & Pepper Chicken Wings','6.60');
insert into my_item(item_category, item_name, item_price) values('Starter','Salt & Pepper Chicken','6.60');
insert into my_item(item_category, item_name, item_price) values('Starter','Pancake Wrapped Chicken','7.80');
insert into my_item(item_category, item_name, item_price) values('Starter','Pancake Wrapped Pork','7.80');
insert into my_item(item_category, item_name, item_price) values('Starter','Pancake Wrapped King Prawns','8.20');
insert into my_item(item_category, item_name, item_price) values('Starter','Pancake Wrapped Mixed Vegetables','7.00');
insert into my_item(item_category, item_name, item_price) values('Starter','Sesame Prawn Toast','7.80');
insert into my_item(item_category, item_name, item_price) values('Starter','Satay Chicken on Skewers (5)','6.60');
insert into my_item(item_category, item_name, item_price) values('Starter','Smoked Chicken','6.60');
insert into my_item(item_category, item_name, item_price) values('Starter','Crispy Seaweed','4.50');
insert into my_item(item_category, item_name, item_price) values('Starter','Meat Spring Rolls (2)','4.00');
insert into my_item(item_category, item_name, item_price) values('Starter','Vegetable Spring Rolls (5)','4.00');
insert into my_item(item_category, item_name, item_price) values('Starter','Grilled Meat Dumplings (5)','6.00');
insert into my_item(item_category, item_name, item_price) values('Starter','Thai Fish Cakes','6.60');
insert into my_item(item_category, item_name, item_price) values('Starter','Prawn Crackers','2.30');
insert into my_item(item_category, item_name, item_price) values('Sweet & Sour','Chicken, Beef and Pork Sweet and Sour','7.80');
insert into my_item(item_category, item_name, item_price) values('Sweet & Sour','Chicken Sweet and Sour','7.50');
insert into my_item(item_category, item_name, item_price) values('Sweet & Sour','Beef Sweet and Sour','7.50');
insert into my_item(item_category, item_name, item_price) values('Sweet & Sour','Roasted Pork Sweet and Sour','7.50');
insert into my_item(item_category, item_name, item_price) values('Sweet & Sour','Duck Fillet Sweet and Sour','8.20');
insert into my_item(item_category, item_name, item_price) values('Sweet & Sour','King Prawn Sweet and Sour','8.20');
insert into my_item(item_category, item_name, item_price) values('Sweet & Sour','Tofu Sweet and Sour','5.40');
insert into my_item(item_category, item_name, item_price) values('Sweet & Sour','Quorn Sweet and Sour','7.00');
insert into my_item(item_category, item_name, item_price) values('Stir Fry','Stir Fry with Cashew Nuts','5.40');
insert into my_item(item_category, item_name, item_price) values('Oyster Sauce Dishes','Mushrooms in Oyster Sauce','5.40');
insert into my_item(item_category, item_name, item_price) values('Oyster Sauce Dishes','Bok Choi in Oyster Sauce','5.40');
insert into my_item(item_category, item_name, item_price) values('Oyster Sauce Dishes','Bok Choi & Mangetout','5.40');
insert into my_item(item_category, item_name, item_price) values('Soup','Chicken & Sweetcorn Soup','4.00');
insert into my_item(item_category, item_name, item_price) values('Soup','Hot & Sour Soup','4.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','Pawpaw Special Chow Mein','7.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','Chicken Chow Mein','6.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','Beef Chow Mein','6.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','Pork Chow Mein','6.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','King Prawn Chow Mein','7.60');
insert into my_item(item_category, item_name, item_price) values('Noodles','Mushroom Chow Mein','5.30');
insert into my_item(item_category, item_name, item_price) values('Noodles','Mixed Vegetable Chow Mein','5.30');
insert into my_item(item_category, item_name, item_price) values('Noodles','Plain Chow Mein','4.20');
insert into my_item(item_category, item_name, item_price) values('Noodles','Singapore Noodles','7.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','Vegetarian Singapore Noodles','6.80');
insert into my_item(item_category, item_name, item_price) values('Noodles','Pad Thai Noodles with Chicken','7.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','Pad Thai Noodles with Pork','7.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','Pad Thai Noodles with Beef','7.00');
insert into my_item(item_category, item_name, item_price) values('Noodles','Pad Thai Noodles with King Prawns','7.80');
insert into my_item(item_category, item_name, item_price) values('Noodles','Pad Thai Noodles with Vegetables','6.80');
insert into my_item(item_category, item_name, item_price) values('Curry','Chinese Curry - with with rice or chips','6.30');
insert into my_item(item_category, item_name, item_price) values('Curry','Thai Green Curry - with Rice or Chips','6.90');
insert into my_item(item_category, item_name, item_price) values('Curry','Thai Red Curry - with Rice or Chips','6.90');
insert into my_item(item_category, item_name, item_price) values('Rice','Steamed Rice','3.30');
insert into my_item(item_category, item_name, item_price) values('Rice','Egg Fried Rice','3.60');
insert into my_item(item_category, item_name, item_price) values('Rice','Special Fried Rice','5.90');
insert into my_item(item_category, item_name, item_price) values('Rice','Chicken Fried Rice','5.90');
insert into my_item(item_category, item_name, item_price) values('Rice','Roast Pork Fried Rice','5.90');
insert into my_item(item_category, item_name, item_price) values('Rice','Singapore Fried Rice','5.90');
insert into my_item(item_category, item_name, item_price) values('Rice','King Prawn Fried Rice','7.50');
insert into my_item(item_category, item_name, item_price) values('Rice','Mushroom Fried Rice','5.40');
insert into my_item(item_category, item_name, item_price) values('Rice','Mixed Vegetable Fried Rice','5.40');
insert into my_item(item_category, item_name, item_price) values('Vegetables','Stir Fry Mushrooms','4.30');
insert into my_item(item_category, item_name, item_price) values('Vegetables','Stir Fry Beansprouts','4.30');
insert into my_item(item_category, item_name, item_price) values('Vegetables','Stir Fry Broccoli, Ginger & Garlic','4.30');
insert into my_item(item_category, item_name, item_price) values('Vegetables','Stir Fry Bok Choi, Ginger & Garlic','5.90');
insert into my_item(item_category, item_name, item_price) values('Vegetables','Stir Fry Bok Choi with Oyster Sauce','5.90');
insert into my_item(item_category, item_name, item_price) values('Vegetables','Stir Fry Mixed Vegetables','4.30');
insert into my_item(item_category, item_name, item_price) values('Sides','Chips','2.40');
insert into my_item(item_category, item_name, item_price) values('Sides','Curry Sauce','2.00');
insert into my_item(item_category, item_name, item_price) values('Sides','Sweet & Sour Sauce','2.00');
insert into my_item(item_category, item_name, item_price) values('Sides','BBQ Sauce','2.00');
insert into my_item(item_category, item_name, item_price) values('Sides','Sweet Chilli Sauce','1.80');
insert into my_item(item_category, item_name, item_price) values('Sides','Satay Sauce','1.80');
insert into my_item(item_category, item_name, item_price) values('Wine','The Guv''''nor House Red 750ml ABV 14%','11.80');
insert into my_item(item_category, item_name, item_price) values('Wine','Silver Ghost House White 750ml ABV 12%','11.80');
insert into my_item(item_category, item_name, item_price) values('Wine','Villa Vito Pinot Grigio 750ml ABV 12%','13.00');
insert into my_item(item_category, item_name, item_price) values('Beer','Tiger Beer 330ml ABV 4.8%','3.30');
insert into my_item(item_category, item_name, item_price) values('Beer','Tsingtao Beer 330ml ABV 4.7%','3.30');
insert into my_item(item_category, item_name, item_price) values('Soft Drinks','Coca Cola - 330ml','1.40');
insert into my_item(item_category, item_name, item_price) values('Soft Drinks','Diet Coke - 330ml','1.40');
insert into my_item(item_category, item_name, item_price) values('Soft Drinks','Fanta Orange - 330ml','1.40');
insert into my_item(item_category, item_name, item_price) values('Soft Drinks','Sprite - 330ml','1.40');

create table my_order(
    id                  number(10)          generated by default on null as identity(start with 10000000 nocache)
    ,table_number       number(4)
    ,customer_name      varchar2(128)
    ,customer_address   varchar2(256)
    ,status_id          number(2)
    ,created            timestamp
    ,created_by         varchar2(62)
    ,updated            timestamp
    ,updated_by         varchar2(62)
);

alter table my_order
add constraint pk_my_order
primary key (id);

alter table my_order
add constraint fk_my_order1
foreign key (status_id) references my_order_status(id);

comment on table my_order is
'All orders and customer details';

comment on column my_order.id           is 'This is a sequence generated order number (eight digit)';
comment on column my_order.table_number is 'Table number of the resturant, ideally to be denormalised to separate table';
comment on column my_order.table_number is 'customer name, deally to be denormalised to separate table';
comment on column my_order.table_number is 'customer address, ideally to be denormalised to separate table';
comment on column my_order.created      is 'Datetimestamp when order is created';
comment on column my_order.created_by   is 'Username who created the order';
comment on column my_order.updated      is 'Datetimestamp when order is last updated';
comment on column my_order.updated_by   is 'Username who updated the order';

create table my_order_item(
    id                  number          generated by default on null as identity(start with 1 nocache)
    ,order_id           number(10)
    ,item_id            number(4)
    ,quantity           number(2)
    ,created            timestamp
    ,created_by         varchar2(62)
    ,updated            timestamp
    ,updated_by         varchar2(62)
);

alter table my_order_item
add constraint pk_my_order_item
primary key (id);

alter table my_order_item
add constraint uk_my_order_item1
unique (order_id, item_id);

alter table my_order_item
add constraint fk_my_order_item1
foreign key (order_id) references my_order(id);

alter table my_order_item
add constraint fk_my_order_item2
foreign key (item_id) references my_item(id);

comment on table my_order_item is
'Line items of orders';

comment on column my_order_item.id            is 'This is a sequence generated number';
comment on column my_order_item.order_id      is 'Order id of the order';
comment on column my_order_item.item_id       is 'item ID from item table';
comment on column my_order_item.quantity      is 'Quantity';
comment on column my_order_item.created       is 'Datetimestamp when event is created';
comment on column my_order_item.created_by    is 'Username who created the event';
comment on column my_order_item.updated       is 'Datetimestamp when order is last updated';
comment on column my_order_item.updated_by    is 'Username who updated the order';

create table my_order_event(
    id                  number          generated by default on null as identity(start with 10000000 nocache)
    ,order_id           number(10)
    ,old_status_id      number(2)
    ,new_status_id      number(2)
    ,created            timestamp
    ,created_by         varchar2(62)
);

alter table my_order_event
add constraint pk_my_order_event
primary key (id);

alter table my_order_event
add constraint uk_my_order_event1
unique (order_id, old_status_id, new_status_id);

alter table my_order_event
add constraint fk_my_order_event1
foreign key (order_id) references my_order(id);

comment on table my_order is
'Order status change events';

comment on column my_order_event.id            is 'This is a sequence generated number';
comment on column my_order_event.order_id      is 'Order id of the order';
comment on column my_order_event.old_status_id is 'Old status';
comment on column my_order_event.new_status_id is 'New status';
comment on column my_order_event.created       is 'Datetimestamp when event is created';
comment on column my_order_event.created_by    is 'Username who created the event';


create or replace trigger trg_my_order_bu
before insert or update on my_order
for each row
declare
begin
    if inserting then
        :new.created    := systimestamp;
        :new.created_by := coalesce(
                            sys_context('APEX$SESSION','app_user')
                            ,regexp_substr(sys_context('userenv','client_identifier'),'^[^:]*')
                            ,sys_context('userenv','session_user')
                        );
    elsif updating then
        :new.updated    := systimestamp;
        :new.updated_by := coalesce(
                            sys_context('APEX$SESSION','app_user')
                            ,regexp_substr(sys_context('userenv','client_identifier'),'^[^:]*')
                            ,sys_context('userenv','session_user')
                        );
        if coalesce(:new.status_id,0) != coalesce(:old.status_id,0) then
            insert into my_order_event(
                order_id
                ,old_status_id
                ,new_status_id
                ,created
                ,created_by
            )
            values(
                :new.id
                ,:old.status_id
                ,:new.status_id
                ,coalesce(
                            sys_context('APEX$SESSION','app_user')
                            ,regexp_substr(sys_context('userenv','client_identifier'),'^[^:]*')
                            ,sys_context('userenv','session_user')
                        )
                ,systimestamp
            );
        end if;
    end if;
end;
/