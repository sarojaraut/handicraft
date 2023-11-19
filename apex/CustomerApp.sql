/*

Navigation Menu
    Customers
    Categories
    Geographies
    Products



Tricks :
    Item group : display as piill button

    And in LOV

escape special characters
    set template  = <span class="t-Icon fa fa-table" title="#DISPLAY_VALUE#"></span>

    list Region with template as alert and attribute as media list which will show list items as clickable media item, hide icon of alert regioin

<span class="t-Icon fa fa-tiles-2x2" title="#DISPLAY_VALUE#"></span><span class="u-VisuallyHidden">#DISPLAY_VALUE#</span>

<span class="t-Icon fa fa-table" title="#DISPLAY_VALUE#"></span><span class="u-VisuallyHidden">#DISPLAY_VALUE#</span>

#APP_FILES#icons/app-icon-192.png

If you want to dynamicaly create a Pagee title in breadcrumb seection then create a dynamic content and use template like hero

declare
  t varchar2(4000) := null;
begin
  begin
      t := EBA_CUST_FW.get_preference_value('WELCOME_TEXT');
  exception
      when others then
      t := null;
  end;
  if t is null or t = '&nbsp;' or t = 'Preference does not exist' then
     sys.htp.p('<p>Track and Manage Customers</p>');
  else
     sys.htp.p('<p>'||apex_escape.html(t)||'</p>');
  end if;
end;


*/

-- Customer Cards queery
select
    apex_util.prepare_url('f?p='||:APP_ID||':50:'||:APP_SESSION||':::50:P50_ID:'||a.id) card_link,
    a.customer_name card_title,
    NVL(substr(a.summary,1,255), DBMS_LOB.substr(a.customer_profile,255,1))      card_text,
    --nvl(c.status,'Unknown Status')||', '||
    nvl((select INDUSTRY_NAME from EBA_CUST_INDUSTRIES i where i.id = a.INDUSTRY_ID),'')
        ||decode(geography_name,null,null,', '|| geography_name) card_subtext,
    upper(
        decode(instr(a.customer_name,' '),
                0,
                substr(a.customer_name,1,2),
                substr(a.customer_name,1,1)||substr(a.customer_name,instr(a.customer_name,' ')+1,1)
        )) card_initials
from eba_cust_customers a,
    eba_cust_categories b,
    eba_cust_status c,
    eba_cust_geographies d,
    eba_cust_type e,
    eba_cust_use_case f
where a.category_id = b.id(+)
    and a.status_id = c.id(+)
    and a.geography_id = d.id(+)
    and a.type_id = e.id(+)
    and a.use_case_id = f.id(+)
    and (:P59_SEARCH is null or
            instr(upper(a.customer_name),upper(:P59_SEARCH)) > 0 or
                       instr(upper(a.summary),upper(:P59_SEARCH)) > 0 )
    and (NVL(:P59_GEO,0) = 0 or :P59_GEO = a.geography_id)
    and (NVL(:P59_COUNTRY,0) = 0 or :P59_COUNTRY = a.country_id)
    and (NVL(:P59_INDUSTRY,0) = 0 or  :P59_INDUSTRY = a.industry_id)
    and (NVL(:P59_CATEGORY,0) = 0 or :P59_CATEGORY = a.category_id)
    and (NVL(:P59_STATUS,0) = 0 or :P59_STATUS = a.status_id)
    and (NVL(:P59_TYPE,0) = 0 or :P59_TYPE = a.type_id)
    and (NVL(:P59_USE_CASE,0) = 0 or :P59_USE_CASE = a.use_case_id)
    and (:P59_MARQUEE_CUST is null or :P59_MARQUEE_CUST = a.marquee_customer_yn)
    and (:P59_IMP_PARTNER is null
        or exists ( select null
                    from eba_cust_cust_partner_ref rf
                    where rf.customer_id = a.id
                        and rf.partner_id = :P59_IMP_PARTNER ))
    and (:P59_COMPETITOR is null
        or exists ( select null
                    from eba_cust_cust_competitor_ref rf
                    where rf.customer_id = a.id
                        and rf.competitor_id = :P59_COMPETITOR ))
    and (:P59_REFERENCEABLE is null or :P59_REFERENCEABLE = a.referencable)
    and (:P59_SCP_CUST is null or :P59_SCP_CUST = a.strategic_customer_program_yn)
    and (
        exists (select 1 from eba_cust_customer_reftype_ref r
        where r.customer_id = a.id and
              instr(':'||:P59_REFERENCE_TYPES||':',':'||reference_type_id||':') > 0)
        or
        :P59_REFERENCE_TYPES is null
        )
    and  NVL(:P59_DISPLAY_AS,'X') = 'CARDS'
    and (NVL(:P59_PRODUCT,0) = 0 or exists (select 1 from eba_cust_product_uses u where u.CUSTOMER_ID = a.id and u.PRODUCT_ID = :P59_PRODUCT))
order by
    case :P59_SORT
        when 'NAME' then lower(a.customer_name)
        else null
    end,
    case :P59_SORT
        when 'UPDATED' then current_timestamp - a.updated
        when 'OLDFIRST' then a.created - current_timestamp
        when 'NEWFIRST' then current_timestamp - a.created
        else null
    end,
    case :P59_SORT
        when 'NAME' then current_timestamp - a.updated
        else null
    end,
    case :P59_SORT
        when 'UPDATED' then lower(a.customer_name)
        when 'OLDFIRST' then lower(a.customer_name)
        when 'NEWFIRST' then lower(a.customer_name)
        else null
    end

