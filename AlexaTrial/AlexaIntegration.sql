drop table w_io_web_ord_hdr
/

create table w_io_web_ord_hdr
(
   event_id              NUMBER(27),
   event_uuid            VARCHAR2(36),
   event_type            VARCHAR2(20),
   order_number          VARCHAR2(25),
   consignment_code      VARCHAR2(50),
   shipping_status       VARCHAR2(20),
   carrier_service_type  VARCHAR2(40),
   original_event_id     NUMBER,
   created_dtm           DATE,
   processed_dtm         DATE,
   submit_count          NUMBER(3),
   io_error_id           VARCHAR2(12),
   io_error_descr        VARCHAR2(4000),
   req_json              CLOB,
   resp_json             CLOB
)
/

ALTER TABLE  w_io_web_ord_hdr
ADD (
    CONSTRAINT  w_io_web_ord_hdr_pk
    PRIMARY KEY  (event_id)
  )
 /

drop table w_io_web_ord_item
/

create table w_io_web_ord_item
(
   event_id            NUMBER(27),
   item_number         NUMBER(10),
   item_seq            NUMBER(10),
   sku_id              VARCHAR2(15),
   return_code         VARCHAR2(4),
   reason_code         VARCHAR2(10),
   created_dtm         DATE
)
/

create sequence tst_web_order_event_id_seq increment by -1;

create or replace function get_seq_id
return number
is
begin
return tst_web_order_event_id_seq.nextval;
end;
/

INSERT ALL
INTO w_io_web_ord_hdr
(
    event_id
    ,event_uuid
    ,event_type
    ,order_number
    ,consignment_code
    ,shipping_status
    ,carrier_service_type
    ,original_event_id
    ,created_dtm
    ,processed_dtm
    ,submit_count
    ,io_error_id
    ,io_error_descr
    ,req_json
    ,resp_json
)
VALUES
(
    event_id
    ,event_uuid
    ,event_type
    ,order_number
    ,consignment_code
    ,shipping_status
    ,carrier_service_type
    ,original_event_id
    ,created_dtm
    ,processed_dtm
    ,submit_count
    ,io_error_id
    ,io_error_descr
    ,req_json
    ,resp_json
)
into w_io_web_ord_item
(
    event_id
    ,item_number
    ,item_seq
    ,sku_id
    ,return_code
    ,reason_code
    ,created_dtm
)
VALUES
(
    event_id
    ,item_number
    ,item_seq
    ,sku_id
    ,return_code
    ,reason_code
    ,created_dtm
)
select
    rn event_id
    ,regexp_replace(
                rawtohex(sys_guid()),
                '([A-F0-9]{8})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{12})',
                '\1-\2-\3-\4-\5'
            ) event_uuid
    ,DECODE(
        ABS(MOD(rn,5)),
        1,'cancel',
        2,'dispatch',
        3,'dispatch',
        4,'dispatch',
        'return')  event_type
    ,rn  order_number
    ,rn  consignment_code
    ,DECODE(
        ABS(MOD(rn,5)),
        1,'SHORT_SHIPPED',
        2,'SHIPPED',
        3,'SHIPPED',
        4,'SHIPPED',
        'RETURNED')  shipping_status
    ,'DPD' carrier_service_type
    ,null original_event_id
    ,sysdate created_dtm
    ,null  processed_dtm
    ,null  submit_count
    ,null  io_error_id
    ,null  io_error_descr
    ,NULL  req_json
    ,NULL  resp_json
    --
    ,1          item_number
    ,1          item_seq
    ,abs(mod(rn,1000)) sku_id
    ,abs(mod(rn,5))   return_code
    ,abs(mod(rn,5))   reason_code
from dual,
    (
    SELECT
        get_seq_id rn
    FROM dual
    connect by rownum <=10
    ) tmp;

commit;

/*
create table alexa_orders
 (
  alo_id      raw(16) default sys_guid() primary key,
  alo_name    varchar2(4000),
  alo_qty     number,
  alo_value   number,
  alo_date    date,
  alo_status  varchar2(1024),
  alo_ship_date date
 );

insert into alexa_orders ( alo_name, alo_qty , alo_value , alo_date, alo_status, alo_ship_date)
values ('Pizza Pepperoni', round(dbms_random.value(1,10),0), round(dbms_random.value(5,1000),2), sysdate-dbms_random.value(1,3),'In progress',sysdate+((1/1440)*dbms_random.value(1,120)));

insert into alexa_orders ( alo_name, alo_qty , alo_value , alo_date, alo_status, alo_ship_date)
values ('Pizza Margarita',round(dbms_random.value(1,10),0), round(dbms_random.value(5,1000),2), sysdate-dbms_random.value(1,3),'Prepared raw',sysdate+(1/1440)*dbms_random.value(1,120));

insert into alexa_orders ( alo_name, alo_qty , alo_value , alo_date, alo_status, alo_ship_date)
values ('Pizza Diabolo',round(dbms_random.value(1,10),0), round(dbms_random.value(5,1000),2), sysdate-dbms_random.value(1,3),'Completed',sysdate+(1/1440)*dbms_random.value(1,120));

insert into alexa_orders ( alo_name, alo_qty , alo_value , alo_date, alo_status, alo_ship_date)
values ('Pizza Pepperoni',round(dbms_random.value(1,10),0), round(dbms_random.value(5,1000),2), sysdate-dbms_random.value(1,3),'Delivered',sysdate+(1/1440)*dbms_random.value(1,120));

insert into alexa_orders ( alo_name, alo_qty , alo_value , alo_date, alo_status, alo_ship_date)
values ('Pizza Diabolo',round(dbms_random.value(1,10),0), round(dbms_random.value(5,1000),2), sysdate-dbms_random.value(1,3),'Delivered',sysdate+(1/1440)*dbms_random.value(1,120));

commit;
*/

create or replace package alexa_trial is

    procedure parse_alexa_skill (
        p_body in blob
    );

end alexa_trial;
/

create or replace package body alexa_trial as

    C_scope_prefix  varchar2(100) := LOWER($$plsql_unit) || '.';

    function blob_to_clob (
        p_data  in  blob)
    return clob
    as
    l_clob         clob;
    l_dest_offset  pls_integer := 1;
    l_src_offset   pls_integer := 1;
    l_lang_context pls_integer := dbms_lob.default_lang_ctx;
    l_warning      pls_integer;
    begin

    dbms_lob.createtemporary(
        lob_loc => l_clob,
        cache   => true);

    dbms_lob.converttoclob(
        dest_lob      => l_clob,
        src_blob      => p_data,
        amount        => dbms_lob.lobmaxsize,
        dest_offset   => l_dest_offset,
        src_offset    => l_src_offset,
        blob_csid     => dbms_lob.default_csid,
        lang_context  => l_lang_context,
        warning       => l_warning);

    return l_clob;
    end blob_to_clob;
    --
    --
    --
    function say_date (p_date in date)
    return varchar2
    is
    begin

        if p_date is null then
            return null;
        else
            return trim(to_char(p_date,'Day'))||'. ????'||trim(to_char(p_date,'MMDD'))||'';
        end if;

    end say_date;
    --
    --
    --
    function alexa_answer (
        p_voice_message in varchar2,
        p_card_title    in varchar2 default 'ALEXATRIAL',
        p_card_content  in varchar2 default 'OMS orders information')
    return varchar2
    is
        l_message varchar2(32000);
        l_scope   varchar2(100) := C_scope_prefix||'parse_alexa_skill';
    begin

    l_message := '
        {
        "version": "1.0",
        "sessionAttributes": {},
        "response": {
            "outputSpeech": {
            "type": "SSML",
            "ssml": "'||p_voice_message||'"
                            },
            "card": {
            "type": "Simple",
            "title": "'||p_card_title||'",
            "content": "'||p_card_content||'"
            },

            "shouldEndSession": true
        }
        }
        ';

    logger.log_info (
        p_text   => 'l_message',
        p_scope  => L_scope,
        p_extra  => l_message);

    return l_message;
    end alexa_answer;
    --
    --
    --
    procedure message_howmanyorders(
        p_values        in apex_json.t_values,
        p_json_count    in number,
        p_voice_message in out varchar2,
        p_card_title    in out varchar2,
        p_card_content  in out varchar2)
    is

        l_slots_name varchar2(4000);
        l_slot_value varchar2(4000);
        l_return_howmanyorders number;
    begin

        for x in 1.. p_json_count
        loop

        l_slots_name :=
            apex_json.get_members(
                p_path=>'request.intent.slots',
                p_values=>p_values)(x) ;

        l_slot_value := 
            apex_json.get_varchar2(
                p_path=>'request.intent.slots.'||l_slots_name||'.value',
                p0=>x,
                p_values=>p_values);
        -- Default
        p_voice_message := 'Web order event count is '||l_return_howmanyorders;

        if l_slot_value is not null then

            if  regexp_count(l_slot_value, '-') = 2 then 
                --ex. today, now, tomorrow, november twenty-fifth, next monday, right now
                select count(*) 
                into l_return_howmanyorders 
                from w_io_web_ord_hdr 
                where trunc(created_dtm,'DD') = to_date(l_slot_value,'YYYY-MM-DD');
            elsif regexp_count(l_slot_value, '-')=1 and regexp_count(l_slot_value, 'W') = 0 then 
                --this month, last month
                select count(*) 
                into l_return_howmanyorders 
                from w_io_web_ord_hdr 
                where to_char(trunc(created_dtm,'DD'),'YYYY-MM') =  l_slot_value;
            elsif regexp_count(l_slot_value, '-')=1 and regexp_count(l_slot_value, 'W')= 1 then 
                  --ex. this week, next week
                select count(*) 
                into l_return_howmanyorders 
                from w_io_web_ord_hdr 
                where to_char(trunc(created_dtm,'DD'),'YYYY-"W"IW') =  l_slot_value;
            elsif regexp_count(l_slot_value, '-')=0 then 
                --ex. this yesr, last year
                select count(*) 
                into l_return_howmanyorders 
                from w_io_web_ord_hdr 
                where to_char(created_dtm,'YYYY') =  l_slot_value;
            elsif regexp_count(l_slot_value, '-')=1 and regexp_count(l_slot_value, 'W')= 0 then 
                 --this month, last month
                    null;
            end if;
            p_voice_message := 'Web order event count is '||l_return_howmanyorders;
        else
            p_voice_message := 'Please say again';
        end if;
    end loop;

    p_card_content  := p_voice_message;

    end message_howmanyorders;

    procedure parse_alexa_skill (p_body in blob)
    is
        l_body_clob     clob;
        l_values        apex_json.t_values;
        l_intent_name   varchar2(4000);
        l_json_count    number;
        l_voice_message varchar2(4000);
        l_card_title    varchar2(4000);
        l_card_content  varchar2(4000);
        l_scope         varchar2(100) := C_scope_prefix||'parse_alexa_skill';
    begin

    --transfer blob to clob
    l_body_clob := blob_to_clob (p_data => p_body);
/*
    logger.log_info (
        p_text   => 'converted colb value',
        p_scope  => L_scope,
        p_extra  => l_body_clob);
*/
    --Parse clob to json object
    apex_json.parse(l_values,l_body_clob);

    l_intent_name := apex_json.get_varchar2(p_path=>'request.intent.name',p0=>1,p_values=>l_values);

    --Check how many rows in json object
    l_json_count := nvl(apex_json.get_count(
        p_path      => 'request.intent.slots',
        p_values    => l_values
        ), 0);
/*
    logger.log_info (
        p_text   => 'l_json_count='||l_json_count,
        p_scope  => L_scope);
*/
    if l_intent_name in ('howmanyorders') then
        message_howmanyorders(
            p_values        =>  l_values,
            p_json_count    =>  l_json_count,
            p_voice_message =>  l_voice_message,
            p_card_title    =>  l_card_title,
            p_card_content  =>  l_card_content);

        htp.p(alexa_answer (
            p_voice_message =>  l_voice_message,
            p_card_title    =>  l_card_title,
            p_card_content  =>  l_card_content));

    end if;
/*
    exception 
        when others then
        logger.log_error (
            p_text   => 'parse_alexa_skillfailure',
            p_scope  => L_scope);
*/
    end parse_alexa_skill;

END alexa_trial;

BLOB_TO_CLOB function - Used to convert http response to readable clob
SAY_DATE function - Returning date in Alexa format (very specific)
ALEXA_ANSWER function - Used to prepare ALEXA JSON message
MESSAGE_HOWMANYORDERS procedure - Preparing information from ALEXA_ORDERS table (in Oracle)
PARSE_ALEXA_SKILL procedure - Used as a main API. It will be used by RESTService

DECLARE
    l_scope               varchar2(50) := 'create_ords_rest_service_aps.sql';
    l_module_name         varchar2(50) := 'aps.v1';
    L_module_base_path    varchar2(50) := 'aps/v1/';
    l_template_pattern    varchar2(50) := 'alexa';
    l_handler_get_source  varchar2(4000) := 'select * from w_io_web_ord_hdr';
    l_handler_post_source varchar2(4000) :=
    q'[
    begin
        alexa_trial.parse_alexa_skill (p_body => :body);
        :http_status := 200;
    end;
    ]';

BEGIN

    ords.define_module(
        p_module_name    => l_module_name,
        p_base_path      => l_module_base_path,
        p_status         => 'PUBLISHED',
        p_comments       => 'API Module for restful service : aps'
    );


    ords.define_template(
        p_module_name => l_module_name,
        p_pattern     => l_template_pattern,
        p_comments    => 'Resource Template for restful service: aps'
    );

    ords.define_handler(
        p_module_name    => l_module_name,
        p_pattern        => l_template_pattern,
        p_method         => 'POST',
        p_source_type    => ords.source_type_plsql,
        p_source         => l_handler_post_source,
        p_comments       => 'Handler for restful service : aps'
    );

	ords.define_parameter(
		p_module_name        => l_module_name,
		p_pattern            => l_template_pattern,
		p_method             => 'POST',
		p_name               => 'X-APEX-STATUS-CODE',
		p_bind_variable_name => 'http_status',
		p_source_type        => 'HEADER',
		p_param_type         => 'INT',
		p_access_method      => 'OUT',
		p_comments           => 'HTTP Response status'
    );

    ords.define_handler(
        p_module_name    => l_module_name,
        p_pattern        => l_template_pattern,
        p_method         => 'GET',
        p_source_type    => ords.source_type_collection_feed,
        p_source         => l_handler_get_source,
        p_comments       => 'Handler for restful service : aps'
    );

END;
/

SHOW ERR;

https://apexutil.blogspot.com/2018/03/oracle-apex-amazon-alexa-integration_28.html

https://apex.oracle.com/pls/apex/sarojws/aps/v1/alexa

https://apex.oracle.com/pls/apex/sarojws/aps/v1/alexa

http://ords-alb.dev.transit.ri-tech.io/ords/omsdev/itsr/aps/v1/alexa

https://developer.amazon.com/docs/custom-skills/request-and-response-json-reference.html#response-object

https://jordankasper.com/building-an-amazon-alexa-skill-with-node-js/

https://alexa.amazon.com/spa/index.html#help/thingstotry

https://www.amazon.com/gp/help/customer/display.html/ref=hp_left_v4_sib?ie=UTF8&nodeId=202039610&tag=aftvn-20

alexa ask system how many orders

{
	"version": "1.0",
	"session": {
		"new": true,
		"sessionId": "amzn1.echo-api.session.fcf4437f-222e-433b-b083-f8ff846b94c4",
		"application": {
			"applicationId": "amzn1.ask.skill.f6c77143-f4fa-45be-b233-87d1b3241415"
		},
		"user": {
			"userId": "amzn1.ask.account.AE5UOF6J2UR64WKC6XJAA4R5O2U2HD5BKS7QFP3ZC36AFA2T4HTJ2LKJLIHQMWZC5APV6GDUVI4XAEYOVOAQHJDU2YS3SFYWW55UTYIEM26HRCFYZMQHLEEMLJUUIPZVCD45CPA7CAG4IYXILKCXOWDBM5BJBD5UJ53MEFW5PYXCG63ECVUTM7DETWJRRZ7J4MYSP3MEBINZEOA"
		}
	},
	"context": {
		"System": {
			"application": {
				"applicationId": "amzn1.ask.skill.f6c77143-f4fa-45be-b233-87d1b3241415"
			},
			"user": {
				"userId": "amzn1.ask.account.AE5UOF6J2UR64WKC6XJAA4R5O2U2HD5BKS7QFP3ZC36AFA2T4HTJ2LKJLIHQMWZC5APV6GDUVI4XAEYOVOAQHJDU2YS3SFYWW55UTYIEM26HRCFYZMQHLEEMLJUUIPZVCD45CPA7CAG4IYXILKCXOWDBM5BJBD5UJ53MEFW5PYXCG63ECVUTM7DETWJRRZ7J4MYSP3MEBINZEOA"
			},
			"device": {
				"deviceId": "amzn1.ask.device.AHFVTHGAYAAHKF2KZOVBNVLXDZITP23GZGRF62UQ6BOMIFLN7UEI325JAD2LAFALB477YSDWBYAQVXGKXNYWQCYPTPKR472SCNY4ILWZSS2Y7L7MIMU3ZCVR3LY3WEON7UIK7HZHPTVRVC4PBCXDRIMECG4ICXKTEIP3VDRYE6MKONLMYC3EE",
				"supportedInterfaces": {}
			},
			"apiEndpoint": "https://api.amazonalexa.com",
			"apiAccessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJhdWQiOiJodHRwczovL2FwaS5hbWF6b25hbGV4YS5jb20iLCJpc3MiOiJBbGV4YVNraWxsS2l0Iiwic3ViIjoiYW16bjEuYXNrLnNraWxsLmY2Yzc3MTQzLWY0ZmEtNDViZS1iMjMzLTg3ZDFiMzI0MTQxNSIsImV4cCI6MTUyOTk2NTM5MSwiaWF0IjoxNTI5OTYxNzkxLCJuYmYiOjE1Mjk5NjE3OTEsInByaXZhdGVDbGFpbXMiOnsiY29uc2VudFRva2VuIjpudWxsLCJkZXZpY2VJZCI6ImFtem4xLmFzay5kZXZpY2UuQUhGVlRIR0FZQUFIS0YyS1pPVkJOVkxYRFpJVFAyM0daR1JGNjJVUTZCT01JRkxON1VFSTMyNUpBRDJMQUZBTEI0NzdZU0RXQllBUVZYR0tYTllXUUNZUFRQS1I0NzJTQ05ZNElMV1pTUzJZN0w3TUlNVTNaQ1ZSM0xZM1dFT043VUlLN0haSFBUVlJWQzRQQkNYRFJJTUVDRzRJQ1hLVEVJUDNWRFJZRTZNS09OTE1ZQzNFRSIsInVzZXJJZCI6ImFtem4xLmFzay5hY2NvdW50LkFFNVVPRjZKMlVSNjRXS0M2WEpBQTRSNU8yVTJIRDVCS1M3UUZQM1pDMzZBRkEyVDRIVEoyTEtKTElIUU1XWkM1QVBWNkdEVVZJNFhBRVlPVk9BUUhKRFUyWVMzU0ZZV1c1NVVUWUlFTTI2SFJDRllaTVFITEVFTUxKVVVJUFpWQ0Q0NUNQQTdDQUc0SVlYSUxLQ1hPV0RCTTVCSkJENVVKNTNNRUZXNVBZWENHNjNFQ1ZVVE03REVUV0pSUlo3SjRNWVNQM01FQklOWkVPQSJ9fQ.B7QS0_bBmZ6hH4eEbCBCk7gnyxage2nBmnk_gzuZgI9yAKnnKTi2ljoKvaYB0Ltle9u5a0bAjINGcdNbOiuN48dDki2sTdd83qLBhCMUZZwClyRVFFlyOT2tRHsSDLGdJq4pom3I3pQKS9n09AXdKTXxxtlx2QAPYmTrCeeIDaXxJtlLMgzoiv35rQifqZWcjpiCMTusxzV0IF1jKaFssEZeqneezhpLMrWXEpVDJIKfql1FfAR8C64lttddgrdGIGwMEoElV_JU98l-SA7yoYYrCgIEgRGm_bfAgISleOcginvSVVVl8Q-M2ju5Bq8UxZOA_KCjMZ7OBP5pIU6QHA"
		}
	},
	"request": {
		"type": "IntentRequest",
		"requestId": "amzn1.echo-api.request.868672b5-65d6-40b7-ac8c-8dc3b66555ee",
		"timestamp": "2018-06-25T21:23:11Z",
		"locale": "en-GB",
		"intent": {
			"name": "howmanyorders",
			"confirmationStatus": "NONE"
		}
	}
}

request : A request object that provides the details of the users request. There are several different request types avilable, see:

Standard Requests:
    CanFulfillIntentRequest
    LaunchRequest
    IntentRequest
    SessionEndedRequest
AudioPlayer Requests
PlaybackController Requests
Display.ElementSelected Requests
GadgetController Requests
GameEngine Requests
object

Response Body Syntax

{
  "version": "string",
  "sessionAttributes": {
    "key": "value"
  },
  "response": {
    "outputSpeech": {
      "type": "PlainText",
      "text": "Plain text string to speak",
      "ssml": "<speak>SSML text string to speak</speak>"
    },
    "card": {
      "type": "Standard",
      "title": "Title of the card",
      "content": "Content of a simple card",
      "text": "Text content for a standard card",
      "image": {
        "smallImageUrl": "https://url-to-small-card-image...",
        "largeImageUrl": "https://url-to-large-card-image..."
      }
    },
    "reprompt": {
      "outputSpeech": {
        "type": "PlainText",
        "text": "Plain text string to speak",
        "ssml": "<speak>SSML text string to speak</speak>"
      }
    },
    "directives": [
      {
        "type": "InterfaceName.Directive"
        (...properties depend on the directive type)
      }
    ],
    "shouldEndSession": true
  }
}

{
	"body": {
		"version": "1.0",
		"response": {
			"outputSpeech": {
				"type": "SSML",
				"ssml": "<speak>Count of orders is 128</speak>"
			},
			"card": {
				"type": "Simple",
				"title": "Count of orders is 128",
				"content": "Count of orders is 128"
			},
			"shouldEndSession": true
		},
		"sessionAttributes": {}
	}
}


{ "type": "Dialog.Delegate", "updatedIntent": { "name": "order_status", "confirmationStatus": "NONE", "slots": { "order_number": { "name": "order_number", "confirmationStatus": "NONE" } } } }


{ 
"version": "1.0", 
"sessionAttributes": {}, 
"response": { 
    "outputSpeech": { 
    "type": "SSML", 
    "ssml": "<speak>'||p_voice_message||'</speak>" 
                    }, 
    "card": { 
    "type": "Simple", 
    "title": "'||p_card_title||'", 
    "content": "'||p_card_content||'" 
    }, 

    "shouldEndSession": true 
} 
} 


A response object that defines what to render to the user and whether to end the current session.
outputSpeech : The object containing the speech to render to the user
card : The object containing a card to render to the Amazon Alexa App
reprompt : The object containing the outputSpeech to use if a re-prompt is necessary. This is used if the your service keeps the session open after sending the response, but the user does not respond with anything that maps to an intent defined in your voice interface while the audio stream is open. sIf this is not set, the user is not re-prompted.
shouldEndSession : A boolean value with true meaning that the session should end after Alexa speaks the response, or false if the session should remain active. If not provided, defaults to true.
OutputSpeech Object Object 
type : A string containing the type of output speech to render. Valid types are:
    "PlainText": Indicates that the output speech is defined as plain text.
    "SSML": Indicates that the output speech is text marked up with SSML.
text : A string containing the speech to render to the user. Use this when type is "PlainText"
ssml : A string containing text marked up with SSML to render to the user. Use this when type is  "SSML"

The first step in building a new skill is to decide what your skill will do.

Custom skill : You define the requests the skill can handle (intents) and the words users say to invoke those requests (utterances).

When designing and building a custom skill, you create the following:

A set of intents that represent actions that users can do with your skill. These intents represent the core functionality for your skill.
A set of sample utterances that specify the words and phrases users can say to invoke those intents. You map these utterances to your intents. This mapping forms the interaction model for the skill.
An invocation name that identifies the skill. The user includes this name when initiating a conversation with your skill.
A cloud-based service that accepts these intents as structured requests and then acts upon them. This service must be accessible over the Internet. You provide an endpoint for your service when configuring the skill.
A configuration that brings all of the above together so that Alexa can route requests to the service for your skill. You create this configuration in the developer console.

User: Alexa, get high tide for Seattle from Tide Pooler
(In this example, the italicized words form the sample utterance you have defined, while the invocation name is shown in bold).

For example, a skill for getting tide information might define an intent called OneshotTideIntent to 

Intent = OneshotTideIntent

This intent would be mapped to several sample utterances such as:

OneshotTideIntent get high tide
OneshotTideIntent get high tide for {City}
OneshotTideIntent tide information for {City}
OneshotTideIntent when is high tide in {City}
...
(many more sample utterances)

Step 1: Design a Voice User Interface
Create a flow diagram that maps out how users will interact with the skill. This flow diagram should show the requests users will make and the possible outcomes of those requests. Use the flow diagram to identify the user requests that your skill will handle. These will become intents.
Step 2: Set Up the Skill in the Developer Console
Step 3: Use the Voice Design to Build Your Interaction Model
The interaction model refers to your collection of intents, sample utterances, and the dialog model:

The requests your skill can handle are represented as intents.
Intents can optionally have arguments called slots.
Sample utterances map the intents to the words and phrases users can say to interact with your skill.
A dialog model identifies information your skill requires and the prompts Alexa can use to collect and confirm that information in a conversation with the user.
There are two different ways to create these components:
Use the developer console. This provides an updated console for the entire skill-building process, including the interaction model.
Create the JSON for the interaction model and create or update your skill with the Skill Management API or the ASK Command Line Interface.
Step 4: Write and Test the Code for Your Skill
Your primary coding task for your skill is to create a service that can accept requests from the Alexa service and send back responses.

The usability of the skill directly depends on how well the sample utterances and custom slot values represent real-world language use.
Building a representative set of custom values and sample utterances is an important process and one that requires iteration. During development and testing, try using many different phrases to invoke each intent. Given the flexibility and variation of spoken language in the real world, there will often be many different ways to express the same request. If you have requests that are full sentences, think about shortened ways that users might say them. Providing these different phrases in your sample utterances will help improve voice recognition for the abilities you add to Alexa. (though do not include samples that users will never speak)

Sample Utterances for Starting a Conversation

Tell me the total number of orders 
Give me the total number of orders
What is the total count of orders
Whats the total count of the orders 
Get me the me the total number of orders

Number of Sample Utterances
"what is…"
"what's…"
"tell me…"
"give…"
"give me…"
"get…"
"get me…"
"find…"
"find me…"

Recommendations for Custom Slot Type Values

{
  "version": "1.0",
  "session": {
    "new": true,
    "sessionId": "amzn1.echo-api.session.[unique-value-here]",
    "application": {
      "applicationId": "amzn1.ask.skill.[unique-value-here]"
    },
    "attributes": {
      "key": "string value"
    },
    "user": {
      "userId": "amzn1.ask.account.[unique-value-here]",
      "accessToken": "Atza|AAAAAAAA...",
      "permissions": {
        "consentToken": "ZZZZZZZ..."
      }
    }
  },
  "context": {
    "System": {
      "device": {
        "deviceId": "string",
        "supportedInterfaces": {
          "AudioPlayer": {}
        }
      },
      "application": {
        "applicationId": "amzn1.ask.skill.[unique-value-here]"
      },
      "user": {
        "userId": "amzn1.ask.account.[unique-value-here]",
        "accessToken": "Atza|AAAAAAAA...",
        "permissions": {
          "consentToken": "ZZZZZZZ..."
        }
      },
      "apiEndpoint": "https://api.amazonalexa.com",
      "apiAccessToken": "AxThk..."
    },
    "AudioPlayer": {
      "playerActivity": "PLAYING",
      "token": "audioplayer-token",
      "offsetInMilliseconds": 0
    }
  },
  "request": {}
}

alexa ask system orders in last one hour

{
	"version": "1.0",
	"session": {
		"new": true,
		"sessionId": "amzn1.echo-api.session.ebd4a1d0-eb45-4295-a7f1-57b12b611cb1",
		"application": {
			"applicationId": "amzn1.ask.skill.f6c77143-f4fa-45be-b233-87d1b3241415"
		},
		"user": {
			"userId": "amzn1.ask.account.AE5UOF6J2UR64WKC6XJAA4R5O2U2HD5BKS7QFP3ZC36AFA2T4HTJ2LKJLIHQMWZC5APV6GDUVI4XAEYOVOAQHJDU2YS3SFYWW55UTYIEM26HRCFYZMQHLEEMLJUUIPZVCD45CPA7CAG4IYXILKCXOWDBM5BJBD5UJ53MEFW5PYXCG63ECVUTM7DETWJRRZ7J4MYSP3MEBINZEOA"
		}
	},
	"context": {
		"System": {
			"application": {
				"applicationId": "amzn1.ask.skill.f6c77143-f4fa-45be-b233-87d1b3241415"
			},
			"user": {
				"userId": "amzn1.ask.account.AE5UOF6J2UR64WKC6XJAA4R5O2U2HD5BKS7QFP3ZC36AFA2T4HTJ2LKJLIHQMWZC5APV6GDUVI4XAEYOVOAQHJDU2YS3SFYWW55UTYIEM26HRCFYZMQHLEEMLJUUIPZVCD45CPA7CAG4IYXILKCXOWDBM5BJBD5UJ53MEFW5PYXCG63ECVUTM7DETWJRRZ7J4MYSP3MEBINZEOA"
			},
			"device": {
				"deviceId": "amzn1.ask.device.AHFVTHGAYAAHKF2KZOVBNVLXDZITP23GZGRF62UQ6BOMIFLN7UEI325JAD2LAFALB477YSDWBYAQVXGKXNYWQCYPTPKR472SCNY4ILWZSS2Y7L7MIMU3ZCVR3LY3WEON7UIK7HZHPTVRVC4PBCXDRIMECG4ICXKTEIP3VDRYE6MKONLMYC3EE",
				"supportedInterfaces": {}
			},
			"apiEndpoint": "https://api.amazonalexa.com",
			"apiAccessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJhdWQiOiJodHRwczovL2FwaS5hbWF6b25hbGV4YS5jb20iLCJpc3MiOiJBbGV4YVNraWxsS2l0Iiwic3ViIjoiYW16bjEuYXNrLnNraWxsLmY2Yzc3MTQzLWY0ZmEtNDViZS1iMjMzLTg3ZDFiMzI0MTQxNSIsImV4cCI6MTUzMDIyNjE5MSwiaWF0IjoxNTMwMjIyNTkxLCJuYmYiOjE1MzAyMjI1OTEsInByaXZhdGVDbGFpbXMiOnsiY29uc2VudFRva2VuIjpudWxsLCJkZXZpY2VJZCI6ImFtem4xLmFzay5kZXZpY2UuQUhGVlRIR0FZQUFIS0YyS1pPVkJOVkxYRFpJVFAyM0daR1JGNjJVUTZCT01JRkxON1VFSTMyNUpBRDJMQUZBTEI0NzdZU0RXQllBUVZYR0tYTllXUUNZUFRQS1I0NzJTQ05ZNElMV1pTUzJZN0w3TUlNVTNaQ1ZSM0xZM1dFT043VUlLN0haSFBUVlJWQzRQQkNYRFJJTUVDRzRJQ1hLVEVJUDNWRFJZRTZNS09OTE1ZQzNFRSIsInVzZXJJZCI6ImFtem4xLmFzay5hY2NvdW50LkFFNVVPRjZKMlVSNjRXS0M2WEpBQTRSNU8yVTJIRDVCS1M3UUZQM1pDMzZBRkEyVDRIVEoyTEtKTElIUU1XWkM1QVBWNkdEVVZJNFhBRVlPVk9BUUhKRFUyWVMzU0ZZV1c1NVVUWUlFTTI2SFJDRllaTVFITEVFTUxKVVVJUFpWQ0Q0NUNQQTdDQUc0SVlYSUxLQ1hPV0RCTTVCSkJENVVKNTNNRUZXNVBZWENHNjNFQ1ZVVE03REVUV0pSUlo3SjRNWVNQM01FQklOWkVPQSJ9fQ.XxY8pYgFszv7OpoIetPv9dKkNjxSyusGo0_zoYA9sNeFi-57ar8olpghH69RyTIqsgihKzrYZR2B7lf0h8zegmREStz3oEIBjV4Kz3SJs4_JVAYTx7gTHHB95Nqjj5DbD2sir-y2iI3j5dMBLigzcFZiaXX8rlEnTjJ9pFq4QAC5qoydcMmZtIL69H92h2hRuNo9rZE3HGmECEQXUdSdcgblNyiVYGamIql0Eo4kdVn0RMTpywocYMkuBQ0Z1zcJDMExVBLXUXt_OVHhCRiph_1rogCmrX2Gwdq52t6lq8E5skSa-HsxH5nzhT1otpeZPXYFj2BsyYrTk_t3H6nSJA"
		}
	},
	"request": {
		"type": "IntentRequest",
		"requestId": "amzn1.echo-api.request.417193f7-eadd-4b20-87c9-5377557b42ef",
		"timestamp": "2018-06-28T21:49:51Z",
		"locale": "en-GB",
		"intent": {
			"name": "howmanyorders",
			"confirmationStatus": "NONE",
			"slots": {
				"since_last_x_hour": {
					"name": "since_last_x_hour",
					"value": "1",
					"confirmationStatus": "NONE"
				}
			}
		}
	}
}

request.intent.slots.since_last_x_hour.value

alexa ask system order events




with temp as 
(
    select 
'{
    "version": "1.0",
    "session": {
        "new": true,
        "sessionId": "amzn1.echo-api.session.d9c81762-8faa-4d8e-b452-aa37a5f9e0c5",
        "application": {
            "applicationId": "amzn1.ask.skill.f6c77143-f4fa-45be-b233-87d1b3241415"
        },
        "user": {
            "userId": "amzn1.ask.account.AE5UOF6J2UR6"
        }
    },
    "context": {
        "System": {
            "application": {
                "applicationId": "amzn1.ask.skill.f6c77143-f4fa-45be-b233-87d1b3241415"
            },
            "user": {
                "userId": "amzn1.ask.account.AE5UOF6J2UR6"
            },
            "device": {
                "deviceId": "amzn1.ask.device.AHFVTHGAYAAHKF2KZO",
                "supportedInterfaces": {}
            },
            "apiEndpoint": "https://api.amazonalexa.com",
            "apiAccessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjEifQ.eyJhdWQiOi"
        }
    },
    "request": {
        "type": "IntentRequest",
        "requestId": "amzn1.echo-api.request.8bee231b-9c3b-48de-ae49-a85632cd0d9a",
        "timestamp": "2018-06-28T19:15:38Z",
        "locale": "en-GB",
        "intent": {
            "name": "howmanyorders",
            "confirmationStatus": "NONE",
			"slots": {
				"since_last_x_hour": {
					"name": "since_last_x_hour",
					"value": "1",
					"confirmationStatus": "NONE"
				}
			}
            }
        }
    }
}' json_data
from dual
)
select 
    D.*
from temp p,
JSON_TABLE(
    p.json_data ,
    '$'
    columns (
        intent_name        varchar2(100)   path '$.request.intent.name',
        slot_last_x_hour   number          path '$.request.intent.slots.since_last_x_hour.value',
        slot_order_count   number          path '$.request.intent.slots.count.value'
    )
) D
/


https://developer.amazon.com/docs/custom-skills/understanding-custom-skills.html

https://www.youtube.com/watch?v=B93QezwTQpI

https://developer.amazon.com/docs/custom-skills/request-and-response-json-reference.html

https://beta.echosim.io/embed/welcome

Tell me the total number of orders from core system
Give me the total number of orders from core system
ask core system about the total number of orders
What is the total count of orders in core system
get total order count from core system
get total order count in last 1 hour from system
get total order count in last 10 hour from system
Get total event count from system
get total despatch count from system
get total cancel event count 
get total return count 

Ask system

Orders 
despatches
cancels
returns

Total * 
Total * in last x hour

ask core system 
get from core system 

<some action> <connecting word> <invocation name>
give me my Taurus horoscope using Daily Horoscopes.
tell me the horoscope for Taurus from Daily Horoscopes.
Ask Daily Horoscopes to give me the horoscope for Taurus.
Ask Daily Horoscopes about Taurus
Ask Daily Horoscopes for Taurus
Tell scorekeeper to give ten points to Stephen
Tell scorekeeper that Stephen has ten points.

Search Daily Horoscopes for Taurus
Load Daily Horoscopes and give me the horoscope for Taurus

Noun utterances ("the horoscope for…")
Verb utterances ("give me the horoscope for…")
Question utterances ("what is the horoscope for…")

create or replace package alexa_trial_v1 is 
 
    procedure parse_alexa_skill ( 
        p_body in blob 
    ); 
 
end alexa_trial_v1;

create or replace package body alexa_trial_v1 as 
 
    C_scope_prefix  varchar2(100) := LOWER($$plsql_unit) || '.'; 
 
    function blob_to_clob ( 
        p_data  in  blob) 
    return clob 
    as 
    l_clob         clob; 
    l_dest_offset  pls_integer := 1; 
    l_src_offset   pls_integer := 1; 
    l_lang_context pls_integer := dbms_lob.default_lang_ctx; 
    l_warning      pls_integer; 
    begin 
 
    dbms_lob.createtemporary( 
        lob_loc => l_clob, 
        cache   => true); 
 
    dbms_lob.converttoclob( 
        dest_lob      => l_clob, 
        src_blob      => p_data, 
        amount        => dbms_lob.lobmaxsize, 
        dest_offset   => l_dest_offset, 
        src_offset    => l_src_offset, 
        blob_csid     => dbms_lob.default_csid, 
        lang_context  => l_lang_context, 
        warning       => l_warning); 
 
    return l_clob; 
    end blob_to_clob; 
    -- 
    -- 
    -- 
    function say_date (p_date in date) 
    return varchar2 
    is 
    begin 
 
        if p_date is null then 
            return null; 
        else 
            return trim(to_char(p_date,'Day'))||'. ????'||trim(to_char(p_date,'MMDD'))||''; 
        end if; 
 
    end say_date; 
    -- 
    -- 
    -- 
    function alexa_answer ( 
        p_voice_message in varchar2, 
        p_card_title    in varchar2 default 'ALEXATRIAL', 
        p_card_content  in varchar2 default 'OMS orders information') 
    return varchar2 
    is 
        l_message varchar2(32000); 
        l_scope   varchar2(100) := C_scope_prefix||'parse_alexa_skill'; 
    begin 
 
    l_message := ' 
{ 
"version": "1.0", 
"sessionAttributes": {}, 
"response": { 
    "outputSpeech": { 
    "type": "SSML", 
    "ssml": "<speak>'||p_voice_message||'</speak>" 
                    }, 
    "card": { 
    "type": "Simple", 
    "title": "'||p_card_title||'", 
    "content": "'||p_card_content||'" 
    }, 

    "shouldEndSession": true 
} 
} 
        '; 
/* 
    logger.log_info ( 
        p_text   => 'l_message', 
        p_scope  => L_scope, 
        p_extra  => l_message); 
*/ 
 
    return l_message; 
    end alexa_answer; 
    -- 
    -- 
    -- 

    procedure parse_alexa_skill (p_body in blob) 
    is 
        l_body_clob     clob; 
        l_values        apex_json.t_values; 
        l_intent_name   varchar2(4000); 
        l_count         number;
        l_since_last_x_hour number;
        l_voice_message varchar2(4000); 
        l_card_title    varchar2(4000); 
        l_card_content  varchar2(4000); 
        l_scope         varchar2(100) := C_scope_prefix||'parse_alexa_skill'; 
    begin 
 
    --transfer blob to clob 
    l_body_clob := blob_to_clob (p_data => p_body); 
/* 
    logger.log_info ( 
        p_text   => 'converted colb value', 
        p_scope  => L_scope, 
        p_extra  => l_body_clob); 
*/ 
    --Parse clob to json object 
    apex_json.parse(l_values,l_body_clob); 
 
    l_intent_name := apex_json.get_varchar2(p_path=>'request.intent.name', p_values=>l_values); 
    l_since_last_x_hour := apex_json.get_varchar2(p_path=>'request.intent.slots.since_last_x_hour.value', p_values=>l_values);
 
    if l_intent_name = 'orders' 
    then
        select count(*)  
        into l_count  
        from w_io_web_ord_hdr  
        where created_dtm  >= created_dtm - NVL(l_since_last_x_hour,0); 

    elsif l_intent_name = 'dispatches' 
    then
        select count(*)  
        into l_count  
        from w_io_web_ord_hdr  
        where created_dtm  >= created_dtm - NVL(l_since_last_x_hour,0)
        and event_type='dispatch'; 
    elsif l_intent_name = 'cancels' 
    then
        select count(*)  
        into l_count  
        from w_io_web_ord_hdr  
        where created_dtm  >= created_dtm - NVL(l_since_last_x_hour,0)
        and event_type='cancel'; 
    elsif l_intent_name = 'returns' 
    then
        select count(*)  
        into l_count  
        from w_io_web_ord_hdr  
        where created_dtm  >= created_dtm - NVL(l_since_last_x_hour,0)
        and event_type='return'; 
    else 
        l_count := null;
    end if;

    l_voice_message := 'Count of '||l_intent_name|| 'is '||nvl(to_char(l_count),'Unknown');
/* 
    logger.log_info ( 
        p_text   => 'l_json_count='||l_json_count, 
        p_scope  => L_scope); 
*/ 
 
    htp.p(alexa_answer ( 
        p_voice_message =>  l_voice_message, 
        p_card_title    =>  l_voice_message, 
        p_card_content  =>  l_voice_message)); 
 
/* 
    exception  
        when others then 
        logger.log_error ( 
            p_text   => 'parse_alexa_skillfailure', 
            p_scope  => L_scope); 
*/ 
    end parse_alexa_skill; 
 
END alexa_trial_v1;


