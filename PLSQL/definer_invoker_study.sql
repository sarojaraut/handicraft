if you create a new role and grant that role to a already connected session, privileges will not be accesible. It will be only be accessible to new sessions. But if you drop a role and privileges will be revoked immediately.
you have to set role to avail the privileges.



create or replace procedure find_count_definer
is
	l_count  integer;
begin
	select count(*)
	into   l_count
	from   all_tables;
	dbms_output.put_line ('Count from definer is = '||l_count);
end;
/


create or replace procedure find_count_invoker 
authid current_user
is
	l_count  integer;
begin
	select count(*)
	into   l_count
	from   all_tables;
	dbms_output.put_line ('Count from invoker is = '||l_count);
end;
/

create role abcd;
grant select on sarojr.temp to abcd;
grant select on sarojr.temp1 to abcd;
grant abcd to ams_ihub;


drop procedure find_count_definer;
drop procedure find_count_invoker;
drop role abcd;

set serveroutput on;

begin
find_count_definer; -- Tables granted through roles will not be counted here
find_count_invoker; -- Tables granted through roles will be counted here
end;
/

Testing combination of invoker's right and definer's right


create table sarojr.main(name varchar2(20));
create table ams_ihub.main(name varchar2(20)) tablespace users;

insert into sarojr.main values ('sarojr_main');
insert into ams_ihub.main values ('ams_ihub_main');

create table sarojr.int1(name varchar2(20));
create table ams_ihub.int1(name varchar2(20));

insert into sarojr.int1 values ('sarojr_int1');
insert into ams_ihub.int1 values ('ams_ihub_int1');

create table sarojr.int2(name varchar2(20));
create table ams_ihub.int2(name varchar2(20));

insert into sarojr.int2 values ('sarojr_int2');
insert into ams_ihub.int2 values ('ams_ihub_int2');



set serveroutput on;

create or replace procedure sarojr.main
authid definer
is
tmp varchar2(20);
begin
	select name into tmp
	from main;
	dbms_output.put_line(tmp);
	p_int1;
	p_int2;
	
end;
/

create or replace procedure sarojr.p_int1
authid current_user
is
tmp varchar2(20);
begin
	select name into tmp
	from int1;
	dbms_output.put_line(tmp);
end;
/

create or replace procedure ams_ihub.p_int1
authid current_user
is
tmp varchar2(20);
begin
	select name into tmp
	from int1;
	dbms_output.put_line(tmp);
end;
/

create or replace procedure sarojr.p_int2
authid current_user
is
tmp varchar2(20);
begin
	select name into tmp
	from int2;
	dbms_output.put_line(tmp);
end;
/

create or replace procedure ams_ihub.p_int2
authid current_user
is
tmp varchar2(20);
begin
	select name into tmp
	from int2;
	dbms_output.put_line(tmp);
end;
/

drop table sarojr.main;
drop table sarojr.int1;
drop table sarojr.int2;

drop table ams_ihub.main;
drop table ams_ihub.int1;
drop table ams_ihub.int2;

drop procedure sarojr.main;
drop procedure sarojr.p_int1;
drop procedure sarojr.p_int2;

drop procedure ams_ihub.main;
drop procedure ams_ihub.p_int1;
drop procedure ams_ihub.p_int2;

