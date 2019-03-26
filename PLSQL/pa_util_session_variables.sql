create or replace package ams_etl.pa_util_session_variables
as
    --*******************************************************************************
    --
    -- This package contains routines to return standard session variables
    --
    -- %PCMS_HEADER_SUBSTITUTION_START%
    --       File: %ARCHIVE%
    --       $Revision %PR%
    --       Author: %AUTHOR%
    --       Last Changed: %PRT%
    -- %PCMS_HEADER_SUBSTITUTION_END%
    --
    --*******************************************************************************

    function server_host
    return varchar2;

    function host
    return varchar2;

    function ip_address
    return varchar2;

    function terminal
    return varchar2;

    function database_name
    return varchar2;

    function os_user
    return varchar2;

    function user_name
    return varchar2;

    function module
    return varchar2;

    function module_step
    return varchar2;

    function session_id
    return varchar2;

    function session_sid
    return pls_integer;

    function time
    return pls_integer;

    function system_dt
    return date;

    function system_date
    return date;

    function system_time_in_days
    return number;

    function system_time_in_hours
    return number;

    function system_time_in_minutes
    return number;

    function system_time_in_seconds
    return number;

    function get_application_setting
    (
        i_setting_name                   in      tams_application_setting.setting_name%type
       ,i_mandatory                      in      boolean := true
    )
    return tams_application_setting.setting_value%type result_cache;

end;

create or replace package body ams_etl.pa_util_session_variables
as
    --*******************************************************************************
    --
    -- This package contains routines to return standard session variables
    --
    -- %PCMS_HEADER_SUBSTITUTION_START%
    --       File: %ARCHIVE%
    --       $Revision %PR%
    --       Author: %AUTHOR%
    --       Last Changed: %PRT%
    -- %PCMS_HEADER_SUBSTITUTION_END%
    --
    --*******************************************************************************

    g_server_host     varchar2 (256 char);
    g_host            varchar2 (256 char);
    g_ip_address      varchar2 (256 char);
    g_terminal        varchar2 (256 char);
    g_database_name   varchar2 (256 char);
    g_os_user         varchar2 (256 char);
    g_user_name       varchar2 (256 char);
    g_session_id      varchar2 (256 char);
    g_session_sid     pls_integer;

    -- don't call debug_handler as this causes circular ref
    function server_host
    return varchar2
    as
    begin
        return (g_server_host);
    end;

    function host
    return varchar2
    as
    begin
        return (g_host);
    end;

    function ip_address
    return varchar2
    as
    begin
        return (g_ip_address);
    end;

    function terminal
    return varchar2
    as
    begin
        return (g_terminal);
    end;

    function database_name
    return varchar2
    as
    begin
        return (g_database_name);
    end;

    function os_user
    return varchar2
    as
    begin
        return (g_os_user);
    end;

    function user_name
    return varchar2
    as
    begin
        return (g_user_name);
    end;

    function module
    return varchar2
    as
    begin
        return (sys_context ('USERENV', 'MODULE'));
    end;

    function module_step
    return varchar2
    as
    begin
        return (sys_context ('USERENV', 'ACTION'));
    end;

    function session_id
    return varchar2
    as
    begin
        return (g_session_id);
    end;

    function session_sid
    return pls_integer
    as
    begin
        return (g_session_sid);
    end;

    function time
    return pls_integer
    as
    begin
        return (dbms_utility.get_time);
    end;

    function system_dt
    return date
    as
    begin
        return (sysdate);
    end;

    function system_date
    return date
    as
    begin
        return (trunc (sysdate));
    end;

    function system_time_in_days
    return number
    as
    begin
        return (sysdate - trunc (sysdate));
    end;

    function system_time_in_hours
    return number
    as
    begin
        return ((sysdate - trunc (sysdate)) * 24);
    end;

    function system_time_in_minutes
    return number
    as
    begin
        return ((sysdate - trunc (sysdate)) * 1440);
    end;

    function system_time_in_seconds
    return number
    as
    begin
        return ((sysdate - trunc (sysdate)) * 86400);
    end;


    function get_application_setting
    (
        i_setting_name                   in      tams_application_setting.setting_name%type
       ,i_mandatory                      in      boolean := true
    )
    return tams_application_setting.setting_value%type
    result_cache
    as
        l_setting_value                  tams_application_setting.setting_value%type;
    begin
        begin
            select  tas.setting_value
            into    l_setting_value
            from    tams_application_setting  tas
            where   tas.setting_name = i_setting_name;

        exception
            when no_data_found
            then
                if (i_mandatory)
                then
                    raise;
                else
                    l_setting_value := null;
                end if;
        end;

        return(l_setting_value);
    exception
        when others
        then
            pa_util_error.raise_error
            (
                i_error       => 'CANNOT_RETRIEVE_APPLICATION_SETTING'
               ,i_parameter_1 => i_setting_name
            );
    end;

begin
    g_server_host := sys_context ('USERENV', 'SERVER_HOST');
    g_host := sys_context ('USERENV', 'HOST');
    g_ip_address := sys_context ('USERENV', 'IP_ADDRESS');
    g_terminal := sys_context ('USERENV', 'TERMINAL');
    g_database_name := sys_context ('USERENV', 'DB_NAME');
    g_os_user := sys_context ('USERENV', 'OS_USER');
    g_user_name := sys_context ('USERENV', 'SESSION_USER');
    g_session_id := dbms_session.unique_session_id;
    g_session_sid := to_number (substr (g_session_id, 1, 4), 'xxxx');
end;
