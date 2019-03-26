begin
  ords.create_role('org_role');     
  commit;
end;
/

DECLARE
  l_arr owa.vc_arr;
BEGIN
  l_arr(1) := 'org_role';
  
  ORDS.define_privilege (
    p_privilege_name => 'org_priv',
    p_roles          => l_arr,
    p_label          => 'ORG Data',
    p_description    => 'Allow access to the ORG data.'
  );
   
  COMMIT;
END;
/

begin
 ords.create_privilege_mapping(
      p_privilege_name => 'org_priv',
      p_pattern => '/org/orgmst/*');     
  commit;
end;
/

First Party Authentication
org_user/org_user

java -jar C:\Saroj\Software\ords.3.0.4.60.12.48\ords.war user org_user org_role
INFO: Created user: org_user in file: C:\Saroj\Software\ords.3.0.4.60.12.48\config\ords\credentials

curl -i -k http://wwisdlap002/ords/cms/org/orgmst/

curl -i -k --user org_user:org_user http://wwisdlap002/ords/cms/org/orgmst/


OAuth 2: two-legged process

BEGIN
  OAUTH.create_client(
    p_name            => 'Org_Client',
    p_grant_type      => 'client_credentials',
    p_owner           => 'RI Limited',
    p_description     => 'A client for org management',
    p_support_email   => 'test@test.com',
    p_privilege_names => 'org_priv'
  );

  COMMIT;
END;
/

SELECT id, name, client_id, client_secret FROM user_ords_clients;

client id : bUAjQwIEw6rBtmgeAHN5Rg..
client secret : KFkK0vsYdTigFD0rWkuFcg..

-- Display client-privilege relationship.
SELECT name, client_name FROM user_ords_client_privileges;

-- Associate the client with org_role role required for org_priv
BEGIN
  OAUTH.grant_client_role(
    p_client_name => 'Org_Client',
    p_role_name   => 'org_role'
  );

  COMMIT;
END;
/

SELECT client_name, role_name FROM  user_ords_client_roles;

curl -i -k --user bUAjQwIEw6rBtmgeAHN5Rg..:KFkK0vsYdTigFD0rWkuFcg... --data "grant_type=client_credentials" http://wwisdlap002/ords/cms/oauth/token

curl -i -k --user bUAjQwIEw6rBtmgeAHN5Rg..:KFkK0vsYdTigFD0rWkuFcg... --data "grant_type=client_credentials" http://wwisdlap002/ords/oauth/token

{"access_token":"xxx","token_type":"bearer","expires_in":3600}

Bearer is the access token returned from above call.

curl -i -k -H"Authorization: Bearer xxx" http://wwisdlap002/ords/cms/org/orgmst/

/*
begin
ORDS.DELETE_PRIVILEGE('org_priv');     
  commit;
end;
/

begin
 ords.delete_privilege_mapping(
      p_privilege_name => 'org_priv',
      p_pattern => '/org/orgmst/*');     
  commit;
end;
/

ORDS.DEFINE_PRIVILEGE(
p_privilege_name VARCHAR2 (255) IN,
p_roles PL/SQL TABLE (VC_ARR) IN,
p_patterns PL/SQL TABLE (VC_ARR) IN,
p_modules PL/SQL TABLE (VC_ARR) IN,
p_label VARCHAR2 (255) IN DEFAULT NULL,
p_description VARCHAR2 (4000) IN DEFAULT NULL,
p_comments VARCHAR2 (4000) IN DEFAULT NYLL);
or
ORDS.DEFINE_PRIVILEGE(
p_privilege_name VARCHAR2 (255) IN,
p_roles PL/SQL TABLE (VC_ARR) IN,
p_patterns PL/SQL TABLE (VC_ARR) IN,
p_label VARCHAR2 (255) IN DEFAULT NULL,
p_description VARCHAR2 (4000) IN DEFAULT NULL,
p_comments VARCHAR2 (4000) IN DEFAULT NYLL);
or
ORDS.DEFINE_PRIVILEGE(
p_privilege_name VARCHAR2 (255) IN,
p_roles PL/SQL TABLE (VC_ARR) IN,
p_label VARCHAR2 (255) IN DEFAULT NULL,
p_description VARCHAR2 (4000) IN DEFAULT NULL,
p_comments VARCHAR2 (4000) IN DEFAULT NYLL);
*/