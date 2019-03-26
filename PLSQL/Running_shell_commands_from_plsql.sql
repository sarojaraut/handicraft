CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED "HOST" AS
import java.lang.*;
import java.io.*;
 
public class Host
{
public static void executeCommand (String command, String etype) throws IOException
{
String[] wFullCommand = {"C:\\winnt\\system32\\cmd.exe", "/y", "/c", command};
String[] uFullCommand = {"/bin/sh", "-c", command};
if (etype.toUpperCase().equals("W"))
 Runtime.getRuntime().exec(wFullCommand);
else if(etype.toUpperCase().equals("U+"))
Runtime.getRuntime().exec(uFullCommand);
else if(etype.toUpperCase().equals("U"))
 Runtime.getRuntime().exec(command);
}
};
/


CREATE OR REPLACE PROCEDURE Host_Command_Proc (p_command  IN  VARCHAR2, p_etype  IN  VARCHAR2)
AS LANGUAGE JAVA 
NAME 'Host.executeCommand (java.lang.String, java.lang.String)';
/


begin
dbms_java.grant_permission( 'SAROJR','SYS:java.io.FilePermission', '/bin/sh', 'execute' );
end;
/


exec host_command_proc ('/bin/chmod 777 /home/sarrara/ams_etl.dmp', 'U+');

