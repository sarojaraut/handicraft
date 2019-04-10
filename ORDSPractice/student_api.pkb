create or replace package student_api
is
    procedure create_student(
        i_firstname         in  student.firstname%type 
        ,i_lastname         in  student.lastname%type
        ,i_address          in  student.address%type  
        ,i_status           in  student.status%type
        ,o_id               out student.id%type     
        ,o_response_code    out number  
        ,o_response_message out varchar2
    );
    procedure delete_student(
        i_id                in student.id%type     
        ,o_response_code    out number  
        ,o_response_message out varchar2
    );
end student_api;
/
create or replace package body student_api
as
    procedure create_student(
        i_firstname         in  student.firstname%type 
        ,i_lastname         in  student.lastname%type
        ,i_address          in  student.address%type  
        ,i_status           in  student.status%type
        ,o_id               out student.id%type     
        ,o_response_code    out number  
        ,o_response_message out varchar2

    )
    is
        l_success_message  varchar2(100) := 'Student created successfully';
        l_failure_message  varchar2(100) := 'Creation failed for student %s-[%s]';
    begin 
        insert into student values(
            student_seq.nextval
            ,i_firstname 
            ,i_lastname 
            ,i_address  
            ,i_status   
        )
        returning id into o_id;
        o_response_code    := 200;
        o_response_message := l_success_message;
    exception 
        when others then
            o_response_code    := 500;
            o_response_message := 
            apex_string.format(
                l_failure_message
                ,i_firstname
                ,sqlerrm
            );
            -- Also add applicable code for logging the procedure state 
    end create_student;
    procedure delete_student(
        i_id                in student.id%type     
        ,o_response_code    out number  
        ,o_response_message out varchar2
    )
    is
        l_success_message  varchar2(100) := 'Student[%s] deleted successfully';
        l_notify_message  varchar2(100) := 'No Student[%s] to be deleted';
        l_failure_message  varchar2(100) := 'Deletion failed for id %s-[%s]';
        l_id               student.id%type;
    begin 
        delete from student where id=i_id
        returning id into l_id;
        If sql%rowcount > 0 then
            o_response_code    := 200;
            o_response_message := 
                apex_string.format(
                    l_success_message
                    ,l_id
                );
        else
            o_response_code    := 204;
            o_response_message := 
                apex_string.format(
                    l_notify_message
                    ,i_id
                );
        end if;
    exception 
        when others then
            o_response_code    := 404;
            o_response_message := 
            apex_string.format(
                l_failure_message
                ,i_id
                ,sqlerrm
            );
    end delete_student;
end student_api;
/

/*
declare
    l_notification_json  blob;
    l_id                 number;
    l_response_code      number;
    l_response_message   varchar2(100);
begin
    students_api.create_student(
        i_firstname           => :firstname ,
        i_lastname            => :lastname  ,
        i_address             => :address   ,
        i_status              => :status    ,
        o_id                  => l_id       ,
        o_response_code       => l_response_code,
        o_response_message    => l_response_message
    );
    :id                 := l_id;
    :http_status        := l_response_code;
    :response_message   := l_response_message;
exception
    when others then
        :http_status      := 503;
        :id               := -999;
        :response_message := sqlerrm;
        rollback;
end;

declare
    l_firstname         student.firstname%type  :='X';
    l_lastname          student.lastname%type   :='X';
    l_address           student.address%type    :='X';
    l_status            student.status%type     :='X';
    l_id                student.id%type;
    l_response_code     number;
    l_response_message  varchar2(4000);
    l_http_status       varchar2(100);
begin
    students_api.create_student(
        i_firstname           => l_firstname ,
        i_lastname            => l_lastname  ,
        i_address             => l_address   ,
        i_status              => l_status    ,
        o_id                  => l_id,
        o_response_code       => l_http_status,
        o_response_message    => l_response_message
    );
    dbms_output.put_line(l_id);
exception
    when others then
        l_http_status      := 503;
        l_response_message := sqlerrm;
        rollback;
end;

declare
    l_id                student.id%type:=21;
    l_response_code     number;
    l_response_message  varchar2(4000);
    l_http_status       varchar2(100);
begin
    students_api.delete_student(
        i_id                  => l_id,
        o_response_code       => l_http_status,
        o_response_message    => l_response_message
    );
    dbms_output.put_line(l_id);
exception
    when others then
        l_http_status      := 503;
        l_response_message := sqlerrm;
        rollback;
end;


*/