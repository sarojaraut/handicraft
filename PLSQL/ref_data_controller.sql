create or replace package ref_data_controller
is
    function generate_excel(
        i_created_by         in     varchar2
        ,i_user_remark       in     varchar2
        ,o_file_name         out    varchar2
        ,o_file_id           out    number
    )
    return blob;

    function get_excel(
        i_file_id           in    number
    )
    return blob;
    procedure download(
        i_file_id           in    number
    );
    -- Builds a excel file
    procedure build_excel(
        i_created_by    in     varchar2
        ,i_user_remark  in     varchar2
    );
    -- Parse the uploaded excel file and loads
    -- minto correpsonding tables
    procedure process_excel(
        i_file_name           in     varchar2
        ,i_file_content       in     blob
        ,i_created_by         in     varchar2
        ,i_user_remark        in     varchar2
    );

end ref_data_controller;
/

create or replace package body ref_data_controller
is
    c_message_template varchar2(100)
        := 'Del count %s and Ins count %s';

    procedure set_constraint_deferred
    is
    begin
        execute immediate 'alter session set constraints = deferred';
    end;
    --
    --
    --
    procedure set_constraint_immediate
    is
    begin
        execute immediate 'alter session set constraints = immediate';
    end;
    --
    -- Called from ORDS end point for downloading the file
    --
    procedure download (
        i_file_id           in    number
    ) is
        l_blob       blob;
        l_file_name  varchar2(100);
    begin

        select file_content, file_name
        into l_blob, l_file_name
        from ref_data_activity_log
        where id = i_file_id;

        owa_util.mime_header('application/octet-stream', false);
        htp.p('content-length: ' || dbms_lob.getlength(l_blob));
        htp.p('content-disposition: filename="' || l_file_name || '"');
        owa_util.http_header_close;

        wpg_docload.download_file(l_blob);
    end;
    --
    -- Create a file name based on timestamp
    --
    function fl_get_file_name
    return varchar2
    is
        c_file_prefix   constant  varchar2(30) := 'ref_data_';
        c_file_extn   constant  varchar2(30)   := '.xlsx';
    begin
      return
        c_file_prefix
        || to_char(sysdate,'yymmddhh24miss')
        || c_file_extn;
    end;
    function get_excel(
        i_file_id           in    number
    )
    return blob
    is
        l_blob    blob;
    begin
        select file_content
        into l_blob
        from ref_data_activity_log
        where id = i_file_id;
        return l_blob;
    end;
    --
    -- Inserts activity log record
    --
    procedure pl_ins_activity_log(
        o_id                out           number
        ,i_activity_type    in            varchar2
        ,i_user_remark      in            varchar2
        ,i_file_name        in            varchar2
        ,i_file_content     in            blob
        ,i_created_by       in            varchar2
        -- i_stats        in out nocopy logger.tab_param
    )
    is
        pragma autonomous_transaction;
        l_scope         varchar2(60) :=$$plsql_unit||'.pl_ins_activity_log' ;
    begin

        insert into ref_data_activity_log(
            id
            ,activity_type
            ,user_remark
            ,created
            ,created_by
            ,information
            ,file_name
            ,file_content
            ,mime_type
            ,char_set
        )
        values(
            ref_data_event_seq.nextval
            ,i_activity_type
            ,i_user_remark
            ,sysdate
            ,i_created_by
            ,null
            ,i_file_name
            ,i_file_content
            ,'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
            ,'AL32UTF8'
        )
        returning id into o_id;
        commit;

    end pl_ins_activity_log;
    --
    -- Update activity log
    --
    procedure pl_upd_activity_log(
        i_id            in     number
        ,i_stats        in     logger.tab_param
        ,i_success_ind  in     varchar2 default 'Y'
        ,i_file_content in     blob default null
    )
    is
        pragma autonomous_transaction;
        l_scope         varchar2(60) :=$$plsql_unit||'.pl_upd_activity_log' ;
        l_info          varchar2(4000);
    begin
        for i in 1..i_stats.count
        loop
            l_info := l_info || i_stats(i).name||' : '||i_stats(i).val||chr(13);
        end loop;
        if i_file_content is null then
            update ref_data_activity_log
            set information  = l_info,
                is_success   = i_success_ind
            where id = i_id;
        else
            update ref_data_activity_log
            set information  = l_info,
                is_success   = i_success_ind,
                file_content = i_file_content
            where id = i_id;
        end if;
        commit;
    end pl_upd_activity_log;
    --
    -- Generates the individual excel worksheets and
    -- adds to the final file
    --
    function generate_excel(
        i_created_by    in     varchar2
        ,i_user_remark  in     varchar2
        ,o_file_name    out    varchar2
        ,o_file_id      out    number
    ) return blob
    is
        l_file_id       number;
        l_excel         blob;
        l_stats         logger.tab_param := logger.gc_empty_tab_param;
        c_initial_msg   varchar2(100) := 'Ref-data download by %s at %s';
        l_scope         varchar2(100) := $$plsql_unit||'.generate_excel';
    begin
        logger.append_param(
            l_stats,
            'Start',
            apex_string.format(
                c_initial_msg,
                i_created_by,
                to_char(sysdate,'DD Mon YY hh24:mi:ss')
            )
        );
        dbms_lob.createtemporary( l_excel, true );
        o_file_name := fl_get_file_name;

    pl_ins_activity_log(
        o_id                => o_file_id
        ,i_activity_type    => 'D'
        ,i_user_remark      => i_user_remark
        ,i_file_name        => o_file_name
        ,i_file_content     => NULL
        ,i_created_by       => i_created_by
        -- i_stats        in out nocopy logger.tab_param
    );
        --
        -- Add course Data
        --
        as_xlsx.new_sheet( p_sheetname => 'COURSE');
        as_xlsx.query2sheet( p_sql => 'select * from c19_course', p_sheet => 1);
        logger.append_param(
            l_stats,
            'COURSE exported',
            to_char(sysdate,'DD Mon YY hh24:mi:ss')
        );
        --
        -- Add qualification Data
        --
        as_xlsx.new_sheet( p_sheetname => 'QUALIFICATION');
        as_xlsx.query2sheet( p_sql => 'select * from c19_qualification', p_sheet => 2);
        logger.append_param(
            l_stats,
            'QUALIFICATION exported',
            to_char(sysdate,'DD Mon YY hh24:mi:ss')
        );
        --
        -- Add qual_option Data
        --
        as_xlsx.new_sheet( p_sheetname => 'QUAL_OPTION');
        as_xlsx.query2sheet( p_sql => 'select * from c19_qual_option', p_sheet => 3);
        logger.append_param(
            l_stats,
            'QUAL_OPTION exported',
            to_char(sysdate,'DD Mon YY hh24:mi:ss')
        );
        --
        -- Add subject Data
        --
        as_xlsx.new_sheet( p_sheetname => 'SUBJECT');
        as_xlsx.query2sheet( p_sql => 'select * from c19_subject', p_sheet => 4);
        logger.append_param(
            l_stats,
            'SUBJECT exported',
            to_char(sysdate,'DD Mon YY hh24:mi:ss')
        );
        --
        -- Add qual_subject Data
        --
        as_xlsx.new_sheet( p_sheetname => 'QUAL_SUBJECT');
        as_xlsx.query2sheet( p_sql => 'select * from c19_qual_subj', p_sheet => 5);
        logger.append_param(
            l_stats,
            'QUAL_SUBJECT exported',
            to_char(sysdate,'DD Mon YY hh24:mi:ss')
        );
        --
        -- Add course_subject Data
        --
        as_xlsx.new_sheet( p_sheetname => 'COURSE_SUBJECT');
        as_xlsx.query2sheet( p_sql => 'select * from c19_course_subject', p_sheet => 6);
        --
        -- Add course_subject Data
        --
        as_xlsx.new_sheet( p_sheetname => 'USER_ACCESS');
        as_xlsx.query2sheet( 
            p_sql => '
                select 
                    u.username
                    ,u.full_name
                    ,d.dept
                    ,ud.role
                from c19_user u 
                left join c19_user_dept ud
                on (ud.username = u.username)
                left join c19_dept d
                on (ud.dept_id=d.dept_id)', 
            p_sheet => 7);

        logger.append_param(
            l_stats,
            'USER_ACCESS exported',
            to_char(sysdate,'DD Mon YY hh24:mi:ss')
        );

        l_excel := as_xlsx.finish;

        logger.append_param(
            l_stats,
            'Generated successfully',
            to_char(sysdate,'DD Mon YY hh24:mi:ss')
        );
        pl_upd_activity_log(
            i_id            => o_file_id
            ,i_success_ind  => 'Y'
            ,i_file_content => l_excel
            ,i_stats        => l_stats
        );
        logger.append_param(
            l_stats,
            'End',
            apex_string.format(
                c_initial_msg,
                i_created_by,
                to_char(sysdate,'DD Mon YY hh24:mi:ss')
            )
        );
        return l_excel;
    exception
        when others then
            logger.log_error(
                'Data generation failure',
                l_scope,
                null,
                l_stats
            );
        logger.append_param(
            l_stats,
            'Generation Error',
            dbms_utility.format_error_stack()
        );
        pl_upd_activity_log(
            i_id            => o_file_id
            ,i_success_ind  => 'N'
            ,i_file_content => l_excel
            ,i_stats        => l_stats
        );
        raise;
    end;
    --
    -- Store the excel file in DB
    --
    procedure build_excel(
        i_created_by        in     varchar2
        ,i_user_remark      in     varchar2
    )
    is
        l_scope         varchar2(60) :=$$plsql_unit||'.build_excel' ;
        l_stats         logger.tab_param;
        l_file_name     varchar2(30);
        l_output_blob   blob;
        l_file_id       number;
    begin

        l_output_blob:= generate_excel(
            i_created_by         => i_created_by
            ,i_user_remark       => i_user_remark
            ,o_file_name         => l_file_name
            ,o_file_id           => l_file_id
        );

    exception
        when others then
            logger.log_error(
                'Reference data preparation failure',
                l_scope,
                null,
                l_stats
            );
            raise;
    end;
    --
    -- Loads course worksheet into course table
    --
    procedure load_course_data(
        i_work_sheet_name  in varchar2,
        i_file_id          in number,
        i_stats            in out logger.tab_param)
    is
        l_del_count     number;
        l_ins_count     number;
        l_scope         varchar2(60) :=$$plsql_unit||'.load_course_data' ;
    begin
        delete from c19_course;
        l_del_count := sql%rowcount;

        insert into c19_course
        select
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
            --TO_DATE ('1900-01-01','YYYY-MM-DD' ) + col016, -- Changed this to make it more flexible
            sysdate,
            col017
        from ref_data_activity_log f,
                table(
                    apex_data_parser.parse(
                        p_content                     => f.file_content,
                        p_add_headers_row             => 'Y',
                        p_xlsx_sheet_name             => i_work_sheet_name,
                        p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                        p_file_name                   => f.file_name
                    )
                ) data
        where f.id = i_file_id
        and line_number > 1;
        l_ins_count := sql%rowcount;

        logger.append_param(
            i_stats,
            'Course Data',
            apex_string.format(c_message_template, l_del_count, l_ins_count)
        );
    exception
        when others then
            logger.log_error(
                'Course data load failure',
                l_scope,
                null,
                i_stats
            );
            raise;
    end;
    --
    -- Load qualification data
    --
    procedure load_qualification_data(
        i_work_sheet_name  in varchar2,
        i_file_id          in number,
        i_stats            in out logger.tab_param)
    is
        l_del_count     number;
        l_ins_count     number;
        l_scope         varchar2(60) :=$$plsql_unit||'.load_qualification_data' ;
    begin
        delete from c19_qualification;
        l_del_count := sql%rowcount;

        insert into c19_qualification
        select
            col001,
            col002,
            col003
        from ref_data_activity_log f,
                table(
                    apex_data_parser.parse(
                        p_content                     => f.file_content,
                        p_add_headers_row             => 'Y',
                        p_xlsx_sheet_name             => i_work_sheet_name,
                        p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                        p_file_name                   => f.file_name
                    )
                ) data
        where f.id = i_file_id
        and line_number > 1;
        l_ins_count := sql%rowcount;

        logger.append_param(
            i_stats,
            'Course Data',
            apex_string.format(c_message_template, l_del_count, l_ins_count)
        );
    exception
        when others then
            logger.log_error(
                'Course data load failure',
                l_scope,
                null,
                i_stats
            );
            raise;
    end;
    --
    --
    --
    procedure load_qual_option_data(
        i_work_sheet_name  in varchar2,
        i_file_id          in number,
        i_stats            in out logger.tab_param)
    is
        l_del_count     number;
        l_ins_count     number;
        l_scope         varchar2(60) :=$$plsql_unit||'.load_qualification_data' ;
    begin
        delete from c19_qual_option;
        l_del_count := sql%rowcount;

        insert into c19_qual_option
        select
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
                        p_xlsx_sheet_name             => i_work_sheet_name,
                        p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                        p_file_name                   => f.file_name
                    )
                ) data
        where f.id = i_file_id
        and line_number > 1;
        l_ins_count := sql%rowcount;

        logger.append_param(
            i_stats,
            'Course Data',
            apex_string.format(c_message_template, l_del_count, l_ins_count)
        );
    exception
        when others then
            logger.log_error(
                'Course data load failure',
                l_scope,
                null,
                i_stats
            );
            raise;
    end load_qual_option_data;
    --
    --
    --
    procedure load_subject_data(
        i_work_sheet_name  in varchar2,
        i_file_id          in number,
        i_stats            in out logger.tab_param)
    is
        l_del_count     number;
        l_ins_count     number;
        l_scope         varchar2(60) :=$$plsql_unit||'.load_subject_data' ;
    begin
        delete from c19_subject;
        l_del_count := sql%rowcount;

        insert into c19_subject
        select
            col001,
            col002
        from ref_data_activity_log f,
                table(
                    apex_data_parser.parse(
                        p_content                     => f.file_content,
                        p_add_headers_row             => 'Y',
                        p_xlsx_sheet_name             => i_work_sheet_name,
                        p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                        p_file_name                   => f.file_name
                    )
                ) data
        where f.id = i_file_id
        and line_number > 1;
        l_ins_count := sql%rowcount;

        logger.append_param(
            i_stats,
            'Course Data',
            apex_string.format(c_message_template, l_del_count, l_ins_count)
        );
    exception
        when others then
            logger.log_error(
                'Course data load failure',
                l_scope,
                null,
                i_stats
            );
            raise;
    end load_subject_data;
    --
    --
    --
    procedure load_course_subject_data(
        i_work_sheet_name  in varchar2,
        i_file_id          in number,
        i_stats            in out logger.tab_param)
    is
        l_del_count     number;
        l_ins_count     number;
        l_scope         varchar2(60) :=$$plsql_unit||'.course_subject' ;
    begin
        delete from c19_course_subject;
        l_del_count := sql%rowcount;

        insert into c19_course_subject
        select
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
                        p_xlsx_sheet_name             => i_work_sheet_name,
                        p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                        p_file_name                   => f.file_name
                    )
                ) data
        where f.id = i_file_id
        and line_number > 1;
        l_ins_count := sql%rowcount;

        logger.append_param(
            i_stats,
            'Course Data',
            apex_string.format(c_message_template, l_del_count, l_ins_count)
        );
    exception
        when others then
            logger.log_error(
                'Course data load failure',
                l_scope,
                null,
                i_stats
            );
            raise;
    end load_course_subject_data;
    --
    --
    --
    procedure load_qual_subj_data(
        i_work_sheet_name  in      varchar2,
        i_file_id          in     number,
        i_stats            in out logger.tab_param
        )
    is
        l_del_count     number;
        l_ins_count     number;
        l_scope         varchar2(60) :=$$plsql_unit||'.load_qual_subj_data' ;
    begin
        delete from c19_qual_subj;
        l_del_count := sql%rowcount;

        insert into c19_qual_subj
        select
            col001,
            col002,
            col003
        from ref_data_activity_log f,
                table(
                    apex_data_parser.parse(
                        p_content                     => f.file_content,
                        p_add_headers_row             => 'Y',
                        p_xlsx_sheet_name             => i_work_sheet_name,
                        p_store_profile_to_collection => 'FILE_PARSER_COLLECTION',
                        p_file_name                   => f.file_name
                    )
                ) data
        where f.id = i_file_id
        and line_number > 1;
        l_ins_count := sql%rowcount;

        logger.append_param(
            i_stats,
            'Course Data',
            apex_string.format(c_message_template, l_del_count, l_ins_count)
        );
    exception
        when others then
            logger.log_error(
                'Course data load failure',
                l_scope,
                null,
                i_stats
            );
            raise;
    end load_qual_subj_data;
    --
    -- Load user access Data
    --
    procedure load_user_access_data(
        i_work_sheet_name  in      varchar2,
        i_file_id          in     number,
        i_stats            in out logger.tab_param
        )
    is
        l_del_count     varchar2(30);
        l_ins_count     number;
        l_scope         varchar2(60) :=$$plsql_unit||'.load_user_access_data' ;
    begin
        delete from c19_user;
        l_del_count := sql%rowcount;
        delete from c19_user_dept;
        l_del_count := l_del_count||'-'||sql%rowcount;

        insert all 
            when role_rank=1 then
                into c19_user(username, full_name)
                values (username, full_name)
            when 1=1 then
                into c19_user_dept(username, dept_id, role)
                values (username, dept_id, role)
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
                        p_xlsx_sheet_name             => i_work_sheet_name,
                        p_file_name                   => f.file_name 
                    ) 
                ) e
                join dept d  
                on (e.col003 = d.dept)
        where f.id = 1221
        and line_number !=1
        )
        select 
            username
            ,full_name
            ,dept
            ,role
            ,dept_id
            ,role_rank
        from user_access_data;

        l_ins_count := sql%rowcount;

        logger.append_param(
            i_stats,
            'User Data',
            apex_string.format(c_message_template, l_del_count, l_ins_count)
        );
    exception
        when others then
            logger.log_error(
                'Course data load failure',
                l_scope,
                null,
                i_stats
            );
            raise;
    end load_user_access_data;
    --
    -- Parse the uploaded excel file and loads
    -- into correpsonding tables
    procedure process_excel(
        i_file_name     in     varchar2,
        i_file_content  in     blob,
        i_created_by    in     varchar2,
        i_user_remark   in     varchar2
    )
    is
        l_scope         varchar2(60) :=$$plsql_unit||'.process_excel' ;
        l_stats         logger.tab_param;
        c_initial_msg   varchar2(100) := '%s uploded by %s at %s';
        l_file_id       number;
        l_ws_missing    boolean := false;
    begin
        logger.append_param(
            l_stats,
            'Start',
            apex_string.format(
                c_initial_msg,
                i_file_name,
                i_created_by,
                to_char(sysdate,'DD Mon YY hh24:mi:ss')
            )
        );

    logger.log(l_scope,'START', null, l_stats);

    pl_ins_activity_log(
        o_id                => l_file_id
        ,i_activity_type    => 'U'
        ,i_user_remark      => i_user_remark
        ,i_file_name        => i_file_name
        ,i_file_content     => i_file_content
        ,i_created_by       => i_created_by
        -- i_stats        in out nocopy logger.tab_param
    );

        set_constraint_deferred;

        for i in (
            -- with mandatory_ws_str as (
            -- select
            --     lower('course,qualification,qual_option,subject,course_subject,qual_subject,user_access') names
            -- from dual
            -- ),
            -- mandatory_ws as(
            -- select
            --     regexp_substr(ws.names,'[^,]+',1,rownum) ws_name
            -- from mandatory_ws_str ws
            -- connect by rownum <= regexp_count(ws.names,',' )+ 1
            -- ),
            with mandatory_ws as(
            select
                value_s1            table_name
                ,lower(value_s2)    ws_name
                ,lower(is_active)   is_active
                ,config_seq         seq
            from param_dtl
            where is_active != 'n' -- Y are mandatory and O are optional
            and system_name='Clearing'
            and param_name='REF_DATA'
            and config_name='SRC_TGT'
            order by config_seq
            ),
            supplied_ws as(
            select
                sheet_display_name,
                sheet_file_name,
                sheet_sequence,
                sheet_path,
                f.id
            from ref_data_activity_log f,
                table(
                    apex_data_parser.get_xlsx_worksheets(
                        p_content => file_content )
                ) p
            where f.id = l_file_id
            )
            select
                ws_name,
                sheet_display_name,
                sheet_file_name,
                sheet_sequence,
                sheet_path,
                sw.id,
                is_active
            from mandatory_ws mw
            left join supplied_ws sw
            on (mw.ws_name = lower(sw.sheet_display_name))
            order by nvl2(sheet_display_name, seq, -1)
            -- If something is missing then that will be picked of first
            -- if nothing missing then it will be processed in sequenced order
        )
        loop
            if i.sheet_display_name is null and i.is_active <> 'o' then
            -- user_access work sheet is optional
                l_ws_missing := true;
                    logger.append_param(
                        l_stats,
                        'Missing worksheet',
                        i.ws_name
                    );
            end if;
            --
            -- Process only if none of ws are missing
            --
            if not l_ws_missing and i.sheet_display_name is not null then
                logger.append_param(
                    l_stats,
                    'Processing worksheet',
                    i.ws_name
                );
                case i.ws_name
                    when 'course' then
                        load_course_data(i.sheet_file_name, i.id, l_stats);
                    when 'qualification' then
                        load_qualification_data(i.sheet_file_name, i.id, l_stats);
                    when 'qual_option' then
                        load_qual_option_data(i.sheet_file_name, i.id, l_stats);
                    when 'subject' then
                        load_subject_data(i.sheet_file_name, i.id, l_stats);
                    when 'course_subject' then
                        load_course_subject_data(i.sheet_file_name, i.id, l_stats);
                    when 'qual_subject' then
                        load_qual_subj_data(i.sheet_file_name, i.id, l_stats);
                    when 'user_access' then
                        load_user_access_data(i.sheet_file_name, i.id, l_stats);
                    else
                        NULL;
                end case;
            end if;
        end loop;

        logger.append_param(
            l_stats,
            'End',
            apex_string.format(
                c_initial_msg,
                i_file_name,
                i_created_by,
                to_char(sysdate,'DD Mon YY hh24:mi:ss')
            )
        );

        set_constraint_immediate;
        commit;

        pl_upd_activity_log(
            i_id            => l_file_id
            ,i_success_ind  => case when l_ws_missing then 'N' else 'Y' end
            ,i_stats        => l_stats
        );
        logger.log(l_scope,'END',null,l_stats);

    exception
        when others then
            logger.log_error(
                'Reference data upload failure',
                l_scope,
                null,
                l_stats
            );
        logger.append_param(
            l_stats,
            'Processing Error',
            dbms_utility.format_error_stack()
        );
        pl_upd_activity_log(
            i_id            => l_file_id
            ,i_success_ind  => 'N'
            ,i_stats        => l_stats
        );
        raise;
    end;

end ref_data_controller;
/

show err;

/*


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

create table param_hdr(
    system_name           varchar2(20)  -- e.g Clearing
    ,param_name           varchar2(20)  -- e.g REF_DATA
    ,description          varchar2(255) -- All configurations related to clearing reference data management
    ,constraint   param_hdr_pk primary key (system_name, param_name)
);

create table param_dtl(
    system_name           varchar2(20)  -- e.g Clearing
    ,param_name           varchar2(20)  -- e.g REF_DATA
    ,config_name          varchar2(20)  -- e.g SRC_TGT
    ,config_seq           number        -- e.g 1, 2 , 3
    ,value_n1             number        -- e.g NULL
    ,value_n2             number        -- e.g NULL
    ,value_d1             date          -- e.g NULL
    ,value_d2             date          -- e.g NULL
    ,value_s1             varchar2(100) -- e.g C19_SUBJECT
    ,value_s2             varchar2(100) -- e.g SUBJECT
    ,value_extra          varchar2(100) -- e.g @
    ,is_active            varchar2(1)   -- Y/N
    ,comments             varchar2(255) -- value extra field holds the db link name
    ,constraint   param_dtl_fk foreign key(system_name, param_name) references param_hdr(system_name, param_name)
    ,constraint   param_dtl_pk primary key (system_name, param_name, config_name, config_seq)
);

REM INSERTING into PARAM_HDR
SET DEFINE OFF;
Insert into PARAM_HDR (SYSTEM_NAME,PARAM_NAME,DESCRIPTION) values ('Clearing','REF_DATA','All configurations related to clearing reference data management, Y''s will be processed and if absent process will throw error, N''s will not be processed and if resent in excel will be ignored. O''s are optional and will be processed if present.');
Insert into PARAM_HDR (SYSTEM_NAME,PARAM_NAME,DESCRIPTION) values ('Clearing','DUMMY_PARRAM','Testing UI');


REM INSERTING into PARAM_DTL
SET DEFINE OFF;
Insert into PARAM_DTL (SYSTEM_NAME,PARAM_NAME,CONFIG_NAME,CONFIG_SEQ,VALUE_N1,VALUE_N2,VALUE_D1,VALUE_D2,VALUE_S1,VALUE_S2,VALUE_EXTRA,IS_ACTIVE,COMMENTS) values ('Clearing','REF_DATA','SRC_TGT',1,null,null,null,null,'C19_SUBJECT','SUBJECT','WEBAPPS_OWNER_DEV','Y','value extra field holds the db link name');
Insert into PARAM_DTL (SYSTEM_NAME,PARAM_NAME,CONFIG_NAME,CONFIG_SEQ,VALUE_N1,VALUE_N2,VALUE_D1,VALUE_D2,VALUE_S1,VALUE_S2,VALUE_EXTRA,IS_ACTIVE,COMMENTS) values ('Clearing','REF_DATA','SRC_TGT',2,null,null,null,null,'C19_COURSE_SUBJECT','COURSE_SUBJECT','WEBAPPS_OWNER_DEV','Y','value extra field holds the db link name');
Insert into PARAM_DTL (SYSTEM_NAME,PARAM_NAME,CONFIG_NAME,CONFIG_SEQ,VALUE_N1,VALUE_N2,VALUE_D1,VALUE_D2,VALUE_S1,VALUE_S2,VALUE_EXTRA,IS_ACTIVE,COMMENTS) values ('Clearing','REF_DATA','SRC_TGT',3,null,null,null,null,'C19_QUAL_OPTION','QUAL_OPTION','WEBAPPS_OWNER_DEV','Y','value extra field holds the db link name');
Insert into PARAM_DTL (SYSTEM_NAME,PARAM_NAME,CONFIG_NAME,CONFIG_SEQ,VALUE_N1,VALUE_N2,VALUE_D1,VALUE_D2,VALUE_S1,VALUE_S2,VALUE_EXTRA,IS_ACTIVE,COMMENTS) values ('Clearing','REF_DATA','SRC_TGT',4,null,null,null,null,'C19_QUAL_SUBJ','QUAL_SUBJECT','WEBAPPS_OWNER_DEV','Y','value extra field holds the db link name');
Insert into PARAM_DTL (SYSTEM_NAME,PARAM_NAME,CONFIG_NAME,CONFIG_SEQ,VALUE_N1,VALUE_N2,VALUE_D1,VALUE_D2,VALUE_S1,VALUE_S2,VALUE_EXTRA,IS_ACTIVE,COMMENTS) values ('Clearing','REF_DATA','SRC_TGT',5,null,null,null,null,'C19_COURSE','COURSE','WEBAPPS_OWNER_DEV','Y','value extra field holds the db link name');
Insert into PARAM_DTL (SYSTEM_NAME,PARAM_NAME,CONFIG_NAME,CONFIG_SEQ,VALUE_N1,VALUE_N2,VALUE_D1,VALUE_D2,VALUE_S1,VALUE_S2,VALUE_EXTRA,IS_ACTIVE,COMMENTS) values ('Clearing','REF_DATA','SRC_TGT',6,null,null,null,null,'C19_QUALIFICATION','QUALIFICATION','WEBAPPS_OWNER_DEV','Y','value extra field holds the db link name');
Insert into PARAM_DTL (SYSTEM_NAME,PARAM_NAME,CONFIG_NAME,CONFIG_SEQ,VALUE_N1,VALUE_N2,VALUE_D1,VALUE_D2,VALUE_S1,VALUE_S2,VALUE_EXTRA,IS_ACTIVE,COMMENTS) values ('Clearing','REF_DATA','SRC_TGT',7,null,null,null,null,'C19_USER_ACCESS','USER_ACCESS','WEBAPPS_OWNER_DEV','O','value extra field holds the db link name');


--Master details side by side query
select "SYSTEM_NAME",
    null link_class,
    apex_page.get_url(p_items => 'P16_SYSTEM_NAME,P16_PARAM_NAME', p_values => "SYSTEM_NAME"||','||"PARAM_NAME") link,
    null icon_class,
    null link_attr,
    null icon_color_class,
    case when nvl(:P16_SYSTEM_NAME,'0') = "SYSTEM_NAME"
      then 'is-active' 
      else ' '
    end list_class,
    substr("SYSTEM_NAME", 1, 50)||( case when length("SYSTEM_NAME") > 50 then '...' end ) list_title,
    substr("PARAM_NAME", 1, 50)||( case when length("PARAM_NAME") > 50 then '...' end ) list_text,
    null list_badge
from "PARAM_HDR" x
where (:P16_SEARCH is null
        or upper(x."SYSTEM_NAME") like '%'||upper(:P16_SEARCH)||'%'
        or upper(x."PARAM_NAME") like '%'||upper(:P16_SEARCH)||'%'
    )
order by "SYSTEM_NAME"


*/
-- show err;

/*
exec ref_data_controller.build_excel('saroj');

declare
    l_blob       blob;
    l_file_name  varchar2(30);
    l_file_id    number;
begin
    l_blob := ref_data_controller.generate_excel(
        i_created_by    => 'saroj'
        ,i_user_remark   => 'Testing'
        ,o_file_name    => l_file_name
        ,o_file_id      => l_file_id
        );
    dbms_output.put_line('File created-' ||l_file_name);
end;
/

Declare
    l_blob          blob :=null;
    l_file_name     varchar2(30);
begin
    l_blob := ref_data_controller.generate_excel(
        i_created_by    => 'saroj'
        ,i_user_remark   => 'Testing'
        ,o_file_name    => l_file_name
        );
    sys.htp.init;
    sys.owa_util.mime_header( 'application/octet-stream', FALSE,'UTF-8' );
    sys.htp.p('Content-length: ' || sys.dbms_lob.getlength( l_blob ));
    -- sys.htp.p('Content-Disposition: attachment; filename="'||:P18_FILENAME||'"' );
    sys.htp.p('Content-Disposition: attachment; filename="'||l_file_name||'"' );
    sys.owa_util.http_header_close;

   sys.wpg_docload.download_file(l_blob);
   DBMS_LOB.FREETEMPORARY (l_blob); --do not forget!!
   apex_application.stop_apex_engine;
exception when others then
    sys.htp.prn('error: '||sqlerrm);
   DBMS_LOB.FREETEMPORARY (l_blob); --do not forget!!
   apex_application.stop_apex_engine;
end;

select systimestamp from dual;
set serveroutput on;
set timing on;
begin
    for i in (
        select
            file_name,
            file_content
        from ref_data_activity_log
        where rownum = 1
    )
    loop
        ref_data_controller.process_excel(
            i_file_name     => i.file_name,
            i_file_content  => i.file_content,
            i_created_by    => 'Raut',
            i_user_remark   => 'First test'
        );
    end loop;
end;
/

select systimestamp from dual;

*/
-- BEGIN
--   ORDS.enable_schema(
--     p_enabled             => TRUE,
--     p_schema              => user,
--     p_url_mapping_type    => 'BASE_PATH',
--     p_url_mapping_pattern => 'api',
--     p_auto_rest_auth      => FALSE
--   );

--   COMMIT;
-- END;
-- /

BEGIN

    ORDS.define_module(
        p_module_name    => 'media_module',
        p_base_path      => 'media_module/',
        p_items_per_page => 0);

    ORDS.define_template(
        p_module_name    => 'media_module',
        p_pattern        => 'media/:fileid');

    ORDS.define_handler(
        p_module_name    => 'media_module',
        p_pattern        => 'media/:fileid',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_plsql,
        p_source         => q'[
            BEGIN
                ref_data_controller.download (i_file_id  => :fileid);
            EXCEPTION
                WHEN OTHERS THEN
                :status := 404;
                :message := SQLERRM;
            END;
        ]',
        p_items_per_page => 0);

    ORDS.define_parameter(
        p_module_name        => 'media_module',
        p_pattern            => 'media/:fileid',
        p_method             => 'GET',
        p_name               => 'X-ORDS-STATUS-CODE',   -- Available in 18.3
        p_bind_variable_name => 'status',
        p_source_type        => 'HEADER',
        p_access_method      => 'OUT'
        );

    ORDS.define_parameter(
        p_module_name        => 'media_module',
        p_pattern            => 'media/:fileid',
        p_method             => 'GET',
        p_name               => 'message',
        p_bind_variable_name => 'message',
        p_source_type        => 'RESPONSE',
        p_access_method      => 'OUT'
        );

  COMMIT;
END;
/

http://localhost:38080/ords/api/media_module/media/699

declare
    l_blob          blob :=null;
    l_file_name     varchar2(30);
    l_file_id       number;
begin
    l_blob := ref_data_controller.generate_excel(
        i_created_by        => :APP_USER
        ,i_user_remark      => :P6_USER_REMARK
        ,o_file_name        => l_file_name
        ,o_file_id          => l_file_id
        );
    commit;
end;

WEBAPPS_OWNER_DEV

push_data_to_target_env
begin
delete from 
c19_subject;
C19_COURSE_SUBJECT;
C19_QUAL_OPTION;
C19_QUAL_SUBJ;
C19_COURSE;
C19_QUALIFICATION;

-- Working in order
begin
    insert into C19_USER@WEBAPPS_OWNER_DEV select * from C19_USER; -- needed for course data
    insert into C19_dept@WEBAPPS_OWNER_DEV select * from C19_dept; -- needed for course data
    insert into C19_SUBJECT@WEBAPPS_OWNER_DEV select * from C19_SUBJECT;
    insert into C19_QUALIFICATION@WEBAPPS_OWNER_DEV select * from C19_QUALIFICATION;
    insert into C19_QUAL_OPTION@WEBAPPS_OWNER_DEV select * from C19_QUAL_OPTION;
    insert into C19_COURSE@WEBAPPS_OWNER_DEV select * from C19_COURSE;
    insert into C19_COURSE_SUBJECT@WEBAPPS_OWNER_DEV select * from C19_COURSE_SUBJECT;
    insert into C19_QUAL_SUBJ@WEBAPPS_OWNER_DEV select * from C19_QUAL_SUBJ;
end;
/

select 
    value_s1,
    value_s2,
    value_extra,
    apex_string.format(
        'insert into %0@%1 select * from %0' 
        ,value_s1
        ,value_extra
        ,value_s2
    ) sql_string
from param_dtl 
where system_name='Clearing' 
    and param_name='REF_DATA' 
    and config_name='SRC_TGT';

