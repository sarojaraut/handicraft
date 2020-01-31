set serveroutput on;
declare
    l_ldap_host     VARCHAR2(256) := 'enterprise.internal.xx.ac.uk';
    l_ldap_port     VARCHAR2(256) := '636'; -- 389
    l_ldap_base     VARCHAR2(256) := 'dc=enterprise,dc=internal,dc=xx,dc=ac,dc=uk';
    l_dn_prefix     VARCHAR2(100) := 'enterprise\'; -- Amend as desired'.

    l_retval        PLS_INTEGER;
    l_session       DBMS_LDAP.session;

    P_USERNAME VARCHAR2(200) := 'saroj';
    P_PASSWORD VARCHAR2(200) := '';
BEGIN
    --    logger.log_error('p_username :'||p_username||'.p_password:'||p_password);
    dbms_output.put_line('Started');
    IF p_username IS NULL OR p_password IS NULL THEN
    RAISE_APPLICATION_ERROR(-20000, 'Credentials must be specified.');
    END IF;
    
    -- Choose to raise exceptions.
    DBMS_LDAP.use_exception := TRUE;
    
    -- Connect to the LDAP server.
    l_session := DBMS_LDAP.init(
                    hostname => l_ldap_host,
                    portnum  => l_ldap_port);
    dbms_output.put_line('Connection intialised');
    l_retval := DBMS_LDAP.open_ssl(
                    ld              => l_session,
                    sslwrl          => 'file:D:\OracleHome\ClearingSSCertificates', -- wallet location, ie file:/etc/ORACLE/WALLETS/oracle
                    sslwalletpasswd => 'xxxxx', -- wallet password
                    sslauth         => 2); -- NO_AUTH :1, ONE_WAY_AUTH: 2, TWO_WAY_AUTH: 3
    dbms_output.put_line('SSL connection');   
    l_retval := DBMS_LDAP.simple_bind_s(
                ld     => l_session,
                dn     => l_dn_prefix||p_username,
                passwd => p_password);
        dbms_output.put_line('Simple Binded');
    -- No exceptions mean you are authenticated.
    --   RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        --Exception means authentication failed. 
        dbms_output.put_line(SQLERRM);
    --    l_retval := DBMS_LDAP.unbind_s(ld => l_session);
    --    APEX_UTIL.set_custom_auth_status(p_status => 'Incorrect username and/or password');
        -- RETURN FALSE;    
END;
/






https://seanstuber.com/2018/07/07/how-to-use-dbms_ldap-part-2/

https://tylermuth.wordpress.com/2009/01/30/plsql-ldap-over-ssl-please-test/

