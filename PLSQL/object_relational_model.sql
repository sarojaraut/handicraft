--
drop sequence student_contact_seq;
drop sequence student_address_seq;
drop sequence student;

drop table student;
drop table student_contact;
drop table student_address;

create sequence student_contact_seq start with 1 increment by 1;
create sequence student_address_seq start with 1 increment by 1;
create sequence student_seq start with 1 increment by 1;

create table student_address(
    addressid    number(13)
    ,addresstype varchar2(20)
    ,address1    varchar2(100)
    ,address2    varchar2(100)
    ,towncity    varchar2(50)
    ,postcode    varchar2(20)
    ,country     varchar2(20)
    ,countrycode varchar2(20)
    ,constraint student_address_pk primary key (addressid)
);

create table student_contact(
    contactid    number(13)
    ,contacttype varchar2(20)
    ,title       varchar2(5)
    ,firstname   varchar2(100)
    ,surname     varchar2(50)
    ,email       varchar2(100)
    ,mobile      varchar2(20)
    ,phone       varchar2(20)
    ,constraint student_contact_pk primary key (contactid)
);

create table student(
    studentid         number(13)
    ,primarycontact   number(13)
    ,secondarycontact number(13)
    ,primaryaddress   number(13)
    ,secondaryaddress number(13)
    ,constraint student_pk primary key (studentid)
    ,constraint student_fk1 foreign key (primarycontact) references student_contact(contactid)
    ,constraint student_fk2 foreign key (secondarycontact) references student_contact(contactid)
    ,constraint student_fk3 foreign key (primaryaddress) references student_address(addressid)
    ,constraint student_fk4 foreign key (secondaryaddress) references student_address(addressid)
);


drop table students; -- This needs to eb dropped first
drop type student_o;
drop type address_ot;
drop type address_o;
drop type contact_ot;
drop type contact_o;

create type address_o as object (
    addresstype  varchar2(20)
    ,addressid   number(13)
    ,address1    varchar2(100)
    ,address2    varchar2(100)
    ,towncity    varchar2(50)
    ,postcode    varchar2(20)
    ,country     varchar2(20)
    ,countrycode varchar2(20)
);
/

create type address_ot as table of address_o; -- nested table type
/

create type contact_o as object (
    contacttype  varchar2(20)
    ,contactid   number(13)
    ,title       varchar2(5)
    ,firstname   varchar2(100)
    ,surname     varchar2(50)
    ,email       varchar2(100)
    ,mobile      varchar2(20)
    ,phone       varchar2(20)
);
/

create type contact_ot as table of contact_o; -- nested table type
/

create type student_o as object (
    student_id      number
    ,contacts       contact_ot
    ,addresses      address_ot
);
/

CREATE TABLE students OF student_o 
NESTED TABLE contacts STORE AS contacts 
NESTED TABLE addresses STORE AS addresses;

/*
declare 
    l_student student_o;
begin
    insert into students 
    values (
        student_seq.nextval
        ,contact_ot(
            contact_o('Primary',student_contact_seq.nextval,'Mr','Saroj','Raut','saroj.temp@gmail.com','07424333121','+447424333121')
            ,contact_o('Secondary',student_contact_seq.nextval,'Mr','Saroj','Raut','saroj.temp@gmail.com','07424333121','+447424333121')
        ),
        address_ot(
            address_o('Primary',student_address_seq.nextval,'Flat-86','Grand Union Heights','Wembley','HA0 1LF','UK','UK')
            ,address_o('Secondary',student_address_seq.nextval,'Flat-86','Grand Union Heights','Wembley','HA0 1LF','UK','UK')
        )
    );
    select value(s) -- note the value clause
    into l_student
    from students s 
    where student_id = (select max(student_id) from students);
end;
/

declare 
    l_student student_o;
begin
    insert into student_vw 
    values (
        get_nextval('student_seq')
        ,contact_ot(
            contact_o('Primary',get_nextval('student_contact_seq'),'Mr','Saroj','Raut','saroj.temp@gmail.com','07424333121','+447424333121')
            ,contact_o('Secondary',get_nextval('student_contact_seq'),'Mr','Saroj','Raut','saroj.temp@gmail.com','07424333121','+447424333121')
        ),
        address_ot(
            address_o('Primary',get_nextval('student_address_seq'),'Flat-86','Grand Union Heights','Wembley','HA0 1LF','UK','UK')
            ,address_o('Secondary',get_nextval('student_address_seq'),'Flat-86','Grand Union Heights','Wembley','HA0 1LF','UK','UK')
        )
    );
end;
/

declare 
    l_student student_o;
begin
    insert into students 
    values (
        get_nextval('student_seq')
        ,contact_ot(
            contact_o('Primary',get_nextval('student_contact_seq'),'Mr','Saroj','Raut','saroj.temp@gmail.com','07424333121','+447424333121')
            ,contact_o('Secondary',get_nextval('student_contact_seq'),'Mr','Saroj','Raut','saroj.temp@gmail.com','07424333121','+447424333121')
        ),
        address_ot(
            address_o('Primary',get_nextval('student_address_seq'),'Flat-86','Grand Union Heights','Wembley','HA0 1LF','UK','UK')
            ,address_o('Secondary',get_nextval('student_address_seq'),'Flat-86','Grand Union Heights','Wembley','HA0 1LF','UK','UK')
        )
    );
    select value(s) -- note the value clause
    into l_student
    from students s 
    where student_id = (select max(student_id) from students);
end;
/


*/

create or replace function get_nextval(
    i_sequence_name in varchar2)
return number
is 
    l_val     number;
begin
    execute immediate 'select '||i_sequence_name||'.nextval from dual' into l_val;
    return l_val;
end;
/

--Object View
CREATE OR REPLACE VIEW student_vw AS
SELECT  s.studentid,
        CAST (
            MULTISET (
                SELECT  
                    contacttype
                    ,contactid 
                    ,title     
                    ,firstname 
                    ,surname   
                    ,email     
                    ,mobile    
                    ,phone     
                FROM  student_contact sc
                WHERE  sc.contactid = s.primarycontact
                    OR sc.contactid = s.secondarycontact
            ) 
            AS contact_ot
        ) contacts,
        CAST (
            MULTISET (
                SELECT  
                    addresstype 
                    ,addressid  
                    ,address1   
                    ,address2   
                    ,towncity   
                    ,postcode   
                    ,country    
                    ,countrycode    
                FROM  student_address sa
                WHERE  sa.addressid = s.primaryaddress
                    OR sa.addressid = s.secondaryaddress
            ) 
            AS address_ot
        ) addresses
FROM  student s
/
--
-- Instead of trigger to insert into the base table
--
CREATE OR REPLACE TRIGGER student_vw_trg
INSTEAD OF INSERT ON student_vw
FOR EACH ROW
BEGIN

    -- Populate Address Data
    FOR i IN :new.addresses.first .. :new.addresses.last 
    LOOP
        INSERT INTO student_address (
            addressid   
            ,addresstype
            ,address1   
            ,address2   
            ,towncity   
            ,postcode   
            ,country    
            ,countrycode
        )
        VALUES (
            :new.addresses(i).addressid   
            ,:new.addresses(i).addresstype
            ,:new.addresses(i).address1   
            ,:new.addresses(i).address2   
            ,:new.addresses(i).towncity   
            ,:new.addresses(i).postcode   
            ,:new.addresses(i).country    
            ,:new.addresses(i).countrycode
        );
    END LOOP;
    -- Populate Contact Data
    FOR i IN :new.contacts.first .. :new.contacts.last 
    LOOP
        INSERT INTO student_contact (
            contactid   
            ,contacttype
            ,title      
            ,firstname  
            ,surname    
            ,email      
            ,mobile     
            ,phone      
        )
        VALUES (  
            :new.contacts(i).contactid   
            ,:new.contacts(i).contacttype
            ,:new.contacts(i).title      
            ,:new.contacts(i).firstname  
            ,:new.contacts(i).surname    
            ,:new.contacts(i).email      
            ,:new.contacts(i).mobile     
            ,:new.contacts(i).phone      
        );
    END LOOP;
    --Populate Student record
    insert into student(
        studentid        
        ,primarycontact  
        ,secondarycontact
        ,primaryaddress  
        ,secondaryaddress
    )
    values(
        :new.studentid
        ,:new.contacts(1).contactid 
        ,:new.contacts(2).contactid 
        ,:new.addresses(1).addressid 
        ,:new.addresses(2).addressid 
    );
END;
/


select * from students; -- Object View

select * from student; -- RDBMS table
select * from student_contact;
select * from student_address;

https://docs.oracle.com/cd/B19306_01/appdev.102/b14261/record_definition.htm