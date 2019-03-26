save me hours of wondering why stuff just does not work. 

select workspace, schemas, to_char(workspace_id) from apex_workspaces;

select id, flow_id, name, filename from wwv_flow_files;

select id, flow_id, name, filename from wwv_flow_files;

exec wwv_flow_api.set_security_group_id('1658378935394435');

create or replace function hex_to_decimal( p_hex_str in varchar2 ) 
return number 
is
    v_dec   number; 
    v_hex   varchar2(16) := '0123456789ABCDEF'; 
begin
    v_dec := 0; 

    for indx in 1 .. length(p_hex_str) 
    loop 
        v_dec := v_dec * 16 + instr(v_hex,upper(substr(p_hex_str,indx,1)))-1; 
    end loop; 

    return v_dec; 

End hex_to_decimal;
/

DECLARE
    v_blob_data       BLOB;
    v_blob_len        NUMBER;
    v_position        NUMBER;
    v_raw_chunk       RAW(10000);
    v_char            CHAR(1);
    c_chunk_len       NUMBER  := 1;
    v_line            VARCHAR2 (32767)  := NULL;
    v_data_array      wwv_flow_global.vc_arr2;
BEGIN
    -- Read data from wwv_flow_files
    select blob_content 
    into v_blob_data
    from wwv_flow_files 
    where name = 'F29800/Data_CSV.csv';

    v_blob_len := dbms_lob.getlength(v_blob_data);
    v_position := 1;

    -- Read and convert binary to char
    WHILE ( v_position <= v_blob_len ) 
    LOOP
        v_raw_chunk := dbms_lob.substr(v_blob_data, c_chunk_len, v_position);
        v_char :=  chr(hex_to_decimal(rawtohex(v_raw_chunk)));
        v_line := v_line || v_char;
        v_position := v_position + c_chunk_len;
        -- When a whole line is retrieved
        IF v_char = CHR(10) THEN
            -- Convert comma to : to use wwv_flow_utilities
            v_line := REPLACE (v_line, ',', ':');
            -- Convert each column separated by : into array of data
            v_data_array := wwv_flow_utilities.string_to_table (v_line);
            -- Insert data into target table
            EXECUTE IMMEDIATE 'insert into TABLE_X (v1, v2, v3, v4)
            values (:1,:2,:3,:4)'
            USING
            v_data_array(1),
            v_data_array(2),
            v_data_array(3),
            v_data_array(4);
            -- Clear out
            v_line := NULL;
        END IF;
    END LOOP;
END;
/

create or replace procedure load_source_data
IS
    v_blob_data       BLOB; 
    v_blob_len        NUMBER; 
    v_position        NUMBER; 
    v_raw_chunk       RAW(10000); 
    v_char            CHAR(1);
    c_chunk_len       number       := 1; 
    v_line            VARCHAR2 (32767)        := NULL; 
    v_data_array      wwv_flow_global.vc_arr2; 
    v_rows            number; 
    v_sr_no           number := 1; 
BEGIN

    delete from w_ii_store_location; 

     -- Read data from wwv_flow_files

    select blob_content into v_blob_data
    from apex_application_temp_files
    where name = V('P2_SOURCE_FILE');

    v_blob_len := dbms_lob.getlength(v_blob_data); 
    v_position := 1; 

     -- Read and convert binary to char</span> 

    WHILE ( v_position <= v_blob_len ) LOOP 

    v_raw_chunk := dbms_lob.substr(v_blob_data,c_chunk_len,v_position); 
    v_char :=  chr(hex_to_decimal(rawtohex(v_raw_chunk))); 

    v_line := v_line || v_char; 
    v_position := v_position + c_chunk_len; 

         -- When a whole line is retrieved </span> 
    IF v_char = CHR(10) THEN
        -- Convert comma to : to use wwv_flow_utilities </span> 
        v_line := REPLACE (v_line, ',', ':'); 
        -- Convert each column separated by : into array of data </span> 
        v_data_array := wwv_flow_utilities.string_to_table (v_line); 
         -- Insert data into target table </span> 
        insert into w_ii_store_location
        (
            storeid,
            location_id,
            ii_master_feed_id,
            tote_label_required
        )
        values(
            v_data_array(1),
            v_data_array(2),
            substr(V('P2_SOURCE_FILE'),1,9),
            v_data_array(4)
        );

        -- Clear out 
        v_line := NULL; 
        v_sr_no := v_sr_no + 1; 

    END IF; 

    END LOOP; 
commit;
END load_source_data;
/


APEX_UTIL.set_session_state(
p_name => 'PX_MY_ITEM'
, p_value => 'wibble');

select *
from apex_application_temp_files
where name = :page item name;

exists
(
    select 1
    from apex_application_temp_files
    where name = :P2_SOURCE_FILE
)

declare
  arr apex_global.vc_arr2;
begin
  arr := apex_util.string_to_table(:P1_MULTIPLE_FILES);
  for i in 1..arr.count loop
    select t.whatever
    into   your_variable
    from   apex_application_temp_files t
    where  t.name = arr(i);
  end loop;
end;

APEX_ADMINISTRATOR_ROLE

beginning in APEX 5.1, also the APEX_ADMINISTRATOR_READ_ROLE).

select *
  from apex_debug_messages
 where page_view_id = NN
 order by message_timestamp asc;
 
where nn is the internal error message displayed to the end user.


They were quite simple and powerful reminders - and important enough that I shared them with our entire development and QA teams.

OWN IT —  Things sometimes go off track.   Whether it was something on your team that went sideways or it was another team's responsibility, step up, own the problem and deliver a resolution.  
LEARN IT —  There are always new technologies, solutions, processes, and procedures.   Set aside time to learn and master what is new so that you are prepared when the time comes.   
TEACH IT — When you master something new, find someone else with whom you can share it.  
GROW IT — Your team is incredibly valuable.   Take the time to invest in your teammates and equip them with new capabilities. 
OVERLOOK IT — People can make poor decisions.   Fight the urge to gossip about them.   Look for the best and ignore the rest. 

It's not about appearing to be good enough, it's about measuring and recording performance. good enough is not enough, what is good enough today is substandard tommorrow. Aspire for excellence

Use the equipments the manner that are designed to be used.
Let's not guess what is going on. let's try to find out what's going on
short term design decissions, appear to work functionally, but works in a highly ennefficient manner.
we need to make our fingers dirty if you want to clean something
it's going to be intense, you are meant to be exhausted
We are missing the top to down holistic view, we are only focusing on one sprint and doing lots of re-work.

Most of the times people say I think this is what is happening : show me 
moving to the solution without understanding the poblem, untill you understand the problem you can't solve it

How many junior people you have trained/mentored to use features properly?
Unfortunately in RI the QA process is more about banner, header, rivision, logging methods, typo in comment section. 
There is always have been reluctance to accept it.



