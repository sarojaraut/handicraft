
create or replace package alexa_trial_v4 is

    procedure p_accept_alexa_payload (
        p_body              in  blob,
        o_response_message  out varchar2
    );

    c_ord_dialogue_delg_template   varchar2(1000) :=
    '{
        "version": "1.0",
        "sessionAttributes": {},
        "response": {
            "shouldEndSession": false,
            "directives": [
                {
                    "type": "Dialog.Delegate",
                    "updatedIntent": {
                        "name": "orderstatus",
                        "confirmationStatus": "NONE",
                        "slots": {
                            "ordernumber": {
                                "name": "ordernumber",
                                "confirmationStatus": "NONE"
                            }
                        }
                    }
                }
            ]
        }
    }';

    c_ord_dialogue_conf_template   varchar2(1000) :=
    '{
        "version": "1.0",
        "sessionAttributes": {},
        "response": {
            "outputSpeech": {
                "type": "PlainText",
                "text": "You said your order number is %s, right?"
            },
            "shouldEndSession": false,
            "directives": [
                {
                    "type": "Dialog.ConfirmSlot",
                    "slotToConfirm": "ordernumber",
                    "updatedIntent": {
                        "name": "orderstatus",
                        "confirmationStatus": "NONE",
                        "slots": {
                            "ordernumber": {
                                "name": "ordernumber",
                                "value": %s,
                                "confirmationStatus": "NONE"
                            }
                        }
                    }
                }
            ]
        }
    }';

end alexa_trial_v4;
/

create or replace package body alexa_trial_v4 as

    C_scope_prefix  varchar2(100) := LOWER($$plsql_unit) || '.';

    function blob_to_clob (
        p_data  in  blob
    )
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
            return trim(to_char(p_date,'Day'))||
                    '. ????'||
                    trim(to_char(p_date,'MMDD'))||'';
        end if;

    end say_date;
    --
    --
    --
    function get_order_status (i_ordernumber in number)
    return varchar2
    is
        l_status       varchar2(100);
        l_event_date   varchar2(100);
        l_status_msg   varchar2(4000);
        l_key_sound    varchar2(4000);
    begin
        l_key_sound := '<audio src="https://s3.amazonaws.com/ask-soundlibrary/office/amzn_sfx_typing_medium_02.mp3"/>';
        select
            replace(max(shipping_status),'_',' '),
            max(trim(to_char(created_dtm,'YYYYMMDD')))
        into
            l_status,
            l_event_date
        from w_io_web_ord_hdr
        where order_number=i_ordernumber;

        if l_status is not null then
            l_status_msg := apex_string.format('Your order <say-as interpret-as="digits">%s</say-as> is %s on <say-as interpret-as="date">%s</say-as>',
                                i_ordernumber,
                                l_status,
                                l_event_date
                            );
        else
            l_status_msg := apex_string.format('Order <say-as interpret-as="digits">%s</say-as> is not found in the system', i_ordernumber);
        end if;

        return l_status_msg;

    end get_order_status;
    --
    --
    --
    function f_create_test_order (
        i_count in number)
    return number
    is
    begin
        insert ALL
        into w_io_web_ord_hdr
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
        values
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
        values
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
            ,decode(
                ABS(MOD(rn,5)),
                1,'cancel',
                2,'dispatch',
                3,'dispatch',
                4,'dispatch',
                'return')  event_type
            ,rn  order_number
            ,rn  consignment_code
            ,decode(
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
            select
                get_seq_id rn
            from dual
            connect by rownum <=i_count
            ) tmp;

    return sql%rowcount/2;

    end f_create_test_order;
    --
    --
    --
    function f_build_alexa_response (
        i_voice_message         in varchar2,
        i_card_title            in varchar2,
        i_card_content          in varchar2,
        i_order_number          in varchar2,    
        i_dialog_state          in varchar2,
        i_confirmation_status   in varchar2
    )
    return varchar2
    is
        l_message varchar2(32000);
        l_scope   varchar2(100) := C_scope_prefix||'f_build_alexa_response';
    begin

        if  i_voice_message is not NULL
        -- voice msg will be not null only if dialog state is confirmed
        -- and confirmation status is confirmed
        then
            apex_json.initialize_clob_output;

            apex_json.open_object; -- {
                apex_json.write('version', '1.0');
                apex_json.open_object('sessionAttributes'); -- sessionAttributes {
                apex_json.close_object; -- } sessionAttributes
                apex_json.open_object('response'); -- response {
                    apex_json.open_object('outputSpeech'); -- outputSpeech {
                        apex_json.write('type', 'SSML');
                        apex_json.write('ssml', '<speak>'||i_voice_message||'</speak>' );
                    apex_json.close_object; -- } outputSpeech
                    apex_json.open_object('card'); -- card {
                        apex_json.write('type', 'Simple');
                        apex_json.write('title',i_card_title );
                        apex_json.write('content',i_card_content);
                    apex_json.close_object; -- } card
                    apex_json.write('shouldEndSession', true);
                apex_json.close_object; -- } response
            apex_json.close_object; -- }

            l_message := apex_json.get_clob_output;
        elsif (i_voice_message is null
            and i_dialog_state =  'STARTED'
            and NVL(i_confirmation_status,'X') = 'NONE' )
            or NVL(i_confirmation_status,'X') = 'DENIED'
        then
            l_message := c_ord_dialogue_delg_template;

        elsif i_voice_message is null
                and i_order_number is not null
                and i_dialog_state = 'IN_PROGRESS'
        then
            l_message := apex_string.format(c_ord_dialogue_conf_template, i_order_number, i_order_number);
        end if;

        return l_message;

    end f_build_alexa_response;
    --
    --
    --
    procedure p_accept_alexa_payload (
        p_body              in  blob,
        o_response_message  out varchar2
    )
    is
        l_body_clob           clob;
        l_values              apex_json.t_values;
        l_intent_name         varchar2(4000);
        l_dialog_state        varchar2(1000);
        l_count               number;
        l_since_last_x_hour   number;
        l_voice_message       varchar2(4000);
        l_card_title          varchar2(4000);
        l_card_content        varchar2(4000);
        l_response_json       varchar2(4000);
        l_order_number        varchar2(100);
        l_confirmation_status varchar2(100);
        l_scope               varchar2(100) := C_scope_prefix||'p_accept_alexa_payload';
    begin

        --Convert blob to clob
        l_body_clob := blob_to_clob (p_data => p_body);

        delete from alexa_json_log where time_stamp < systimestamp - 1/24;
    /*
        logger.log_info (
            p_text   => 'converted colb value',
            p_scope  => L_scope,
            p_extra  => l_body_clob);
    */
        --Parse clob to json object
        apex_json.parse(l_body_clob);

        l_intent_name := apex_json.get_varchar2(p_path=>'request.intent.name');
        l_since_last_x_hour := apex_json.get_varchar2(p_path=>'request.intent.slots.since_last_x_hour.value');
        l_dialog_state := apex_json.get_varchar2(p_path=>'request.dialogState');
        l_order_number := apex_json.get_varchar2(p_path=>'request.intent.slots.ordernumber.value');
        l_confirmation_status := apex_json.get_varchar2(p_path=>'request.intent.slots.ordernumber.confirmationStatus');
    /*
        logger.log_info (
            p_text   => 'l_since_last_x_hour '||l_since_last_x_hour,
            p_scope  => L_scope,
            p_extra  => l_body_clob);
    */

        if l_intent_name = 'orders'
            or  l_intent_name = 'dispatches'
            or  l_intent_name = 'cancels'
            or  l_intent_name = 'returns'
        then
            -- count of orders or specific to event type
            select count(*)
            into l_count
            from w_io_web_ord_hdr
            where created_dtm  >= NVL(sysdate - (l_since_last_x_hour/24), created_dtm)
                and event_type=
                case l_intent_name
                    when 'orders'     then  event_type
                    when 'dispatches' then 'dispatch'
                    when 'cancels'    then 'cancel'
                    when 'returns'    then 'return'
                else null
                end;
            if l_since_last_x_hour is not null then
                l_voice_message := 'Count of '||l_intent_name||' in last '||l_since_last_x_hour||' hours'||' is '||l_count;
            else
                l_voice_message := 'Count of '||l_intent_name||' is '||l_count;
            end if;
        elsif l_intent_name = 'create_test_order' then
            l_count := f_create_test_order(
                NVL(apex_json.get_varchar2(p_path=>'request.intent.slots.count.value'), 10)
            );
            l_voice_message := 'Count of test orders created is '||l_count;
        elsif l_intent_name = 'orderstatus' then
            if l_order_number is not null and l_confirmation_status='CONFIRMED' then
                l_voice_message := get_order_status(l_order_number);
            else 
                l_voice_message := null;
            end if;
        else
            l_voice_message := 'Sorry, I have no information about '||l_intent_name;
        end if;

            o_response_message:=
            f_build_alexa_response (
                i_voice_message       =>  l_voice_message,
                i_card_title          =>  l_voice_message,
                i_card_content        =>  l_voice_message,
                i_order_number        =>  l_order_number,
                i_dialog_state        =>  l_dialog_state,
                i_confirmation_status =>  l_confirmation_status
                );
/*
    logger.log_info (
        p_text   => 'l_json_count='||l_json_count,
        p_scope  => L_scope);
*/

    insert into alexa_json_log values(l_intent_name, systimestamp, l_body_clob, o_response_message);
    --htp.p(o_response_message);
/*
    exception
        when others then
        logger.log_error (
            p_text   => 'p_accept_alexa_payloadfailure',
            p_scope  => L_scope);
*/
    end p_accept_alexa_payload;

END alexa_trial_v4;
/

--
-- https://apex.oracle.com/pls/apex/sarojws/aps/v3/alexa
--
DECLARE
    l_scope               varchar2(50) := 'create_ords_rest_service_aps.sql';
    l_module_name         varchar2(50) := 'aps.v4';
    L_module_base_path    varchar2(50) := 'aps/v4/';
    l_template_pattern    varchar2(50) := 'alexa';
    l_handler_get_source  varchar2(4000) := 'select * from w_io_web_ord_hdr';
    l_handler_post_source varchar2(4000) :=
    q'[
    declare
        l_response_message   varchar2(4000);
    begin
        alexa_trial_v4.p_accept_alexa_payload (
            p_body             => :body,
            o_response_message => l_response_message);
        :http_status        := 200;
        :response_message   := l_response_message;
    end;
    ]';
    -- https://apex.oracle.com/pls/apex/sarojws/aps/v4/alexa
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

	ords.define_parameter(
        p_module_name        => l_module_name,
        p_pattern            => l_template_pattern,
		p_method             => 'POST',
		p_name               => 'message',
		p_bind_variable_name => 'response_message',
		p_source_type        => 'RESPONSE',
		p_param_type         => 'STRING',
		p_access_method      => 'OUT',
		p_comments           => 'Result message'
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
