The basic makeup of an ORDS RESTful web service is as follows.

Module : A container for one or more templates, with an associated path (testmodule1/).
Template : A container for one or more handlers. The template must be unique within the module and is associated with a specific path (emp/), which may or may not include parameters.
Handler : A link to the actual work that is done. Typical handler methods include GET, POST, PUT, DELETE, which are passed in the HTTP header, rather than the URL. Each handler is associated with a specific source (or action), which can be of several types.


http://www.slideshare.net/search/slideshow?ft=all&lang=%2A%2A&page=2&q=Oracle+ORDS&qid=26e8c73f-7b7d-4d2e-bd4e-c2225c8fe5c9&searchfrom=header&sort=&ud=any

http://www.slideshare.net/chriscmuir/oracle-rest-data-services?qid=26e8c73f-7b7d-4d2e-bd4e-c2225c8fe5c9&v=&b=&from_search=11

http://www.slideshare.net/DimitriGielis/oracle-application-express-apex-and-microsoft-sharepoint-integration?qid=26e8c73f-7b7d-4d2e-bd4e-c2225c8fe5c9&v=&b=&from_search=8

http://www.slideshare.net/MarkoGoriki/speed-up-your-apex-apps-with-json-and-handlebars?qid=26e8c73f-7b7d-4d2e-bd4e-c2225c8fe5c9&v=&b=&from_search=5

http://www.slideshare.net/hillbillyToad/auto-rest-enabling-your-oracle-database-tables?qid=26e8c73f-7b7d-4d2e-bd4e-c2225c8fe5c9&v=&b=&from_search=1

http://www.slideshare.net/KrisRice/oracle-rest-data-services-best-practices-overview?qid=26e8c73f-7b7d-4d2e-bd4e-c2225c8fe5c9&v=&b=&from_search=18

http://www.slideshare.net/DimitriGielis/how-to-make-apex-print-through-nodejs?qid=26e8c73f-7b7d-4d2e-bd4e-c2225c8fe5c9&v=&b=&from_search=23

http://dgielis.blogspot.co.uk/2015/05/2-minute-tech-tip-working-with-json-in.html


ORDS is now main-stream, widely adopted and proven technology. Unless it's a legacy system, I don't really see any reason anymore why you should not use ORDS in your architecture.

ORDS evolved a lot over time, and the new name reflects more what the core feature is "Oracle REST Data Services". REST web services became so important in the last years

We developed native smart phone applications that call REST web services all build in ORDS. ORDS is getting or pushing the data into our Oracle Database using JSON. Next to that weve dashboards in APEX to "see" and work with the data. We learned and still learn a lot of this project; about the volume of data, the security etc. but without ORDS it would not have been possible.

So this shows how easy it is to generate JSON these days.

from within the database, from the client with javascript/jquery
JSON stands for JavaScript Object Notation, its a text based format to store and transport data. XML VS JSON

It all comes from exchanging data, and finding a format that can easily be used by the "client" who needs to do something with the data. In the past XML (and SOAP) was used a lot to fill that need, between tags you found your data. With JSON its kinda the same, but because many "clients" are now web pages, it makes sense to use something that is very easy to use by a browser.

native json capability

you can get SSL for free too (and its very easy to do!), thanks to Letsencrypt. I used Letsencrypt to protect the Euro2016challenge.eu APEX app/website for example.
Here's the Getting Started Guide from Let's Encrypt. This is the command I used (after installing the package):

./letsencrypt-auto certonly --webroot -w /var/www/euro2016 -d euro2016challenge.eu -d www.euro2016challenge.eu

Whatis this presentation about
 :
ORDS Architecture
ORDS Performance

ORDS evolved a lot over time, and the new name reflects more what the core feature is "Oracle REST Data Services". REST web services became so important in the last years and that is exactly what Ive been blogging and talking about lately (see further).

Advantage :

Heavily invested and actively developed product
Oracle recomended architecture
Multiple deployment options
Integration with JAVA, NODE JS.
Inbuilt debuging and logging features
Integrated security and outh-2 compliant
Restfull web services
Multi DB routing.
Performance and features
Legacy systems can easily listen to web enabled applications easily integrate hybrid systems
Turns database into a rest enabled API service
Supports all HTML methods GET, POST, PUT DELETE, PATCH
Oauth-2 Integration
Mapping URI to SQL and PLSQL
Highly scalable
Virus Scanner Integration, if uploading file- scans all uploaded files before it reaches database
pre and post processes in PLSQL <entry key="procedure.postprocess"> </entry key>
Auto REST enablment
BULK CSV Upload
Provides data access consistent with modern App dev frameworks
MId tier application
Maps standard http(s) requests to SQL (get-slect, post-insert, put-update,merge, head-metadata select)
Returns data in JSON (the common language for integration solution), Available whereevere web is available
provides external data access via HTTP(s)
For modern development frameworks REST is the contemporary choice for javascript(jquery), mobile and cloud solutions
Mapps standard http/restful calls to sql
supports high nmber of users

http:/server:port/contextroot/module/template/template
ORDS maps and binds
sends JDBC SQL call
DB returns result set
ORDS transforms to JASON, CSV, BINARY_INTEGER
response sent to client

http://www.slideshare.net/chriscmuir/oracle-rest-data-services?next_slideshow=1

Deployment choices
One ORDS with mappings
Single web server
Single upgrade/patch

One ORDS per mapping
Multiple webservers
Staggered Upgrades

https://cdivilly.wordpress.com/2013/03/08/configuring-logging-in-oracle-application-express-listener-2-0-1/

$.getJSON("https://www.apexrnd.be/ords/training/emp_json/", function(json) {
  console.log(json);
});

Diaadvantage
Not used that much (yet)
Waiting for Oracle for new features

http://wwisdlap002/ords/cms/orgmodule/orgmstee/

http://wwisdlap002/ords/cms/orgmodule/liststore/SINGAPORE

http://wwisdlap002/ords/cms/orgmodule/orgmstee/10

select * from orgmstee where org_lvl_child=:b1

CREATE TABLE ssn_json
   (id          NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    date_loaded DATE,
    json_document CLOB
    CONSTRAINT ensure_json CHECK (json_document IS JSON));

SELECT XMLELEMENT("items", XMLAGG(
         XMLELEMENT("emp",
           XMLFOREST(
             e.empno AS "empno",
             e.ename AS "ename")
         )
       )) AS employees
FROM   emp e

select '{"items": { "emp":[' 
   || listagg( '{ '
   ||' "empno":"'||empno||'"'
   ||',"ename":'||ename
   ||'} ', ',') within group (order by 1) 
   || ']} }'as  json
from   emp

select org_name_full country,
    org_lvl_child country_id,
    org_lvl_parent country_group_id,
    cursor(
        select org_name_full area,
            org_lvl_child area_id,
            org_lvl_parent country_id,
            cursor(
                select org_name_full area,
                    org_lvl_child area_id,
                    org_lvl_parent country_id
                from orgmstee store
                where area.org_lvl_child = store.org_lvl_parent
                ) store
        from orgmstee area
        where cntry.org_lvl_child = area.org_lvl_parent
        ) area
from orgmstee cntry
where org_lvl_id=3


ORDS

CREATE USER cms IDENTIFIED BY cms;
GRANT "CONNECT" TO cms;
GRANT "RESOURCE" TO cms;
GRANT UNLIMITED TABLESPACE TO cms

SQL for enabling

DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_SCHEMA(p_enabled => FALSE,
                       p_schema => 'CMSER',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'cmser',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;


right-click prdmstee table in the Connections navigator, and select REST Services > Enable RESTful Services, click on enble object(p_enabled => TRUE else FALSE)

DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_OBJECT(p_enabled => TRUE,
                       p_schema => 'CMSER',
                       p_object => 'PRDMSTEE',
                       p_object_type => 'TABLE',
                       p_object_alias => 'prdmstee',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;


http://localhost/ords/cmser/prdmstee
http://localhost/ords/cmser/metadata-catalog/prdmstee/item
http://localhost/ords/cmser/prdmstee/AAAGRDAAEAAAAMrAAY


java -jar ords.war user test_developer "SQL Developer"

You will be prompted to enter a password. The user details are stored in a file named credentials in the ORDS configuration folder.

This command creates a user named test_developer and grants the user the role named SQL Developer. Only users with the SQL Developer role are permitted to access the resource modules API.

Username: test_developer
http or https: Select http for simplicity in this tutorial.
Hostname: localhost
Port: 80
Server Path: /ords ( Context root where the REST Data Services is deployed. Example: /ords)
Workspace: ordstest ( If you are using Oracle REST Data Service RESTful services, specify the schema alias. If you are using Oracle Application Express RESTful services, specify the Application Express workspace to which the user is assigned.)

Create the module. Right-click the Modules node in the REST Development view, click New Module, and enter information on the Specify Module page:

Module Name:  Name of the RESTful service module. Case sensitive. Must be unique.
URI Prefix: /test (Base of the URI that is used to access this RESTful service. Example: test/ means that all URIs starting with test/ will be serviced by this resource module. (The displayed example changes to include what you enter.)
Publish - Make this RESTful Service available for use: Enable (check).(Makes the RESTful service publicly available for use)
Pagination Size: 7
Origins Allowed: Origins that are allowed to access the resource templates. (Click the plus (+) to add each origin.) For example: 
http://example1.org


Resource Template
Specify properties of the resource template. 

URI Pattern: /prdmstee
(A pattern for the resource template. For example, a pattern of /objects/:object/:id? will match /objects/emp/101 (matches a request for the item in the emp resource with id of 101) and will also match /objects/emp/ (matches a request for the emp resource, because the :id parameter is annotated with the ? modifier, which indicates that the id parameter is optional). (The displayed example changes to include what you enter.) 

A URI pattern can be either a route pattern or a URI template, although you are encouraged to use route patterns. Route patterns focus on decomposing the path portion of a URI into its component parts, while URI templates focus on forming concrete URIs from a template. For a detailed explanation of route patterns, see docs\javadoc\plugin-api\route-patterns.html, under <sqldeveloper-install>\ords and under the location (if any) where you manually installed Oracle REST Data Services. 
)

Priority: Priority for the order of how the resource template should be evaluated (low through high).

HTTP Entity Tag (ETag): Identifies the type of entity tag to be used by the resource template. An entity tag is an HTTP Header that acts as a version identifier for a resource. Use entity tag headers to avoid retrieving previously retrieved resources and to perform optimistic locking when updating resources. Options include: 

Secure HASH (default): The contents of the returned resource representation are hashed using a secure digest function to provide a unique fingerprint for a given resource version. 

Query: Manually define a query that uniquely identifies a resource version. A manually defined query can often generate an entity tag more efficiently than hashing the entire resource representation. 

None: Do not generate an entity tag.

Resource Handler
Specify the properties of the resource handler. The specific options depend on the method type. 

Method: HTTP request method for this handler: GET (retrieves a representation of a resource), POST (creates a new resource or adds a resource to a collection), PUT (updates an existing resource), or DELETE (deletes an existing resource). Only one handler for each HTTP method is permitted. 

Requires Secure Access: Indicates whether the resource should be accessed through a secure channel such as HTTPS. 

Source Type: Source implementation for the selected HTTP method: 

Feed: Executes a SQL query and transforms the results into a JSON Feed representation. Each item in the feed contains a summary of a resource and a hyperlink to a full representation of the resource. The first column in each row in the result set must be a unique identifier for the row and is used to form a hyperlink of the form: path/to/feed/{id}, with the value of the first column being used as the value for {id}. The other columns in the row are assumed to summarize the resource and are included in the feed. A separate resource template for the full representation of the resource should also be defined. Result Format: JSON 

Media Resource: Executes a SQL Query conforming to a specific format and turns the result set into a binary representation with an accompanying HTTP Content-Type header identifying the Internet media type of the representation. Result Format: Binary 

PL/SQL: Executes an anonymous PL/SQL block and transforms any OUT or IN/OUT parameters into a JSON representation. Available only when the HTTP method is DELETE, PUT, or POST. Result Format: JSON 

Query: Executes a SQL Query and transforms the result set into either a JavaScript Object Notation (JSON) or CSV representation, depending on the format selected. Available when the HTTP method is GET. Result Format: JSON or CSV 

Query One Row: Executes a SQL Query returning one row of data into a JSON representation. Available when the HTTP method is GET. Result Format: JSON 

Data Format (if the Source Type is Query Source): JSON or CSV. 

Pagination Size (GET handler): Default pagination size for the modules resource templates: size of the pagination window, or the number of rows to return for a database query. 


Define the query for the GET resource handler.

Expand the test node under the Modules node in the REST Development view.

Expand the /prdmstee/ node, right-click the GET node, and select Open.

In the SQL Worksheet that opens for GET /prdmstee/, enter the following SQL query:

select * from prdmstee
Right-click on the test node under the 'Modules' node in the 'REST Development' view

Click 'Upload...'. A confirmation dialog will appear confirming the module has been uploaded.

Now you can test >> http://localhost/ords/cmser/test/prdmstee/

http://docs.oracle.com/cd/E56351_01/doc.30/e56293/get_started.htm#AELIG90198

Create a privilege. In SQL Developer, right-click the Privileges node in the REST Development view and select New Privileges to display the Edit Privilege dialog box:

Name: test
Title: Example Privilege
Description: Demonstrate controlling access with privileges
Protected Modules: Ensure that the list includes the test module. Use the arrow button to move it if necessary.
Click Apply.

Right click the test privilege and click Upload.
A dialog box confirms that the privilege has been uploaded.

http://localhost/ords/cmser/sign-in/?r=test%2Fprdmstee%2F
enter user id = test_developer and password same.

http://localhost/ords/cmser/oauth/clients/

click on new clients

Name: Test Client
Description: An example OAuth Client
Redirect URI: http://example.org/redirect
Support e-mail: info@example.org
Support URI: http://example.org/support
Required Privileges: Example Privilege

http://localhost/ords/cmser/oauth/auth?response_type=token&client_id=pgLhmN48Ck0YBH-3IXgvXA..&state=_replace_with_a_unique_value_

----
begin
 ords.create_service(
      p_module_name => 'examples.routes' ,
      p_base_path   => '/examples/routes/',
      p_pattern     => 'greeting/:name',
      p_source => 'select ''Hello '' || :name || '' from '' || nvl(:whom,sys_context(''USERENV'',''CURRENT_USER'')) "greeting" from dual');
 commit;
end;
/

http://localhost/ords/cmser/examples/routes/greeting/Joe

http://localhost/ords/cmser/examples/routes/greeting/Joe?whom=Jane

begin
 ords.create_service(
      p_module_name => 'orgctlee.routes' ,
      p_base_path   => '/orgctlee/routes/',
      p_pattern     => '.',
      p_source => 'select * from orgctlee');
 commit;
end;
/

begin
ords.create_service(
      p_module_name => 'examples.employees' ,
      p_base_path  => '/examples/employees/',
      p_pattern =>  '.' ,
      p_items_per_page => 7,
      p_source  =>  'select * from emp order by empno desc');
commit;
end;

DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    ORDS.ENABLE_SCHEMA(p_enabled => FALSE);
    ORDS.drop_rest_for_schema();
    commit;
END;


ORDS.DEFINE_SERVICE(
   p_module_name VARCHAR2(255) IN,
   p_base_path   VARCHAR2(255) IN,
   p_pattern     VARCHAR2(600) IN,
   p_method      VARCHAR2(10) IN DEFAULT 'GET',
   p_source_type VARCHAR2(30) IN DEFAULT ords.source_type_collection_feed,
   p_source      CLOB IN,
   p_items_per_page  INTEGER IN DEFAULT 25,
   p_status          VARCHAR2(30) IN DEFAULT 'PUBLISHED',
   p_etag_type       VARCHAR2(30) IN DEFAULT 'HASH',
   p_etag_query      VARCHAR2(4000) IN DEFAULT NULL ,
   p_mimes_allowed   VARCHAR2(255) IN DEFAULT NULL ,
   p_module_comments   VARCHAR2(4000) IN DEFAULT NULL,
   p_template_comments VARCHAR2(4000) IN DEFAULT NULL,
   p_handler_comments  VARCHAR2(4000) IN DEFAULT NULL 
   );

DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_SCHEMA(p_enabled => FALSE,
                       p_schema => 'CMSER',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'cmser',
                       p_auto_rest_auth => FALSE);
    
    COMMIT;

END;


DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_OBJECT(p_enabled => TRUE,
                       p_schema => 'CMSER',
                       p_object => 'PRDMSTEE',
                       p_object_type => 'TABLE',
                       p_object_alias => 'prdmstee',
                       p_auto_rest_auth => FALSE);
    
    COMMIT;

END;


begin
ORDS.DEFINE_SERVICE(
  p_module_name => 'orgctlee.routes' ,
  p_base_path   => '/orgctlee/routes/',
  p_pattern     => '.',
  p_source => 'select * from orgctlee'
   );
commit;
end;
/
   
BEGIN
    ORDS.DELETE_MODULE(
        p_module_name => 'orgctlee.routes'
        );
    COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    ROLLBACK;
    RAISE;
END;
/
   
   
http://localhost/ords/cmser/orgctlee/routes/

BEGIN
    ORDS.DEFINE_SERVICE(
      p_module_name => 'orgmstee' ,
      p_base_path   => '/orgmstee/',
      p_pattern     => '.',
      p_method =>'GET',
      p_source => 
            'select
                root_org_lvl_number,
                stor_name,
                stor_num,
                area_name,
                area_num,
                country_name,
                country_num,
                countrygroup_name,
                countrygroup_num,
                region_name,
                region_num,
                grp_name         
            from
            (
            select 
                connect_by_root org_lvl_number as root_org_lvl_number,
                org_lvl_number, 
                org_name_full, 
                org_lvl_id 
            from orgmstee
            where connect_by_root org_lvl_id=1
            start with org_lvl_id=1
            connect by prior org_lvl_parent=org_lvl_child
            )
            pivot( 
                max(org_name_full) name,
                max(org_lvl_number) num
                    for org_lvl_id in 
                    (
              1 stor                                                   
                    ,2	area                                                        
                    ,3	country                                                     
                    ,4	countrygroup                                               
                    ,5	region                                          
                    ,6	grp                                                  
                    )
            )
            order by 1',
       p_items_per_page => 10
       );
    COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    ROLLBACK;
    RAISE;
END;
/



http://localhost/ords/cmser/orgmstee/

http://localhost/ords/cmser/orgmstee/?offset=25

curl -i http://localhost/ords/cmser/orgmstee/

curl GET http://localhost/ords/cmser/orgmstee/metadata-catalog/

curl -i http://localhost/ords/cmser/metadata-catalog/orgmstee/


LIst of all srvices >> http://localhost/ords/cmser/metadata-catalog/

Get Table Data Using Paging >> http://localhost/ords/cmser/orgmstee/?offset=25&limit=5

Get Table Data Using Query >> http://localhost/ords/cmser/orgmstee/?q={"root_org_lvl_number":{"$lte":2}}

http://localhost/ords/cmser/orgmstee/?q={"stor_num":{"$lte":2}}

Get Table Row Using Primary Key>>  http://localhost/ords/cmser/orgmstee/root_org_lvl_number/1

https://docs.oracle.com/cd/E56351_01/doc.30/e56293/ords_ref.htm#AELIG90214


https://docs.oracle.com/cd/E56351_01/doc.30/e56293/develop.htm#AELIG90132


BEGIN
    ORDS.DEFINE_SERVICE(
      p_module_name => 'keytab' ,
      p_base_path   => '/keytab/',
      p_pattern     => '.',
      p_method =>'GET',
      p_source => 'select * from key_tab',
       p_items_per_page => 10
       );
    COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    ROLLBACK;
    RAISE;
END;
/

http://localhost/ords/cmser/keytab/

curl -i http://localhost/ords/cmser/keytab/

http://localhost/ords/cmser/key_tab/1/

curl PUT http://localhost/ords/cmser/keytab/1
Content-Type: application/json
 
{"key_id":1,"key_val":"1_val","key_desc":"1_desc"}

BEGIN
    ORDS.DEFINE_SERVICE(
      p_module_name => 'keytab' ,
      p_base_path   => '/keytab/',
      p_pattern     => '.',
      p_method =>'GET',
      p_source => 'select * from key_tab',
       p_items_per_page => 10
       );
    COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    ROLLBACK;
    RAISE;
END;
/

The DEFINE_SERVICE procedure allows you to create a new module, template and handler in a single step. If the module already exists, its replaced by the new definition.

The basic makeup of an ORDS RESTful web service is as follows.

Module : A container for one or more templates, with an associated path (testmodule1/).
Template : A container for one or more handlers. The template must be unique within the module and is associated with a specific path (emp/), which may or may not include parameters.
Handler : A link to the actual work that is done. Typical handler methods include GET, POST, PUT, DELETE, which are passed in the HTTP header, rather than the URL. Each handler is associated with a specific source (or action), which can be of several types.

Base ORDS URL : http://ol7-121.localdomain:8080/ords/pdb1/
Schema (alias): http://ol7-121.localdomain:8080/ords/pdb1/testuser1/
Module        : http://ol7-121.localdomain:8080/ords/pdb1/testuser1/testmodule1/
Template      : http://ol7-121.localdomain:8080/ords/pdb1/testuser1/testmodule1/emp/


Rather than using the DEFINE_SERVICE procedure, we can build the same web service manually using the DEFINE_MODULE, DEFINE_TEMPLATE and DEFINE_HANDLER procedures. The following code creates a similar web service to that defined previously, but this time defining all the pieces manually.

BEGIN
  ORDS.define_module(
    p_module_name    => 'testmodule2',
    p_base_path      => 'testmodule2/',
    p_items_per_page => 0);
  
  ORDS.define_template(
   p_module_name    => 'testmodule2',
   p_pattern        => 'emp/');

  ORDS.define_handler(
    p_module_name    => 'testmodule2',
    p_pattern        => 'emp/',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_query,
    p_source         => 'SELECT * FROM emp',
    p_items_per_page => 0);
    
  COMMIT;
END;
/

Multiple Templates

The following code creates a web service with two templates, one of which uses a parameter to return a single record. Notice the parameter is used in the associated query to limit the results returned.

BEGIN
  ORDS.define_module(
    p_module_name    => 'testmodule3',
    p_base_path      => 'testmodule3/',
    p_items_per_page => 0);
  
  ORDS.define_template(
   p_module_name    => 'testmodule3',
   p_pattern        => 'emp/');

  ORDS.define_handler(
    p_module_name    => 'testmodule3',
    p_pattern        => 'emp/',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_query,
    p_source         => 'SELECT * FROM emp',
    p_items_per_page => 0);
    
  ORDS.define_template(
   p_module_name    => 'testmodule3',
   p_pattern        => 'emp/:empno');

  ORDS.define_handler(
    p_module_name    => 'testmodule3',
    p_pattern        => 'emp/:empno',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_query,
    p_source         => 'SELECT * FROM emp WHERE empno = :empno',
    p_items_per_page => 0);
    
  COMMIT;
END;
/

Stored Procedure (JSON)

The previous examples use handlers associated with queries, but they can be associated with stored procedures if required. To show this, create the following procedure, which uses the APEX_JSON package to generate the JSON results.

apocalypse

------------


DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                       p_schema => 'CMS',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'cms',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;
/

BEGIN
    ORDS.DEFINE_SERVICE(
      p_module_name => 'orgmodule' ,
      p_base_path   => '/orgmodule/',
      p_pattern     => 'orgmstee/',
      p_method =>'GET',
      p_source => 'select * from orgmstee',
       p_items_per_page => 10
       );
    COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    ROLLBACK;
    RAISE;
END;
/


List all Orgs (Using SQL)
http://wwisdlap002/ords/cms/orgmodule/orgmstee/

List all Orgs - CSV (Using SQL)
http://wwisdlap002/ords/cms/orgmodule/orgmstee-csv.csv/

Country wise stores list (Using SQL)
http://wwisdlap002/ords/cms/orgmodule/liststore/SINGAPORE

(Note: Last part of the url is country name e.g IRELAND, TURKEY, QATAR, RUSSIA
http://wwisdlap002/ords/cms/orgmodule/liststore/QATAR
)

Countrywise stores list (using PLSQL procedure(cursor))
http://wwisdlap002/ords/cms/orgmodule/storecursor/SINGAPORE


Update Existing org - PUT (Needs cURL or "Advanced REST client" for testing)
URL        : http://wwisdlap002/ords/cms/orgmodule/update-orgmstee/
Method     : PUT
Header     : Content-Type: application/json
Raw Payload: {"org_lvl_child":452,"org_lvl_parent":858,"org_lvl_id":1,"org_name_full":"DOHA VILLAGIO MALL-NEW","org_name_short":"DOHA","org_lvl_number":325,"curr_code":"GBP      ","org_is_store":"T  ","web_store_ind":"F"}


Delete existing org - PUT (Needs cURL or "Advanced REST client" for testing)
Delete Test
URL        : http://wwisdlap002/ords/cms/orgmodule/delete-orgmstee/
Method     : DELETE
Header     : Content-Type: application/json
Raw Payload: {"org_lvl_child": 482}



New Templates

select * from dba_tables where table_name='APEX_WORKSPACE_ACCESS_LOG'

The following code creates a web service with two templates, one of which uses a parameter to return a single record. Notice the parameter is used in the associated query to limit the results returned.

set serveroutput on;
BEGIN
   
  ORDS.define_template(
   p_module_name    => 'orgmodule',
   p_pattern        => 'liststore/:CountryName');

  ORDS.define_handler(
    p_module_name    => 'orgmodule',
    p_pattern        => 'liststore/:CountryName',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_query,
    p_source         => 'select * from orgmstee 
                        where org_lvl_id=1
                        start with org_lvl_child in
                        (select org_lvl_child from orgmstee 
                        where org_lvl_id=3 
                        and org_name_full=upper(:CountryName))
                        connect by prior org_lvl_child = org_lvl_parent',
    p_items_per_page => 0);
    
    
  COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    ROLLBACK;
    RAISE;
END;
/


BEGIN
    ORDS.DELETE_MODULE(
        p_module_name => 'orgmodule'
        );
    COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    ROLLBACK;
    RAISE;
END;
/

CREATE OR REPLACE PROCEDURE get_store_json (i_org_name IN orgmstee.org_name_full%TYPE DEFAULT NULL) AS
  l_cursor SYS_REFCURSOR;
BEGIN
  
  INSERT INTO REST_ORG_ACCESS_LOG
    (user_name,access_date)
  VALUES (user,sysdate);
  
    COMMIT;
    
    OPEN l_cursor FOR
        select * from orgmstee 
        where org_lvl_id=1
        start with org_lvl_child in
        (select org_lvl_child from orgmstee 
        where org_lvl_id=3 
        and org_name_full=upper(i_org_name))
        connect by prior org_lvl_child = org_lvl_parent;
        
  APEX_JSON.open_object;
  APEX_JSON.write('STORES', l_cursor);
  APEX_JSON.close_object;
END;
/

BEGIN
   
  ORDS.define_template(
    p_module_name    => 'orgmodule',
    p_pattern        => 'storecursor/:CountryName');
   
  ORDS.define_handler(
   p_module_name    => 'orgmodule',
   p_pattern        => 'storecursor/:CountryName',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_plsql,
    p_source         => 'BEGIN get_store_json(:CountryName); END;',
    p_items_per_page => 0);
    
  COMMIT;
END;
/


BEGIN
    ORDS.DEFINE_SERVICE(
      p_module_name => 'orgmodule' ,
      p_base_path   => '/orgmodule/',
      p_pattern     => 'orgmstee-csv.csv/',
      p_method =>'GET',
      p_source_type => ORDS.source_type_csv_query,
      p_source => 'select * from orgmstee',
       p_items_per_page => 10
       );
    COMMIT;
EXCEPTION
WHEN OTHERS THEN 
    ROLLBACK;
    RAISE;
END;
/

CREATE OR REPLACE PROCEDURE update_orgmstee (
    i_org_lvl_child               orgmstee.org_lvl_child%TYPE,
    i_org_lvl_parent              orgmstee.org_lvl_parent%TYPE,
    i_org_lvl_id                  orgmstee.org_lvl_id%TYPE,
    i_org_name_full               orgmstee.org_name_full%TYPE,
    i_org_name_short              orgmstee.org_name_short%TYPE,
    i_org_lvl_number              orgmstee.org_lvl_number%TYPE,
    i_curr_code                   orgmstee.curr_code%TYPE,
    i_org_is_store                orgmstee.org_is_store%TYPE,
    i_web_store_ind               orgmstee.web_store_ind%TYPE
)
AS
BEGIN
    UPDATE orgmstee
    SET 
        org_lvl_parent     =  i_org_lvl_parent,
        org_lvl_id         =  i_org_lvl_id,
        org_name_full      =  i_org_name_full,
        org_name_short     =  i_org_name_short,
        org_lvl_number     =  i_org_lvl_number,
        curr_code          =  i_curr_code,
        org_is_store       =  i_org_is_store,
        web_store_ind      =  i_web_store_ind 
    WHERE   org_lvl_child =  i_org_lvl_child; 
EXCEPTION
  WHEN OTHERS THEN
    HTP.print(SQLERRM);
END;
/

BEGIN
  ORDS.define_template(
   p_module_name    => 'orgmodule',
   p_pattern        => 'update-orgmstee/');

  ORDS.define_handler(
    p_module_name    => 'orgmodule',
    p_pattern        => 'update-orgmstee/',
    p_method         => 'PUT',
    p_source_type    => ORDS.source_type_plsql,
    p_source         => 'BEGIN
                           update_orgmstee (
                            i_org_lvl_child               =>  :org_lvl_child,
                            i_org_lvl_parent              =>  :org_lvl_parent,
                            i_org_lvl_id                  =>  :org_lvl_id,
                            i_org_name_full               =>  :org_name_full,
                            i_org_name_short              =>  :org_name_short,
                            i_org_lvl_number              =>  :org_lvl_number,
                            i_curr_code                   =>  :curr_code,
                            i_org_is_store                =>  :org_is_store,
                            i_web_store_ind               =>  :web_store_ind
                        );
                         END;',
    p_items_per_page => 0);

  COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE delete_orgmstee (
    i_org_lvl_child  IN   orgmstee.org_lvl_child%TYPE
)
AS
BEGIN
  DELETE FROM orgmstee
  WHERE org_lvl_child = i_org_lvl_child;
EXCEPTION
  WHEN OTHERS THEN
    HTP.print(SQLERRM);
END;
/

BEGIN

  ORDS.define_template(
   p_module_name    => 'orgmodule',
   p_pattern        => 'delete-orgmstee/');

  ORDS.define_handler(
    p_module_name    => 'orgmodule',
    p_pattern        => 'delete-orgmstee/',
    p_method         => 'DELETE',
    p_source_type    => ORDS.source_type_plsql,
    p_source         => 'BEGIN
                           delete_orgmstee(i_org_lvl_child => :org_lvl_child);
                         END;',
    p_items_per_page => 0);

  COMMIT;
END;
/

http://wwisdlap002/ords/cms/orgmodule/storecursor/SINGAPORE

http://wwisdlap002/ords/cms/orgmodule/liststore/SINGAPORE

Delete Test
URL        : http://wwisdlap002/ords/cms/orgmodule/delete-orgmstee/
Method     : DELETE
Header     : Content-Type: application/json
Raw Payload: {"org_lvl_child": 482}


Update Test
URL        : http://wwisdlap002/ords/cms/orgmodule/update-orgmstee/
Method     : PUT
Header     : Content-Type: application/json
Raw Payload: {"org_lvl_child":452,"org_lvl_parent":858,"org_lvl_id":1,"org_name_full":"DOHA VILLAGIO MALL-NEW","org_name_short":"DOHA","org_lvl_number":325,"curr_code":"GBP      ","org_is_store":"T  ","web_store_ind":"F"}

$ curl -i -X PUT --data-binary @/tmp/update-payload.json -H "Content-Type: application/json" http://ol7-121.localdomain:8080/ords/pdb1/testuser1/testmodule7/emp/

chrome://apps/ >> arc

JASON Formater Add-on
For Google Chrome: JSON Formatter (https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa)
For Mozilla Firefox: JSON View (https://addons.mozilla.org/en-US/firefox/addon/jsonview/)

Advanced REST client Add-on
For Google Chrome: Advanced REST client (https://chrome.google.com/webstore/detail/advanced-rest-client/hgmloofddffdnphfgcellkdfbfbjeloo)
For Mozilla Firefox: RESTClient, a debugger for RESTful web services https://addons.mozilla.org/en-GB/firefox/addon/restclient/


--- APEX_JASON Package Overview and Examples

This example parses a JSON string and prints the value of member variable "a".

DECLARE
    s varchar2(32767) := '{ "a": 1, "b": ["hello", "world"]}';
BEGIN
    apex_json.parse(s);
    sys.dbms_output.put_line('a is '||apex_json.get_varchar2(p_path => 'a'));
END;
/

This example converts a JSON string to XML and uses XMLTABLE to query member values.

select col1, col2
from xmltable (
        '/json/row'
        passing apex_json.to_xmltype('[{"col1": 1, "col2": "hello"},'||
                '{"col1": 2, "col2": "world"}]')
        columns
           col1 number path '/row/col1',
           col2 varchar2(5) path '/row/col2' );
           
This example writes a nested JSON object to the HTP buffer.

BEGIN
    apex_json.open_object;        -- {
    apex_json.write('a', 1);    --   "a":1
    apex_json.open_array('b');  --  ,"b":[
    apex_json.open_object;    --    {
    apex_json.write('c',2); --      "c":2
    apex_json.close_object;   --    }
    apex_json.write('hello'); --   ,"hello"
    apex_json.write('world'); --   ,"world"
    apex_json.close_all;          --  ]
                          -- }
END;

CLOSE_ALL Procedure : This procedure closes all objects and arrays up to the outermost nesting level.
APEX_JSON.CLOSE_ALL;

CLOSE_ARRAY Procedure : This procedure writes a close bracket symbol as: ]
APEX_JSON.CLOSE_ARRAY ();

CLOSE_OBJECT Procedure : This procedure writes a close curly bracket symbol as : }

DOES_EXIST Function : This function determines whether the given path points to an existing value.

Syntax
APEX_JSON.DOES_EXIST (
   p_path             IN VARCHAR2,
   p0                 IN VARCHAR2 DEFAULT NULL,
   p1                 IN VARCHAR2 DEFAULT NULL,
   p2                 IN VARCHAR2 DEFAULT NULL,
   p3                 IN VARCHAR2 DEFAULT NULL,
   p4                 IN VARCHAR2 DEFAULT NULL,
   p_values           IN t_values DEFAULT g_values ) 
RETURN BOOLEAN;

This example parses a JSON string and prints whether it contains values under a path.

DECLARE 
    j apex_json.t_values; 
BEGIN 
    apex_json.parse(j, '{ "items": [ 1, 2, { "foo": true } ] }'); 
    if apex_json.does_exist(p_path => 'items[%d].foo', p0 => 3, p_values => j) then 
        dbms_output.put_line('found items[3].foo'); 
    end if; 
    if not apex_json.does_exist(p_path => 'items[%d].foo_new', p0 => 3, p_values => j) then 
        dbms_output.put_line('Not found items[3].foo_new'); 
    end if;
END;
/

FIND_PATHS_LIKE Function : This function returns paths into p_values that match a given pattern.

APEX_JSON.FIND_PATHS_LIKE (
    p_return_path      IN VARCHAR2,
    p_subpath          IN VARCHAR2 DEFAULT NULL,
    p_value            IN VARCHAR2 DEFAULT NULL,
    p_values           IN t_values DEFAULT g_values )
RETURN wwv_flow_t_varchar2;

This example parses a JSON string, finds paths that match a pattern, and prints the values under the paths.

DECLARE
    j            apex_json.t_values;
    l_paths      apex_t_varchar2;
BEGIN
    apex_json.parse(j, '{ "items": [ { "name": "Amulet of Yendor", "magical": true }, '||
                                     '{ "name": "Slippers",  "magical": "rather not" } ]}');
    l_paths := apex_json.find_paths_like (
        p_values         => j,
        p_return_path => 'items[%]',
        p_subpath       => '.magical',
        p_value           => 'true' );
    dbms_output.put_line('Magical items:');
    for i in 1 .. l_paths.count loop
        dbms_output.put_line(apex_json.get_varchar2(p_values => j, p_path => l_paths(i)||'.name')); 
    end loop;
END;
/


Configuring Secure Access to RESTful Services

RESTful APIs consist of resources, each resource having a unique URI. A set of resources can be protected by a privilege. A privilege defines the set of roles, at least one of which an authenticated user must possess to access a resource protected by a privilege.

Configuring a resource to be protected by a particular privilege requires creating a privilege mapping. A privilege mapping defines a set of patterns that identifies the resources that a privilege protects.

A first party is the author of a RESTful API. A first party application is a web application deployed on the same web origin as the RESTful API.

A third party is any party other than the author of a RESTful API. A third party application cannot be trusted in the same way as a first party application; therefore, there must be a mediated means to selectively grant the third party application limited access to the RESTful API.

The OAuth 2.0 protocol (https://tools.ietf.org/html/rfc6749) defines flows to provide conditional and limited access to a RESTful API. In short, the third party application must first be registered with the first party, and then the first party (or an end user of the first party RESTful service) approves the third party application for limited access to the RESTful API, by issuing the third party application a short-lived access token.

Two-legged OAuth flows involve two parties: the party calling the RESTful API (the third party application), and the party providing the RESTful API. Two-legged flows are used in server to server interactions where an end user does not need to approve access to the RESTful API. In OAuth 2.0 this flow is called the client credentials flow. It is most typically used in business to business scenarios.

Three-legged OAuth flows involve three parties: the party calling the RESTful API, the party providing the RESTful API, and an end user party that owns or manages the data to which the RESTful API provides access. Three-legged flows are used in client to server interactions where an end user must approve access to the RESTful API. In OAuth 2.0 the authorization code flow and the implicit flow are three-legged flows. These flows are typically used in business to consumer scenarios.

Create a privilege. While connected to the ORDSTEST schema, execute the following PL/SQL statements:

begin
  ords.create_role('HR Administrator');     
 
  ords.create_privilege(
      p_name => 'example.employees',
      p_role_name => 'HR Administrator',
      p_label => 'Employee Data',
      p_description => 'Provide access to employee HR data');
  commit;
end;
/

select id,name from user_ords_privileges where name = 'example.employees';

Associate the privilege with resources. While connected to the ORDSTEST schema, execute the following PL/SQL statements:

begin
 ords.create_privilege_mapping(
      p_privilege_name => 'example.employees',
      p_pattern => '/examples/employees/*');     
  commit;
end;
/

select privilege_id, name, pattern from user_ords_privilege_mappings;

Register the OAuth client. While connected to the ORDSTEST schema, execute the following PL/SQL statements:

begin 
 oauth.create_client(
      p_name => 'Client Credentials Example',
      p_grant_type => 'client_credentials',
      p_privilege_names => 'example.employees',
      p_support_email => 'support@example.com');
 commit;
end;
/

select client_id,client_secret from user_ords_clients where name = 'Client Credentials Example';

Grant the OAuth client a required role. While connected to the ORDSTEST schema, execute the following PL/SQL statements:

begin 
 oauth.grant_client_role(
     'Client Credentials Example',
     'HR Administrator');
 commit;
end;
/

select * from user_ords_client_roles where client_name = 'Client Credentials Example';

------------- ORDS PACKAGE specification

ORDS.DEFINE_MODULE(
   p_module_name    VARCHAR2(255) IN,
   p_base_path      VARCHAR2(255) IN,
   p_items_per_page NUMBER(0) IN DEFAULT 25,
   p_status         VARCHAR2(30) IN DEFAULT 'PUBLISHED',
   p_comments       VARCHAR2(4000) IN DEFAULT NULL );
   
ORDS.DELETE_MODULE(p_module_name  VARCHAR2(255) IN);

ORDS.DELETE_PRIVILEGE(p_name  VARCHAR2(255) IN);

ORDS.DELETE_ROLE(p_role_name  VARCHAR2(255) IN);

ORDS.DROP_REST_FOR_SCHEMA(p_schema  VARCHAR2(30) IN);

These operations needs commit;
Dropping rest for a schema is going to drop all module/templates/services under that schema.



ORDS.RENAME_MODULE(
   p_module_name    VARCHAR2(255) IN,
   p_new_name       VARCHAR2(255) IN DEFAULT NULL,
   p_base_path      VARCHAR2(255) IN DEFEULT NULL);
   
--
-- Enable the main Schema CMSER
--
BEGIN
ORDS.DROP_REST_FOR_SCHEMA('CMSER');
END;
/

DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                       p_schema => 'CMSER',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'cmsdev',
                       p_auto_rest_auth => FALSE);
    
    commit;

END;
/

What’s happening under the covers
When you call ords.enable_schema, a few things happen:

The schema is configured so that ords_public_user can proxy to the schema. In the above example the following alter user command is issued:

alter user cmser grant connect through ords_public_user;

A ‘base path’ url mapping is created that maps the schema to the lowercase form of it’s name. In the above example, assuming ORDS is listening on http://localhost:8080/ords/, then resources in the ordstest schema can be accessed under:

http://localhost/ords/cmsdemo/orgmodule


BEGIN
    /*ORDS.DEFINE_SERVICE(
        p_module_name => 'orgmodule' ,
        p_base_path   => '/orgmodule/',
        p_pattern     => 'orgmstee/',
        p_method =>'GET',
        p_source => 'select * from orgmstee',
        p_items_per_page => 10
        );
        */
        --
        -- define service create a module, a template and a handler in a single call
        --
    ORDS.DEFINE_MODULE(
       p_module_name    => 'orgmodule',
       p_base_path      => '/orgmodule/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'Test Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'orgmodule',
        p_pattern        => 'liststore/:CountryName');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'orgmodule',
        p_pattern        => 'liststore/:CountryName',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 
                        'select * from orgmstee 
                        where org_lvl_id=1
                        start with org_lvl_child in
                        (select org_lvl_child from orgmstee 
                        where org_lvl_id=3 
                        and org_name_full=upper(:CountryName))
                        connect by prior org_lvl_child = org_lvl_parent',
        p_items_per_page => 0);
END;
/

BEGIN
ORDS.DELETE_MODULE('TicketReport');
END;
/


BEGIN
ORDS.DROP_REST_FOR_SCHEMA('CMSER');
END;
/

---  Authentication

ORDS Roles and Privileges

To protect the web service, we need to create a role with an associated privilege, then map the privilege to the web service. Normally, we would expect a role to be a collection of privileges, and of course a single privilege can be part of multiple roles, but in this case we will keep it simple. The following code creates a new role called "emp_role".

BEGIN
  ORDS.create_role(
    p_role_name => 'emp_role'
  );
  
  COMMIT;
END;
/

create a new privilege called "emp_priv", which is associated with the role

DECLARE
  l_arr OWA.vc_arr;
BEGIN
  l_arr(1) := 'emp_role';
  
  ORDS.define_privilege (
    p_privilege_name => 'emp_priv',
    p_roles          => l_arr,
    p_label          => 'EMP Data',
    p_description    => 'Allow access to the EMP data.'
  );
   
  COMMIT;
END;
/

To protect the web service, we associate the privilege directly to a URL pattern.

BEGIN
  ORDS.create_privilege_mapping(
    p_privilege_name => 'emp_priv',
    p_pattern => '/testmodule1/emp/*'
  );     

  COMMIT;
END;
/

select * from user_ords_privilege_mappings;

--Once this mapping is in place, we can no longer access the web service without authentication. At this point we have not defined how we should authenticate, only that authentication is needed to access this resource.

--
-- First-Party Authentication
First-Party Authentication (Basic Authentication) : If you have to support basic authentication, it is possible by creating users on the ORDS server.

Create a new ORDS user called "emp_user" with access to the "emp_role" role.  
$JAVA_HOME/bin/java -jar ords.war user emp_user emp_role

Access the web service from a browser using the following URL.

You are presented with a 401 message, which includes a "sign in" link. Click the link, sign in with the ORDS credentials you just created and you will be directed to web service output.

Alternatively, specify the credentials in a "curl" command.

$ curl -i -k --user emp_user:Password1 https://ol7-121.localdomain:8443/ords/pdb1/testuser1/testmodule1/emp/7788

OAuth 2 revolves around registering clients, which represent a person or an application wanting to access the resource, then associating those clients to roles. Once the client is authenticated, it has access to the protected resources associated with the roles.

To protect the web service, we need to create a role with an associated privilege, then map the privilege to the web service. Normally, we would expect a role to be a collection of privileges, and of course a single privilege can be part of multiple roles, but in this case we will keep it simple. The following code creates a new role called "emp_role".

OAuth 2 : Client Credentials

The client credentials flow is a two-legged process that seems the most natural to me as I mostly deal with server-server communication, which should have no human interaction. For this flow we use the client credentials to return an access token, which is used to authenticate calls to protected resources. The example steps through the individual calls, but in reality it would be automated by the application

BEGIN
  OAUTH.create_client(
    p_name            => 'Emp Client',
    p_grant_type      => 'client_credentials',
    p_owner           => 'My Company Limited',
    p_description     => 'A client for Emp management',
    p_support_email   => 'tim@example.com',
    p_privilege_names => 'emp_priv'
  );

  COMMIT;
END;
/

SELECT id, name, client_id, client_secret FROM   user_ords_clients;

-- Display client-privilege relationship.
SELECT name, client_name FROM  user_ords_client_privileges;

Associate the client with the role that holds the correct privileges for the resources it needs to access.

BEGIN
  OAUTH.grant_client_role(
    p_client_name => 'Emp Client',
    p_role_name   => 'emp_role'
  );

  COMMIT;
END;
/

SELECT client_name, role_name FROM  user_ords_client_roles;

In order to access the web service, we must first retrieve an access token using the CLIENT_ID and CLIENT_SECRET we queried from the USER_ORDS_CLIENTS view.

CLIENT_ID     : 3NvJRo_a0UwGKx7Q-kivtA..
CLIENT_SECRET : F5WVwyrWxXj3ykmhSONldQ..
OAUTH URL     : https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/token

$ curl -i -k --user 3NvJRo_a0UwGKx7Q-kivtA..:F5WVwyrWxXj3ykmhSONldQ.. --data "grant_type=client_credentials" https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/token

{"access_token":"-zYl-sFyB2iLicAHw2TsRA..","token_type":"bearer","expires_in":3600}

We can now use the access token to call our web service. Notice the "Authorization: Bearer {access-token}" entry in the header of the call.

$ curl -i -k -H"Authorization: Bearer -zYl-sFyB2iLicAHw2TsRA.." https://ol7-121.localdomain:8443/ords/pdb1/testuser1/testmodule1/emp/7788

{"items":[{"empno":7788,"ename":"SCOTT","job":"ANALYST","mgr":7566,"hiredate":"1987-04-18T23:00:00Z","sal":3000,"comm":null,"deptno":20}]}

--
-- OAuth 2 : Authorization Code
OAuth 2 : Authorization Code

The authorization code flow is a three-legged process. The user accesses a URL in a browser, which prompts for credentials. Once authenticated, the browser is redirected to a specified page with an authhorization code as one of the parameters in the URL. That authorization code is used in a call to generate an access token, which is used to authenticate calls to protected resources. With the exception of the user confirmation, all the other steps in the flow should be handled by the application.

Create a client using the grant type of "authorization_code". The redirect and support URLs are not real, but we will be able to follow the example through anyway.

BEGIN
  OAUTH.create_client(
    p_name            => 'Emp Client',
    p_grant_type      => 'authorization_code',
    p_owner           => 'My Company Limited',
    p_description     => 'A client for Emp management',
    p_redirect_uri    => 'https://ol7-121.localdomain:8443/ords/pdb1/testuser1/redirect',
    p_support_email   => 'tim@example.com',
    p_support_uri     => 'https://ol7-121.localdomain:8443/ords/pdb1/testuser1/support',
    p_privilege_names => 'emp_priv'
  );

  COMMIT;
END;
/

SELECT id, name, client_id, client_secret FROM user_ords_clients;

Associate the client with the role that holds the correct privileges for the resources it needs to access.

BEGIN
  OAUTH.grant_client_role(
    p_client_name => 'Emp Client',
    p_role_name   => 'emp_role'
  );

  COMMIT;
END;
/

SELECT client_name, role_name FROM   user_ords_client_roles;

We then attempt to request an authorization code. Notice we are using the CLIENT_ID from the USER_ORDS_CLIENTS view along with a unique string that will represent the state.

CLIENT_ID     : gxqNSyxPbLUJhSj1yBe8qA..
State         : 3668D7A713E93372E0406A38A8C02171
URL           : https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/auth?response_type=code&client_id={client_id}&state={state}

Access the following URL from a browser.

https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/auth?response_type=code&client_id=gxqNSyxPbLUJhSj1yBe8qA..&state=3668D7A713E93372E0406A38A8C02171
You are presented with a 401 message, which includes a "sign in" link. Click the link, sign in with the ORDS credentials you created ealier (emp_user) and you will be directed to an approval page. Click the "Approve" button, which will take you to the redirect page you specified for the client.

The redirect page we specified for the client doesnt really exist, but we can get the authorization code and state from the URL.

https://ol7-121.localdomain:8443/ords/pdb1/testuser1/redirect?code=FF-APuIMukuBlrver1XU2A..&state=3668D7A713E93372E0406A38A8C02171
The application should check the state string matches the one used in the initial call. We use the authorization code to retrieve the access token.

CLIENT_ID     : gxqNSyxPbLUJhSj1yBe8qA..
CLIENT_SECRET : E-_mKJBlOTfTdHc_zISniA..
User          : CLIENT_ID:CLIENT_SECRET
Data          : grant_type=authorization_code&code={authorization-code}
URL           : https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/token

The following call retrieves the access token.

$ curl -i -k --user gxqNSyxPbLUJhSj1yBe8qA..:E-_mKJBlOTfTdHc_zISniA.. --data "grant_type=authorization_code&code=FF-APuIMukuBlrver1XU2A.." https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/token
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
X-Frame-Options: SAMEORIGIN
Content-Type: application/json
Transfer-Encoding: chunked
Date: Wed, 29 Jun 2016 12:38:52 GMT

{"access_token":"cOYb2hFK_SyxOh8o9n6R7A..","token_type":"bearer","expires_in":3600,"refresh_token":"RC33rvSwAfhguraOWlvgfA.."}
$
We can now access the protected resource using the access token.

$ curl -i -k -H"Authorization: Bearer cOYb2hFK_SyxOh8o9n6R7A.." https://ol7-121.localdomain:8443/ords/pdb1/testuser1/testmodule1/emp/7788
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
ETag: "jtC17IXyetESUjSkxB2ani/a1TnFh28yfor+fLmxxUzGr6G9IFxQ77+/Gd71W4Qzz0rSxf90Qqbl+ICwezTayQ=="
Content-Type: application/json
Transfer-Encoding: chunked
Date: Wed, 29 Jun 2016 12:40:34 GMT

{"items":[{"empno":7788,"ename":"SCOTT","job":"ANALYST","mgr":7566,"hiredate":"1987-04-18T23:00:00Z","sal":3000,"comm":null,"deptno":20}]}
$

--
-- OAuth 2 : Implicit
OAuth 2 : Implicit
The implicit flow is a two-legged process that requires user interaction. The user accesses a URL in a browser, which prompts for credentials. Once authenticated, the browser is redirected to a specified page with an access token as one of the parameters in the URL. That access token is used to authenticate calls to protected resources.

Create a client using the grant type of "implicit". The redirect and support URLs are not real, but we will be able to follow the example through anyway.

BEGIN
  OAUTH.create_client(
    p_name            => 'Emp Client',
    p_grant_type      => 'implicit',
    p_owner           => 'My Company Limited',
    p_description     => 'A client for Emp management',
    p_redirect_uri    => 'https://ol7-121.localdomain:8443/ords/pdb1/testuser1/redirect',
    p_support_email   => 'tim@example.com',
    p_support_uri     => 'https://ol7-121.localdomain:8443/ords/pdb1/testuser1/support',
    p_privilege_names => 'emp_priv'
  );

  COMMIT;
END;
/

SELECT id, name, client_id, client_secret FROM   user_ords_clients;

Associate the client with the role that holds the correct privileges for the resources it needs to access.

BEGIN
  OAUTH.grant_client_role(
    p_client_name => 'Emp Client',
    p_role_name   => 'emp_role'
  );

  COMMIT;
END;
/

SELECT client_name, role_name FROM   user_ords_client_roles;

We then attempt to request an access token. Notice we are using the CLIENT_ID from the USER_ORDS_CLIENTS view along with a unique string that will represent the state.

CLIENT_ID     : 0docHbkL8__7Ic58n7GCBA..
State         : 3668D7A713E93372E0406A38A8C02171
URL           : https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/auth?response_type=code&client_id={client_id}&state={random-string}

Access the following URL from a browser.

https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/auth?response_type=token&client_id=0docHbkL8__7Ic58n7GCBA..&state=3668D7A713E93372E0406A38A8C02171

You are presented with a 401 message, which includes a "sign in" link. Click the link, sign in with the ORDS credentials you created ealier (emp_user) and you will be directed to an approval page. Click the "Approve" button, which will take you to the redirect page you specified for the client.

The redirect page we specified for the client doesnt really exist, but we can get the access token from the URL.

https://ol7-121.localdomain:8443/ords/pdb1/testuser1/redirect#token_type=bearer&access_token=5SVR_NVP5N_OnDQt6iSxJg..&expires_in=3600&state=3668D7A713E93372E0406A38A8C02171

The application should check the state string matches the one used in the initial call. We can now access the protected resource using the access token.

$ curl -i -k -H"Authorization: Bearer 5SVR_NVP5N_OnDQt6iSxJg.." https://ol7-121.localdomain:8443/ords/pdb1/testuser1/testmodule1/emp/7788

{"items":[{"empno":7788,"ename":"SCOTT","job":"ANALYST","mgr":7566,"hiredate":"1987-04-18T23:00:00Z","sal":3000,"comm":null,"deptno":20}]}


getting the IP address of the client consuming rest web services
OWA_UTIL.GET_CGI_ENV ('REMOTE_ADDR')



BEGIN
    ORDS.DEFINE_MODULE(
       p_module_name    => 'TestPriv',
       p_base_path      => 'prdctlee/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'Test Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'TestPriv',
        p_pattern        => '.');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'TestPriv',
        p_pattern        => '.',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from PRDCTLEE'
    );
END;
/

commit;

http://localhost/ords/cmser/prdctlee

BEGIN
  ORDS.delete_privilege_mapping(
    p_privilege_name => 'prd_priv',
    p_pattern => '/prdctlee/*'
  );     

  COMMIT;
END;
/

BEGIN
  ORDS.delete_privilege(
   p_name => 'prd_priv'
  );
  
  COMMIT;
END;
/

BEGIN
  ORDS.delete_role(
    p_role_name => 'prd_role'
  );
  
  COMMIT;
END;
/

BEGIN
  ORDS.create_role(
    p_role_name => 'prd_role_temp'
  );
  
  COMMIT;
END;
/

-- java -jar ords.war user prd_user prd_role_temp

/*

Enter a password for user prd_user: prd_user
Confirm password for user prd_user: prd_user
Oct 17, 2016 2:36:32 PM oracle.dbtools.standalone.ModifyUser execute
INFO: Created user: prd_user in file: C:\Saroj\Software\ords.3.0.4.60.12.48\config\ords\credentials

*/
BEGIN
  ORDS.create_role(
    p_role_name => 'prd_role'
  );
  
  COMMIT;
END;
/

DECLARE
  l_arr OWA.vc_arr;
BEGIN
  l_arr(1) := 'prd_role';
  l_arr(2) := 'prd_role_temp';
  
  ORDS.define_privilege (
    p_privilege_name => 'prd_priv',
    p_roles          => l_arr,
    p_label          => 'PRD Data',
    p_description    => 'Allow access to the PRDCTLEE data.'
  );
   
  COMMIT;
END;
/



BEGIN
  ORDS.create_privilege_mapping(
    p_privilege_name => 'prd_priv',
    p_pattern => '/prdctlee/*' -- missing first back slash is not going to work.
  );     

  COMMIT;
END;
/

select * from user_ords_roles WHERE  name = 'prd_role';

SELECT * FROM user_ords_privileges WHERE  name = 'prd_priv';

select * FROM user_ords_privilege_roles WHERE  role_name = 'prd_role';

SELECT  * FROM   user_ords_privilege_mappings WHERE  name = 'prd_priv';

curl http://localhost/ords/cmser/TestPriv/prdctlee/1

BEGIN
  OAUTH.create_client(
    p_name            => 'PRD Client',
    p_grant_type      => 'client_credentials',
    p_owner           => 'My Company Limited',
    p_description     => 'A client for PRD management',
    p_support_email   => 'saroj@example.com',
    p_privilege_names => 'prd_priv'
  );

  COMMIT;
END;
/

BEGIN
 OAUTH.DELETE_CLIENT( p_name  => 'PRD Client');
  COMMIT;
END;
/

SELECT * FROM user_ords_clients;

CLIENT_ID     : OzSKygSmWccOscw7z-naVA..
CLIENT_SECRET : K_xN9MWXLk_kgc1Ko9DQGQ..
OAUTH URL     : https://ol7-121.localdomain:8443/ords/pdb1/testuser1/oauth/token

http://localhost/ords/cmser/oauth/token



SELECT * FROM user_ords_client_privileges;



-- Associate the client with the role that holds the correct privileges for the resources it needs to access.
BEGIN
  OAUTH.grant_client_role(
    p_client_name => 'PRD Client',
    p_role_name   => 'prd_role'
  );

  COMMIT;
END;
/

SELECT * FROM   user_ords_client_roles;

Now the secure resource can be accessed as 

curl --basic http://localhost/ords/cmser/prdctlee/

above should give you error : <p>Access to this resource is protected. Please <a href="http://localhost/ords/cmser/sign-in/?r=prdctlee%2F">sign in</a> to access this resource.</p>

Now generate the authorisation code using the client id client secret

curl -i -k --user OzSKygSmWccOscw7z-naVA..:K_xN9MWXLk_kgc1Ko9DQGQ.. --data "grant_type=client_credentials" http://localhost/ords/cmser/oauth/token

--Notice the user format above is "CLIENT_ID:CLIENT_SECRET". 

HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Content-Type: application/json
Transfer-Encoding: chunked
Date: Mon, 17 Oct 2016 13:05:16 GMT

{"access_token":"-HL16jmirLtZ9QNIbCkeXQ..","token_type":"bearer","expires_in":3600}

curl -i -k -H"Authorization: Bearer -HL16jmirLtZ9QNIbCkeXQ.." http://localhost/ords/cmser/prdctlee/

BEGIN
  ORDS.define_service(
    p_module_name    => 'testmodule',
    p_base_path      => 'users/',
    p_pattern        => 'name/',
    p_method         => 'GET',
    p_source_type    => ORDS.source_type_query,
    p_source         => 'SELECT * from prdctlee',
    p_items_per_page => 0);

  COMMIT;
END;
/

http://localhost/ords/cmser/users/name



/*
BEGIN
  ORDS.delete_role(
    p_role_name => 'ords-rest-access-ims'
  );
  
  COMMIT;
END;
/

BEGIN
  ORDS.delete_privilege(
   p_name => 'rest-access-test'
  );
  
  COMMIT;
END;
/

BEGIN
  ORDS.create_role(
    p_role_name => 'ords-rest-access-ims'
  );
  
  COMMIT;
END;
/

DECLARE
  l_arr OWA.vc_arr;
BEGIN
  l_arr(1) := 'ords-rest-access-ims';
  
  ORDS.define_privilege (
    p_privilege_name => 'rest-access-test',
    p_roles          => l_arr,
    p_label          => 'Users data',
    p_description    => 'Allow access to Users data.'
  );
   
  COMMIT;
END;
/

BEGIN
  ORDS.create_privilege_mapping(
    p_privilege_name => 'rest-access-test',
    p_pattern => '/users/*'
  );     

  COMMIT;
END;
/


*/

-- Working Set of modules/template and service and their role/priv/mapping
BEGIN
    ORDS.DELETE_MODULE(p_module_name => 'testmodule');
  COMMIT;
END;
/

BEGIN
    ORDS.DEFINE_MODULE(
       p_module_name    => 'testmodule',
       p_base_path      => 'users/',
       p_items_per_page => 10,
       p_status         => 'PUBLISHED',
       p_comments       => 'Test Module' );

    ORDS.DEFINE_TEMPLATE(
        p_module_name    => 'testmodule',
        p_pattern        => 'name/');

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'testmodule',
        p_pattern        => 'name/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => 'select * from PRDCTLEE'
    );
END;
/

commit;

BEGIN
  ORDS.create_role(
    p_role_name => 'tst role'
  );
  
  COMMIT;
END;
/

DECLARE
  l_arr OWA.vc_arr;
BEGIN
  l_arr(1) := 'tst role';
  
  ORDS.define_privilege (
    p_privilege_name => 'tst priv',
    p_roles          => l_arr,
    p_label          => 'Users data',
    p_description    => 'Allow access to Users data.'
  );
   
  COMMIT;
END;
/

BEGIN
  ORDS.create_privilege_mapping(
    p_privilege_name => 'tst priv',
    p_pattern => '/users/*'
  );     

  COMMIT;
END;
/


BEGIN
    ORDS.DELETE_MODULE(
       p_module_name    => 'testpriv' );
END;
/


-- AutoRest

BEGIN
  ORDS.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'CMSER',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'CMSER',
    p_auto_rest_auth      => FALSE
  );
    
  COMMIT;
END;
/


BEGIN
  ORDS.enable_object (
    p_enabled      => TRUE, -- Default  { TRUE | FALSE }
    p_schema       => 'CMSER',
    p_object       => 'ORGCTLEE',
    p_object_type  => 'TABLE', -- Default  { TABLE | VIEW }
    p_object_alias => 'org'
  );
    
  COMMIT;
END;
/



GET Web Services (READ) :
http://localhost/ords/cmser/org/

The data from an individual row is returned using the primary key value. A comma-separated list is used for concatenated keys.

http://localhost/ords/cmser/org/1/

it is going to give you 500 internal server error i no primary key is present.

alter table orgctlee add primary key (org_lvl_id);

Now the the link should work fine : http://localhost/ords/cmser/org/1/

It is possible to page through data using the offset and limit parameters. The following URL returns a page of 3 rows of data from the EMP table, starting at row 2.

http://localhost/ords/cmser/org?offset=2&limit=3


Data filteration

# org_lvl_id = 2
http://localhost/ords/cmser/org/?q={"org_lvl_id":"2"}

# org_lvl_id > 3
http://localhost/ords/cmser/org/?q={"org_lvl_id":{"$gte":3}}

# name = 'Store' AND org_lvl_id <= 3
http://localhost/ords/cmser/org/?q={"name":"Store","org_lvl_id":{"$lte":3}}

# ORG having highest org_lvl_id
http://localhost/ords/cmser/org/?q={"$orderby":{"org_lvl_id":"desc"}}&offset=0&limit=1

# ORG having lowest org_lvl_id

http://localhost/ords/cmser/org/?q={"$orderby":{"org_lvl_id":"asc"}}&offset=0&limit=1

--POST Web Services (INSERT)

URL        : http://localhost/ords/cmser/org
Method     : POST
Header     : Content-Type: application/json
Raw Payload: { "org_lvl_id": 7, "org_lvl_short": "Test-7", "org_lvl_active": "T", "org_lvl_nmbr_rqd": T, "aim_org_prefix": "", "name": "Test-7"}

curl -i -X POST --data-binary @insert-payload.json -H "Content-Type: application/json" http://localhost/ords/cmser/org/

--PUT Web Services (UPDATE)

Records are updated, or inserted if they are missing, using the PUT method. The URL, method, header and payload necessary to do this are displayed below.

URL        : http://localhost/ords/cmser/org/
Method     : PUT
Header     : Content-Type: application/json
Raw Payload: {"org_lvl_name": "TEST-7"}

curl -i -X PUT --data-binary @update-payload.json -H "Content-Type: application/json" http://localhost/ords/cmser/org/7

Blanks out every column except 

--DELETE Web Services (DELETE) org_lvl_name

Records are deleted using the DELETE method. The URL and method necessary to do this are displayed below. If you specify additional header or payload information the web service call may fail.

URL        : http://localhost/ords/cmser/org/?q={"org_lvl_id":7}
Method     : DELETE
The following "curl" command will delete a row from the EMP table. The URL is an encoded version of the one shown above.

curl -i -X DELETE  http://localhost/ords/cmser/org/?q=%7B%22org_lvl_id%22%3A7%7D

--Batch UPDATE

curl -i -X POST --data-binary @ORGCTLEE_CSV.csv -H "Content-Type: text/csv" "http://localhost/ords/cmser/org/batchload?truncate=True&errors=-1"

Limitations of batch load :

Stops processing rows after encountering a error
All successfully rows loaded before first error is commited to the table
Truncate option truncates before loading the data.

--Oracle REST Data Services
http://www.slideshare.net/chriscmuir/oracle-rest-data-services

http://bit.ly/letstalkoracle001

RFID - Radio-frequency identification


We model the ressource, not the action!

▪ Use of nouns in plural form
▪ PUT http://example.com/accounts/12345
Not ▪ PUT http://example.com/accounts/edit/12345
▪ POST http://example.com/accounts/
NOT ▪ POST http://example.com/accounts/addaccount

