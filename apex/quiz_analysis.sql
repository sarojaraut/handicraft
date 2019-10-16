-- MyQuizTest
-- ReviseMe
--Aarevise
-- Revise
--Revisions
-- Aarevs
-- Revise
-- Funrevision.com -- 10$
--How much the domain costs
--Revisenotes.com
--Funrevision
--makemerevise

CREATE TABLE mqt_question_set (
    id                   NUMBER NOT NULL, -- to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
    question_set_id      NUMBER,
    row_version_number   NUMBER NOT NULL, -- set to 1 or Incremented every time row is updated by after update/insert trigger
    row_key              VARCHAR2(30 BYTE), -- Compressed integer, base 36 number, why do we need this?
    name                 VARCHAR2(255 BYTE) NOT NULL,
    score_type           VARCHAR2(1 BYTE) NOT NULL,
    use_sections_yn      VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL,
    description          VARCHAR2(4000 BYTE),
    status_id            NUMBER NOT NULL,
    image_filename       VARCHAR2(4000 BYTE),
    image_mimetype       VARCHAR2(512 BYTE),
    image_charset        VARCHAR2(512 BYTE),
    image_blob           BLOB,
    image_last_updated   DATE,
    image_width          NUMBER,
    image_height         NUMBER,
    created_by           VARCHAR2(255 BYTE),
    created              TIMESTAMP WITH LOCAL TIME ZONE,
    updated_by           VARCHAR2(255 BYTE),
    updated              TIMESTAMP WITH LOCAL TIME ZONE
);

ALTER TABLE mqt_question_set
    ADD CONSTRAINT mqt_question_set_cc2 CHECK ( score_type IN (
        'A',
        'C',
        'N'
    ) );

ALTER TABLE mqt_question_set
    ADD CONSTRAINT mqt_question_set_cc3 CHECK ( use_sections_yn IN (
        'N',
        'Y'
    ) );

CREATE INDEX mqt_question_set_01 ON mqt_question_set (status_id ASC );

CREATE UNIQUE INDEX mqt_question_set_pk ON mqt_question_set ( id ASC );

CREATE UNIQUE INDEX mqt_question_set_uk ON mqt_question_set (name  ASC );

ALTER TABLE mqt_question_set ADD CONSTRAINT mqt_question_set_pk PRIMARY KEY ( id );

ALTER TABLE mqt_question_set ADD CONSTRAINT mqt_question_set_uk UNIQUE ( name );

ALTER TABLE mqt_question_set ADD CONSTRAINT 
    eba_livepoll_q_set_stat_fk FOREIGN KEY ( status_id )
    REFERENCES eba_livepoll_status_codes ( id );


----

-- 92E7E663EAB70640E0530100007F0627
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- 195271380829355737750832696195387688487

-- id=to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')

---- 
drop table mqt_question_answer purge;
drop table mqt_question_option purge;
drop table mqt_question purge;
drop table mqt_question_set_attempt purge;
drop table mqt_question_set purge;


create table mqt_question_set (
    id                      number not null
    ,question_set           varchar2(4000)   not null
    ,Description            varchar2(4000)   not null
);

create table mqt_question_set_attempt (
    id                         number not null
    ,question_set_id           varchar2(4000)   not null
    ,app_user_name             varchar2(256)             
    ,created                   date             not null
    ,status                    varchar2(30)     not null -- START, COMPLETE
);

create table mqt_question (
    id                       number not null
    ,question_set            number not null
    ,question                varchar2(4000)   not null
    ,question_type           varchar2(30)     not null -- RADIO_GROUP, CHECK_BOX, FREE_TEXT
    ,display_order           number
);

create table mqt_question_option (
    id                      number not null
    ,question_id            number not null
    ,option_text            varchar2(256)     not null
    ,is_answer              varchar2(1)
);

create table mqt_question_answer (
    id                      number not null
    ,question_id            number not null
    ,attempt_id             number not null
    ,option_id              number not null
    ,user_id                varchar2(256)
);

<span aria-hidden="true" class="fa fa-check-circle fam-circle fam-is-success"></span>

<span aria-hidden="true" class="fa fa-times-circle fam-circle fam-is-success"></span>

Failed red large
<span aria-hidden="true" class="fa fa-times-circle-o fam-blank fam-is-danger fa-lg"></span>

success green large
<span aria-hidden="true" class="fa fa-check-circle-o fam-blank fam-is-success fa-lg"></span>

ALTER TABLE mqt_question ADD CONSTRAINT mqt_question_pk PRIMARY KEY ( id );

ALTER TABLE mqt_question_option ADD CONSTRAINT 
    mqt_question_option_fk FOREIGN KEY ( question_id )
    REFERENCES mqt_question ( id );

create sequence  mqt_question_seq 
    minvalue 1 
    maxvalue 99999999 
    increment by 1
    start with 1 cache 20 noorder  nocycle  nokeep  global;
/

create sequence  mqt_question_set_attempt_seq 
    minvalue 1 
    maxvalue 99999999 
    increment by 1
    start with 1 cache 20 noorder  nocycle  nokeep  global;
/

insert into mqt_question_set values(1,'Sample Question Set','Sample Question Set Description');

insert into mqt_question values(1,1,'What is 5 + 6?','RADIO_GROUP',10);
insert into mqt_question values(2,1,'5 + 6 is less than which of the following?','CHECK_BOX',20);
insert into mqt_question values(3,1,'5 + 6 is more than which of the following?','CHECK_BOX',30);

insert into mqt_question_option values(1,1,'10','N');
insert into mqt_question_option values(2,1,'11','Y');
insert into mqt_question_option values(3,1,'12','N');
insert into mqt_question_option values(4,1,'13','N');

insert into mqt_question_option values(5,2,'10','N');
insert into mqt_question_option values(6,2,'11','N');
insert into mqt_question_option values(7,2,'12','Y');
insert into mqt_question_option values(8,2,'13','Y');

insert into mqt_question_option values(5,3,'10','Y');
insert into mqt_question_option values(6,3,'11','N');
insert into mqt_question_option values(7,3,'12','N');
insert into mqt_question_option values(8,3,'13','N');

insert into mqt_question_set_attempt values(1,1,'APXAPP',sysdate,'START');


insert into mqt_question_set values(2,'Test Sample - 1','All radio group question test');
insert into mqt_question values(20,2,'What is 5 + 6?','RADIO_GROUP',10);
insert into mqt_question_option values(1,20,'10','N');
insert into mqt_question_option values(2,20,'11','Y');
insert into mqt_question_option values(3,20,'12','N');
insert into mqt_question_option values(4,20,'13','N');

insert into mqt_question values(21,2,'What is 16 * 8?','RADIO_GROUP',20);
insert into mqt_question_option values(1,21,'128','Y');
insert into mqt_question_option values(2,21,'144','N');
insert into mqt_question_option values(3,21,'118','N');
insert into mqt_question_option values(4,21,'108','N');

insert into mqt_question values(22,2,'What is 14 * 9?','RADIO_GROUP',30);
insert into mqt_question_option values(1,22,'144','N');
insert into mqt_question_option values(2,22,'128','N');
insert into mqt_question_option values(3,22,'126','Y');
insert into mqt_question_option values(4,22,'108','N');

insert into mqt_question values(23,2,'What is 32 - 8 * 2?','RADIO_GROUP',40);
insert into mqt_question_option values(1,23,'48','N');
insert into mqt_question_option values(2,23,'18','N');
insert into mqt_question_option values(3,23,'32','N');
insert into mqt_question_option values(4,23,'16','Y');

insert into mqt_question values(24,2,'What is the area of a suqre whose sides are 8 cm','RADIO_GROUP',50);
insert into mqt_question_option values(1,24,'64 cm','N');
insert into mqt_question_option values(2,24,'32 cm','N');
insert into mqt_question_option values(3,24,'64 square cm','Y');
insert into mqt_question_option values(4,24,'32 square cm','N');

insert into mqt_question values(25,2,'What is the perimeter of a suqre whose sides are 10 cm','RADIO_GROUP',60);
insert into mqt_question_option values(1,25,'40 cm','Y');
insert into mqt_question_option values(2,25,'32 cm','N');
insert into mqt_question_option values(3,25,'40 square cm','N');
insert into mqt_question_option values(4,25,'32 square cm','N');

/*
delete from mqt_question_set where id=2;
delete from mqt_question_option where question_id in (20,21,22,23,24,25);
delete from mqt_question where id in (20,21,22,23,24,25);
*/

insert into mqt_question_set_attempt values(2,2,'APXAPP',sysdate,'START');

create or replace view mqt_question_ordered_vw
as
select 
    id
    ,question_set -- should bequestion_set_id
    ,question 
    ,question_type
    ,display_order
    ,lead(id,1) over (partition by question_set order by display_order) next
    ,lag(id,1) over (partition by question_set order by display_order) prev
    ,(
        select listagg(id,',') within group( order by id) 
        from mqt_question_option 
        where question_id=mq.id
        and is_answer='Y'
    ) answer
from mqt_question mq
order by display_order;



Badge list query to 
select 
    "ID",
    null link_class,
    apex_page.get_url(p_items => 'P5_ID', p_values => "ID") link,
    null icon_class,
    null link_attr,
    null icon_color_class,
    case when nvl(:P5_ID,'0') = "ID"
      then 'is-active' 
      else ' '
    end list_class,
    substr("QUESTION", 1, 50)||( case when length("QUESTION") > 50 then '...' end ) list_title,
    substr("QUESTION_TYPE", 1, 50)||( case when length("QUESTION_TYPE") > 50 then '...' end ) list_text,
    null list_badge
from "MQT_QUESTION" x
where (:P5_SEARCH is null
        or upper(x."QUESTION") like '%'||upper(:P5_SEARCH)||'%'
        or upper(x."QUESTION_TYPE") like '%'||upper(:P5_SEARCH)||'%'
    )
order by "QUESTION"



-- Alert type classic report query
select 
    id
    ,question_set alert_title
    ,description  alert_desc
    ,total_attempt_count alert_action
    ,case 
        when total_attempt_count = 0     then 'info'
        when total_attempt_count >=1     then 'success'
        when total_attempt_count >= 1000 then 'warning'
        else                             'danger' 
    end    as alert_type
    ,user_attempt_count
from
(
select
    id
    ,question_set 
    ,description  
    ,(
        select count(1) 
        from mqt_question_set_attempt qsa
        where qsa.question_set_id = qs.id
    ) as total_attempt_count
    ,(
        select count(1) 
        from mqt_question_set_attempt qsa
        where qsa.question_set_id = qs.id
        and app_user_name = app_user_name
    ) user_attempt_count
from mqt_question_set qs
);

-- Card type classic report query
-- If your boss does not value your work then it's time for a fresh start
select 
    id                   card_initials
    ,question_set        card_title
    ,description         card_text
    ,total_attempt_count card_subtext
    ,'f?p='                  ||
        :APP_ID              ||
        ':3:'                ||
        :APP_SESSION         ||
        '::NO::'             ||
        'P3_QUESTION_SET_ID:'||
        id                   || card_link
        ,user_attempt_count
from
(
select
    id
    ,question_set 
    ,description  
    ,(
        select count(1) 
        from mqt_question_set_attempt qsa
        where qsa.question_set_id = qs.id
    ) as total_attempt_count
    ,(
        select count(1) 
        from mqt_question_set_attempt qsa
        where qsa.question_set_id = qs.id
        and app_user_name = app_user_name
    ) user_attempt_count
from mqt_question_set qs
);

select 
    ename  as alert_title,
    job    as alert_desc,
    sal    as alert_action,
    case 
        when sal < 1000                then 'info'
        when sal between 2000 and 3000 then 'success'
        when sal between 3000 and 4000 then 'warning'
        else                                'danger' 
    end    as alert_type
from emp;

P3_QUESTION_SET_ID

insert into mqt_question_answer values(
       mqt_question_seq.nextval
    ,:G_QUESTION_ID
    ,:G_ATTEMPT_ID
    ,:P9_OPTION
    ,:APP_USER
);

procedure insert_answer(
    i_question_id          number
    ,i_attempt_id          number
    ,i_answer              number
    ,i_user                number
    ,o_message             varchar2
    ,o_explanation         varchar2
)


/* Clean up
--Soft

delete from mqt_question_answer;
delete from mqt_question_option;
delete from mqt_question;
delete from  mqt_question_set_attempt;
delete from mqt_question_set;

--Hard

drop table mqt_question_answer purge;
drop table mqt_question_option purge;
drop table mqt_question purge;
drop table mqt_question_set_attempt;
drop table mqt_question_set purge;
*/

/* Requirements
1. Answer validation : radio box answres are easy : 
    Selected value = select mqt_question_option from mqt_question_option where question_id = item_name;

Users can create quiz sets of their own
Other topic wise questions can be grouped based on category.

Classic report
Click on take quiz > That will generate an attempt id and no partial completed id already exists

Page lists all the questions sets in card link format.
Clicking on any card will edirect to another page with question set valur set to the card clicked.
This page should show the question and once clicked on submit should show the result of the question
There can be two regions On region displaying the question
and the other region displaying the status of the questions (Correct/Incorrect/Not attended and a link to go back to the question.)
Two buttons next and previous  and saved state should get fetched from the database.
How to fetch status from database and showing the ticked results.
There needs to be three regions
One for radio group, one for check box and one for free text. 
depending on the question type of the current question the result whould get displayed.
So control types are 
How do you track the question number where you are at any given point of time.

Page Items :

These are global items that can be set from any page

g_question_set_id - question set id : to be set when choosed from the classic report
Following five needs to be populated by row fetch process dependng on question set and and current question id
g_question_id - Question id :
g_question_text 
g_question_type
g_next_question_id - Next question id :
g_prev_question_id previous question id :
g_answer

    select 
        question_set
        ,id
        ,question
        ,question_type
        ,next
        ,prev
        ,answer
    into
         :g_question_set_id
        ,:g_question_id
        ,:g_question_text
        ,:g_question_type
        ,:g_next_question_id
        ,:g_prev_question_id
        ,:g_answer
    from mqt_question_ordered_vw 
    where question_set=nvl(g_question_set_id,2)
    and id = NVL(g_question_id,20);

G_QUESTION_ID

G_NEXT_QUESTION_ID

one previous button and next button which are activated depending on their item valus.

none of the ui should be dependent on underlying tables.

get_question(
    i_question_set    in number
    ,i_id             in number -- null means fetch the first question
    ,o_question_text  out varchar2
    ,o_question_type  out varchar2
    ,o_next           out number
    ,o_prev           out number
);


Finish

set_pagination

There will be items (one radio option and one check box) and one of them will be displayed depending on the value of question type
On submit the value of either radio and check box will be stored depending on question type.

Downloading a PDF version of the file : enhance ment

How the answer will be checked?
qmt_question_answer contains the answer in raw format : option_id, list of option_id and free text.
When submit button will be pressed then the answer will be checked with 


When a quiz is started for the first time : 
it will crete a session with status = START if not already there.
If a start session is already there then session id will be fetched.
Subsequenet questions will be shown with the already answered options.
That session will be move to completed status when the user clicks on the finish button
Finish button will be shown at the end of quiz along with the last questions 

page items : G_QUESTION_SET_ID , G_QUESTION_ID, G_QUESTION_TEXT,, G_QUESTION_TYPE, G_NEXT_QUESTION_ID, G_PREV_QUESTION_ID, G_ANSWER, G_ATTEMPT_ID
Page process to initialise all the application items.
REgion display selector with title as &G_QUESTION_TEXT.
Radio group with content as
select option_text,id 
from mqt_question_option where question_id=:g_question_id

Three buttons
Prev , submit, next : spacing bottom and left set as large, size is large, Icons fa-angle-double-right, fa-angle-double-left
Next redirect to same page with G_QUESTION_ID = &G_NEXT_QUESTION_ID.
Previous button redirect to same page with G_QUESTION_ID = &G_PREV_QUESTION_ID.
Hide prev and next button when corresponding item becomes null. On page load with server side condition as item G_PREV_QUESTION_ID is null and same for other button
When submit is clicked a record should get inserted into the mqt_question_answer table also a should show an message about whether answer is correct or not.
We can add a new column to record whether answer is right or wrong. should have a record answer procedure. 

Enhancements :

Wrong answer should show some explanation
Suggestion on where you can 

*/

/* Git hub pages

Migrating from other blog posts to git pages

http://krisrice.io/2017-10-06-migrating-my-blog-from-blogger-to-github-pages-with-jekyll/

http://deanattali.com/beautiful-jekyll/ 

domain name can be registered at a price of 0.99 $ per year.

Lets's book the data for coming Friday, they have asked me to document everything as they have not taken decission on what to do. 

*/

Left hand menu 
Create or replace package mqt_take_quiz
is
    --
    -- Return if already esists else create one and return the id
    --
    function get_quiz_session(
        i_user_name        varchar2,
        i_question_set_id  number
    ) return number;
end mqt_take_quiz;
/


Create or replace package body mqt_take_quiz
is
    function fl_create_session(
        i_user_name        varchar2,
        i_question_set_id  number
    ) return number
    is 
        l_sesion_id    number;
    begin
        insert into mqt_question_set_attempt(
            id              
            ,question_set_id
            ,app_user_name  
            ,created        
            ,status         
        )
        values(
            mqt_question_set_attempt_seq.nextval
            ,i_question_set_id
            ,i_user_name
            ,sysdate
            ,'START'
        ) 
        returning id 
        into l_sesion_id; 
        
        return l_sesion_id;

        -- rownum=1 is just a safe mesaure there should not be more than one incomplete attempts
    exception
        when others then
            logger.log_error(
                p_text    => 'Fatal error from get_quiz_session'
                ,p_scope   => 'get_quiz_session'            
                );
        raise;
    end fl_create_session;
    --
    --
    --
    function get_quiz_session(
        i_user_name        varchar2,
        i_question_set_id  number
    ) return number
    is 
        l_sesion_id    number;
    begin
        select id 
        into l_sesion_id
        from mqt_question_set_attempt
        where app_user_name = i_user_name
        and question_set_id = i_question_set_id
        and status          <> 'COMPLETE'
        and rownum =1; 

        return l_sesion_id;

        -- rownum=1 is just a safe mesaure there should not be more than one incomplete attempts
    exception
    when no_data_found then
        return fl_create_session(i_user_name, i_question_set_id);
    when others then
        logger.log_error(
            p_text    => 'Fatal error from get_quiz_session'
            ,p_scope   => 'get_quiz_session'            
            );
        return null;
    end get_quiz_session;

end mqt_take_quiz;
/


create or replace package test_mqt_take_quiz as

  -- %suite
  -- %displayname(Take Quiz)

  -- %test
  -- %displayname(Fetches existing session)
  -- %beforetest(add_session)
  procedure fetch_existing_session;

  -- %test
  -- %displayname(Creates a new session)
  -- %beforetest(del_session)
  procedure create_new_session;

  procedure add_session;

end test_mqt_take_quiz;
/

create or replace package body test_mqt_take_quiz as

  gc_test_user_1                constant varchar2(30) := 'Saroj';
  gc_test_user_2                constant varchar2(30) := 'Test';
  gc_test_question_set          constant number  := -1;
  g_test_attempt_id             number;

    procedure add_session
    is
    begin
        insert into mqt_question_set_attempt(
            id              
            ,question_set_id
            ,app_user_name  
            ,created        
            ,status         
        )
        values(
            mqt_question_set_attempt_seq.nextval
            ,gc_test_question_set
            ,gc_test_user_1
            ,sysdate
            ,'START'
        )
        returning id
        into g_test_attempt_id;
    end;
    --
    --
    procedure del_session
    is
    begin
        delete from mqt_question_set_attempt
        where question_set_id = gc_test_question_set
        and   app_user_name   = gc_test_user_2
        and   status          = 'START';
    end;
    --
    --
    function get_session_count
    return number
    is
        l_count   number;
    begin
        select count(1)
        into l_count
        from mqt_question_set_attempt
        where question_set_id = gc_test_question_set
        and   app_user_name   = gc_test_user_2
        and   status          = 'START';

        return l_count;
    end;
    --
    --
    procedure fetch_existing_session is
        l_session_id number;
    begin
    --arrange
        -- open not_affected for
        -- select * from employees_test where employee_id <> gc_test_employee;

    --act
        l_session_id := mqt_take_quiz.get_quiz_session(gc_test_user_1, gc_test_question_set);
        dbms_output.put_line('l_session_id = '||l_session_id);

    --assert
        ut.expect( l_session_id ).to_equal( g_test_attempt_id );
    end;
    --
    --
    procedure create_new_session is
        l_session_id   number;
        l_before_count number;
        l_after_count  number;
    begin
    --arrange
        l_before_count := get_session_count;

    --act
        l_session_id := mqt_take_quiz.get_quiz_session(gc_test_user_2, gc_test_question_set);
        l_after_count := get_session_count;
        dbms_output.put_line('l_before_count = '||l_before_count);
        dbms_output.put_line('l_after_count = '||l_after_count);

    --assert
        ut.expect( l_after_count -  l_before_count).to_equal( 1 );
    end;
end test_mqt_take_quiz;
/

exec ut.run(user||'.test_mqt_take_quiz');

create or replace trigger  bi_mqt_question_trg
before insert on mqt_question
for each row
 when (new.id is null) 
begin
    :new.od := mqt_question_seq.nextval;
end;
/

CREATE TABLE mqt_question (
    id                   NUMBER NOT NULL, -- to_number(sys_guid(),'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
    question_set_id      NUMBER,
    row_version_number   NUMBER NOT NULL, -- set to 1 or Incremented every time row is updated by after update/insert trigger
    row_key              VARCHAR2(30 BYTE), -- Compressed integer, base 36 number, why do we need this?
    name                 VARCHAR2(255 BYTE) NOT NULL,
    score_type           VARCHAR2(1 BYTE) NOT NULL,
    use_sections_yn      VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL,
    description          VARCHAR2(4000 BYTE),
    status_id            NUMBER NOT NULL,
    image_filename       VARCHAR2(4000 BYTE),
    image_mimetype       VARCHAR2(512 BYTE),
    image_charset        VARCHAR2(512 BYTE),
    image_blob           BLOB,
    image_last_updated   DATE,
    image_width          NUMBER,
    image_height         NUMBER,
    created_by           VARCHAR2(255 BYTE),
    created              TIMESTAMP WITH LOCAL TIME ZONE,
    updated_by           VARCHAR2(255 BYTE),
    updated              TIMESTAMP WITH LOCAL TIME ZONE
);

select 
    level as item_no,
    apex_item.text( p_idx=> 1 , p_value=> null , p_attributes=> 'class="number"') as id,
    apex_item.text(p_idx => 2, p_attributes => null) as question,
    apex_item.select_list(3,'radio_group','radio_group;RADIO_GROUP,checkbox;CHECKBOX,text;TEXT,stack;STACK') question_type,
    apex_item.text(p_idx => 4, p_attributes => null) as answer_01
from dual
where rownum <=to_number (:P2_HOW_MANY)
connect by level <= to_number (:P2_HOW_MANY)
;

if :p2_how_many is not null and :p2_how_many > 0 then
for i in 1 .. apex_application.g_f01.count loop
insert into mqt_question (id, question, question_type, answer_01)
   values ( 
       apex_application.g_f01(i), 
       apex_application.g_f02(i), 
       apex_application.g_f03(i), 
       apex_application.g_f04(i));
end loop;
end if;

declare
    s1    varchar2(4000);
    s2    varchar2(4000);
    s3    varchar2(4000);
    s4    varchar2(4000);
begin
    HTP.prn( 'Begin. <hr>' );
    for i in 1 .. apex_application.g_f01.count 
    loop
        HTP.prn( 'Loop - '||i );
        s1 := apex_application.g_f01(i);
        s2 := apex_application.g_f02(i);
        s3 := apex_application.g_f03(i);
        s4 := apex_application.g_f04(i);
        sys.htp.prn(
        s1 ||' -- ' || 
        s2 ||' -- ' ||
        s3 ||' -- ' ||
        s4
        );
    end loop;
    HTP.prn( 'End. <hr>' );
    HTP.prn(apex_item.text( p_idx=> 5 , p_value=> null , p_attributes=> 'class="number"', p_item_label => 'ID'))
end;


sys.htp.p('<div class="lp-Question-inputCheckbox">');

if :p9_how_many is not null and :p9_how_many > 0 then
if not apex_collection.collection_exists (p_collection_name => 'CHILDREN') then
apex_collection.create_or_truncate_collection(
          p_collection_name => 'CHILDREN'); 
end if;
apex_collection.add_members(
p_collection_name => 'CHILDREN',
p_c001 => apex_application.g_f01,
p_c002 => apex_application.g_f03,
p_c003 => apex_application.g_f04,
p_c004 => apex_application.g_f02 
);
end if;

select seq_id editlink,
    seq_id ID,
    c001 Name, 
    c002 Gender, 
    c003 School, 
    c004 AGE
from apex_collections
where collection_name = 'CHILDREN';


APEX_COLLECTION.ADD_MEMBER (
    p_collection_name => 'CHILDREN',
    p_c001 => :P11_CHILD_NAME,
    p_c002 => :P11_GENDER,
    p_c003 => :P11_SCHOOL,
    p_c004 => :P11_AGE
);


APEX_COLLECTION.UPDATE_MEMBER (
    p_collection_name => 'CHILDREN',
    p_seq => :P11_CHILD_ID,
    p_c001 => :P11_CHILD_NAME,
    p_c002 => :P11_GENDER,
    P_c003 => :P11_SCHOOL,
    P_c004 => :P11_AGE
);


APEX_COLLECTION.DELETE_MEMBER (
    p_collection_name => 'CHILDREN',
    p_seq =>  :P11_CHILD_ID);

APEX_COLLECTION.DELETE_COLLECTION (
    p_collection_name => 'CHILDREN');



CREATE TABLE mqt_question (
    id                      NUMBER NOT NULL,
    question_set_id         NUMBER,
    section_id              NUMBER,
    display_sequence        NUMBER,
    question                VARCHAR2(4000 BYTE) NOT NULL,
    question_type           VARCHAR2(30 BYTE) NOT NULL,
    mandatory_yn            VARCHAR2(1 BYTE) NOT NULL,
    publish_yn              VARCHAR2(1 BYTE) NOT NULL,
    allow_comments_yn       VARCHAR2(1 BYTE) NOT NULL,
    use_custom_answers_yn   VARCHAR2(1 BYTE) NOT NULL,
    image_filename          VARCHAR2(4000 BYTE),
    image_mimetype          VARCHAR2(512 BYTE),
    image_charset           VARCHAR2(512 BYTE),
    image_blob              BLOB,
    image_last_updated      DATE,
    image_width             NUMBER,
    image_height            NUMBER,
    answer_01               VARCHAR2(4000 BYTE),
    answer_02               VARCHAR2(4000 BYTE),
    answer_03               VARCHAR2(4000 BYTE),
    answer_04               VARCHAR2(4000 BYTE),
    answer_05               VARCHAR2(4000 BYTE),
    answer_06               VARCHAR2(4000 BYTE),
    answer_07               VARCHAR2(4000 BYTE),
    answer_08               VARCHAR2(4000 BYTE),
    answer_09               VARCHAR2(4000 BYTE),
    answer_10               VARCHAR2(4000 BYTE),
    answer_11               VARCHAR2(4000 BYTE),
    answer_12               VARCHAR2(4000 BYTE),
    correct_answer          VARCHAR2(4000 BYTE),
    enable_score_yn         VARCHAR2(1 BYTE) NOT NULL,
    answer_01_score         NUMBER,
    answer_02_score         NUMBER,
    answer_03_score         NUMBER,
    answer_04_score         NUMBER,
    answer_05_score         NUMBER,
    answer_06_score         NUMBER,
    answer_07_score         NUMBER,
    answer_08_score         NUMBER,
    answer_09_score         NUMBER,
    answer_10_score         NUMBER,
    answer_11_score         NUMBER,
    answer_12_score         NUMBER,
    max_mc_answers          NUMBER,
    row_version_number      NUMBER NOT NULL,
    row_key                 VARCHAR2(30 BYTE),
    created_by              VARCHAR2(255 BYTE),
    created                 TIMESTAMP WITH LOCAL TIME ZONE,
    updated_by              VARCHAR2(255 BYTE),
    updated                 TIMESTAMP WITH LOCAL TIME ZONE
);

-- ALTER TABLE mqt_question
--     ADD CONSTRAINT mqt_question_cc1 CHECK ( mandatory_yn IN (
--         'N',
--         'Y'
--     ) );

-- ALTER TABLE mqt_question
--     ADD CONSTRAINT mqt_question_cc2 CHECK ( publish_yn IN (
--         'N',
--         'Y'
--     ) );

-- ALTER TABLE mqt_question
--     ADD CONSTRAINT mqt_question_cc3 CHECK ( allow_comments_yn IN (
--         'N',
--         'Y'
--     ) );

-- ALTER TABLE mqt_question
--     ADD CONSTRAINT mqt_question_cc4 CHECK ( use_custom_answers_yn IN (
--         'N',
--         'Y'
--     ) );

-- ALTER TABLE mqt_question
--     ADD CONSTRAINT mqt_question_cc5 CHECK ( enable_score_yn IN (
--         'N',
--         'Y'
--     ) );

-- CREATE INDEX webapps_owner.mqt_question_01 ON
--     mqt_question (
--         question_set_id
--     ASC );

-- CREATE UNIQUE INDEX webapps_owner.eba_livepoll_q_pk ON
--     mqt_question (
--         id
--     ASC );

-- ALTER TABLE mqt_question ADD CONSTRAINT eba_livepoll_q_pk PRIMARY KEY ( id );

-- ALTER TABLE mqt_question
--     ADD CONSTRAINT eba_livepoll_q_fk FOREIGN KEY ( question_set_id )
--         REFERENCES eba_livepoll_question_sets ( id )
--             ON DELETE CASCADE;

-- ALTER TABLE mqt_question
--     ADD CONSTRAINT eba_livepoll_q2_fk FOREIGN KEY ( section_id )
--         REFERENCES eba_livepoll_sections ( id )
--             ON DELETE SET NULL;


