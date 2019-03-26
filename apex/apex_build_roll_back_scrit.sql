/*
CREATE USER APEX_DEPLOY IDENTIFIED BY APEX_DEPLOY;
GRANT APEX_ADMINISTRATOR_ROLE TO APEX_DEPLOY; -- just gives execute privilege on a db package
GRANT CREATE SESSION TO APEX_DEPLOY;

Rollback Section

begin
    APEX_INSTANCE_ADMIN.REMOVE_WORKSPACE(
        p_workspace         => 'AMS'
        ,p_drop_users       => 'N'
        ,p_drop_tablespaces => 'N' );
end;
/

APEX_INSTANCE_ADMIN.ADD_SCHEMA(
    p_workspace    IN VARCHAR2,
    p_schema       IN VARCHAR2);
    
APEX_INSTANCE_ADMIN.REMOVE_SCHEMA(
    p_workspace     IN VARCHAR2,
    p_schema        IN VARCHAR2);

    -- Deleting User
DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
BEGIN
    APEX_UTIL.SET_SECURITY_GROUP_ID(P_SECURITY_GROUP_ID => 1000000000000000);
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'ANDREWF');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'ANGUSD');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'DAVIDW');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'HAYLEYH');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'JAMESHEA');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'KEVINC');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'MATTHEWR');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'NEILB');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'PAULH');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'SARRARA');
    APEX_UTIL.REMOVE_USER(P_USER_NAME => 'APEX_DEPLOY');
END;
/

APEX_UTIL.GET_CURRENT_USER_ID

-- Changing pasword

sqlplus AMS_PORTAL/amsportaldev@gba71011:10200/AMSDEV

set serveroutput on;
DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
    l_user_id         NUMBER;
    l_user_name       VARCHAR2(100);
begin
    apex_util.set_security_group_id(p_security_group_id => 1000000000000000);
    
    l_user_id   := APEX_UTIL.GET_USER_ID('SARRARA');
    l_user_name := APEX_UTIL.GET_USERNAME(l_user_id);
    
    dbms_output.put_line(l_user_id);
    APEX_UTIL.EDIT_USER (
    p_user_id                      => l_user_id,
    p_user_name                    => l_user_name,
    p_web_password                 => 'sarrara',
    p_new_password                 => 'sarrara' -- For updating the password web and new should be same
    );
    
    commit;
end;
/


DECLARE
    l_workspace_id    NUMBER       := 1000000000000000;
    l_user_id         NUMBER;
    l_user_name       VARCHAR2(100);
begin
    apex_util.set_security_group_id(p_security_group_id => 1000000000000000);
    
    l_user_id   := APEX_UTIL.GET_CURRENT_USER_ID;
    l_user_name := APEX_UTIL.GET_USERNAME(l_user_id);
    
    dbms_output.put_line(l_user_id);
    APEX_UTIL.EDIT_USER (
    p_user_id                      => l_user_id,
    p_user_name                    => l_user_name,
    p_web_password                 => :P3_NEW_PASSWORD,
    p_new_password                 => :P3_CONFIRM_PASSWORD);
    
    commit;
end;

begin
    if V('P3_NEW_PASSWORD')= V('P3_CONFIRM_PASSWORD') then
        APEX_UTIL.CHANGE_CURRENT_USER_PW(V('P3_NEW_PASSWORD'));
    else
        raise_application_error(-20343,'Confirmation password is not matching >' ||V('P3_NEW_PASSWORD')||':'||V('P3_CONFIRM_PASSWORD'));
    end if;
end;


getting user id required or reseting password by user name is enough?
Get user details?


*/

developer menu >

options > 

begin
raise_application_error(-20343,'Confirmation password is not matching');
end;
/

begin
if APEX_UTIL.IS_LOGIN_PASSWORD_VALID(
    p_username => 'SARRARA',
    p_password => 'sarrara') then
dbms_output.put_line('Password Valid');
else
dbms_output.put_line('Password invalid');
end if;
end;
/


APEX_UTIL.IS_LOGIN_PASSWORD_VALID(
    p_username => APEX_UTIL.GET_CURRENT_USER_ID(),
    p_password => V('P3_CURRENT_PASSWORD'));
    
DECLARE
    VAL BOOLEAN;
BEGIN
    VAL := APEX_UTIL.IS_LOGIN_PASSWORD_VALID(
        P_USERNAME => V('APP_USER'),
        P_PASSWORD => V('P3_CURRENT_PASSWORD'));
    RETURN VAL;
END;



Change Password

Invalid Current Pasword

If you wish to change your password, enter a new password. Otherwise, leave the password columns null and the current password will not be changed.

java -jar apex.war standalone --port 8181

