--
-- NAME:  cms_rfid_alert_report.sql
-- TYPE:  SQL Query
-- TITLE: SQL Query to produce report on ticket request generated
--        after 1st July 2016 and corresponding RFID status of 
--        associated products. 
--
--$Revision:   1.2  $
-------------------------------------------------------------------------------
-- Version | Date    | Author        | Reason
-- 1.0     |15/08/16 | S. Raut       | Initial Version
-- 1.1     |19/08/16 | S. Raut       | Enahancment (adding five new columns)
--                                     QA Changes and Bug Fix
-- 1.2     |12/10/16 | S. Raut       | Added extra colummns 
--                                   | (look and hand_over_date(s))
-------------------------------------------------------------------------------
WITH
r_type_tckt AS
(
    SELECT
        CONNECT_BY_ROOT tckt_req_hdr_num 
        AS tckt_req_hdr_num,
        reference_key,
        req_type_ind,
        CONNECT_BY_ROOT req_type_ind     r_req_type_ind,
        CONNECT_BY_ROOT create_dt        create_dt,
        CONNECT_BY_ROOT req_extract_dt   req_extract_dt,
        CONNECT_BY_ROOT tag_supp_code    tag_supp_code
    FROM tckt_req_hdr
    WHERE CONNECT_BY_ISLEAF=1
        AND CONNECT_BY_ROOT cancel_tckt_req_ind='F'
    START WITH req_type_ind='R' 
        AND create_dt >= TO_DATE('01/07/2016','dd/mm/yyyy')
    CONNECT BY PRIOR reference_key= TO_CHAR(ad_hoc_request_num)
),
all_tckt_type AS
(
    SELECT
        tckt_req_hdr_num,
        reference_key,
        req_type_ind,
        create_dt,
        req_extract_dt,
        req_type_ind r_req_type_ind,
        tag_supp_code
    FROM tckt_req_hdr
    WHERE  create_dt >= TO_DATE('01/07/2016','dd/mm/yyyy')
        AND req_type_ind IN ('P','O','C')
        AND cancel_tckt_req_ind='F'
    UNION ALL
    SELECT
        tckt_req_hdr_num,
        reference_key,
        req_type_ind,
        create_dt,
        req_extract_dt,
        r_req_type_ind,
        tag_supp_code
    FROM r_type_tckt
),
all_product AS
(
    SELECT 
        vpd.prd_lvl_child, 
        tckt_req_hdr_num,
        att.reference_key,
        NULL pmg_sell_qty,
        NULL pmg_exp_rct_date,
        NULL pmg_entry_date,
        NULL pmg_last_chg_dt,
        vpd.vpc_tech_key,
        NULL min_hand_over_date,
        NULL max_hand_over_date
    FROM all_tckt_type att
    JOIN  vpcprdee vpd
        ON(RPAD(att.reference_key,15) = vpd.vpc_case_pack_id
        AND att.req_type_ind = 'C' )
    UNION
    SELECT 
        pod.prd_lvl_child, 
        att.tckt_req_hdr_num,
        att.reference_key,
        SUM(pod.pmg_sell_qty) pmg_sell_qty,
        MAX(pod.pmg_exp_rct_date) pmg_exp_rct_date,
        MAX(hdr.pmg_entry_date) pmg_entry_date,
        MAX(hdr.pmg_last_chg_dt) pmg_last_chg_dt,
        MAX(hdr.vpc_tech_key) vpc_tech_key,
        MIN(pod.pmg_ship_date)  min_hand_over_date,
        MAX(pod.pmg_ship_date)  max_hand_over_date
    FROM all_tckt_type att
    JOIN pmgdtlee pod
        ON(att.reference_key=pod.pmg_po_number)
    JOIN pmghdree hdr
        ON(pod.pmg_po_number = hdr.pmg_po_number)
    WHERE att.req_type_ind IN ('P','O')
        AND pod.pmg_status <> 7 
    GROUP BY pod.prd_lvl_child, 
        att.tckt_req_hdr_num,
        att.reference_key 
),
all_product_with_hier AS
(
        SELECT 
            connect_by_root prd_lvl_child plc,
            connect_by_root prd_name_full prd_name_full,
            connect_by_root prd_lvl_number prd_lvl_number,
            prd_lvl_number prd_lvl_parent_numb,
            prd_lvl_child  prd_lvl_parent,
            prd_lvl_id,
            prd_name_full parent_name_full
        FROM prdmstee 
        WHERE prd_lvl_id IN (2,4,6)
        START WITH prd_lvl_child IN(
            SELECT 
                prd_lvl_child 
            FROM all_product
            )
        CONNECT BY PRIOR prd_lvl_parent=prd_lvl_child
),
all_product_with_hier_denorm AS
(
    SELECT
        plc prd_lvl_child,
        prd_lvl_number,
        prd_name_full,
        range_id,
        range_num,
        range_name,
        dept_id,
        dept_num,
        dept_name,
        division_id,
        division_num,
        division_name,
        (SELECT MAX(pmg_exp_rct_date) 
         FROM pmgdtlee 
         WHERE prd_lvl_child=plc 
            AND pmg_status <> 7) max_pmg_exp_rct_date,
        cms_attr.f_attr_code_desc('Compass Fixed Att.'
                                    ,'Season' 
                                    ,'PRD'
                                    ,plc) season,
        cms_attr.f_attr_code_desc('Compass Var. Att.'
                                    ,'End Use/Brands/Looks' 
                                    ,'PRD'
                                    ,plc) look
    FROM all_product_with_hier
    pivot(
            MIN(prd_lvl_parent_numb) num,
            MIN(prd_lvl_parent) id,
            MIN(parent_name_full) name
            FOR prd_lvl_id IN (2 AS range,
                               4 AS dept,
                               6 AS Division)
        )   
),
all_tckt_dtl_qty AS
(
    SELECT 
        att.tckt_req_hdr_num,
        att.reference_key,
        prd.prd_lvl_parent,
        trd.tag_type,
        SUM(tckt_qty) tckt_dtl_qty
    FROM all_tckt_type att
        LEFT JOIN tckt_req_dtl trd 
            ON (att.tckt_req_hdr_num = trd.tckt_req_hdr_num)
        LEFT JOIN prdmstee prd
            ON (RPAD(trd.sku_prd_lvl_number,15) = prd.prd_lvl_number)
    WHERE trd.addn_tag_type_ind='F'
    GROUP BY prd.prd_lvl_parent,
        att.tckt_req_hdr_num,
        att.reference_key,
        trd.tag_type
),
all_prd_attr AS
(
    SELECT 
        prd_attr.prd_lvl_child,
        attr_desc.atr_code_desc,
        attr_desc.atr_code
    FROM   
       basatyee attr_typ 
       JOIN basahree attr_subtyp 
        ON (attr_typ.atr_typ_tech_key = attr_subtyp.atr_typ_tech_key )
       JOIN basatpee prd_attr
        ON( prd_attr.atr_typ_tech_key = attr_typ.atr_typ_tech_key
            AND prd_attr.atr_hdr_tech_key = attr_subtyp.atr_hdr_tech_key)
       JOIN basacdee attr_desc
        ON( attr_desc.atr_cod_tech_key = prd_attr.atr_cod_tech_key
            AND attr_desc.atr_hdr_tech_key = prd_attr.atr_hdr_tech_key)
    WHERE  attr_typ.atr_type_desc = 'Ticketing' 
    AND    attr_typ.app_func = 'PRD'
    AND    attr_subtyp.atr_header_desc = 'Ticket Type'
    AND    attr_subtyp.app_func ='PRD'
    AND    prd_attr.prd_lvl_child  IN 
           (SELECT prd_lvl_child 
           FROM all_product)
)
SELECT
    att.create_dt                   AS tckt_create_dt
    ,att.reference_key              AS po_vpc_no 
    ,apd.prd_lvl_number             AS prd_lvl_number
    ,att.req_extract_dt             AS req_extract_dt
    ,ap.pmg_exp_rct_date            AS expected_receipt_date
    ,ap.pmg_entry_date              AS po_create_dt
    ,ap.pmg_last_chg_dt             AS po_amend_dt
    ,ap.min_hand_over_date          AS min_hand_over_date
    ,ap.max_hand_over_date          AS max_hand_over_date
    ,CASE 
        WHEN att.req_type_ind='P' 
            AND NVL(atdq.tckt_dtl_qty,0) =0
                THEN ap.pmg_sell_qty 
         ELSE atdq.tckt_dtl_qty
     END                             AS quantity
    ,apa.atr_code_desc               AS prd_lvl_ticket_type
    ,apd.season                      AS season
    ,apd.dept_name                   AS department
    ,apd.dept_num                    AS dept_number
    ,apd.range_name                  AS range
    ,apd.range_num                   AS range_number
    ,apd.division_name               AS division
    ,apd.division_num                AS division_number
    ,atdq.tag_type                   AS tag_type_sent
    ,cms_attr.f_prd_hier_attr_code(
            'Ticketing',
            'Ticket Type',
            ap.prd_lvl_child)        AS tag_type_current
    ,apd.prd_name_full               AS prd_description
    ,apd.look                        AS look
    ,CASE 
        WHEN SUBSTR(apd.season,-2) >= 17
            AND  COALESCE (rngmp.atr_cod_tech_key,
                            deptmp.atr_cod_tech_key) IS NOT NULL
                THEN 'Qualified'
        WHEN substr(apd.season,-2) < 17
            AND  COALESCE (rngmp.atr_cod_tech_key,
                            deptmp.atr_cod_tech_key) IS NOT NULL
            AND apd.max_pmg_exp_rct_date >= TO_DATE('01/12/2016','dd/mm/yyyy')
                THEN 'Qualified'
        ELSE 'Dis-qualified'
     END                             AS rfidable
     ,CASE att.r_req_type_ind
        WHEN 'P' then 'Production'
        WHEN 'O' then 'Adhoc PO'
        WHEN 'C' then 'Adhoc Case-pack'
        WHEN 'R' then 'Adhoc ref-req'
    END                            AS ticket_request_type,
    trs.tag_supp_name              AS tag_supp_name,
    vdr.vendor_name                AS supplier,
    cms_prd_dtl.f_cntry_of_origin(
                  ap.prd_lvl_child,
                  ap.vpc_tech_key) AS country_of_mnfct
FROM all_tckt_type att
    JOIN all_product ap
        ON(att.tckt_req_hdr_num = ap.tckt_req_hdr_num)
    JOIN all_product_with_hier_denorm apd
        ON(ap.prd_lvl_child = apd.prd_lvl_child)
    JOIN vpcmstee vdr
        ON(ap.vpc_tech_key     = vdr.vpc_tech_key)
    LEFT JOIN all_tckt_dtl_qty atdq
        ON(att.tckt_req_hdr_num = atdq.tckt_req_hdr_num
            AND ap.prd_lvl_child = atdq.prd_lvl_parent)
    LEFT JOIN all_prd_attr apa
        ON (ap.prd_lvl_child = apa.prd_lvl_child)
    LEFT JOIN rfid_map rngmp
         ON (rngmp.prd_lvl_child = apd.range_id)
    LEFT JOIN rfid_map deptmp
         ON (deptmp.prd_lvl_child = apd.dept_id)
    LEFT JOIN tckt_req_supplier trs
        ON (NVL(att.tag_supp_code,
                cms_attr.f_add_value('TS',
                'PMGHDREE',
                DECODE(req_type_ind,'C',NULL,att.reference_key))
                ) = trs.tag_supp_code)
WHERE NOT(att.r_req_type_ind <> 'P' 
    AND atdq.tckt_dtl_qty IS  NULL);
