create table ri_ords_project
(
    prject_name         VARCHAR2(30)
    ,project_phase      VARCHAR2(10)
    ,ords_url_map       VARCHAR2(50)
    ,app_server_name    VARCHAR2(100)
    ,base_schema        VARCHAR2(30)
    ,base_schema_alias  VARCHAR2(30)
    ,auth_type          VARCHAR2(50)
    ,user_name          VARCHAR2(50)
    ,password           VARCHAR2(50)
);

COMMENT ON COLUMN ri_ords_project.prject_name IS 
'Values can be cms, wms, oms'
/

COMMENT ON COLUMN ri_ords_project.project_phase IS 
'Values can be dev, tst, ts2, ts3, ts4, sp1, uat, prd'
/

COMMENT ON COLUMN ri_ords_project.ords_url_map IS 
'ORDS URL map assigned during installation'
/

COMMENT ON COLUMN ri_ords_project.app_server_name IS 
'app_server_name referring to app_server_name of ri_ords_app_server'
/

COMMENT ON COLUMN ri_ords_project.base_schema IS 
'Base schema name for that environment, e.g cms, orderactive, rwm as used in ORDS module'
/

create table ri_ords_app_server
(
     app_server_name   VARCHAR2(100)
    ,app_server_dns    VARCHAR2(100)
    ,app_server_port   VARCHAR2(5)
    ,ssl_flag          VARCHAR2(1)
    ,ords_cname_alias  VARCHAR2(100)
    ,apex_cname_alias  VARCHAR2(100)
    ,context_root      VARCHAR2(10)
);

COMMENT ON COLUMN ri_ords_app_server.app_server_name IS 
'Name of the app server where ORDS is deployed'
/

COMMENT ON COLUMN ri_ords_app_server.app_server_dns IS 
'DNS of the app server where ORDS is deployed'
/

COMMENT ON COLUMN ri_ords_app_server.app_server_port IS 
'APP server port on which container server is running'
/

COMMENT ON COLUMN ri_ords_app_server.ssl_flag IS 
'Y/N whether SSL is implemented'
/

COMMENT ON COLUMN ri_ords_app_server.ords_cname_alias IS 
'CNAME alias to be used for ORDS service'
/

COMMENT ON COLUMN ri_ords_app_server.apex_cname_alias IS 
'CNAME alias to be used for APEX applications'
/

COMMENT ON COLUMN ri_ords_app_server.context_root IS 
'Context root name for ORDS default is ORDS if not provided'
/

-- http://ords-alb.dev.transit.ri-tech.io/ords/cmsdev/cms/demo-api/dbdetails
-- http://ords-alb.dev.transit.ri-tech.io/ords/cmstst/cms/demo-api/dbdetails

cp -r /apps/software/oracle/ords309/config/ords /home/dev/itsr/config


