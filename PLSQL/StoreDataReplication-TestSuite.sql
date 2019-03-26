1. Comparing store data for each row.
2. 
3.

CREATE MATERIALIZED VIEW STORE_MV 
BUILD DEFERRED
REFRESH FORCE
AS
WITH ORGCLO_LIST AS(
SELECT clo.org_lvl_child,
                LISTAGG(
                TO_CHAR(clo.org_closed_fr_date,'DD-MON-YYYY') || ' - ' ||
                TO_CHAR(clo.org_closed_to_date,'DD-MON-YYYY')
                ,','
                ) WITHIN GROUP (ORDER BY org_closed_fr_date) AS date_str
FROM   orgcloee@PMM       clo
GROUP BY ORG_LVL_CHILD
)
SELECT 
    DISTINCT 
    --org.org_lvl_child       AS sk_store_id,
    org.org_lvl_number               AS storeid,
    DECODE(org.web_store_ind,
          'T'/*s_const.C_true*/, ' ' || RTRIM(org.org_name_full),
          RTRIM(org.org_name_full)
         )                           AS storename,
    SUBSTR(TRIM(olvl2.org_name_full),1,40)
                                     AS manager,
    TRIM(adr.bas_addr_1) || ', ' ||
    TRIM(NVL(adr.bas_addr_2, ''))    AS address1,
    CASE
       WHEN    adr.bas_addr_3 IS NULL
            OR adr.bas_addr_3 = LPAD(' ',40,' ')
       THEN
           CASE
               WHEN    adr.bas_state IS NULL
                    OR adr.bas_state = LPAD(' ',40,' ')
               THEN
                   TRIM(REPLACE(adr.bas_addr_3,'|',' '))
               ELSE
                   TRIM(REPLACE(adr.bas_city,'|',' '))
           END
       ELSE
           TRIM(REPLACE(adr.bas_addr_3,'|',' '))
    END                              AS address2,
    CASE
       WHEN    adr.bas_addr_3 IS NULL
            OR adr.bas_addr_3 = LPAD(' ',40,' ')
       THEN
           CASE
               WHEN    adr.bas_state IS NULL
                    OR adr.bas_state = LPAD(' ',40,' ')
               THEN
                   TRIM(REPLACE(adr.bas_city,'|',' '))
               ELSE
                   TRIM(REPLACE(adr.bas_state,'|',' '))
           END
       ELSE
           TRIM(REPLACE(adr.bas_city,'|',' '))
    END                              AS city,
    NVL(UPPER(coo.cntry_name), '')   AS country,
    TRIM(adr.bas_area) || ' ' ||
    TRIM(adr.bas_phone_numb)         AS phone,
    'N' /*s_const.C_no*/             AS closure,
    TO_CHAR(org.org_lvl_number)      AS code,
    CAST(NULL AS VARCHAR (25))       AS comments,
    1 /*C_active_sts*/               AS status,
    SYSDATE                          AS createdon,
    odtl.org_date_opened             AS storeopeningdate,
    odtl.org_date_closed             AS storeclosingdate,
    clo.date_str                     AS temporarycloserdate,
    NVL(
       cms_attr.f_attr_code@PMM(
           'Store Ordering' /*cms_attr_const.C_attr_typ_store_ordering*/,
           'Collection Store' /*cms_attr_const.C_collection_store*/,
           'ORG' /*cms_attr_const.C_app_fnc_org*/,
           org.org_lvl_child),
        'F' /*s_const.C_false*/
       )                             AS collection_store_ind,
    adr.vpc_email                    AS vpc_email
FROM   alt_orgmstee@PMM org
    JOIN   alt_orgplvee@PMM olv
       ON (org.org_lvl_child      = olv.org_lvl_child)
    JOIN   alt_orgmstee@PMM olvl4
       ON (olv.org_lvl_parent     = olvl4.org_lvl_child)
    JOIN   alt_orgmstee@PMM olvl2
       ON (olvl2.org_lvl_child    = org.org_lvl_parent)
    JOIN   orgdtlee@PMM odtl
       ON (odtl.org_lvl_child     = org.org_lvl_child)
    JOIN   basadree@PMM adr
       ON (odtl.bas_add_key       = adr.bas_add_key)
    LEFT OUTER JOIN   bascooee@PMM coo
       ON (coo.cntry_lvl_child = odtl.cntry_lvl_child)
    LEFT OUTER JOIN   orgclo_list clo
        ON (clo.org_lvl_child = org.org_lvl_child)
WHERE  org.org_is_store       = 'T' --s_const.C_true
AND    olv.org_lvl_id         = 1 /*org_hier.C_location_id*/
AND    DECODE(odtl.org_date_closed, '', SYSDATE,
                                    ADD_MONTHS(odtl.org_date_closed,
                                               12 /*C_add_months*/)
             ) >= SYSDATE
AND org.alt_hier_id   = 1 -- cms_alt_org_hier.G_dflt_hier
AND olv.alt_hier_id   = 1 --cms_alt_org_hier.G_dflt_hier
AND olvl4.alt_hier_id = 1 --cms_alt_org_hier.G_dflt_hier
AND olvl2.alt_hier_id = 1 --cms_alt_org_hier.G_dflt_hier;

