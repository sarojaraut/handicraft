BEGIN
    -- Foorce tot take another working copy
    :P6_DTL_FEED_ID := NULL;
END;

SELECT 
    wisl.storeid                                   store_id,
    (
        SELECT sl.location_id
        FROM   store_location  sl
        WHERE  sl.storeid = wisl.storeid
    )                                              old_location_ID,
    wisl.location_id                               new_location_ID,
    (
        SELECT sl.tote_label_required
        FROM   store_location  sl
        WHERE  sl.storeid = wisl.storeid
    )                                              old_tote_label_required,
    wisl.tote_label_required                       new_tote_label_required,
    wisl.ii_error_dtl,
    wisl.ii_dtl_feed_id,
    wisl.ii_source,
    wisl.ii_processed_appl_dt
FROM w_ii_store_location wisl
WHERE wisl.ii_dtl_feed_id = :P6_DTL_FEED_ID


begin  
     case :APEX$ROW_STATUS 
     when 'C' then  
         insert into w_ii_store_location(
            storeid, 
            location_id, 
            tote_label_required,
            ii_processed_sys_dtm)  
         values( 
             :storeid, 
             :location_id, 
             :tote_label_required,
             sysdate)  
         returning rowid into :rowid;  
     when 'U' then  
         update w_ii_store_location  
            set storeid  = :storeid,  
                location_id = :location_id,
                tote_label_required = :tote_label_required,
                ii_processed_sys_dtm = sysdate
          where rowid  = :ROWID;  
     when 'D' then  
         delete w_ii_store_location  
         where rowid = :ROWID;  
     end case;  
     insert into temp values(seq1.nextval);
end;


https://community.oracle.com/thread/3937159

SELECT 
    "ROWID", 
    "STOREID",
    "LOCATION_ID",
    "CREATED_DTM",
    "TOTE_LABEL_REQUIRED"
FROM "#OWNER#"."STORE_LOCATION" 



-- Block to populate working copy
DECLARE
    L_feed_id     w_ii_store_location.ii_dtl_feed_id%TYPE;
    L_ii_source   w_ii_store_location.ii_source%TYPE;
BEGIN

    L_feed_id   := ii_feed_id_seq.NEXTVAL;
    L_ii_source := SUBSTR(:APP_USER ||':'|| :APP_SESSION,1,32);

    :P8_DTL_FEED_ID := L_feed_id;
    APEX_UTIL.SET_SESSION_STATE('P8_DTL_FEED_ID', L_feed_id);
    
    :P8_II_SOURCE := L_ii_source;
    APEX_UTIL.SET_SESSION_STATE('P8_DTL_FEED_ID', L_ii_source);
    
    --Purge Data older than 24 hours from working table
    DELETE FROM w_ii_store_location 
    WHERE ii_processed_sys_dtm < SYSDATE - 1;
    --Create working copy of the data for the session
    INSERT INTO w_ii_store_location(
        storeid,
        location_id,
        tote_label_required,
        ii_master_feed_id,
        ii_dtl_feed_id,
        ii_processed_appl_dt,
        ii_processed_sys_dtm,
        ii_source)
    SELECT
        storeid,
        location_id,
        tote_label_required,
        ii_dtl_feed_id,
        L_feed_id,
        created_dtm,
        SYSDATE,
        L_ii_source
    FROM store_location;
    
END;

-- Query for rendering data grid

SELECT 
    location_id          Old_location_ID,
    location_id          New_Location_ID,
    storeid              Old_store_id,
    storeid              new_store_id,
    tote_label_required  old_tote_label_required,
    tote_label_required  new_tote_label_required,
    ii_error_dtl,
    ii_dtl_feed_id,
    ii_source,
    ii_processed_appl_dt
FROM w_ii_store_location
WHERE ii_dtl_feed_id = :P8_DTL_FEED_ID

DECLARE
    L_err_count NUMBER;
BEGIN
    oms_click_collect.p_load_store_loc(:P8_DTL_FEED_ID);
    
    SELECT COUNT(1)
    INTO L_err_count
    FROM w_ii_store_location
    WHERE ii_dtl_feed_id = :P8_DTL_FEED_ID
        AND ii_error_dtl IS NOT NULL;
    
    IF L_err_count > 0 THEN
        apex_application.g_print_success_message := 
            '<span style="color:GOLD">Error saving changed data, Check Error message column for more details</span>';
    ELSE
        apex_application.g_print_success_message := 
            '<span style="color:WHITE">Changed data saved successfully</span>';
    END IF;    
END;


ORANGE
OrangeRed 

MAROON
LIGHTPINK
HOTPINK

PALEVIOLETRED

VALIDATION

StoreExists

UniqueStoreID

SELECT 1
FROM store_location
WHERE storeid = :P4_STOREID
AND (:P4_ROWID IS NULL 
    OR ROWID <> :P4_ROWID)

UniqueLocationID
SELECT 1
FROM store_location
WHERE location_id = :P4_LOCATION_ID
AND (:P4_ROWID IS NULL 
    OR ROWID <> :P4_ROWID)

------------ Old Code

DECLARE
    l_feed_id  NUMBER;
BEGIN

    l_feed_id := ii_feed_id_seq.NEXTVAL;
    
    :P8_DTL_FEED_ID := l_feed_id;
    APEX_UTIL.SET_SESSION_STATE('P8_DTL_FEED_ID', l_feed_id);

    DELETE FROM w_ii_store_location 
    WHERE ii_processed_appl_dt < sysdate - 1;
    
    INSERT INTO w_ii_store_location(
        storeid,
        location_id,
        tote_label_required,
        ii_master_feed_id,
        ii_dtl_feed_id,
        ii_processed_appl_dt,
        ii_processed_sys_dtm,
        ii_source)
    SELECT
        storeid,
        location_id,
        tote_label_required,
        ii_dtl_feed_id,
        l_feed_id,
        created_dtm,
        sysdate,
        SUBSTR(:app_user ||':'|| :app_session,1,32)
    FROM store_location;
    
END;


DECLARE
    l_feed_id  NUMBER;
BEGIN

    l_feed_id := ii_feed_id_seq.NEXTVAL;
    
    :P8_DTL_FEED_ID := l_feed_id;
    APEX_UTIL.SET_SESSION_STATE('P8_DTL_FEED_ID', l_feed_id);

    DELETE FROM w_ii_store_location 
    WHERE ii_dtl_feed_id = l_feed_id;
    
    INSERT INTO w_ii_store_location(
        storeid,
        location_id,
        tote_label_required,
        ii_dtl_feed_id,
        ii_processed_sys_dtm,
        ii_source)
    SELECT
        storeid,
        location_id,
        tote_label_required,
        l_feed_id,
        created_dtm,
        SUBSTR(:app_user ||':'|| :app_session,1,32)
    FROM store_location;
    
    :P8_ERROR_COUNT := 0;
    APEX_UTIL.SET_SESSION_STATE('P8_ERROR_COUNT', 0);
    
END;

DECLARE
    L_err_count NUMBER;
BEGIN
    oms_click_collect.p_load_store_loc(:app_session);
    
    SELECT COUNT(1)
    INTO L_err_count
    FROM w_ii_store_location
    WHERE ii_error_dtl is not null;
    
    IF L_err_count > 0 THEN
        apex_application.g_print_success_message := 
            '<span style="color:RED">Error saving changed data, Check Error message column for more details</span>';
    ELSE
        DELETE FROM w_ii_store_location 
        WHERE ii_dtl_feed_id = :app_session;
        apex_application.g_print_success_message := 
            '<span style="color:WHITE">Changed data saved successfully</span>';
    END IF;    
END;

ii_feed_id_seq.nextval

declare
    l_feed_id  number;
begin
    l_feed_id := II_FEED_ID_SEQ.NEXTVAL;
    
    :P8_DTL_FEED_ID := l_feed_id;
    
    apex_util.set_session_state('P8_DTL_FEED_ID', l_feed_id);
end;

apex_application.g_print_success_message := '<span style="color:green">Data from ' || :P1_DATE || ' successfully updated</span>';

select distinct ii_dtl_feed_id from w_ii_store_location;

select distinct to_char(ii_processed_sys_dtm,'dd/mm/yyyy hh24:mi:ss') from w_ii_store_location;

FUNCTION ihf_authentication (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2 )
RETURN BOOLEAN
IS
    L_valid_user_ind   s_datatype.ind_var;
    L_valid_appl       BOOLEAN := FALSE;

BEGIN     
    L_valid_appl := oms_user.f_validate_user_bool(p_username,p_password);

RETURN L_valid_appl;

END ihf_authentication;

8375442816596

    apex_error.add_error (
        p_message          => 'Error processing',
        p_display_location => apex_error.c_inline_in_notification );
        

function(config) {
    config.features.flashback = false;
    config.features.filter = false;
    config.initActions = function( actions ) {  
        actions.lookup("chart-view").hide = true;  
    };     
    console.log(config);
    return config;
}

function(config) {
    config.views = {
        chart: false
    };

    // there should already be a built in action for this but currently there isnot
    config.initActions = function(actions) {
        actions.add({
            name: "row-delete",
            labelKey: "Delete Row",
            action: function(event, element) {
                var rec,
                    view = $("#emp_ig").interactiveGrid("getViews","grid"),
                    row$ = $( element ).closest( "tr" );

                rec = view.view$.grid( "getRecords", [ row$ ] );
                view.model.deleteRecords( rec );
            }
        });
    }

    return config;
}

Normally the grid is in navigation mode where arrow keys move from cell to cell. To enter edit mode press the Edit button or double click or press Enter key or F2 key in a cell.
To exit edit mode press the Edit button or press Escape key in a cell.
In edit mode the [Shift] Tab key moves to the previous or next cells. The [Shift] Enter key moves to the same column in the previous or next row.
Edit controls such as radio groups or text areas that don't fit in a cell are displayed in a floating popup. The popup can be moved or collapsed to see the data under it. The Ctrl+F6 key will collapse or expand the floating popup.
Use the Delete key to delete the selected rows. Use the Insert key to add a row.


Vallidation message
#COLUMN_HEADER# must not contain special characters or numbers.

var sal = apex.item("cSal"),
    num = sal.getValue();
if ( num !== "" && (parseFloat(num) != num || num < 0 || num > 10000)) {
    sal.node.setCustomValidity("invalid number"); // this message is only shown if there is no data-valid-message attribute on the column item
} else {
    sal.node.setCustomValidity(""); // clear the error
}

$('#myReport1').trigger('apexrefresh');

This is the new official 5.1 way to refresh a region.
apex.region("regionStaticID").refresh();

To turn edit mode off:
apex.region("emp").widget().interactiveGrid("getActions").set("edit", false);

apex.region("emp").widget().interactiveGrid("getActions").set("edit", true);

create table store_location_temp as select * from store_location;

alter table store_location_temp add constraint location_id_uk unique (location_id) deferrable;

set constraint location_id_uk deferred;

update store_location_temp set location_id='319B' where storeid=104;

update store_location_temp set location_id='321C' where storeid=105

SET CONSTRAINT pk_blick IMMEDIATE;

EXECUTE IMMEDIATE 'set constraint location_id_uk deferred';

EXECUTE IMMEDIATE 'SET CONSTRAINT pk_blick IMMEDIATE';

alter table store_location drop constraint location_id_uk deferred

Enter the pattern used to construct the fully qualified distinguished name (DN) string to DBMS_LDAP.SIMPLE_BIND_S if using exact DN or the search base if using non-exact DN. Use %LDAP_USER% as a placeholder for the username. For example:
Exact DN

cn=%LDAP_USER%,l=amer,dc=yourdomain,dc=com

Base DN: dc=hq,dc=river-island,dc=com

Host : ri-dc01.hq.river-island.com
Port : 389
Distinguished Name (DN) String(Value Required) : cn=%LDAP_USER%,dc=hq,dc=river-island,dc=com
Use Exact Distinguished Name (DN) : Yes


