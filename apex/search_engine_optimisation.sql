https://insum.ca/search-engine-optimization-with-apex-creating-a-google-sitemap/

create or replace package apex_sitemap as

    -- This procedure creates a sitemap that includes all public pages
    -- in the application with p_app_id with the following exceptions:
    --   - pages that have a build set that is not "Include"
    --   - modal pages
    --   - pages without URL access, e.g. page 0
    --   - page 101 because it is typically the login page
    procedure page_xml(p_app_id   in number);

/*
    -- This procedure is specific to an application that utilizes the table "MY_CATALOG."
    -- 
    --
    -- This procedure creates a sitemap that includes all public pages
    -- in the application with p_app_id with the following exceptions:
    --   - pages that have a build set that is not "Include"
    --   - modal pages
    --   - pages without URL access, e.g. page 0
    --   - page 101 because it is typically the login page
    --
    -- Additionally, this procedure will generate sitemap entries for a specific
    -- parameterized page (page 123456).
    procedure catalog_xml;
*/

end;
/


create or replace package body apex_sitemap as
    -- see package spec for usage
    procedure page_xml (p_app_id  in number) as

        l_xml  clob;

    begin
        begin
            select  
            xmlElement("urlset", xmlattributes('http://www.sitemaps.org/schemas/sitemap/0.9' as "xmlns")
                , xmlAgg(
                xmlElement("url",
                    xmlElement("loc", 'http://www.adarshwork.com/ords/f?p=' || aap.application_id ||':'|| aap.page_id ||':0') the_xml
                    )
                )
                ).getClobVal() the_xml
            into l_xml
            from apex_applications aa
            inner join APEX_APPLICATION_PAGES aap 
                on aap.application_id = aa.application_id
            left outer join apex_application_build_options bo 
                on bo.build_option_name = aap.build_option
                and bo.application_id = aap.application_id
            where aa.application_id = p_app_id
            -- do not return modal pages
            and aap.page_mode = 'Normal'
            -- only show public pages
            and (aap.page_requires_authentication = 'No' or aa.authentication_scheme_type = 'No Authentication')
            -- do not return pages without URL access, e.g. page 0
            and aap.page_access_protection != 'No URL Access'
            -- do not return login page
            and aap.page_id not in (101)
            -- check build status
            and (bo.build_option_status is null or bo.build_option_status = 'Include');
    
            -- Note! This will only output 32K.
            --       If you anticipate more than 32K, consider chunking or other options.
--            OWA_UTIL.mime_header('text/xml');
            htp.print('<?xml version="1.0" encoding="UTF-8"?>');
            htp.print(l_xml);
    
        exception
            when others then dbms_output.put_line('Err: ' || sqlerrm);
            raise;
        end;

    end page_xml;


end;
/


http://www.adarshwork.com/ords/f?p=103:2::::::

http://www.google.com/ping?sitemap=<complete_url_of_sitemap>


-- Ords End POint

declare 
    l_module_name          varchar2(100)   := 'adarshwork.v1';
    L_module_base_path     varchar2(100)   := 'adarshwork/';
    L_template_base        varchar2(100)   := 'v1/';
    L_sitemap_sql          varchar2(32767) :=
        q'[
            begin
                apex_sitemap.page_xml(p_app_id => 103);
            end;
        ]';
begin
    ords.enable_schema(
        p_enabled             => true,
        p_schema              => user,
        p_url_mapping_type    => 'BASE_PATH',
        p_url_mapping_pattern => 'myapi',
        p_auto_rest_auth      => false
    );
    --
    -- main module template and handler
    --
    ords.define_module(
        p_module_name    => l_module_name,
        p_base_path      => L_module_base_path,
        p_items_per_page => 10,
        p_status         => 'PUBLISHED',
        p_comments       => 'adarsh apis'
    );
    --
    -- get all students : http://www.adarshwork.com/ords/myapi/adarshwork/v1/
    --
    ords.define_template(
        p_module_name    => l_module_name,
        p_pattern        => L_template_base
    );

    ords.define_handler(
        p_module_name    => l_module_name,
        p_pattern        => L_template_base,
        p_method         => 'GET',
        p_source_type    => ords.source_type_plsql,
        p_source         => L_sitemap_sql,
        p_items_per_page => 0
    );

    commit;
exception
    when others then 
        dbms_output.put_line(sqlerrm);
        rollback;
        raise;
end;
/

https://sd2cgxnc6zom7sw-ourcompany.adb.uk-london-1.oraclecloudapps.com/ords/myapi/adarshwork/v1/

http://www.adarshwork.com/ords/myapi/adarshwork/v1/

http://www.adarshwork.com/ords/myapi/adarshwork/v1/

Make your sitemap available to Google (Submit your sitemap to Google)

http://www.google.com/ping?sitemap=http://www.adarshwork.com/ords/myapi/adarshwork/v1/

Output 

Sitemap Notification Received

Your Sitemap has been successfully added to our list of Sitemaps to crawl. If this is the first time you are notifying Google about this Sitemap, please add it via http://www.google.com/webmasters/tools/ so you can track its status. Please note that we do not add all submitted URLs to our index, and we cannot make any predictions or guarantees about when or if they will appear.


https://support.google.com/webmasters/answer/9008080#domain_name_verification

https://search.google.com/u/3/search-console/inspect?resource_id=sc-domain%3Aadarshwork.com&id=JJ-L9xegZrTjF3BSmgJkUQ

