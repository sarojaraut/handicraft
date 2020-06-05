create or replace function generate_excel
return blob
is
    l_file_id       number;
    l_excel         blob;
    l_stats         logger.tab_param := logger.gc_empty_tab_param;
    l_scope         varchar2(100) := $$plsql_unit;
begin
    logger.append_param(
        l_stats,
        'Start',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
    );
    dbms_lob.createtemporary( l_excel, true );

    as_xlsx.new_sheet( p_sheetname => 'USER_ACCESS');
    as_xlsx.query2sheet( 
        p_sql => '
            select 
                u.username
                ,u.full_name
                ,d.dept
                ,ud.role
            from c19_user@webapps_owner_prd u 
            left join c19_user_dept@webapps_owner_prd ud
            on (ud.username = u.username)
            left join c19_dept@webapps_owner_prd d
            on (ud.dept_id=d.dept_id)', 
        p_sheet => 1);

    -- as_xlsx.new_sheet( p_sheetname => 'APPLICATION');
    -- as_xlsx.query2sheet( 
    --     p_sql => 'select * from c19_application', 
    --     p_sheet => 1);

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
    logger.append_param(
        l_stats,
        'End',
        to_char(sysdate,'DD Mon YY hh24:mi:ss')
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
    raise;
end;
/

CREATE OR REPLACE PROCEDURE send_mail
IS
    l_date_stamp  VARCHAR2(100) := to_char(sysdate,'yyyy_mm_dd_hh24');
    l_to          VARCHAR2(100) := 'saroj.raut@city.ac.uk';
    l_from        VARCHAR2(100) := 'saroj.raut@city.ac.uk';
    l_subject     VARCHAR2(100) := '2019 clearing Data';
    l_text_msg    VARCHAR2(100) := 'Please find the attached file';
    l_attach_name VARCHAR2(100) := 'clearing_excel_'||to_char(sysdate,'yyyy_mm_dd_hh24')||'.xlsx';
    l_attach_mime VARCHAR2(100) := '';
    l_smtp_host   VARCHAR2(100) := 'smtphost.city.ac.uk';
    l_smtp_port   NUMBER := 25;
    l_attach_blob BLOB DEFAULT NULL;
    --
    --
    l_mail_conn   UTL_SMTP.connection;
    l_boundary    VARCHAR2(50) := '----=*#abc1234321cba#*=';
    l_step        PLS_INTEGER  := 12000; -- make sure you set a multiple of 3 not higher than 24573
BEGIN
    l_mail_conn := UTL_SMTP.open_connection(l_smtp_host, l_smtp_port);
    UTL_SMTP.helo(l_mail_conn, l_smtp_host);
    UTL_SMTP.mail(l_mail_conn, l_from);
    UTL_SMTP.rcpt(l_mail_conn, l_to);

    UTL_SMTP.open_data(l_mail_conn);

    UTL_SMTP.write_data(l_mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'To: ' || l_to || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'From: ' || l_from || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Subject: ' || l_subject || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Reply-To: ' || l_from || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'MIME-Version: 1.0' || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Type: multipart/mixed; boundary="' || l_boundary || '"' || UTL_TCP.crlf || UTL_TCP.crlf);

    IF l_text_msg IS NOT NULL THEN
        UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
        UTL_SMTP.write_data(l_mail_conn, 'Content-Type: text/plain; charset="iso-8859-1"' || UTL_TCP.crlf || UTL_TCP.crlf);

        UTL_SMTP.write_data(l_mail_conn, l_text_msg);
        UTL_SMTP.write_data(l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
    END IF;

    IF l_attach_name IS NOT NULL THEN
        l_attach_blob := generate_excel;
        UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
        UTL_SMTP.write_data(l_mail_conn, 'Content-Type: ' || l_attach_mime || '; name="' || l_attach_name || '"' || UTL_TCP.crlf);
        UTL_SMTP.write_data(l_mail_conn, 'Content-Transfer-Encoding: base64' || UTL_TCP.crlf);
        UTL_SMTP.write_data(l_mail_conn, 'Content-Disposition: attachment; filename="' || l_attach_name || '"' || UTL_TCP.crlf || UTL_TCP.crlf);

        FOR i IN 0 .. TRUNC((DBMS_LOB.getlength(l_attach_blob) - 1 )/l_step) LOOP
            UTL_SMTP.write_data(l_mail_conn, UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(DBMS_LOB.substr(l_attach_blob, l_step, i * l_step + 1))));
        END LOOP;

    UTL_SMTP.write_data(l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
    END IF;

    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || '--' || UTL_TCP.crlf);
    UTL_SMTP.close_data(l_mail_conn);

    UTL_SMTP.quit(l_mail_conn);
END;
/

exec send_mail;

-- Email Set up

grant execute on UTL_SMTP to WEBAPPS_OWNER;
grant execute on UTL_TCP to WEBAPPS_owner;


BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'email_acl_file.xml', 
    description  => 'A test of the ACL functionality',
    principal    => 'SYS',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;
END;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'email_acl_file.xml',
    host        => 'smtphost.city.ac.uk', 
    lower_port  => 25,
    upper_port  => 25); 

  COMMIT;
END;
/

alter system set smtp_out_server = 'smtphost.city.ac.uk:25' scope=both;

SELECT host, lower_port, upper_port, acl FROM   dba_network_acls;

SELECT acl,
       principal,
       privilege,
       is_grant,
       TO_CHAR(start_date, 'DD-MON-YYYY') AS start_date,
       TO_CHAR(end_date, 'DD-MON-YYYY') AS end_date
FROM   dba_network_acl_privileges;

SELECT DECODE(
         DBMS_NETWORK_ACL_ADMIN.check_privilege('email_acl_file.xml', 'WEBAPPS_OWNER', 'connect'),
         1, 'GRANTED', 0, 'DENIED', NULL) privilege 
FROM dual;

SELECT *
FROM   TABLE(DBMS_NETWORK_ACL_UTILITY.domains('smtphost.city.ac.uk'));

SQL> connect / as sysdba
SQL> @?/rdbms/admin/utlmail.sql
SQL> @?/rdbms/admin/prvtmail.plb 
SQL> grant execute on utl_mail to public;

DECLARE
  v_From      VARCHAR2(80) := 'saroj.raut@city.ac.uk';
  v_Recipient VARCHAR2(80) := 'saroj.raut@city.ac.uk';
  v_Subject   VARCHAR2(80) := 'test subject';
  v_Mail_Host VARCHAR2(30) := 'smtphost.city.ac.uk';
  v_Mail_Conn utl_smtp.Connection;
  crlf        VARCHAR2(2)  := chr(13)||chr(10);
BEGIN
 v_Mail_Conn := utl_smtp.Open_Connection(v_Mail_Host, 25);
 utl_smtp.Helo(v_Mail_Conn, v_Mail_Host);
 utl_smtp.Mail(v_Mail_Conn, v_From);
 utl_smtp.Rcpt(v_Mail_Conn, v_Recipient);
 utl_smtp.Data(v_Mail_Conn,
   'Date: '   || to_char(sysdate, 'Dy, DD Mon YYYY hh24:mi:ss') || crlf ||
   'From: '   || v_From || crlf ||
   'Subject: '|| v_Subject || crlf ||
   'To: '     || v_Recipient || crlf ||
   crlf ||
   'some message text'|| crlf ||	-- Message body
   'more message text'|| crlf
 );
 utl_smtp.Quit(v_mail_conn);
EXCEPTION
 WHEN utl_smtp.Transient_Error OR utl_smtp.Permanent_Error then
   raise_application_error(-20000, 'Unable to send mail', TRUE);
END;
/

CREATE OR REPLACE PROCEDURE send_mail (l_to        IN VARCHAR2,
                                       l_from      IN VARCHAR2,
                                       l_subject   IN VARCHAR2,
                                       p_message   IN VARCHAR2,
                                       l_smtp_host IN VARCHAR2,
                                       l_smtp_port IN NUMBER DEFAULT 25)
AS
  l_mail_conn   UTL_SMTP.connection;
BEGIN
  l_mail_conn := UTL_SMTP.open_connection(l_smtp_host, l_smtp_port);
  UTL_SMTP.helo(l_mail_conn, l_smtp_host);
  UTL_SMTP.mail(l_mail_conn, l_from);
  UTL_SMTP.rcpt(l_mail_conn, l_to);

  UTL_SMTP.open_data(l_mail_conn);
  
  UTL_SMTP.write_data(l_mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'To: ' || l_to || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'From: ' || l_from || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'Subject: ' || l_subject || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'Reply-To: ' || l_from || UTL_TCP.crlf || UTL_TCP.crlf);
  
  UTL_SMTP.write_data(l_mail_conn, p_message || UTL_TCP.crlf || UTL_TCP.crlf);
  UTL_SMTP.close_data(l_mail_conn);

  UTL_SMTP.quit(l_mail_conn);
END;
/


BEGIN
  send_mail(l_to        => 'saroj.raut@city.ac.uk',
            l_from      => 'saroj.raut@city.ac.uk',
            l_subject   => 'Test Subject - old',
            p_message   => 'This is a test message - old',
            l_smtp_host => 'smtphost.city.ac.uk');
END;
/


select * from ref_data_activity_log order by 1 desc;

create table temp_files(id number, data blob);

select * from temp_files;