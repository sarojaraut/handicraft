-- Add Item
begin
  if not apex_collection.collection_exists('ORDER_ITEMS') then 
    apex_collection.create_collection('ORDER_ITEMS');
  end if;
  apex_collection.add_member(
    p_collection_name => 'ORDER_ITEMS',
    p_n001 =>  :PX_ITEM_NO
    p_n002 =>  :PX_ITEM_QTY 
  );
end;

--Place Order
declare
  l_order_no    orders.order_no%type;
begin
-- insert into order
insert into orders(

)
values(

)
returning order_no into l_order_no;

-- insert into order item
insert into order_items(

)
-- Note the difference argument name in apex_collection.add_member is p_n001 but column name 
-- in select query is n001(without p_)
select
    l_order_no
    ,n001  -- Item Number
    ,n002  -- Quantity
from apex_collections
where collection_name = 'ORDER_ITEMS';

-- truncate collection so that next order makes a fresh start
  apex_collection.truncate_collection (
    p_collection_name => :ORDER_ITEMS );

end;

Adding a button to the report
define column name as link with
link text : <span class="t-Icon fa fa-plus-circle" aria-hidden="true"></span>
link attribute : id='#ITEM_NO#' class="add t-Button t-Button--success t-Button--small" title="Add Item: #ITEM_NAME#"

this sets id value to the report column name that needs to be used in the dynamic action 
create dynamic action on event= click , selection type = jquery selector, jquery selector=a.add add is the class name we have added to the link attribute class

true action set value this.triggeringElement.id to PX_ITEM_NO
then add another tru action to use that field value in the plsql process. make sure to use the page item to submit and return appropriately

Begin
    APEX_COLLECTION.DELETE_MEMBER(
        p_collection_name => 'ORDER_ITEMS',
        p_seq => '2');
End;

apex_collection.add_member(
    p_collection_name => :P3_NAME,
    p_c001            => :P3_ATTR1,
    p_c002            => :P3_ATTR2,
    p_c003            => :P3_ATTR3,
    p_c004            => :P3_ATTR4,
    p_c005            => :P3_ATTR5,
    p_n001            => :P3_NUM_ATTR1,
    p_n002            => :P3_NUM_ATTR2,
    p_n003            => :P3_NUM_ATTR3,
    p_d001            => to_date(:P3_DATE_ATTR1),
    p_d002            => to_date(:P3_DATE_ATTR2),
    p_d003            => to_date(:P3_DATE_ATTR3),
    p_generate_md5    => 'YES' );
commit;


Begin
    APEX_COLLECTION.DELETE_MEMBER(
        p_collection_name => 'EMPLOYEES',
        p_seq => '2');
End;

select
    c001,
    c002,
    c003,
    c004,
    c005
from apex_collections
where collection_name = 'DATA_COLLECTION';



-- And finally I want to check if I get the same results inside my SQL Developer:

-- Set up APEX SESSION
declare
  v_ws_id number;
  v_app_id number := &app_id;
  v_session_id number := &session_id;
begin
  select workspace_id into v_ws_id from apex_workspaces;
  wwv_flow_api.set_security_group_id(v_ws_id);
  wwv_flow.g_flow_id := v_app_id;
  wwv_flow.g_instance := v_session_id;
end;
/

-- Execute SQL
select *
from apex_collections
where collection_name = 'DATA_COLLECTION';


Dynamic Actions example

-- creating a button on a report
Adding a button to the report
define column name as link with
link text : <span class="t-Icon fa fa-plus-circle" aria-hidden="true"></span>
link attribute : id='#ITEM_NO#' class="add t-Button t-Button--success t-Button--small" title="Add Item: #ITEM_NAME#"

this sets id value to the report column name that needs to be used in the dynamic action 
create dynamic action on event= click , selection type = jquery selector, jquery selector=a.add add is the class name we have added to the link attribute class

true action set value this.triggeringElement.id to PX_ITEM_NO
then add another tru action to use that field value in the plsql process. make sure to use the page item to submit and return appropriately

-- dynamic action add class if name field is null

create dynamic action on loose focus to add class as validation_error with client side condition as item is null

dynamic action on event=get focus, selection type=region, true action = add class, classname=showfocus
by adding this dynamic action this will be applicable to all items on that region 

