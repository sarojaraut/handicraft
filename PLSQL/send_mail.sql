
CREATE OR REPLACE PROCEDURE send_mail (p_to        IN VARCHAR2,
                                       p_from      IN VARCHAR2,
                                       p_subject   IN VARCHAR2,
                                       p_text_msg  IN VARCHAR2 DEFAULT NULL,
                                       p_html_msg  clob,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 25)
AS
  l_mail_conn   UTL_SMTP.connection;
  l_boundary    VARCHAR2(50) := '----=*#abc1234321cba#*=';
  l_step        PLS_INTEGER  := 12000; -- make sure you set a multiple of 3 not higher than 24573
BEGIN
  l_mail_conn := UTL_SMTP.open_connection(p_smtp_host, p_smtp_port);
  UTL_SMTP.helo(l_mail_conn, p_smtp_host);
  UTL_SMTP.mail(l_mail_conn, p_from);
  UTL_SMTP.rcpt(l_mail_conn, p_to);

  UTL_SMTP.open_data(l_mail_conn);
  
  UTL_SMTP.write_data(l_mail_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'To: ' || p_to || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'From: ' || p_from || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'Subject: ' || p_subject || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'Reply-To: ' || p_from || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'MIME-Version: 1.0' || UTL_TCP.crlf);
  UTL_SMTP.write_data(l_mail_conn, 'Content-Type: multipart/alternative; boundary="' || l_boundary || '"' || UTL_TCP.crlf || UTL_TCP.crlf);
  
  IF p_text_msg IS NOT NULL THEN
    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Type: text/plain; charset="iso-8859-1"' || UTL_TCP.crlf || UTL_TCP.crlf);

    UTL_SMTP.write_data(l_mail_conn, p_text_msg);
    UTL_SMTP.write_data(l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
  END IF;



  IF p_html_msg IS NOT NULL THEN
    UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
    UTL_SMTP.write_data(l_mail_conn, 'Content-Type: text/html; charset="iso-8859-1"' || UTL_TCP.crlf || UTL_TCP.crlf);

    FOR i IN 0 .. TRUNC((DBMS_LOB.getlength(p_html_msg) - 1 )/l_step) LOOP
      UTL_SMTP.write_data(l_mail_conn, DBMS_LOB.substr(p_html_msg, l_step, i * l_step + 1));
    END LOOP;
    UTL_SMTP.write_data(l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
  END IF;

  UTL_SMTP.write_data(l_mail_conn, '--' || l_boundary || '--' || UTL_TCP.crlf);
  UTL_SMTP.close_data(l_mail_conn);

  UTL_SMTP.quit(l_mail_conn);
END;
/

DECLARE
  l_html clob;
BEGIN
select  
    replace(
        TO_CLOB(data)
        ,'{{ student }}'
        ,'Test')
into l_html 
from temp_files where id=100;

  send_mail(p_to        => 'saroj.raut@city.ac.uk',
            p_from      => 'saroj.raut@city.ac.uk',
            p_subject   => 'Test Message',
            p_text_msg  => 'This is a test message.',
            p_html_msg  => l_html,
            p_smtp_host => 'smtphost.city.ac.uk');
END;
/

