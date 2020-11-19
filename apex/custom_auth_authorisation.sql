------------------------------------------------------------------------
-- FUNCTION: H A S H _ P A S S W O R D
------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION HASH_PASSWORD(
    p_user_name in varchar2,
    p_password  in varchar2)
return varchar2
is
    l_password varchar2(255);
    -- The following salt is an example.
    -- Should probably be changed to another random string.
    l_salt  varchar2(255) := '2345USFGOJN2T3HW89EFGOBN23R5SDFGAKL';
begin
    --
    -- The following encryptes the password using a salt string and the
    -- DBMS_OBFUSCATION_TOOLKIT.
    -- This is a one-way encryption using MD5
    --
    l_password := utl_raw.cast_to_raw (
					dbms_obfuscation_toolkit.md5(
					    input_string => p_password
                            ||substr(l_salt,4,14)
                            ||p_user_name
                            ||substr(l_salt,5,10)
                    )
                );
    return l_password;
end hash_password;
/

------------------------------------------------------------------------
-- Simple Users Table
------------------------------------------------------------------------
CREATE SEQUENCE USERS_SEQ
    MINVALUE 1
    MAXVALUE 999999999999999999999999999
    INCREMENT BY 1
    START WITH 1
    NOCACHE
    NOORDER
    NOCYCLE
    NOKEEP
    NOSCALE
    GLOBAL
/
CREATE TABLE  USERS (
    USER_ID   number,
    USER_NAME varchar2(255) NOT NULL ENABLE,
    PASSWORD  varchar2(255) NOT NULL ENABLE,
    PRIMARY KEY (USER_ID) USING INDEX  ENABLE,
    CONSTRAINT USERS_U1 UNIQUE (USER_NAME) USING INDEX  ENABLE
)
/

--
-- Before insert rwo trigger to
--      stores username in uppercase
--      store the hashed password
--
CREATE OR REPLACE EDITIONABLE TRIGGER  BI_USERS
before insert on users
for each row
begin
    -- Get a unique sequence value to use as the primary key
    select users_seq.nextval into :new.user_id from dual;
    -- Make sure to save the username in upper case
    :new.user_name := upper(:new.user_name);
    -- Hash the password so we are not saving clear text
    :new.password := hash_password(upper(:new.user_name), :new.password);
end;
/

ALTER TRIGGER  BI_USERS ENABLE
/

--
-- Before update rwo trigger
--      stores username in uppercase
--      store the hashed password if password is updated
--
CREATE OR REPLACE EDITIONABLE TRIGGER  BU_USERS
before update on users
for each row
begin
    -- Make sure to save the user name in upper case
    :new.user_name := upper(:new.user_name);
    -- If the new password is not null
    if :new.password is not null then
        -- Make sure to hash the password so it is not stored in clear text
        :new.password := hash_password(upper(:new.user_name), :new.password);
        -- If the password is empty
    else
        -- Keep the old hashed password. We don't want a blank password.
        :new.password := :old.password;
    end if;
end;

/
ALTER TRIGGER  "BU_USERS" ENABLE
/

--
-- Custom authentication function
--
------------------------------------------------------------------------
-- FUNCTION: A U T H E N T I C A T E _ U S E R
------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION AUTHENTICATE_USER (
    p_username in varchar2,
    p_password in varchar2)
return boolean
is
    l_user_name       users.user_name%type    := upper(p_username);
    l_password        users.password%type;
    l_hashed_password varchar2(1000);
    l_count           number;
begin
-- Returns from the AUTHENTICATE_USER function
--    0    Normal, successful authentication
--    1    Unknown User Name
--    2    Account Locked
--    3    Account Expired
--    4    Incorrect Password
--    5    Password First Use
--    6    Maximum Login Attempts Exceeded
--    7    Unknown Internal Error
--
-- First, check to see if the user exists
    select count(*)
    into l_count
    from users
    where user_name = l_user_name;

    if l_count > 0 then
        -- Hash the password provided
        l_hashed_password := hash_password(l_user_name, p_password);
        -- Get the stored password
        select password
        into l_password
        from users
        where user_name = l_user_name;
        -- Compare the two, and if there is a match, return TRUE
        if l_hashed_password = l_password then
            -- Good result.
            APEX_UTIL.SET_AUTHENTICATION_RESULT(0);
            return true;
        else
            -- The Passwords didn't match
            APEX_UTIL.SET_AUTHENTICATION_RESULT(4);
            return false;
        end if;

    else
        -- The username does not exist
        APEX_UTIL.SET_AUTHENTICATION_RESULT(1);
        return false;
    end if;
    -- If we get here then something weird happened.
    APEX_UTIL.SET_AUTHENTICATION_RESULT(7);
    return false;
exception
    when others then
        -- We don't know what happened so log an unknown internal error
        APEX_UTIL.SET_AUTHENTICATION_RESULT(7);
        -- And save the SQL Error Message to the Auth Status.
        APEX_UTIL.SET_CUSTOM_AUTH_STATUS(sqlerrm);
        return false;

end authenticate_user;
/

-- Now create a test user to get started
Insert into USERS (USER_ID,USER_NAME,PASSWORD) values (1,'ADMIN','admin')
/

Access control list
Manul page for access control list 
Reader, contributor and Admin role
Lock down apec components
Step wizard to add multple users 


Building Out Our Own Solution
Authorisation level needed


Shared Components > Application Access Control > Add roles 
Admin
Consumer

This just gives a way to link users to these roles 
Exclusive Authorisation and Cascading Authorisation


To create these 2 roles in our sample application, we navigate to Shared Components > Application Access Control. From  there use the Add Role > button to add the for roles above. You will end up with something like this: 

Shared Components > Authorization Schemes > Create(From scratch)
Name : Exclusive Admin 
Scheme Type : Is in Role or Group
Type : Application Role
Names : Admin 
Error Message :
Validate Auth : Once per page visit ( so that we can make changes and test without being to log out an dlog in again)

For cascading Authorisation in the names field select all role names instead of one 

select role_name d, role_id r
from APEX_APPL_ACL_ROLES 
where application_id = :APP_ID 
order by 1

declare 
    l_roles     varchar2(4000);
begin 
    select role_ids
    into l_roles
    from apex_appl_acl_users
    where APPLICATION_ID = :APP_ID
    and USER_NAME = 'ADMIN';
    --
    :P1_ROLE_IDS := l_roles;
exception 
    when no_data_found then 
        :P10001_ROLE_ID := '';
end;

declare 
    l_roles   wwv_flow_t_number := apex_string.split_numbers(:P1_ROLE_IDS, ':');
BEGIN 
    APEX_ACL.REPLACE_USER_ROLES (
        p_application_id => :APP_ID,
        p_user_name => 'ADMIN',
        p_role_ids => l_roles );
END;

select * from APEX_ACL;

select * from APEX_APPL_ACL_USERS;

select * from APEX_APPL_ACL_ROLES;

select * from APEX_APPL_ACL_USER_ROLES;



-- https://blogs.oracle.com/apex/custom-authentication-and-authorization-using-built-in-apex-access-control-a-how-to
