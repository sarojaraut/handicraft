RI-Core

Generalnotif

https://www.snapdeal.com/product/panasonic-th40es500d-101-cm-40/622922330204

https://www.amazon.in/Panasonic-inches-Viera-TH-40ES500D-Full/dp/B0743F76CB/ref=sr_1_1?ie=UTF8&qid=1520086560&sr=8-1&keywords=panasonic+th-40es500d+smart+tv

play book

rule book

Incoming web hook URL
https://hooks.slack.com/services/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

curl -X POST --data-urlencode "payload={\"channel\": \"#appmon\", \"username\": \"webhookbot\", \"text\": \"This is posted to #appmon and comes from a bot named webhookbot.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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

You have two options for sending data to the Webhook URL above:
Send a JSON string as the payload parameter in a POST request
Send a JSON string as the body of a POST request

payload={"text": "This is a line of text in a channel.\nAnd this is another line of text."}

begin 
  -- send a formatted message
  s_slack_util.send_message ('Hello *Slack* World!');
end;
/

mkdir -p /u01/app/oracle/admin/DB11G/wallet

orapki wallet create -wallet /u01/app/oracle/admin/DB11G/wallet -pwd WalletPasswd123 -auto_login

orapki wallet add -wallet /u01/app/oracle/admin/DB11G/wallet -trusted_cert -cert "/host/BaltimoreCyberTrustRoot.crt" -pwd WalletPasswd123

https://oracle-base.com/articles/misc/utl_http-and-ssl

Select the "Base-64 encoded X.509 (.CER)" option and click the "Next" button. Other formats work, but I've found this to be the most consistent.

Order APIs
http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/ordermanagement/v1/orders
http://ords-alb.staging.transit.ri-tech.io/ords/omsuat/api/ordermanagement/v1/orders
http://ords-alb.staging.transit.ri-tech.io/ords/wmsuat/api/ordermanagement/v1/orders

Outh Token URI
http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/oauth/token
http://ords-alb.staging.transit.ri-tech.io/ords/omsuat/api/oauth/token
http://ords-alb.staging.transit.ri-tech.io/ords/wmsuat/api/oauth/token

Reference APIs
http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/orderreference/v1/bascooee
http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/orderreference/v1/omspaymentprovider
http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/orderreference/v1/rrefdtl
http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/orderreference/v1/scharcodes
http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/orderreference/v1/curratee

http://ords-alb.staging.transit.ri-tech.io/ords/omsuat/api/orderreference/v1/currencytable
http://ords-alb.staging.transit.ri-tech.io/ords/omsuat/api/orderreference/v1/scharcodes
http://ords-alb.staging.transit.ri-tech.io/ords/omsuat/api/orderreference/v1/omspaymentprovider

'

select to_char(newdate,'DD-MON-YYYY HH24:MI:SS TZD') from test_time;
select TZ_OFFSET('US/Pacific') FROM DUAL;

select TZ_OFFSET('ETC/GMT+8') FROM DUAL;

TZ_OFFS
-------
-08:00

select TZ_OFFSET('US/Pacific') FROM DUAL;

TZ_OFFS
-------
-07:00

Etc/GMT+1 	 Wed-07-Mar-2018 	 19:52:56 	 -01  	Historical: 1 hour behind GMT 
Etc/GMT0 	 Wed-07-Mar-2018 	 20:52:56 	 GMT  
Etc/GMT-1 	 Wed-07-Mar-2018 	 21:52:56 	 +01  	Historical: 1 hour ahead of GMT 

select 
  apex_web_service.make_rest_request( 
  p_url => 'https://api.slack.com/', 
  p_http_method => 'GET', 
  p_wallet_path => 'file:'||s_env.f_getenv('S_WALLET_DIR')) 
from dual;

select 
  apex_web_service.make_rest_request( 
  p_url => 'https://riverislanddev.service-now.com/api/now/table/incident', 
  p_http_method => 'GET', 
  p_wallet_path => 'file:'||s_env.f_getenv('S_WALLET_DIR')) 
from dual;