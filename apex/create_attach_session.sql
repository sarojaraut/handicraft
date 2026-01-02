-- Abort an already running automation
set serveroutput on;
declare
    v_pulse_app_id number := 100000;
    v_comm_app_id  number := 1118089;
    --
    v_adhoc_comm_gen_automation varchar2(100):= 'adhoc-generatecommission';
begin
    apex_session.create_session (
        p_app_id   => v_pulse_app_id,
        p_page_id  => 1,
        p_username => 'RAUTS2' );

        if apex_automation.is_running(
            p_application_id => v_pulse_app_id,
            p_static_id => v_adhoc_comm_gen_automation )
        then
            -- apex_automation.abort(
            --     p_application_id => v_pulse_app_id,
            --     p_static_id      => v_adhoc_comm_gen_automation );

            dbms_output.put_line( 'The Automation was running and now aborted' );
        else
            --
            -- execute executes synchronously
            -- apex_automation.execute(
            --     p_application_id => v_pulse_app_id,
            --     p_static_id      => v_adhoc_comm_gen_automation );
            --
            -- execute executes Asynchronously
            --
            -- apex_automation.execute(
            --     p_application_id => v_pulse_app_id,
            --     p_static_id      => v_adhoc_comm_gen_automation 
            --     p_run_in_background => true);
            dbms_output.put_line( 'The Automation is currently not running.' );
        end if;

end;
/

--Start automation if not already running
set serveroutput on;
declare
    v_pulse_app_id number := 100000;
    v_comm_app_id  number := 1118089;
    --
    v_adhoc_comm_gen_automation varchar2(100):= 'adhoc-generatecommission';
begin
    apex_session.create_session (
        p_app_id   => v_pulse_app_id,
        p_page_id  => 1,
        p_username => 'RAUTS2' );

        if apex_automation.is_running(
            p_application_id => v_pulse_app_id,
            p_static_id => v_adhoc_comm_gen_automation )
        then
            dbms_output.put_line( 'Already Running' );
        else
            --
            -- execute executes synchronously
            -- apex_automation.execute(
            --     p_application_id => v_pulse_app_id,
            --     p_static_id      => v_adhoc_comm_gen_automation );
            --
            -- execute executes Asynchronously
            --
            apex_automation.execute(
                p_application_id => v_pulse_app_id,
                p_static_id      => v_adhoc_comm_gen_automation ,
                p_run_in_background => true);
            dbms_output.put_line( 'The Automation Started' );
        end if;

end;
/


-- Attaching and setting session state, example shows setting application item

begin
    apex_session.attach (
        p_app_id     => 103,
        p_page_id    => 25,
        p_session_id => 14852695515895 );
        -- :DEMO_MODE = 'Y';
    apex_util.set_session_state('DEMO_MODE', 'Y');
    sys.dbms_output.put_line (
        'App is '||v('APP_ID')||', session is '||v('APP_SESSION'));
    commit;
end;
