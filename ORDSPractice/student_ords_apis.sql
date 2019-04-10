declare 
    l_module_name          varchar2(100)   := 'students.v1';
    L_module_base_path     varchar2(100)   := 'students/';
    L_template_base        varchar2(100)   := 'v1/';
    L_template_idbased     varchar2(100)   := 'v1/:id';
    l_del_student_byid_sql varchar2(32767) :=
        q'[
            declare
                l_id                student.id%type:=0;
                l_response_code     number;
                l_response_message  varchar2(4000);
                l_http_status       varchar2(100);
            begin
                student_api.delete_student(
                    i_id                  => :id,
                    o_response_code       => l_http_status,
                    o_response_message    => l_response_message
                );
                :http_status        := l_response_code;
                :response_message   := l_response_message;
            exception
                when others then
                    :http_status      := 503;
                    :response_message := sqlerrm;
                    rollback;
            end;
        ]';
    l_create_student_sql varchar2(32767) :=
        q'[
            declare
                l_id                student.id%type:=0;
                l_response_code     number;
                l_response_message  varchar2(4000);
                l_http_status       varchar2(100);
            begin
                student_api.create_student(
                    i_firstname           => :firstname ,
                    i_lastname            => :lastname  ,
                    i_address             => :address   ,
                    i_status              => :status    ,
                    o_id                  => l_id,
                    o_response_code       => l_http_status,
                    o_response_message    => l_response_message
                );
                :id                 := l_id;
                :http_status        := l_response_code;
                :response_message   := l_response_message;
            exception
                when others then
                    :http_status      := 503;
                    :response_message := sqlerrm;
                    rollback;
            end;
        ]';
    l_module_course           varchar2(100)   := 'courses.v1';
    L_module_course_base      varchar2(100)   := 'courses/v1/';
    L_course_stud_pattern     varchar2(100)   := 'students';
    l_get_studs_by_course_sql varchar2(32767) :=
        q'[
            select
                c.id           as "courseID"
                ,c.name         as "courseName"
                ,c.description  as "courseDescr"
                ,cursor(
                    select
                        s.firstname  as "firstName"
                        ,s.lastname   as "lastName"
                        ,s.address    as "address"
                        ,s.status     as "status"
                    from enrollment e
                    join student s
                        on e.student_id   = s.id
                    where e.course_id = c.id
                ) as  "student"
            from course c
        ]';
begin
    -- ords.enable_schema(
    --     p_enabled             => true,
    --     p_schema              => 'sarojws',
    --     p_url_mapping_type    => 'base_path',
    --     p_url_mapping_pattern => 'sarojapi',
    --     p_auto_rest_auth      => false
    -- );
    --
    -- main module template and handler
    --
    ords.define_module(
        p_module_name    => l_module_name,
        p_base_path      => L_module_base_path,
        p_items_per_page => 10,
        p_status         => 'PUBLISHED',
        p_comments       => 'students module'
    );
    --
    -- get all students : https://apex.oracle.com/pls/apex/sarojapi/students/
    --
    ords.define_template(
        p_module_name    => l_module_name,
        p_pattern        => L_template_base
    );

    ords.define_handler(
        p_module_name    => l_module_name,
        p_pattern        => L_template_base,
        p_method         => 'GET',
        p_source_type    => ords.source_type_query,
        p_source         => 'select * from student',
        p_items_per_page => 0
    );
    --
    -- get student by id : https://apex.oracle.com/pls/apex/sarojapi/students/1
    --
    ords.define_template(
        p_module_name    => l_module_name,
        p_pattern        => L_template_idbased
    );

    ords.define_handler(
        p_module_name    => l_module_name,
        p_pattern        => L_template_idbased,
        p_method         => 'GET',
        p_source_type    => ords.source_type_query_one_row,
        p_source         => 'select * from student where id=:id',
        p_items_per_page => 0
    );
    --
    -- delete student by id
    --
    ords.define_handler(
        p_module_name    => l_module_name,
        p_pattern        => L_template_idbased,
        p_method         => 'DELETE',
        p_source_type    => ords.source_type_plsql,
        p_source         => l_del_student_byid_sql,
        p_items_per_page => 0
    );

	ords.define_parameter(
		p_module_name        => l_module_name,
		p_pattern            => L_template_idbased,
		p_method             => 'DELETE',
		p_name               => 'X-APEX-STATUS-CODE',
		p_bind_variable_name => 'http_status',
		p_source_type        => 'HEADER',
		p_param_type         => 'INT',
		p_access_method      => 'OUT',
		p_comments           => 'HTTP Response status'
    );

	ords.define_parameter(
        p_module_name        => l_module_name,
        p_pattern            => L_template_idbased,
		p_method             => 'DELETE',
		p_name               => 'message',
		p_bind_variable_name => 'response_message',
		p_source_type        => 'RESPONSE',
		p_param_type         => 'STRING',
		p_access_method      => 'OUT',
		p_comments           => 'Result message'
    );
    --
    -- Create Student
    --
    ords.define_handler(
        p_module_name    => l_module_name,
        p_pattern        => L_template_base,
        p_method         => 'POST',
        p_source_type    => ords.source_type_plsql,
        p_source         => l_create_student_sql,
        p_items_per_page => 0
    );

	ords.define_parameter(
		p_module_name        => l_module_name,
		p_pattern            => L_template_base,
		p_method             => 'POST',
		p_name               => 'X-APEX-STATUS-CODE',
		p_bind_variable_name => 'http_status',
		p_source_type        => 'HEADER',
		p_param_type         => 'INT',
		p_access_method      => 'OUT',
		p_comments           => 'HTTP Response status'
    );

	ords.define_parameter(
        p_module_name        => l_module_name,
        p_pattern            => L_template_base,
		p_method             => 'POST',
		p_name               => 'message',
		p_bind_variable_name => 'response_message',
		p_source_type        => 'RESPONSE',
		p_param_type         => 'STRING',
		p_access_method      => 'OUT',
		p_comments           => 'Result message'
    );

	ords.define_parameter(
        p_module_name        => l_module_name,
        p_pattern            => L_template_base,
		p_method             => 'POST',
		p_name               => 'id',
		p_bind_variable_name => 'id',
		p_source_type        => 'RESPONSE',
		p_param_type         => 'INT',
		p_access_method      => 'OUT',
		p_comments           => 'Result message'
    );
    --
    -- Get students by courseid
    --
    ords.define_module(
        p_module_name    => l_module_course,
        p_base_path      => L_module_course_base,
        p_items_per_page => 10,
        p_status         => 'PUBLISHED',
        p_comments       => 'students module'
    );
    --
    -- get all ourses : https://apex.oracle.com/pls/apex/sarojapi/courses/v1
    --
    ords.define_template(
        p_module_name    => l_module_course,
        p_pattern        => '/'
    );

    ords.define_handler(
        p_module_name    => l_module_course,
        p_pattern        => '/',
        p_method         => 'GET',
        p_source_type    => ords.source_type_query,
        p_source         => 'select * from course',
        p_items_per_page => 0
    );
    --
    -- get all students by course : https://apex.oracle.com/pls/apex/sarojapi/courses/v1/students
    --
    ords.define_template(
        p_module_name    => l_module_course,
        p_pattern        => L_course_stud_pattern
    );

    ords.define_handler(
        p_module_name    => l_module_course,
        p_pattern        => L_course_stud_pattern,
        p_method         => 'GET',
        p_source_type    => ords.source_type_query,
        p_source         => l_get_studs_by_course_sql,
        p_items_per_page => 0
    );

    commit;
exception
    when others then 
        dbms_output.put_line(sqlerrm);
        rollback;
        raise;
end;
/