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