-- Credit Card
select extra, time_stamp, regexp_substr(extra,'"type":"[a-z,A-Z]+"') paymentProvider, regexp_substr(extra,'"merchantAccount":"[a-z,A-Z]+"') 
from logger_logs_60_min 
where scope = 's_load_order_util.p_accept_order_api' 
and text like 'Processed order id%'
and extra like '%creditCardPaymentInstrument%';

-- Paypal
select extra, time_stamp, regexp_substr(extra,'"type":"[a-z,A-Z]+"') paymentProvider, regexp_substr(extra,'"merchantAccount":"[a-z,A-Z]+"')
from logger_logs_60_min 
where scope = 's_load_order_util.p_accept_order_api' 
and text like 'Processed order id%'
and extra like '%paypalPaymentInstrument%';


select itemnumber, sku, status_code, created_dtm, pick_load_num from orderitemheader_status where ordernumber=250210974;

select * from pick_load  where pick_load_num in ('MG2202193','MG2202192');

select * from trans_dc_pick_res where pick_load_num='MG2202192'; --'5462978','5462971' X,'5490814' , 22-FEB-19 12:17:45

select * from trans_dc_pick_res where pick_load_num='MG2202193'; --'5462978' X,'5462971','5490814', 22-FEB-19 12:17:45

select * from vw_w_ii_oms_load_order_mdt where ordernumber=250210974;

select * from vw_w_ii_oms_load_item_mdt where ordernumber=250210974;

select * from vw_w_ii_oms_load_sku_upc_mdt where sort_load_id in ('MG2202193','MG2202192'); --'5462971','5462978','5490814','5462971','5462978','5490814'

select * from vw_w_ii_oms_load_sku_dtl_mdt where sort_load_id in ('MG2202193','MG2202192'); -- not duplicated, I don't think is a problem??

select * from vw_w_ii_oms_load_mdt where sort_load_id in ('MG2202193','MG2202192'); -- 22-FEB-19 12:17:57,22-FEB-19 12:17:56

select * from orderitemheader where ordernumber=250210974;  -- six skus : '5462971' X,'5462971','5462978','5462978' X,'5490814','5490814'

SELECT  oihs.ordernumber, res.oms_ord_number, pl.pick_load_num, oihs.pick_load_num, pl.area_id, res.pick_load_num
 FROM   trans_dc_pick_res res
        JOIN orderitemheader_status oihs
            ON (res.oms_ord_number = oihs.ordernumber)
        JOIN pick_load pl
            ON (pl.pick_load_num = oihs.pick_load_num)
        JOIN oms_area oa
            ON (pl.area_id = oa.area_id)
 WHERE  oa.area_type_id = 1 /*oms_const.C_oms_area_type_auto*/
 AND    res.action_code = '02'
 --AND    s_util.f_idx_null_test(res.processed_dtm) = 'T'
 AND    oa.area_id = 2;

select * from oms_area where handle_split_load_ind ='T';

select * from oms_system_params where param_name='MANUAL_SORT';

select * from trans_hso_ord_addr where sk_trans_ord_id=900643048;

select * from trans_dc_hso_pick where pick_load_num='MG1902191';

select * from trans_dc_pick_res where pick_load_num='MG1902190';

select * from trans_dc_pick_res where pick_load_num='MG1902191';

select * from trans_dc_pick_res where oms_ord_number in (250210872,250210874,250210874,250210875,250210875,250210875,250210878,250210878,250210878);

select * from trans_dc_pick_res where oms_ord_number in (250210867,250210868,250210869,250210869,250210869,250210869,250210870,250210870,250210870,250210871,250210871,250210871);


--- Not received payments
select whdr.event_id, whdr.order_number, whdr.created_dtm, opn.amount, ordernetvalue, hdr.shippingcode
from w_io_web_ord_hdr whdr
join orderheader hdr
on (to_number(whdr.order_number) = hdr.ordernumber
    and hdr.pmt_point='02')
left join oms_psp_notification opn
on (hdr.ordernumber = opn.ordernumber
    and opn.eventcode='CAPTURE')
where whdr.event_type='dispatch' 
and whdr.created_dtm > sysdate-4
and opn.eventcode is null
and nvl(hdr.shippingcode,0) not in (12,13);
---

Steps : 
oms_web_order_pick.p_process 
    pl_retry_error_order -- calls pl_send_notif_email if retried successfully
    pl_setup_batch
    pl_validate_and_propagate_err
    IF L_batch_has_missing_order THEN
            pl_send_notif_email(C_error_notif_type);
    END IF;
    IF L_max_retry_notif_needed OR L_batch_has_other_error_order THEN
            pl_create_snow_incident;
    END IF;
    pl_update_mw status = C_os_interfaced_oms = 20
        insert into pick_load, trans_dc_pick_res, 
        update trans_dc_pick_res for primary_pick_load_num
        update orderitemheader_status with status and product attributes for picked records
        update orderitemheader with volume and weight for picked records
        update orderheader_status with status code 
    pl_process_exceptions 
        update orderitemheader 
            set itemstatusmajor = 50 
                lastactioncode = 15 
                reasoncode     = 7 --oms_const.C_category_code_wh_cnl
                refund_reason  = 10 --C_return_reason_item_not_desp
        update orderitemheader_status set status_code = 200 -- C_ois_cancelled
        update orderheader_status set status = 200 if all items cancelled
        delete from w_ii_mds_item_location_alloc and oms_item_location_alloc so that detach sum works 
    IF fl_area_has_pick_ex_item THEN insert into MDT views

Kibana Search :

data.loadID:RI00288900

POS Trans Confluence Docs :
https://riverisland.atlassian.net/wiki/spaces/CFT/pages/1156646044/POS+cash+and+safe+management
https://riverisland.atlassian.net/wiki/spaces/CFT/pages/1173948649/POS+transactions

https://riverisland.atlassian.net/wiki/spaces/SANDRS/pages/41386001/POS+and+Banking+transactions+handover
https://riverisland.atlassian.net/wiki/spaces/RJR/pages/1265041640/CMS+POS+TRANS+Consts


https://riverisland.atlassian.net/wiki/spaces/SANDRS/pages/50659396/GL+interface+handover

https://riverisland.atlassian.net/wiki/spaces/DDR/pages/104794176/MPoS


SELECT res.processed_dtm,res.*
FROM   trans_dc_pick_res res
    JOIN orderitemheader_status oihs
        ON (res.oms_ord_number = oihs.ordernumber)
    JOIN pick_load pl
        ON (pl.pick_load_num = oihs.pick_load_num)
    JOIN oms_area oa
        ON (pl.area_id = oa.area_id)
WHERE  oa.area_type_id = '1' /* oms_const.C_oms_area_type_auto*/
AND    res.action_code = '02' /* oms_const.C_action_code_pick_except*/
--AND    oihs.ordernumber=250210799
--AND    s_util.f_idx_null_test(res.processed_dtm) = 'T'
AND    oa.area_id = 2 /*oms_const.C_mdt_sorter_area_id*/

cms_pos_sales

cms_web_order

cms_store_sales

select * from logger_logs where time_stamp > sysdate - 4/24 and logger_level=2  and scope like 'cms_web_order_payment.%' order by 1 desc;

create table SAR_TMP_LOGGER_EVENTS_1 AS
select 
    id, 
    time_stamp,--  extra, 
    --regexp_substr(extra,'"externalId":"[0-9]+"') order_str, 
    --regexp_substr(extra,'"shippingStatus":"[A-Z,_]+"') status_str,
    --regexp_substr(extra,'"location":"[A-Z,_,0-9 ]+"') location_str,
    to_char(trim('"' from regexp_substr(regexp_substr(extra,'"externalId":"[0-9]+"'),'[^:]+',1,2))) ordernumber,
    to_char(trim('"' from regexp_substr(regexp_substr(extra,'"shippingStatus":"[A-Z,_]+"'),'[^:]+',1,2))) status,
    to_char(trim('"' from regexp_substr(regexp_substr(extra,'"location":"[A-Z,_,0-9 ]+"'),'[^:]+',1,2))) location
from SAR_TMP_LOGGER_EVENTS
order by ordernumber;

select * from SAR_TMP_LOGGER;

select * from logger_logs where time_stamp between to_date('11-FEB-19 15.58','DD-MON-YY HH24:MI') and to_date('11-FEB-19 15.59','DD-MON-YY HH24:MI')
and scope = 'oms_store_order_tracking.p_accept_events_api' and extra like '%52693936%';

select * from logger_logs where logger_level=2 and scope='oms_store_order_tracking.pl_process_event';

select
    cms_attr.f_prd_hier_attr_code(
    'IHF Defaults',-- cms_attr_const.C_attr_ihf_automation,
    'Weight', --cms_attr_const.C_default_weight,
    prd_hier.f_tk(0,5494393)
    ) weight,
    cms_attr.f_prd_hier_attr_code(
    'IHF Defaults',-- cms_attr_const.C_attr_ihf_automation,
    'Cubic Volume', -- cms_attr_const.C_cubic_volume,
    prd_hier.f_tk(0,5494393)
    ) volume
from dual;

SELECT
    oh.orderstatusmajor         AS ordhdr_orderstatusmajor
    ,ohs.status_code            AS ohs_status_code
    ,csg.consignment_status     AS consignment_status
    ,oihs.status_code           AS oihs_status_code
    ,op.package_status          AS package_status
    ,op.gs1_package_barcode     AS gs1_package_barcode
    ,csg.consignment_id         AS consignment_id
    ,oihs.sku                   AS sku
    ,oihs.itemnumber            AS itemnumber
    ,op.cage_id
    ,op.received_dtm
    ,op.collected_dtm
    ,op.reminder_due_dt
    ,op.reminder_sent_dtm
    ,op.return_due_dt
    ,op.returned_dtm
    ,op.return_email_sent_dtm
    ,op.returned_by
    ,oih.itemstatusmajor  
    ,oih.lastactioncode  -- 15 Pick Exception
    ,oih.reasoncode      -- 07 Ware house cancellation for pick ex?
    ,oih.refund_reason   -- 10 Item not despatched
    ,ohs.last_changed_dtm    
    ,ohs.last_changed_by
    ,csg.last_changed_dtm
    ,csg.last_changed_by
    ,oh.lastactioncode
    ,oh.shippingcode
    ,oh.carrier_service_group
    ,oh.ord_store_num
    ,oh.deliv_store_num
    ,oh.dest_type
    ,oh.pmt_point
    ,oh.lang_locale
    ,oih.paymentstatusmajor
    ,oih.paymentstatusminor
FROM orderheader oh
JOIN orderheader_status ohs
    ON(ohs.ordernumber = oh.ordernumber)
JOIN orderitemheader oih
    ON(ohs.ordernumber = oih.ordernumber)
JOIN orderitemheader_status oihs
    ON(oihs.ordernumber = oh.ordernumber)
JOIN oms_consignment csg
    ON(oh.ordernumber = csg.ordernumber
        AND csg.consignment_status not in (199,200))
JOIN oms_package op
    ON (csg.consignment_id = op.consignment_id)
WHERE oh.ordernumber =  52311334;

with all_tocollect as(
    select trunc(received_dtm) dt, count(distinct oc.ordernumber) to_collect_count
    from oms_package op
    join oms_consignment oc
    on (op.consignment_id = oc.consignment_id)
    where received_dtm > to_date('22/01/2019','dd/mm/yyyy')
    group by trunc(received_dtm)
),
all_collected as(
    select trunc(collected_dtm) dt, count(distinct oc.ordernumber) collected_count
    from oms_package op
    join oms_consignment oc
    on (op.consignment_id = oc.consignment_id)
    where collected_dtm > to_date('22/01/2019','dd/mm/yyyy')
    group by trunc(collected_dtm)
),
old_app_use_count as(
    select dt, tocollect_cnt, collected_cnt
    from (
    select trunc(created_dtm) dt, event_type
    from w_io_web_ord_hdr 
    where event_type in ('tocollect','collected') 
    and created_dtm > to_date('22/01/2019','dd/mm/yyyy')
    )
    pivot(
        count(*) cnt
            for event_type in (
                'tocollect'           as tocollect
                ,'collected'           as collected
                )
        )
)
select 
    atc.dt, 
    atc.to_collect_count              as total_tocollect, 
    oa.tocollect_cnt                  as old_app_tocollect,
    ac.collected_count                as total_collected,  
    oa.collected_cnt                  as old_app_collected,
    round((atc.to_collect_count 
        - oa.tocollect_cnt)
        /atc.to_collect_count,2)*100  as new_rec_per,
    round((ac.collected_count
        - oa.collected_cnt)
        /ac.collected_count,2)*100    as new_col_per
from all_tocollect atc
join all_collected ac
on (atc.dt = ac.dt)
join old_app_use_count oa
on(atc.dt = oa.dt) order by 1 desc;

with ucr as
( 
select order_number
from w_io_web_ord_hdr whdr
where created_dtm > sysdate -10 
and event_type='returned-uncollected'
)
select *
from(
    select
        whdr.order_number,
        whdr.event_type,
        whdr.created_dtm,
        hdr.deliv_store_num
    from ucr
    join w_io_web_ord_hdr whdr
    on (ucr.order_number = whdr.order_number)
    join orderheader hdr
    on(to_number(whdr.order_number) = hdr.ordernumber)
    where submit_count is null
) all_events
pivot(
    min(created_dtm) dtm
        for event_type in (
            'dispatch'              as despatch
            ,'redispatch'           as redispatch
            ,'cancel'               as cancel
            ,'tocollect'            as tocollect
            ,'collected'            as collected
            ,'returned-uncollected' as returned_uncollected
            ,'returned-to-store'    as returntostore
            ,'returned-to-dc'       as returntodc
            ,'received-by-dc'       as receivedatdc
            ,'return'               as return
            )
    ) order by despatch_dtm;

with relabel_data as(
select * from(
select
    level lvl,
    gs1_package_barcode,
    package_id,
    orig_package_id,
    created_dtm,
    prior created_dtm as relebl_date,
    prior gs1_package_barcode relabel_gs1_package_barcode
from oms_package 
where created_dtm > sysdate-30
start with orig_package_id is not null 
connect by prior orig_package_id = package_id
) where lvl=2
)
select 
    ordernumber,
    consignment_id,
    parcel_id,
    barcode,
    parcel_code,
    event_type,
    event_dtm -- C_event_tracking_receive=150, C_event_tracking_collection=156, C_event_tracking_return_dc=157
from OMS_ACTIVITY_LOG 
where app_system ='5'/*C_itracker*/ 
and module_id=34 /*C_module_store_tracking*/
and parcel_code in (select gs1_package_barcode from relabel_data)
;

select 
    ordernumber,
    consignment_id,
    parcel_id,
    barcode,
    parcel_code,
    event_type,-- C_event_tracking_receive=150, C_event_tracking_collection=156, C_event_tracking_return_dc=157, C_event_tracking_despatch=160
    event_dtm 
from OMS_ACTIVITY_LOG 
where app_system ='5'/*C_itracker*/ 
and module_id=34 /*C_module_store_tracking*/
and event_type=160 /*C_event_tracking_despatch*/
order by event_dtm desc
;

Also noticed that we have only storeReceivedDate, customerCollectedDate, and returnToDCDate?

select 
    ordernumber,
    consignment_id,
    parcel_id,
    barcode,
    parcel_code,
    event_type,
    event_dtm -- C_event_tracking_receive=150, C_event_tracking_collection=156, C_event_tracking_return_dc=157
from OMS_ACTIVITY_LOG 
where app_system ='5'/*C_itracker*/ 
and module_id=34 /*C_module_store_tracking*/
and event_type=160 /*C_event_tracking_despatch*/
order by event_dtm desc;

select 
    to_char(trunc(event_dtm),'dd-MON-YYYY') collection_date,
    count(*)
from OMS_ACTIVITY_LOG 
where app_system ='5'/*C_itracker*/ 
and module_id=34 /*C_module_store_tracking*/
and event_type=160 /*C_event_tracking_despatch*/
group by trunc(event_dtm)
order by 1 desc;

SELECT
    oh.ordernumber
    ,csg.consignment_status
    ,op.package_status     
    ,op.gs1_package_barcode
    ,csg.consignment_code
    ,op.cage_id
    ,op.received_dtm
    ,op.collected_dtm
    ,op.reminder_due_dt
    ,op.reminder_sent_dtm
    ,op.return_due_dt
    ,op.returned_dtm
    ,op.return_email_sent_dtm
    ,op.returned_by   
    ,csg.last_changed_dtm
    ,csg.last_changed_by
    ,oh.lastactioncode
    ,oh.shippingcode
    ,oh.carrier_service_group
    ,oh.ord_store_num
    ,oh.deliv_store_num
    ,oh.dest_type
    ,oh.pmt_point
    ,oh.lang_locale
FROM sar_tmp_log stl
JOIN orderheader oh
ON(stl.ordernumber = oh.ordernumber)
JOIN oms_consignment csg
ON(oh.ordernumber = csg.ordernumber)
JOIN oms_package op
ON (csg.consignment_id = op.consignment_id)
WHERE csg.consignment_status not in (199,200);

SELECT DISTINCT stl.ordernumber,
    op.cage_id,
    oc.cage_id,
    oc.created_dtm,
    oc.last_changed_dtm,
    oc.cage_status_code,
    ohc.cage_id,
    ohc.created_dtm,
    ohc.last_changed_dtm,
    ohc.cage_status_code
FROM sar_tmp_log stl
JOIN orderheader oh
ON(stl.ordernumber = oh.ordernumber)
JOIN oms_consignment csg
ON(oh.ordernumber = csg.ordernumber)
JOIN oms_package op
ON (csg.consignment_id = op.consignment_id)
left join oms_cage oc
on (op.cage_id = oc.cage_id)
left join oms_hist_cage ohc
on (op.cage_id = ohc.cage_id)
WHERE csg.consignment_status not in (199,200)
and stl.ordernumber=52291289;

29-JAN-2019	1
23-JAN-2019	5
22-JAN-2019	41
21-JAN-2019	13
14-JAN-2019	3
13-JAN-2019	1
12-JAN-2019	1
11-JAN-2019	24
10-JAN-2019	14
09-JAN-2019	5
08-JAN-2019	2
07-JAN-2019	4
04-JAN-2019	11
03-JAN-2019	457
02-JAN-2019	496
01-JAN-2019	20

select * from w_io_web_ord_hdr where order_number in (52401912,52393205,52401772,52395366,52402003)
order by order_number, event_id;

select * from orderheader where ordernumber in (52401912,52393205,52401772,52395366,52402003);

create table sar_tmp_log as
select 
*
from OMS_ACTIVITY_LOG 
where app_system ='5'/*C_itracker*/ 
and module_id=34 /*C_module_store_tracking*/
and event_type=160 /*C_event_tracking_despatch*/
order by event_dtm desc;

SELECT
    oh.ordernumber
    ,csg.consignment_status
    ,op.package_status     
    ,op.gs1_package_barcode
    ,csg.consignment_code
    ,op.cage_id
    ,op.received_dtm
    ,op.collected_dtm
    ,op.reminder_due_dt
    ,op.reminder_sent_dtm
    ,op.return_due_dt
    ,op.returned_dtm
    ,op.return_email_sent_dtm
    ,op.returned_by
    ,csg.last_changed_dtm
    ,csg.last_changed_by
    ,oh.lastactioncode
    ,oh.shippingcode
    ,oh.carrier_service_group
    ,oh.ord_store_num
    ,oh.deliv_store_num
    ,oh.dest_type
    ,oh.pmt_point
    ,oh.lang_locale
FROM orderheader oh
JOIN oms_consignment csg
ON(oh.ordernumber = csg.ordernumber)
JOIN oms_package op
ON (csg.consignment_id = op.consignment_id)
WHERE csg.consignment_status not in (199,200)
and oh.ordernumber in (52584310,52582442,52582740,52586708,52585590,52589643,52586287,52582689,52585114,52580223,52583302,52585814,52585834,52579566,52583296,52585842,52580691,52580714);

select * from oms_cage where cage_id in (1017274,1017278,1012293);

select * from oms_hist_cage where cage_id in (1017274,1017278,1012293);

select * from oms_consignment where ordernumber in (-1017274,-1017278,-1012293);

select sum(ordergrossvalue) from orderheader where ordernumber in (
select ordernumber from sar_tmp_log);

--18296.2
select sum(ordergrossvalue) from orderheader where ordernumber in (
select ordernumber from sar_tmp_log where trunc(event_dtm)= to_date('02-JAN-19','DD-MON-YY'));

--12887.6
select sum(ordergrossvalue) from orderheader where ordernumber in (
select ordernumber from sar_tmp_log where trunc(event_dtm)= to_date('03-JAN-19','DD-MON-YY'));

create table sar_tmp as 
select * from(
select
    level lvl,
    gs1_package_barcode,
    package_id,
    orig_package_id,
    created_dtm,
    prior created_dtm as relebl_date,
    prior gs1_package_barcode relabel_gs1_package_barcode
from oms_package 
where created_dtm > sysdate-30
start with orig_package_id is not null 
connect by prior orig_package_id = package_id
) where lvl=2
;

create table sar_tmp_log as 
select 
    ordernumber,
    consignment_id,
    parcel_id,
    barcode,
    parcel_code,
    event_type,
    event_dtm -- C_event_tracking_receive=150, C_event_tracking_collection=156, C_event_tracking_return_dc=157
from OMS_ACTIVITY_LOG 
where app_system ='5'/*C_itracker*/ 
and module_id=34 /*C_module_store_tracking*/
;

select * from sar_tmp_log where barcode in (
select gs1_package_barcode from sar_tmp);

52370502	46628520	33738275	350522970337382751		156	25-JAN-19 13:10:56
51959713	46267645	33375438	350522970333754383		150	04-JAN-19 17:05:11
51959713	46267645	33375438	350522970333754383		156	04-JAN-19 17:05:50

http://dm-delta.metapack.com/metatrack/track?retailerId=283&orderRef=260006808

http://dm4.metapack.com/metatrack/track?retailerId=283&orderRef=52370502

http://dm4.metapack.com/metatrack/track?retailerId=283&orderRef=-1008244

http://dm4.metapack.com/metatrack/track?retailerId=283&orderRef=51959713

select bytes/(1024*1024) from dba_segments where segment_name like 'SAR_TMP%';

select * from oms_package where gs1_package_barcode='350522970337382751';

select * from oms_package where orig_package_id=33738275;

select * from oms_consignment where consignment_id=46628520;

select * from oms_consignment where ordernumber=52370502;

select * from oms_package where consignment_id in (46681106,46628520);

select 
    ordernumber,
    consignment_id,
    parcel_id,
    barcode,
    parcel_code,
    event_type,
    event_dtm -- C_event_tracking_receive=150, C_event_tracking_collection=156, C_event_tracking_return_dc=157
from OMS_ACTIVITY_LOG 
where app_system ='5'/*C_itracker*/ 
and module_id=34 /*C_module_store_tracking*/;

select trunc(created_dtm), event_type, count(*) cnt
from w_io_web_ord_hdr 
where event_type in ('tocollect','collected') 
and created_dtm > to_date('22/01/2019','dd/mm/yyyy')
group by trunc(created_dtm), event_type;

select count(distinct oc.ordernumber), count(*) 
from oms_package op
join oms_consignment oc
on (op.consignment_id = oc.consignment_id)
where received_dtm > to_date('22/01/2019','dd/mm/yyyy');

This change is to promote the following list of objects and OMS in autopromotion slot.  

Latest revision of s_webservice_config has not been promoted to CMS/WMS and pending since 2014.This change is to promote the latest table to WMS and CMS. ( Only OMS has latest revision)

--Short Description
Promotion for creating/publishing new order event re-despatch - OMSUAT

--Description and Justification
Sometimes delayed parcels being re-despatched by DC staff and this change is to capture and publish such activities as an event to keep order history up-to date. 

--Implementation Plan
Following objects needs to be promoted

oms_web_order_event.pks,1.X,F,OMS
oms_web_order_event.pkb,1.X,F,OMS
oms_despatch.pkb,1.88,F,OMS

--Risk and Impact analysis
We have ammended despatch process as a part of this change. Thoroughly tested in dev/test and uat environments. Hence risk is minimal.

--Backout Plan
If promotion fails then help needed from core support team to identify and fix the root cause. In the worst case please revert back to the following revisions.

oms_web_order_event.pks,1.X,F,OMS
oms_web_order_event.pkb,1.X,F,OMS
oms_despatch.pkb,1.88,F,OMS

--Post Implementation Check:
Post implementation testing will be done by Silver Bullets

select * from orderheader where ordernumber =250210036;

select * from orderitemheader_status where ordernumber=250210036;

select * from oms_consignment where ordernumber=250210036;

select * from oms_package where consignment_id=42907210;

--
-- Query to find out
--
select *
from(
    select
        whdr.order_number,
        whdr.event_type,
        whdr.created_dtm
    from w_io_web_ord_hdr whdr
    where whdr.order_number in (
        SELECT
            to_char(oh.ordernumber)
        FROM orderheader oh
            JOIN orderitemheader oih
            ON(oih.ordernumber = oh.ordernumber)
            JOIN oms_consignment csg
            ON(oh.ordernumber = csg.ordernumber)
            JOIN oms_package op
            ON (csg.consignment_id = op.consignment_id)
        WHERE csg.created_dtm > to_date('21-DEC-18','dd-Mon-yy')
            and oih.cancelleddate < coalesce(op.collected_dtm,
                op.received_dtm,
                csg.created_dtm)
            and oih.reasoncode='06'
            and csg.clone_ind='T'
            and csg.consignment_status in (220,230)
            and oih.sku='SYSTEM_SHIPPING'
    )
) all_events
pivot(
    min(created_dtm) dtm
        for event_type in (
            'dispatch'             as despatch
            ,'cancel'              as cancel
            ,'tocollect'           as tocollect
            ,'collected'           as collected
            ,'returned-to-store'   as returntostore
            ,'received-by-dc'      as receivedatdc
            ,'return'              as return
            )
    );


select *
from(
    select
        whdr.order_number,
        whdr.event_type,
        whdr.created_dtm,
        hdr.deliv_store_num
    from w_io_web_ord_hdr whdr
    join w_io_web_ord_item item
    on(whdr.event_id = item.event_id)
    join orderheader hdr
    on(to_number(whdr.order_number) = hdr.ordernumber
        and dest_type='01')
    where whdr.created_dtm > to_date('24-DEC-18','dd-Mon-yy')
        and submit_count is null
) all_events
pivot(
    min(created_dtm) dtm
        for event_type in (
            'dispatch'             as despatch
            ,'cancel'              as cancel
            ,'tocollect'           as tocollect
            ,'collected'           as collected
            ,'returned-to-store'   as returntostore
            ,'received-by-dc'      as receivedatdc
            ,'return'              as return
            )
    )
where return_dtm < nvl(collected_dtm, tocollect_dtm);

--
-- Return uncollected status changes
--
select *
from(
    select
        whdr.order_number,
        whdr.event_type,
        whdr.created_dtm,
        hdr.deliv_store_num
    from w_io_web_ord_hdr whdr
    join w_io_web_ord_item item
    on(whdr.event_id = item.event_id)
    join orderheader hdr
    on(to_number(whdr.order_number) = hdr.ordernumber
        and dest_type='01')
    where whdr.created_dtm > sysdate - 5
        and submit_count is null
) all_events
pivot(
    min(created_dtm) dtm
        for event_type in (
            'dispatch'              as despatch
            ,'redispatch'           as redispatch
            ,'cancel'               as cancel
            ,'tocollect'            as tocollect
            ,'collected'            as collected
            ,'returned-uncollected' as returned_uncollected
            ,'returned-to-store'    as returntostore
            ,'returned-to-dc'       as returntodc
            ,'received-by-dc'       as receivedatdc
            ,'return'               as return
            )
    )
where returned_uncollected_dtm is not null;

select * from w_io_web_ord_hdr where
order_number in (
)
order by order_number,event_id;

--
-- Live Store Details , Livestore
--
select
    storeid as "storeId", 
    initcap(storename) as "storeName", 
    initcap(country) as "country",
    storeemail as "storeEmail"
from store 
where collection_store_ind='T'
order by storeid;

select *
from(
    select
        whdr.order_number,
        whdr.event_type,
        whdr.created_dtm
    from w_io_web_ord_hdr whdr
    where whdr.order_number in (
    '51943314','51673279','52092239','51518058','51744211','51672749','51606542','51859759','51933075','51557861','51909916','51859110','51934684','51864816','51947642','51735250','52026610','51720346','51721792','51315281','51936646','52033879','51947987','51728196','51719734','52078410','52011229','52048924','51727815','51589132','50596715','51561587'
    )
) all_events
pivot(
    min(created_dtm) dtm
        for event_type in (
            'dispatch'             as despatch
            ,'cancel'              as cancel
            ,'tocollect'           as tocollect
            ,'collected'           as collected
            ,'returned-to-store'   as returntostore
            ,'received-by-dc'      as receivedatdc
            ,'return'              as return
            )
    )
where despatch_dtm is not null
and return_dtm < nvl(collected_dtm, tocollect_dtm);

select *
from(
    select
        whdr.order_number,
        whdr.event_type,
        whdr.created_dtm
    from w_io_web_ord_hdr whdr
    where whdr.order_number in (
        select
            hdr.order_number,
        from w_io_web_ord_hdr hdr
        where created_dtm >  to_date('24-DEC-18','dd-Mon-yy')
        and event_type in ('cancel','return')
        and exists (
        select 1
        from w_io_web_ord_item item
        where item.event_id = hdr.event_id
        and return_code='06'
    )
) all_events
pivot(
    min(created_dtm) dtm
        for event_type in (
            'dispatch'             as despatch
            ,'cancel'              as cancel
            ,'tocollect'           as tocollect
            ,'collected'           as collected
            ,'returned-to-store'   as returntostore
            ,'received-by-dc'      as receivedatdc
            ,'return'              as return
            )
    )
where despatch_dtm is not null
and return_dtm < nvl(collected_dtm, tocollect_dtm);

select *
from (
select
    row_number() over (partition by transaction_type order by transaction_creation_date desc) rn
    ,wr.*
from W_II_REPORTTRANSACTIONS  wr
where transaction_type in (51,52,100,59,76,77,57,58,60,61,62,64,66,67,72,75,78,101,102,103,120)
and transaction_creation_date > sysdate -1000
) where rn <=5
order by rn, transaction_type;

select *
from (
select
    row_number() over (partition by transaction_type order by DATE_TIME_CREATED desc) rn
    ,wr.*
from W_II_REPORTITEMS wr
where transaction_type in (51,52,100,59,76,77,57,58,60,61,62,64,66,67,72,75,78,101,102,103,120)
and DATE_TIME_CREATED > sysdate -1000
) where rn <=5
order by rn, transaction_type;

select * from logger_logs where time_stamp > sysdate -1.2/24 and scope='cms_web_order.p_process_batch' order by 1 ;

select * from logger_logs where id between 202538572 and  202594175 and scope like 'cms_hso_pos%' order by 1 desc;

select *
from logger_logs
where time_stamp = to_timestamp('02-JAN-19 22.55.23.299919000','dd-mon-yy hh24:mi:ss.ff9')
and scope='cms_web_order.p_process_batch';

select
    id,
    job_begin_dtm,
    job_end_dtm
from
(
select
    case when text='End' then lag(id) over(order by time_stamp) else id end as id,
    text,
    time_stamp
from logger_logs
where time_stamp > sysdate -14/24 and scope='cms_web_order.p_process_batch'
)
pivot(
    min(time_stamp) dtm
        for text in (
            'Begin'             as job_begin
            ,'End'              as job_end
            )
    )
order by job_end_dtm - job_begin_dtm desc;

select * from all_tables where table_name like '%TMP_DODGY%';

create table tmp_dodgy_order as
select *
from(
    select
        whdr.order_number,
        whdr.event_type,
        whdr.created_dtm,
        hdr.deliv_store_num
    from w_io_web_ord_hdr whdr
    join w_io_web_ord_item item
    on(whdr.event_id = item.event_id)
    join orderheader hdr
    on(to_number(whdr.order_number) = hdr.ordernumber
    and dest_type='01')
    where whdr.created_dtm > to_date('21-DEC-18','dd-Mon-yy')
        and submit_count is null
) all_events
pivot(
    min(created_dtm) dtm
        for event_type in (
            'dispatch'             as despatch
            ,'cancel'              as cancel
            ,'tocollect'           as tocollect
            ,'collected'           as collected
            ,'returned-to-store'   as returntostore
            ,'received-by-dc'      as receivedatdc
            ,'return'              as return
            )
    )
where despatch_dtm is not null
and return_dtm < nvl(collected_dtm, tocollect_dtm);

select sum(itemunitprice)
from tmp_dodgy_order tdo
join orderitemheader oih
on to_number(tdo.order_number)=oih.ordernumber
and reasoncode='06'
order by ordernumber;

select
    tdo.order_number             as ordernumber
    ,tdo.deliv_store_num         as delivery_store_number
    ,tdo.despatch_dtm            as despatch_date
    ,tdo.tocollect_dtm           as store_received_date
    ,tdo.collected_dtm           as customer_collection_date
    ,tdo.returntostore_dtm       as return_to_store_date
    ,tdo.receivedatdc_dtm        as dc_received_date
    ,tdo.return_dtm              as return_date
    ,ordergrossvalue             as ordervalue
from tmp_dodgy_order tdo
join orderheader hdr
on (to_number(tdo.order_number) = hdr.ordernumber)
where tdo.collected_dtm is not null
and return_dtm <  collected_dtm;

create MATERIALIZED view tmp_dodgy_order as
select
    tdo.order_number             as ordernumber
    ,tdo.deliv_store_num         as delivery_store_number
    ,tdo.despatch_dtm            as despatch_date
    ,tdo.tocollect_dtm           as store_received_date
    ,tdo.collected_dtm           as customer_collection_date
    ,tdo.returntostore_dtm       as return_to_store_date
    ,tdo.receivedatdc_dtm        as dc_received_date
    ,tdo.return_dtm              as return_date
    ,ordergrossvalue             as ordervalue
    ,hdr.orderdate
from tmp_dodgy_order@omsprd tdo
join orderheader@omsprd hdr
on (to_number(tdo.order_number) = hdr.ordernumber)
where tdo.collected_dtm is not null
and return_dtm <  collected_dtm;

--Pack and Despatch Queries
SELECT
    oh.orderstatusmajor         AS ordhdr_orderstatusmajor
    ,ohs.status_code            AS ohs_status_code
    ,csg.consignment_status     AS consignment_status
    ,oihs.status_code           AS oihs_status_code
    ,op.package_status          AS package_status
    ,op.gs1_package_barcode     AS gs1_package_barcode
    ,csg.consignment_id         AS consignment_id
    ,oihs.sku                   AS sku
    ,oihs.itemnumber            AS itemnumber
    ,op.cage_id
    ,oih.itemstatusmajor  
    ,oih.lastactioncode  -- 15 Pick Exception
    ,oih.reasoncode      -- 07 Ware house cancellation for pick ex?
    ,oih.refund_reason   -- 10 Item not despatched
    ,ohs.last_changed_dtm    
    ,ohs.last_changed_by
    ,csg.last_changed_dtm
    ,csg.last_changed_by
    ,oh.lastactioncode
    ,oh.shippingcode
    ,oh.carrier_service_group
    ,oh.ord_store_num
    ,oh.deliv_store_num
    ,oh.dest_type
    ,oh.pmt_point
    ,oh.lang_locale
    ,oih.paymentstatusmajor
    ,oih.paymentstatusminor
FROM orderheader oh
JOIN orderheader_status ohs
    ON(ohs.ordernumber = oh.ordernumber)
JOIN orderitemheader oih
    ON(ohs.ordernumber = oih.ordernumber)
JOIN orderitemheader_status oihs
    ON(oihs.ordernumber = oh.ordernumber)
JOIN oms_consignment csg
    ON(oh.ordernumber = csg.ordernumber
        AND csg.consignment_status not in (199,200))
JOIN oms_package op
    ON (csg.consignment_id = op.consignment_id)
WHERE oh.ordernumber =  52263463;


----- Tocollect and collected checks to-collect and collected checks
SELECT
    oh.orderstatusmajor
    ,ohs.status_code
    ,ohs.last_changed_dtm
    ,ohs.last_changed_by
    ,csg.consignment_status
    ,csg.last_changed_dtm
    ,csg.last_changed_by
    ,csg.consignment_id
FROM orderheader oh
JOIN orderheader_status ohs
ON(ohs.ordernumber = oh.ordernumber)
JOIN oms_consignment csg
ON(oh.ordernumber = csg.ordernumber)
--AND csg.consignment_status not in (199,200))
WHERE oh.ordernumber = 50522044;

SELECT
    oihs.status_code
    ,oihs.last_changed_dtm
    ,oihs.last_changed_by
FROM orderitemheader_status oihs
JOIN orderitemheader oih
ON(oihs.ordernumber = oih.ordernumber
AND oihs.itemnumber = oih.itemnumber)
WHERE oih.ordernumber = 50522044;

SELECT
    pkg.package_id
    ,pkg.package_status
    ,pkg.last_changed_dtm
    ,pkg.last_changed_by
    ,pkg.received_dtm
    ,pkg.received_by
    ,pkg.reminder_due_dt
    ,pkg.store_location_barcode
    ,pkg.collected_dtm
    ,pkg.collection_handled_by
FROM oms_package pkg
WHERE  consignment_id = 44981425;
----

select ordernumber, amount, eventcode, to_char(created_dtm,'dd-mon-yy hh24:mi:ss') created_date
from oms_psp_notification
where ordernumber in (50579654, 50522044, 50029870, 51093233, 51063511, 51107618) order by ordernumber, notification_id desc;

select ordernumber, amount, eventcode, to_char(created_dtm,'dd-mon-yy hh24:mi:ss') created_date
from oms_psp_notification
where ordernumber in (
select to_number(order_number)
from w_io_web_ord_hdr whdr
where
    whdr.created_dtm > to_date('13-DEC-18','DD-MON_YY') --and whdr.event_type='cancel'
and not exists (
select 1 from w_io_web_ord_item witm where witm.event_id=whdr.event_id
)
)
order by ordernumber, notification_id desc;

select ord_id, ord_status, created_dtm, carrier_descr, sc.code
from trans_oms_ord_hdr@pmm hdr
left join s_char_codes@pmm sc
on(hdr.ord_status=sc.num_translation)
where ord_id in ('51093233','51063511','51107181','50350707','50694895','51095124','50579654','51107618','50522044','51094895','50029870','51060550')
and nvl(code_type, 'HSO_ORDER_STATUS')='HSO_ORDER_STATUS'
order by ord_id, created_dtm desc;

sqlcl orderactive/orderactive@omsprd

set timing on;

BEGIN oms_web_order_event.p_publish; END;

select count(*) from w_io_web_ord_hdr
where processed_dtm is null;

lock table w_io_web_ord_hdr in exclusive mode;

@/Volumes/itsr/oms/sql/procs/oms_despatch.pkb
@/Volumes/itsr/oms/sql/procs/oms_tracking_app.pkb
@/Volumes/itsr/oms/sql/procs/oms_web_order_event.pkb

select * from logger_logs where time_stamp between
to_timestamp('19:02:21 09/12/2018','hh24:mi:ss dd/mm/yyyy') and
to_timestamp('19:45:21 09/12/2018','hh24:mi:ss dd/mm/yyyy')
and scope = 'cms_web_order.p_process_batch';

select * from logger_logs where id between  178665861 and 178672944
and scope like 'cms_web_order.%'
order by 1 desc;

select * from logger_logs where id between  178665861 and 178672944
and scope like 'cms_hso_pos.p_gen_sale_pos_for_prepay_ord%'
order by 1 desc;

select count(*) from w_ii_web_ord_hdr; -- 9033

select * from logger_logs where scope='oms_despatch.p_manifest_and_despatch' and time_stamp
between to_timestamp('04-DEC-18 20.11.50.596830000','dd-mon-yy hh24:mi:ss fs10') and ;

select * from logger_logs;

select * from logger_logs where scope like 'oms_despatch.%' and id between 539736833 and 539890622; -- 04-DEC-18 20.11.50.596830000 to 04-DEC-18 21.14.18.460279000

select * from logger_logs where scope='oms_despatch.p_manifest_and_despatch' and id between 539894314 and 539949938; --04-DEC-18 21.15.28.820673000 to 04-DEC-18 21.33.37.667003000

select * from oms_eft_req_hdr
where created_dtm between to_timestamp('04-DEC-18 20.11.50.595','dd-mon-yy hh24:mi:ss ff3') and to_timestamp('04-DEC-18 21.14.18.469','dd-mon-yy hh24:mi:ss ff3')
order by 1 desc;

select to_timestamp('04-DEC-18 20.11.50.595','dd-mon-yy hh24:mi:ss ff3') from dual;

select * from w_ii_pick_load_hdr;

select * from w_ii_pick_load_dtl;

select * from w_ii_pick_load_ord_hdr;

select * from w_ii_pick_load_ord_item;

truncate table w_ii_pick_load_hdr;
truncate table w_ii_pick_load_dtl;
truncate table w_ii_pick_load_ord_hdr;
truncate table w_ii_pick_load_ord_item;

http://ords-alb.dev.transit.ri-tech.io/

http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/demo-api/dbdetails/

http://ords-alb.prod.transit.ri-tech.io/ords/cmsprd/api/demo-api/dbdetails/

http://ords-alb.dev.transit.ri-tech.io/ords/cmsdev/api/demo-api/dbdetails/

select  to_char(time_stamp,'dd-mon-yy hh24') date_hour, count (distinct replace(text, 'Processed order id:','')) order_count
from logger_logs
where time_stamp > sysdate - 15/24 and
scope='s_load_order_util.p_accept_order_api' and text like 'Processed order id:%'
group by  to_char(time_stamp,'dd-mon-yy hh24') order by 1;

select * from logger_logs_5_min where scope = 'wms_web_order.p_process_batch';

select  to_char(time_stamp,'dd-mon-yy hh24') date_hour, count (distinct replace(text, 'Processed order id:',''))
from logger_logs
where time_stamp > sysdate - 10/24 and
scope='s_load_order_util.p_accept_order_api' and text like 'Processed order id:%'
group by  to_char(time_stamp,'dd-mon-yy hh24');

select * from logger_logs_5_min where scope = 'wms_web_order.p_process_batch'

OMS Pick Load import :

Load into work tables
Validations:

oms_web_order_pick
    p_accept_event_api
Validation
-- Check to see if there is a web order within the OMS system : only existance in orderalias should be fine
--Check order quantity isnt greater than orderitemheader
--SKu not in the order
--If any other item is error
--Check to ensure load has not already been interfaced
-- function to get stock quantity

--There are some functions that needs to be retained : p_detach_trolleys

--Load number of pickexceptions are prefixed with Z will it be a problem if we don't follow that convention

-- w_ii_odm_stk_err doing nothing

--Rename things

w_ii_pick_load_hdr
w_ii_pick_load_dtl
w_ii_pick_load_ord_hdr
w_ii_pick_load_ord_item

wms_web_order_pick
oms_web_order_pick
cms_web_order_pick

My suggestion to use prefix : wms_web_order* as all web order related packages starting with this prefix

Package Names
----- TO_COLLECT Testing Dev
1. Invalid store : 404 message = incorrect store and correct store details 
2. Absent parcel : 404 message = parcel not found 
3. TO_COLLECT All OK : 200 update and create activity log


select * from logger_logs_5_min order by 1 desc;

select * from oms_activity_log where app_system=6 order by event_dtm desc;

-- Working example in dev
update oms_package set package_status=190 where package_id=13679983;
update orderitemheader_status set status_code=190 where ordernumber = 2110000001;
update oms_consignment set consignment_status=190 where ordernumber = 2110000001;
update orderheader set orderstatusmajor=40 where ordernumber = 2110000001;
update orderheader_status set status_code=190 where ordernumber = 2110000001;
update orderitemheader set itemstatusmajor=40 where ordernumber = 2110000001;
update orderitemheader_status set status_code=220 where ordernumber = 2110000001 and itemnumber=-61120532;

select * from orderitemheader_status where  ordernumber = 2110000001;


update oms_package set package_status=190 where package_id=13679984;
update orderitemheader_status set status_code=190 where ordernumber = 2110000004;
update oms_consignment set consignment_status=190 where ordernumber = 2110000004;
update orderheader set orderstatusmajor=40 where ordernumber = 2110000004;
update orderheader_status set status_code=190 where ordernumber = 2110000004;
update orderitemheader set itemstatusmajor=40 where ordernumber = 2110000004;

SELECT
    oh.orderstatusmajor
    ,ohs.status_code
    ,ohs.last_changed_dtm
    ,ohs.last_changed_by
    ,csg.consignment_status
    ,csg.last_changed_dtm
    ,csg.last_changed_by
    ,csg.consignment_id
FROM orderheader oh
JOIN orderheader_status ohs
ON(ohs.ordernumber = oh.ordernumber)
JOIN oms_consignment csg
ON(oh.ordernumber = csg.ordernumber)
--AND csg.consignment_status not in (199,200))
WHERE oh.ordernumber = 2110000004;

SELECT
    oihs.status_code
    ,oihs.last_changed_dtm
    ,oihs.last_changed_by
FROM orderitemheader_status oihs
JOIN orderitemheader oih
ON(oihs.ordernumber = oih.ordernumber
AND oihs.itemnumber = oih.itemnumber)
WHERE oih.ordernumber = 2110000004;

SELECT
    pkg.package_id
    ,pkg.gs1_package_barcode
    ,pkg.package_status
    ,pkg.last_changed_dtm
    ,pkg.last_changed_by
    ,pkg.received_dtm
    ,pkg.received_by
    ,pkg.reminder_due_dt
    ,pkg.store_location_barcode
    ,pkg.collected_dtm
    ,pkg.collection_handled_by
    ,pkg.*
FROM oms_package pkg
WHERE  consignment_id = 26638763;



set serveroutput on;

DECLARE
    j apex_json.t_values;
BEGIN
    apex_json.parse(j, '{"D1":"2018-09-25T10:49:45Z", "D2":"2018-11-25T10:49:45Z"}');

dbms_output.put_line(to_char(apex_json.get_date(p_path=>'D1',p_values=>j), 'DD-MM-YYYY hh24:mi:ss'));
dbms_output.put_line(to_char(apex_json.get_date(p_path=>'D2',p_values=>j), 'DD-MM-YYYY hh24:mi:ss'));
END;
/

select * from logger_logs where text ='Processed order id:50051853' and time_stamp > sysdate -2;

--
with dispatches as(
    select order_number, shipping_status, created_dtm, event_type
    from w_io_web_ord_hdr
    where created_dtm > trunc(sysdate-1)
    and io_error_id is null
    and event_type='dispatch'
),
canceles as (
    select order_number, shipping_status, created_dtm, event_type
    from w_io_web_ord_hdr
    where created_dtm > trunc(sysdate-1)
    and io_error_id is null
    and event_type='cancel'
),
returns as (
    select order_number, shipping_status, created_dtm, event_type
    from w_io_web_ord_hdr
    where created_dtm > trunc(sysdate-1)
    and io_error_id is null
    and event_type='return'
)
select *
from dispatches d
join canceles c
on (c.order_number = d.order_number)
join returns r
on (d.order_number = r.order_number);

select
    ordernumber,
    eventcode,
    event_dtm,
    merchantreference,
    amount,
    success_ind,
    ltrim(replace(merchantreference,ordernumber,''),'-') event_uuid
from oms_psp_notification
where created_dtm > sysdate -2 and success_ind='T'; -- eventcode= CAPTURE, REFUND, CAPTURE_FAILED

with dispatchandreturn as(
select
    event_uuid,
    order_number,
    shipping_status,
    created_dtm,
    event_type
from w_io_web_ord_hdr
where created_dtm > trunc(sysdate-1)
and io_error_id is null
and event_type in ('dispatch','return')
),
paymentnotifs as (
    select
        ordernumber,
        eventcode,
        event_dtm,
        merchantreference,
        amount,
        success_ind,
        ltrim(replace(merchantreference,ordernumber,''),'-') event_uuid
    from oms_psp_notification
    where created_dtm > sysdate -2
    and success_ind='T' -- eventcode= CAPTURE, REFUND, CAPTURE_FAILED
)
select
    dr.event_uuid,
    dr.order_number,
    dr.shipping_status,
    dr.created_dtm,
    dr.event_type,
    pn.amount,
    pn.event_uuid
from dispatchandreturn dr
join orderheader hdr
on (dr.order_number = hdr.ordernumber
    and hdr.pmt_point !='01'
    and ord_channel!='GLOBAL-E')
left join paymentnotifs pn
on (dr.event_uuid = pn.event_uuid)
where pn.event_uuid is null
order by dr.created_dtm;

update oms_carrier set internal_carrier_ind ='F' where carrier_id='DPD';

Insert into oms_wh_srvc_grp_trlt (WAREHOUSE_ID,SERVICE_GROUP_ID,TO_WAREHOUSE_ID,TO_SERVICE_GROUP_ID,RELABEL_IND) values (1,'11',3,'11','T');

delete from oms_wh_srvc_grp_trlt where SERVICE_GROUP_ID=11;

G_cnl_sts         := s_code.f_trlt_to_num('HSO_ORDER_STATUS',
                                            'CANCELLED');

G_partial_dsp_sts := s_code.f_trlt_to_num('HSO_ORDER_STATUS','PARTIAL_DISPATCH');

G_dsp_sts         := s_code.f_trlt_to_num('HSO_ORDER_STATUS','DISPATCHED');

G_complete_sts    := s_code.f_trlt_to_num('HSO_ORDER_STATUS','COMPLETE');

G_rtn_sts         := s_code.f_trlt_to_num('HSO_ORDER_STATUS',
                                            'RETURNED');

G_rfd_sts         := s_code.f_trlt_to_num('HSO_ORDER_STATUS',
                                            'REFUND');

G_str_rtn_sts     := s_code.f_trlt_to_num('HSO_ORDER_STATUS',
                                            'STORE_RETURNED');

select s_code.f_trlt_to_num('HSO_ORDER_STATUS','CANCELLED') from dual; -- cancelled 3
select s_code.f_trlt_to_num('HSO_ORDER_STATUS','PARTIAL_DISPATCH') from dual; -- 4
select s_code.f_trlt_to_num('HSO_ORDER_STATUS','DISPATCHED') from dual; -- 5
select s_code.f_trlt_to_num('HSO_ORDER_STATUS','COMPLETE') from dual; -- 6

select sk_file_till_id from trans_hso_ord_hdr@pmm where ord_id=45640195;

select
oh.ordernumber,
ohs.status_code,
ohs.created_dtm,
oh.orderdate
from orderheader oh
left join orderheader_status ohs
on (oh.ordernumber = ohs.ordernumber)
where ohs.ordernumber is null
order by ordernumber desc;

select distinct lang_locale, ord_currency from trans_hso_ord_hdr where ord_currency='USD';

en-US	USD
fr-FR	USD
de-DE	USD
en-GB	USD

-------------------------------------------------------------------------------------------------------
orderheader
reasoncode    => C_category_code_wh_cnl  CONSTANT actionmessageheader.actiontype%TYPE := '07';
refund_reason => C_return_reason_item_not_desp CONSTANT s_num_codes.code%TYPE := 10;

oh.reasoncode                       AS return_code,
oh.refund_reason                    AS reason,
-------------------------------------------------------------------------------------------------------
delete from w_io_web_ord_hdr where order_number=48694044;

delete from w_io_web_ord_hdr where event_id in (select event_id from w_io_web_ord_hdr where order_number=48694044);

select ord_id,ord_store_num, deliv_store_num,lang_locale, created_dtm, pos_sk_sale_id, till_receipt_id, ord_source
from trans_hso_ord_hdr where created_dtm > sysdate-10 and ord_currency='WER'; and ord_source <> 'WEB';

select * from logger_logs where time_stamp between
to_timestamp('11-SEP-18 10:30:20','dd-mon-yy hh24:mi:ss') and
to_timestamp('11-SEP-18 10:37:20','dd-mon-yy hh24:mi:ss')
and text like '%49059792%';

select  ord_id,ord_store_num, deliv_store_num,lang_locale, created_dtm, pos_sk_sale_id, till_receipt_id, ord_source, ord_currency
from trans_hso_ord_hdr where ord_source = 'STORE' and ord_currency='EUR' and created_dtm > sysdate-10 and deliv_store_num is null;

oh.orderstatusmajor      : ready to despatch=30, despatched=50, cancel=60, hold=80, receievd=220, collected=230, rtnd to dc=240, rcvd at dc=250 , rtnd to store=260
oh.orderstatusminor      : none=0, loss prevent=200, dupe cust=240

oih.itemstatusmajor      : Picking=25, packed=30, cancel=50, despatch=40, received=220, collected=230 , returned to dc=240, returned to store=260
oih.itemstatusminor      : not Charged=10, Charge confirm=20, confirm refund=40, failed payment=60, wait pick alloc=500
oih.paymentstatusmajor   : authorised=20, Wait charge=30, Charged=40, wait refund=50, refunded=60, fail auth=900, fail refund=920,
oih.paymentstatusminor   : Wait charge=10, complete=30, problem card=920

oms_package.package_status
packed=150, caged=170, despatched=190, cancelled=200, received=220, collected=230, rtnd to dc=240, rcvd at dc=250 , rtnd to store=260
oms_consignmnet.consignment_status
packed=150, caged=170, ready to manifest=180, despatched=190, marked for cancellation=199, cancelled=200, failed=210, received=220, collected=230, rtnd to dc=240, rcvd at dc=250 , rtnd to store=260
orderitemheader_status.status_code
on order=10, interfaced to oms=20, failed=30, ready for release=40, released=50, sorted=90, located=110, ready for pack=120, packing=130, pack allocated=140, packed=150, caged=170, ready for despatch=180, despatched=190, cancelled=200, received=220, collected=230, rtnd to dc=240, rcvd at dc=250 , rtnd to store=260

;
-- Global-e return, globale
select
hdr.ordernumber,
hdr.external_order_reference
from orderheader hdr
join orderitemheader oih
on (hdr.ordernumber = oih.ordernumber)
where hdr.orderdate > sysdate-10 
and hdr.shippingcode in (12,13)
and hdr.orderstatusmajor in (240,250,260,200);
--and oih.itemstatusmajor in (240,250,260,200);

select
hdr.ordernumber,
hdr.external_order_reference,
oihs.sku,
oihs.status_code
from orderheader hdr
join orderitemheader_status oihs
on (hdr.ordernumber = oihs.ordernumber)
where hdr.orderdate > sysdate-10 
and hdr.shippingcode in (12,13)
and oihs.status_code in (240,250,260);
--and oih.itemstatusmajor in (240,250,260,200);

select
hdr.ordernumber,
hdr.external_order_reference,
oc.consignment_status
from orderheader hdr
join oms_consignment oc
on (hdr.ordernumber = oc.ordernumber)
where hdr.orderdate > sysdate-10 
and hdr.shippingcode in (12,13)
and oc.consignment_status in (240,250,260);

select
hdr.ordernumber,
hdr.external_order_reference,
oihs.sku,
oihs.status_code
from orderheader hdr
join orderitemheader_status oihs
on (hdr.ordernumber = oihs.ordernumber)
where hdr.orderdate > sysdate-400 
and hdr.shippingcode in (12,13)
and oihs.status_code in (240,250,260);

select * from orderitemheader where ordernumber=52338426;

01    Damaged on receipt
02    Damaged by customer
03    Not actionable
04    Clear mispick
05    Resaleable
06    Other customer service action
07    Warehouse cancel - no stock
08    DSR customer cancellation
09    Refunded return

select distinct refund_reason from orderitemheader where cancelleddate > sysdate -100 and refund_reason is not null and rownum < 100;

select * from reasoncode where reasoncodeid in (30, 20, 70, 50, 60);

select * from categorycodes;

select * from actioncodes;

select * from reasoncode;

returned to store and returned

return uncollected and returned

select * from w_io_web_ord_hdr where order_number='250209571';

select * from oms_consignment where ordernumber=250209571;

select distinct oih.ordernumber, oih.itemnumber, oih.itemseq,oih.sku, oih.itemstatusmajor, oih.itemstatusminor, sa.skualias, oihs.status_code, oihs.service_group
from orderitemheader oih
join stockskualias sa
on (oih.sku=sa.sku)
join orderheader_status oihs
on (oih.ordernumber=oihs.ordernumber)
where oih.ordernumber=250209571
and sa.sku<>sa.skualias;

select package_id, consignment_id, package_status, gs1_package_barcode, cage_id, created_dtm, last_changed_dtm, orig_package_id
from oms_package where consignment_id in (42907086,42907088,42907089);

select op.package_id, op.consignment_id, op.package_status, op.gs1_package_barcode, op.cage_id, op.created_dtm,opi.created_dtm,opi.itemnumber, op.last_changed_dtm, op.orig_package_id
from oms_package op
join oms_package_item opi
on(op.package_id = opi.package_id)
where consignment_id in (42907086,42907088,42907089)
order by opi.itemnumber;

update w_io_web_ord_hdr set processed_dtm=null, resp_json=null
where order_number='250209571';

select * from logger_logs_60_min where scope like 'oms_web_order_event%' order by 1 desc;

select * from logger_logs_60_min where scope like 'oms_despatch%' order by 1 desc;

update oms_carrier set internal_carrier_ind ='F' where carrier_id='DPD';

Insert into oms_wh_srvc_grp_trlt (WAREHOUSE_ID,SERVICE_GROUP_ID,TO_WAREHOUSE_ID,TO_SERVICE_GROUP_ID,RELABEL_IND) values (1,'11',3,'11','T');


delete from oms_wh_srvc_grp_trlt where SERVICE_GROUP_ID=11;


BEGIN oms_despatch.p_manifest_and_despatch; END;;

TODO:

DROP TABLE tmp_w_io_web_ord_hdr;
DROP TABLE tmp_w_io_web_ord_item;
DROP TABLE tmp_w_io_web_ord_hdr_1312;
DROP TABLE tmp_w_io_web_ord_item_1312;
DROP TABLE tmp_w_io_web_ord_item_can;
DROP TABLE tmp_w_io_web_ord_hdr_new;
DROP TABLE tmp_w_io_web_ord_item_new;

DROP TABLE TMP_W_IO_WEB_ORD_HDR;
DROP TABLE TMP_W_IO_WEB_ORD_ITEM;
DROP TABLE SAR_TEMP_1;
DROP TABLE TMP_W_IO_WEB_ORD_ITEM_CAN;
DROP TABLE TMP_W_IO_WEB_ORD_HDR_CAN;
DROP TABLE TMP_W_IO_WEB_ORD_HDR_1312;
DROP TABLE TMP_W_IO_WEB_ORD_ITEM_1312;
DROP TABLE TMP_DODGY_ORDER_OLD;
DROP TABLE TMP_DODGY_ORDER_WITH_PP_REFUND;
DROP TABLE TMP_DODGY_ORDER;

create table as select * from TMP_W_IO_WEB_ORD_HDR@omsprd;
create table as select * from TMP_W_IO_WEB_ORD_ITEM@omsprd;
create table as select * from SAR_TEMP_1@omsprd;
create table as select * from TMP_W_IO_WEB_ORD_ITEM_CAN@omsprd;
create table as select * from TMP_W_IO_WEB_ORD_HDR_CAN@omsprd;
create table as select * from TMP_W_IO_WEB_ORD_HDR_1312@omsprd;
create table as select * from TMP_W_IO_WEB_ORD_ITEM_1312@omsprd;
create table as select * from TMP_DODGY_ORDER_OLD@omsprd;
create table as select * from TMP_DODGY_ORDER_WITH_PP_REFUND@omsprd;
create table as select * from TMP_DODGY_ORDER@omsprd;

create table TMP_W_IO_WEB_ORD_HDR as select * from TMP_W_IO_WEB_ORD_HDR@omsprd;
create table TMP_W_IO_WEB_ORD_ITEM as select * from TMP_W_IO_WEB_ORD_ITEM@omsprd;
create table SAR_TEMP_1 as select * from SAR_TEMP_1@omsprd;
create table TMP_W_IO_WEB_ORD_ITEM_CAN as select * from TMP_W_IO_WEB_ORD_ITEM_CAN@omsprd;
create table TMP_W_IO_WEB_ORD_HDR_CAN as select * from TMP_W_IO_WEB_ORD_HDR_CAN@omsprd;
create table TMP_W_IO_WEB_ORD_HDR_1312 as select * from TMP_W_IO_WEB_ORD_HDR_1312@omsprd;
create table TMP_W_IO_WEB_ORD_ITEM_1312 as select * from TMP_W_IO_WEB_ORD_ITEM_1312@omsprd;
create table TMP_DODGY_ORDER_OLD as select * from TMP_DODGY_ORDER_OLD@omsprd;
create table TMP_DODGY_ORDER_WITH_PP_REFUND as select * from TMP_DODGY_ORDER_WITH_PP_REFUND@omsprd;
create table TMP_DODGY_ORDER as select * from TMP_DODGY_ORDER@omsprd;

TODO:


create table tmp_w_io_web_ord_hdr as
select *
from w_io_web_ord_hdr where event_id in(
select
event_id --, item_number, count(*)
from w_io_web_ord_item where created_dtm > sysdate -5
group by item_number, event_id
having count(*) > 1
)
and event_type='dispatch';

create table tmp_w_io_web_ord_item
as
select * from w_io_web_ord_item where event_id in(
select event_id from tmp_w_io_web_ord_hdr);

DELETE FROM tmp_w_io_web_ord_item
WHERE created_dtm > SYSDATE -5
AND (event_id,item_number, gs1_package_barcode) IN
(
WITH tmp AS(
SELECT
    twi.event_id,
    twi.item_number,
    twi.gs1_package_barcode,
    pkg.orig_package_id,
    item.created_dtm,
    ROW_NUMBER() OVER (
        PARTITION BY item.itemnumber
        ORDER BY
            pkg.orig_package_id DESC NULLS LAST,
            item.created_dtm DESC
        )  AS item_rank
FROM  tmp_w_io_web_ord_item twi
    JOIN orderitemheader oih
        ON(twi.item_number = oih.itemnumber)
    JOIN oms_package_item item
        ON (oih.itemnumber = item.itemnumber)
    JOIN oms_package pkg
        ON (item.package_id = pkg.package_id
        AND pkg.gs1_package_barcode = twi.gs1_package_barcode)
ORDER BY 1,2
)
SELECT
    event_id,
    item_number,
    gs1_package_barcode
FROM tmp
WHERE item_rank!=1
);

select *
from w_io_web_ord_hdr whdr
    join orderheader hdr
        on(to_number(whdr.order_number) = hdr.ordernumber)
where
    whdr.created_dtm > sysdate-6 and whdr.event_type='cancel'
and not exists (
select 1 from w_io_web_ord_item witm where witm.event_id=whdr.event_id
)
and hdr.pmt_point in ('01', '03');

update w_io_web_ord_hdr set processed_dtm=null, resp_json=null where event_id in
(select event_id from tmp_w_io_web_ord_hdr);

:TODO: --13 Dec 2018
create table tmp_w_io_web_ord_hdr_1312 as
select *
from w_io_web_ord_hdr where event_id in(
select
event_id --, item_number, count(*)
from w_io_web_ord_item where created_dtm > sysdate -5
group by item_number, event_id
having count(*) > 1
)
and event_type='dispatch';

select * from tmp_w_io_web_ord_hdr_1312;

select distinct submit_count from tmp_w_io_web_ord_hdr_1312;

create table tmp_w_io_web_ord_item_1312
as
select * from w_io_web_ord_item where event_id in(
select event_id from tmp_w_io_web_ord_hdr_1312);

delete from w_io_web_ord_item where created_dtm > sysdate -5 and (event_id,item_number, gs1_package_barcode) in
(
with tmp as(
SELECT
    twi.event_id,
    twi.item_number,
    twi.gs1_package_barcode,
    pkg.orig_package_id,
    item.created_dtm,
    ROW_NUMBER() OVER (
        PARTITION BY item.itemnumber
        ORDER BY
            pkg.orig_package_id DESC NULLS LAST,
            item.created_dtm DESC
        )  AS item_rank
FROM  tmp_w_io_web_ord_item_1312 twi
    JOIN orderitemheader oih
        ON(twi.item_number = oih.itemnumber)
    JOIN oms_package_item item
        ON (oih.itemnumber = item.itemnumber)
    JOIN oms_package pkg
        ON (item.package_id = pkg.package_id
        AND pkg.gs1_package_barcode = twi.gs1_package_barcode)
--order by 1,2
)
select
    event_id,
    item_number,
    gs1_package_barcode
from tmp
where item_rank!=1
);



:TODO: --13 Dec 2018


delete from w_io_web_ord_item where created_dtm > sysdate -5 and (event_id,item_number, gs1_package_barcode) in
(
with tmp as(
SELECT
    twi.event_id,
    twi.item_number,
    twi.gs1_package_barcode,
    pkg.orig_package_id,
    item.created_dtm,
    ROW_NUMBER() OVER (
        PARTITION BY item.itemnumber
        ORDER BY
            pkg.orig_package_id DESC NULLS LAST,
            item.created_dtm DESC
        )  AS item_rank
FROM  tmp_w_io_web_ord_item twi
    JOIN orderitemheader oih
        ON(twi.item_number = oih.itemnumber)
    JOIN oms_package_item item
        ON (oih.itemnumber = item.itemnumber)
    JOIN oms_package pkg
        ON (item.package_id = pkg.package_id
        AND pkg.gs1_package_barcode = twi.gs1_package_barcode)
--order by 1,2
)
select
    event_id,
    item_number,
    gs1_package_barcode
from tmp
where item_rank!=1
);

update w_io_web_ord_hdr set processed_dtm=null, resp_json=null
where event_id in(
select event_id from tmp_w_io_web_ord_hdr_1312
);

--- Cancel events

create table tmp_w_io_web_ord_item_can as
select
    whdr.event_id      AS event_id,
    oih.itemnumber     AS item_number,
    oih.itemseq        AS item_seq,
    oih.sku            AS sku_id,
    oih.reasoncode     AS return_code,
    oih.refund_reason  AS reason_code,
    sysdate            AS created_dtm,
    CAST( NULL AS VARCHAR2(18))             AS gs1_package_barcode
from w_io_web_ord_hdr whdr
    join orderheader hdr
        on(to_number(whdr.order_number) = hdr.ordernumber)
    join orderitemheader oih
    on(oih.ordernumber=hdr.ordernumber
    and oih.itemstatusmajor = 50)
where
    whdr.created_dtm > sysdate-6 and whdr.event_type='cancel'
and not exists (
select 1 from w_io_web_ord_item witm where witm.event_id=whdr.event_id
)
and hdr.pmt_point in ('01', '03')
order by 1 desc;

create table tmp_w_io_web_ord_hdr_can as
select * from w_io_web_ord_hdr
where event_id in(
select event_id from tmp_w_io_web_ord_item_can
);

select * from tmp_w_io_web_ord_hdr_new;

select * from tmp_w_io_web_ord_item_new;

--TODO:
insert into w_io_web_ord_item(
    event_id,
    item_number,
    item_seq,
    sku_id,
    return_code,
    reason_code,
    created_dtm,
    gs1_package_barcode
)
select
    event_id,
    item_number,
    item_seq,
    sku_id,
    return_code,
    reason_code,
    created_dtm,
    gs1_package_barcode
FROM tmp_w_io_web_ord_item_can;

update w_io_web_ord_hdr set processed_dtm=null, resp_json=null, event_uuid=s_web_util.f_build_uuid()
where event_id in(
select event_id from tmp_w_io_web_ord_item_can
);


select twhdr.event_id, twhdr.order_number, whdr.order_number, twhdr.req_json, whdr.req_json
from tmp_w_io_web_ord_hdr_can twhdr
join w_io_web_ord_hdr whdr
on (twhdr.event_id=whdr.event_id);

--TODO:

select order_number, created_dtm, event_uuid
from tmp_w_io_web_ord_hdr_new
order by created_dtm desc;

28 pre-pay cancel events are also affected where core has not sent the cancel line item details. I dont see any refund issued for these orders, I believe payments will not issue refund to the customer until we send the lineitem details to them. So we have to retry these. I think with different uuid so that payment wont consider these as duplicate

select ordernumber, count(*)
from oms_consignment oc
where oc.consignment_status not in (199,200)
and clone_ind is null
group by ordernumber
having count(*) > 1
order by 2 desc; -- no rows

select ordernumber, count(*)
from oms_consignment oc
where oc.consignment_status not in (199,200)
and clone_ind='T'
group by ordernumber
having count(*) > 1
order by 2 desc; -- 172 rows

select consignment_id, count(distinct cage_id) , created_dtm, package_status
from oms_package op
where op.package_status not in (199,200) and created_dtm > sysdate-10
group by consignment_id
having count(distinct cage_id) > 2
order by 2 desc;

select consignment_id, cage_id , created_dtm, package_status
from oms_package op
where consignment_id=45426639;

select consignment_id, ordernumber , created_dtm, consignment_status
from oms_consignment
where consignment_id=45426639;

select ordernumber, itemnumber, sku, itemstatusmajor
from orderitemheader
where ordernumber in (50965408)
order by 1 ;

select event_id, created_dtm, event_type from w_io_web_ord_hdr where order_number='50965408' order by 1 desc;

select event_id, item_number, sku_id from w_io_web_ord_item where event_id=4001580 order by 1 desc;


select event_id, created_dtm, event_type from w_io_web_ord_hdr

SELECT pkg.cage_id,cg.cage_status_code,csg.*
--BULK COLLECT INTO L_package_id_tbl
FROM   oms_package pkg
       JOIN oms_cage cg
           ON (cg.cage_id = pkg.cage_id)
       JOIN oms_consignment csg
           ON (csg.consignment_id = pkg.consignment_id)
WHERE  cg.cage_status_code = 55;-- oms_const.C_cage_queued
;

SELECT pkg.cage_id, count(*)
--BULK COLLECT INTO L_package_id_tbl
FROM   oms_package pkg
       JOIN oms_cage cg
           ON (cg.cage_id = pkg.cage_id)
       JOIN oms_consignment csg
           ON (csg.consignment_id = pkg.consignment_id)
group by pkg.cage_id;

update oms_package set cage_id = case mod(rownum,3) when 0 then 284869  when 1 then 284870 else 284871 end;

update oms_package set cage_id = case mod(rownum,3) when 0 then 284869  when 1 then 284870 else 284871 end  where cage_id=284869 ;

update oms_cage set cage_status_code = 55 where cage_id in (284869);

select * from oms_cage where cage_id in (284869,284870,284871);

select
    oih.ordernumber,
    oih.itemnumber,
    oih.sku,
    oih.itemstatusmajor,
    oih.itemstatusminor,
    oih.paymentstatusmajor,
    oih.paymentstatusminor,
    oih.lastactioncode,
    oih.grossvalue,
    oih.amountpaid,
    oh.pmt_point
from   orderitemheader oih
join orderheader oh
on(oih.ordernumber=oh.ordernumber)
where  oh.ordernumber in ('50328701','50318327','50324044','50327238','50328636','50327798','50326696','50329288','50322924','50308948','50319917','50325202','50320814','50324126','50323153');;

select
    oih.ordernumber,
    oih.itemnumber,
    oih.sku,
    oih.itemstatusmajor,
    oih.itemstatusminor,
    oih.paymentstatusmajor,
    oih.paymentstatusminor,
    oih.lastactioncode
from   orderitemheader oih
    JOIN oms_refund_req req
        ON (req.itemnumber = oih.itemnumber)
where oih.lastactioncode not in (10, 15)/* 10 manual cancel and 15 pick exception*/ ;

Return Query

SELECT oih.ordernumber,
    oh.sourcecode,
    MIN(
        DECODE(oih.lastactioncode,
                /*oms_const.C_actn_code_manual_canc*/ 10, /*C_ord_cancel*/ 1,
                /*oms_const.C_actn_code_pick_ex*/ 15, /*C_ord_cancel*/ 1,
                /*C_ord_with_refund*/  0)
        ) ord_cancel_status,   -- 1=cancel, 0=refund if all order item are cancels
    MIN(itemseq) min_itemseq,  -- if a zero is present then a shipping line
    MAX(opp.psp_name) psp_name
FROM   orderitemheader oih
    JOIN oms_refund_req req
        ON (req.itemnumber = oih.itemnumber)
    JOIN order_tndr tndr
        ON (tndr.ordernumber = oih.ordernumber)
    JOIN oms_payment_provider opp
        ON (tndr.payment_provider = opp.payment_provider)
    JOIN orderheader oh
        ON (oih.ordernumber = oh.ordernumber)
WHERE  req.processed_dtm IS NOT NULL
GROUP  BY oih.ordernumber, oh.sourcecode

SELECT (
        CASE
            WHEN SUM(DECODE (cc.refund_shipping, s_const.C_yes, 1, 0)) =
                        L_tot_items
            THEN
                    s_const.C_true
            WHEN MIN(oh.cancel_request_dtm) IS NOT NULL
            AND  COUNT(*) = L_tot_items
            THEN
                    s_const.C_true
            ELSE
                    s_const.C_false
        END
        )
INTO   L_returnship_flag
FROM   orderitemheader oih
        JOIN orderheader oh
            ON (oh.ordernumber = oih.ordernumber)
        JOIN categorycodes cc
            ON (cc.categorycode = oih.reasoncode)
WHERE  oih.ordernumber =  FV_rec.ordernumber
AND    oih.itemstatusmajor IN (/*oms_const.C_orditm_maj_stat_canc*/50, /*oms_const.C_orditm_maj_stat_rtn_to_str*/ 260)
AND    (oih.lastactioncode NOT IN
            (/*oms_const.C_actn_code_manual_canc*/ 10,
                /*oms_const.C_actn_code_pick_ex*/ 15)
        OR
        oih.lastactioncode IS NULL
        )
AND    EXISTS(
            SELECT 1
            FROM   orderitemheader oiha
            WHERE  sku                   = 'SYSTEM_SHIPPING' /*oms_const.C_shipping_sku_val*/
            AND    ordernumber           = FV_rec.ordernumber
            AND    oiha.itemstatusmajor != /*oms_const.C_orditm_maj_stat_canc*/ 50);

After returns

/*** Clean up***/
DROP
-- CMS Objects related to bringing card_bin, card_summary, expiry_date from OMS
W_II_OMS_CARD_AUTH
VW_W_IO_OMS_CARD_AUTH_ALIAS
TRANS_CARD_AUTH
-- OMS Objects related to bringing card_bin, card_summary, expiry_date into CMS
W_IO_CARD_AUTH
VW_W_IO_OMS_CARD_AUTH_ALIAS
Section of OMS_EFT_NOTIFICATION
cms_oms_import_order.pl_update_card_auth is not required


select * from trans_hso_ord_addr where
(addr_line_1  like '%'||CHR(13)||'%'
or addr_line_2 like '%'||CHR(13)||'%'
or addr_line_3 like '%'||CHR(13)||'%'
--or addr_line_1 like '%'||CHR(10)||'%'
--or addr_line_2 like '%'||CHR(10)||'%'
--or addr_line_3 like '%'||CHR(10)||'%'
)
and created_dtm > sysdate - 30
and sk_trans_ord_id=893185185;

Intrastat

Output File details : /apps/projects/cms/dev/marker/websal*

two files with extension .mkr and .dat

Intrastat report to exclude all global-e orders is promoted for testing if you have time this sprint.
Script for generating that report is : cms_phy_cnt_store_rpt.sh
This should generate a file start with websal* under /apps/projects/cms/dev/marker/ directory.

Multitender

select * from r_io_export where xpt_proc_name='p_intra_websal_exp'; -- intra_web

select s_au_extract.f_min_key('p_intra_websal_exp') from dual; -- 447019027

insert into trans_oms_ord_hdr select * from trans_oms_ord_hdr@cmsts3 where sk_trans_ord_id >= 499419847 and rownum <=20;

insert into trans_oms_ord_item select * from trans_oms_ord_item@cmsts3 where sk_trans_ord_id in (select sk_trans_ord_id from trans_oms_ord_hdr);

insert into trans_hso_ord_hdr select * from trans_hso_ord_hdr@cmsts3 where ord_id in (select ord_id from trans_oms_ord_hdr);

insert into trans_hso_ord_item select * from trans_hso_ord_item@cmsts3 where sk_trans_ord_id in (select sk_trans_ord_id from trans_hso_ord_hdr);

insert into trans_hso_ord_addr select * from trans_hso_ord_addr@cmsts3 where sk_trans_ord_id in (select sk_trans_ord_id from trans_hso_ord_hdr);

insert into trans_hso_ord_cntt select * from trans_hso_ord_cntt@cmsts3 where sk_trans_ord_id in (select sk_trans_ord_id from trans_hso_ord_hdr);

insert into trans_hso_ord_tndr select * from trans_hso_ord_tndr@cmsts3 where sk_trans_ord_id in (select sk_trans_ord_id from trans_hso_ord_hdr);

insert into trans_hso_ord_promo select * from trans_hso_ord_promo@cmsts3 where sk_trans_ord_id in (select sk_trans_ord_id from trans_hso_ord_hdr);

commit;

select
    id,
    to_timestamp(to_char(end_time),'dd-mon-yy hh24:mi:ss:ff9') - to_timestamp(to_char(start_time),'dd-mon-yy hh24:mi:ss:ff9') elapsed,
    text,
    time_stamp
from (
select
    id,
    text,
    substr(regexp_substr(extra, '\*\* Start time:.*',1,1),16,30) start_time,
    substr(regexp_substr(extra, '\*\* End time:.*',1,1),14,30) end_time,
    time_stamp
from logger_logs_60_min
where scope = 's_load_order_util.p_accept_order_api'
)
order by 2 desc;

select
    id,
    to_timestamp(to_char(end_time),'dd-mon-yy hh24:mi:ss:ff9') - to_timestamp(to_char(start_time),'dd-mon-yy hh24:mi:ss:ff9') elapsed,
    text,
    time_stamp
from (
select
    id,
    text,
    substr(regexp_substr(extra, '\*\* Start time:.*',1,1),16,30) start_time,
    substr(regexp_substr(extra, '\*\* End time:.*',1,1),14,30) end_time,
    time_stamp
from logger_logs
where scope = 's_load_order_util.p_accept_order_api'
and time_stamp between to_timestamp('17-SEP-18 18:40:00','dd-mon-yy hh24:mi:ss') and to_timestamp('17-SEP-18 19:20:00','dd-mon-yy hh24:mi:ss')
)
order by 2 desc;

All orders with non-eu delivery address has already been excluded.

Now, question is : how global-e checkout page will be made available to the customer? based on site region? e.g https://us.riverisland.com/

AUTHORISATION_CODE
PAYMENT_REFERENCE
CARD_TYPE
PMT_POINT
--
--Tender details
--
-- For GIft Card payments :
--   paymentProvider will be "GC" and type will be "GIFT CARD".
--   securitycode, securityCodeType and cardNumber is only required
--   for calling SVS, which will be handlled by payment service.
--   Hence these details will not not be stored in core
--   only aggregated gift card amount per order will be stored
--

Similar performance issue also experienced for ~15 minutes at around 17-SEP-18 18.43.34. Rest end points took more than one minute

Billing address : Do we need a billing address for gift cards? B, D X
Billing Contacts : Do we need billing contacts

Only contention is PMT_POINT : both in cms and oms
biling address : how this will be handlled.
billing address same as shipping address

pl_populate_addr_record
pl_populate_cntt_record

Will there be an address details for gift card. This means that if there is only paid by gift card then bill to id will be blank in oms.

--Nothing in Production
select * from trans_hso_ord_hdr where payment_reference is not null;

select * from trans_hso_ord_hdr where CARD_TYPE is not null;

select * from trans_hso_ord_hdr where AUTHORISATION_CODE is not null;

-------
with temp as
(select
    distinct regexp_substr(text,'[0-9]+') id
from
    logger_logs@wms
where
    text like 'loaded json for order id %'
    and time_stamp between
        to_date('30-jun-18 01.00.00','dd-mon-yy hh24:mi:ss')
        and to_date('30-jun-18 11.00.00','dd-mon-yy hh24:mi:ss')
group by
    regexp_substr(text,'[0-9]+')
    )
select
t.id, ord.ordernumber
from temp t
left join orderalias ord
on (t.id=ord.ordernumber)
where ordernumber is null;

select * from orderalias where ordernumber in
(47547118,47547119,47547127,47547125,47547121,47547124,47547120,47547122,47547126);

select distinct ord_id from w_ii_odm_stk where ord_id in
(47547118,47547119,47547127,47547125,47547121,47547124,47547120,47547122,47547126);

select distinct ord_id from w_ii_odm_stk_err where ord_id in
(47547118,47547119,47547127,47547125,47547121,47547124,47547120,47547122,47547126)

http://www.oracle.com/technetwork/products/globalization/nls-lang-099431.html

JBUY599

NLS_LANG = language_territory.charset

AMERICAN_UNITED KINGDOM.WE8ISO8859P15

ENGLISH_UNITED KINGDOM.WE8ISO8859P15

AL32UTF8

SELECT * FROM NLS_SESSION_PARAMETERS;

SELECT USERENV ('language') FROM DUAL; --gives the session's <Language>_<territory> but the DATABASE character set not the client, so the value returned is not the client's complete NLS_LANG setting!

select UPPER(s_env.f_getenv('S_PROJECT_PHASE')) from dual;

AL32UTF8

Checking the current NLS_LANG Setting

SELECT DUMP(col,1016)FROM table;

* If set, client parameters (NLS_SESSION_PARAMETERS) always take precedence over NLS_INSTANCE_PARAMETERS and NLS_DATABASE_PARAMETERS.

When the client NLS_LANG character set is set to the same value as the database character set, Oracle assumes that the data being sent or received are of the same (correct) encoding, so no conversions or validations may occur for performance reasons. The data is just stored as delivered by the client, bit by bit.

create table char_convert_test(text varchar2(100));

insert into char_convert_test values( 'ééééé' );

select * from char_convert_test;

SELECT * FROM NLS_SESSION_PARAMETERS;

select * from NLS_DATABASE_PARAMETERS;

SELECT USERENV ('language') FROM DUAL;
--gives the session's <Language>_<territory> but the DATABASE character set not the client, so the value returned is not the client's complete NLS_LANG setting!

SELECT * from v$nls_parameters;

SELECT userenv ('language') from dual;

SELECT sys_context('userenv','language') from dual;
-- Both these SELECT statements give the session's <Language>_<territory> and the

SELECT * FROM NLS_SESSION_PARAMETERS;

select * from NLS_DATABASE_PARAMETERS;

SELECT USERENV ('language') FROM DUAL;
--gives the session's <Language>_<territory> but the DATABASE character set not the client, so the value returned is not the client's complete NLS_LANG setting!

SELECT * from v$nls_parameters;

SELECT userenv ('language') from dual;

SELECT sys_context('userenv','language') from dual;
-- Both these SELECT statements give the session's <Language>_<territory> and the

select * from w_stock_att_updates;

select * from all_synonyms where synonym_name='W_STOCK_ATT_UPDATE';

select sysdate- interval '4' hour from dual;

select * from s_char_codes where code_type like '%APEX%';

select * from s_num_codes;

http://localhost:8282/ords/cmsdev/itsr-api/demo/v1/dbsession/

http://localhost:8181/ords/{{env}}/{{schema_alias}}{{order_test_handler_module}}/orderaddresses/250200703

Dash Board Queries

DELETE FROM W_II_WEB_ORD_HDR  ;
DELETE FROM W_II_WEB_ORD_ITEM ;
DELETE FROM W_II_WEB_ORD_TNDR ;
DELETE FROM W_II_WEB_ORD_ADDR ;
DELETE FROM W_II_WEB_ORD_CNTT ;
DELETE FROM W_II_WEB_ORD_PROMO;

select * from logger_prefs;

select * from logger_logs where text='Checksum mismatch' and logger_level < 8;

select * from logger_logs where unit_name='CMSUAT.S_LOAD_ORDER_UTIL' and logger_level < 8;

WITH all_counts AS (
    SELECT
        'CMS'                     db_name,
        'Total Count'             metric,
        COUNT(*)                  order_count
    FROM
        w_ii_web_ord_hdr
    UNION
    SELECT
        'CMS'                     db_name,
        'Distinct Count'          metric,
        COUNT(distinct ord_id)    order_count
    FROM
        w_ii_web_ord_hdr
    UNION
    SELECT
        'OMS'                     db_name,
        'Total Count'             metric,
        COUNT(*)                  order_count
    FROM
        w_ii_web_ord_hdr@oms
    UNION
    SELECT
        'OMS'                     db_name,
        'Distinct Count'          metric,
        COUNT(distinct ord_id)    order_count
    FROM
        w_ii_web_ord_hdr@oms
    UNION
    SELECT
        'WMS'                  db_name,
        'Total Count'          metric,
        COUNT(*)               order_count
    FROM
        w_ii_web_ord_hdr@wms
    UNION
    SELECT
        'WMS'                     db_name,
        'Distinct Count'          metric,
        COUNT(distinct ord_id)    order_count
    FROM
        w_ii_web_ord_hdr@wms
) SELECT
    *
  FROM
    all_counts
PIVOT (
    SUM ( order_count )
    FOR ( db_name )
    IN ( 'CMS' AS cms,'OMS' AS oms,'WMS' AS wms )
);

SELECT
    cms.ord_id cms_ord_id,
    oms.ord_id oms_ord_id,
    wms.ord_id wms_ord_id
FROM w_ii_web_ord_hdr@wms wms
    left join w_ii_web_ord_hdr cms
    on (cms.ord_id = wms.ord_id)
    left join w_ii_web_ord_hdr@oms oms
    on (wms.ord_id = oms.ord_id)
where
  cms.ord_id is null
or oms.ord_id is null;

SELECT
    cms.ord_id,
    wms.ord_id
FROM w_ii_web_ord_hdr@wms wms
     right join w_ii_web_ord_hdr cms
    on (cms.ord_id = wms.ord_id)
where
  wms.ord_id is null;

select
    apex_web_service.make_rest_request(
        p_url          => 'https://api.slack.com/',
        p_http_method  => 'GET',
        p_wallet_path  => 'file:'||s_env.f_getenv('S_WALLET_DIR'))
from dual;


select distinct
    hdr.ord_id         ordnumber,
    hdr.sk_request_id  request,
    hdr.ii_error_dtl   hdr_err,
    item.ii_error_dtl  item_err,
    addr.ii_error_dtl  addr_err,
    cntt.ii_error_dtl  cntt_err,
    tndr.ii_error_dtl  tndr_err,
    promo.ii_error_dtl promo_ERR
from
         w_ii_web_ord_hdr_err   hdr
    join w_ii_web_ord_item_err  item
        on(hdr.sk_request_id = item.sk_request_id)
    left join w_ii_web_ord_addr_err  addr
        on(hdr.sk_request_id = addr.sk_request_id)
   left join w_ii_web_ord_cntt_err  cntt
        on(hdr.sk_request_id = cntt.sk_request_id)
    left join w_ii_web_ord_tndr_err  tndr
        on(hdr.sk_request_id = tndr.sk_request_id)
    left join w_ii_web_ord_promo_err promo
        on(hdr.sk_request_id = promo.sk_request_id)
where hdr.ord_id in
(260182585 ,260182664 ,260182715);
Billing address
shipping address table.

No order ID dupes in work table (hdr)
No order item dupes in work table (item)
Only 1 tender record in work table (tndr)
Order ID not already in trans_hso_ord_hdr (CMS MW), excluding store orders
More than that, it should allow null values and not process further.
Check order hdr has at least 1 item record (hdr)
Check order hdr has a corresponding cntt record (hdr)
Check order hdr has a corresponding tndr record (hdr)
Hdr record exists for addr, cntt , item , tndr  record

Sub Client : Website, Phone app
Auth Code : 051458, PAYPAL
Paypal Address :
Shipment ID is duplicated

-b use bash shell
Service :	Expresspak DPD >> Booking Code	@10/*/*-*/2017-03-30/*-23:59
Service :	Parcel DPD >> Booking Code	@10/*/*-*/2017-03-30/*-23:59
Service :	Two Day >>    Booking Code	@10/*/*-*/2017-03-30/*-23:59
Service :	Win Direct Standard >> Booking Code	@10/*/*-*/2017-04-06/*-23:59
Service :	Royal Mail Tracked High Volume No Sig >> Booking Code	@01/*/*-*/2017-03-30/*-23:59
Service :	Yodel @home 48 hour NON-POD >> Booking Code	@01/*/*-*/2017-03-30/*-23:59
Not allocated >> HDN72MERCHTOSTORE_YNGV_77071_2003/*/*-*/2017-03-30/*-23:59
Service :	Tracked High Volume No Sig >> Booking Code	@01/*/*-*/2017-03-30/*-23:59
Service :	Hermes Cross Border Parcelshop >> Booking Code	HPSPXSTD0_06760_06760_153001/*/*-*/2017-04-03/*-23:59
Service :   DPD Next Day @22/*/*-*/2017-06-24/*-23:59
*/

Picking is enabled by populating data in working tables. How can we ensure that when they run a wave it must be taking data from a set of tables.

Distributed processing > when TCPL writes to a kinesis stream

WMS Pattern > 1: CMS procedure runs to create data in an SDI table, 2: an ‘inpt’ procedure is run. The inpt procedure is a procedure in the RWM schema of WMS, which processes data in the SDI table and populates one or more ‘INPT’ tables. 3: Thirdly, a bridge program is run. A bridge program is a Manhattan program that processes data in specific INPT_ tables into the main WMS tables.

We also have two interfaces that import the following information from WMS to CMS. The way that Manhattan have grouped the two interfaces coming back from WMS is purely done by which source the data is coming from. (a*) builds its data from the WMS PIX_TRAN table, while (b*) builds its data from the OUTPT_ tables. Therefore the two different import interfaces have their own specific WMS stored procedures, but no WMS Bridge programs.

The WMS database contains 2 main schemas:
WMS holds Manhattan objects for the DC application.
RWM holds River Island objects, including the bespoke procedures that were originally written by Manhattan to populate INPT_ tables and to retrieve data for interfacing data back to ODBMS. These procedures are now under RI control.

READ ONLY USER
sqlplus WMSRDO/WMSRDO@WMSPRD
sqlplus RWM/RWMPRD@WMSPRD

--cmsts3
select count(*) from user_source; -- 382823 , JDA= 1417496

--wms wmsdev
select count(*) from user_source; -- 77535

--rwm wmsdev
select count(*) from user_source; -- 31386

--orderactive omsdev
select count(*) from user_source; -- 220293

select 382823 + 1417496 + 77535 + 31386 + 220293 from dual; 2129533

SELECT *
FROM   r_ref_dtl
WHERE  ref_system_name = 'HSO'
AND    ref_hdr_name    = 'DEST_TYPE'

[rlcmstd] /apps/projects/cms/dev/control/hsoordii-> more hsoordiifile.gdi
hso106|none|none|sqlldr|sqlldr|-k direct=true|w_ii_hso_ord.ldr|none|none|fail|nowait

[rlcmstd] /apps/projects/cms/dev/control/hsoordii-> more hsoordiimarker.gdi
hso106|web|||||||T

/apps/projects/cms/dev/sql/schema/loader/w_ii_hso_ord.ldr

/apps/projects/cms/ts3/remote_data/in

/apps/projects/cms/ts3/remote_data/archive/in

/apps/projects/cms/dev/remote_data/in/web-> more hso106170109019.dat

more hso106170109019.dat

1^^28220363^^5294995^^20170109162926^^1^^36.00^^GBP^^20^^20170111180000^^20170111200059^^0.00^^WEB^^en-GB^^Store^^20170112000000^^53^^
2^^28220363^^AC^^7924839793148586^^3600^^36.00^^Visa^^RICardsGBP_UAT4^^^^1111^^Website^^River Island W5 5JY
3^^28220363^^1^^5112559^^18.00^^1^^Black cut-out bikini tank top 16 Black
3^^28220363^^2^^5112559^^18.00^^1^^Black cut-out bikini tank top 16 Black
4^^28220363^^D^^MR^^Mal^^Graney^^Malcolm.Graney@river-island.com^^^^
4^^28220363^^B^^MR^^Mal^^Graney^^^^002089914500^^
5^^28220363^^D^^River Island^^Unit 28-30^^Ealing Broadway Centre^^London^^^^W5 5JY^^GB^^
5^^28220363^^B^^River Island Clothing Co^^Chelsea House^^West Gate^^London^^^^W5 1DR^^GB^^

more hso106170109019.mkr
hso106170109019.dat count 8

select * from s_val_table_data where table_name='W_II_HSO_ORD_HDR'  and validate_name='HSO_ORD_ID'

w_ii_hso_ord.ldr loads data into>

select * from w_ii_hso_ord_hdr
select * from w_ii_hso_ord_tndr
select * from w_ii_hso_ord_item
select * from w_ii_hso_ord_cntt -- Contact Details Title, Forename, Surname, Cntt_type email_addr, telephone, BFPO Service rank name
select * from w_ii_hso_ord_addr --
select * from w_ii_hso_ord_promo
select * from w_ii_hso_ord_cancel

Changes Needed :

cms_hso_to_oms
    Stop purging the data : s_purge.p_purge_group hsoordii
    Purge after processing is done.
    Selectively reprocess the error records if any.
    Validation : Idempotent?? and make the process fault resilient.
    Remove duplicate file check
    Ensure header record exists in w_ii_hso_ord_hdr for address records in w_ii_hso_ord_addr for same ord_id
    Ensure header record exists in w_ii_hso_ord_hdr for contact records in w_ii_hso_ord_cntt for same ord_id
    Cancel order event??
    Move telephone and email from delivery to billing contact

cms_hso_c_to_oms.sh >> cms_hso_to_oms.sh
Lines starting with # are shell script steps.
1. # Purge data into from working tables f_jobstep s_purge_group.sh hsoordii >> s_purge.p_purge_group hsoordii
    p_purge_table : w_ii_hso_ord_item, w_ii_hso_ord_cntt, w_ii_hso_ord_addr, w_ii_hso_ord_tndr, w_ii_hso_ord_hdr, w_ii_hso_ord_promo
    All truncates, delete_type = T = truncate, D=delete, P=procedure
2. # Load web orders data into working tables f_jobstep s_ii.sh hsoordii
3. # Reprocess the error records from error tables to working tables f_jobstep s_sql.sh cms_hso_import_order.p_reprocess_error
-- DESCRIPTION: This procedure reprocess error records from error by inserting into working tables with all data that errored during the previous run
4. # Process the web orders f_jobstep s_ii_process.sh hsoordii
	SELECT proc_type||'|'||proc_id||'|'||proc_name FROM r_ii_process WHERE proc_group_id = upper('${P_PROCESS_GROUP}') AND active_ind = 'T' ORDER BY run_order
    SELECT * FROM r_ii_process WHERE proc_group_id = upper('hsoordii')
CMS_HSO_IMPORT_ORDER.P_PROCESS_ORDER
        pl_std_vld_chk('W_II_HSO_ORD_HDR','HSO_ORDER',FEED_ID)
            s_val_table.p_check_mandatory etc
        pl_std_vld_chk for other tables W_II_HSO_ORD_ADDR, W_II_HSO_ORD_CNTT, W_II_HSO_ORD_ITEM, W_II_HSO_ORD_PROMO, W_II_HSO_ORD_TNDR, W_II_HSO_ORD_HDR for key 'HSO_ORDER'
        -- pl_std_vld_chk does three kinds of validation 1.  s_val_table.p_check_mandatory, 2. s_val_table.p_validate 3. s_val_table.p_convert
/*
s_val_table.p_check_mandatory
        --exec s_val_table.p_check_mandatory( 'HSO_ORDER','W_II_HSO_ORD_HDR',' AND ii_dtl_feed_id = ' ||TO_CHAR(1473726));

        SELECT table_name, column_name
        FROM s_val_table_data
        WHERE table_name in
            ( 'W_II_HSO_ORD_HDR',
            'W_II_HSO_ORD_CNTT',
            'W_II_HSO_ORD_ITEM',
            'W_II_HSO_ORD_PROMO',
            'W_II_HSO_ORD_TNDR',
            'W_II_HSO_ORD_HDR',
            'W_II_HSO_ORD_CANCEL')
        AND   validate_name = 'HSO_ORDER'
        AND conv_column_mandatory ='Y'
        AND conv_column_active ='Y'
        ORDER BY 1

        UPDATE W_II_HSO_ORD_HDR SET ii_error_dtl =
        SUBSTR(s_val_table.f_mandatory(DELIV_TYPE,'MAND-DELIV_TYPE,') ||
        s_val_table.f_mandatory(DEST_TYPE_TEXT,'MAND-DEST_TYPE_TEXT,') ||
        s_val_table.f_mandatory(EARLIEST_COLLECT_DTM_TEXT,'MAND-EARLIEST_COLLECT_DTM_TEXT,') ||
        s_val_table.f_mandatory(HSO_CUST_ID,'MAND-HSO_CUST_ID,') ||
        s_val_table.f_mandatory(LATEST_DELIV_DTM_TEXT,'MAND-LATEST_DELIV_DTM_TEXT,') ||
        s_val_table.f_mandatory(ORD_CURRENCY,'MAND-ORD_CURRENCY,') ||
        s_val_table.f_mandatory(ORD_DTM_TEXT,'MAND-ORD_DTM_TEXT,') ||
        s_val_table.f_mandatory(ORD_ID,'MAND-ORD_ID,') ||
        s_val_table.f_mandatory(ORD_STATUS_TEXT,'MAND-ORD_STATUS_TEXT,') ||
        s_val_table.f_mandatory(ORD_TOTAL_VAL_TEXT,'MAND-ORD_TOTAL_VAL_TEXT,') ||
        s_val_table.f_mandatory(POST_AND_PACKING_CHARGE_TEXT,'MAND-POST_AND_PACKING_CHARGE_TEXT,') ,1,256)
        WHERE ii_error_id IS NULL  AND ii_dtl_feed_id = 1473726

s_val_table.p_validate

        SELECT table_name, column_name, conv_column_name, conv_column_type
        FROM s_val_table_data
        WHERE table_name in
            ( 'W_II_HSO_ORD_HDR',
            'W_II_HSO_ORD_CNTT',
            'W_II_HSO_ORD_ITEM',
            'W_II_HSO_ORD_PROMO',
            'W_II_HSO_ORD_TNDR',
            'W_II_HSO_ORD_HDR',
            'W_II_HSO_ORD_CANCEL')
        AND   validate_name = 'HSO_ORDER'
        AND conv_column_active ='Y'
        AND conv_column_name is not null
        ORDER BY 1

        SELECT table_name, column_name
        FROM s_val_table_data
        WHERE table_name in
            ( 'W_II_HSO_ORD_HDR')
        AND   validate_name = 'HSO_ORD_ID'
        AND conv_column_mandatory ='Y'
        AND conv_column_active ='Y'
        ORDER BY 1

    prepares a concanated string of function calls s_val_table.f_val_number, s_val_table.f_val_date, s_val_table.f_val_char_length
    Then prepare a update statement to use this string of function calls and update ii_error_dtl

Records not flagged as error record in above two processes will be used for data conversion s_val_table.p_convert
*/
cms_hso_import_order.p_process_order

        pl_std_vld_chk('W_II_HSO_ORD_HDR','HSO_ORD_ID',FEED_ID)
        -- pl_std_vld_chk does three kinds of validation 1.  s_val_table.p_check_mandatory, 2. s_val_table.p_validate 3. s_val_table.p_convert

        select * from s_val_table_data where table_name='W_II_HSO_ORD_HDR'  and validate_name='HSO_ORD_ID'
        -- Check for duplicate transactions
        CMS_HSO_IMPORT_ORDER.pl_dupl_trans_chk(I_feed_id => I_feed_id);
            -- Check for duplicate filename if record exists in trans_file where trans_file_id  = hdr.ii_source
            -- Check Order hasn't already been loaded into middleware if exists trans_hso_ord_hdr where ord_id = hdr.ord_id
            -- Check only one order hdr exists in working table w_ii_hso_ord_hdr dupl WHERE dupl.ord_id = hdr.ord_id AND dupl.ii_dtl_feed_id = I_feed_id
            -- Check for duplicate item records w_ii_hso_ord_item dupl WHERE  dupl.ord_id = itm.ord_id AND dupl.item_seq_nbr = itm.item_seq_nbr AND dupl.ii_dtl_feed_id = I_feed_id
            -- Check for multiple tender type records w_ii_hso_ord_tndr dupl WHERE dupl.ord_id = tndr.ord_id AND dupl.ii_dtl_feed_id = I_feed_id
            --END
        -- Check code fields
    pl_vld_data_chk(I_feed_id => I_feed_id);
        -- Check all payment provider codes are valid
        UPDATE w_ii_hso_ord_tndr tndr
        SET    tndr.ii_error_id  = cms_hso_const.C_invld_tndr,
               tndr.ii_error_dtl = cms_hso_const.C_invld_pmt_provider_detail
        WHERE NOT EXISTS in r_ref_dtl for ref_code = tndr.payment_provider AND ref_system_name = 'HSO' AND ref_hdr_name = 'PMT_PROVIDER'

        -- Check that there is an auth_code for datacash payments
        UPDATE w_ii_hso_ord_tndr tndr
        SET    tndr.ii_error_id  = cms_hso_const.C_invld_tndr,
               tndr.ii_error_dtl = cms_hso_const.C_no_auth_code_detail
        WHERE tndr.payment_provider = 'DC' AND auth_code IS NULL AND EXISTS
            (SELECT 1
               FROM   w_ii_hso_ord_hdr hdr
               WHERE  hdr.ord_id     = tndr.ord_id
               AND    hdr.ord_status = 'ORDERED')
        -- Check payment types only if the order source is not STORE
        UPDATE w_ii_hso_ord_tndr C_invld_tndr and C_invd_pmt_type_detail where payment_type IS NOT NULL and ord_id in
        (select ord_id from w_ii_hso_ord_hdr where NVL(hdr.ord_source, cms_hso_const.C_web) <> cms_hso_const.C_store)
        and not exists (record in r_ref_dtl for same payment type ref_system_name = 'HSO' and ref_hdr_name'TNDR_DESC')
        -- Check delivery type is valid
        UPDATE w_ii_hso_ord_hdr hdr set error id and dtl to cms_hso_const.C_invld_deliv_type and cms_hso_const.C_invld_deliv_type_detail
        where not exists (SELECT 1
                   FROM   r_ref_dtl ref WHERE  ref_system_name = 'HSO' -- cms_hso_const.C_hso
                   AND    ref.ref_hdr_name = 'SRVC_GRP' -- cms_hso_const.C_hso_srvc_grp
                   AND    ref.ref_code = hdr.deliv_type))

        -- Sample Data,
        /*
        --    Payment_provider : AC(Adyen Card), AP(Adyen Paypal), AI(Ideal), SO(Store Order),  select * from r_ref_dtl where  ref_system_name = 'HSO' AND ref_hdr_name = 'PMT_PROVIDER'
        -- Order is pre pay is or not decided by the payment provider: SO, AS(Sofort), AI(Ideal), AG(Giropay) (select * from oms_payment_provider where prepay_type_ind='T')
        -- pmt_point = 01 is pre-pay and 02 is post pay IN TRANS_HSO_ORD_HDR
        --    PSP_NAME : DATACASH, ADYEN select * from oms_payment_provider
        --    payment_type : VISA, PAYPAL, MAESTRO, IDEAL, AMERICAN EXPRESS, VISA DEBIT, -- select * from r_ref_dtl where  ref_system_name = 'HSO' AND ref_hdr_name = 'TNDR_DESC'
        -- Delivery Type 01(Demestic Home stdndard), 02(Demestic Home Exp), 10(International Home Standard), 11(International Home Express), 20(Domestic Store Standard), 21(Domestic Store Order To Home Standard), 22(Domestic Store Express), 23(Domestic Store Order To Home Express), 30(International Store Standard), 40(Collect Plus Standard)
        -- Order Source web=01, store=02 SELECT * FROM   s_char_codes scc WHERE  scc.code_type = 'HSO_ORDER_SOURCE'
        -- DEST_TYPE : 01(store), 02(home), 03(collect plus), 04(hermes)
        -- ADDRESS TYPE B=Billing, D=Delivery, X=Both, F=BFPO , select s_code.f_trlt_to_char ('HSO_ADDRESS_TYPE','BILLING') from dual; select * from s_char_codes where code_type='HSO_ADDRESS_TYPE'
        -- CONTACT TYPE B=Billing, D=Delivery, X=Both, F=BFPO select * from s_char_codes where code_type='HSO_CONTACT_TYPE'
      */
        /*
        select distinct payment_type from trans_hso_ord_tndr;

        AMERICAN EXPRESS
        PAYPAL
        VISA
        IDEAL
        STORE PAYMENT
        MASTERCARD
        MAESTRO
        GIROPAY
        GLOBAL-E
        */
        -- Check order source is valid
        UPDATE w_ii_hso_ord_hdr hdr set error id and dtl to cms_hso_const.C_invld_ord_source and cms_hso_const.C_invld_ord_source_detail
        where ord_source is not null and NOT EXISTS(
                   SELECT 1
                   FROM   s_char_codes scc
                   WHERE  scc.code_type = 'HSO_ORDER_SOURCE' --cms_hso_const.C_ord_source_code_type
                   AND    scc.code      = hdr.ord_source)
        -- Check row exists in TRANS_HSO_ORD_HDR if a store order
        UPDATE w_ii_hso_ord_hdr hdr set error id and dtl to cms_hso_const.C_no_mw_ord_hdr and cms_hso_const.C_no_mw_ord_hdr_detail if no record exists for this in trans_hso_ord_hdr.
        -- Check rows in TRANS_HSO_ORD_HDR have correct status if a store order
        UPDATE w_ii_hso_ord_hdr hdr set error id and dtl to cms_hso_const.C_invld_ord_hdr_stat and cms_hso_const.C_invld_ord_hdr_stat_detail
        where ord_source     = cms_hso_const.C_store and EXISTS(
                   SELECT 1
                   FROM   trans_hso_ord_hdr thoh
                   WHERE  thoh.ord_id     =  hdr.ord_id
                   AND    thoh.ord_status <> G_pre_ordered_ord_status)
        -- select * from s_char_codes where code_type='HSO_ORDER_STATUS' order by num_translation
        -- Check postcodes UK addresses and BFPO must have a postcode
        UPDATE w_ii_hso_ord_hdr hdr set error id and dtl to cms_hso_const.C_invld_addr and cms_hso_const.C_invld_addr_detail
        WHERE  (
                      (
                       (addr.country_code = cms_const.C_gb
                        OR
                        addr.addr_type = 'BFPO' --G_bfpo_addr_type
                       )
                       AND addr.postcode IS NULL
                      )
               );
        -- Temporary Fix UPDATE w_ii_hso_ord_cntt SET surname = '-' WHERE  ii_dtl_feed_id = I_feed_id AND cntt_type = G_billing_cntt_type AND surname IS NULL;

        -- Check surname field is only null for BFPO contacts
        UPDATE w_ii_hso_ord_cntt set error id and dtl to cms_hso_const.C_invld_cntt and cms_hso_const.C_invld_cntt_detail where cntt_type != G_bfpo_cntt_type AND  surname IS NULL
        END pl_vld_data_chk


        -- Validate the order header records
    pl_order_hdr_chk(I_feed_id => I_feed_id)
            -- valid dest_type
            Translate dest_type_text to dest_type and mark error if dest_type is blank in w_ii_hso_ord_hdr.
            SELECT ref_code FROM r_ref_dtl WHERE ref_system_name = 'HSO' AND ref_hdr_name = 'DEST_TYPE';
            -- if destination type is store then customer collection date and time must be present
            -- deliv_store_num, delivery store can only be set if delivery is to a store
            -- if destination type is store then delivery store must be present
            -- if destination type is store then delivery store must be valid EXISTS
                   (SELECT 1
                    FROM   orgmstee org
                    WHERE  org.org_lvl_number = hdr.deliv_store_num
                    AND    org.org_is_store = s_const.C_true)
            -- if destination type is CollectPlus then the carrier miscellaneous field 1 must be present carrier_misc_1
            -- Check an address exists
                    SELECT 1
                    FROM   w_ii_hso_ord_addr addr
                    WHERE  addr.ord_id         = hdr.ord_id
                    AND    addr.ii_dtl_feed_id = I_feed_id
            -- Check at least one item record exists
                    SELECT 1
                    FROM   w_ii_hso_ord_item itm
                    WHERE  itm.ord_id         = hdr.ord_id
                    AND    itm.ii_dtl_feed_id = I_feed_id
            -- Check for a contact record
                   SELECT 1
                   FROM   w_ii_hso_ord_cntt cntt
                   WHERE  cntt.ord_id         = hdr.ord_id
                   AND    cntt.ii_dtl_feed_id = I_feed_id
            -- Check for a tender record
                   SELECT 1
                   FROM   w_ii_hso_ord_tndr tndr
                   WHERE  tndr.ord_id         = hdr.ord_id
                   AND    tndr.ii_dtl_feed_id = I_feed_id
            -- Ensure header record exists in w_ii_hso_ord_hdr for address records in w_ii_hso_ord_addr for same ord_id
            -- Ensure header record exists in w_ii_hso_ord_hdr for contact records in w_ii_hso_ord_cntt for same ord_id
            -- Check header record exists for tender records in w_ii_hso_ord_tndr
            -- Check for a the order where the ord_total_value does not equal to the sum of prices for all of the items on the order, plus postage and packing
                    UPDATE w_ii_hso_ord_hdr hdr
                    SET    hdr.ii_error_id  = cms_hso_const.C_invld_total_id,
                           hdr.ii_error_dtl = cms_hso_const.C_invld_ord_value_dtl
                    WHERE  hdr.ii_dtl_feed_id = I_feed_id
                    AND    hdr.ii_error_id    IS NULL
                    AND    hdr.ord_total_val <>
                               (
                                hdr.post_and_packing_charge
                                +
                                (SELECT SUM(itm.unit_price)
                                 FROM   w_ii_hso_ord_item itm
                                 WHERE  itm.ord_id = hdr.ord_id
                                 AND    itm.ii_dtl_feed_id  = I_feed_id)
                               );
        --
        -- Check for orders where the auth_amount does not equal to the sum of the prices for all of the items on the order, plus the postage
                UPDATE w_ii_hso_ord_tndr tndr
                SET    tndr.ii_error_id  = cms_hso_const.C_invld_total_id,
                       tndr.ii_error_dtl = cms_hso_const.C_invld_auth_amount_dtl
                WHERE  tndr.ii_dtl_feed_id = I_feed_id
                AND    tndr.ii_error_id    IS NULL
                AND    tndr.auth_amount   !=
                           (
                            (SELECT NVL(hdr.post_and_packing_charge, 0)
                             FROM   w_ii_hso_ord_hdr hdr
                             WHERE  hdr.ord_id = tndr.ord_id
                             AND    hdr.ii_dtl_feed_id  = I_feed_id
                             AND    hdr.ii_error_id     IS NULL)
                            +
                            (SELECT SUM(itm.unit_price)
                             FROM   w_ii_hso_ord_item itm
                             WHERE  itm.ord_id = tndr.ord_id
                             AND    itm.ii_dtl_feed_id  = I_feed_id)
                           );
    END pl_order_hdr_chk

    http://rlcmstd:8080/apex/f?p=demoajaxapp

    http://ords-alb.dev.transit.ri-tech.io/ords/cmsdev/f?p=demoajaxapp

        -- Generate billing address records for PrePay type orders
        -- Insert billing address type rows into w_ii_hso_ord_addr for orders which are a prepay type order
        -- The assumption is that all prepay type payment methods won't have a billing address in the order details coming from the web. It's important that we have a billing country which is defaulted from the so no billing address is required
         (I_feed_id => I_feed_id);

        pl_add_prepay_contact(I_feed_id => I_feed_id);
        -- Generate contact records for PrePay type orders
        -- Insert billing contact type rows into w_ii_hso_ord_cntt for orders which are a prepay type order
        -- The assumption is that all prepay type payment methods won't have a billing contact in the order details coming from the web. The details (email address and telephone) will be defaulted from the delivery contact
        end pl_add_prepay_contact;

        pl_vld_addr_type(I_feed_id => I_feed_id);
        -- Validate address records
        -- Check that values in the addr_type column are valid w_ii_hso_ord_addr addr_type NOT IN (SELECT char_translation FROM s_char_codes WHERE code_type = cms_hso_const.c_addr_type_code_type)
        -- Check that there is only 1 of each address type
        -- If there is an address(Type X) for both delivery and billing, check that it is the only address for that order
        -- Check for orders that have no billing address
        -- Check for orders that have no delivery address
        -- Check that BFPO addresses have also have a BFPO contact
        -- Check that country code exists
        END pl_vld_addr_type

        -- Validate promo records
        -- Mark promo header record in w_ii_hso_ord_prom(item_seq_nbr = 0 is header record) as error if no header is present in w_ii_hso_ord_hdr
        -- -- Mark promo detail record in w_ii_hso_ord_prom(item_seq_nbr > 0 is detail record) as error if no detail is present in w_ii_hso_ord_item
        pl_vld_promo_line(I_feed_id => I_feed_id);

        -- Validate contact records
        -- Check that values in the cntt_type column are valid SELECT char_translation FROM s_char_codes WHERE code_type = 'HSO_CONTACT_TYPE' -- cms_hso_const.c_cntt_type_code_type
        -- Check that there is only 1 of each contact type
        -- If there is an contact for both delivery and billing(X TYPE), check that It is the only contact for that order
        -- Check for orders that have no billing contact
        -- Check for orders that have no delivery contact
        -- Check that BFPO contacts also have a BFPO address
        pl_vld_cntt_type(I_feed_id => I_feed_id);

        -- Validate the sku ids
        -- Check sku exists, update sku_id coming from web is prd_lvl_number and find prd_lvl_child and update w_ii_hso_ord_item.sku_lvl_child
        -- and mark records with null sku_lvl_child as error
        pl_validate_sku(I_feed_id => I_feed_id);
        -- Validate the order cancellations
        -- Validate that the order already exists in the middleware, update w_ii_hso_ord_cancel otherwise.
        pl_validate_cancel(I_feed_id => I_feed_id);

        -- Propogate errors
        s_error_propogate.p_process(I_table_names =>'W_II_HSO_ORD_HDR'  || ',' ||'W_II_HSO_ORD_CNTT' || ',' ||'W_II_HSO_ORD_ADDR' || ',' ||'W_II_HSO_ORD_ITEM' || ',' ||'W_II_HSO_ORD_PROMO'|| ',' ||'W_II_HSO_ORD_TNDR',
                                    I_join_columns => 'ord_id',
                                    I_where        => 'AND ii_dtl_feed_id = ' ||TO_CHAR(I_feed_id)
                                   );
        /* Updates each table in the list with similar update statement.
            UPDATE W_II_HSO_ORD_HDR main
            SET
            ii_error_id = 'E_REL_ERR',
            ii_error_dtl = 'Related Error Exists'
            WHERE main.ii_error_id is NULL
            AND (main.ord_id) IN
            (
                SELECT W_II_HSO_ORD_HDR.ord_id
                FROM W_II_HSO_ORD_HDR W_II_HSO_ORD_HDR
                WHERE W_II_HSO_ORD_HDR.ii_error_id IS NOT NULL
            UNION
                SELECT
                W_II_HSO_ORD_CNTT.ord_id
                FROM W_II_HSO_ORD_CNTT W_II_HSO_ORD_CNTT
                WHERE
                W_II_HSO_ORD_CNTT.ii_error_id IS NOT NULL
            UNION
                SELECT
                W_II_HSO_ORD_ADDR.ord_id
                FROM W_II_HSO_ORD_ADDR W_II_HSO_ORD_ADDR
                WHERE
                W_II_HSO_ORD_ADDR.ii_error_id IS NOT NULL
            UNION
                SELECT
                W_II_HSO_ORD_ITEM.ord_id
                FROM W_II_HSO_ORD_ITEM W_II_HSO_ORD_ITEM
                WHERE
                W_II_HSO_ORD_ITEM.ii_error_id IS NOT NULL
            UNION
                SELECT
                W_II_HSO_ORD_PROMO.ord_id
                FROM W_II_HSO_ORD_PROMO W_II_HSO_ORD_PROMO
                WHERE
                W_II_HSO_ORD_PROMO.ii_error_id IS NOT NULL
            UNION
                SELECT
                W_II_HSO_ORD_TNDR.ord_id
                FROM W_II_HSO_ORD_TNDR W_II_HSO_ORD_TNDR
                WHERE
                W_II_HSO_ORD_TNDR.ii_error_id IS NOT NULL
            )
            AND ii_dtl_feed_id = 10000
        */

        -- Log and email errors if any are found
        -- Insert into corresponding error records to w_ii_hso_ord_hdr_err, w_ii_hso_ord_cntt_err, w_ii_hso_ord_addr_err, w_ii_hso_ord_item_err, w_ii_hso_ord_promo_err, w_ii_hso_ord_tndr_err, w_ii_hso_ord_cancel_err
        -- Send email out if error encountered p_email_interface_error
        --
        pl_log_error(I_feed_id => I_feed_id);

        -- Move telephone and email from delivery to billing contact
        -- update w_ii_hso_ord_cntt where cntt_type = G_billing_cntt_type by taking email_addr and telephone from w_ii_hso_ord_cntt where cntt_type IN (G_delivery_cntt_type, G_bfpo_cntt_type))
        pl_move_cntt_details(I_feed_id => I_feed_id);

        -- Update middleware with web SKU description
        -- Update hso_web_sku.web_sku_descr with the product description coming in hso file.
        -- If multiple occurance in the same batch then use the description from the most recent order.
        pl_update_sku_descr(I_feed_id => I_feed_id);

        -- Update middleware with orders
        -- INSERT INTO trans_file, trans_file_till,
        -- trans_hso_ord_hdr joining data from w_ii_hso_ord_hdr, trans_file_till, oms_srvc_grp_day_offset, w_ii_hso_ord_tndr, oms_payment_provider, oms_system_parameter
        -- oms_system_parameter holds pick by offset, sort_by_offset, pack_by_offset used to compute pick_by_dtm, sort_by_dtm, pack_by_dtm
        -- insert into trans_hso_ord_cntt, trans_hso_ord_addr, trans_hso_ord_item, trans_hso_ord_promo for non-store odrers
        -- insert into trans_hso_ord_tndr  from tables w_ii_hso_ord_tndr, trans_hso_ord_hdr, trans_card_auth
        -- insert into trans_hso_ord_cancel
        pl_update_middleware(I_feed_id => I_feed_id);

        -- Update middleware with (store) orders
        -- There is a defect not updating the trans_hso_ord_promo with new sk_trans_item_id. Fixed ?????
        pl_update_middleware_sto(I_feed_id => I_feed_id);

        -- Audit transactions
        -- insert into w_ii_hso_audit
        -- select * from s_char_codes  where code_type='HSO_ORDER_STATUS'
        -- Status code pre-ordered =0 , ordered =1, errored=2, but in w_ii_hso_audit table it's populated as ordered or errored
        -- populate the audit records with mst_rpt_code and dtl_rpt_code
        -- Order store number and delivery store number etc
        -- p_hso_ii_audit(I_trans_batch_id => L_batch_id);
            -- Update w_ii_hso_audit hso set trans_curr_code =
            --        (start with org_lvl_child of  of hso join that to orgmstee, orgdtlee and fetch ctnry_lvl_child from orgdtlee and fetch bascooee.curr_code)
            -- update cost from sku level, UPDATE w_ii_hso_audit hso SET trans_cost (cst_cost from cstmstee where prd_lvl_child    = hso.sku_lvl_child)
            -- update cost from prd level, UPDATE w_ii_hso_audit hso SET trans_cost (cst_cost from cstmstee and prdmstee prd where prd.prd_lvl_parent    = hso.sku_lvl_child)
            -- Update vat amount for audits that have no order id, cms_util.p_upd_vat_val : this procedure takes the table name and column name and where clause as input and update the tax columns.
            -- Update vat amount for audits that have order id,
            -- For info:
            -- txsorgee - organisation to tax area mapping
            -- txsataee - tax area to tax authority mapping
            -- txsprdee - product to tax authority and rate
            -- txsratee - tax rate table
            -- txsaraee - All areas
        pl_audit_ii_trans(I_feed_id => I_feed_id);

        -- Generate sale type POS MW entries in an 'ordered' state for PrePay type orders.
        -- select * from r_trans_sale_sundry where sundry_desc='Web Postage and Packaging Charge'
        -- SELECT file_name FROM s_file_sequence WHERE file_id   = 'HSO_SALES' AND   file_type = 'HSO';
        -- Insert into trans_sale_hdr
        -- UPDATE trans_hso_ord_hdr set pos_sk_sale_id = sk_sale_id from trans_sale_hdr and other tables.
        -- insert into trans_sale_dtl
        -- VAT values are not coming from web so needs to be calculated : UPDATE trans_sale_dtl set vat_val=
        -- insert into trans_sale_tndr
        -- insert into trans_sale_sundry
        -- Update VAT values for trans sale sundry : update trans_sale_sundry set vat_val
        cms_hso_pos.p_prepay_pos_mw_load_ord(I_feed_id => I_feed_id);

        -- Tidy up to catch any card auth which arrived after the related order
        -- Update trans_hso_ord_tndr with card_bin, expiry_date from trans_card_auth
        p_unproc_card_auth
    END cms_hso_import_order.p_process_order;

    -- Job Step-2 SELECT * FROM r_ii_process WHERE proc_group_id = upper('hsoordii')
    -- select * from r_hso_trlt : Reference and translation data for use by the Home Shopping interfaces.
    -- select * from r_hso_trlt where mw_source='HSO_ORD' and trans_type ='MV' and mw_to_odb_ind='T'
    -- TRANS_TYPE MV = inv_mv, WO=inv_write_off, AD=inv_adj
    -- select * from INVTYPEE where INV_TYPE_CODE in (01, 07), salebale, ordered
    -- select * from INVTRCEE where INV_TRN_CODE in ('63','64') Internal Movement Out, Internal Movement In
    -- select * from all_col_comments where table_name='R_HSO_TRLT'
    -- select * from invtrnee : Contains inventory transactions
    -- SELECT * FROM s_extract_tbl WHERE  extract_proc_id ='cms_hso_import_order.p_move_stock'
    -- s_au_extract.f_min_key  returns min key from s_extract_tbl
    -- s_au_extract.f_max_key returns max kay from extract_table_name of s_extract_tbl
    --
    -- Move stock to Orderd in ODBMS for successfully validated
    -- Create pair of transaction detail lines into INVTRNEE
    -- Create header row INSERT  INTO invtrhee
    -- Update Max key processed
    -- Execute Inventory upload
        -- invtrnprc (in_trans_session => L_trans_session); L_trans_session is a new sequence value per run.
            -- If no header record exists in invtrhee then return.
            -- Reject procesing ureject(in_trans_session,in_process_luw);
                -- Does a lots of computations and finally update invtrnee ir failed insert into invrejee
            -- Clear the work files -- Delete the counts summary workfile DELETE FROM	invcntww
            -- Delete the inventory summary workfile  DELETE	FROM	invsumww
            -- Delete the sales summary workfile -- Pre  DELETE	FROM	invsumee
            -- -- Count Summary -- Step 1

        CMS_HSO_IMPORT_ORDER.P_MOVE_STOCK
        -- Move stock to Orderd in ODBMS for successfully validated

4. # Truncate the OMS working inbound order tables f_jobstep s_ssh.sh -b -r oms s_purge_group.sh omsordii

5. # Run the outbound interface to OMS f_jobstep s_io.sh -mwe omsordio
 -- M - Message job Step s_io_message.sh s_genio.p_msgqtoworkq  moves from io_msg_queue to io_work_queue
 -- W- Work Job step s_io_work.sh > s_genio.p_process_workq "'${P_PROCESS_GROUP}'",  SELECT * FROM   r_io_process WHERE  proc_group_id = 'omsordio' AND  active_ind = 'Y' ORDER BY run_order;
    -- cms_oms_export_order.p_sku_descr_upd (1)
        -- Insert into OMS outbound table where an ODBMS or Web SKU description has changed and the SKU has already been extracted to OMS INSERT INTO w_io_oms_sku
    -- cms_oms_export_order.p_upc_ins (2)
        -- Insert into OMS outbound table where the new barcode is for a sku already extracted to OMS.
        -- Since prd_upc is the PK of prdupcee, it is not
        -- possible to add the same upc twice so we don't have to cater for
        -- multiple upc messages per sku in io_msg_queue.
        -- INSERT INTO w_io_oms_upc
 -- E- export job step s_io_export.sh
    -- SELECT * FROM r_io_export WHERE  proc_group_id = 'omsordio' AND    active_ind = 'Y' ORDER BY run_order;
    -- cms_oms_export_order.p_process_order
        --L_min_key := s_au_extract.f_min_key ('cms_oms_export_order.pl_extract_order'); and L_max_key := s_au_extract.f_max_key ('cms_oms_export_order.pl_extract_order');
            -- SELECT NVL(max_num_extracted,0) + 1 FROM s_extract_tbl WHERE extract_proc_id = 'cms_oms_export_order.pl_extract_order';
            -- Above query returns the key col value from where processing needs to be started. Then next step is to find out the max value from the actual table and  update s_extact_table with the max value once processing done.
        -- Extract Order data into outbound tables pl_extract_order;
            --INSERT INTO w_io_oms_ord_hdr FROM trans_hso_ord_hdr WHERE sk_trans_ord_id BETWEEN L_min_key AND L_max_key
            --INSERT INTO w_io_oms_ord_cntt, w_io_oms_ord_addr, w_io_oms_ord_item, w_io_oms_ord_promo, w_io_oms_ord_tndr,
        -- Extract order cancellations into outbound tables pl_extract_ord_canc; INSERT INTO w_io_oms_ord_cancel FROM   trans_hso_ord_cancel cnl
        -- Extract SKU and UPC data into outbound tables pl_extract_ref_data; INSERT INTO w_io_oms_sku FROM w_io_oms_ord_item and other related tables
        -- Update tax rate, UPDATE w_io_oms_sku
        -- Create associated UPC data,  INSERT INTO w_io_oms_upc
        -- Flag newly extracted skus as processed,  UPDATE hso_web_sku hso
        -- If OMS db link valid then export SKU and UPC data into OMS inbound tables, pl_export_ref_data
            -- INSERT INTO vw_w_ii_oms_sku(w_ii_odm_sku@oms) FROM   w_io_oms_sku
            -- INSERT INTO vw_w_ii_oms_upc(w_ii_odm_upc@oms) FROM   w_io_oms_upc
            -- Mark records as processed  UPDATE w_io_oms_sku SET    processed_dtm = SYSDATE, UPDATE w_io_oms_upc SET    processed_dtm = SYSDATE
        --  pl_export_order_data;
            -- INSERT INTO vw_w_ii_oms_ord_hdr(w_ii_oms_ord_hdr@oms) FROM   w_io_oms_ord_hdr, INSERT INTO vw_w_ii_oms_ord_cntt(w_ii_oms_ord_cntt@oms) FROM   w_io_oms_ord_cntt , INSERT INTO vw_w_ii_oms_ord_addr ....
            -- Update w_io_oms_ord_hdr, w_io_oms_ord_cntt, w_io_oms_ord_addr ... SET    processed_dtm = SYSDATE

6. # Load SKU and UPC data into OMS f_jobstep s_ssh.sh -b -r oms oms_ii_ref_data.sh
-- Runs remote script which in turn calls following two OMS process
    -- usp_ps_job_import_odm_sku
        -- merge into stock from w_ii_odm_sku
        -- Merge sku tax data into skutaxbands table. MERGE INTO skutaxbands FROM   w_ii_odm_sku
        -- Mark as processed UPDATE w_ii_odm_sku SET    processed_dtm = SYSDATE
    -- usp_ps_job_importstockskualias
        -- MERGE INTO STOCKSKUALIAS FROM w_ii_odm_upc
7. # Load order data into OMS f_jobstep s_ssh.sh -b -r oms s_ii_process.sh omsordii
    -- SELECT * FROM  r_ii_process WHERE  proc_group_id = upper('omsordii')
    -- OMS_IMPORT_ORDER.P_PROCESS_ORDER
        -- Recycle errored orders from previous run, copy error records back from *_err tables to corresponding working tables.
        -- Perform validations
            -- pl_dupl_trans_chk,  Check for orders that are already in the system
            -- pl_order_hdr_chk,
                --Check for missing mandatory columns not null fields (deliv_by_dtm, deliv_type, earliest_collect_dtm, ord_source, dest_type, pmt_point, ord_currency, lang_locale, exchange_rate)
                -- Conditional mandatory if source code is store then  ord_store_num, pos_sk_sale_id, till_receipt_id should be not null.
                    -- if source code is store and destination is store then deliv_store_num should be not null.
                    -- Validate lookup values ord_source(oms_ord_const.C_ord_source),  dest_type(oms_ord_const.C_dest_type), pmt_point(oms_ord_const.C_pmt_pt) should be in s_char_codes for corresponding code_type.
                    -- order store is valid if ordered in store
                    -- destination store is valid if ordered in store and destination type is store
                    -- currency code must exist in currencytable
                    -- exchange_rate must be greater than zero
                    -- Check for headers with no address record
                    -- Check for headers with no contact record
                    -- Check for headers with no item record
                    -- Check for headers with no tender record
                    -- Check for address records with no header record
                    -- Check for contact records with no header record
                    -- Check for item records with no header record
                    -- Check for tender records with no header record
            -- pl_order_value_chk
                -- Check for orders where the total_ord_value does not equal the sum of the prices for all of the items on the order, plus the postage
                -- Check for orders where the auth_amount does not equal the sum of the prices for all of the items on the order, plus the postage
            -- pl_vld_sku
                -- Check for order lines where SKU is not present in stock table
                -- Check for order lines where SKU is not present in stockskualias table
            -- pl_order_cancel_chk
                -- Check order exists in orderheader for order cancel request
        -- If any records failed validation, log this and send emails to interested parties pl_log_error(I_feed_id);
        -- Load order details into oms table, customer URN is generated and shared across all tables.
        pl_load_customers    (I_feed_id => I_feed_id);
            --  For existing customers, updates the customer table if any details have changed. For new customers insert into customer and customeralias
            -- If the order was made in store and new customer then create records with blank address rather than store address
            -- Customer URN is sequnce generated 10 char 0 padded number.
            -- Cursor prepares a blanked out address for store orders and then this cursor is used to update and insert the customer details
        pl_load_contacts     (I_feed_id => I_feed_id);
            -- Loads new customer contact details into customercontacts table
        pl_load_addresses    (I_feed_id => I_feed_id);
            -- Loads new customer address details into customeraddressbook table
        pl_load_orderalias   (I_feed_id => I_feed_id);
            -- Loads order numbers into orderalias table, The order number that is sent from the website will be used for the ordernumber and newmediaordernumber coloumns
        pl_load_order_hdrs   (I_feed_id => I_feed_id);
            --  Loads orders into orderheader table and order header status table
        pl_load_order_tndrs  (I_feed_id => I_feed_id);
            -- Loads order tender information to order_tndr table
            -- select * from eftconfig
        pl_load_order_items  (I_feed_id => I_feed_id);
            -- Loads order items into orderitemheader

        pl_load_order_promo  (I_feed_id => I_feed_id);
        pl_load_payments     (I_feed_id => I_feed_id); -- Loads order payment details into the following tables pblheader, pbldetail, eftheader and pbltxn
        pl_upd_orders        (I_feed_id => I_feed_id);
        pl_cancel_orders     (I_feed_id => I_feed_id);

8. # Check if web order errors have exceeded the limits and accordingly fail the job f_jobstep cms_hso_ord_error_check.sh

----------------------------------------------------------------------
SDITRFDTE : Table to hold transfer data that has been exported out of  ODBMS using SDI procedures
SDITRFDTI : Table to hold transfer data that is being imported into ODBMS using SDI procedures
SDIPOSEE - Table holds pos details.
cms_pkm_c_out.sh  > cms_pkm_out.sh

How frequently we need to call the WMS BATCH JOB.
Removing some redundant code , like if more than 99 then only pick 99 items
pre order product

SELECT TRIM(sku.prd_lvl_number) AS sku_id,
       sku.prd_lvl_child,
       pop.hold_start_dt,
       pop.release_dt
FROM   r_pre_ord_product pop
       JOIN prdplvee plv
           ON (pop.prd_lvl_child = plv.prd_lvl_parent)
       JOIN prdmstee sku
           ON (plv.prd_lvl_child = sku.prd_lvl_parent)
       JOIN prdstsee sts
           ON (sts.prd_status = sku.prd_status)
WHERE  sts.prd_status_code = 'ACT'
AND    plv.prd_lvl_id      = 1
UNION
SELECT TRIM(sku.prd_lvl_number) AS sku_id,
       sku.prd_lvl_child,
       pop.hold_start_dt,
       pop.release_dt
FROM   r_pre_ord_product pop
       JOIN prdmstee sku
           ON (pop.prd_lvl_child = sku.prd_lvl_parent)
       JOIN prdstsee sts
           ON (sts.prd_status = sku.prd_status)
WHERE  sts.prd_status_code = 'ACT'
AND    sku.prd_lvl_id      = 0;

JobStep-1 f_jobstep s_io.sh -e dctransio -- SELECT * FROM r_io_export WHERE lower(proc_group_id) = 'dctransio'
    -- 1. dc_trf_export.p_export
        -- select * from trfstscd where trf_sts_desc='Pick Release';
        -- If any record present in trfhdrae with trf_status=2 (above) or (trf_rec_loc=500(org_lvl_child for RI WEB, store 400) and trf_ship_loc is a live rpos store) then call
        -- select * from trfstscd
        -- p_dataman = cms_dataman.p_run('INV','HDR', 'SDI')
            -- SELECT * FROM APPMSTEE  where app_name in ('INV')
            -- frtch L_max_audit_number as not provided SELECT MAX(audit_number) FROM invqueee (first three letters of the table is variable)
            -- p_to_inbound('INV','HDR', L_max_audit_number)
                -- This runs the 1st part of data manager copying entries from the queue tables to maninbee.
                -- INSERT INTO maninbee (audit_number,app_name,app_func) SELECT audit_number,app_name,app_func FROM invqueee AND app_func IN ('INV') -- Dynamic SQL
                -- DELETE FROM invqueee AND app_func IN ('INV') -- Dynamic SQL
            -- p_to_outbound('INV','HDR', L_max_audit_number)
                --This runs the 2nd part of data manager copying entries from the  inbound table (maninbee) to the outbound table (manoutee)
                -- INSERT INTO manoutee (audit_number, app_dest, app_name, app_func) SELECT inb.audit_number, rte.app_dest, inb.app_name, inb.app_func FROM maninbee inb, apprteee rte
                -- WHERE NOT EXISTS (SELECT * FROM manoutee out WHERE OUT.audit_number=inb.audit_number) AND rte.app_name=inb.app_name AND rte.app_func=inb.app_func ...
            -- p_process_outbound('INV','HDR', 'SDI')
                /*
                    L_app_sql_str
                    SELECT app_name, app_post_process
                    FROM   appmstee
                    WHERE  app_name IN ('INV')

                    L_proc_sql_str := L_proc_sql_str || L_proc_where_clause
                    SELECT app_schema_btch, app_func
                    FROM   apprteee rte
                    WHERE  EXISTS
                    (SELECT * FROM manoutee owt
                        WHERE  rte.app_dest = owt.app_dest
                            AND    rte.app_name = owt.app_name
                            AND    rte.app_func = owt.app_func )
                            AND    rte.app_schema_btch IS NOT NULL
                            AND    rte.app_name = 'INV'  -- outut of L_app_sql_str.app_name
                            AND rte.app_func IN ('HDR')
                            AND rte.app_dest IN ('SDI')
                */
                -- BEGIN dnltrfdtlex; END;
                -- JDA proc to extract transfers to SDI
                    -- INSERT INTO sditrfdte
                    -- DELETE FROM manoutee, FROM maninbee
                    -- trfhdrae audit_type= A or C or D
                    -- TRFHDREE PK is TRF_NUMBER and TRFDTLEE PK is TRF_NUMBER, PRD_LVL_MASTER, PRD_LVL_CHILD
                    -- INVBALEE PK is ORG_LVL_CHILD, PRD_LVL_CHILD, INV_TYPE_CODE
                    ..
                    ..
                    ..
                -- Then app_post_process from APPMSTEE
    -- 2. pkm_export.p_transfer
        -- Flag transfers with a zero qty as processed to avoid WMS processing: UPDATE sditrfdte SET sdit.download_date_2 = G_odbms_dt where v_download_date_2_ind = s_const.C_false AND sdit.quantity = 0 AND
        -- (action_code <> dc_const.C_actn_shipped or (action_code = dc_const.C_actn_shipped and to_loc is a web store and (from location is store or from location is dc_const.C_hso_returns_loc))
        -- Insert unprocessed data into copy table on WMS database : INSERT INTO vw_wms_sditrfdte  FROM  sditrfdte sdit exatcly above filter except sdit.quantity = 0
        -- Update table for all data : UPDATE  sditrfdte sdit SET sdit.download_date_2 = G_odbms_d exactly same filer as above
        -- To cater for store to web store transfers, Set download_date_2 so the transfers are not reported to Customs warehouse
    -- 3. pkm_export.p_hso_pick
        -- Set extract_to_pkm_dtm to low date to mark which records: UPDATE trans_hso_ord_hdr SET extracted_to_pkm_dtm = s_const.C_low_dt WHERE  extracted_to_pkm_dtm IS NULL AND ord_status <> 0 -- 0=Pre ordered
        -- Pre ordered product INSERT INTO cms_hso_pre_ord FROM trans_hso_ord_hdr hdr join with  trans_hso_ord_item and vw_pre_ord_prd
        -- INSERT INTO w_io_dc_hso_pick from trans_hso_ord_hdr, trans_hso_ord_item and count of all items and not exists in cms_hso_pre_ord
            -- with from_loc=9001(DC) and to_loc=400(HSO)
            -- Two step insert pick data for normal orders and pre-orders
        -- Populate WMS table INSERT INTO vw_wms_w_ii_dc_hso_pick(w_ii_dc_hso_pick@wms) FROM   w_io_dc_hso_pick
        -- Delete CMS records after processing DELETE FROM w_io_dc_hso_pick WHERE  processed_dtm IS NULL;
    -- 4. pkm_export.p_asn_alloc : Not Active
        -- Execute Data Manager for ASN alloc cms_dataman.p_run
        -- INSERT INTO vw_wms_sdipmgasn(sdipmgasn@wms) FROM sdipmgasn WHERE v_download_date_2_ind = s_const.C_false;
        -- UPDATE  sdipmgasn SET download_date_2 = G_odbms_dt WHERE   v_download_date_2_ind = s_const.C_false ;
    -- 5. pkm_export.p_po_alloc : Not Active
        -- Execute Data Manager for PO allocs
            -- INSERT INTO vw_wms_sdipmgall FROM sdipmgall WHERE v_download_date_2_ind = s_const.C_false;
            -- UPDATE sdipmgall SET download_date_2 = G_odbms_dt WHERE v_download_date_2_ind = s_const.C_false;
    -- 6. pkm_export.p_rtv : Return To Vendor
        -- Execute Data Manager for RTV
            -- INSERT INTO vw_wms_uk_sdirtvdte FROM uk_sdirtvdte WHERE v_download_date_2_ind = s_const.C_false;
            -- UPDATE uk_sdirtvdte SET download_date_2 = G_odbms_dt WHERE v_download_date_2_ind = s_const.C_false;
    -- 7. pkm_export.p_po   : Control Purchase Order export to WMS
        -- Create audits if changes made to the mutipack attribute buy updating pmgdtlee and so creating pmgdtlae records
        -- Get max audit_number from basvalee where entity_name='PMGDTLEE' and field_code='OP' -- Multipack ind
        -- UPDATE pmgdtlee pmg SET pmg.pmg_last_chg_dt  = SYSDATE, pmg.pmg_last_chg_usr = C_devteam_usr WHERE pmg.pmg_dtl_tech_key IN in basvalee
        -- cms_dataman.p_run for additional fields
    -- 8. pkm_export.p_vendor   : Control the Vendor export to WMS
        -- Execute Data Manager for Vendors   cms_dataman.p_run
        -- INSERT INTO vw_wms_sdivpcmst FROM sdivpcmst WHERE v_download_date_2_ind = s_const.C_false AND iss_tech_key = G_iss_tech_key;
        --  UPDATE sdivpcmst SET download_date_2 = G_odbms_dt WHERE v_download_date_2_ind = s_const.C_false AND  iss_tech_key = G_iss_tech_key;
    -- 9. pkm_export.p_location   : Control Store export to WMS
        -- Execute Data Manager for Stores cms_dataman.p_run
        -- INSERT INTO vw_wms_sdiorgmst  FROM  sdiorgmst sdi JOIN alt_orgmstee org JOIN alt_orgmstee chnl
        -- UPDATE  sdiorgmst SET download_date_2 = G_odbms_dt WHERE  v_download_date_2_ind = s_const.C_false AND iss_tech_key = G_iss_tech_key;
    -- 10. pkm_export.p_product   : Control product export to WMS
        -- Execute Data Manager for products cms_dataman.p_run('BAS','PRD','SDI') and cms_dataman.p_run('BAS','ATP','SDI') -- Ultimately records ended in sdiprdmst
        -- INSERT INTO vw_wms_sdiprdmst  FROM  sdiprdmst JOIN alt_prdmstee apd JOIN alt_prdmstee apd2
        -- UPDATE  sdiprdmst SET  download_date_2 = G_odbms_dt WHERE   v_download_date_2_ind = s_const.C_false AND     iss_tech_key = G_iss_tech_key;
        -- INSERT INTO vw_wms_w_ii_prd_attr FROM    sdiprdsdi sdi
    -- 11. pkm_export.p_upc   : Control Bar code export to WMS
        -- Execute Data Manager for products cms_dataman.p_run('BAS','UPC','SDI') -- Ultimately records ended in sdiprdupc
        -- INSERT INTO vw_wms_sdiprdupc  FROM  sdiprdupc
        -- UPDATE  sdiprdupc SET     download_date_2 = G_odbms_dt WHERE   v_download_date_2_ind = s_const.C_false AND     iss_tech_key = G_iss_tech_key;
    -- 12. p_proc_mnfst   : executes the datamanager processes for processing manifest
        -- Execute Data Manager for manifest cms_dataman.p_run('INV','MFH','SDI')
JobStep-2  f_jobstep s_ssh.sh -b -r wms wms_ii_pkmi.sh
for L_JOB in "wms_ii_item_master.sh"   \ #f_jobstep s_sql.sh -x inpt_item_master_proc "'${ORACLE_SID}'" and f_jobstep wms_ii_pkbridge.sh ItemMaster
             "wms_ii_item_xref.sh"     \ #f_jobstep s_sql.sh -x inpt_item_xref_proc "'${ORACLE_SID}'" and f_jobstep wms_ii_pkbridge.sh XRef
             "wms_ii_store_master.sh"  \ #f_jobstep s_sql.sh -x inpt_store_master_proc "'${ORACLE_SID}'" and f_jobstep wms_ii_pkbridge.sh Store
             "wms_ii_vendor_master.sh" \ #f_jobstep s_sql.sh -x inpt_vendor_master_proc "'${ORACLE_SID}'" and f_jobstep wms_ii_pkbridge.sh Vendor
             "wms_ii_po.sh"            \ #f_jobstep s_sql.sh -x inpt_po_proc "'${ORACLE_SID}'" and f_jobstep wms_ii_pkbridge.sh PO
             "wms_ii_rtv_pkt.sh"       \ #f_jobstep s_sql.sh -x inpt_rtv_pkt_proc "'${ORACLE_SID}'" , f_jobstep s_sql.sh -x inpt_xfer_proc "'${ORACLE_SID}'" and f_jobstep wms_ii_pkbridge.sh Pkt
             "wms_ii_asn.sh"           \#f_jobstep s_sql.sh -x inpt_asn_proc "'${ORACLE_SID}'" and f_jobstep wms_ii_pkbridge.sh Asn
             "wms_ii_store_distro.sh"   #f_jobstep s_sql.sh -x inpt_store_distro_type1_proc "'${ORACLE_SID}'", f_jobstep s_sql.sh -x p_ii_hso_pick "'${ORACLE_SID}'" and f_jobstep wms_ii_pkbridge.sh Distro
do
   f_jobstep ${L_JOB}
done
---

cms hso rcn rn

There is no change to r_io_export because we want pkm_export.p_hso_pick to be executed for orders coming through HSO106, untill we decomission that.
wms_ii_store_distro.sh can be taken off and added to a completely new schedule??

Change to wms_ii_store_distro.sh
This will create the transfer entries and hso order into input store distro.
Add a new job step to call the scripts.

To decouple we need to take wms_ii_store_distro.sh step out of wms_ii_pkmi.sh. and put that in WMS schedule.

pkm_export.p_hso_pick inserts into cms.W_IO_DC_HSO_PICK >> rwm.w_ii_dc_hso_pick

RWM.P_II_HSO_PICK >> inert into inpt_store_distro from w_ii_dc_hso_pick

W_IO_DC_HSO_PICK -> inpt_store_distro > wms_ii_pkbridge > store_distro

INPT_STORE_DISTRO_TYPE1_PROC >> insert into inpt_store_distro from cursor joining sditrfdte, store_master and address table with most of values null including prty_code

After the WMS Bridge program has run successfully, there should be no entries left in the corresponding INPT_ tables.

There is no pre order product(pre_order)

select * from VW_PRE_ORD_PRD

Deliv_type of rwm.w_ii_dc_hso_pick goes to prty_code of inpt_store_distro

Procedures using the field are :  MANH_INVOICE_PKT_INSERT, INPT_STORE_DISTRO_TYPE1_PROC, INPT_STORE_DISTRO_TYPE3_PROC, P_II_HSO_PICK

Can run wave template by new service group and earliest collection day
Latest Despatch Date (earliestCollectionDate) = STORE_DISTRO. IN_STORE_DATE (Data Type, DATE)
DateRef (latestDeliveryDate.DAY_OF_MONTH) = STORE_DISTRO. PPACK_GRP_CODE (Data Type, Varchar2(8))

select in_store_date, ppack_grp_code from inpt_store_distro

select * from store_distro where  distro_nbr in ('W3000000000','W3000000001','W3000000002','W3000000003', 'W3000000004','W3000000005')

create table saroj_store_distro as select * from store_distro where  distro_nbr in ('W3000000000','W3000000001','W3000000002','W3000000003', 'W3000000004','W3000000005')

update inpt_store_distro set ppack_grp_code = to_char(sysdate,'dd') + substr(distro_nbr,-1)+1
where  distro_nbr in ('W3000000000','W3000000001','W3000000002','W3000000003', 'W3000000004','W3000000005')

lock table inpt_store_distro in exclusive mode

lock table store_distro in exclusive mode

echo -n OBD WebServices:83dGtRchJ0 | base64

Output = T0JEIFdlYlNlcnZpY2VzOjgzZEd0UmNoSjA=

CREATE TABLE s_webservice_config
(
  system_id            VARCHAR2(10),
  service_name         VARCHAR2(30),
  project_phase        VARCHAR2(3),
  endpoint_url_prefix  VARCHAR2(200),
  username             VARCHAR2(200),
  password             VARCHAR2(200),
  max_retries          NUMBER(2),
  batch_size           NUMBER(12),
  encoded_auth_header  VARCHAR2(500),
  --
  oauth_audience       VARCHAR2(200)
)
/

https://notifications-api.dev.order.ri-tech.io/
http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/product/v1/suppliers

http://ords-alb.staging.transit.ri-tech.io/ords/cmsuat/api/ordermanagement/v1/paymentnotifications

http://ords-alb.dev.transit.ri-tech.io/ords/omsdev/api/oauth/token
****Pick Load Analysis****
    -- Status codes for pick load(table pick_load)
Story to be done

Publishing pick load events from WMS
Processing pick load events in

Interfaced to OMS -> Ready for release

    C_pickload_status       CONSTANT s_num_codes.code_type%TYPE
    := 'MDS_LOAD_STATUS';

    C_pickload_interfaced_oms      CONSTANT s_num_codes.code%TYPE  := 20;
    C_pickload_failed              CONSTANT s_num_codes.code%TYPE  := 30;
    C_pickload_ready_for_release   CONSTANT s_num_codes.code%TYPE  := 40;
    C_pickload_released            CONSTANT s_num_codes.code%TYPE  := 50;
    C_pickload_sorting             CONSTANT s_num_codes.code%TYPE  := 60;
    C_pickload_sorted              CONSTANT s_num_codes.code%TYPE  := 90;
    C_pickload_locating            CONSTANT s_num_codes.code%TYPE  := 100;
    C_pickload_located             CONSTANT s_num_codes.code%TYPE  := 110;
    C_pickload_packing             CONSTANT s_num_codes.code%TYPE  := 130;
    C_pickload_packed              CONSTANT s_num_codes.code%TYPE  := 150;
    C_pickload_caged               CONSTANT s_num_codes.code%TYPE  := 170;
    C_pickload_despatched          CONSTANT s_num_codes.code%TYPE  := 190;
    C_pickload_cancelled           CONSTANT s_num_codes.code%TYPE  := 200;

Concerns
Exceptions does not have a load number??
Pick exceptions has to be processed first
Special processing for mixed load?
Special processing for International load?
admin release?

select apex_web_service.make_rest_request(
    p_url => 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson',
    p_http_method => 'GET' ) from dual;

Tasks:

select s_env.f_getenv('S_WALLET_DIR') from dual;

WMS Changes

Create standard package for 1. Generating UUID, Geting oauth token
Create two tables W_IO_PICK_LOAD_HDR and W_IO_PICK_LOAD_DTL (non Partitioned)
Create package WMS_PICK_LOAD which identifies the candidate records and call api gateway for Publishing
Change to p_io_hso_pick??

CMS :
Create table W_II_PICK_LOAD_HDR and W_II_PICK_LOAD_DTL
Create package CMS_PICK_LOAD
Changes to

OMS :
Create table W_II_PICK_LOAD_HDR and W_II_PICK_LOAD_DTL
Create package OMS_PICK_LOAD
Update

create table saroj_pick_data_analysis as
SELECT
    hdr.load_nbr,
    hdr.carton_nbr,
    ph.invc_batch_nbr,
    ph.pkt_ctrl_nbr,
    pd.distro_nbr,
    pd.pkt_seq_nbr,
    cdtl.units_pakd,
    ph.proc_stat_code,
    hdr.create_date_time as crtn_create_date_time,
    ph.create_date_time  as pkt_create_date_time
FROM outpt_pkt_hdr ph
JOIN outpt_pkt_dtl pd
    ON (ph.invc_batch_nbr = pd.invc_batch_nbr
    AND ph.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr)
JOIN outpt_carton_dtl cdtl
    ON (cdtl.pkt_ctrl_nbr = pd.pkt_ctrl_nbr
    AND cdtl.pkt_seq_nbr  = pd.pkt_seq_nbr)
JOIN outpt_carton_hdr hdr
    ON (hdr.invc_batch_nbr = cdtl.invc_batch_nbr
    AND hdr.carton_nbr     = cdtl.carton_nbr)
JOIN store_distro sd
    ON  (sd.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr
    AND sd.pkt_seq_nbr    = pd.pkt_seq_nbr)
WHERE SUBSTR(sd.distro_nbr,1,1) = 'W';

select d1.distro_nbr, d2.load_nbr, d1.load_nbr
from saroj_pick_data_analysis d1
join saroj_pick_data_analysis d2
on (d1.distro_nbr = d2.distro_nbr
and d1.load_nbr <> d2.load_nbr);

select min(crtn_create_date_time), max(crtn_create_date_time) from saroj_pick_data_analysis;

select load_nbr, count(*), sum(units_pakd)
from saroj_pick_data_analysis
group by load_nbr order by 2 desc;

OMS Query
select * from trans_dc_pick_res where primary_pick_load_num <> pick_load_num;
--primary_pick_load_num seems to be the min pick load number for that order

w_io_web_ord_pick_hdr

w_io_web_ord_pick_item
---------------------------------------------------------------------- New WMS Pick Work

cms_pkm_to_oms.sh
--Script to control the upload of Home Shopping DC pick data from PkMS into OMS via the middleware.
f_jobstep s_ssh.sh  -b -r wms wms_io_hso_pick.sh
    -- -b use bash shell and -r reomte script
    --  f_jobstep s_sql.sh -x p_io_hso_pick (RWM schema)
        -- Update HSO Pick Ticket and Carton records as in process : outpt_pkt_hdr, outpt_pkt_dtl, outpt_carton_hdr, outpt_carton_dtl
        -- Insert shipments INSERT INTO w_io_dc_hso_pick from outpt_carton_hdr, outpt_carton_dtl, outpt_pkt_dtl, store_distro, item_master, item_whse_master

f_jobstep s_ii_process.sh dchsoii
    -- select * from r_ii_process where lower(proc_group_id)='dchsoii'-- PKM_IMPORT.P_PICK_RESULTS_TO_CMS and PKM_IMPORT.P_HSO_PICK
    -- PKM_IMPORT.P_PICK_RESULTS_TO_CMS
        -- insert into w_ii_dc_hso_pick from vw_w_io_dc_hso_pick(w_io_dc_hso_pick@wms);
        -- DELETE FROM vw_w_io_dc_hso_pick;
        -- Validate records
            -- UPDATE w_ii_dc_hso_pick wii SET ii_error_id  = cms_err_const.C_sku_unknown where not exists sku_id(prd_lvl_number)
            -- UPDATE w_ii_dc_hso_pick wii SET ii_error_id  = cms_err_const.C_loc_unknown where from_loc and to_loc does not exist in orgmstee
            -- Log errors INSERT INTO w_ii_dc_hso_pick_err
select * from all_col_comments where table_name='TRANS_DC_HSO_PICK'
OMS_STK - table to hold details of undispatched orders for Home Shopping
    -- PKM_IMPORT.P_HSO_PICK
        -- Copy records into middleware INSERT INTO trans_dc_hso_pick FROM   w_ii_dc_hso_pick
        -- MERGE INTO oms_stk from w_ii_dc_hso_pick
f_jobstep s_io.sh -e omsstkio
#
    --select * from r_io_export where lower(proc_group_id)='omsstkio';
    --cms_oms_export_stock.p_process_stock
    -- CMS view VW_W_II_OMS_STK -> w_ii_odm_stk@oms
f_jobstep s_ssh.sh -b -r oms oms_ii_stk.sh
    --f_jobstep s_sql.sh oms_import_stk.p_process_stk
----------------------------------------------------------------------
Things to test :
    make sure load details are populated properly in pick_load
    Make sure item numbers are allocated properly in trans_dc_pick_res
    make sure orderitemheader_status is updated properly

----------------------------------------------------------------------
There is not enough details in the model to get something meaning full.

INSERT INTO pick_load pl
    (pl.pick_load_num,
        pl.pick_load_status,
        pl.admin_released_ind,
        pl.created_dtm,
        pl.last_changed_dtm,
        pl.last_changed_by)
VALUES
    (FV_odm_stk.pick_load_num,
        oms_const.C_pickload_interfaced_oms,
        s_const.C_false,
        SYSDATE,
        SYSDATE,
        oms_const.C_system_user);

select * from all_constraints where table_name in ('OUTPT_PKT_HDR', 'OUTPT_PKT_DTL', 'OUTPT_CARTON_HDR', 'OUTPT_CARTON_DTL') and owner='WMS' and constraint_type<>'C';

select * from all_cons_columns where table_name in ('OUTPT_PKT_HDR', 'OUTPT_PKT_DTL', 'OUTPT_CARTON_HDR', 'OUTPT_CARTON_DTL') and owner='WMS' and constraint_name in
(select constraint_name from all_constraints where table_name in ('OUTPT_PKT_HDR', 'OUTPT_PKT_DTL', 'OUTPT_CARTON_HDR', 'OUTPT_CARTON_DTL') and owner='WMS' and constraint_type<>'C')
order by constraint_name, position;

select * from oms_area@oms where handle_split_load_ind ='T';

select * from oms_system_params where param_name='MANUAL_SORT';

RWM@wmsdev🍷 >desc w_io_dc_hso_pick
Name          Null? Type
------------- ----- ------------
DISTRO_ID           VARCHAR2(12)
MNFST_ID            VARCHAR2(48)
CARTON_ID           VARCHAR2(48)
ACTION_CODE         VARCHAR2(2)
FROM_LOC            NUMBER(12)
TO_LOC              NUMBER(12)
SKU_ID              VARCHAR2(15)
SKU_QTY             NUMBER(10,3)
CREATED_DTM         DATE
PROCESSED_DTM       DATE
PICK_LOAD_NUM       VARCHAR2(20)
ITEM_VOLUME         NUMBER(13,2)
ITEM_WEIGHT         NUMBER(13,2)
FLAT_HANG           VARCHAR2(1)


WMS	PK_OUTPT_CARTON_DTL	OUTPT_CARTON_DTL	INVC_BATCH_NBR	1
WMS	PK_OUTPT_CARTON_DTL	OUTPT_CARTON_DTL	CARTON_NBR	2
WMS	PK_OUTPT_CARTON_DTL	OUTPT_CARTON_DTL	CARTON_SEQ_NBR	3
WMS	PK_OUTPT_CARTON_HDR	OUTPT_CARTON_HDR	INVC_BATCH_NBR	1
WMS	PK_OUTPT_CARTON_HDR	OUTPT_CARTON_HDR	CARTON_NBR	2
WMS	PK_OUTPT_PKT_DTL	OUTPT_PKT_DTL	INVC_BATCH_NBR	1
WMS	PK_OUTPT_PKT_DTL	OUTPT_PKT_DTL	PKT_CTRL_NBR	2
WMS	PK_OUTPT_PKT_DTL	OUTPT_PKT_DTL	PKT_SEQ_NBR	3
WMS	PK_OUTPT_PKT_HDR	OUTPT_PKT_HDR	INVC_BATCH_NBR	1
WMS	PK_OUTPT_PKT_HDR	OUTPT_PKT_HDR	PKT_CTRL_NBR	2

UPDATE outpt_pkt_hdr ph
SET    proc_stat_code = rpk_const.C_hso_in_process_status
WHERE  proc_stat_code = rpk_const.C_unprocessed_ctn_status
AND EXISTS
    (SELECT 1
        FROM   outpt_carton_dtl cdtl,
            outpt_pkt_dtl pd,
            store_distro sd
        WHERE  ph.invc_batch_nbr = pd.invc_batch_nbr
        AND    ph.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr
        AND    cdtl.pkt_ctrl_nbr = pd.pkt_ctrl_nbr
        AND    cdtl.pkt_seq_nbr  = pd.pkt_seq_nbr
        AND    sd.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr
        AND    sd.pkt_seq_nbr    = pd.pkt_seq_nbr
        AND    SUBSTR(sd.distro_nbr,1,1)
                                = rpk_hso_const.C_hso_ord_distro_prefix)

SELECT
    hdr.load_nbr,
    hdr.carton_nbr,
    ph.invc_batch_nbr,
    ph.pkt_ctrl_nbr,
    pd.distro_nbr,
    pd.pkt_seq_nbr
FROM outpt_pkt_hdr ph
JOIN outpt_pkt_dtl pd
    ON (ph.invc_batch_nbr = pd.invc_batch_nbr
    AND ph.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr)
JOIN outpt_carton_dtl cdtl
    ON (cdtl.pkt_ctrl_nbr = pd.pkt_ctrl_nbr
    AND cdtl.pkt_seq_nbr  = pd.pkt_seq_nbr)
JOIN outpt_carton_hdr hdr
    ON (hdr.invc_batch_nbr = cdtl.invc_batch_nbr
    AND hdr.carton_nbr     = cdtl.carton_nbr)
JOIN store_distro sd
    ON  (sd.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr
    AND sd.pkt_seq_nbr    = pd.pkt_seq_nbr)
WHERE SUBSTR(sd.distro_nbr,1,1) = 'W';

select * from logger_logs where time_stamp > sysdate - 1/24 and scope='p_io_hso_pick' and text='Begin' order by 1 desc;

/*
--records with same PKT_CTRL_NBR but different CARTON_NBR - Exists
select PKT_CTRL_NBR ,count(*)
from outpt_carton_hdr group by PKT_CTRL_NBR having count( distinct CARTON_NBR) > 1;

--records with same CARTON_NBR but different PKT_CTRL_NBR - Does not exists
select CARTON_NBR ,count(*)
from outpt_carton_hdr group by CARTON_NBR having count( distinct PKT_CTRL_NBR) > 1;

WMS Table structure
info++ outpt_carton_hdr
Indexes
INDEX_NAME                   UNIQUENESS   STATUS   FUNCIDX_STATUS   COLUMNS
WMS.PK_OUTPT_CARTON_HDR      UNIQUE       VALID                     INVC_BATCH_NBR, CARTON_NBR
WMS.OUTPT_CARTON_HDR_IND_1   NONUNIQUE    VALID                     CARTON_NBR
WMS.OUTPT_CARTON_HDR_IND_2   NONUNIQUE    VALID                     PKT_CTRL_NBR
WMS.OUTPT_CARTON_HDR_IND_3   NONUNIQUE    VALID                     PROC_STAT_CODE, WHSE


info++ outpt_carton_dtl
Indexes
INDEX_NAME                   UNIQUENESS   STATUS   FUNCIDX_STATUS   COLUMNS
WMS.PK_OUTPT_CARTON_DTL      UNIQUE       VALID                     INVC_BATCH_NBR, CARTON_NBR, CARTON_SEQ_NBR
WMS.OUTPT_CARTON_DTL_IND_1   NONUNIQUE    VALID                     CARTON_NBR, CARTON_SEQ_NBR
WMS.OUTPT_CARTON_DTL_IND_2   NONUNIQUE    VALID                     PKT_CTRL_NBR, PKT_SEQ_NBR
WMS.OUTPT_CARTON_DTL_IND_3   NONUNIQUE    VALID                     SKU_ID
WMS.OUTPT_CARTON_DTL_IND_4   NONUNIQUE    VALID                     CREATE_DATE_TIME
WMS.OUTPT_CARTON_DTL_IND_5   NONUNIQUE    VALID                     PROC_STAT_CODE


info++ outpt_pkt_hdr
Indexes
INDEX_NAME                UNIQUENESS   STATUS   FUNCIDX_STATUS   COLUMNS
WMS.PK_OUTPT_PKT_HDR      UNIQUE       VALID                     INVC_BATCH_NBR, PKT_CTRL_NBR
WMS.OUTPT_PKT_HDR_IND_1   NONUNIQUE    VALID                     PKT_CTRL_NBR
WMS.OUTPT_PKT_HDR_IND_2   NONUNIQUE    VALID                     MOD_DATE_TIME, PROC_STAT_CODE


info++ outpt_pkt_dtl
Indexes
INDEX_NAME                UNIQUENESS   STATUS   FUNCIDX_STATUS   COLUMNS
WMS.PK_OUTPT_PKT_DTL      UNIQUE       VALID                     INVC_BATCH_NBR, PKT_CTRL_NBR, PKT_SEQ_NBR
WMS.OUTPT_PKT_DTL_IND_1   NONUNIQUE    VALID                     PKT_CTRL_NBR, PKT_SEQ_NBR
WMS.OUTPT_PKT_DTL_IND_2   NONUNIQUE    VALID                     PROC_STAT_CODE

select p1.distro_nbr, p1.pkt_ctrl_nbr||p1.pkt_seq_nbr , p2.pkt_ctrl_nbr||p2.pkt_seq_nbr
from outpt_pkt_dtl p1
join outpt_pkt_dtl p2
on(p1.distro_nbr = p2.distro_nbr
and p1.pkt_ctrl_nbr||p1.pkt_seq_nbr <> p2.pkt_ctrl_nbr||p2.pkt_seq_nbr)

*/

How will we post the pick exceptions, they are not linked to any load? order sku_id, quantity not picked

select invc_batch_nbr, pkt_ctrl_nbr,count(distro_nbr)
from outpt_pkt_dtl group by invc_batch_nbr, pkt_ctrl_nbr
order by 3 desc;

select opd.invc_batch_nbr, opd.pkt_ctrl_nbr, count(distinct opd.distro_nbr), SUM(ocd.units_pakd), count(opd.distro_nbr)
from outpt_pkt_dtl  opd
join outpt_carton_dtl ocd
on(opd.invc_batch_nbr = ocd.invc_batch_nbr
and opd.pkt_ctrl_nbr = ocd.pkt_ctrl_nbr
and opd.pkt_seq_nbr = ocd.pkt_seq_nbr)
group by opd.invc_batch_nbr, opd.pkt_ctrl_nbr
order by 3 desc;

Finding :
cms_oms_export_stock
oms_import_stk
select * from trans_dc_pick_res where item_width is not null; -- no record in prod item_length, item_width, item_height
p_io_hso_pick
UPDATE outpt_pkt_hdr ph
SET    proc_stat_code = rpk_const.C_hso_in_process_status
WHERE  proc_stat_code = rpk_const.C_unprocessed_ctn_status
AND EXISTS
    (SELECT 1
        FROM   outpt_carton_dtl cdtl,
            outpt_pkt_dtl pd,
            store_distro sd
        WHERE  ph.invc_batch_nbr = pd.invc_batch_nbr
        AND    ph.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr
        AND    cdtl.pkt_ctrl_nbr = pd.pkt_ctrl_nbr
        AND    cdtl.pkt_seq_nbr  = pd.pkt_seq_nbr
        AND    sd.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr
        AND    sd.pkt_seq_nbr    = pd.pkt_seq_nbr
        AND    SUBSTR(sd.distro_nbr,1,1)
                                = rpk_hso_const.C_hso_ord_distro_prefix);
--
-- same for all four tables outpt_pkt_hdr, outpt_pkt_dtl, outpt_carton_hdr, outpt_carton_dtl
--
INSERT INTO w_io_dc_hso_pick
(
    distro_id,
    mnfst_id,
    carton_id,
    action_code,
    from_loc,
    to_loc,
    sku_id,
    sku_qty,
    created_dtm,
    pick_load_num,
    item_volume,
    item_weight,
    flat_hang
)
SELECT
    pd.distro_nbr,
    hdr.store_nbr || hdr.load_nbr,
    dtl.carton_nbr,
    s_code.f_trlt_to_char('DC_PICK_ACTION', 'PICK'),
    rpk_const.C_cms_milton_keynes_dc_id,
    hdr.store_nbr,
    TO_NUMBER(dtl.sku_id),
    SUM(dtl.units_pakd),
    L_processed_dtm,
    hdr.load_nbr,
    im.unit_vol,
    iwm.misc_numeric_2,
    CASE
        WHEN SUBSTR(hdr.carton_type,1,2) = rpk_const.C_ctn_type_flat
        THEN
            rpk_const.C_fh_flat
        WHEN SUBSTR(hdr.carton_type,1,2) = rpk_const.C_ctn_type_hanging
        THEN
            rpk_const.C_fh_hanging
        ELSE
            rpk_const.C_fh_hanging
    END AS flat_hang
FROM
    outpt_carton_hdr hdr
    JOIN outpt_carton_dtl dtl
        ON (hdr.invc_batch_nbr = dtl.invc_batch_nbr
        AND hdr.carton_nbr     = dtl.carton_nbr)
    JOIN outpt_pkt_dtl pd
        ON (dtl.pkt_ctrl_nbr   = pd.pkt_ctrl_nbr
        AND dtl.pkt_seq_nbr    = pd.pkt_seq_nbr
        AND dtl.invc_batch_nbr = pd.invc_batch_nbr
        AND pd.distro_type     = rpk_const.C_type_1_distro)
    JOIN store_distro sd
        ON (sd.pkt_ctrl_nbr    = pd.pkt_ctrl_nbr
        AND sd.pkt_seq_nbr     = pd.pkt_seq_nbr)
    LEFT OUTER JOIN item_master im
        ON (im.sku_id          = dtl.sku_id)
    LEFT OUTER JOIN item_whse_master iwm
        ON (iwm.sku_id         = im.sku_id)
WHERE hdr.proc_stat_code = rpk_const.C_hso_in_process_status
GROUP BY
    pd.distro_nbr,
    hdr.store_nbr,
    hdr.load_nbr,
    dtl.carton_nbr,
    s_code.f_trlt_to_char('DC_PICK_ACTION','PICK'),
    rpk_const.C_cms_milton_keynes_dc_id,
    hdr.store_nbr,
    TO_NUMBER(dtl.sku_id),
    im.unit_vol,
    iwm.misc_numeric_2,
    hdr.carton_type,
    L_processed_dtm;

select s_code.f_trlt_to_char('DC_PICK_ACTION','PICK') action_code_pick, s_code.f_trlt_to_char('DC_PICK_ACTION','PICK EXCEPTION') action_code_mispick from dual;

INSERT INTO vw_w_ii_oms_load_order_mdt -- w_ii_oms_load_order@mdt
    (carrier_collection_dtm,
    international_ind,
    multi_item_order_ind,
    ordernumber,
    service_group,
    service_group_descr,
    sort_load_id)

INSERT INTO vw_w_ii_oms_load_item_mdt
(sort_load_id,
ordernumber,
itemnumber,
sku,
quantity)

INSERT INTO vw_w_ii_oms_load_sku_upc_mdt
(sku,
sku_upc,
sort_load_id)

-- Write all the SKU details for the orders which have been interfaced
INSERT INTO vw_w_ii_oms_load_sku_dtl_mdt
(nonsortable_ind,
sku,
sku_descr,
sku_height,
sku_length,
sku_volume,
sku_weight,
sku_width,
sort_load_id)

INSERT INTO vw_w_ii_oms_load_mdt
(admin_release_ind,
created_dtm,
last_changed_dtm,
exclusive_sort_ind,
load_status,
released_ind,
sort_load_id)

-- Set the pick exceptions as processed
UPDATE trans_dc_pick_res res
SET    res.processed_dtm = SYSDATE
WHERE  s_util.f_idx_null_test(res.processed_dtm) =  s_const.C_true
AND    res.action_code = oms_const.C_action_code_pick_except;

SELECT sng.pick_load_num  AS pick_load_num,
       CASE
           WHEN SUM(DECODE(complete_ind, 'T', 0, 1)) > 0
           THEN
               'T'
           ELSE
               'F'
       END                AS split_load_ind,
       SUM(CASE
               WHEN total_lines = 1 THEN 1 ELSE 0
           END)           AS tot_single_orders,
       SUM(CASE
               WHEN total_lines > 1 THEN 1 ELSE 0
           END)           AS tot_multi_orders,
       SUM (CASE
                WHEN total_lines > 1 THEN total_lines ELSE 0
            END)          AS tot_multi_items,
       SUM(CASE
               WHEN total_lines > 1
               AND  complete_ind = 'T'
               AND  first_time = 'T'
               THEN 1
               ELSE 0
           END) /
        SUM(CASE
               WHEN total_lines > 1
               AND  first_time = 'T'
               THEN 1
            END) * 100    AS pc_complete_multi_orders,
       SUM(CASE
               WHEN first_time = 'T' AND total_lines > 1
               THEN sng.total_items_missing
               ELSE 0
           END)           AS tot_multi_items_missing
FROM   (SELECT    mln.pick_load_num,
                  mln.oms_ord_number,
                  mln.total_lines,
                  mln.complete_ind,
                  mln.total_items_missing,
                  mln.first_time
        FROM     (SELECT pl.pick_load_num,
                         oms_ord_number,
                         COUNT(ih.ordernumber)
                             OVER(PARTITION BY ih.ordernumber)
                                                         AS total_lines,
                         CASE
                             WHEN SUM(DECODE(res.action_code, '01', 1, 0))
                                      OVER(PARTITION BY res.pick_load_num,
                                                        res.oms_ord_number) =
                                  COUNT(ih.ordernumber)
                                      OVER(PARTITION BY ih.ordernumber)
                             THEN 'T'
                             ELSE 'F'
                         END complete_ind,
                         COUNT(ih.ordernumber)
                             OVER(PARTITION BY ih.ordernumber) -
                         SUM(DECODE(res.action_code, '01', 1, 0))
                                      OVER(PARTITION BY res.pick_load_num,
                                                        res.oms_ord_number)
                                                         AS total_items_missing,
                         CASE
                             WHEN res.pick_load_num = res.primary_pick_load_num
                             THEN 'T'
                             ELSE 'F'
                         END first_time
                  FROM   trans_dc_pick_res res
                         JOIN pick_load pl
                           ON (res.pick_load_num = pl.pick_load_num
                          AND  pl.pick_load_status  = 20)
                         RIGHT OUTER JOIN
                             (SELECT DISTINCT ihdr.ordernumber,
                                              ihdr.itemnumber
                              FROM   orderitemheader_status ihdr,
                                     trans_dc_pick_res res2,
                                     pick_load pl2
                              WHERE ihdr.status_code <> 200
                              AND   res2.oms_ord_number = ihdr.ordernumber
                              AND   res2.pick_load_num  = pl2.pick_load_num
                              AND   pl2.pick_load_status = 20) ih
                           ON (ih.ordernumber = res.oms_ord_number
                          AND  res.oms_item_number = ih.itemnumber)
                 ) mln
        GROUP BY mln.pick_load_num,
                 mln.oms_ord_number,
                 mln.complete_ind,
                 mln.total_items_missing,
                 mln.first_time,
                 mln.total_lines) sng
GROUP BY sng.pick_load_num

---------------------------------------------------------------------

Store Order Analysis ---------------------

cms_pos_trans.sh

    ISSDEV CMSDEV : DB LINK CMS user in ISSDEV and ISS user in CMSDEV connect to each other.

    cms_pos_trans.p_data_load >>

        insert data into cms.w_ii_reporttransactions() from reporttransactions and w_iss_trans  : @RetailJ
        INSERT INTO w_ii_reportitems from reportitems and w_iss_trans
        UPDATE w_ii_reportitems ri SET    ri.sundry_id
        INSERT INTO w_ii_ord_cust_dtl from reporttransactions and baskets
        INSERT /*+ APPEND */ INTO w_ii_reporttransactions@PMM FROM w_ii_reporttransactions -- @PMM is CMS side
        INSERT /*+ APPEND */ INTO w_ii_reportitems@pmm FROM w_ii_reportitems
        INSERT /*+ APPEND */ INTO w_ii_ord_cust_dtl@pmm FROM w_ii_ord_cust_dtl;

        pl_future_transactions > UPDATE w_ii_reporttransactions hdr set ii_master_feed_id and

    cms_pos_trans.p_extract_trans
        pl_extract_cash_manage_trans

    cms_pos_trans.p_extr_ord_stk_to_unreserve >> INSERT INTO w_io_iss_ord_void_trans FROM w_ii_reportitems items JOIN w_ii_reporttransactions trans

    ..
    ..
    cms_hso_load_ord.sh -- Call script to extract pre-ordered Store Orders to the website
        cms_hso_load_ord.p_create_store_orders

SELECT * FROM trans_hso_ord_hdr where ord_status=0

SELECT * FROM s_char_codes where code_type='HSO_ORDER_STATUS'

Store Order Analysis ---------------------

pl_email_webservice_failure : Adds a email event s_process_event.p_add_event

pl_process_failed_orders : inserts into cms_hso_ord_load_err the failed order details

OLD Flow : p_create_store_orders
    > for the big cursor it calls pl_create_orders with batch of orders
        > calls cms_web_srvc_sto.createOrders:
            if exception then calls pl_email_webservice_failure and stops the whole process > sends email
            If graceful failed orders then pl_email_failed_orders > gets all record from cms_hso_ord_load_err with error_rpt_ind='F', adds all failed orders and sends email

New Flow : p_create_store_orders
    > for cursor in trans_hso_ord_hdr and cms_hso_ord_load_err it calls fl_gen_createorders_req_xml (no_data_found will return blank XML and other error will stop whole process)
        > then calls pl_invoke_service_createorders
            if exception then calls pl_email_webservice_failure and stops the whole process
            If graceful failed orders then pl_email_failed_orders

Order number immutable.
HOS order number and store order number.
Franchise order number.

Natural keys that seem immutable today have a habit of changing eventually. Vendors and other companies merge, employees change names and IDs, financial systems change (mucking up purchase orders and accounts), part numbers change, currencies change, social security numbers change (think identity theft), country names change, street names change. Not many things never change;
This often comes handy when new data source are introduced in a data warehouse environment
INSERT INTO manoutee (audit_number, app_dest, app_name, app_func) SELECT inb.audit_number, rte.app_dest, inb.app_name, inb.app_func FROM maninbee inb, apprteee rte
WHERE NOT EXISTS (SELECT * FROM manoutee out WHERE OUT.audit_number=inb.audit_number) AND rte.app_name=inb.app_name AND rte.app_func=inb.app_func ...

BEGIN dnltrfdtlex; END;

 L_post_sql_str
 SELECT DISTINCT download_process
 FROM   sdictlee
 WHERE  app_name = :NDS_app_name
 AND    download_process IS NOT NULL
 AND rte.app_func IN ('HDR')

-- Product WEB SKU Analysis
cms_hso_import_order.pl_update_sku_descr updates hso_web_sku.web_sku_descr sku if new description is coming, that trigger makes entry to io_msg_queue C_msg_sku_descr_upd (OMS_SKU)
cms_oms_export_order.p_sku_descr_upd picks entries from message queue and writes them to w_io_oms_sku for that feed id.

SELECT * FROM   r_io_process WHERE  proc_group_id = 'omsordio' AND  active_ind = 'Y' ORDER BY run_order;

-- Product data to OMS, new product interface
>> cms_oms_export_sku.sh

1. f_jobstep s_io.sh -mwe omsskuio
    select * from r_io_process where proc_group_id = 'omsskuio' order by run_order;
    select * from r_io_export  where proc_group_id = 'omsskuio' order by run_order;
2. oms_ii_ref_data.sh
    f_jobstep s_sql.sh -x usp_ps_job_import_odm_sku
        MERGE INTO stock FROM w_ii_odm_sku
        MERGE INTO skutaxbands FROM w_ii_odm_sku
    f_jobstep s_sql.sh -x usp_ps_job_importstockskualias
        MERGE INTO STOCKSKUALIAS FROM w_ii_odm_upc
------
CMS
select * from W_II_HSO_ORD_HDR
select * from W_II_HSO_ORD_CNTT
select * from W_II_HSO_ORD_ADDR
select * from W_II_HSO_ORD_ITEM
select * from W_II_HSO_ORD_PROMO
select * from W_II_HSO_ORD_TNDR
select * from W_II_HSO_ORD_CANCEL

OMS
select * from W_II_OMS_ORD_HDR
select * from W_II_OMS_ORD_CNTT
select * from W_II_OMS_ORD_ADDR
select * from W_II_OMS_ORD_ITEM
select * from W_II_OMS_ORD_PROMO
select * from W_II_OMS_ORD_TNDR
select * from W_II_OMS_ORD_CANCEL

select * from cms.r_cust_mst where cust_mst_id='5181225'

https://riverisland.atlassian.net/browse/RTCB-526

s_sql.sh -x inpt_pix_tran_proc "'${ORACLE_SID}'" >> s_ora_sql.sh ${*} >> -x option calls a procedure

Core systems JDA as a part of ODBMS package

CMSVPC_PKM_C_IN >>
    s_cycle.sh -s ${P_SECS} cms_pkm_in.sh >>
        f_jobstep s_ssh.sh -b -r wms wms_io_pkmo.sh >>
            f_jobstep s_sql.sh -x inpt_pix_tran_proc "'${ORACLE_SID}'" >>  RWM.inpt_pix_tran_proc
            f_jobstep s_sql.sh -x outpt_invoice_proc "'${ORACLE_SID}'" >>  RWM.Outpt_Invoice_Proc
        f_jobstep s_ii_process.sh dctransii

CMSVPC_PKM_C_TO_OMS >>
    s_cycle.sh -s ${P_SECS} cms_pkm_to_oms.sh >>
        f_jobstep s_ssh.sh  -b -r wms wms_io_hso_pick.sh >> RWM.p_io_hso_pick
            outpt_pkt_hdr, outpt_carton_dtl, outpt_pkt_dtl, store_distro
        f_jobstep s_ii_process.sh dchsoii
        f_jobstep s_io.sh -e omsstkio
        f_jobstep s_ssh.sh -b -r oms oms_ii_stk.sh

cms_oms_to_hso.sh
f_jobstep s_ii_process.sh omstransii
select * from r_ii_process where upper(proc_group_id)='OMSTRANSII'

CMS_OMS_IMPORT_ORDER.P_PROCESS_ORDER
CMS_OMS_IMPORT_ORDER.P_PROCESS_INV_ADJ
CMS_HSO_POS.P_PROCESS_RTN
CMS_HSO_POS.P_PROCESS_RTN_INV_ADJ
CMS_HSO_POS.P_PROCESS_RTN_TRF
CMS_HSO_POS.P_PREPAY_POS_MW_CNL_ORD

Job : cms_pkm_c_out.sh
This script cycles the cms_pkm_out.sh script

cms_pkm_out.sh
This script performs the outbound processing for the PMM/PKMS interface and comprises the following job steps :
f_jobstep s_io.sh -e dctransio
f_jobstep s_ssh.sh -b -r wms wms_ii_pkmi.sh
# Extract shipment data to produce DELD files
f_jobstep s_sql.sh ext_dc_trans_load.p_trf_trans
f_jobstep s_io.sh -ep frndeliv

SELECT *
FROM   r_io_export exp
WHERE  exp.proc_group_id = 'dctransio'
AND    exp.active_ind = 'Y'
ORDER BY exp.run_order

dc_trf_export.p_export
pkm_export.p_transfer
pkm_export.p_hso_pick
pkm_export.p_rtv
pkm_export.p_po
pkm_export.p_vendor
pkm_export.p_location
pkm_export.p_product
pkm_export.p_upc
p_proc_mnfst

dc_trf_export.p_export >>
if there is atleast one transfer record to be processed then
        cms_dataman.p_run( I_app_name => cms_const.C_appl_name_trf, -- INV
                           I_app_func => cms_const.C_appl_fn_trf,   -- HDR
                           I_app_dest => cms_const.C_appl_dest_sdi);-- SDI

SELECT * FROM APPMSTEE
SELECT MAX(audit_number) FROM invqueee
p_to_inbound > INSERT INTO maninbee, DELETE FROM invqueee

p_to_outbound > INSERT INTO manoutee … FROM maninbee inb, apprteee rte

Validations >
Duplicate file, duplicate order.

select * from r_purge where table_name='w_ii_hso_ord_tndr'

select * from w_ii_hso_ord_hdr

select * from w_ii_hso_ord_hdr_err

SELECT * FROM r_ii_process WHERE proc_group_id = upper('hsoordii') AND active_ind = 'T' ORDER BY run_order

select * from trans_file

Validations
-- Check for duplicate filename
-- Check Order hasn't already been loaded into middleware : trans_hso_ord_hdr
-- Check only one order hdr exists in working table
-- Check only one order hdr exists in working table
-- Check for duplicate item records w_ii_hso_ord_item
-- Check for multiple tender type records w_ii_hso_ord_tndr

cms_err_const
C_invld_prd_hier_dtl      CONSTANT s_datatype.err_msg     := 'Invalid level of product hierarchy';
C_invld_prtnr_dtl         CONSTANT s_datatype.err_msg     := 'Invalid partner details supplied';
C_no_product_dtl          CONSTANT s_datatype.err_msg     := 'No product id supplied';
C_no_curr_code_dtl        CONSTANT s_datatype.err_msg     := 'No currency code supplied'
C_invld_curr_code_dtl     CONSTANT s_datatype.err_msg     := 'Currency code supplied is invalid';
C_no_curr_rate_dtl        CONSTANT s_datatype.err_msg     := 'No currency rate available for currency';
C_no_price_dtl            CONSTANT s_datatype.err_msg     := 'No price supplied';
C_invld_price_dtl         CONSTANT s_datatype.err_msg     := 'Price supplied is invalid';

C_no_carr_misc_1_dtl CONSTANT s_datatype.err_msg          := 'Carrier miscellaneous field 1 must be present is delivery type is CollectPlus';
C_invld_deliv_store_dtl CONSTANT s_datatype.err_msg       := 'Delivery store must be valid if delivery is to a store';
C_no_deliv_store_dtl CONSTANT s_datatype.err_msg          := 'Delivery store must be present if delivery is to a store';
C_no_need_deliv_store_dtl CONSTANT s_datatype.err_msg     := 'Delivery store must not be present if delivery is not to a store';
C_no_cust_col_dtm_dtl CONSTANT s_datatype.err_msg         := 'Collection date and time must be present if delivery is to a store';
C_invld_dest_type_dtl CONSTANT s_datatype.err_msg         := 'Missing or invalid destination type';

Address record, header record, detail record exists.
Unknown SKU, unknown UPC, Tax code not found.

invalid date
invalid number
character length
mandatory fields

Risks >>

How can we ensure the same event is not processed twice.
How can we ensure that the order of the events are mantained as in the source system. E.g say customer placed an order, then cancelled. if the database picks the cancel transaction first and then try to process the order creation then we are in mess.

SELECT trf.trf_number,
       prd.prd_lvl_number,
       trf.prd_lvl_child,
       rcv.org_lvl_number                          AS shipped_to,
       ship.org_lvl_number                         AS shipped_from,
       sts.trf_status_id                           AS trf_status,
       sts.trf_sts_desc                            AS trf_status_descr,
       trf.trf_qty_alloc,
       trf.trf_in_carton + trf.trf_qty_ship        AS trf_qty_shipped,
       DECODE (     --
                    -- For the PICK EXCEPTION qty use the trf status to
                    -- determine which calculation should be used
                    --
                sts.trf_sts_desc,
                    --
                    -- COMPLETE: use the shipped qty vs allocated quantity:
                s_util.f_package_var ('dc_const.C_trf_complete'),
                    DECODE ( (NVL(trf.trf_in_carton,0)
                                  + NVL(trf.trf_qty_ship,0) - trf.trf_qty_alloc),
                             0, NULL,
                             (NVL(trf.trf_in_carton,0)
                                  + NVL(trf.trf_qty_ship,0) - trf.trf_qty_alloc)),
                    --
                    -- PICK_RELEASE: nothing would have been pick excepted:
                s_util.f_package_var ('dc_const.C_trf_pick_release'),
                NULL,
                    --
                    -- IN PROCESS / PICKED / other Status:
                    -- Need to compare outstanding and pick excepted quantities
                DECODE ( trf.trf_qty_pick,
                         trf.trf_qty_alloc, NULL,
                         0, -trf.trf_qty_alloc,
                         trf.trf_qty_pick - trf.trf_qty_alloc)
               )                                   AS trf_qty_pick,
       DECODE (trf.trf_source_id, 4,    'Arthur',
                                  6,    'Replen',
                                  NULL, 'Screen')  AS source
FROM   trfdtlee trf,
       prdmstee prd,
       trfstscd sts,
       orgmstee rcv,
       orgmstee ship
WHERE  prd.prd_lvl_child = trf.prd_lvl_child
AND    trf.trf_status    = sts.trf_status_id
AND    trf.trf_rec_loc   = rcv.org_lvl_child
AND    trf.trf_shp_loc   = ship.org_lvl_child

https://blogs.oracle.com/developers/getting-started-with-microservices-part-three

Design for Efficient Services Communication :

Design for Proper Asynchronous Messaging : one of the biggest advantages of using asynchronous messaging is that the service does not block while waiting for a response from another service. The flip side is that asynchronous messaging also introduces some challenges to be aware of.

Depending on your messaging solution, the order of messages may be random. Many times this is not a problem, but in case your service requires or expects a certain order to its messages, you need to apply some logic to your service to implement ordering. Another challenge may arise when needing to deal with repeated messages; a message could be sent more than once, for example as part of retry logic. In this case it is critical to make sure that your service is able to detect duplicate messages and handle them appropriately.

Another problem, which happens quite frequently, is how to handle messages that cannot be processed. For example, if a message is malformed or contains corrupt data it may cause a receiver to throw an exception. A good practice is to discard them by adding them to a specific queue as part of the exception handling, so receivers do not continue trying to process the “poisoned” message. The poisoned message can then be taken out of the specific queue for diagnostics purposes.

Design for Idempotency : Messages for example can be received and processed more than once based on failed receivers, retry policies, etc. Ideally the receiver should handle the message in an idempotent way, so that the repeated call produces the same result.

Let’s assume further the first operation fails due to some network issues and the receiver cannot pick up the message. As you have seen before it is good practice to implement retries. As a result, the sender submits the message again. Now you end up with two equal messages. If the receiver now picks up the messages and process them both, the account has been credited not $100 but $200. To avoid this, you need to ensure idempotency. A common way of ensuring that an operation is idempotent is by adding a unique identifier to the message and making sure that the service only processes the message if the identifiers do not match.

Below is an example of the same message, but with an identifier added.

This is also commonly referred to as de-duping. The same principle applies to data updates. Bottom line is that one should design operations to be idempotent, so that each step can be repeated without impacting the system.

As mentioned in the introduction, which patterns to use depends very much on your specific scenario. This blog post explored some of the basic design principles to keep in mind when you start to design and develop microservices-based applications. Please let us know if you find this information useful and if you would like more details on certain aspects.

In this session we’ll explore some common misconceptions about how to make an application scalable and correct. We’ll explore the true effects of different angles, beyond shallow theory, and see what it really does in terms of efficiency, scalability, correctness and maintainability.

Finally, one of the most important best practices is to use a correlation or activity ID. This ID is generated when a request is made to the application and is passed on to all downstream services. This allows you to trace a request from beginning to end, even though it spans multiple independent services.

There is always the classic question of what is too much logging and what is not enough. As with so many things, this depends on your scenario,

The goal of microservices is to sufficiently decompose the application in order to facilitate agile application development and deployment.

Another major drawback of microservices is the complexity that arises from the fact that a microservices application is a distributed system. Developers need to choose and implement an inter-process communication mechanism based on either messaging or RPC. Moreover, they must also write code to handle partial failure, since the destination of a request might be slow or unavailable.

These kinds of transactions are trivial to implement in a monolithic application because there is a single database. In a microservices-based application

https://github.com/River-Island/order-development/blob/master/order-event-sample.json

carrier_collect_dtm: Earliest carrier collection date and time
deliv_by_dtm    Date and time order to be delivered by

deliv_by_dtm, deliv_type, earliest_collect_dtm

latest despatch by date, latest delivery by date and Token ID

deliv_by_dtm - latest_deliv_dtm
carrier_collect_dtm - earliest_collect_dtm

deliv_type=srvc_grp [ 03- nominated day, 04 nominated eveening, 05 DPD precise hour slot]
select * from r_ref_dtl where ref_hdr_name = 'SRVC_GRP'

EARLIEST_COLLECT_DTM_TEXT
EARLIEST_COLLECT_DTM
LATEST_DELIV_DTM_TEXT
LATEST_DELIV_DTM

DELIV_BY_DTM
CREATED_DTM
CARRIER_COLLECT_DTM
PICK_BY_DTM
PACK_BY_DTM
SORT_BY_DTM

I think that is what is returned by Metapack finddelivery options.



Booking Codes : @10/*/*-*/2017-06-15/*-23:59

DPD :@01/*/*-*/2017-06-03/*-23:59
Hermes : @01/*/*-*/2017-06-03/*-23:59
Royal mail : @01/*/*-*/2017-06-03/*-23:59

@32/*/*-*/2017-06-05/*-23:59

@30/*/*-*/2017-06-06/*-23:59

HSO102 : Product Info to WEB
*/

First column of the file says whether its prd or prd_attr or sku or upc or delete type record.

        C_prd_rec         CONSTANT NUMBER(1) := 1;
        C_prd_attr_rec    CONSTANT NUMBER(1) := 2;
        C_sku_rec         CONSTANT NUMBER(1) := 3;
        C_upc_rec         CONSTANT NUMBER(1) := 4;
        C_del_rec         CONSTANT NUMBER(1) := 5;

INSERT INTO hso_web_sku

Messages logged in io_msg_queue and io_qork_queue

    C_prd_full              CONSTANT io_msg_queue.msg_type%TYPE := 'F';
    C_prd_delete            CONSTANT io_msg_queue.msg_type%TYPE := 'D';
    C_prd_interface_check   CONSTANT io_msg_queue.msg_type%TYPE := 'Z';
    C_price_add             CONSTANT io_msg_queue.msg_type%TYPE := 'A';
    C_price_delete          CONSTANT io_msg_queue.msg_type%TYPE := 'D';
    C_price_update          CONSTANT io_msg_queue.msg_type%TYPE := 'C';

------- WMS Analysis

SQL> desc W_IO_DC_HSO_PICK
Name                                      Null?    Type
----------------------------------------- -------- -------------
DISTRO_ID                                          VARCHAR2(12)
FROM_LOC                                           NUMBER(12)
TO_LOC                                             NUMBER(12)
SKU_ID                                             VARCHAR2(15)
SKU_QTY                                            NUMBER(10,3)
DELIV_TYPE                                         VARCHAR2(2)
ORD_ITEM_CNT                                       NUMBER(2)
CREATED_DTM                                        DATE
PROCESSED_DTM                                      DATE
DELIV_STORE_NUM                                    NUMBER(12)

Distro id : W<OrderID>
FROM_LOC : 9001
TO_LOC : 400
SKU_QTY : Count per SKU

OMS  Service GRP Queries

select * from orderheader where orderdate >= sysdate-2

select * from oms_carrier

select * from oms_carrier_service where carrier_service_id='GENSDND'

select * from oms_cage_type_service where carrier_service_id='GENSDND'

select * from oms_service_group

select * from oms_store_deliv_grp_map

select * from oms_store_deliv_grp

select * from orderheader where carrier_service_type like '%PL%' -- DPD

cp -r /apps/software/oracle/ords309/config/ords /home/dev/itsr/config

OMS Inbound Tables.

select * from W_II_OMS_ORD_HDR;
select * from W_II_OMS_ORD_ITEM;
select * from W_II_OMS_ORD_CNTT;
select * from W_II_OMS_ORD_ADDR;
select * from W_II_OMS_ORD_TNDR;
select * from W_II_OMS_ORD_PROMO;

select * from w_ii_web_ord_hdr;

select * from w_ii_web_ord_item;

select * from w_ii_web_ord_tndr;

OMS Payment Processing:

pblheader : for non-Adyen type providers and are not pre-paid. Order number, pbvalue=balance value? paidvalue=value paid?, mop= 131072method of payment, pbtype=0(auth charge) 1(refund),

majorstatus=C_paymnt_maj_stat_authorised, minorstatus=C_paymnt_min_stat_complete
pbldetail : pblid of header, itemnumber from orderitemheader, chunkvalue, gross value from orderitemheader and major status and minor status. and payment id sequence generated to be used in eft header

eftheader : payment id and pblid from pbldetail, record type auth, dummy start and end date. card holder name = title, firstname and last name from contact table.cardtype = payment_type, merchantid=001, installmentid=0, eftprovider =order_tndr.eftprovider, transactiondate=sysdate, processed_flag-Yes

pbltxn : txnid= seq val, txntype = C_eft_txntype_auth, paymentid, pblid, itemnumber, eftresult=oms_const.C_eft_result_success, tndr.auth_code,  tndr.payment_reference

--
-- PBLTXN Transaction Types
--
C_eft_txntype_auth         CONSTANT pbltxn.txntype%TYPE := 1;
C_eft_txntype_charge       CONSTANT pbltxn.txntype%TYPE := 2;
C_eft_txntype_refund       CONSTANT pbltxn.txntype%TYPE := 4;

order_tndr

carrierconsignmentheader
actionmessageheader

update orderheader with sum of netamount, taxvalue, grossvalue from orderitemheader.
update orderitemheader set consignmentnum from carrierconsignmentheader

dup checks in OMS are : orderalias.newmediaordernumber
valid order source
    SELECT 1
    FROM   s_char_codes cd
    WHERE  cd.code      = hdr.ord_source
    AND    cd.code_type = oms_ord_const.C_ord_source
valid store
pl_vld_sku
valid stockskualias

insert into orderalias
    orderheader
    orderheader_status >> service_group=deliv_type, earliest_collect_dtm, status_code=oms_const.C_os_on_order
    order_tndr
    orderitemheader

referenced data globaltaxbands.

oms_import_order.p_process_order:
        pl_load_customers    (I_feed_id => I_feed_id); >> lok for record in customeralias ca if not present ca.customeralias=hso_cust_id then insert into customer & customeralias else update customer if existing address <> new address (checks for all column)
        pl_load_contacts     (I_feed_id => I_feed_id); >> if record does not exist in customercontacts for customerurn insert with contactid=0 else (Note: previous step inserts record into alias table ans generate customerurn for new customers) insert new record with contactid = max(contactid) +1
        pl_load_addresses    (I_feed_id => I_feed_id); >>
        pl_load_orderalias   (I_feed_id => I_feed_id);
        pl_load_order_hdrs   (I_feed_id => I_feed_id);
        pl_load_order_tndrs  (I_feed_id => I_feed_id);
        pl_load_order_items  (I_feed_id => I_feed_id);
        pl_load_order_promo  (I_feed_id => I_feed_id);
        pl_load_payments     (I_feed_id => I_feed_id);
        pl_upd_orders        (I_feed_id => I_feed_id);
        pl_cancel_orders     (I_feed_id => I_feed_id);

select s_env.f_getenv( 'S_INFO_DEBUG', USER ) from dual;

begin
    s_env.p_addenv('S_INFO_DEBUG','TRUE');
end;
/

begin
    cms_phy_frm.p_force(1922,60);
end;
/

C_odbms_notify_contact_grp CONSTANT s_contact.user_group%TYPE := 'ODBMS_NOTIFICATION';
C_live_support_contact_grp CONSTANT s_contact.user_group%TYPE := 'LIVE_SUPPORT';

ORDS Errors needs to be trapped

16-Feb-2018 13:01:38.326 SEVERE [main] . The connection pool named: apex_pu is not correctly configured, due to the following error(s): IO Error: The Network Adapter could not establish the connection

--- WMS Analysis

Now wms_ii_store_distro.sh is de coupled from all CMS processes and being executed as stand alone job in WMS.

select * from Whse_Master;

select * from wcd_master;

select * from cd_master;

select * from msg_log;

FROM Inpt_Store_Distro a
    Where proc_stat_code = 0
AND NOT EXISTS (SELECT 1
                        FROM Whse_Master wm, wcd_master wcdm, cd_master cdm
                    WHERE wm.whse_master_id = wcdm.whse_master_id
                        AND wcdm.cd_master_id = cdm.cd_master_id
                        AND a.whse = wm.whse
                        AND a.co = cdm.co AND a.div = cdm.div)

ORDS Errors needs to be trapped

InternalServerException [statusCode=500, reasons=[]] : Not necessarily from OPD

ORA-00000 to ORA-00832
ORA-00910 to ORA-01497
ORA-40001 to ORA-40322

11G, 40K different exceptions in 12C its more than 60K.

false positives, false negatives

SELECT PARAMETER, VALUE FROM V$NLS_PARAMETERS WHERE PARAMETER IN ('NLS_CHARACTERSET', 'NLS_LANGUAGE', 'NLS_TERRITORY');

setenv NLS_LANG AMERICAN_AMERICA.WE8ISO8859P1

NLS_LANGUAGE	AMERICAN
NLS_TERRITORY	UNITED KINGDOM
NLS_CHARACTERSET	WE8ISO8859P15

SELECT
    s_code.f_trlt_to_num(
        I_code_type     => 'WEB_ORD_STG_RETENTION',
        I_code          => 'DEV',
        I_active_ind    => 'Y'
)
from dual;

INSERT INTO s_char_codes (
    code_type,
    code,
    char_short_translation,
    char_translation,
    date_translation,
    num_translation,
    sys_code_desc,
    active_ind
) VALUES (
    'WEB_ORD_STG_RETENTION',
    'DEV',
    'Value in hours',
    'Web order staging data retention period - in hours',
    NULL,
    3,
    NULL,
    'Y'
);

INSERT INTO s_code_types (
    code_type,
    code_type_name,
    code_type_desc,
    code_datatype,
    return_datatype,
    user_invld_actions
) VALUES (
    'WEB_ORD_STG_RETENTION',
    'Constants web order retention',
    'Constants to be used for web order processing',
    'C',
    'N',
    NULL
);

s_char_codes
WEB_ORD_STG_RETENTION,DEV,Value in hours,Web order staging data retention period - in hours,,3,,Y


Code Type

WEB_ORD_STG_RETENTION,Constants web order retention,Constants to be used for web order processing,C,N,

--

Need to do the changes in following :
For endpoint :
TOCOLLECT :
OMS_TRACKING_APP.P_RECEIVE_PARCEL : to insert record into w_io_web_ord_hdr when the parcel is received at store.
When it is updating the orderstatusmajor in orderheader to be oms_const.C_orditm_maj_stat_recv
COLLECTED
OMS_TRACKING_APP.P_RECEIVE_PARCEL : to insert record into w_io_web_ord_hdr when the parcel is received at store.
When it is updating the orderstatusmajor in orderheader to be oms_const.C_ord_maj_stat_collected

Changes in web_order_event package to send the events to MS

Changes to OMS_CONST package to add new status


Agreed Payload :
{
    "order": {
        "externalIds": [
            {
                "externalId": "250201056",
                "systemId": "TCPL"
            }
        ],
        "shipments": [
            {
                "shippingStatus": "TO_COLLECT"
            }
        ]
    }
}

{
    "order": {
        "externalIds": [
            {
                "externalId": "250201056",
                "systemId": "TCPL"
            }
        ],
        "shipments": [
            {
                "shippingStatus": "COLLECTED"
            }
        ]
    }
}


{
"id":"70E428A8-BFAE-BC40-E053-3872B81E5AE1"
,"order":{
"shipments":[
{
"consignmentCode":"DMC07VBNENEP"
,"carrierServiceType":"HERMESPOS"
,"shippingStatus":"SHIPPED"
,"shippingType":"IH"
}
]
,"productLineItems":[
{
"itemId":1
,"skuId":"5434810"
,"itemStatus":"DISPATCHED"
}
,{
"itemId":3
,"skuId":"5447335"
,"itemStatus":"DISPATCHED"
}
,{
"itemId":2
,"skuId":"5499291"
,"itemStatus":"DISPATCHED"
}
]
,"externalIds":[
{
"externalId":"47794800"
,"systemId":"TCPL"
}
]
,"featureFlag":{
"corePaymentProcessing":true
}
,"metadata":{
"coreEnvironment":"prd"
}
}
}

ORDERACTIVE@omsdev🍷 >desc w_io_web_ord_hdr
Name                 Null?    Type
-------------------- -------- --------------
EVENT_ID             NOT NULL NUMBER(27)
EVENT_UUID                    VARCHAR2(36)
EVENT_TYPE                    VARCHAR2(20)
ORDER_NUMBER                  VARCHAR2(25)
CONSIGNMENT_CODE              VARCHAR2(50)
SHIPPING_STATUS               VARCHAR2(20)
CARRIER_SERVICE_TYPE          VARCHAR2(40)
ORIGINAL_EVENT_ID             NUMBER
CREATED_DTM                   DATE
PROCESSED_DTM                 DATE
SUBMIT_COUNT                  NUMBER(3)
IO_ERROR_ID                   VARCHAR2(12)
IO_ERROR_DESCR                VARCHAR2(4000)
REQ_JSON                      CLOB
RESP_JSON                     CLOB

INSERT INTO w_io_web_ord_hdr(
    event_id ,
    event_uuid,
    event_type,
    order_number,
    consignment_code,
    shipping_status,
    carrier_Service_Type,
    created_dtm)
SELECT
    web_order_event_id_seq.NEXTVAL      AS event_id,
    oms_web_order_event.f_build_uuid()  AS event_uuid,
    oms_web_order_event.c_ord_despatch  AS event_type,
    oh.ordernumber                      AS order_number,
    csg.consignment_code                AS consignment_code,
    oms_web_order_event.c_ord_shipped   AS shipping_status,
    ocs.carrier_id                      AS carrier_Service_Type,
    SYSDATE                             AS created_dtm
FROM   orderitemheader oh
    JOIN oms_consignment csg
        ON oh.ordernumber = csg.ordernumber
    JOIN oms_package pkg
        ON (csg.consignment_id = pkg.consignment_id)
        AND pkg.package_id = I_package_id_tbl(FV_package_id_tbl_indx)
    JOIN oms_carrier_service ocs
        ON ocs.carrier_service_id = csg.carrier_service_id
WHERE  oh.itemstatusmajor = oms_const.C_orditm_maj_stat_despatch
AND    oh.despatchconfirmed IS NOT NULL
AND    oh.sku <> oms_const.C_shipping_sku_val) ord
WHERE    NOT EXISTS
            (SELECT ''
            FROM   w_io_web_ord_hdr hdr2
            WHERE  hdr2.order_number  = ord.order_number
            AND    hdr2.event_type = oms_web_order_event.c_ord_despatch);

    --
    -- UNIT:        pl_create_order_event
    -- DESCRIPTION: Create order events for order history
    -- USAGE:       pl_create_order_event(
    --                 I_event_type      => L_event_type,
    --                 I_order_number    => L_order_number,
    --                 I_shipping_status => L_shipping_status
    --              )
    --
    -- PARAMS:
    --             I_order_number      : Order number
    --             I_event_type        : Event type
    --             I_shipping_status   : Shipping_status
    -- RETURNS:     N/A
    --
    -- NOTES:  Throws exception fails
    --
    PROCEDURE pl_create_order_event(
        I_event_type          IN  w_io_web_ord_hdr.event_type%TYPE,
        I_order_number        IN  w_io_web_ord_hdr.order_number%TYPE,
        I_shipping_status     IN  w_io_web_ord_hdr.shipping_status%TYPE
    )
    IS
        L_scope    s_datatype.unit_name
                    := C_scope_prefix || 'pl_create_order_event';
    BEGIN
        logger.log (
            p_text   => s_const.C_begin,
            p_scope  => L_scope);

            INSERT INTO w_io_web_ord_hdr(
                event_id ,
                event_uuid,
                event_type,
                order_number,
                shipping_status,
                created_dtm)
            SELECT
                web_order_event_id_seq.NEXTVAL      AS event_id,
                oms_web_order_event.f_build_uuid()  AS event_uuid,
                I_event_type                        AS event_type,
                I_ordernumber                       AS order_number,
                I_shipping_status                   AS shipping_status,
                SYSDATE                             AS created_dtm
            FROM DUAL;

        logger.log (
            p_text   => s_const.C_end,
            p_scope  => L_scope);

    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error (
                p_text   => 'Error creating order event',
                p_scope  => L_scope,
                p_params => G_batch_stats);
		RAISE;
    END pl_create_order_event;

    FROM   oms_package
    WHERE  gs1_package_barcode =  I_barcode

    SELECT package_id,
            orig_package_id,
            package_status,
            consignment_id
    INTO   L_package_id,
            L_orig_package_id,
            L_package_status,
            L_consignment_id
    FROM   oms_package
    WHERE  gs1_package_barcode =  I_barcode

    IF L_loc_number < L_min_loc OR
        L_loc_number > L_max_loc OR
        UPPER(SUBSTR(I_location,1,2)) <>
            oms_tracking_app.C_location_barcode_prefix

SELECT
     oh.ordernumber
FROM   orderheader hdr
    join orderitemheader oh
        ON (hdr.ordernumber = oh.ordernumber)
    JOIN oms_consignment csg
        ON oh.ordernumber = csg.ordernumber
    JOIN oms_package pkg
        ON (csg.consignment_id = pkg.consignment_id)
    JOIN oms_carrier_service ocs
        ON ocs.carrier_service_id = csg.carrier_service_id

select * from oms_consignment where consignment_id=26638762;

select * from orderitemheader_status where ordernumber=250202582;

select * from orderitemheader where ordernumber=250202582;

select * from oms_consignment where ordernumber=2110000001;

select * from w_io_web_ord_hdr where order_number=2110000001;

select * from oms_package where /*gs1_package_barcode =  '350522970136799833';*/ consignment_id=26638762;

select * from oms_package_item where package_id=13679983;

select * from orderitemheader where ordernumber=2110000001; -- 61120532

update oms_package set package_status=190 where consignment_id=26638762;

select * from oms_package_document where package_id in (22250898,22250899,22250900);

select * from oms_system_params where param_name like '%LOC%';

update oms_package set package_status=190 where consignment_id=26638762;


SELECT package_id,
        orig_package_id,
        package_status,
        pkg.consignment_id,
        cons.ordernumber,
        cons.consignment_code
FROM   oms_package pkg
join oms_consignment cons
on(pkg.consignment_id = cons.consignment_id)
WHERE  gs1_package_barcode =  '350522970136799833';

SELECT oh.dest_type,
        oh.deliv_store_num,
        oh.ordernumber
/*INTO   L_dest_type,
        L_deliv_store_num,
        L_ordernumber*/
FROM   orderheader oh
        JOIN oms_consignment con
            ON (oh.ordernumber     = con.ordernumber)
        JOIN oms_package pkg
            ON (con.consignment_id = pkg.consignment_id)
WHERE  con.consignment_status <> 200 --oms_const.C_consignmnet_cancelled
AND    con.consignment_code <> 'NOT ALLOCATED' --oms_tracking_app.C_not_allocated
AND    pkg.package_id         =  13679983; --L_package_id;

Package has to be in <= 220 C_pkg_received


exec oms_web_order_event.p_publish;


set serveroutput on;
declare
    l_result SYS_REFCURSOR;
    L_success_ind         varchar2(100);
    L_error_code          varchar2(100);
    L_error_description   varchar2(100);
    l_barcode   oms_package.package_barcode%TYPE:='350522970136799833';
begin
    oms_tracking_app.p_receive_parcel(
            O_result     =>  l_result
            ,I_barcode    =>  l_barcode
            ,I_user_login =>  'SAROJ'
            ,I_device_id  =>  'ALL.RI'
            ,I_location   =>  'CO120' -- CO120
            ,I_language   =>  'ENG'
        );

    loop
        fetch l_result into L_success_ind, L_error_code, L_error_description;
        exit when l_result%notfound;
        dbms_output.put_line('success_ind: '||L_success_ind);
        dbms_output.put_line('L_error_code: '||L_error_code);
        dbms_output.put_line('L_error_description: '||L_error_description);
    end loop;
end;
/

declare
    l_result SYS_REFCURSOR;
    L_success_ind         varchar2(100);
    L_error_code          varchar2(100);
    L_error_description   varchar2(100);
    l_barcode             oms_package.package_barcode%TYPE:='350522970136799833';
    l_ordernumber         number := 2110000001;
begin
    oms_tracking_app.p_collect_parcel(
            O_result          =>  l_result
            ,I_barcode        =>  l_barcode
            ,I_ordernumber    =>  l_ordernumber
            ,I_user_login     =>  'SAR'
            ,I_device_id      =>  'ALL.RI'
            ,I_language       =>  'ENG'
        );

    loop
        fetch l_result into L_success_ind, L_error_code, L_error_description;
        exit when l_result%notfound;
        dbms_output.put_line('success_ind: '||L_success_ind);
        dbms_output.put_line('L_error_code: '||L_error_code);
        dbms_output.put_line('L_error_description: '||L_error_description);
    end loop;
end;
/

select * from w_io_web_ord_hdr where order_number= 2110000001;

SELECT
    hdr.ordernumber,
    hdr.dest_type,
    hdr.deliv_store_num,
    csg.consignment_id,
    pkg.package_id,
    pkg.gs1_package_barcode,
    hdr.orderstatusmajor,
    csg.consignment_status,
    pkg.package_status ,
    oih.itemstatusmajor,
    oihs.status_code    oihs_status_code
FROM   orderheader hdr
    join orderitemheader oih
        ON (hdr.ordernumber = oih.ordernumber)
    JOIN oms_consignment csg
        ON hdr.ordernumber = csg.ordernumber
    JOIN oms_package pkg
        ON (csg.consignment_id = pkg.consignment_id)
    JOIN orderitemheader_status oihs
        on (hdr.ordernumber = oihs.ordernumber)
where hdr.ordernumber= 2110000001
    and csg.consignment_status <> 199 -- 190=despatched, 199=marked for cancel, 220=received, 230=collected
    and oih.sku <>'SYSTEM_SHIPPING' ;

update orderheader set dest_type='01', deliv_store_num = 1 where ordernumber= 2110000001;

select * from w_io_web_ord_hdr where order_number= 2110000001;

SELECT count(1)
--INTO   L_unscanned_item_count
FROM   orderitemheader_status
WHERE  ordernumber = L_ordernumber
AND    status_code <> 200 --oms_const.C_ois_cancelled
AND    status_code < 220 --oms_const.C_ois_received;

INSERT INTO w_io_web_ord_hdr(
    event_id ,
    event_uuid,
    event_type,
    order_number,
    shipping_status,
    created_dtm)
SELECT
    web_order_event_id_seq.NEXTVAL      AS event_id,
    oms_web_order_event.f_build_uuid()  AS event_uuid,
    'tocollect'                         AS event_type,
    2100126010                          AS order_number,
    'TO_COLLECT'                        AS shipping_status,
    SYSDATE                             AS created_dtm
FROM DUAL;

INSERT INTO w_io_web_ord_hdr(
    event_id ,
    event_uuid,
    event_type,
    order_number,
    shipping_status,
    created_dtm)
SELECT
    web_order_event_id_seq.NEXTVAL      AS event_id,
    oms_web_order_event.f_build_uuid()  AS event_uuid,
    'tocollect'                         AS event_type,
    1234567890                          AS order_number,
    'TO_COLLECT'                        AS shipping_status,
    SYSDATE                             AS created_dtm
FROM DUAL
connect by rownum < 100;

DECLARE
  l_stmt CLOB;
BEGIN
  l_stmt := 'SELECT DISTINCT event_id, event_id FROM w_io_web_ord_hdr';
  DBMS_PARALLEL_EXECUTE.create_task (task_name => 'OPD_EVENT');
  DBMS_PARALLEL_EXECUTE.create_chunks_by_sql(task_name => 'OPD_EVENT',
                                             sql_stmt  => l_stmt,
                                             by_rowid  => FALSE);
END;
/

  DBMS_PARALLEL_EXECUTE.create_chunks_by_number_col(task_name    => 'OPD_EVENT',
                                                    table_owner  => user,
                                                    table_name   => 'SELECT DISTINCT event_id FROM w_io_web_ord_hdr',
                                                    table_column => 'event_id',
                                                    chunk_size   => 10000);

select * FROM user_parallel_execute_tasks;
SELECT * FROM user_parallel_execute_chunks where task_name='OPD_EVENT';
select * from s_webservice_config; -- parallel_level, chunk_size

----

drop table itsr.trans_hso_ord_hdr;

----- Retail-J cms_pos_trans.sh POS

select * from user_ords_modules where module_name='partnergateway.v1';
select * from user_ords_templates where module_id=19957;
select * from user_ords_handlers where template_id=20409;

DECLARE
    l_order_json         BLOB;
    l_response_code      NUMBER;
    l_response_message   s_datatype.long_string;
    l_content_sha1       s_datatype.unit_name;
BEGIN
    l_order_json := :body;
    l_content_sha1 := :content_SHA1;

    partnergateway_loader.p_accept_order_api(
        i_order_json       => l_order_json,
        i_content_sha1     => l_content_sha1,
        o_response_code    => l_response_code,
        o_response_message => l_response_message
    );
    :http_status        := l_response_code;
    :response_message   := l_response_message;
END;

select * from W_II_PGW_SALES_DTL;

select * from W_II_PGW_SALES_HDR;

cms_pos_trans.sh

f_jobstep s_sql.sh -x cms_pos_trans.p_data_load "${L_FEED_ID}"
# -- get data into w_ii_reporttransactions, w_ii_reportitems and w_ii_ord_cust_dtl
f_jobstep s_sql.sh -x cms_pos_trans.p_extr_ord_stk_to_unreserve "${L_FEED_ID}"
#--INSERT INTO w_io_iss_ord_void_trans
f_jobstep s_sql.sh -x cms_pos_trans.p_extract_trans "${L_FEED_ID}"
#
f_jobstep s_sql.sh -x cms_pos_trans.p_validate "${L_FEED_ID}"
#
f_jobstep s_sql.sh -x cms_pos_trans.p_populate_middleware "${L_FEED_ID}"
#
f_jobstep s_sql.sh -x cms_pos_trans.p_err

if [[ ${?} -ne 0 ]]
then
     f_fail "failure in cms_pos_trans.sh"
fi

f_jobstep cms_upload_pos.sh "WINDSS" "RETAILJ"

cms_pos_trans.p_data_load "${L_FEED_ID}"
    p_cms_pos_data_load@iss(I_feed_id => I_feed_id);
        UPDATE w_iss_trans SET io_feed_id = I_feed_id WHERE v_interface_ind = C_false AND trans_type = cms_trans_const.C_report_trans_type;

        INSERT INTO w_ii_reporttransactions -- GTT
        FROM   reporttransactions rt
        JOIN w_iss_trans   tr
        ON (tr.transaction_id = rt.report_transaction_id)
        WHERE  tr.io_feed_id = I_feed_id;

        INSERT INTO w_ii_reportitems -- GTT
        FROM   reportitems ri
        JOIN w_iss_trans tr
        ON (tr.transaction_id = ri.report_transaction_id)
        WHERE  tr.io_feed_id = I_feed_id;

        -- set sundry ID for product attributes
        UPDATE w_ii_reportitems ri
        SET    ri.sundry_id =
                (SELECT SUBSTR(attr.attribute_value,1,2)
                FROM   products prd
                        JOIN productattributes attr
                            ON (attr.product_id = prd.id)
                WHERE  prd.type IN (cms_trans_const.C_prd_type_pos,
                                    cms_trans_const.C_prd_type_sku)
                AND    prd.mmgroup_id = C_iss_xpt_hier_top
                AND    ri.product_id  = prd.id
                AND    attr.attribute_id = C_iss_non_merch_attr)
        WHERE  ri.transaction_type = C_rpt_hdr_pos_type
        AND    ri.item_type       IN (C_rpt_dtl_prd_sale,
                                    C_rpt_dtl_prd_rtn);

SELECT prd.id, prd.type,prd.mmgroup_id, SUBSTR(attr.attribute_value,1,2), attr.*
FROM   products prd
JOIN productattributes attr
    ON (attr.product_id = prd.id)
WHERE  prd.type IN (/*cms_trans_const.C_prd_type_pos*/1,
                    /*cms_trans_const.C_prd_type_sku*/9)
AND    prd.mmgroup_id = 'ROOT' --C_iss_xpt_hier_top
--AND    ri.product_id  = prd.id
AND    attr.attribute_id = 'NonMerchandised'; --C_iss_non_merch_attr

        -- Load Order Customer details
        INSERT INTO w_ii_ord_cust_dtl
            (report_transaction_id,
            created_dtm,
            compressedxml)
        SELECT trans.report_transaction_id,
            SYSDATE,
            bas.compressedxml
        FROM reporttransactions trans
            JOIN baskets bas
                ON (bas.id = trans.basket_id)
        WHERE trans.report_transaction_id IN
                    (SELECT DISTINCT ite.report_transaction_id
                    FROM   reportitems ite
                            JOIN w_iss_trans tr
                                ON (tr.transaction_id = ite.report_transaction_id)
                    WHERE ite.reason_id = 'WEB'
                    AND   tr.io_feed_id = I_feed_id);

    -- add data into CMS w_ii_reporttransactions
    INSERT /*+ APPEND */ INTO w_ii_reporttransactions@pmm
    -- add data into CMS w_ii_reportitems
    INSERT /*+ APPEND */ INTO w_ii_reportitems@pmm
    INSERT /*+ APPEND */ INTO w_ii_ord_cust_dtl@pmm
        (report_transaction_id,
         created_dtm,
         compressedxml)
    SELECT report_transaction_id,
           created_dtm,
           compressedxml
    FROM w_ii_ord_cust_dtl;

cms_pos_trans.p_extr_ord_stk_to_unreserve "${L_FEED_ID}"
    INSERT INTO w_io_iss_ord_void_trans 
cms_pos_trans.p_extract_trans "${L_FEED_ID}"
    UPDATE w_ii_reporttransactions trans SET trans.user_id=(SELECT DISTINCT(item.user_id) FROM w_ii_reportitems ..) WHERE  trans.user_id = C_not_found .. 
    UPDATE w_ii_reportitems ri SET ri.sundry_id .. 
    pl_extract_cash_manage_trans : 
        INSERT INTO w_ii_iss_cash_manage_hdr FROM w_ii_reporttransactions( not training_mode,   cash_session_date is not null and w_ii_reportitems.item_type is not void )
        INSERT INTO w_ii_iss_cash_manage_dtl 
    pl_validate_cash_manage
        select * from s_val_table_data where validate_name='ISS_REPORT_TRANS_KEY' and table_name='W_II_ISS_CASH_MANAGE_HDR';
        -- Mandatory Check
        SELECT *
        FROM  s_val_table_data
        WHERE table_name = 'W_II_ISS_CASH_MANAGE_HDR'
        AND   validate_name = 'ISS_REPORT_TRANS_KEY'
        AND   conv_column_active = 'Y'
        AND   conv_column_mandatory='Y';

        SELECT *
        FROM s_val_table_data
        WHERE table_name = 'W_II_ISS_SESSION'
        AND   validate_name = 'ISS_REPORT_TRANS_KEY'
        AND   conv_column_name IS NOT NULL
        AND   conv_column_active = 'Y';

        
        p_check_mandatory >> 
        For tables 
            W_II_ISS_CASH_MANAGE_HDR
            W_II_ISS_CASH_MANAGE_DTL
            validate data, convert, mandatory checks, 
            p_validate_org : store is valid or not 
            Codes are valid : pos_tender_type_id, pos_tender_sub_type_id, pos_tender_card_type
            Transaction date is less than odbms date 

    pl_cash_session
        INSERT INTO w_ii_iss_session
        Run validations on w_ii_iss_session
        INSERT INTO r_iss_session
        UPDATE r_iss_session rs
        SET    rs.close_cash_session_dtm = SYSDATE
        ... 
        pl_close_cash_session_err
            UPDATE r_iss_session
            SET    error_rpt_ind = s_const.C_true
            WHERE close_cash_session_dtm IS NULL 
            and more then on entries in same table for same store and till 
            and cash_session_dtm is less then max(cash_session_dtm) for same store and till 

    pl_extract_pos_trans
        INSERT INTO w_ii_iss_sale_hdr
        FROM   w_ii_reporttransactions rt
        WHERE  rt.transaction_type  = cms_pos_trans.C_rpt_hdr_pos_type
        AND    rt.training_mode     = cms_pos_trans.C_pos_false
        AND not exists in of cms_pos_trans.C_rpt_dtl_void_trans or cms_pos_trans.C_rpt_dtl_no_sale_trans in w_ii_reportitems
        for same report_transaction_id

        UPDATE w_ii_iss_sale_hdr sal_hdr
        SET    cust_id =

        INSERT INTO w_ii_iss_sale_dtl
        FROM   w_ii_iss_sale_hdr hdr
               JOIN w_ii_reportitems ri

        UPDATE w_ii_iss_sale_dtl dtl
        SET (promo_prc_event_type_text,
             promo_prc_event_code_text) =

        INSERT INTO w_ii_iss_sale_ord_cust_dtl
        FROM w_ii_ord_cust_dtl dtl
             JOIN w_ii_iss_sale_hdr hdr

        INSERT INTO w_ii_iss_sale_sundry

        UPDATE w_ii_iss_sale_sundry sal_sun
           SET vat_val = sale_val * .. 

        -- gift voucher sales data
        INSERT INTO w_ii_iss_sale_gv_dtl

        INSERT INTO w_ii_iss_sale_tndr

        INSERT INTO w_ii_iss_sundry_hdr

        INSERT INTO w_ii_iss_sundry_dtl

        INSERT INTO w_ii_iss_sundry_tndr

        INSERT INTO w_ii_iss_sale_disc

        -- Gift cards issued as change
cms_pos_trans.p_validate "${L_FEED_ID}"
    select distinct from_ref_hdr_name from r_ref_trlt 
    where from_ref_system_name='ISS_SALES';

    select * from r_ref_trlt 
    where from_ref_system_name = 'WINDSS_SALES';

    UPDATE trans_sale_dtl tsd
    SET    tsd.order_item_status =

cms_pos_trans.p_populate_middleware
    pl_populate_pos_mw
        INSERT INTO trans_file
        INSERT INTO trans_file_till
        INSERT INTO trans_sale_hdr

        UPDATE trans_sale_hdr hdr
        SET    (ord_id,
                ord_source)

        INSERT INTO trans_sale_dtl

        profit protection return stop??

        UPDATE trans_sale_hdr tsh

        INSERT INTO trans_sale_gv_dtl

        INSERT INTO trans_sale_disc

        INSERT INTO trans_sale_sundry

        INSERT INTO trans_sale_tndr

        INSERT INTO trans_sundry_hdr

        INSERT INTO trans_sundry_dtl
        
        INSERT INTO trans_sundry_tndr

        INSERT INTO trans_hso_ord_hdr

        INSERT INTO trans_hso_ord_file

        INSERT INTO trans_hso_ord_addr

        INSERT INTO trans_hso_ord_cntt

        INSERT INTO trans_hso_ord_item

        INSERT INTO trans_hso_ord_tndr

        INSERT INTO trans_hso_ord_promo

    UPDATE w_ii_reporttransactions
    SET    processed_dtm = sysdate
    WHERE  ii_master_feed_id = I_feed_id;

    UPDATE w_ii_reportitems itm
    SET    processed_dtm = sysdate
    WHERE .. 

-- 230 columns : Layer One
select * from user_col_comments 
where table_name in ('W_II_REPORTTRANSACTIONS','W_II_REPORTITEMS','W_II_ORD_CUST_DTL')
and comments is not null;
-- Layer Two
select * from user_col_comments 
where table_name in ('W_II_ISS_CASH_MANAGE_HDR','W_II_ISS_CASH_MANAGE_DTL','W_II_ORD_CUST_DTL')
and comments is not null;
Customer data we are getting in compressed XML format? that will change

-- non-merchandise sale items which are coming through as income
-- or expenses
--non-merchandise return data
--non-merchandise SKU sales
--non-merchandise SKU return
--Update Sundry Postage and packing VAT values

w_ii_iss_sale_hdr
w_ii_iss_sale_dtl
w_ii_iss_sale_sundry
w_ii_iss_sale_tndr
w_ii_iss_sale_disc
w_ii_iss_sale_ord_cust_dtl

select * from r_ref_trlt 
where from_ref_system_name='ISS_SALES' and from_ref_hdr_name='EXPENSE_TYPE'; and from_ref_code= and to_ref_system_name= and to_ref_hdr_name;

select distinct from_ref_hdr_name from r_ref_trlt 
where from_ref_system_name='ISS_SALES';

select * from r_ref_trlt 
where from_ref_system_name = 'WINDSS_SALES';

DETAIL_CODE
DISCOUNT_REASON
EXPENSE_TYPE
RETURN_REASON
SUNDRY_REASON
TNDR_CODE

w_ii_iss_sale_hdr
w_ii_iss_sale_dtl
w_ii_iss_sale_sundry
w_ii_iss_sale_tndr
w_ii_iss_sale_disc
w_ii_iss_sale_ord_cust_dtl

W_II_ISS_BANKING_DTL
W_II_ISS_BANKING_HDR
W_II_ISS_CASH_MANAGE_DTL
W_II_ISS_CASH_MANAGE_HDR
W_II_ISS_CLOB_PROMO -- DWH
W_II_ISS_EMPLOYEE   -- DWH
W_II_ISS_EMPLOYEEGRADE -- DWH
W_II_ISS_PROMOTION -- DWH
W_II_ISS_SALE_DISC
W_II_ISS_SALE_DTL
W_II_ISS_SALE_GV_DTL
W_II_ISS_SALE_HDR
W_II_ISS_SALE_ORD_CUST_DTL
W_II_ISS_SALE_SUNDRY
W_II_ISS_SALE_TNDR
W_II_ISS_SESSION
W_II_ISS_STKADJ_DTL
W_II_ISS_STKADJ_HDR
W_II_ISS_STOCK_RCN
W_II_ISS_SUNDRY_DTL
W_II_ISS_SUNDRY_HDR
W_II_ISS_SUNDRY_TNDR
W_II_ISS_TILL_TOTALS
W_II_ISS_TRF_DTL
W_II_ISS_TRF_HDR
W_II_ISS_TRF_RCV_DTL
W_II_ISS_TRF_RCV_HDR
--------------
W_IO_ISS_EXPORT
W_IO_ISS_ORD_VOID_TRANS
W_IO_ISS_PRICE
W_IO_ISS_STK_ADJ

W_II_STORE_SALE_HDR 

-----
-----
Whether can we re-use PGW components?
Whether can we use our own ordermanagement module?
Whether to use new set of working tables or not?

ordermanagement/v1/orders

ordermanagement/v2/weborders 
ordermanagement/v2/storeorders
ordermanagement/v2/storesales : I think yes because we are treating everything inside our order canonical model. 

We want to go live in dark. No one using this only data will flow to staging tables.  

W_II_WEB_ORD_HDR 

W_II_STORE_ORD_HDR  : w_ii_iss_sale_hdr
W_II_STORE_ORD_BANKING_HDR  : w_ii_iss_banking_hdr
W_II_STORE_ORD_CUST_DTL : W_II_ISS_SALE_ORD_CUST_DTL 
W_II_STORE_ORD_SUNDRY_HDR : W_II_ISS_SUNDRY_HDR 

There will still be some ISS tables, like stk adjustment : cms_iss_ssm

p_cms_iss_promo ???

P_CMS_ISS_EMP_EMPGRADES

Questions??
How the the stores get product and product attribute from ODBMS? 
Do we send any feed to somewhere e.g datawarehouse?
Void tender type and void tender value ?
Some of the working table validations are not applicable in new world? Date conversion 
SKU and Store, tax code validations without these validations can we send it to TCPL??
profit protection return stop??

Purge policy on the existing tables. 

validate data, convert, mandatory checks, 
p_validate_org : store is valid or not 
Codes are valid : pos_tender_type_id, pos_tender_sub_type_id, pos_tender_card_type
Transaction date is less than odbms date 

cms_store_sales 

pks

w_ii_trans_sales_hdr.tbl,1.0
w_ii_trans_sales_dtl.tbl,1.0
w_ii_trans_sales_tndr.tbl,1.0
cms_trans_sale.pks,1.0
cms_trans_sale.pkb,1.0
trans_sk_request_id_seq.seq,1.0

I think it will be more explanatory if we use store prefix

cms_store_sales

cms_store_sales : 
cms_store_trans_sales : Package moving to 

w_ii_store_sale_hdr : 
