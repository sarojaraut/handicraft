BEGIN
    ORDS.DEFINE_MODULE(
       p_module_name    => 'PRDTicketReport',
       p_base_path      => 'PRDTicketReport/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'TCKT Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'PRDTicketReport',
        p_pattern        => 'PRDTicketReport.csv/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'PRDTicketReport',
        p_pattern        => 'PRDTicketReport.csv/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_csv_query,
        p_source         => 
q'[
WITH
r_type_tckt AS
(
    SELECT /*+ DRIVING_SITE(tckt_req_hdr) */
        CONNECT_BY_ROOT tckt_req_hdr_num
        AS tckt_req_hdr_num,
        reference_key,
        req_type_ind,
        CONNECT_BY_ROOT req_type_ind     r_req_type_ind,
        CONNECT_BY_ROOT create_dt        create_dt,
        CONNECT_BY_ROOT req_extract_dt   req_extract_dt,
        CONNECT_BY_ROOT tag_supp_code    tag_supp_code
    FROM tckt_req_hdr@batprd_cmsprd
    WHERE CONNECT_BY_ISLEAF=1
        AND CONNECT_BY_ROOT cancel_tckt_req_ind='F'
    START WITH req_type_ind='R'
        AND create_dt >= TO_DATE('01/07/2016','dd/mm/yyyy')
    CONNECT BY PRIOR reference_key= TO_CHAR(ad_hoc_request_num)
),
all_tckt_type AS
(
    SELECT /*+ DRIVING_SITE(tckt_req_hdr) */
        tckt_req_hdr_num,
        reference_key,
        req_type_ind,
        create_dt,
        req_extract_dt,
        req_type_ind r_req_type_ind,
        tag_supp_code
    FROM tckt_req_hdr@batprd_cmsprd
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
    SELECT /*+ DRIVING_SITE(vpd) */
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
    JOIN  vpcprdee@batprd_cmsprd vpd
        ON(RPAD(att.reference_key,15) = vpd.vpc_case_pack_id
        AND att.req_type_ind = 'C' )
    UNION
    SELECT /*+ DRIVING_SITE(pod) */
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
    JOIN pmgdtlee@batprd_cmsprd pod
        ON(att.reference_key=to_char(pod.pmg_po_number))
    JOIN pmghdree@batprd_cmsprd hdr
        ON(pod.pmg_po_number = hdr.pmg_po_number)
    WHERE att.req_type_ind IN ('P','O')
        AND pod.pmg_status <> 7
    GROUP BY pod.prd_lvl_child,
        att.tckt_req_hdr_num,
        att.reference_key
),
all_product_with_hier AS
(
SELECT  /*+ DRIVING_SITE(plv) */
    plv.prd_lvl_child   plc,
    plv.prd_name_full   prd_name_full,
    plv.prd_lvl_number  prd_lvl_number,
    prd.prd_lvl_number  prd_lvl_parent_numb,
    plv.prd_lvl_parent  prd_lvl_parent,
    plv.prd_parent_id+1 prd_lvl_id,
    prd.prd_name_full   parent_name_full
FROM all_product ap
JOIN prdplvee@batprd_cmsprd plv
ON  ( ap.prd_lvl_child = plv.prd_lvl_child)
JOIN prdmstee@batprd_cmsprd prd
ON (prd.prd_lvl_child=plv.prd_lvl_parent
    AND plv.prd_parent_id in (1,3,5)
    )
),
all_product_with_hier_denorm AS
(
    SELECT /*+ DRIVING_SITE(pmgdtlee) */
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
         FROM pmgdtlee@batprd_cmsprd
         WHERE prd_lvl_child=plc
            AND pmg_status <> 7) max_pmg_exp_rct_date,
        cms_attr.f_attr_code_desc@batprd_cmsprd('Compass Fixed Att.'
                                    ,'Season'
                                    ,'PRD'
                                    ,plc) season,
        cms_attr.f_attr_code_desc@batprd_cmsprd('Compass Var. Att.'
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
    SELECT /*+ DRIVING_SITE(trd) */
        att.tckt_req_hdr_num,
        att.reference_key,
        prd.prd_lvl_parent,
        trd.tag_type,
        SUM(tckt_qty) tckt_dtl_qty
    FROM all_tckt_type att
        LEFT JOIN tckt_req_dtl@batprd_cmsprd trd
            ON (att.tckt_req_hdr_num = trd.tckt_req_hdr_num)
        LEFT JOIN prdmstee@batprd_cmsprd prd
            ON (RPAD(trd.sku_prd_lvl_number,15) = prd.prd_lvl_number)
    WHERE trd.addn_tag_type_ind='F'
    GROUP BY prd.prd_lvl_parent,
        att.tckt_req_hdr_num,
        att.reference_key,
        trd.tag_type
),
all_prd_attr AS
(
    SELECT /*+ DRIVING_SITE(attr_subtyp) */
        prd_attr.prd_lvl_child,
        attr_desc.atr_code_desc,
        attr_desc.atr_code
    FROM
       basatyee@batprd_cmsprd attr_typ
       JOIN basahree@batprd_cmsprd attr_subtyp
        ON (attr_typ.atr_typ_tech_key = attr_subtyp.atr_typ_tech_key )
       JOIN basatpee@batprd_cmsprd prd_attr
        ON( prd_attr.atr_typ_tech_key = attr_typ.atr_typ_tech_key
            AND prd_attr.atr_hdr_tech_key = attr_subtyp.atr_hdr_tech_key)
       JOIN basacdee@batprd_cmsprd attr_desc
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
    CAST('TCKT_CREATE_DT'           AS VARCHAR2(100)) AS TCKT_CREATE_DT,
    CAST('PO_VPC_NUM'               AS VARCHAR2(100)) AS PO_VPC_NUM,
    CAST('PRDUCT_NUM'               AS VARCHAR2(100)) AS PRDUCT_NUM,
    CAST('TCKT_EXTRACT_DT'          AS VARCHAR2(100)) AS TCKT_EXTRACT_DT,
    CAST('EXPTD_RCPT_DATE'          AS VARCHAR2(100)) AS EXPTD_RCPT_DATE,
    CAST('PO_CREATE_DT'             AS VARCHAR2(100)) AS PO_CREATE_DT,
    CAST('PO_AMEND_DT'              AS VARCHAR2(100)) AS PO_AMEND_DT,
    CAST('MIN_HAND_OVER_DATE'       AS VARCHAR2(100)) AS MIN_HAND_OVER_DATE,
    CAST('MAX_HAND_OVER_DATE'       AS VARCHAR2(100)) AS MAX_HAND_OVER_DATE,
    CAST('QUANTITY'                 AS VARCHAR2(100)) AS QUANTITY,
    CAST('PRD_TCKT_TYPE'            AS VARCHAR2(100)) AS PRD_TCKT_TYPE,
    CAST('SEASON'                   AS VARCHAR2(100)) AS SEASON,
    CAST('DEPARTMENT'               AS VARCHAR2(100)) AS DEPARTMENT,
    CAST('DEPT_NUM'                 AS VARCHAR2(100)) AS DEPT_NUM,
    CAST('RANGE'                    AS VARCHAR2(100)) AS RANGE,
    CAST('RANGE_NUM'                AS VARCHAR2(100)) AS RANGE_NUM,
    CAST('DIVISION'                 AS VARCHAR2(100)) AS DIVISION,
    CAST('DIVISION_NUM'             AS VARCHAR2(100)) AS DIVISION_NUM,
    CAST('TAG_TYPE_SENT'            AS VARCHAR2(100)) AS TAG_TYPE_SENT,
    CAST('TAG_TYPE_CURRENT'         AS VARCHAR2(100)) AS TAG_TYPE_CURRENT,
    CAST('PRD_DESCRIPTION'          AS VARCHAR2(100)) AS PRD_DESCRIPTION,
    CAST('LOOK'                     AS VARCHAR2(100)) AS LOOK,
    CAST('RFIDABLE'                 AS VARCHAR2(100)) AS RFIDABLE,
    CAST('TICKET_REQ_TYPE'          AS VARCHAR2(100)) AS TICKET_REQ_TYPE,
    CAST('TAG_SUPP_NAME'            AS VARCHAR2(100)) AS TAG_SUPP_NAME,
    CAST('SUPPLIER'                 AS VARCHAR2(100)) AS SUPPLIER,
    CAST('COUNTRY_OF_MANUFCT'       AS VARCHAR2(100)) AS COUNTRY_OF_MANUFCT
FROM DUAL@batprd_cmsprd dl /*+ DRIVING_SITE(dl) */
UNION ALL
SELECT /*+ DRIVING_SITE(vdr) */
    to_char(att.create_dt, 'dd/mm/yyyy')                   AS tckt_create_dt
    ,to_char(att.reference_key)                            AS po_vpc_no
    ,to_char(apd.prd_lvl_number)                           AS prd_lvl_number
    ,to_char(att.req_extract_dt, 'dd/mm/yyyy')             AS req_extract_dt
    ,to_char(ap.pmg_exp_rct_date, 'dd/mm/yyyy')            AS expected_receipt_date
    ,to_char(ap.pmg_entry_date, 'dd/mm/yyyy')              AS po_create_dt
    ,to_char(ap.pmg_last_chg_dt, 'dd/mm/yyyy')             AS po_amend_dt
    ,to_char(ap.min_hand_over_date, 'dd/mm/yyyy')          AS min_hand_over_date
    ,to_char(ap.max_hand_over_date, 'dd/mm/yyyy')          AS max_hand_over_date
    ,to_char(CASE
        WHEN att.req_type_ind='P'
            AND NVL(atdq.tckt_dtl_qty,0) =0
                THEN ap.pmg_sell_qty
         ELSE atdq.tckt_dtl_qty
     END)                                     AS quantity
    ,to_char(apa.atr_code_desc)               AS prd_lvl_ticket_type
    ,to_char(apd.season)                      AS season
    ,to_char(apd.dept_name)                   AS department
    ,to_char(apd.dept_num)                    AS dept_number
    ,to_char(apd.range_name)                  AS range
    ,to_char(apd.range_num)                   AS range_number
    ,to_char(apd.division_name)               AS division
    ,to_char(apd.division_num)                AS division_number
    ,to_char(atdq.tag_type)                   AS tag_type_sent
    ,to_char(cms_attr.f_prd_hier_attr_code@batprd_cmsprd(
            'Ticketing',
            'Ticket Type',
            ap.prd_lvl_child))                AS tag_type_current
    ,to_char(apd.prd_name_full)               AS prd_description
    ,to_char(apd.look)                        AS look
    ,to_char(CASE
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
     END)                                   AS rfidable
     ,to_char(CASE att.r_req_type_ind
        WHEN 'P' then 'Production'
        WHEN 'O' then 'Adhoc PO'
        WHEN 'C' then 'Adhoc Case-pack'
        WHEN 'R' then 'Adhoc ref-req'
    END)                                    AS ticket_request_type,
    to_char(trs.tag_supp_name)              AS tag_supp_name,
    to_char(vdr.vendor_name)                AS supplier,
    to_char(cms_prd_dtl.f_cntry_of_origin@batprd_cmsprd(
                  ap.prd_lvl_child,
                  ap.vpc_tech_key))         AS country_of_mnfct
FROM all_tckt_type att
    JOIN all_product ap
        ON(att.tckt_req_hdr_num = ap.tckt_req_hdr_num)
    JOIN all_product_with_hier_denorm apd
        ON(ap.prd_lvl_child = apd.prd_lvl_child)
    JOIN vpcmstee@batprd_cmsprd vdr
        ON(ap.vpc_tech_key     = vdr.vpc_tech_key)
    LEFT JOIN all_tckt_dtl_qty atdq
        ON(att.tckt_req_hdr_num = atdq.tckt_req_hdr_num
            AND ap.prd_lvl_child = atdq.prd_lvl_parent)
    LEFT JOIN all_prd_attr apa
        ON (ap.prd_lvl_child = apa.prd_lvl_child)
    LEFT JOIN rfid_map@batprd_cmsprd rngmp
         ON (rngmp.prd_lvl_child = apd.range_id)
    LEFT JOIN rfid_map@batprd_cmsprd deptmp
         ON (deptmp.prd_lvl_child = apd.dept_id)
    LEFT JOIN tckt_req_supplier@batprd_cmsprd trs
        ON (NVL(att.tag_supp_code,
                cms_attr.f_add_value@batprd_cmsprd('TS',
                'PMGHDREE',
                DECODE(req_type_ind,'C',NULL,att.reference_key))
                ) = trs.tag_supp_code)
WHERE NOT(att.r_req_type_ind <> 'P'
    AND atdq.tckt_dtl_qty IS  NULL)
]');

    COMMIT;

END;
/