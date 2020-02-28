------
--Query with green play button for active courses
--and amber stop buttons for inactive courses
------
with course_rule_summary as
(
select
    ucas_code
    ,sum(case when required_for ='O' then 1 else 0 end) offer_rules
    ,sum(case when required_for ='R' then 1 else 0 end) rffer_rules
    ,sum(case when required_for is null then 1 else 0 end) other_rules
    ,count(*) total_rules
from rule_course
group by ucas_code
)
select
    c.ucas_code || ' - '|| c.course_title course
    ,c.tariff_advertised Offer
    ,c.tariff_accepted reffer
    ,c.url
    ,nvl(crs.offer_rules,0) offer_rules
    ,nvl(crs.rffer_rules,0) rffer_rules
    ,nvl(crs.other_rules,0) other_rules
    ,nvl(crs.total_rules,0) total_rules
    , case when c.vacancies_internal = 1 
        then '<span aria-hidden="true" style="color:#4caf50" class="fa fa-play-circle"></span>'
        else '<span aria-hidden="true" style="color:#ffa000" class="fa fa-stop-circle"></span>'
    end open
    ,c.ucas_code
from clr_course c
left join course_rule_summary crs
    on c.ucas_code = crs.ucas_code;
------
--Query with add rule button
------
with course_rule_summary as
(
select
    ucas_code
    ,sum(case when required_for ='O' then 1 else 0 end) offer_rules
    ,sum(case when required_for ='R' then 1 else 0 end) rffer_rules
    ,sum(case when required_for is null then 1 else 0 end) other_rules
    ,count(*) total_rules
from rule_course
group by ucas_code
)
select
    c.ucas_code || ' - '|| c.course_title course
    ,c.tariff_advertised Offer
    ,c.tariff_accepted reffer
    ,c.url
    ,nvl(crs.offer_rules,0) offer_rules
    ,nvl(crs.rffer_rules,0) rffer_rules
    ,nvl(crs.other_rules,0) other_rules
    ,nvl(crs.total_rules,0) total_rules
    , case when c.vacancies_internal = 1 
        then '<span aria-hidden="true" style="color:#4caf50" class="fa fa-play-circle"></span>'
        else '<span aria-hidden="true" style="color:#ffa000" class="fa fa-stop-circle"></span>'
    end open
    ,c.ucas_code
from clr_course c
left join course_rule_summary crs
    on c.ucas_code = crs.ucas_code;
------
--Query with buttons for adding details and courses
------

select 
    id
    ,description
    ,created
    ,created_by
    ,updated
    ,updated_by
    ,'Details'  rule_detail_text
    ,case 
        when id < 0 
        then  'class="ma-button disabled  btn waves-effect waves-light"' 
        else 'class="ma-button btn btn-outlined waves-effect waves-light icon-float-right"' 
     end   rule_detail_link_class
     ,'Courses'  rule_course_link_text
     ,'class="ma-button btn btn-outlined waves-effect waves-light icon-float-right"' rule_course_link_class
from rule_header_vw
order by id desc