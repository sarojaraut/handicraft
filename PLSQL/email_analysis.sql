pl_generate_html_email : gets the email content in xml format, get the xsl stylesheet, apply the xsl to xml and add header and footer and invokes
	oms_cust_email.pl_create_email : inturn calls s_process_event.p_add_mail  which makes an entry to s_mail_queue
	
	Usual Process of Sending email is : 
	-- add the email event
	s_process_event.p_add_event (
			I_from_contact_id    => L_from_contact,
			I_mime_type          => s_process_event.C_plain_mime_type,
			I_message            => L_message,
			I_message_title      => 'Email subject line goes here!',
			O_event_id           => L_event_id);
		s_process_event.p_add_event : Input parameters from contact, message title, message, mime type, linked event, external key, event type, sla , o event id.
		Event id is used for fetching default message titiel and message body if not provided.
		If project phase is non test phase then add a prefix like 'created in TS3'
		Makes an entry to s_event_queue.
		--To add a TO recipient
		s_process_event.p_add_event_contact(
			I_event_id       => L_event_id,
			I_contact_id     => s_process_event.f_contact_id('STORES','CC_STORES')
			);
			 This makes an entry to s_event_contact
			 
			INSERT INTO s_event_contact
			(event_id,
			contact_id,
			mail_dest_type)
			VALUES(I_event_id,
			I_contact_id,
			I_mail_dest_type);

	s_process_event.pl_mail_queue : Inserts into s_mail_queue from s_event_queue and s_contact; for the input event_id

	p_desp_canc_emails > calls all pl_procedurs targeted for sending email of specific area.

	All the below calls pl_generate_html_email >> pl_create_email >  s_process_event.p_add_mail >> INSERT INTO s_mail_queue

	p_late_van >> Generate notification emails for late van runs
	pl_ord_canc
	pl_order_canc_pp 
	pl_order_despatched_part_canc >> Generate customer emails for order dispatch and
	pl_complete_order_despatch
	pl_ready_for_collection
	pl_store_collection_reminder
	pl_store_uncollected_return
	pl_order_cbr_return
	pl_order_return
	pl_order_return_pp
	pl_ord_part_despatched_pp

	oms_cust_email.p_desp_canc_emails >> pl_complete_order_despatch and pl_order_despatched_part_canc etc

	deliv_type of cms gos into CARRIER_SERVICE_GROUP of orderheader in OMS

	pl_generate_html_email called from pl_complete_order_despatch with xml data and template data. 
	select * from s_rawdata where obj_id= 
	(select 
	   oms_cust_email.f_s_rawdata_obj_id(
		   'hso050_cust_email_full_despatch.xslt',
		   'en-GB')
	from dual)

select * from s_rawdata where obj_id=2067;

select * from s_vld_test_email_addr; -- validates your email ID

select wkq.* from io_work_queue wkq where s_delim_str.f_get_string(wkq.key_data,2) ='D' 

select * from carrierconsignmentheader

select * from oms_service_group;

exec oms_cust_email.p_desp_canc_emails();

SELECT event.event_id,
       event.from_user_id,
       event.sla_id,
       event.escalation_level,
       dispatch.*
FROM   s_dispatch_queue dispatch,
       s_event_queue event
WHERE  event.event_status  <> 'CLOSED'
AND    dispatch.sent_ind = 'F'
AND    dispatch.error_dtl IS NULL
AND    dispatch.event_id = event.event_id;

s_dispatch.sh >> s_dispatch_mail_queue.sh >> s_dispatch_mail.sh >> s_mail.sh

s_dispatch.sh : 

	SELECT COUNT(*)
	FROM   s_mail_queue
	WHERE  dispatch_status = 'FAIL'
	AND    dispatch_dtm > SYSDATE - (/*L_tolerance_hours*/24/24);

	If above count >5 then fail the script

	s_process_event.p_dispatch  :
	
s_process_event.p_dispatch

Test Orders : 

select * from trans_hso_ord_hdr where ord_id in (250186503, 250186505, 250186506) -- TS4 UAT1

select * from trans_hso_ord_hdr where ord_id=2100106664 -- TS3 UAT2

email_xslt_refresh.sql,1.14,T,OMS

SELECT ordhdr.ordernumber AS ordernumber,
               cust.personalemail AS email_addr,
               et.obj_clob        AS email_temp,
               eh.obj_clob        AS email_header,
               ef.obj_clob        AS email_footer,
               xmltype.getclobval(
                   XMLROOT(
                       XMLELEMENT("EMAIL",
                           XMLELEMENT("RIINFO",
                               XMLFOREST(
                                   IC_web_url AS "WEBURL",
                                   IC_hdnl_url AS "HDNLURL",
                                   IC_collectp_url AS "COLLECTPLUSURL",
                                   IC_contact_email AS "CONTACTEMAIL",
                                   IC_ord_contact_email AS "ORDERCONTACTEMAIL",
                                   IC_email_type AS "EMAILTYPE"
                               )
                           ),
                           XMLELEMENT("ORDER",
                               XMLELEMENT("HEADER",
                                   (SELECT
                                       XMLFOREST(
                                           TO_CHAR(xmlordhdr.ordergrossvalue,'99990D00') AS "ORDERGROSSVALUE",
                                           TO_CHAR(xmlordhdr.deliverygrossvalue,'999990D00') AS "DELIVERYGROSSVALUE",
                                           TO_CHAR(xmlordhdr.ordergrossvalue - xmlordhdr.deliverygrossvalue,'99990D00') AS "DELIVERYNETVALUE",
                                           TO_CHAR((SELECT SUM (discount_amount)
                                                   FROM oms_orderpromo
                                                   WHERE order_id = xmlordhdr.ordernumber
                                                   AND   order_level_promo_ind = s_const.c_false),'999990D00') "DISCOUNTAMOUNT",
                                           TO_CHAR(despdate.despatchconfirmed,'DD Mon YYYY') AS "DESPATCHDATE",
                                           INITCAP(ct.forenames)     AS "CUSTOMERNAME",
                                           INITCAP(carrier.address1) AS "ADDRESS1",
                                           INITCAP(carrier.address2) AS "ADDRESS2",
                                           INITCAP(carrier.address3) AS "ADDRESS3",
                                           INITCAP(carrier.town) AS "TOWN",
                                           DECODE(UPPER(carrier.county),
                                                  UPPER(carrier.town), NULL,
                                                  INITCAP(carrier.county)) AS "COUNTY",
                                           UPPER(carrier.postcode) AS "POSTCODE",
                                           UPPER(carrier.countrycode)  AS "COUNTRY",
                                           INITCAP(cntry.countryname)  AS "COUNTRYNAME",
                                           xmlordhdr.ordernumber       AS "ORDERID",
                                           INITCAP(shipcode.web_service_name) AS "DELIVERYTYPE",
                                           UPPER(cc.base_currency)     AS "ORDERCURRENCY",
                                           UPPER(xmlordhdr.sourcecode) AS "SOURCECODE",
                                           UPPER(s_code.f_trlt_to_char(oms_ord_const.C_dest_type, xmlordhdr.dest_type)) AS "DESTTYPE",
                                           DECODE(cntry.eumember, 0, s_const.C_false, s_const.C_true) "EUMEMBER_IND",
                                           CASE
                                               WHEN TRUNC(csg.expected_delivery_dtm) > TRUNC(xmlordhdr.deliverbydate)
                                                   THEN
                                                       s_const.C_true
                                               ELSE
                                                   s_const.C_false
                                           END                         AS "LATE_IND",
                                           CASE
                                               WHEN csg.expected_delivery_dtm > xmlordhdr.deliverbydate
                                                   THEN
                                                       TO_CHAR(csg.expected_delivery_dtm,'DD Mon YYYY  YYYY HH:MI AM')
                                               ELSE
                                                   TO_CHAR(xmlordhdr.deliverbydate, 'DD Mon YYYY  YYYY HH:MI AM')
                                           END                         AS "DELIVDATE",
                                           LOWER(TO_CHAR(NVL(csg.expected_delivery_dtm, xmlordhdr.deliverbydate),
                                                       'HH24:MI')) AS "DELIVTIME",
                                           TO_CHAR(xmlordhdr.cust_collection_dtm,
                                                       'DD Mon YYYY')  AS "COLLECTDATE",
                                           LOWER(TO_CHAR(xmlordhdr.cust_collection_dtm,
                                                       'HH24:MI')) AS "COLLECTTIME"
                                       )
                                    FROM  orderheader xmlordhdr
                                          JOIN (SELECT ordernumber,
                                                       MAX(expected_delivery_dtm) expected_delivery_dtm
                                                FROM   oms_consignment csg
                                                WHERE  csg.consignment_status >= 190 --oms_const.C_consignmnet_despatched
                                                AND    csg.consignment_status <> 200 --oms_const.C_consignmnet_cancelled
                                                GROUP  BY csg.ordernumber)  csg
                                              ON (csg.ordernumber = xmlordhdr.ordernumber)
                                          JOIN carrierconsignmentheader carrier
                                              ON (carrier.ordernumber   = xmlordhdr.ordernumber)
                                          LEFT JOIN country cntry
                                              ON (cntry.countrycode = carrier.countrycode)
                                          JOIN currencytable cc
                                              ON (xmlordhdr.currencycode = cc.currencycode)
                                          JOIN oms_service_group shipcode
                                              ON (shipcode.service_group_id = xmlordhdr.shippingcode)
                                          JOIN (SELECT ordernumber,
                                                       MAX(despatchconfirmed) AS despatchconfirmed
                                                FROM   orderitemheader
                                                WHERE  itemstatusmajor >= 40 --oms_const.C_orditm_maj_stat_despatch
                                                AND    itemstatusmajor <> 50 --oms_const.C_orditm_maj_stat_canc
                                                GROUP BY ordernumber) despdate
                                              ON (despdate.ordernumber   = xmlordhdr.ordernumber)
                                          JOIN customercontacts ct
                                              ON (ct.customerurn= xmlordhdr.customerurn
                                              AND ct.contactid = xmlordhdr.contactid)
                                    WHERE ordhdr.ordernumber = xmlordhdr.ordernumber
                                    AND   ROWNUM < 2
                                   )
                               ),
                               XMLELEMENT("ITEMS",
                                   (SELECT  XMLAGG(
                                       XMLELEMENT("ITEM",
                                           XMLFOREST(
                                               xmlorditm.sku AS "SKU",
                                               xmlorditm.sku||'  '||stk.detaileddescription AS "SKUDESCRIPTION",
                                               TO_CHAR(
                                                   SUM(xmlorditm.grossvalue * xmlorditm.quantity)
                                                   ,'99990D00') AS "GROSSVALUE",
                                               SUM(xmlorditm.quantity) AS "QUANTITY",
                                               TO_CHAR(SUM(itempromo.discount_amount * xmlorditm.quantity),'999990D00') AS "ITEMDISCOUNTVALUE",
                                               (CASE
                                                    WHEN SUM(itempromo.discount_amount) IS NULL
                                                    THEN
                                                        TO_CHAR(xmlorditm.grossvalue,'999990D00')
                                                    ELSE
                                                        TO_CHAR(SUM(xmlorditm.grossvalue + itempromo.discount_amount),'999990D00')
                                                END) AS "UNITPRICE"
                                           )
                                       ))
                                    FROM  orderitemheader xmlorditm
                                          JOIN stock stk
                                              ON (stk.sku = xmlorditm.sku)
                                          LEFT OUTER JOIN (SELECT order_id,
                                                                  orderitem_id,
                                                                  SUM (discount_amount)AS discount_amount
                                                           FROM   oms_orderpromo
                                                           WHERE order_level_promo_ind=s_const.c_false
                                                           GROUP BY order_id,
                                                                    orderitem_id
                                                           )itempromo
                                              ON (xmlorditm.ordernumber  = itempromo.order_id
                                              AND xmlorditm.itemnumber = itempromo.orderitem_id)
                                    WHERE xmlorditm.ordernumber = ordhdr.ordernumber
                                    AND   stk.clientcode = 'RI' --oms_const.C_clientcode_river_island
                                    GROUP BY xmlorditm.sku,
                                             stk.detaileddescription,
                                             stk.description,
                                             xmlorditm.grossvalue
                                   )
                               ),
                               XMLELEMENT("CONSIGNMENT",
                                   (SELECT  XMLAGG(
                                       XMLELEMENT("LINE",
                                           XMLFOREST(
                                               carrier.carrierconsignmentnumber AS "CONSIGNMENTNUMBER",
                                               carrier.barcode AS "BARCODE",
                                               (SELECT trackable_ind
                                                FROM oms_carrier_service
                                                WHERE carrier_service_id = ordhdr.carrier_service_type ) AS "TRACKABLE",
                                               IC_hdnltracker_url||carrier.ordernumber AS "HDNLTRACKERURL"
                                           )
                                       ))
                                    FROM  carrierconsignmentheader carrier
                                    WHERE carrier.ordernumber = ordhdr.ordernumber
                                   )
                               ),
                               XMLELEMENT("CUSTOMER",
                                   (SELECT
                                       XMLFOREST(
                                           xmlcust.personalemail AS "EMAILADDR"
                                       )
                                    FROM  customer xmlcust
                                    WHERE xmlcust.customerurn = ordhdr.customerurn
                                   )
                               )
                           )
                       ),
                   VERSION '1.0'
                   )
               ) AS email_xml
        FROM  io_work_queue wkq
              JOIN orderheader ordhdr
                  ON (ordhdr.ordernumber = s_delim_str.f_get_string(wkq.key_data,1))
              JOIN customer cust
                  ON (cust.customerurn = ordhdr.customerurn)
              JOIN s_rawdata et
                   ON (et.obj_id =
                           oms_cust_email.f_s_rawdata_obj_id(
                               oms_cust_email.C_full_despatch_xslt,
                               ordhdr.lang_locale))
              JOIN s_rawdata eh
                   ON (eh.obj_id =
                           oms_cust_email.f_s_rawdata_obj_id(
                               oms_cust_email.C_auto_email_header_xslt,
                               ordhdr.lang_locale))
              JOIN s_rawdata ef
                   ON (ef.obj_id =
                           oms_cust_email.f_s_rawdata_obj_id(
                               oms_cust_email.C_auto_email_footer_xslt,
                               ordhdr.lang_locale))
        WHERE 1=1 --wkq.feed_dtl_id = IC_feed_id
        AND   s_delim_str.f_get_string(wkq.key_data,2) =
                  'D' -- oms_const.C_msg_email_despatch
        AND   NOT EXISTS (
                  SELECT 1
                  FROM   orderitemheader orderitemcanc
                  WHERE  orderitemcanc.ordernumber = ordhdr.ordernumber
                  AND    orderitemcanc.itemstatusmajor =
                             50 --oms_const.C_orditm_maj_stat_canc
                             );

select * from s_char_codes

select * from orderheader

select to_char(sysdate, 'Dayddth Mon YYYY'), to_char(sysdate, 'HH AM') Slot_start_time, to_char( sysdate + (1/24), 'HH AM') Slot_end_time from dual

select * from user_tables where table_name like '%WAREHOUSE%'

select * from OMS_WAREHOUSE

select * from oms_wh_srvc_grp_trlt

select 
   oms_cust_email.f_s_rawdata_obj_id(
       'hso050_cust_email_full_despatch.xslt',
       'en-GB')
from dual

select * from s_rawdata where obj_id= 
    (select 
       oms_cust_email.f_s_rawdata_obj_id(
           'hso050_cust_email_full_despatch.xslt',
           'en-GB')
    from dual)
    
select to_char(sysdate,'FMHHam') from dual

select * from s_rawdata where obj_id=2067

select * from s_rawdata_bkp

create table s_rawdata_bkp as select * from s_rawdata

update s_rawdata set obj_clob= where obj_id=2067

begin
  oms_cust_email.p_desp_canc_emails(100266198);
end;
/

TS4 ORDER

update orderitemheader set itemstatusmajor=40 where itemnumber=83591660 and ordernumber=250186675 and itemstatusmajor=25;

update orderheader set shippingcode='05', NDD_SLOT_TOKEN_ID='PR12345678' where ordernumber=250186675;

update oms_consignment set consignment_status=190 where ordernumber=250186675 and consignment_status=150;


select * from orderheader where ordernumber=250186675

select * from orderitemheader where ordernumber=250186675

select * from oms_consignment where ordernumber=250186675

select * from oms_package where consignment_id=33409758



<html xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xsl:version="1.0">
  <head>
    <title>River Island</title>
    <style>

    .ord-summary-hdr{
      font-family:arial;
      font-weight: bold;
      text-decoration: underline;
      font-size:14;
     }
     
    .ord-summary-item{
    font-family:arial;
    font-size:12;
    
    }
    
    .ord-summary-tot{
        font-family:arial;
        font-weight: bold;
        font-size:13
    }
   .ib{
      height:150px;
      width:195px;
      background-color:#ffffff;
      text-align:center;
      margin-bottom:2px;
    }
   .notified_txt{
        font-family:arial;
        font-weight: bold;
        font-size:14
   }   
    
    </style>
  </head>
  <body>
    <font face="arial">
      <table border="0" cellpadding="0" cellspacing="0" width="700" align="center" bgcolor="#ffffff">
        <tr>
          <td width="700" align="left">
             <EMAIL-HEADER/>
            <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr valign="top">
                <td width="505">
                  <font face="arial" color="#000000" size="2">
                    <img src="http://riverisland.scene7.com/is/image/RiverIsland/autoemail-dispatch-title?scl=1" alt="Despatch Confirmation" width="505" height="68" border="0" usemap="#WMap1" />
                    <br/>
                    
                    Hi <b><xsl:value-of select="/EMAIL/ORDER/HEADER/CUSTOMERNAME"/></b><br/>
                    <br/>
                    Good news! Your River Island order is on its way.
                    <xsl:choose>
                      <xsl:when test="/EMAIL/ORDER/HEADER/DESTTYPE='STORE'">
                          <br/><p class="notified_txt">You will be notified by the 'It's Arrived' email when your order is ready for collection at the store.</p>
                      </xsl:when>
                    </xsl:choose>
                    <br/>
                    <xsl:if test="/EMAIL/ORDER/HEADER/LATE_IND = 'T'">
                      <xsl:if test="not(/EMAIL/ORDER/HEADER/DESTTYPE='STORE')">
                        <br/>We're sorry to let you know that your order has been delayed and so won't be delivered on the date given when you ordered. Please accept our apologies for any inconvenience caused by this delay
                        <br/>
                      </xsl:if>
                    </xsl:if>
                    <br/>
                    Order number is:&#160;<b>
                      <xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERID"/>
                    </b><br/>
                    <br/>

                    <xsl:if test="not(/EMAIL/ORDER/HEADER/SOURCECODE='STORE')">
                    <xsl:choose>
                      <xsl:when test="/EMAIL/ORDER/HEADER/DESTTYPE='STORE'">
                        </xsl:when>
                      <xsl:otherwise>
                        Expected delivery date is:&#160;<b>
                          <xsl:value-of select="/EMAIL/ORDER/HEADER/DELIVDATE"/>
                        </b>
                          </xsl:otherwise>
                    </xsl:choose>
                    <br/>
                    <br/>
                    </xsl:if>
                    Your delivery type is:&#160;<b>
                      <xsl:value-of select="/EMAIL/ORDER/HEADER/DELIVERYTYPE"/>
                    </b><br/>
                    <br/>

                    We'll deliver to:<br/>
                    <p>
                      <b>
                        <xsl:if test="/EMAIL/ORDER/HEADER/ADDRESS1">
                          <xsl:value-of select="/EMAIL/ORDER/HEADER/ADDRESS1"/>
                          <br />
                        </xsl:if>
                        <xsl:if test="/EMAIL/ORDER/HEADER/ADDRESS2">
                          <xsl:value-of select="/EMAIL/ORDER/HEADER/ADDRESS2"/>
                          <br />
                        </xsl:if>
                        <xsl:if test="/EMAIL/ORDER/HEADER/ADDRESS3">
                          <xsl:value-of select="/EMAIL/ORDER/HEADER/ADDRESS3"/>
                          <br />
                        </xsl:if>
                        <xsl:if test="/EMAIL/ORDER/HEADER/TOWN">
                          <xsl:value-of select="/EMAIL/ORDER/HEADER/TOWN"/>
                          <br />
                        </xsl:if>
                        <xsl:if test="/EMAIL/ORDER/HEADER/COUNTY">
                          <xsl:value-of select="/EMAIL/ORDER/HEADER/COUNTY"/>
                          <br />
                        </xsl:if>
                        <xsl:value-of select="/EMAIL/ORDER/HEADER/POSTCODE"/>
                        <br/>
                        <xsl:if  test="not(/EMAIL/ORDER/HEADER/COUNTRY = 'GB')">
                          <xsl:value-of select="/EMAIL/ORDER/HEADER/COUNTRYNAME"/>
                        </xsl:if>
                      </b>
                    </p>
                    <br/>
                    <xsl:choose>
                      <xsl:when test="/EMAIL/ORDER/CONSIGNMENT/LINE/TRACKABLE='T'">
                        <xsl:if test="not(/EMAIL/ORDER/HEADER/SOURCECODE='WEB' and /EMAIL/ORDER/HEADER/DESTTYPE='STORE')">
                          <p>
                            <br/>
                            Your order will be with you soon, but if you want to keep an eye on it then you can
                            <xsl:for-each select="/EMAIL/ORDER/CONSIGNMENT/LINE">
                              <a href="{HDNLTRACKERURL}">
                                track your order
                              </a>
                              <br/>
                              <br />
                            </xsl:for-each>
                          </p>
                        </xsl:if>
                      </xsl:when>
                     </xsl:choose>
                    <br/>
                    <b>YOUR ORDER SUMMARY:</b>
                    <br/>
                    <br/>
                    <xsl:choose>
                      <xsl:when test="/EMAIL/ORDER/HEADER/DISCOUNTAMOUNT">
                        <table width="500" border="0" cellpadding="1" cellspacing="0">
                          <tr class="ord-summary-hdr">
                            <th width="340" align="left"  valign="bottom">
                              Product
                            </th>
                            <th width="50" align="right" valign="bottom" >
                              Qty
                            </th>
                            <th width="145" align="right" valign="top" >
                              Price <br/>
                            </th>
                            <th width="65" align="right" valign="bottom">
                              Discount
                              <br />
                              Applied
                            </th>
                            <th width="65" align="right" valign="bottom">
                              Price<br/>Paid
                            </th>
                          </tr>
                          <xsl:for-each select="/EMAIL/ORDER/ITEMS/ITEM">
                            <tr class="ord-summary-item">
                              <td width="340" align="left" valign="bottom" >
                                <xsl:value-of select="SKUDESCRIPTION"/>
                              </td>
                              <td width="50" align="right" valign="bottom" >
                                <xsl:value-of select="QUANTITY"/>
                              </td>
                              <td width="145" align="right" valign="bottom">
                                <xsl:value-of select="UNITPRICE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                              </td>
                              <td width="65" align="right" valign="bottom" >
                                <xsl:if test="ITEMDISCOUNTVALUE">
                                  <xsl:value-of select="ITEMDISCOUNTVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                                </xsl:if>
                              </td>
                              <td width="65" align="right" valign="bottom">
                                <xsl:value-of select="GROSSVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                              </td>
                            </tr>
                          </xsl:for-each>
                          <tr>
                            <td width="340" align="left" valign="bottom"></td>
                            <td width="50" align="right" valign="bottom"></td>
                            <td class="ord-summary-tot" width="145" align="right" valign="bottom">Sub Total</td>
                            <td class="ord-summary-tot" width="65"  align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/DISCOUNTAMOUNT"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                            </td>
                            <td class="ord-summary-tot" width="65"  align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/DELIVERYNETVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                            </td>
                          </tr>
                          <tr>
                            <td width="340" align="left" valign="bottom"></td>
                            <td width="50" align="right" valign="bottom"></td>
                            <td class="ord-summary-tot" width="145" align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/DELIVERYTYPE"/> Delivery
                            </td>
                            <td width="65" align="right" valign="bottom"></td>
                            <td class="ord-summary-tot" width="65" align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/DELIVERYGROSSVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                            </td>
                          </tr>
                          <tr>
                            <td width="340" align="left" valign="bottom"></td>
                            <td width="50" align="right" valign="bottom"></td>
                            <td class="ord-summary-tot" width="145" align="right" valign="bottom" >Total Payable</td>
                            <td width="65" align="right" valign="bottom"></td>
                            <td class="ord-summary-tot" width="65" align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERGROSSVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                            </td>
                          </tr>

                        </table>
                      </xsl:when>
                      <xsl:when test="not(/EMAIL/ORDER/HEADER/DISCOUNTAMOUNT)">
                        <table width="500" border="0" cellpadding="1" cellspacing="0">
                          <tr class="ord-summary-hdr">
                            <th width="340" align="left" valign="bottom">
                              Product
                            </th>
                            <th width="50" align="right" valign="bottom" >Qty</th>
                            <th width="145" align="right" valign="bottom">
                              Price<br/>Each
                            </th>
                            <th width="65" align="right" valign="bottom">Total</th>
                          </tr>
                          <xsl:for-each select="/EMAIL/ORDER/ITEMS/ITEM">
                            <tr class="ord-summary-item">
                              <td width="340" align="left" valign="bottom">
                                <xsl:value-of select="SKUDESCRIPTION"/>
                              </td>
                              <td width="50" align="right" valign="bottom">
                                <xsl:value-of select="QUANTITY"/>
                              </td>
                              <td width="145" align="right" valign="bottom">
                                <xsl:value-of select="UNITPRICE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                              </td>
                              <td width="65" align="right" valign="bottom">
                                <xsl:value-of select="GROSSVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                              </td>
                            </tr>
                          </xsl:for-each>
                          <tr>
                            <td width="340" align="left" valign="bottom"></td>
                            <td width="50" align="right" valign="bottom"></td>
                            <td class="ord-summary-tot" width="145" align="right" valign="bottom">Sub Total</td>
                            <td class="ord-summary-tot" width="65"  align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/DELIVERYNETVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                            </td>
                          </tr>
                          <tr>
                            <td width="340" align="left" valign="bottom"></td>
                            <td width="50" align="right" valign="bottom"></td>
                            <td class="ord-summary-tot" width="145" align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/DELIVERYTYPE"/> Delivery
                            </td>
                            <td class="ord-summary-tot" width="65" align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/DELIVERYGROSSVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                            </td>
                          </tr>
                          <tr>
                            <td width="340" align="left" valign="bottom"></td>
                            <td width="50" align="right" valign="bottom"></td>
                            <td  class="ord-summary-tot" width="145" align="right" valign="bottom">Total Payable</td>
                            <td class="ord-summary-tot" width="65" align="right" valign="bottom">
                              <xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERGROSSVALUE"/>&#160;<xsl:value-of select="/EMAIL/ORDER/HEADER/ORDERCURRENCY"/>
                            </td>
                          </tr>
                        </table>
                      </xsl:when>
                    </xsl:choose>
                    <br/>
                    <br/>
                    
                    <xsl:choose>
                      <xsl:when test="/EMAIL/ORDER/HEADER/DESTTYPE='COLLECTPLUS' or /EMAIL/ORDER/HEADER/DESTTYPE='HERMES'">
                      <p>You will be notified when it has arrived and is ready for collection at the store.</p>
                      </xsl:when>
                      </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="/EMAIL/ORDER/HEADER/DISCOUNTAMOUNT">
                        <p>
                          If for any reason you wish to return any part of your order, please note that you will be refunded the price of the item(s) after the discount has been applied, not the full price of the item(s).
                        </p>
                      </xsl:when>
                    </xsl:choose>
                    <p>
                      For more information regarding your order, past order history or saved details, simply log into <a href="https://www.riverisland.com/myaccount?cmpid=trsRIoms">My Account</a>.
                     <br/>
                    </p>
                    <p>
                      <xsl:choose>
                        <xsl:when test="/EMAIL/ORDER/HEADER/EUMEMBER_IND = 'T'">
                          For full details of our returns policy, how to track your order, or for more information about how to cancel your order under the EU Distance Selling Regulations, please take a look at our <a href="http://www.riverisland.com/how-can-we-help/frequently-asked-questions">Frequently Asked Questions</a>.
                        </xsl:when>
                        <xsl:otherwise>
                          For full details of our returns policy or how to track your order, please take a look at our <a href="http://www.riverisland.com/how-can-we-help/frequently-asked-questions">Frequently Asked Questions</a>.
                        </xsl:otherwise>
                      </xsl:choose>
                    </p>
                    <br/>
                    <b>Thanks for choosing to shop at River Island.</b>
                    <br/>
                      <img src="http://riverisland.scene7.com/is/image/RiverIsland/autoemail-signature?scl=1" alt="The River Island Team" width="505" height="60" border="0" />
                    <br/>
                  </font>
                </td>
                <td valign="top">
                 <table border="0">
                    <tr>
                      <td width="195" align="center">
                        <xsl:choose>
                        <xsl:when test="/EMAIL/RIINFO/EMAILTYPE='DESPATCH' or /EMAIL/RIINFO/EMAILTYPE='PARTIALDESPATCH'">
                            <xsl:if test="/EMAIL/ORDER/CONSIGNMENT/LINE/TRACKABLE='T'">
                                <xsl:if test="not(/EMAIL/ORDER/HEADER/SOURCECODE='WEB' and /EMAIL/ORDER/HEADER/DESTTYPE='STORE')">
                                  <div class="ib">
                                    <a href="{/EMAIL/ORDER/CONSIGNMENT/LINE/HDNLTRACKERURL}">
                                      <img src="http://riverisland.scene7.com/is/image/RiverIsland/track" />
                                    </a>
                                  </div>
                            </xsl:if>
                          </xsl:if>
                          <div class="ib">
                            <a href="http://www.riverisland.com/how-can-we-help/frequently-asked-questions?cmpid=trsRIoms"><img src="http://riverisland.scene7.com/is/image/RiverIsland/faqs" /></a>
                          </div> 
                          <div class="ib">
                            <a href="http://www.riverisland.com/how-can-we-help/frequently-asked-questions/returns/returning-goods?cmpid=trsRIoms"> <img src="http://riverisland.scene7.com/is/image/RiverIsland/returns" /></a>
                          </div>   
                          <xsl:if  test="/EMAIL/ORDER/HEADER/COUNTRY = 'GB' and /EMAIL/ORDER/HEADER/SOURCECODE='WEB'">
                            <div class="ib">
                              <a href="{/EMAIL/RIINFO/COLLECTPLUSURL}?ord={/EMAIL/ORDER/HEADER/ORDERID}"><img src="http://riverisland.scene7.com/is/image/RiverIsland/collect" /></a>
                            </div> 
                          </xsl:if>
                          <xsl:if test="/EMAIL/ORDER/CONSIGNMENT/LINE/TRACKABLE='F'">
                            <div class="ib">
                                <a href="http://www.riverisland.com/styleinsider?cmpid=trsRIoms"> <img src="http://riverisland.scene7.com/is/image/RiverIsland/styleinsider" /></a>
                            </div>     
                          </xsl:if>
                            <div class="ib">
                              <a href="https://www.riverisland.com/signup" ><img src="http://riverisland.scene7.com/is/image/RiverIsland/email" /></a>
                            </div> 
                           <xsl:if  test="not(/EMAIL/ORDER/HEADER/COUNTRY = 'GB')">
                           <div class="ib"> 
                              <a href="http://www.riverisland.com/boys"><img src="http://riverisland.scene7.com/is/image/RiverIsland/picture1" /></a>
                            </div> 
                           </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                              <xsl:when test="/EMAIL/RIINFO/EMAILTYPE='CANCELLED'">
                              <div class="ib">
                                  <a href="http://www.riverisland.com/how-can-we-help/frequently-asked-questions?cmpid=trsRIoms"> <img src="http://riverisland.scene7.com/is/image/RiverIsland/faqs"/> </a>                                </div> 
                                <div class="ib">
                                  <a href="http://www.riverisland.com/how-can-we-help/contact-us?cmpid=trsRIoms"><img src="http://riverisland.scene7.com/is/image/RiverIsland/picture1" /></a>
                                </div> 
                                <div class="ib">
                                  <a href="http://www.riverisland.com"><img src="http://riverisland.scene7.com/is/image/RiverIsland/picture1" /></a>
                                </div> 
                                <div class="ib">
                                  <a href="http://www.riverisland.com"><img src="http://riverisland.scene7.com/is/image/RiverIsland/picture2" /></a>
                                </div> 
                                <div class="ib">
                                  <a href="http://www.riverisland.com"><img src="http://riverisland.scene7.com/is/image/RiverIsland/picture3" /></a>
                                </div> 
                              </xsl:when>
                              <xsl:otherwise>
                              <div class="ib">
                                  <a href="http://www.riverisland.com/how-can-we-help/frequently-asked-questions?cmpid=trsRIoms"><img src="http://riverisland.scene7.com/is/image/RiverIsland/faqs" /></a>
                                </div> 
                              <div class="ib">
                                    <a href="http://riverisland.com"><img src="http://riverisland.scene7.com/is/image/RiverIsland/justarrived" /></a>
                                </div> 
                                <div class="ib">
                                  <a href="https://www.riverisland.com/signup" ><img src="http://riverisland.scene7.com/is/image/RiverIsland/email" /></a>
                                </div> 
                                <div class="ib">
                                  <a href="http://www.riverisland.com"><img src="http://riverisland.scene7.com/is/image/RiverIsland/picture1" /></a>
                                </div> 
                                <div class="ib">
                                 <a href="http://www.riverisland.com"><img src="http://riverisland.scene7.com/is/image/RiverIsland/picture1" /></a>
                                </div> 
                              </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise> 
                        </xsl:choose>
                    </td>
                  </tr>
               </table>  
                </td>
              </tr>
            </table>
            <EMAIL-FOOTER/>
            <!--outside table close-->
          </td>
        </tr>
      </table>
    </font>
</body>
</html>

