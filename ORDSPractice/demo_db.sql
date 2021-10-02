drop table facility purge;
drop table counterparty purge;
drop table creditgroup purge;
drop table product purge;
drop table country purge;


create table country(
    country_id           number,
    country_name         varchar2(50),
    constraint country_ak1 unique (country_id)
);

create table counterparty(
    counterparty_id           number,
    counterparty_name         varchar2(50),
    country_of_risk           number,
    constraint counterparty_ak1 unique (counterparty_id)
);

create table creditgroup(
    credit_group_id           number,
    credit_group_name         varchar2(50),
    country_of_risk           number,
    constraint creditgroup_ak1 unique (credit_group_id)
);

create table product(
    product_id           number,
    product_name         varchar2(50),
    constraint product_ak1 unique (product_id)
);

create table facility
(
    facility_id               number, 
    booking_entity_id         number, 
    counterparty_id           number, 
    credit_group_id           number, 
    product_id                number, 
    mdr_id                    number, 
    reporting_date             date, 
    gross_max_limit            number, 
    gross_available_limit      number, 
    net_max_limit              number, 
    net_available_limit        number, 
    mdr_counterparty_limit     number, 
    mdr_overall_limit          number, 
    item_1                     number, 
    item_2                     number, 
    item_3                     number, 
    item_4                     number, 
    item_5                     number, 
    standalone_clo             number, 
    standalone_cds             number, 
    integrated_clo             number, 
    integrated_cds             number, 
    cla_facility_net_limit     number, 
    cla_grp_mdr_net_limit      number, 
    cla_cpy_mdr_net_limit      number, 
    br_be_party_id             number, 
    constraint facility_ak1 unique (reporting_date, br_be_party_id, booking_entity_id, facility_id),
    constraint facility_fk1 foreign key(counterparty_id) references counterparty(counterparty_id),
    constraint facility_fk2 foreign key(credit_group_id) references creditgroup(credit_group_id),
    constraint facility_fk3 foreign key(product_id) references product(product_id)
);



insert into country
with full_str as (
    select 'UK,USA,DEU,FRA,JPN,IND' val from dual
)
select 
    rownum,
    regexp_substr(val,'[^,]+',1,rownum) country
from full_str
connect by rownum <= regexp_count(val,',')+1;

insert into counterparty
select 
    rownum, 
    'CP_'||rownum,
    mod(rownum,6)+1
from dual
connect by rownum <=1000;

insert into creditgroup
select 
    rownum, 
    'CG_'||rownum,
    mod(rownum,6)+1
from dual
connect by rownum <=1000;

insert into product
select 
    rownum, 
    'P_'||rownum
from dual
connect by rownum <=10;

insert into facility
select
    rownum,             --facility_id               number, 
    mod(rownum, 1000 ), --booking_entity_id         number, 
    mod(rownum, 1000 )+1,--counterparty_id           number, 
    mod(rownum, 1000 )+1,--credit_group_id           number, 
    mod(rownum, 10 )+1, --product_id                number, 
    mod(rownum, 1000 ), --mdr_id                    number, 
    trunc(sysdate),     --reporting_date             date, 
    rownum * 100 + 90,  --gross_max_limit            number, 
    rownum * 100 + 80,  --gross_available_limit      number, 
    rownum * 100 + 70,  --net_max_limit              number, 
    rownum * 100 + 60,  --net_available_limit        number, 
    rownum * 100 + 50,  --mdr_counterparty_limit     number, 
    rownum * 100 + 40,  --mdr_overall_limit          number, 
    rownum * 100 + 1,   --item_1                     number, 
    rownum * 100 + 2,   --item_2                     number, 
    rownum * 100 + 3,   --item_3                     number, 
    rownum * 100 + 4,   --item_4                     number, 
    rownum * 100 + 5,   --item_5                     number, 
    20 ,                --standalone_clo             number, 
    20 ,                --standalone_cds             number, 
    20 ,                --integrated_clo             number, 
    20 ,                --integrated_cds             number, 
    10,                 --cla_facility_net_limit     number, 
    10,                 --cla_grp_mdr_net_limit      number, 
    10,                 --cla_cpy_mdr_net_limit      number, 
    415                 --br_be_party_id             number,
from dual
connect by rownum <= 100000;

------------- ORDS End Point



BEGIN
    ORDS.DEFINE_MODULE(
        p_module_name    => 'cr',
        p_base_path      => 'cr/',
        p_items_per_page => 10,
        p_status         => 'PUBLISHED',
        p_comments       => 'Credit Risk Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'cr',
        p_pattern        => 'party/');
    ORDS.DEFINE_HANDLER(
        p_module_name    => 'cr',
        p_pattern        => 'party/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => '
        select
            counterparty_id             as "counterpartyId",
            sum(gross_max_limit)        as "grossMaxLimit",
            sum(gross_available_limit)  as "grossAvailableLimit",
            sum(net_max_limit)          as "netMaxLimit",
            sum(net_available_limit)    as "netAvailableLimit"
        from facility
        group by counterparty_id
        ');

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'cr',
        p_pattern        => 'party/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name    => 'cr',
        p_pattern        => 'party/:id',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => '
        select
            counterparty_id        as "counterpartyId",
            facility_id            as "facilityId",
            gross_max_limit        as "grossMaxLimit",
            gross_available_limit  as "grossAvailableLimit",
            net_max_limit          as "netMaxLimit",
            net_available_limit    as "netAvailableLimit"
        from facility
        where counterparty_id = :id
        ');

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'cr',
        p_pattern        => 'group/');
    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'cr',
        p_pattern        => 'group/:id');
    ORDS.DEFINE_HANDLER(
        p_module_name    => 'cr',
        p_pattern        => 'group/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => '
        select
            credit_group_id             as "creditGroupId",
            sum(gross_max_limit)        as "grossMaxLimit",
            sum(gross_available_limit)  as "grossAvailableLimit",
            sum(net_max_limit)          as "netMaxLimit",
            sum(net_available_limit)    as "netAvailableLimit"
        from facility
        group by credit_group_id
        ');
    ORDS.DEFINE_HANDLER(
        p_module_name    => 'cr',
        p_pattern        => 'group/:id',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => '
        select
            credit_group_id        as "creditGroupId",
            facility_id            as "facilityId",
            gross_max_limit        as "grossMaxLimit",
            gross_available_limit  as "grossAvailableLimit",
            net_max_limit          as "netMaxLimit",
            net_available_limit    as "netAvailableLimit"
        from facility
        where credit_group_id = :id
        ');

END;
/

commit;

-- https://sd2cgxnc6zom7sw-devclearing.adb.uk-london-1.oraclecloudapps.com/ords/demodb/cr/party
-- https://sd2cgxnc6zom7sw-devclearing.adb.uk-london-1.oraclecloudapps.com/ords/demodb/cr/group


-- https://sd2cgxnc6zom7sw-devclearing.adb.uk-london-1.oraclecloudapps.com/ords/demodb/cr/party/1
-- https://sd2cgxnc6zom7sw-devclearing.adb.uk-london-1.oraclecloudapps.com/ords/demodb/cr/group/1