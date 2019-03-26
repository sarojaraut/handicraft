Multi_table_insert

By specifying FIRST, Oracle stops evaluating the WHEN clause when the first condition is met. Alternatively, if ALL is specified, all conditions will be checked for each row. ALL is useful when the same row is stored in
multiple tables.

INSERT FIRST WHEN today_special_offer = 'Y'
THEN INTO special_purchases
ELSE INTO purchases
SELECT * FROM apr_orders;



SQL> EXECUTE dbms_olap.validate_dimension('product','easydw',false,true);

SQL> SELECT * FROM mview$_exceptions;
no rows selected


CREATE MATERIALIZED VIEW MONTHLY_SALES_MV
PCTFREE 0 TABLESPACE summary
    STORAGE (initial 64k next 64k pctincrease 0) -- <- storage parameters
    BUILD IMMEDIATE                              -- <- when to populate it
    REFRESH FORCE                                -- <- how to refresh it
    ON DEMAND                                    -- <- when to refresh it
    ENABLE QUERY REWRITE                         -- <- use in query rewrite or not
AS                                               -- <- query result it contains
SELECT t.month, t.year, p.product_id,
    SUM (f.purchase_price) as sum_of_sales,
    COUNT (f.purchase_price) as total_sales,
    COUNT(*) as cstar
FROM time t, product p, purchases f
WHERE t.time_key = f.time_key AND
    f.product_id = p.product_id
GROUP BY t.month, t.year, p.product_id;


you can partition yur mviews and create index as well.

To create a materialized view with REFRESH ON COMMIT option, the owner must have the ON COMMIT object privileges on all tables (referenced in the materialized view) outside the schema or have the ON COMMIT system privilege.

EXECUTE DBMS_MVIEW.REFRESH('MONTHLY_SALES_MV', 'C');

In the following example, the REFRESH procedure is used to refresh two materialized views, MONTHLY_SALES_MV and Q12003_SALES_MV, using atomic_refresh.

EXECUTE DBMS_MVIEW.REFRESH('MONTHLY_SALES_MV, Q12003_SALES_MV', atomic_refresh=>TRUE);

The following attractions can only offer print and post when purchasing from a desktop: THORPE PARK Resort, Madame Tussauds London, Coca-Cola London Eye, SEA LIFE London Aquarium, London Dungeons and DreamWorks Tours: Shrek’s Adventure! London.
The following attractions are collection only: The National SEA LIFE Centre Birmingham, SEA LIFE Great Yarmouth, Cornish Seal Sanctuary Gweek, SEA LIFE Loch Lomond Aquarium, Scottish SEA LIFE Sancturary (Oban), Scarborough SEA LIFE Sanctuary and York Dungeon & Edinburgh Dungeon.
Please note by opting for print and post your pass will be distributed within 3-5 working days and will be activated when it is sent out.


