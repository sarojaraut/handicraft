update c19_test_scenario ts
set    ts.qualifications = 
    (
    select
        json_object(
            'QUALIFICATIONS' is (
                select
                    json_arrayagg(
                    json_object(
                         'QUALIFICATION'       is qualification
                        ,'SUBJECT'             is nvl(subject,other_qualification)
                    --                ,'OTHER_QUALIFICATION' is other_qualification
                        ,'GRADE'               is grade
                        ,'YEAR'                is year
                        ,'DISTINCTION'         is distinction
                        ,'MERIT'               is merit
                        ,'PASS'                is pass
                        ,'OVERALL'             is overall
                        ,'READING'             is reading
                        ,'WRITING'             is writing
                        ,'SPEAKING'            is speaking
                        ,'LISTENING'           is listening
                        ABSENT ON NULL
                        )
                    ) 
                from c19_test_qualification
                where id= ts.id
            )
        ) 
    from dual
    );


with json_qual as(
select
    id,
    json_object(
        'QUALIFICATIONS' is (
            json_arrayagg(
            json_object(
                 'QUALIFICATION'       is qualification
                ,'SUBJECT'             is nvl(subject,other_qualification)
--                ,'OTHER_QUALIFICATION' is other_qualification
                ,'GRADE'               is grade
                ,'YEAR'                is year
                ,'DISTINCTION'         is distinction
                ,'MERIT'               is merit
                ,'PASS'                is pass
                ,'OVERALL'             is overall
                ,'READING'             is reading
                ,'WRITING'             is writing
                ,'SPEAKING'            is speaking
                ,'LISTENING'           is listening
                ABSENT ON NULL
                )
            )
        )
    ) quals
from c19_test_qualification
group by id
)
select
    j.id,
    j.quals,
    t.qualifications
from json_qual j
join c19_test_scenario t
on (t.id=j.id
and j.quals <> t.qualifications);

CREATE TABLE c19_test_qualification(
    id                    NUMBER,
    qualification         VARCHAR2(256BYTE),
    subject               VARCHAR2(256BYTE),
    other_qualification   VARCHAR2(256BYTE),
    grade                 VARCHAR2(256BYTE),
    year                  VARCHAR2(256BYTE),
    distinction           VARCHAR2(256BYTE),
    merit                 VARCHAR2(256BYTE),
    pass                  VARCHAR2(256BYTE),
    overall               VARCHAR2(256BYTE),
    reading               VARCHAR2(256BYTE),
    writing               VARCHAR2(256BYTE),
    speaking              VARCHAR2(256BYTE),
    listening             VARCHAR2(256BYTE)
);

delete from c19_test_qualification;

insert into c19_test_qualification
select
--    line_number,
    col001,
    col002,
    col003,
    col004,
    col005,
    col006,
    col007,
    col008,
    col009,
    col010,
    col011,
    col012,
    col013,
    col014
from generic_file f,
    table(
        apex_data_parser.parse(
            p_content                     => f.file_content,
            p_skip_rows                   => 1,
            p_xlsx_sheet_name             => 'sheet2.xml',
            p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
            p_file_name                   => f.file_name
        )
    ) data
where f.id = 1;

update c19_test_qualification set grade = '2.2' where grade='2.2000000000000002';

select
    json_object(
        'QUALIFICATIONS' is (
            json_arrayagg(
            json_object(
                 'QUALIFICATION'       is qualification
                ,'SUBJECT'             is nvl(subject,other_qualification)
--                ,'OTHER_QUALIFICATION' is other_qualification
                ,'GRADE'               is grade
                ,'YEAR'                is year
                ,'DISTINCTION'         is distinction
                ,'MERIT'               is merit
                ,'PASS'                is pass
                ,'OVERALL'             is overall
                ,'READING'             is reading
                ,'WRITING'             is writing
                ,'SPEAKING'            is speaking
                ,'LISTENING'           is listening
                ABSENT ON NULL
                )
            )
        )
    )
from c19_test_qualification d
where id =1;



insert into c19_test_scenario
(
    id
    ,ucas_personal_id
    ,gender
    ,visa
    ,name1
    ,name2
    ,email
    ,second_year_entry
    ,tel1
    ,tel2
    ,nationality
    ,applied_to_ucas
    ,previously_applied_to_city
    ,over18
    ,notes
    ,previous_uni_study
    ,previous_study_notes
    ,ucas_code
    ,supplementary
    ,expected
    ,qualifications
)
select
--    line_number,
    col001,
    col002,
    col003,
    col004,
    col005,
    col006,
    col007,
    col008,
    col009,
    col010,
    col011,
    col012,
    col013,
--    col014, -- CRIMINAL_RECORD
--    col015, -- CRIMINAL_RECORD_NOTES
    col016,
    col017,
    col018,
    col019,
    col020,
    col021,
    col022,
    col023
from generic_file f,
    table(
        apex_data_parser.parse(
            p_content                     => f.file_content,
            p_skip_rows                   => 1,
            p_xlsx_sheet_name             => 'sheet1.xml',
            p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
            p_file_name                   => f.file_name
        )
    ) data
where f.id = 1;




select
     sheet_sequence,
     sheet_display_name,
     sheet_file_name,
     gf.id,
     gf.file_name
from generic_file gf,
    table(
        apex_data_parser.get_xlsx_worksheets(
            p_content => gf.file_content )
    );

select
    line_number,
    col001,
    col002,
    col003,
    col004,
    col005,
    col006,
    col007,
    col008,
    col009,
    col010,
    col011,
    col012,
    col013,
    col014,
    col015,
    col016,
    col017,
    col018,
    col019,
    col020,
    col021,
    col022,
    col023
from generic_file f,
    table(
        apex_data_parser.parse(
            p_content                     => f.file_content,
            p_skip_rows                   => 1,
            p_xlsx_sheet_name             => 'sheet1.xml',
            p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
            p_file_name                   => f.file_name
        )
    ) data
where f.id = 1;



delete from c19_test_scenario;



with 
    --
    -- This function takes work sheet name and file id
    -- and returns the count of records in excel file
    --
    function excel_row_count(
        i_xlsx_sheet_name   in varchar2,
        i_file_id           in number )
    return number
    is
        l_row_count   number;
    begin
        select
            count(*)
        into l_row_count
        from ref_data_activity_log f,
            table(
                apex_data_parser.parse(
                    p_content                     => f.file_content,
                    p_skip_rows                   => 1,
                    p_xlsx_sheet_name             => i_xlsx_sheet_name,
                    p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                    p_file_name                   => f.file_name
                )
            ) data
        where f.id = i_file_id;
        return l_row_count;
    end;
    --
    -- This function takes table name as argument
    -- and returns the count of records using execute immediate
    --
    function table_row_count(
        i_table_name   in varchar2)
    return number
    is
        l_row_count   number;
    begin
        execute immediate 'select count(*) from '|| i_table_name into l_row_count;
        return l_row_count;
    end;
select
    f.id,
    sheet_display_name excel_work_sheet_name,
    pd.value_s1        target_table_name,
--    sheet_file_name,
--    sheet_sequence,
--    sheet_path,
    excel_row_count(sheet_file_name,f.id) excel_record_count,
    table_row_count(pd.value_s1)          table_record_count
from ref_data_activity_log f
    cross join (table(
        apex_data_parser.get_xlsx_worksheets(
            p_content => file_content )
    )) p
    join param_dtl pd
        on (p.sheet_display_name = pd.value_s2)
where f.id=1181
    and pd.system_name='Clearing' 
    and pd.param_name='REF_DATA' 
    and pd.config_name='SRC_TGT';



https://technology.amis.nl/wp-content/uploads/2011/02/as_xlsx18.txt

Excel parsing
    Create a log table to list : file id, file name, file content, date-time of upload
    Parse the excel file and load eachtab to corresponding tables
    Excel column name and table column name can be mapped

create or replace directory blob_dir as '/u01/app/oracle';

docker cp C:\Users\sbrn521\Desktop\Files\Clearing_Reference_Data_2018_v3.xlsx oracle-apex:/files

docker cp C:\Users\sbrn521\Desktop\Files\Clearing_Reference_Data_2018_v3.xlsx mycitox:/u01/app/oracle/Clearing_Reference_Data_2018_v3.xlsx


drop table ref_data_activity_log;

create table ref_data_activity_log (
    id                number             -- generated by default as identity or generated by default on null as identity
    ,activity_type    varchar(1)         -- U uploaded, D downloaded
    ,user_remark      varchar2(255)      -- remark if any givn by user
    ,created          date               -- created date
    ,created_by       varchar2(100)      -- logged in username
    ,information      varchar2(4000)     -- Result of the attempted operation
    ,file_name        varchar2(100)      -- Downloaded file will have default naming pattern ref_data_yymmddhh24miss
    ,file_content     blob               -- Blob file content
    ,mime_type        varchar2(255)      -- required for apex reporting
    ,char_set         varchar2(128)      -- required for apex reporting
    ,is_success       varchar2(1)        -- Y/N
    ,constraint ref_data_activity_log_pk primary key (id)
);

select
    id,
    user_remark,
    created,
    created_by,
    information,
    file_name,
    sys.dbms_lob.getlength(file_content) file_size,
    sys.dbms_lob.getlength(file_content) download,
    mime_type,
    char_set
from ref_data_activity_log;

Interesting Format masks available in APEX : FILESIZE and SINCE 

Manually linking interactive report to a FORM : Create a dynamic action on dialog close event on the report region ( because it links the form) and refresh the report region on that event.
At the report attribute section enable link to custom target and select the form page number and set the primary column of the form.

genarate excel from D will generate the file and download it immediately.

create table ref_data_activity_log (
    id           number,            -- generated by default as identity or generated by default on null as identity
    file_name    varchar2(100),     -- Downloaded file will have default naming pattern ref_data_yymmddhh24miss
    file_content blob,              -- Blob file content
    file_type    varchar(1),        -- U uploaded, D downloaded
    created      date,              -- created date
    created_by   varchar2(100),     -- logged in username
    remark       varchar2(200),      -- remark if any givn by user
    message      varchar2(4000)     -- Result of the attempted operation
);

create sequence ref_data_event_seq start with 1 increment by 1;

exec ref_data_controller.get_dataset('Saoj');

create or replace ref_data_controller
is

    -- Builds a excel file
    procedure get_dataset(
        i_created_by   in     varchar2,
        i_remark       in     varchar2 default null
    );
    -- Parse the uploaded excel file and loads
    -- minto correpsonding tables
    procedure set_dataset(
        i_filename     in     varchar2,
        i_created_by   in     varchar2,
        i_remark       in     varchar2 default null
    );
    
end ref_data_controller;
/

create or replace body ref_data_controller
is
    function fl_get_file_name
    return varchar2
    is 
        c_file_prefix   constant  varchar2(30) := 'ref_data_';
    begin
      return c_file_prefix||to_char(sysdate,'yymmddhh24miss');
    end;
    -- Builds a excel file
    procedure get_dataset(
        i_filename     in     varchar2,
        i_created_by   in     varchar2,
        i_remark       in     varchar2 default null
    )
    is 
    begin 
    end;
    -- Parse the uploaded excel file and loads
    -- minto correpsonding tables
    procedure set_dataset(
        i_filename     in     varchar2,
        i_created_by   in     varchar2,
        i_remark       in     varchar2 default null
    );
    
end ref_data_controller;
/

create sequence ref_data_activity_log start with 1 increment by 1;

-- SELECT table_name,
--        column_name,
--        generation_type,
--        identity_options
-- FROM   all_tab_identity_cols;

create or replace procedure load_blob (
    i_dir       in     varchar2,
    i_filename  in     varchar2,
    io_id       in out number,
    i_remark    in     varchar2 default null
)
is
    l_bfile       bfile;
    l_blob        blob;
    l_dest_offset integer := 1;
    l_src_offset  integer := 1;
begin
    l_bfile := BFILENAME(i_dir, i_filename);
    IF (dbms_lob.fileexists(l_bfile) = 1) THEN
        insert into ref_data_activity_log
        (
            id
            ,file_name
            ,file_content
            ,upload_dt
            ,remark
        )
        values (
            ref_data_activity_log_seq.nextval
            ,i_filename
            ,empty_blob()
            ,sysdate
            ,i_remark
        ) 
        return id, file_content
        into io_id, l_blob;
        dbms_lob.fileopen(l_bfile, dbms_lob.file_readonly );
        dbms_lob.loadfromfile( l_blob, l_bfile, dbms_lob.getlength(l_bfile) );
        dbms_lob.fileclose(l_bfile );
        dbms_output.put_line('File loaded with id ='||io_id);
        commit;
    else
        dbms_output.put_line('File does not exist');
    end if;

END load_blob;
/

set serveroutput on;
DECLARE
    l_id     number;
BEGIN
    load_blob (  
        i_dir         => 'BLOB_DIR',
        i_filename    => 'Clearing_Reference_Data_2018_v3.xlsx',
        io_id         => l_id);
END;
/

--
-- Discover returns CLOB JSON
--
select 
    wwv_flow_data_parser.discover( 
        p_content         => file_content,
        p_file_name       => file_name,
        p_xlsx_sheet_name => 'sheet2.xml'
    )  as profile_json
from ref_data_activity_log f
where f.id = 1;

--
-- Returns the column name and column data type
--
select
    meta.column_position,
    meta.column_name,
    meta.data_type,
    meta.format_mask,
    meta.decimal_char
from ref_data_activity_log f,
    table(
    apex_data_parser.get_columns(
            wwv_flow_data_parser.discover( 
                p_content         => f.file_content,
                p_file_name       => f.file_name,
                p_xlsx_sheet_name => 'sheet2.xml'
            )        
        )
    ) meta
where f.id = 1;

select 
    sheet_display_name, 
    sheet_file_name,
    sheet_sequence,
    sheet_path
from ref_data_activity_log f,
    table( 
        apex_data_parser.get_xlsx_worksheets( 
            p_content => file_content ) 
    ) p
 where f.id = 1;

--
--     P_CONTENT             the file content to be parsed as a BLOB
--     P_FILE_NAME           the name of the file; only used to derive the file type. 
--     P_ADD_HEADERS_ROW     add the detected attribute names for XML or JSON files as the first row
--     P_XLSX_SHEET_NAME     For XLSX workbooks. The name of the worksheet to parse. If omitted or NULL, the function will
--                           use the first worksheet found.
--      
select 
    line_number, 
    col001, 
    col002, 
    col003
from ref_data_activity_log f, 
    table( 
        apex_data_parser.parse(
            p_content                     => f.file_content,
            p_add_headers_row             => 'Y',
            p_xlsx_sheet_name             => 'sheet5.xml',
            p_max_rows                    => 500,
            p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
            p_file_name                   => f.file_name 
        ) 
    )p
where f.id = 1;

exec ref_data_loader.load_all_ref_data;

update c19_subject  set subject='Art and Design (Photography)' where subject='S';

Fixed partition : three partitions . 
Four partitions : 1. Current active version 2. Last working copy. 3. Gold backup
when you upload a file it first replaces 2 with 1 and then replace excel content with 1.
Anytime user can mark current copy as gold version and then current version will be replaced with gold copy.
Any time user can restore from either last back up or gold copy.

Exchange partition 

function to create a hash value for all column of that table: apex function to use the difference based on primary key
Count mismatch, extra absent and value difference

select 
    line_number, 
    col001, 
    col002, 
    col003,
    col004,
    col005,
    col006,
    col007,
    col008,
    col009,
    col010,
    col011,
    col012,
    col013,
    col014,
    col015,
    col016,
    col017
from ref_data_activity_log f, 
        table( 
            apex_data_parser.parse(
                p_content                     => f.file_content,
                p_add_headers_row             => 'Y',
                p_xlsx_sheet_name             => 'sheet1.xml',
--                p_max_rows                    => 500,
                p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                p_file_name                   => f.file_name 
            ) 
        ) data
where f.id = 21
and line_number <> 1;

select 
    line_number, 
    col001, 
    col002, 
    col003
from ref_data_activity_log f, 
        table( 
            apex_data_parser.parse(
                p_content                     => f.file_content,
                p_add_headers_row             => 'Y',
                p_xlsx_sheet_name             => 'sheet2.xml',
--                p_max_rows                    => 500,
                p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                p_file_name                   => f.file_name 
            ) 
        ) data
where f.id = 21
and line_number <> 1;

select 
    line_number, 
    col001, 
    col002, 
    col003,
    col004,
    col005
from ref_data_activity_log f, 
        table( 
            apex_data_parser.parse(
                p_content                     => f.file_content,
                p_add_headers_row             => 'Y',
                p_xlsx_sheet_name             => 'sheet3.xml',
--                p_max_rows                    => 500,
                p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                p_file_name                   => f.file_name 
            ) 
        ) data
where f.id = 21
and line_number <> 1;


select 
    line_number, 
    col001, 
    col002
from ref_data_activity_log f, 
        table( 
            apex_data_parser.parse(
                p_content                     => f.file_content,
                p_add_headers_row             => 'Y',
                p_xlsx_sheet_name             => 'sheet4.xml',
                p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                p_file_name                   => f.file_name 
            ) 
        ) data
where f.id = 21
and line_number <> 1;

select 
    line_number, 
    col001, 
    col002, 
    col003,
    col004,
    col005
from ref_data_activity_log f, 
        table( 
            apex_data_parser.parse(
                p_content                     => f.file_content,
                p_add_headers_row             => 'Y',
                p_xlsx_sheet_name             => 'sheet5.xml',
                p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                p_file_name                   => f.file_name 
            ) 
        ) data
where f.id = 21
and line_number <> 1;

select 
    line_number, 
    col001, 
    col002, 
    col003
from ref_data_activity_log f, 
        table( 
            apex_data_parser.parse(
                p_content                     => f.file_content,
                p_add_headers_row             => 'Y',
                p_xlsx_sheet_name             => 'sheet6.xml',
                p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                p_file_name                   => f.file_name 
            ) 
        ) data
where f.id = 21
and line_number <> 1;

with user_access_data as(
select 
    col001    username, 
    col002    full_name, 
    col003    dept,
    col004    role,
    d.dept_id dept_id,
    row_number() over (partition by col001, col004 order by col004) role_rank
from ref_data_activity_log f
      cross join table( 
            apex_data_parser.parse(
                p_content                     => f.file_content,
                p_add_headers_row             => 'Y',
                p_xlsx_sheet_name             => 'sheet7.xml',
                p_file_name                   => f.file_name 
            ) 
        ) e
        join dept d  
        on (e.col003 = d.dept)
where f.id = 1201
and line_number !=1
)
select 
    username
    ,full_name
    ,dept
    ,role
    ,dept_id
    ,role_rank
from user_access_data
order by username, role;

select * from user_constraints where r_constraint_name='C19_PK_USER';

insert into working partitions 

range 
list
hash 
interval

create table apps(
    app_id number
    ,app_amnt number
)

partition by system
(
    partition  current
    ,partition backup
    ,partition gold
    ,partition previous_gold
);

insert into apps partition(p1) values(1,100);

Delete from current partition and insert the new data
If all table data loaded successfully then things will get commited : if fails in between then it will rollback.

Two set of tables because the unique key and all constraints are difficult to support?

begin
    as_xlsx.new_sheet( p_sheetname => 'Dummy_1');
    as_xlsx.query2sheet( p_sql => 'select 1 as num from dual', p_sheet => 1);
    as_xlsx.new_sheet( p_sheetname => 'Dummy_2');
    as_xlsx.query2sheet( p_sql => 'select 2 as num from dual', p_sheet => 2);
    as_xlsx.new_sheet( p_sheetname => 'Dummy_3');
    as_xlsx.query2sheet( p_sql => 'select 3 as num from dual', p_sheet => 3);
    as_xlsx.save( 'BLOB_DIR', 'my.xlsx' );
end;
/

-- Following works with sheet name as sheet1, sheet2 and so on
begin
    as_xlsx.query2sheet( p_sql => 'select 1 as num from dual');
    as_xlsx.query2sheet( p_sql => 'select 2 as num from dual');
    as_xlsx.query2sheet( p_sql => 'select 3 as num from dual');
    as_xlsx.save( 'BLOB_DIR', 'my.xlsx' );
end;
/

docker cp mycitox:/u01/app/oracle/my.xlsx C:\Users\sbrn521\Desktop\Files\

http://bobjankovsky.org/show.php?seq=132

Declare 
    V_CLOB clob:=null; 
    V_BLOB blob; 
    v_lang_context  integer := DBMS_LOB.DEFAULT_LANG_CTX; 
    v_warning       integer := DBMS_LOB.WARN_INCONVERTIBLE_CHAR; 
    v_dest_offset   integer := 1; 
    v_source_offset integer := 1; 
begin 

    dbms_lob.createtemporary(v_blob, true, DBMS_LOB.CALL); 
    sys.htp.init; 
    sys.owa_util.mime_header( 'application/octet-stream', FALSE,'UTF-8' ); 
    sys.htp.p('Content-length: ' || sys.dbms_lob.getlength( v_clob )); 
    sys.htp.p('Content-Disposition: attachment; filename="'||:P18_FILENAME||'"' ); 
    sys.owa_util.http_header_close; 
    dbms_lob.converttoblob ( 
        dest_lob    => V_BLOB, 
        src_clob    => V_CLOB, 
        amount      => DBMS_LOB.LOBMAXSIZE, 
        dest_offset => v_dest_offset, 
        src_offset  => v_source_offset, 
        blob_csid   => DBMS_LOB.DEFAULT_CSID, 
        lang_context=> v_lang_context, 
        warning     => v_warning 
    ); 
   sys.wpg_docload.download_file(v_blob); 
   DBMS_LOB.FREETEMPORARY (v_BLOB); --do not forget!! 
   apex_application.stop_apex_engine; 
exception when others then 
    sys.htp.prn('error: '||sqlerrm); 
   DBMS_LOB.FREETEMPORARY (v_BLOB); --do not forget!! 
   apex_application.stop_apex_engine; 
end;

-----
select
    ID,
    ROW_VERSION_NUMBER,
    PROJECT_ID,
    FILENAME,
    FILE_MIMETYPE,
    FILE_CHARSET,
    FILE_BLOB,
    FILE_COMMENTS,
    TAGS,
    CREATED,
    CREATED_BY,
    UPDATED,
    UPDATED_BY,
    sys.dbms_lob.getlength(file_blob) file_size,
    sys.dbms_lob.getlength(file_blob) download
from EBA_DEMO_FILES

select filename, blob_content
from
select 
    id, 
    application_id, 
    name, 
    filename, 
    mime_type, 
    created_on, 
    blob_content  
from apex_application_temp_files
where file_name=:P6_FILE_CONTENT
order by created_on desc
) where rownum =1;

Name : Saroja Ranjan Raut
Bank : SBI
A/C Number : 030913171319
IFSC Code : SBIN0001612
030913171319


