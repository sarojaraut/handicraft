set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.2.00.07'
,p_default_workspace_id=>1720397223216815
,p_default_application_id=>104
,p_default_owner=>'SAROJR'
);
end;
/
prompt --application/set_environment
 
prompt APPLICATION 104 - Pre-publish Cube Checklist
--
-- Application Export:
--   Application:     104
--   Name:            Pre-publish Cube Checklist
--   Date and Time:   14:48 Friday February 26, 2016
--   Exported By:     ADMIN
--   Flashback:       0
--   Export Type:     Application Export
--   Version:         5.0.2.00.07
--   Instance ID:     108831138795942
--

-- Application Statistics:
--   Pages:                     23
--     Items:                   52
--     Computations:             1
--     Validations:             30
--     Processes:               10
--     Regions:                 73
--     Buttons:                 13
--     Dynamic Actions:          1
--   Shared Components:
--     Logic:
--       Items:                  2
--     Navigation:
--       Lists:                  8
--       Breadcrumbs:            1
--         Entries:             17
--     Security:
--       Authentication:         1
--       Authorization:          1
--     User Interface:
--       Themes:                 1
--       Templates:
--         Page:                 9
--         Region:              13
--         Label:                5
--         List:                11
--         Popup LOV:            1
--         Calendar:             1
--         Breadcrumb:           1
--         Button:               3
--         Report:               8
--       LOVs:                   6
--       Shortcuts:              2
--       Plug-ins:              12
--     Globalization:
--     Reports:
--   Supporting Objects:  Included

prompt --application/delete_application
begin
wwv_flow_api.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/create_application
begin
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_display_id=>nvl(wwv_flow_application_install.get_application_id,104)
,p_owner=>nvl(wwv_flow_application_install.get_schema,'SAROJR')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Pre-publish Cube Checklist')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'CUBECHECKLIST')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'46FDFBB2126FEEEE1EEBE196789F7F37B7F523973878470DB35C880E67F16C44'
,p_bookmark_checksum_function=>'SH1'
,p_compatibility_mode=>'5.0'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'0'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(16244517030318014)
,p_application_tab_set=>0
,p_logo_image=>'TEXT:Checklist App'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=> nvl(wwv_flow_application_install.get_proxy,'')
,p_flow_version=>'release 1.1'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_substitution_string_01=>'NO_DATA_FOUND_MSG'
,p_substitution_value_01=>'<p style="color:grey">No records in this category </p>'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150915141723'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_ui_type_name => null
);
end;
/
prompt --application/shared_components/navigation/lists
begin
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(16202135626317875)
,p_name=>'Desktop Navigation Menu'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16245719153318033)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'1,20'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16252850580455891)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Checklist Data'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:1,Record Count By Source File Type:'
,p_list_item_icon=>'fa-binoculars'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16253108575463297)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'View Checklist'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:1,Record Count By Source File Type:'
,p_list_item_icon=>'fa-binoculars'
,p_parent_list_item_id=>wwv_flow_api.id(16252850580455891)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16253482581464737)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Prepare Checklist'
,p_list_item_link_target=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:20:::'
,p_list_item_icon=>'fa-edit'
,p_parent_list_item_id=>wwv_flow_api.id(16252850580455891)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16253756119482344)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Cube Data'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19160741037380750)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Datacube EVM MAIN'
,p_list_item_link_target=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_parent_list_item_id=>wwv_flow_api.id(16253756119482344)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'9'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19245518209115038)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'Datacube EVM Cashflow'
,p_list_item_link_target=>'f?p=&APP_ID.:120:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_parent_list_item_id=>wwv_flow_api.id(16253756119482344)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19245871982116711)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Datacube USGAAP Main'
,p_list_item_link_target=>'f?p=&APP_ID.:130:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_parent_list_item_id=>wwv_flow_api.id(16253756119482344)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19246148097118162)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'Datacube LOSSREC Main'
,p_list_item_link_target=>'f?p=&APP_ID.:140:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_parent_list_item_id=>wwv_flow_api.id(16253756119482344)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19246426440119715)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'Datacube EV Main'
,p_list_item_link_target=>'f?p=&APP_ID.:150:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_parent_list_item_id=>wwv_flow_api.id(16253756119482344)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19246736934121062)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'Datacube EV Cashflow'
,p_list_item_link_target=>'f?p=&APP_ID.:160:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_parent_list_item_id=>wwv_flow_api.id(16253756119482344)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23651998364246227)
,p_list_item_display_sequence=>140
,p_list_item_link_text=>'Reports and Charts'
,p_list_item_link_target=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'50,60,70'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23570850326639354)
,p_list_item_display_sequence=>130
,p_list_item_link_text=>'Dashboard'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-desktop'
,p_parent_list_item_id=>wwv_flow_api.id(23651998364246227)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23663038416460269)
,p_list_item_display_sequence=>150
,p_list_item_link_text=>'Bubble Chart'
,p_list_item_link_target=>'f?p=&APP_ID.:60:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-comments'
,p_parent_list_item_id=>wwv_flow_api.id(23651998364246227)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'60'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23666122268474065)
,p_list_item_display_sequence=>160
,p_list_item_link_text=>'Line Chart'
,p_list_item_link_target=>'f?p=&APP_ID.:70:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-stumbleupon'
,p_parent_list_item_id=>wwv_flow_api.id(23651998364246227)
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'70'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23669294061514123)
,p_list_item_display_sequence=>170
,p_list_item_link_text=>'All Reports and Charts'
,p_list_item_link_target=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-book'
,p_parent_list_item_id=>wwv_flow_api.id(23651998364246227)
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(16244279352317992)
,p_name=>'Desktop Navigation Bar'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(32338925330180854)
,p_list_item_display_sequence=>5
,p_list_item_link_text=>'Help'
,p_list_item_link_target=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'a-Icon icon-help'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16244449266318008)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Log Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_list_item_current_for_pages=>'&LOGOUT_URL.'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(16256569176639273)
,p_name=>'Checklist Sections'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16256713668639274)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'<bCount by Source File</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:1,Record Count By Source File Type:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16257136485639276)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'<b>Count by Run Type</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:2,Record Count by Run Type:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16257838859639277)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'<b>Amount by Source File</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:4,Total Amount By Source File Type:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(16258287581639277)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'<b>Amount by Deal Code</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:5,Total Amount By Deal Codes:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19174412305243741)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'<b>AOS_DIFF by Deal Code</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:6,Total AOS DIFF By Deal Codes:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19174723834245532)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'<b>Govt Fixed Income</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:7,Total Amount By Govt Fixed Income:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19175054596246950)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'<b>Public Equities</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:8,Total Amount By Public Equities:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19175354407248774)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'<b>Count By Basis Layer</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:9,Record Count By Basis Layer:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19175677333251382)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'<b>Count By Variable</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:10,Total Count Variables:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19175957221253529)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'<b>Count By EVM NSD</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::P11_SECTION_ID,P11_SECTION_CATEGORY:11,Record Count By EVM Non Std Definition Codes:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19176292003255338)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'<b>Projection Period Diff</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.::P12_SECTION_ID,P12_SECTION_CATEGORY:12,Projection Period Diffeerence:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19176506946256674)
,p_list_item_display_sequence=>130
,p_list_item_link_text=>'<b>Variable Difference</b>'
,p_list_item_link_target=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.::P12_SECTION_ID,P12_SECTION_CATEGORY:13,Variable Code Diffeerence:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(19250538347221932)
,p_name=>'Home Dashboard'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19250760399221934)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Prepare Checklist'
,p_list_item_link_target=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:20:::'
,p_list_item_icon=>'fa-edit'
,p_list_text_01=>'Specify old and new cubes to be used for comparison and build checklist data.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19251150229221935)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'View Checklist'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:1,Record Count By Source File Type:'
,p_list_item_icon=>'fa-binoculars'
,p_list_text_01=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'View checklist data formatted in matrix structure. (New and OLD cube figures)',
''))
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19251523540221935)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'EVM Main Cube'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_list_text_01=>'View The draft version of cube data(Column selection, data filter, aggregation)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19251901995221935)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'EVM CF Cube'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_list_text_01=>'View The draft version of cube data(Column selection, data filter, aggregation)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19252349378221935)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'USGAAP Main Cube'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_list_text_01=>'View The draft version of cube data(Column selection, data filter, aggregation)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19252806654223933)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'LOSSREC Main Cube'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_list_text_01=>'View The draft version of cube data(Column selection, data filter, aggregation)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19253108578227046)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'EV Main Cube'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_list_text_01=>'View The draft version of cube data(Column selection, data filter, aggregation)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(19253426153228092)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'EV CF Cube'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cubes'
,p_list_text_01=>'View The draft version of cube data(Column selection, data filter, aggregation)'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(20792097848739820)
,p_name=>'ChecklistSections-LinktoPage10'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20792282166739824)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Count by Source File'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:1,Record Count By Source File Type:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=1'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20792687201739826)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Count by Run Type'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:2,Record Count by Run Type:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=2'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20793047537739826)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Amount by Source File'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:4,Total Amount By Source File Type:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=4'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20793499508739827)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Amount by Deal Code'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:5,Total Amount By Deal Codes:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=5'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20793825829739827)
,p_list_item_display_sequence=>60
,p_list_item_link_text=>'AOS_DIFF by Deal Code'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:6,Total AOS DIFF By Deal Codes:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=6'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20794249981739827)
,p_list_item_display_sequence=>70
,p_list_item_link_text=>'Govt Fixed Income'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:7,Total Amount By Govt Fixed Income:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=7'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20794611255739827)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'Public Equities'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:8,Total Amount By Public Equities:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=8'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20795097623739828)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Count By Basis Layer'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:9,Record Count By Basis Layer:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=9'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20795473310739828)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'Count By Variable'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:10,Total Count Variables:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=10'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20795869980739829)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'Count By EVM NSD'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:11,Record Count By EVM Non Std Definition Codes:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=11'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20796292233739829)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'Projection Period Diff'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:12,Projection Period Diffeerence:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=12'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(20796686046739829)
,p_list_item_display_sequence=>130
,p_list_item_link_text=>'Variable Difference'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::P10_SECTION_ID,P10_SECTION_CATEGORY:13,Variable Code Difference:'
,p_list_item_current_type=>'EXISTS'
,p_list_item_current_for_pages=>'select 1 from dual where :P10_SECTION_ID=13'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(23653281558266698)
,p_name=>'Summary Reports'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23653497019266700)
,p_list_item_display_sequence=>6
,p_list_item_link_text=>'Product Reports'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cogs'
,p_list_text_01=>'View summary Report on Products'
,p_list_text_02=>'reportIcon'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23653861150266703)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Deals Reports'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-dropbox'
,p_list_text_01=>'View summary Report By Deals'
,p_list_text_02=>'reportIcon'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23654236385266703)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Public Equities Reports'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-gbp'
,p_list_text_01=>'View summary Report By GL Accounts(Public Equities)'
,p_list_text_02=>'reportIcon'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23654666522266704)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Govt Fixed Income Reports'
,p_list_item_link_target=>'f?p=&APP_ID.:Govt Fixed Income Reports:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-align-justify'
,p_list_text_01=>'View Summary Report By Gl Accounts (Govt Fixed Income)'
,p_list_text_02=>'calendarIcon'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23655804900266704)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Table Row Counts'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.:RP:::'
,p_list_item_icon=>'fa-table'
,p_list_text_01=>'View a list of the database tables used by this demonstration system and the current row counts.'
,p_list_text_02=>'reportIcon'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(23657872137283068)
,p_name=>'Charts'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23658031595283068)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Amount By Deals Reports - Draft'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-cloud'
,p_list_text_01=>'Bubble Chart to visualise total amount across deal codes'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23658344084283068)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Public Equities Trend Analysis -  Draft'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-line-chart'
,p_list_text_01=>'Demo Line chart for displaying Quarter end Amount of GL accounts (Public Equities) for FA14, where "Asset Manager"=NON-SRAM, "LOB Code"=80 and "Reporting Fund Num"=6'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23658779902283069)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Pie-Chart'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-pie-chart'
,p_list_text_01=>'Demo Pie chart displaying distribution of amount across LOB codes'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(23659115093283069)
,p_list_item_display_sequence=>40
,p_list_item_link_text=>'Spedometer - Graph'
,p_list_item_link_target=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-dot-circle-o'
,p_list_text_01=>'Graph DIsplaying number of variables appearing in a cube against total number of variables activated for that cube'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list(
 p_id=>wwv_flow_api.id(35976856360068061)
,p_name=>'ChecklistPrepareWizard'
,p_list_status=>'PUBLIC'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(35977018418068064)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'SelectCubes'
,p_list_item_link_target=>'f?p=&APP_ID.:2020:&SESSION.:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(35977445279068067)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'ConfirmCubes'
,p_list_item_link_target=>'f?p=&APP_ID.:2021:&SESSION.:'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_api.create_list_item(
 p_id=>wwv_flow_api.id(35977868665068067)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Checklist Refreshed'
,p_list_item_link_target=>'f?p=&APP_ID.:2022:&SESSION.::&DEBUG.::::'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/files
begin
null;
end;
/
prompt --application/plugin_settings
begin
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(16201827341317873)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_CSS_CALENDAR'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(16201902008317873)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(16202048098317875)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(19004572676745172)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'PLUGIN_COM.ORACLE.APEX.D3.BARCHART'
,p_attribute_01=>'3'
,p_attribute_02=>'1.333'
,p_attribute_03=>'480'
,p_attribute_04=>'WINDOW'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(19020221117745184)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'PLUGIN_COM.ORACLE.APEX.D3.BUBBLE'
,p_attribute_01=>'1.333'
,p_attribute_02=>'3'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(23633220421023301)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'PLUGIN_COM.ORACLE.APEX.D3.LINE'
,p_attribute_01=>'3'
,p_attribute_02=>'1.333'
,p_attribute_03=>'480'
,p_attribute_04=>'WINDOW'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
);
wwv_flow_api.create_plugin_setting(
 p_id=>wwv_flow_api.id(23644631091023308)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'PLUGIN_COM.ORACLE.APEX.D3.TREEMAP'
,p_attribute_01=>'1.33'
,p_attribute_02=>'3'
);
end;
/
prompt --application/shared_components/security/authorizations
begin
wwv_flow_api.create_security_scheme(
 p_id=>wwv_flow_api.id(32063248862243228)
,p_name=>'UserIsAdmin'
,p_scheme_type=>'NATIVE_EXISTS'
,p_attribute_01=>'select 1 from dual where :APP_USER=''ADMIN'''
,p_error_message=>'Only ADMIN user is allowed to do this operation'
,p_caching=>'BY_USER_BY_SESSION'
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
null;
end;
/
prompt --application/shared_components/logic/application_processes
begin
null;
end;
/
prompt --application/shared_components/logic/application_items
begin
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(19228571713323022)
,p_name=>'G_CHECKLIST_REFRESH_TS'
,p_protection_level=>'N'
);
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(32122861719412448)
,p_name=>'NO_DATA_FOUND_MSG'
,p_protection_level=>'I'
);
end;
/
prompt --application/shared_components/logic/application_computations
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(24924886457209851)
,p_lov_name=>'ALL_EVM_CF_CUBES'
,p_lov_query=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(24922983890196323)
,p_lov_name=>'ALL_EVM_MAIN_CUBES'
,p_lov_query=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_MAIN_[0-9,_]+'')',
'order by created desc'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(24925647049217457)
,p_lov_name=>'ALL_EV_CF_CUBES'
,p_lov_query=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(24925451240214809)
,p_lov_name=>'ALL_EV_MAIN_CUBES'
,p_lov_query=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_MAIN_[0-9,_]+'')',
'order by created desc'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(24925263638213221)
,p_lov_name=>'ALL_LOSSREC_MAIN_CUBES'
,p_lov_query=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_LOSSREC_MAIN_[0-9,_]+'')',
'order by created desc'))
);
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(24925055169211498)
,p_lov_name=>'ALL_USGAAP_MAIN_CUBES'
,p_lov_query=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_USGAAP_MAIN_[0-9,_]+'')',
'order by created desc'))
);
end;
/
prompt --application/shared_components/navigation/trees
begin
null;
end;
/
prompt --application/pages/page_groups
begin
null;
end;
/
prompt --application/comments
begin
null;
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_api.create_menu(
 p_id=>wwv_flow_api.id(16245677836318030)
,p_name=>' Breadcrumb'
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(16246020139318034)
,p_parent_id=>0
,p_short_name=>'Home'
,p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.'
,p_page_id=>1
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(19241190130027292)
,p_short_name=>'PrepareChecklist'
,p_link=>'f?p=&APP_ID.:20:&SESSION.'
,p_page_id=>20
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(19302038592200195)
,p_parent_id=>0
,p_short_name=>'EVM'
,p_link=>'f?p=&APP_ID.:9:&SESSION.::&DEBUG.:::'
,p_page_id=>9
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(20827777671807909)
,p_parent_id=>0
,p_short_name=>'Checklist Refresh Date &P10_CHECKLIST_REFRESH_TS.'
,p_link=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:::'
,p_page_id=>10
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(23575580318555800)
,p_short_name=>'Dashboard'
,p_link=>'f?p=&APP_ID.:40:&SESSION.'
,p_page_id=>40
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(23652891146246228)
,p_short_name=>'Reports and Charts'
,p_link=>'f?p=&APP_ID.:50:&SESSION.'
,p_page_id=>50
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(23665006371460275)
,p_short_name=>'Bubble Chart'
,p_link=>'f?p=&APP_ID.:60:&SESSION.'
,p_page_id=>60
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(25054822910998294)
,p_short_name=>'ChecklistPrepareStatus'
,p_link=>'f?p=&APP_ID.:30:&SESSION.'
,p_page_id=>30
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(25177280501794578)
,p_parent_id=>0
,p_short_name=>'Cube'
,p_long_name=>'EVM Main'
,p_link=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.:::'
,p_page_id=>110
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(32021853321907994)
,p_parent_id=>0
,p_short_name=>'Cube'
,p_long_name=>'EVM Cashflow'
,p_link=>'f?p=&APP_ID.:120:&SESSION.::&DEBUG.:::'
,p_page_id=>120
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(32033938659890505)
,p_parent_id=>0
,p_short_name=>'Cube'
,p_link=>'f?p=&APP_ID.:130:&SESSION.::&DEBUG.:::'
,p_page_id=>130
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(32043684901550990)
,p_parent_id=>0
,p_short_name=>'Cube'
,p_link=>'f?p=&APP_ID.:140:&SESSION.::&DEBUG.:::'
,p_page_id=>140
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(32045601460880988)
,p_parent_id=>0
,p_short_name=>'Cube'
,p_link=>'f?p=&APP_ID.:150:&SESSION.::&DEBUG.:::'
,p_page_id=>150
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(32046555933916590)
,p_parent_id=>0
,p_short_name=>'Cube'
,p_link=>'f?p=&APP_ID.:160:&SESSION.::&DEBUG.:::'
,p_page_id=>160
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(36050655264856559)
,p_parent_id=>0
,p_short_name=>'Select Cubes - Prepare Checklist'
,p_link=>'f?p=&APP_ID.:2020:&SESSION.::&DEBUG.:::'
,p_page_id=>2020
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(36050805021859554)
,p_parent_id=>0
,p_short_name=>'Review Choosed Cubes - Prepare Checklist'
,p_link=>'f?p=&APP_ID.:2021:&SESSION.::&DEBUG.:::'
,p_page_id=>2021
);
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(36051090379862785)
,p_parent_id=>0
,p_short_name=>'Prepare Checklist- Prepare Checklist'
,p_link=>'f?p=&APP_ID.:2022:&SESSION.::&DEBUG.:::'
,p_page_id=>2022
);
end;
/
prompt --application/shared_components/user_interface/templates/page
begin
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16202248223317889)
,p_theme_id=>42
,p_name=>'Left Side Column'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.leftSideCol();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-side" id="t_Body_side">',
'      #REGION_POSITION_02#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'        <footer class="t-Footer">',
'          #APP_VERSION#',
'          #CUSTOMIZE#',
'          #SCREEN_READER_TOGGLE#',
'          #REGION_POSITION_05#',
'        </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525196570560608698
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16202333245317895)
,p_page_template_id=>wwv_flow_api.id(16202248223317889)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16202423223317899)
,p_page_template_id=>wwv_flow_api.id(16202248223317889)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16202549683317899)
,p_page_template_id=>wwv_flow_api.id(16202248223317889)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16202625128317899)
,p_page_template_id=>wwv_flow_api.id(16202248223317889)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16202752289317899)
,p_page_template_id=>wwv_flow_api.id(16202248223317889)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16202828371317899)
,p_page_template_id=>wwv_flow_api.id(16202248223317889)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16202919267317899)
,p_page_template_id=>wwv_flow_api.id(16202248223317889)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203092688317899)
,p_page_template_id=>wwv_flow_api.id(16202248223317889)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16203144132317906)
,p_theme_id=>42
,p_name=>'Left and Right Side Columns'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.bothSideCols();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-side" id="t_Body_side">',
'      #REGION_POSITION_02#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        #APP_VERSION#',
'        #CUSTOMIZE#',
'        #SCREEN_READER_TOGGLE#',
'        #REGION_POSITION_05#',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa-bars"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>false
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525203692562657055
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203235110317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203380107317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203468606317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203549991317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203631351317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203758238317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203801477317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16203978330317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16204083645317907)
,p_page_template_id=>wwv_flow_api.id(16203144132317906)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16204139811317908)
,p_theme_id=>42
,p_name=>'Login'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.appLogin();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!doctype html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="html-login no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="html-login no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="html-login no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="html-login no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="html-login no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody--login no-anim #PAGE_CSS_CLASSES#" #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #REGION_POSITION_01#',
'  #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'  <div class="t-Body-wrap">',
'    <div class="t-Body-col t-Body-col--main">',
'      <div class="t-Login-container">',
'      #BODY#',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>6
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2099711150063350616
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16204238296317908)
,p_page_template_id=>wwv_flow_api.id(16204139811317908)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16204302095317909)
,p_page_template_id=>wwv_flow_api.id(16204139811317908)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16204432194317910)
,p_theme_id=>42
,p_name=>'Master Detail'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.masterDetail();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--masterDetail t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-info" id="t_Body_info">',
'        #REGION_POSITION_02#',
'      </div>',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        #APP_VERSION#',
'        #CUSTOMIZE#',
'        #SCREEN_READER_TOGGLE#',
'        #REGION_POSITION_05#',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa-bars"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1996914646461572319
,p_translate_this_template=>'N'
);
end;
/
begin
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16204582136317910)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16204677309317910)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16204729133317910)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16204884138317910)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16204979196317910)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205009915317910)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205143831317911)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205229903317911)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205366461317911)
,p_page_template_id=>wwv_flow_api.id(16204432194317910)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16205493263317911)
,p_theme_id=>42
,p_name=>'Minimal (No Navigation)'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES# t-PageBody--noNav" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  <div class="t-Body-main">',
'      <div class="t-Body-title" id="t_Body_title">',
'        #REGION_POSITION_01#',
'      </div>',
'      <div class="t-Body-content" id="t_Body_content">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-contentInner">',
'          #BODY#',
'        </div>',
'        <footer class="t-Footer">',
'          #APP_VERSION#',
'          #CUSTOMIZE#',
'          #SCREEN_READER_TOGGLE#',
'          #REGION_POSITION_05#',
'        </footer>',
'      </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>4
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2977628563533209425
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205550136317912)
,p_page_template_id=>wwv_flow_api.id(16205493263317911)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205616891317912)
,p_page_template_id=>wwv_flow_api.id(16205493263317911)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205795105317912)
,p_page_template_id=>wwv_flow_api.id(16205493263317911)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205870832317912)
,p_page_template_id=>wwv_flow_api.id(16205493263317911)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16205991291317912)
,p_page_template_id=>wwv_flow_api.id(16205493263317911)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16206035430317912)
,p_page_template_id=>wwv_flow_api.id(16205493263317911)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16206151886317912)
,p_page_template_id=>wwv_flow_api.id(16205493263317911)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16206283707317913)
,p_theme_id=>42
,p_name=>'Modal Dialog'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-Dialog-page #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-wrapper">',
'    <div class="t-Dialog-header">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Dialog-body">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      #BODY#',
'    </div>',
'    <div class="t-Dialog-footer">',
'      #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'500'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_css_classes=>'t-Dialog--standard'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2098960803539086924
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16206306190317914)
,p_page_template_id=>wwv_flow_api.id(16206283707317913)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16206423777317914)
,p_page_template_id=>wwv_flow_api.id(16206283707317913)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16206555497317914)
,p_page_template_id=>wwv_flow_api.id(16206283707317913)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16206685967317914)
,p_theme_id=>42
,p_name=>'Right Side Column'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.rightSideCol();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>'))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'#SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      <div class="t-Body-contentInner">',
'        #BODY#',
'      </div>',
'      <footer class="t-Footer">',
'        #APP_VERSION#',
'        #CUSTOMIZE#',
'        #SCREEN_READER_TOGGLE#',
'        #REGION_POSITION_05#',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Button t-Button--icon t-Button--header t-Button--headerRight" id="t_Button_rightControlButton" type="button"><span class="t-Icon fa-bars"></span></button>',
'    <div class="t-Body-actionsContent">',
'    #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>false
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525200116240651575
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16206714772317915)
,p_page_template_id=>wwv_flow_api.id(16206685967317914)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16206827541317915)
,p_page_template_id=>wwv_flow_api.id(16206685967317914)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16206963060317915)
,p_page_template_id=>wwv_flow_api.id(16206685967317914)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207027768317915)
,p_page_template_id=>wwv_flow_api.id(16206685967317914)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207148107317915)
,p_page_template_id=>wwv_flow_api.id(16206685967317914)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207239882317915)
,p_page_template_id=>wwv_flow_api.id(16206685967317914)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207381390317915)
,p_page_template_id=>wwv_flow_api.id(16206685967317914)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207426254317915)
,p_page_template_id=>wwv_flow_api.id(16206685967317914)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16207520075317915)
,p_theme_id=>42
,p_name=>'Standard'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES#" #ONLOAD# id="t_PageBody">',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" id="t_Button_navControl" type="button"><span class="t-Icon fa-bars"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'    </div>',
'    <div class="t-Header-navBar">',
'      #NAVIGATION_BAR#',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">',
'    #TOP_GLOBAL_NAVIGATION_LIST#',
'    #REGION_POSITION_06#',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'      <div class="t-Body-title" id="t_Body_title">',
'        #REGION_POSITION_01#',
'      </div>',
'      <div class="t-Body-content" id="t_Body_content">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-contentInner">',
'          #BODY#',
'        </div>',
'        <footer class="t-Footer">',
'          #APP_VERSION#',
'          #CUSTOMIZE#',
'          #SCREEN_READER_TOGGLE#',
'          #REGION_POSITION_05#',
'        </footer>',
'      </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs">',
'  #REGION_POSITION_04#',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'        <span class="t-Icon a-Icon icon-user"></span>',
'        <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'      <span class="t-Icon #IMAGE#"></span>',
'      <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>1
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>4070909157481059304
,p_translate_this_template=>'N'
);
end;
/
begin
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207690324317915)
,p_page_template_id=>wwv_flow_api.id(16207520075317915)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207775883317915)
,p_page_template_id=>wwv_flow_api.id(16207520075317915)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207820101317915)
,p_page_template_id=>wwv_flow_api.id(16207520075317915)
,p_name=>'Inline Dialogs'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16207905372317915)
,p_page_template_id=>wwv_flow_api.id(16207520075317915)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16208045691317915)
,p_page_template_id=>wwv_flow_api.id(16207520075317915)
,p_name=>'Page Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16208130686317915)
,p_page_template_id=>wwv_flow_api.id(16207520075317915)
,p_name=>'Page Header'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16208285233317915)
,p_page_template_id=>wwv_flow_api.id(16207520075317915)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>false
,p_glv_new_row=>false
);
wwv_flow_api.create_template(
 p_id=>wwv_flow_api.id(16208329863317916)
,p_theme_id=>42
,p_name=>'Wizard Modal Dialog'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.wizardModal();'
,p_header_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<meta http-equiv="x-ua-compatible" content="IE=edge" />',
'',
'<!--[if lt IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 7]><html class="no-js lt-ie10 lt-ie9 lt-ie8" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 8]><html class="no-js lt-ie10 lt-ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if IE 9]><html class="no-js lt-ie10" lang="&BROWSER_LANGUAGE."> <![endif]-->',
'<!--[if gt IE 9]><!--> <html class="no-js" lang="&BROWSER_LANGUAGE."> <!--<![endif]-->',
'<head>',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>',
'</head>',
'<body class="t-Dialog-page #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Wizard t-Wizard--modal">',
'    <div class=" t-Wizard-steps">',
'      #REGION_POSITION_01#',
'    </div>',
'    <div class="t-Wizard-body">',
'      #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'      #BODY#',
'    </div>',
'    <div class="t-Wizard-footer">',
'      #REGION_POSITION_03#',
'    </div>',
'  </div>',
'</div>'))
,p_footer_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">',
'          #MESSAGE#',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon fa-times"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h3>#MESSAGE#</h3>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>3
,p_grid_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="row">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES#" #ATTRIBUTES#>',
'#CONTENT#',
'</div>'))
,p_grid_first_column_attributes=>'alpha'
,p_grid_last_column_attributes=>'omega'
,p_dialog_js_init_code=>'apex.navigation.dialog(#PAGE_URL#,{title:#TITLE#,height:#DIALOG_HEIGHT#,width:#DIALOG_WIDTH#,maxWidth:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,#DIALOG_ATTRIBUTES#},#DIALOG_CSS_CLASSES#,#TRIGGERING_ELEMENT#);'
,p_dialog_js_close_code=>'apex.navigation.dialog.close(#IS_MODAL#,#TARGET#);'
,p_dialog_js_cancel_code=>'apex.navigation.dialog.cancel(#IS_MODAL#);'
,p_dialog_height=>'480'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_css_classes=>'t-Dialog--wizard'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2120348229686426515
,p_translate_this_template=>'N'
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16208486335317916)
,p_page_template_id=>wwv_flow_api.id(16208329863317916)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16208563917317916)
,p_page_template_id=>wwv_flow_api.id(16208329863317916)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_page_tmpl_display_point(
 p_id=>wwv_flow_api.id(16208690559317916)
,p_page_template_id=>wwv_flow_api.id(16208329863317916)
,p_name=>'Wizard Buttons'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/button
begin
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(16239008833317969)
,p_template_name=>'Icon'
,p_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"><'
||'/span></button>'
,p_hot_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL#" aria-label="#LABEL#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-h'
||'idden="true"></span></button>'
,p_reference_id=>2347660919680321258
,p_translate_this_template=>'N'
,p_theme_class_id=>5
,p_theme_id=>42
);
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(16239148892317970)
,p_template_name=>'Text'
,p_template=>'<button onclick="#JAVASCRIPT#" class="t-Button #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_hot_template=>'<button onclick="#JAVASCRIPT#" class="t-Button t-Button--hot #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_reference_id=>4070916158035059322
,p_translate_this_template=>'N'
,p_theme_class_id=>1
,p_theme_id=>42
);
wwv_flow_api.create_button_templates(
 p_id=>wwv_flow_api.id(16239202992317970)
,p_template_name=>'Text with Icon'
,p_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-label">#LABEL#'
||'</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_hot_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-'
||'label">#LABEL#</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_reference_id=>2081382742158699622
,p_translate_this_template=>'N'
,p_theme_class_id=>4
,p_preset_template_options=>'t-Button--iconRight'
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/region
begin
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16208747833317918)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #BODY#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">#PREVIOUS##CLOSE##CREATE##NEXT#</div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Alert'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2039236646100190748
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16208895816317921)
,p_plug_template_id=>wwv_flow_api.id(16208747833317918)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16210264139317931)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#"> ',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Blank with Attributes'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4499993862448380551
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16210399753317931)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-ButtonRegion t-Form--floatLeft #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <div class="t-ButtonRegion-wrap">',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--content">',
'      <h2 class="t-ButtonRegion-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'      #BODY#',
'      <div class="t-ButtonRegion-buttons">#CHANGE#</div>',
'    </div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Buttons Container'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>17
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2124982336649579661
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16210493565317931)
,p_plug_template_id=>wwv_flow_api.id(16210399753317931)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16210550471317931)
,p_plug_template_id=>wwv_flow_api.id(16210399753317931)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16211257581317931)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--carousel #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'   <div class="t-Region-carouselRegions">',
'     #SUB_REGIONS#',
'   </div>',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Carousel Container'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-Region--showCarouselControls'
,p_preset_template_options=>'t-Region--hiddenOverflow'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2865840475322558786
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16211386723317932)
,p_plug_template_id=>wwv_flow_api.id(16211257581317931)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16211411107317932)
,p_plug_template_id=>wwv_flow_api.id(16211257581317931)
,p_name=>'Slides'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16214611855317934)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--hideShow #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems  t-Region-headerItems--controls">',
'    <button class="t-Button t-Button--icon t-Button--hideShow" type="button"></button>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#EDIT#</div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#CLOSE#</div>',
'    <div class="t-Region-buttons-right">#CREATE#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #COPY#',
'     #BODY#',
'     #SUB_REGIONS#',
'     #CHANGE#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
' </div>',
'</div>'))
,p_page_plug_template_name=>'Collapsible'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>1
,p_preset_template_options=>'is-expanded:t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2662888092628347716
,p_translate_this_template=>'N'
,p_template_comment=>'Red Theme'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16214744095317934)
,p_plug_template_id=>wwv_flow_api.id(16214611855317934)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16214825047317934)
,p_plug_template_id=>wwv_flow_api.id(16214611855317934)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16216730653317935)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-HeroRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-HeroRegion-wrap">',
'    <div class="t-HeroRegion-col t-HeroRegion-col--left"><span class="t-HeroRegion-icon t-Icon #ICON_CSS_CLASSES#"></span></div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--content">',
'      <h2 class="t-HeroRegion-title">#TITLE#</h2>',
'      #BODY#',
'    </div>',
'    <div class="t-HeroRegion-col t-HeroRegion-col--right"><div class="t-HeroRegion-form">#SUB_REGIONS#</div><div class="t-HeroRegion-buttons">#NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Hero'
,p_theme_id=>42
,p_theme_class_id=>22
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672571031438297268
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16216874125317935)
,p_plug_template_id=>wwv_flow_api.id(16216730653317935)
,p_name=>'Region Body'
,p_placeholder=>'#BODY#'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16216946420317935)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#"  class="t-DialogRegion #REGION_CSS_CLASSES# js-regionDialog" #REGION_ATTRIBUTES# style="display:none" title="#TITLE#">',
'  <div class="t-DialogRegion-body js-regionDialog-body">',
'#BODY#',
'  </div>',
'  <div class="t-DialogRegion-buttons js-regionDialog-buttons">',
'     <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'       <div class="t-ButtonRegion-wrap">',
'         <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'         <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'       </div>',
'     </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Dialog'
,p_theme_id=>42
,p_theme_class_id=>24
,p_default_template_options=>'js-modal:js-draggable:js-resizable'
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2671226943886536762
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16217073360317935)
,p_plug_template_id=>wwv_flow_api.id(16216946420317935)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16217862042317938)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-IRR-region #REGION_CSS_CLASSES#" role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <h2 class="u-VisuallyHidden" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'#PREVIOUS##BODY##SUB_REGIONS##NEXT#',
'</div>'))
,p_page_plug_template_name=>'Interactive Report'
,p_theme_id=>42
,p_theme_class_id=>9
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2099079838218790610
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16218120342317939)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Login-region t-Form--stretchInputs t-Form--labelsAbove #REGION_CSS_CLASSES#" id="#REGION_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
'  <div class="t-Login-header">',
'    <span class="t-Login-logo #ICON_CSS_CLASSES#"></span>',
'    <h1 class="t-Login-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h1>',
'  </div>',
'  <div class="t-Login-body">',
'    #BODY#',
'  </div>',
'  <div class="t-Login-buttons">',
'    #NEXT#',
'  </div>',
'  <div class="t-Login-links">',
'    #EDIT##CREATE#',
'  </div>',
'  #SUB_REGIONS#',
'</div>'))
,p_page_plug_template_name=>'Login'
,p_theme_id=>42
,p_theme_class_id=>23
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2672711194551076376
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16218260770317939)
,p_plug_template_id=>wwv_flow_api.id(16218120342317939)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16218364978317939)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# role="group" aria-labelledby="#REGION_STATIC_ID#_heading">',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading">#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #BODY#',
'     #SUB_REGIONS#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>',
''))
,p_page_plug_template_name=>'Standard'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4070912133526059312
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16218491134317939)
,p_plug_template_id=>wwv_flow_api.id(16218364978317939)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16218569334317939)
,p_plug_template_id=>wwv_flow_api.id(16218364978317939)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16220423538317943)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-TabsRegion #REGION_CSS_CLASSES#" #REGION_ATTRIBUTES# id="#REGION_STATIC_ID#">',
'  #BODY#',
'  <div class="t-TabsRegion-items">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Tabs Container'
,p_theme_id=>42
,p_theme_class_id=>5
,p_preset_template_options=>'t-TabsRegion-mod--simple'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3221725015618492759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16220520289317943)
,p_plug_template_id=>wwv_flow_api.id(16220423538317943)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16220690272317943)
,p_plug_template_id=>wwv_flow_api.id(16220423538317943)
,p_name=>'Tabs'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_glv_new_row=>true
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16221620630317943)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="t-BreadcrumbRegion #REGION_CSS_CLASSES#"> ',
'  <div class="t-BreadcrumbRegion-body">',
'    <div class="t-BreadcrumbRegion-breadcrumb">',
'      #BODY#',
'    </div>',
'    <div class="t-BreadcrumbRegion-title">',
'      <h1 class="t-BreadcrumbRegion-titleText">#TITLE#</h1>',
'    </div>',
'  </div>',
'  <div class="t-BreadcrumbRegion-buttons">#PREVIOUS##CLOSE##DELETE##HELP##CHANGE##EDIT##COPY##CREATE##NEXT#</div>',
'</div>'))
,p_page_plug_template_name=>'Title Bar'
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BreadcrumbRegion--showBreadcrumb'
,p_preset_template_options=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2530016523834132090
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_template(
 p_id=>wwv_flow_api.id(16222192630317944)
,p_layout=>'TABLE'
,p_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Wizard #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>',
'  <div class="t-Wizard-header">',
'    <h1 class="t-Wizard-title">#TITLE#</h1>',
'    <div class="u-Table t-Wizard-controls">',
'      <div class="u-Table-fit t-Wizard-buttons">#PREVIOUS##CLOSE#</div>',
'      <div class="u-Table-fill t-Wizard-steps">',
'        #BODY#',
'      </div>',
'      <div class="u-Table-fit t-Wizard-buttons">#NEXT#</div>',
'    </div>',
'  </div>',
'  <div class="t-Wizard-body">',
'    #SUB_REGIONS#',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Wizard Container'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Wizard--hideStepsXSmall'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2117602213152591491
,p_translate_this_template=>'N'
);
wwv_flow_api.create_plug_tmpl_display_point(
 p_id=>wwv_flow_api.id(16222254217317944)
,p_plug_template_id=>wwv_flow_api.id(16222192630317944)
,p_name=>'Wizard Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/list
begin
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16230345291317955)
,p_list_template_current=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value"><a href="#LINK#" #A03#>#A01#</a></span>',
'</li>',
''))
,p_list_template_noncurrent=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <span class="t-BadgeList-label">#TEXT#</span>',
'  <span class="t-BadgeList-value"><a href="#LINK#" #A03#>#A01#</a></span>',
'</li>',
''))
,p_list_template_name=>'Badge List'
,p_theme_id=>42
,p_theme_class_id=>3
,p_default_template_options=>'t-BadgeList--responsive'
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed'
,p_list_template_before_rows=>'<ul class="t-BadgeList t-BadgeList--circular #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Value'
,p_a02_label=>'List item CSS Classes'
,p_a03_label=>'Link Attributes'
,p_reference_id=>2062482847268086664
,p_list_template_comment=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'A01: Large Number',
'A02: List Item Classes',
'A03: Link Attributes'))
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16232070186317959)
,p_list_template_current=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#TEXT#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_name=>'Cards'
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Cards--3cols:t-Cards--featured'
,p_list_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Secondary Information'
,p_a03_label=>'Initials'
,p_a04_label=>'List Item CSS Classes'
,p_reference_id=>2885322685880632508
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16234188221317960)
,p_list_template_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #IMAGE#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#'
||'</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #IMAGE#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#</span></a>'
||'</li>'
,p_list_template_name=>'Links List'
,p_theme_id=>42
,p_theme_class_id=>18
,p_list_template_before_rows=>'<ul class="t-LinksList #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<ul class="t-LinksList-list">'
,p_after_sub_list=>'</ul>'
,p_sub_list_item_current=>'<li class="t-LinksList-item is-current #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-b'
||'adge">#A01#</span></a></li>'
,p_sub_list_item_noncurrent=>'<li class="t-LinksList-item#A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#<'
||'/span></a></li>'
,p_item_templ_curr_w_child=>'<li class="t-LinksList-item is-current is-expanded #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #IMAGE#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-'
||'badge">#A01#</span></a>#SUB_LISTS#</li>'
,p_item_templ_noncurr_w_child=>'<li class="t-LinksList-item #A03#"><a href="#LINK#" class="t-LinksList-link" #A02#><span class="t-LinksList-icon"><span class="t-Icon #IMAGE#"></span></span><span class="t-LinksList-label">#TEXT#</span><span class="t-LinksList-badge">#A01#</span></a>'
||'</li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'Link Attributes'
,p_a03_label=>'List Item CSS Classes'
,p_reference_id=>4070914341144059318
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16234966380317961)
,p_list_template_current=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item is-active #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item  #A04#">',
'    <a href="#LINK#" class="t-MediaList-itemWrap" #A03#>',
'        <div class="t-MediaList-iconWrap">',
'            <span class="t-MediaList-icon"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'        </div>',
'        <div class="t-MediaList-body">',
'            <h3 class="t-MediaList-title">#TEXT#</h3>',
'            <p class="t-MediaList-desc">#A01#</p>',
'        </div>',
'        <div class="t-MediaList-badgeWrap">',
'            <span class="t-MediaList-badge">#A02#</span>',
'        </div>',
'    </a>',
'</li>'))
,p_list_template_name=>'Media List'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-MediaList--showDesc:t-MediaList--showIcons'
,p_list_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'List Item CSS Classes'
,p_reference_id=>2066548068783481421
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16235864890317962)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Menu Bar'
,p_javascript_code_onload=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  if ( apex.actions ) {',
'    apex.actions.addFromMarkup( e );',
'  } else {',
'    apex.debug.warn("Include actions.js to support menu shortcuts");',
'  }',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  iconType: ''fa'',',
'  slide: e.hasClass("js-slide"),',
'  menubar: true,',
'  menubarOverflow: true',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-showSubMenuIcons'
,p_list_template_before_rows=>'<div class="t-MenuBar #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_reference_id=>2008709236185638887
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16236334147317962)
,p_list_template_current=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_noncurrent=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_name=>'Menu Popup'
,p_javascript_code_onload=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menu", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  if ( apex.actions ) {',
'    apex.actions.addFromMarkup( e );',
'  } else {',
'    apex.debug.warn("Include actions.js to support menu shortcuts");',
'  }',
'}',
'e.menu({ slide: e.hasClass("js-slide")});',
''))
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<div id="#PARENT_STATIC_ID#_menu" class="#COMPONENT_CSS_CLASSES#" style="display:none;"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Data ID'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute'
,p_a05_label=>'Shortcut'
,p_reference_id=>3492264004432431646
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16236424497317963)
,p_list_template_current=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" role="button">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" role="button">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Navigation Bar'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<ul class="t-NavigationBar #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<div class="t-NavigationBar-menu" style="display: none" id="menu_#PARENT_LIST_ITEM_ID#"><ul>'
,p_after_sub_list=>'</ul></div></li>'
,p_sub_list_item_current=>'<li><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li><a href="#LINK#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_item_templ_noncurr_w_child=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar js-menuButton" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#"></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow"></span>',
'  </button>'))
,p_sub_templ_curr_w_child=>'<li><a href="#LINK#">#TEXT_ESC_SC#</a><ul>'
,p_sub_templ_noncurr_w_child=>'<li><a href="#LINK#">#TEXT_ESC_SC#</a><ul>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'List  Item CSS Classes'
,p_reference_id=>2846096252961119197
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16236551809317963)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Side Navigation Menu'
,p_javascript_file_urls=>'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.treeView#MIN#.js?v=#APEX_VERSION#'
,p_javascript_code_onload=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'$(''body'').addClass(''t-PageBody--leftNav'');',
''))
,p_theme_id=>42
,p_theme_class_id=>19
,p_list_template_before_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Body-nav t-Body-nav--dark" id="t_Body_nav" role="navigation" aria-label="&APP_TITLE!ATTR.">',
'<div class="t-TreeNav #COMPONENT_CSS_CLASSES#" id="t_TreeNav" data-id="#PARENT_STATIC_ID#_tree" aria-label="&APP_TITLE!ATTR."><ul style="display:none">'))
,p_list_template_after_rows=>'</ul></div></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled True/False'
,p_a04_label=>'Title'
,p_reference_id=>2466292414354694776
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16236643091317964)
,p_list_template_current=>'<li class="t-Tabs-item is-active"><a href="#LINK#" class="t-Tabs-link"><span class="t-Icon #IMAGE#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_noncurrent=>'<li class="t-Tabs-item"><a href="#LINK#" class="t-Tabs-link"><span class="t-Icon #IMAGE#"></span><span class="t-Tabs-label">#TEXT#</span></a></li>'
,p_list_template_name=>'Tabs'
,p_theme_id=>42
,p_theme_class_id=>7
,p_list_template_before_rows=>'<ul class="t-Tabs #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>3288206686691809997
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16237558124317964)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Top Navigation Menu'
,p_javascript_code_onload=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  if ( apex.actions ) {',
'    apex.actions.addFromMarkup( e );',
'  } else {',
'    apex.debug.warn("Include actions.js to support menu shortcuts");',
'  }',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  slide: e.hasClass("js-slide"),',
'  menubar: true,',
'  menubarOverflow: true',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-tabLike'
,p_list_template_before_rows=>'<div class="t-Header-nav-list #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul style="display:none">'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#IMAGE#"><a href="#LINK#" title="#A04#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled True / False'
,p_a03_label=>'Hide'
,p_a04_label=>'Title Attribute'
,p_a05_label=>'Shortcut Key'
,p_reference_id=>2525307901300239072
);
wwv_flow_api.create_list_template(
 p_id=>wwv_flow_api.id(16238013536317965)
,p_list_template_current=>'<li class="t-WizardSteps-step is-active" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"></span></span></div></li>'
,p_list_template_noncurrent=>'<li class="t-WizardSteps-step" id="#LIST_ITEM_ID#"><div class="t-WizardSteps-wrap"><span class="t-WizardSteps-marker"><span class="t-Icon a-Icon icon-check"></span></span><span class="t-WizardSteps-label">#TEXT# <span class="t-WizardSteps-labelState"'
||'></span></span></div></li>'
,p_list_template_name=>'Wizard Progress'
,p_javascript_code_onload=>'apex.theme.initWizardProgressBar();'
,p_theme_id=>42
,p_theme_class_id=>17
,p_preset_template_options=>'t-WizardSteps--displayLabels'
,p_list_template_before_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<h2 class="u-VisuallyHidden">#CURRENT_PROGRESS#</h2>',
'<ul class="t-WizardSteps #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'))
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>2008702338707394488
);
end;
/
prompt --application/shared_components/user_interface/templates/report
begin
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(16222764104317945)
,p_row_template_name=>'Alerts'
,p_row_template1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title">#ALERT_TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #ALERT_DESC#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      #ALERT_ACTION#',
'    </div>',
'  </div>',
'</div>'))
,p_row_template_before_rows=>'<div class="t-Alerts">'
,p_row_template_after_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</div>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>14
,p_reference_id=>2881456138952347027
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(16222826418317946)
,p_row_template_name=>'Badge List'
,p_row_template1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item">',
'  <span class="t-BadgeList-label">#COLUMN_HEADER#</span>',
'  <span class="t-BadgeList-value">#COLUMN_VALUE#</span>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-BadgeList t-BadgeList--circular #COMPONENT_CSS_CLASSES#">'
,p_row_template_after_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BadgeList--responsive'
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed'
,p_reference_id=>2103197159775914759
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(16224546139317949)
,p_row_template_name=>'Cards'
,p_row_template1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <a href="#CARD_LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon"><span class="t-Icon #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'    </a>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_cards">'
,p_row_template_after_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Cards--3cols:t-Cards--featured'
,p_reference_id=>2973535649510699732
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(16226650545317950)
,p_row_template_name=>'Comments'
,p_row_template1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item #COMMENT_MODIFIERS#">',
'    <div class="t-Comments-icon a-MediaBlock-graphic">',
'        <div class="t-Comments-userIcon #ICON_MODIFIER#" aria-hidden="true">#USER_ICON#</div>',
'    </div>',
'    <div class="t-Comments-body a-MediaBlock-content">',
'        <div class="t-Comments-info">',
'            #USER_NAME# &middot; <span class="t-Comments-date">#COMMENT_DATE#</span> <span class="t-Comments-actions">#ACTIONS#</span>',
'        </div>',
'        <div class="t-Comments-comment">',
'            #COMMENT_TEXT##ATTRIBUTE_1##ATTRIBUTE_2##ATTRIBUTE_3##ATTRIBUTE_4#',
'        </div>',
'    </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Comments #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report">'
,p_row_template_after_rows=>'</ul>'
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Comments--chat'
,p_reference_id=>2611722012730764232
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(16227008666317951)
,p_row_template_name=>'Search Results'
,p_row_template1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition1=>':LABEL_02 is null'
,p_row_template2=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition2=>':LABEL_03 is null'
,p_row_template3=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition3=>':LABEL_04 is null'
,p_row_template4=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'      <span class="t-SearchResults-misc">#LABEL_04#: #VALUE_04#</span>',
'    </div>',
'  </li>'))
,p_row_template_before_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-SearchResults #COMPONENT_CSS_CLASSES#">',
'<ul class="t-SearchResults-list">'))
,p_row_template_after_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>',
'</div>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'NOT_CONDITIONAL'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070913431524059316
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(16227141617317951)
,p_row_template_name=>'Standard'
,p_row_template1=>'<td class="t-Report-cell" #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>'
,p_row_template_before_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Report #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES#>',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation">#TOP_PAGINATION#</table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" summary="#REGION_TITLE#">'))
,p_row_template_after_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'      </tbody>',
'    </table>',
'    </div>',
'    <div class="t-Report-links">#EXTERNAL_LINK##CSV_LINK#</div>',
'    <table class="t-Report-pagination t-Report-pagination--bottom" role="presentation">#PAGINATION#</table>',
'  </div>',
'</div>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_before_column_heading=>'<thead>'
,p_column_heading_template=>'<th class="t-Report-colHead" #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>'
,p_after_column_heading=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</thead>',
'<tbody>'))
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Report--altRowsDefault:t-Report--rowHighlight'
,p_reference_id=>2537207537838287671
,p_translate_this_template=>'N'
);
begin
wwv_flow_api.create_row_template_patch(
 p_id=>wwv_flow_api.id(16227141617317951)
,p_row_template_before_first=>'<tr>'
,p_row_template_after_last=>'</tr>'
);
exception when others then null;
end;
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(16228481611317953)
,p_row_template_name=>'Value Attribute Pairs - Column'
,p_row_template1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #COLUMN_HEADER#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #COLUMN_VALUE#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES#>'
,p_row_template_after_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068636272681754
,p_translate_this_template=>'N'
);
wwv_flow_api.create_row_template(
 p_id=>wwv_flow_api.id(16229471458317954)
,p_row_template_name=>'Value Attribute Pairs - Row'
,p_row_template1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #1#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #2#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Report-paginationLink">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068321678681753
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label
begin
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(16238552273317966)
,p_template_name=>'Hidden'
,p_template_body1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer t-Form-labelContainer--hiddenLabel col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label u-VisuallyHidden">'))
,p_template_body2=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--hiddenLabel rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#">'
,p_after_element=>'#HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>13
,p_reference_id=>2039339104148359505
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(16238622797317967)
,p_template_name=>'Optional'
,p_template_body1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</label>',
'</div>',
''))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#">'
,p_after_element=>'#HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>2317154212072806530
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(16238771736317968)
,p_template_name=>'Optional - Above'
,p_template_body1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</label>#HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer">'
,p_after_element=>'#ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>3030114864004968404
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(16238828544317968)
,p_template_name=>'Required'
,p_template_body1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label><span class="t-Form-required"><span class="a-Icon icon-asterisk"></span></span>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#">'
,p_after_element=>'#HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>2525313812251712801
,p_translate_this_template=>'N'
);
wwv_flow_api.create_field_template(
 p_id=>wwv_flow_api.id(16238934144317968)
,p_template_name=>'Required - Above'
,p_template_body1=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
' <span class="u-VisuallyHidden">(#VALUE_REQUIRED#)</span></label><span class="t-Form-required"><span class="a-Icon icon-asterisk"></span></span> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_before_element=>'<div class="t-Form-inputContainer">'
,p_after_element=>'#ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Button t-Button--noUI t-Button--helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden'
||'="true"></span></button>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>3030115129444970113
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/breadcrumb
begin
wwv_flow_api.create_menu_template(
 p_id=>wwv_flow_api.id(16239617562317971)
,p_name=>'Breadcrumb'
,p_before_first=>'<ul class="t-Breadcrumb #COMPONENT_CSS_CLASSES#">'
,p_current_page_option=>'<li class="t-Breadcrumb-item is-active"><span class="t-Breadcrumb-label">#NAME#</span></li>'
,p_non_current_page_option=>'<li class="t-Breadcrumb-item"><a href="#LINK#" class="t-Breadcrumb-label">#NAME#</a></li>'
,p_after_last=>'</ul>'
,p_max_levels=>6
,p_start_with_node=>'PARENT_TO_LEAF'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916542570059325
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/popuplov
begin
wwv_flow_api.create_popup_lov_template(
 p_id=>wwv_flow_api.id(16239830614317976)
,p_page_name=>'winlov'
,p_page_title=>'Search Dialog'
,p_page_html_head=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html lang="&BROWSER_LANGUAGE.">',
'<head>',
'<title>#TITLE#</title>',
'#APEX_CSS#',
'#THEME_CSS#',
'#THEME_STYLE_CSS#',
'#FAVICONS#',
'#APEX_JAVASCRIPT#',
'#THEME_JAVASCRIPT#',
'<meta name="viewport" content="width=device-width,initial-scale=1.0" />',
'</head>'))
,p_page_body_attr=>'onload="first_field()" class="t-Page t-Page--popupLOV"'
,p_before_field_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_filter_width=>'20'
,p_filter_max_width=>'100'
,p_filter_text_attr=>'class="t-Form-field t-Form-searchField"'
,p_find_button_text=>'Search'
,p_find_button_attr=>'class="t-Button t-Button--hot t-Button--padLeft"'
,p_close_button_text=>'Close'
,p_close_button_attr=>'class="t-Button u-pullRight"'
,p_next_button_text=>'Next &gt;'
,p_next_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_prev_button_text=>'&lt; Previous'
,p_prev_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_after_field_text=>'</div>'
,p_scrollbars=>'1'
,p_resizable=>'1'
,p_width=>'380'
,p_height=>'380'
,p_result_row_x_of_y=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_result_rows_per_pg=>100
,p_before_result_set=>'<div class="t-PopupLOV-links">'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>2885398517835871876
,p_translate_this_template=>'N'
,p_after_result_set=>'</div>'
);
end;
/
prompt --application/shared_components/user_interface/templates/calendar
begin
wwv_flow_api.create_calendar_template(
 p_id=>wwv_flow_api.id(16239757640317973)
,p_cal_template_name=>'Calendar'
,p_day_of_week_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_month_title_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" summary="#IMONTH# #YYYY#">'
,p_month_close_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</table>',
'</div>',
''))
,p_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_day_close_format=>'</td>'
,p_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_close_format=>'</td>'
,p_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_nonday_close_format=>'</td>'
,p_week_open_format=>'<tr>'
,p_week_close_format=>'</tr> '
,p_daily_title_format=>'<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>'
,p_daily_open_format=>'<tr>'
,p_daily_close_format=>'</tr>'
,p_weekly_title_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--weekly">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_weekly_day_of_week_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_weekly_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_weekly_month_close_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_weekly_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_day_close_format=>'</div></td>'
,p_weekly_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_close_format=>'</div></td>'
,p_weekly_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_weekly_time_close_format=>'</th>'
,p_weekly_time_title_format=>'#TIME#'
,p_weekly_hour_open_format=>'<tr>'
,p_weekly_hour_close_format=>'</tr>'
,p_daily_day_of_week_format=>'<th scope="col" id="#DY#" class="t-ClassicCalendar-dayColumn">#IDAY#</th>'
,p_daily_month_title_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--daily">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #DD#, #YYYY#</h1>'))
,p_daily_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL#" class="t-ClassicCalendar-calendar">'
,p_daily_month_close_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_daily_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_day_close_format=>'</div></td>'
,p_daily_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol" id="#TIME#">'
,p_daily_time_close_format=>'</th>'
,p_daily_time_title_format=>'#TIME#'
,p_daily_hour_open_format=>'<tr>'
,p_daily_hour_close_format=>'</tr>'
,p_cust_month_title_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="uCal">',
'<h1 class="uMonth">#IMONTH# <span>#YYYY#</span></h1>'))
,p_cust_day_of_week_format=>'<th scope="col" class="uCalDayCol" id="#DY#">#IDAY#</th>'
,p_cust_month_open_format=>'<table class="uCal" cellpadding="0" cellspacing="0" border="0" summary="#IMONTH# #YYYY#">'
,p_cust_month_close_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</table>',
'<div class="uCalFooter"></div>',
'</div>',
''))
,p_cust_week_open_format=>'<tr>'
,p_cust_week_close_format=>'</tr> '
,p_cust_day_title_format=>'<span class="uDayTitle">#DD#</span>'
,p_cust_day_open_format=>'<td class="uDay" headers="#DY#"><div class="uDayData">'
,p_cust_day_close_format=>'</td>'
,p_cust_today_open_format=>'<td class="uDay today" headers="#DY#">'
,p_cust_nonday_title_format=>'<span class="uDayTitle">#DD#</span>'
,p_cust_nonday_open_format=>'<td class="uDay nonday" headers="#DY#">'
,p_cust_nonday_close_format=>'</td>'
,p_cust_weekend_title_format=>'<span class="uDayTitle weekendday">#DD#</span>'
,p_cust_weekend_open_format=>'<td class="uDay" headers="#DY#">'
,p_cust_weekend_close_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="uDayData">#DATA#</span>',
'</td>'))
,p_cust_hour_open_format=>'<tr>'
,p_cust_hour_close_format=>'</tr>'
,p_cust_time_title_format=>'#TIME#'
,p_cust_time_open_format=>'<th scope="row" class="uCalHour" id="#TIME#">'
,p_cust_time_close_format=>'</th>'
,p_cust_wk_month_title_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="uCal uCalWeekly">',
'<h1 class="uMonth">#WTITLE#</h1>'))
,p_cust_wk_day_of_week_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<th scope="col" class="uCalDayCol" id="#DY#">',
'  <span class="visible-desktop">#DD# #IDAY#</span>',
'  <span class="hidden-desktop">#DD# <em>#IDY#</em></span>',
'</th>'))
,p_cust_wk_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="uCal">'
,p_cust_wk_month_close_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'</table>',
'<div class="uCalFooter"></div>',
'</div>'))
,p_cust_wk_week_open_format=>'<tr>'
,p_cust_wk_week_close_format=>'</tr> '
,p_cust_wk_day_title_format=>'<span class="uDayTitle">#DD#</span>'
,p_cust_wk_day_open_format=>'<td class="uDay" headers="#DY#"><div class="uDayData">'
,p_cust_wk_day_close_format=>'</div></td>'
,p_cust_wk_today_open_format=>'<td class="uDay today" headers="#DY#"><div class="uDayData">'
,p_cust_wk_weekend_open_format=>'<td class="uDay weekend" headers="#DY#"><div class="uDayData">'
,p_cust_wk_weekend_close_format=>'</div></td>'
,p_agenda_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--list">',
'  <div class="t-ClassicCalendar-title">#IMONTH# #YYYY#</div>',
'  <ul class="t-ClassicCalendar-list">',
'    #DAYS#',
'  </ul>',
'</div>'))
,p_agenda_past_day_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-past">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_today_day_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-today">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_future_day_format=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-future">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_past_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-past">#DATA#</li>'
,p_agenda_today_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-today">#DATA#</li>'
,p_agenda_future_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-future">#DATA#</li>'
,p_month_data_format=>'#DAYS#'
,p_month_data_entry_format=>'<span class="t-ClassicCalendar-event">#DATA#</span>'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916747979059326
);
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(16240207338317985)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(16207520075317915)
,p_default_dialog_template=>wwv_flow_api.id(16206283707317913)
,p_error_template=>wwv_flow_api.id(16204139811317908)
,p_printer_friendly_template=>wwv_flow_api.id(16207520075317915)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(16204139811317908)
,p_default_button_template=>wwv_flow_api.id(16239148892317970)
,p_default_region_template=>wwv_flow_api.id(16218364978317939)
,p_default_chart_template=>wwv_flow_api.id(16218364978317939)
,p_default_form_template=>wwv_flow_api.id(16218364978317939)
,p_default_reportr_template=>wwv_flow_api.id(16218364978317939)
,p_default_tabform_template=>wwv_flow_api.id(16218364978317939)
,p_default_wizard_template=>wwv_flow_api.id(16218364978317939)
,p_default_menur_template=>wwv_flow_api.id(16221620630317943)
,p_default_listr_template=>wwv_flow_api.id(16218364978317939)
,p_default_irr_template=>wwv_flow_api.id(16217862042317938)
,p_default_report_template=>wwv_flow_api.id(16227141617317951)
,p_default_label_template=>wwv_flow_api.id(16238622797317967)
,p_default_menu_template=>wwv_flow_api.id(16239617562317971)
,p_default_calendar_template=>wwv_flow_api.id(16239757640317973)
,p_default_list_template=>wwv_flow_api.id(16234188221317960)
,p_default_nav_list_template=>wwv_flow_api.id(16237558124317964)
,p_default_top_nav_list_temp=>wwv_flow_api.id(16237558124317964)
,p_default_side_nav_list_temp=>wwv_flow_api.id(16236551809317963)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(16210399753317931)
,p_default_dialogr_template=>wwv_flow_api.id(16210264139317931)
,p_default_option_label=>wwv_flow_api.id(16238622797317967)
,p_default_required_label=>wwv_flow_api.id(16238828544317968)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(16236424497317963)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.0/')
,p_files_version=>62
,p_icon_library=>'FONTAWESOME'
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.regionDisplaySelector#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#tooltipManager#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#libraries/hammer/2.0.3/hammer#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/modernizr-custom#MIN#.js?v=#APEX_VERSION#',
'#IMAGE_PREFIX#plugins/com.oracle.apex.carousel/1.0/com.oracle.apex.carousel#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(16239959390317978)
,p_theme_id=>42
,p_name=>'Vista'
,p_css_file_urls=>'#THEME_IMAGES#css/Vista#MIN#.css?v=#APEX_VERSION#'
,p_is_current=>false
,p_theme_roller_read_only=>true
,p_reference_id=>4007676303523989775
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(16240003749317979)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>true
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_api.create_theme_style(
 p_id=>wwv_flow_api.id(16240155928317979)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>false
,p_theme_roller_input_file_urls=>'#THEME_IMAGES#less/theme/Vita-Slate.less'
,p_theme_roller_config=>'{"customCSS":"","vars":{"@g_Accent-BG":"#505f6d","@g_Accent-OG":"#ececec","@g_Body-Title-BG":"#dee1e4","@l_Link-Base":"#337ac0","@g_Body-BG":"#f5f5f5"}}'
,p_theme_roller_output_file_url=>'#THEME_IMAGES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/theme_display_points
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16209088522317929)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16209273992317930)
,p_theme_id=>42
,p_name=>'ALERT_ICONS'
,p_display_name=>'Alert Icons'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets how icons are handled for the Alert Region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16209451313317930)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16210694657317931)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the region is styled. Use the "Remove Borders" template option to remove the region''s borders and shadows.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16210883970317931)
,p_theme_id=>42
,p_name=>'BODY_PADDING'
,p_display_name=>'Body Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body padding for the region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16211545521317932)
,p_theme_id=>42
,p_name=>'TIMER'
,p_display_name=>'Timer'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets the timer for when to automatically navigate to the next region within the Carousel Region.'
,p_null_text=>'No Timer'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16211934365317932)
,p_theme_id=>42
,p_name=>'BODY_HEIGHT'
,p_display_name=>'Body Height'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body height. You can also specify a custom height by modifying the Region''s CSS Classes and using the height helper classes "i-hXXX" where XXX is any increment of 10 from 100 to 800.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16212506700317933)
,p_theme_id=>42
,p_name=>'ACCENT'
,p_display_name=>'Accent'
,p_display_sequence=>30
,p_template_types=>'REGION'
,p_help_text=>'Set the Region''s accent. This accent corresponds to a Theme-Rollable color and sets the background of the Region''s Header.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16213187872317933)
,p_theme_id=>42
,p_name=>'HEADER'
,p_display_name=>'Header'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Determines the display of the Region Header which also contains the Region Title.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16213372766317933)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16214206848317933)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the animation when navigating within the Carousel Region.'
,p_null_text=>'Fade'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16215835497317934)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16217216680317935)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16220733155317943)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16220969380317943)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16221321824317943)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16221771996317943)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16222367686317944)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16222912690317947)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16223160266317947)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16224796400317949)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'REPORT'
,p_help_text=>'Determines the amount of text to display for the Card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16225444600317950)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Controls the style and design of the cards in the report.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16225726840317950)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Controls how to handle icons in the report.'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16226438241317950)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16226738458317950)
,p_theme_id=>42
,p_name=>'COMMENTS_STYLE'
,p_display_name=>'Comments Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the style in which comments are displayed.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16227214912317953)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16227538766317953)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16227745759317953)
,p_theme_id=>42
,p_name=>'REPORT_BORDER'
,p_display_name=>'Report Border'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of the Report''s borders.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16228502013317953)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16230467795317958)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16231208143317958)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16232259099317959)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'LIST'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16232958428317960)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16233254948317960)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16233978466317960)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16234692670317961)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16237041252317964)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16238103637317965)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16239372085317970)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16240346896317986)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16240593864317986)
,p_theme_id=>42
,p_name=>'SPACING_LEFT'
,p_display_name=>'Spacing Left'
,p_display_sequence=>70
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the left of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16240788179317986)
,p_theme_id=>42
,p_name=>'SPACING_RIGHT'
,p_display_name=>'Spacing Right'
,p_display_sequence=>80
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the right of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16240929250317986)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the size of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16241139732317987)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>30
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the style of the button. Use the "Simple" option for secondary actions or sets of buttons. Use the "Remove UI Decoration" option to make the button appear as text.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16241544563317987)
,p_theme_id=>42
,p_name=>'BUTTON_SET'
,p_display_name=>'Button Set'
,p_display_sequence=>40
,p_template_types=>'BUTTON'
,p_help_text=>'Enables you to group many buttons together into a pill. You can use this option to specify where the button is within this set. Set the option to Default if this button is not part of a button set.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16242228723317987)
,p_theme_id=>42
,p_name=>'WIDTH'
,p_display_name=>'Width'
,p_display_sequence=>60
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the width of the button.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16242647550317987)
,p_theme_id=>42
,p_name=>'LABEL_POSITION'
,p_display_name=>'Label Position'
,p_display_sequence=>140
,p_template_types=>'REGION'
,p_help_text=>'Sets the position of the label relative to the form item.'
,p_null_text=>'Inline - Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16242804358317987)
,p_theme_id=>42
,p_name=>'ITEM_SIZE'
,p_display_name=>'Item Size'
,p_display_sequence=>110
,p_template_types=>'REGION'
,p_help_text=>'Sets the size of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16243060721317988)
,p_theme_id=>42
,p_name=>'LABEL_ALIGNMENT'
,p_display_name=>'Label Alignment'
,p_display_sequence=>130
,p_template_types=>'REGION'
,p_help_text=>'Set the label text alignment for items within this region.'
,p_null_text=>'Right'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16243252747317989)
,p_theme_id=>42
,p_name=>'ITEM_PADDING'
,p_display_name=>'Item Padding'
,p_display_sequence=>100
,p_template_types=>'REGION'
,p_help_text=>'Sets the padding around items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16243505639317989)
,p_theme_id=>42
,p_name=>'ITEM_WIDTH'
,p_display_name=>'Item Width'
,p_display_sequence=>120
,p_template_types=>'REGION'
,p_help_text=>'Sets the width of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_api.create_template_opt_group(
 p_id=>wwv_flow_api.id(16243839455317989)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/user_interface/template_options
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16208915189317925)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16209149203317930)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_api.id(16209088522317929)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16209396452317930)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_api.id(16209273992317930)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16209577197317930)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_api.id(16209451313317930)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16209675931317930)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_api.id(16209088522317929)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16209729974317930)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_api.id(16209273992317930)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16209854776317930)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_api.id(16209088522317929)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16209906157317930)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_api.id(16209273992317930)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16210034407317931)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_api.id(16209088522317929)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16210125380317931)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16208747833317918)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_api.id(16209451313317930)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16210700481317931)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(16210399753317931)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16210910129317931)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_api.id(16210399753317931)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_api.id(16210883970317931)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16211042039317931)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_api.id(16210399753317931)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16211123087317931)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_api.id(16210399753317931)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_api.id(16210883970317931)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16211696564317932)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_api.id(16211545521317932)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16211756370317932)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_api.id(16211545521317932)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16211882600317932)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_api.id(16211545521317932)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212007323317932)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212166848317932)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212263733317932)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212332835317932)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_api.id(16211545521317932)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212451054317932)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212625109317933)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212746666317933)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212841395317933)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16212956729317933)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16213018962317933)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16213284873317933)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(16213187872317933)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16213499203317933)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(16213372766317933)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16213516954317933)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(16213187872317933)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16213628638317933)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16213785274317933)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16213810527317933)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16213933807317933)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(16213372766317933)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16214042549317933)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16214167627317933)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16214379858317933)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_api.id(16214206848317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16214409957317934)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_api.id(16214206848317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16214532989317934)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16211257581317931)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16214992561317934)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215057352317934)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215185088317934)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215245368317934)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215381774317934)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215472155317934)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215503564317934)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215670816317934)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215739843317934)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16215989146317934)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_api.id(16215835497317934)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16216025988317934)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_api.id(16215835497317934)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16216183077317934)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(16213372766317933)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16216247612317935)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16216352157317935)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16216464372317935)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16216585846317935)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(16213372766317933)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16216631638317935)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16214611855317934)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16217146162317935)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16216946420317935)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16217334981317935)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16216946420317935)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_api.id(16217216680317935)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16217465822317935)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16216946420317935)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_api.id(16217216680317935)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16217592515317935)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16216946420317935)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16217681120317938)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16216946420317935)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16217726183317938)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16216946420317935)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_api.id(16217216680317935)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16217912219317939)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16217862042317938)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16218055671317939)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16217862042317938)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16218682710317939)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16218765846317939)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16218843306317939)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16218933650317939)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_api.id(16211934365317932)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219072175317939)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219115657317939)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219222084317940)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219392567317940)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219420796317942)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_api.id(16212506700317933)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219505120317942)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_api.id(16213187872317933)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219608287317942)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_api.id(16213372766317933)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219731852317942)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_api.id(16213187872317933)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219805350317942)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16219936634317942)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16220071748317942)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16220127507317942)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_api.id(16213372766317933)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16220296490317942)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16220390163317943)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16218364978317939)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_api.id(16210694657317931)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16220847498317943)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16220423538317943)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_api.id(16220733155317943)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16221066081317943)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16220423538317943)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_api.id(16220969380317943)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16221151467317943)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16220423538317943)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16221271879317943)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16220423538317943)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_api.id(16220969380317943)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16221419616317943)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16220423538317943)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_api.id(16221321824317943)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16221544859317943)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16220423538317943)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_api.id(16221321824317943)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16221827350317943)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(16221620630317943)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_api.id(16221771996317943)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16221952637317943)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(16221620630317943)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16222074310317943)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_api.id(16221620630317943)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_api.id(16221771996317943)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16222415368317944)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_api.id(16222192630317944)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_api.id(16222367686317944)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16222523038317944)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16222192630317944)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_api.id(16222367686317944)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16222646633317944)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_api.id(16222192630317944)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223077987317947)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(16222912690317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223283821317947)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223338547317947)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(16222912690317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223485719317947)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223501163317948)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(16222912690317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223675419317948)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223796438317948)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223854022317948)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(16222912690317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16223943009317948)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(16222912690317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16224030804317949)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16224129631317949)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16224269549317949)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16224334782317949)
,p_theme_id=>42
,p_name=>'RESPONSIVE'
,p_display_name=>'Responsive'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--responsive'
,p_template_types=>'REPORT'
,p_help_text=>'Automatically resize badges to smaller sizes as screen becomes smaller.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16224402069317949)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16222826418317946)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16224643562317949)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16224871757317949)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(16224796400317949)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16224929463317949)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16225009551317949)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(16224796400317949)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16225102257317950)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16225299748317950)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(16224796400317949)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16225354410317950)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16225502426317950)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(16225444600317950)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16225661988317950)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(16225444600317950)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16225848300317950)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(16225726840317950)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16225926955317950)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(16225726840317950)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16226086539317950)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--featured'
,p_group_id=>wwv_flow_api.id(16225444600317950)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16226186844317950)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16226243374317950)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(16224796400317949)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16226390845317950)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16226599210317950)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Use Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16224546139317949)
,p_css_classes=>'t-Cards--colorize'
,p_group_id=>wwv_flow_api.id(16226438241317950)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16226862938317950)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16226650545317950)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_api.id(16226738458317950)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16226943518317951)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16226650545317950)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_api.id(16226738458317950)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16227348859317953)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_api.id(16227214912317953)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16227436787317953)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_api.id(16227214912317953)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16227652302317953)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_api.id(16227538766317953)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16227890997317953)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_api.id(16227745759317953)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16227914875317953)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_api.id(16227745759317953)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16228073335317953)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_api.id(16227745759317953)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16228149676317953)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_api.id(16227538766317953)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16228267975317953)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16228387180317953)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16227141617317951)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_api.id(16227745759317953)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16228648399317953)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(16228481611317953)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16228707710317953)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16228481611317953)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16228857240317953)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16228481611317953)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16228981028317953)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16228481611317953)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229097473317953)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16228481611317953)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229189721317954)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(16228481611317953)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229210992317954)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(16228481611317953)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229376379317954)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(16228481611317953)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229597600317954)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_api.id(16229471458317954)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229674703317954)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16229471458317954)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229793240317954)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16229471458317954)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229839168317954)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_api.id(16229471458317954)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16229920471317954)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_api.id(16229471458317954)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_api.id(16223160266317947)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16230046331317954)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_api.id(16229471458317954)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16230184586317954)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_api.id(16229471458317954)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16230236730317954)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_api.id(16229471458317954)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_api.id(16228502013317953)
,p_template_types=>'REPORT'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16230559541317958)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16230685720317958)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16230700385317958)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16230836015317958)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16230990862317958)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231093221317958)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231135682317958)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231380310317958)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_api.id(16231208143317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231434207317958)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_api.id(16231208143317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231524524317958)
,p_theme_id=>42
,p_name=>'RESPONSIVE'
,p_display_name=>'Responsive'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--responsive'
,p_template_types=>'LIST'
,p_help_text=>'Automatically resize badges to smaller sizes as screen becomes smaller.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231641713317958)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_api.id(16231208143317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231746303317959)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231855093317959)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'.t-BadgeList--xlarge'
,p_group_id=>wwv_flow_api.id(16231208143317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16231921452317959)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(16230345291317955)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_api.id(16231208143317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16232189549317959)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16232389776317959)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_api.id(16232259099317959)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16232497056317959)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16232540093317959)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_api.id(16232259099317959)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16232665942317959)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16232761453317959)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_api.id(16232259099317959)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16232838535317960)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
);
end;
/
begin
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16233077873317960)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_api.id(16232958428317960)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16233120000317960)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_api.id(16232958428317960)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16233374178317960)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_api.id(16233254948317960)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16233402272317960)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_api.id(16233254948317960)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16233529841317960)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--featured'
,p_group_id=>wwv_flow_api.id(16232958428317960)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16233651653317960)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16233749263317960)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_api.id(16232259099317959)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16233870674317960)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16234013814317960)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Use Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_css_classes=>'t-Cards--colorize'
,p_group_id=>wwv_flow_api.id(16233978466317960)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16234202981317961)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16234188221317960)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_api.id(16232958428317960)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16234347710317961)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16234188221317960)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16234413440317961)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16234188221317960)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16234523399317961)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16234188221317960)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16234763025317961)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16234188221317960)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_api.id(16234692670317961)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16234871073317961)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16234188221317960)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_api.id(16234692670317961)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235087637317961)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235136185317961)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235278530317961)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235306537317961)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235447271317962)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235566330317962)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235619930317962)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Shows an icon for each list item.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235741582317962)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16235909360317962)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_api.id(16235864890317962)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16236018458317962)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16235864890317962)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16236182262317962)
,p_theme_id=>42
,p_name=>'ENABLE_SLIDE_ANIMATION'
,p_display_name=>'Enable Slide Animation'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16235864890317962)
,p_css_classes=>'js-slide'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16236298474317962)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16235864890317962)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16236718256317964)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16236643091317964)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_api.id(16233254948317960)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16236808690317964)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(16236643091317964)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_api.id(16230467795317958)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16236961326317964)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16236643091317964)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_api.id(16233254948317960)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16237171223317964)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16236643091317964)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_api.id(16237041252317964)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16237280638317964)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16236643091317964)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_api.id(16232958428317960)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16237342975317964)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16236643091317964)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_api.id(16232958428317960)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16237421323317964)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_api.id(16236643091317964)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_api.id(16237041252317964)
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16237638175317964)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(16237558124317964)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16237730957317964)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(16237558124317964)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16237869110317964)
,p_theme_id=>42
,p_name=>'ENABLE_SLIDE_ANIMATION'
,p_display_name=>'Enable Slide Animation'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(16237558124317964)
,p_css_classes=>'js-slide'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16237991902317965)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_api.id(16237558124317964)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16238221284317965)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_api.id(16238013536317965)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_api.id(16238103637317965)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16238318303317965)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_api.id(16238013536317965)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_api.id(16238103637317965)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16238454866317965)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_api.id(16238013536317965)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_api.id(16238103637317965)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16239446234317970)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_api.id(16239202992317970)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_api.id(16239372085317970)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16239572139317971)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_api.id(16239202992317970)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_api.id(16239372085317970)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16240419781317986)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_api.id(16240346896317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16240687507317986)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large Left Margin'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_api.id(16240593864317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16240872408317986)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large Right Margin'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_api.id(16240788179317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16241027093317987)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_api.id(16240929250317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16241225907317987)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_api.id(16241139732317987)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16241339698317987)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small Left Margin'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_api.id(16240593864317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16241456924317987)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small Right Margin'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_api.id(16240788179317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16241610470317987)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_api.id(16241544563317987)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16241779454317987)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_api.id(16241544563317987)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16241826837317987)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_api.id(16241544563317987)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16241903840317987)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_api.id(16240346896317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16242033057317987)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_api.id(16241139732317987)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16242164603317987)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_api.id(16240929250317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16242344807317987)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_api.id(16242228723317987)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16242461325317987)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_api.id(16240346896317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16242553507317987)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_api.id(16240346896317986)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16242794231317987)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_api.id(16242647550317987)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16242990962317987)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_api.id(16242804358317987)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16243102314317988)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_api.id(16243060721317988)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16243305471317989)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_api.id(16243252747317989)
,p_template_types=>'REGION'
,p_help_text=>'Removes padding between items.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16243464640317989)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_api.id(16243252747317989)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item padding to 4px.'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16243636549317989)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_api.id(16243505639317989)
,p_template_types=>'REGION'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16243760058317989)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_api.id(16242804358317987)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16243988217317989)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_api.id(16243839455317989)
,p_template_types=>'FIELD'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16244064384317989)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_api.create_template_option(
 p_id=>wwv_flow_api.id(16244183024317989)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_api.id(16243839455317989)
,p_template_types=>'FIELD'
);
end;
/
prompt --application/shared_components/logic/build_options
begin
null;
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/globalization/translations
begin
null;
end;
/
prompt --application/shared_components/globalization/messages
begin
null;
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/user_interface/shortcuts
begin
wwv_flow_api.create_shortcut(
 p_id=>wwv_flow_api.id(19432397710958137)
,p_shortcut_name=>'NO_DATA_FOUND_MSG'
,p_shortcut_type=>'HTML_TEXT'
,p_shortcut=>'<p style="color:grey">No records in this category </p>'
);
wwv_flow_api.create_shortcut(
 p_id=>wwv_flow_api.id(25012302661393573)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_shortcut=>'Would you like to perform this delete action?'
);
end;
/
prompt --application/shared_components/security/authentications
begin
wwv_flow_api.create_authentication(
 p_id=>wwv_flow_api.id(16244517030318014)
,p_name=>'APEX'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_stripe_report
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(18947389548736691)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.STRIPE.REPORT'
,p_display_name=>'Stripe Report'
,p_category=>'EFFECT'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.STRIPE.REPORT'),'')
,p_javascript_file_urls=>'#PLUGIN_FILES#stripe_report_2_0.js'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render_stripe_report (',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_result        apex_plugin.t_dynamic_action_render_result;',
'    -- It''s better to have named variables instead of using the generic ones, makes',
'    -- the code more readable.',
'    -- If an attribute value is ''Required'' and there is a ''Default Value'' set in the ',
'    -- plug-in attribute definition, this should also be defined here.',
'    l_stripe_color  varchar2(4000) := coalesce(p_dynamic_action.attribute_01,''#FAFAFA'');',
'begin',
'    -- During plug-in development it''s very helpful to have some debug information',
'    if apex_application.g_debug then',
'        apex_plugin_util.debug_dynamic_action (',
'            p_plugin            => p_plugin,',
'            p_dynamic_action    => p_dynamic_action );',
'    end if;',
'',
'    -- ***********************************',
'    -- Here starts the actual plug-in code',
'    -- ***********************************',
'    -- Register the javascript function which should be called when the plug-in',
'    -- action is executed with the APEX client side dynamic action framework.',
'    -- The javascript function can be a named javascript function, but it can',
'    -- also be an anonymous function if the code is really short.',
'    -- For example: function(){this.affectedElements.hide(this.action.attribute01);}',
'    l_result.javascript_function    := ''com_oracle_apex_stripe_report'';',
'    l_result.attribute_01           := l_stripe_color;',
'    ',
'    return l_result;',
'end render_stripe_report;',
''))
,p_render_function=>'render_stripe_report'
,p_standard_attributes=>'ONLOAD'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'2.0'
,p_files_version=>3
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18947511520736702)
,p_plugin_id=>wwv_flow_api.id(18947389548736691)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Stripe Color'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'#FAFAFA'
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>',
'	Specify a color to be used to color the background of every alternate row in the report. Colors can be specified in 1 of 3 ways:</p>',
'<ul>',
'	<li>',
'		By Name - The name of the color, like &#39;red&#39;.</li>',
'	<li>',
'		By Hex Code - The hex code of the color, like &#39;#FAFAFA&#39;.</li>',
'	<li>',
'		By RGB Code - The rgb code of the color, like &#39;rgb(0,0,255)&#39;</li>',
'</ul>',
''))
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F20412064796E616D696320616374696F6E20706C75672D696E2066756E6374696F6E2063616E2061636365737320697427732063757272656E7420636F6E7465787420776974682074686520227468697322206F626A6563742E0A2F2F2049742063';
wwv_flow_api.g_varchar2_table(2) := '6F6E7461696E7320666F72206578616D706C652022616374696F6E222077686963682073746F726573207468652064796E616D69632061747472696275746573206174747269627574653031202D20617474726962757465313020616E640A2F2F207468';
wwv_flow_api.g_varchar2_table(3) := '6520616A61784964656E746966696572207573656420666F722074686520414A41582063616C6C2E20496E73696465207468652066756E6374696F6E20796F752063616E207573650A2F2F2022746869732E6166666563746564456C656D656E74732220';
wwv_flow_api.g_varchar2_table(4) := '746F206765742061206A5175657279206F626A65637420776869636820636F6E7461696E7320616C6C207468652061666665637465640A2F2F20444F4D20656C656D656E7473206F75722064796E616D696320616374696F6E2073686F756C6420626520';
wwv_flow_api.g_varchar2_table(5) := '706572666F726D6564206F6E2E20596F752063616E20616C736F20726566657220746F0A2F2F2022746869732E74726967676572696E67456C656D656E742220746F20676574206120444F4D20656C656D656E74206F6620746865207472696767657269';
wwv_flow_api.g_varchar2_table(6) := '6E6720656C656D656E742E0A2F2F0A2F2F20466F722064796E616D696320616374696F6E20706C75672D696E2066756E6374696F6E7320796F752073686F756C642075736520612066756E6374696F6E206E616D652077686963682069730A2F2F20756E';
wwv_flow_api.g_varchar2_table(7) := '697175652C20736F20697420646F65736E27742067657420696E20636F6E666C6963742077697468206578697374696E672066756E6374696F6E732E20426573742070726163746963650A2F2F20697320746F20757365207468652073616D65206E616D';
wwv_flow_api.g_varchar2_table(8) := '65206173207573656420666F722074686520706C75672D696E20696E7465726E616C206E616D652E0A0A66756E6374696F6E20636F6D5F6F7261636C655F617065785F7374726970655F7265706F72742829207B0A202020202F2F204465636C61726520';
wwv_flow_api.g_varchar2_table(9) := '7661726961626C65732E20496E206465616C696E672077697468206174747269627574652076616C7565732C20697427732062657474657220746F2068617665200A202020202F2F206E616D6564207661726961626C657320696E7374656164206F6620';
wwv_flow_api.g_varchar2_table(10) := '7573696E67207468652067656E65726963206F6E65732C2074686174206D616B65732074686520636F6465206D6F7265200A202020202F2F207265616461626C652E0A20202020766172206C537472697065436F6C6F723B0A0A202020202F2F20496E69';
wwv_flow_api.g_varchar2_table(11) := '7469616C69736520616C6C20746865207661726961626C65732C206261736564206F6E2074686569722061747472696275746520646566696E6974696F6E732E0A202020206C537472697065436F6C6F72203D20746869732E616374696F6E2E61747472';
wwv_flow_api.g_varchar2_table(12) := '696275746530313B0A202020200A202020202F2F2027746869732E74726967676572696E67456C656D656E74272069732074686520444F4D20656C656D656E74206F662074686520726567696F6E20636F6E7461696E696E670A202020202F2F20746865';
wwv_flow_api.g_varchar2_table(13) := '20496E746572616374697665205265706F7274207370656369666965642061732074686520275768656E272074726967676572696E6720656C656D656E742E20546869730A202020202F2F2069732075736566756C20696E207468697320737472697069';
wwv_flow_api.g_varchar2_table(14) := '6E67207265706F7274206578616D706C652C20776865726520776520646F6E2774207265616C6C79206E656564207468650A202020202F2F207573657220746F206861766520746F20646566696E652074686520696E746572616374697665207265706F';
wwv_flow_api.g_varchar2_table(15) := '727420616761696E20696E207468652027416666656374656420456C656D656E7473270A202020202F2F206F66207468652064796E616D696320616374696F6E2E205765206A757374207573652074686520275768656E272074726967676572696E6720';
wwv_flow_api.g_varchar2_table(16) := '656C656D656E74206469726563746C7920616E640A202020202F2F20646F2061206A51756572792073746174656D656E742074686174207374726970657320746865207265706F72742C20776974682074686520636F6C6F7220646566696E6564206279';
wwv_flow_api.g_varchar2_table(17) := '20746865200A202020202F2F20706C75672D696E207573657220696E20746865202753747269706520436F6C6F7227206174747269627574652E0A202020202F2F0A20202020617065782E6A517565727928272327202B20746869732E74726967676572';
wwv_flow_api.g_varchar2_table(18) := '696E67456C656D656E742E6964202B2027202E612D4952522D636F6E74656E742074723A6F646420746427292E63737328276261636B67726F756E642D636F6C6F72272C206C537472697065436F6C6F72293B0A7D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(18947964956736708)
,p_plugin_id=>wwv_flow_api.id(18947389548736691)
,p_file_name=>'stripe_report_2_0.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_timer
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(18948316300736718)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.TIMER'
,p_display_name=>'Timer'
,p_category=>'INIT'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.TIMER'),'')
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render_timer (',
'    p_dynamic_action  in apex_plugin.t_dynamic_action,',
'    p_plugin          in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_action     varchar2(10) := nvl(p_dynamic_action.attribute_01, ''add'');',
'    l_timer_name varchar2(20) := substr(nvl(case l_action',
'                                              when ''add''    then p_dynamic_action.attribute_02',
'                                              when ''remove'' then p_dynamic_action.attribute_03',
'                                            end, p_dynamic_action.id), 1, 20);',
'    l_expire_in  number       := nvl(p_dynamic_action.attribute_04, 1000);',
'    l_occurrence varchar2(10) := nvl(p_dynamic_action.attribute_05, ''infinite'');',
'',
'    l_result apex_plugin.t_dynamic_action_render_result;',
'begin',
'    apex_javascript.add_library (',
'        p_name      => ''com_oracle_apex_timer.min'',',
'        p_directory => p_plugin.file_prefix,',
'        p_version   => null );',
'',
'    l_result.javascript_function := ''com_oracle_apex_timer.init'';',
'    l_result.attribute_01        := l_action;',
'    l_result.attribute_02        := l_timer_name;',
'    l_result.attribute_03        := l_expire_in;',
'    l_result.attribute_04        := l_occurrence;',
'    return l_result;',
'end render_timer;'))
,p_render_function=>'render_timer'
,p_standard_attributes=>'ITEM:REGION:JAVASCRIPT_EXPRESSION:JQUERY_SELECTOR:TRIGGERING_ELEMENT:EVENT_SOURCE:REQUIRED'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>',
'	&nbsp;</p>',
'<div id="cke_pastebin">',
'	This plug-in is a dynamic action which allows to periodically fire other dynamic actions in the browser.&nbsp;For example to refresh a region. But you can perform any action you want, because the plug-in just provides&nbsp;the infrastructure so that'
||' you can hook up your own actions which you want to execute periodically.</div>',
'<div>',
'	&nbsp;</div>',
'<ol>',
'	<li>',
'		Create a dynamic action with the &quot;Timer&quot; plug-in which sets up the periodic timer</li>',
'	<li>',
'		Create a dynamic action for the event &quot;Timer Expired [Plug-in]&quot; where you execute your periodic actions.</li>',
'</ol>',
''))
,p_version_identifier=>'1.0'
,p_about_url=>'http://www.oracleapex.info/'
,p_files_version=>2
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18948586005736718)
,p_plugin_id=>wwv_flow_api.id(18948316300736718)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Action'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'add'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Specify if you want to <strong>add</strong> or <strong>remove</strong> a timer. If you add a timer with the same name again, the existing one will be removed and created again. If you remove an existing timer, you have to specify a name when you add '
||'the timer so that you are able to identify it when you remove it.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18948907397736718)
,p_plugin_attribute_id=>wwv_flow_api.id(18948586005736718)
,p_display_sequence=>10
,p_display_value=>'Add Timer'
,p_return_value=>'add'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18949403394736720)
,p_plugin_attribute_id=>wwv_flow_api.id(18948586005736718)
,p_display_sequence=>20
,p_display_value=>'Remove Timer'
,p_return_value=>'remove'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18949915312736721)
,p_plugin_id=>wwv_flow_api.id(18948316300736718)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Timer Name'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>20
,p_max_length=>20
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18948586005736718)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'add'
,p_help_text=>'If you want to remove a timer with the "Remove Timer" action you have to specify a name for the timer when you create it. If you just want to create a timer you don''t have to specify a timer name.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18950322989736721)
,p_plugin_id=>wwv_flow_api.id(18948316300736718)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Timer Name'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_display_length=>20
,p_max_length=>20
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18948586005736718)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'remove'
,p_help_text=>'Name of the timer you want to remove. Use the same name you used when you created the timer.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18950788758736721)
,p_plugin_id=>wwv_flow_api.id(18948316300736718)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Expire in x Milliseconds'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_display_length=>10
,p_max_length=>10
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18948586005736718)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'add'
,p_help_text=>'Specify the number of milliseconds after which the timer should expire. There are 1000 milliseconds in one second.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18951145326736722)
,p_plugin_id=>wwv_flow_api.id(18948316300736718)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Occurrence'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'infinite'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18948586005736718)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'add'
,p_lov_type=>'STATIC'
,p_help_text=>'Specify how often the timer should fire. The timer can be fired just <strong>once</strong> or <strong>infinite</strong> until you remove it with the "Remove Timer" action.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18951536756736722)
,p_plugin_attribute_id=>wwv_flow_api.id(18951145326736722)
,p_display_sequence=>10
,p_display_value=>'Once'
,p_return_value=>'once'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18952057466736722)
,p_plugin_attribute_id=>wwv_flow_api.id(18951145326736722)
,p_display_sequence=>20
,p_display_value=>'Infinite'
,p_return_value=>'infinite'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(18953732577736724)
,p_plugin_id=>wwv_flow_api.id(18948316300736718)
,p_name=>'timer_expired'
,p_display_name=>'Timer Expired'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '636F6D5F6F7261636C655F617065785F74696D65723D7B6372656174656454696D6572733A7B7D2C696E69743A66756E6374696F6E28297B76617220613D746869732E616374696F6E2E61747472696275746530312C663D746869732E616374696F6E2E';
wwv_flow_api.g_varchar2_table(2) := '61747472696275746530322C653D7061727365496E7428746869732E616374696F6E2E61747472696275746530332C3130292C633D746869732E616374696F6E2E61747472696275746530342C643D746869732E6166666563746564456C656D656E7473';
wwv_flow_api.g_varchar2_table(3) := '3B66756E6374696F6E206228297B696628633D3D3D22696E66696E69746522297B636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D3D73657454696D656F757428622C65297D656C73657B64656C65746520';
wwv_flow_api.g_varchar2_table(4) := '636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D7D642E74726967676572282274696D65725F657870697265642E434F4D5F4F5241434C455F415045585F54494D4552222C66297D696628613D3D3D226164';
wwv_flow_api.g_varchar2_table(5) := '6422297B696628636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D297B636C65617254696D656F757428636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D297D';
wwv_flow_api.g_varchar2_table(6) := '636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D3D73657454696D656F757428622C65297D656C73657B696628613D3D3D2272656D6F766522297B696628636F6D5F6F7261636C655F617065785F74696D65';
wwv_flow_api.g_varchar2_table(7) := '722E6372656174656454696D6572735B665D297B636C65617254696D656F757428636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D293B64656C65746520636F6D5F6F7261636C655F617065785F74696D65';
wwv_flow_api.g_varchar2_table(8) := '722E6372656174656454696D6572735B665D7D7D7D7D7D3B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(18954164874736725)
,p_plugin_id=>wwv_flow_api.id(18948316300736718)
,p_file_name=>'com_oracle_apex_timer.min.js'
,p_mime_type=>'text/javascript'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/shared_components/plugins/item_type/com_oracle_slider
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(18954504985736726)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'COM.ORACLE.SLIDER'
,p_display_name=>'Slider'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('ITEM TYPE','COM.ORACLE.SLIDER'),'')
,p_javascript_file_urls=>'#PLUGIN_FILES#com_oracle_apex_slider.js'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'c_min_value constant number := 0;',
'c_max_value constant number := 1010;',
'',
'function render_slider (',
'    p_item                in apex_plugin.t_page_item,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_value               in varchar2,',
'    p_is_readonly         in boolean,',
'    p_is_printer_friendly in boolean )',
'    return apex_plugin.t_page_item_render_result',
'is',
'    l_escaped_value varchar2(32767) := apex_escape.html(p_value);',
'',
'    l_name          varchar2(30);',
'    l_result        apex_plugin.t_page_item_render_result;',
'begin',
'    --*********************',
'    -- NOTE: This plug-in isn''t a good example because it''s missing the readonly/print code!',
'    --       But it shows you how a widget can provide it''s own events for dynamic actions.',
'    --*********************',
'    if apex_application.g_debug then',
'        apex_plugin_util.debug_page_item (',
'            p_plugin              => p_plugin,',
'            p_page_item           => p_item,',
'            p_value               => p_value,',
'            p_is_readonly         => p_is_readonly,',
'            p_is_printer_friendly => p_is_printer_friendly );',
'    end if;',
'',
'    l_name := apex_plugin.get_input_name_for_page_item (',
'                  p_is_multi_value => false );',
'',
'    apex_css.add_file (',
'        p_name      => ''jquery.ui.slider'',',
'        p_directory => wwv_flow.g_image_prefix||''libraries/jquery-ui/1.10.4/themes/base/'',',
'        p_version   => null );',
'',
'',
'    apex_javascript.add_library (',
'        p_name      => ''jquery.ui.slider.min'',',
'        p_directory => wwv_flow.g_image_prefix||''libraries/jquery-ui/1.10.4/ui/minified/'',',
'        p_version   => null );',
'',
'',
'    -- render the div for the slider and the input field',
'',
'    htp.p(''<div id="''||p_item.name||''_control"''||',
'          ''></div>'');',
'    htp.p(''<div class="slider-container" style="padding: 4px 8px">'');',
'    htp.p(''<span id="''||p_item.name||''_display">$''||l_escaped_value||''</span>'');',
'    htp.p(''<input type="hidden" id="''||p_item.name||''" ''||''name="''||l_name||''" ''||''value="''||l_escaped_value||''">'');',
'    htp.p(''</div>'');',
'',
'    -- initialize the slider when the page has been rendered    ',
'    apex_javascript.add_onload_code(',
'        p_code => ''com_oracle_apex_slider('' || ',
'                        ''"#'' || p_item.name || ''",'' ||',
'                        ''{'' ||',
'                        apex_javascript.add_attribute(''orientation'',    p_item.attribute_01) ||',
'                        apex_javascript.add_attribute(''min'',            coalesce(p_item.attribute_02, c_min_value)) ||',
'                        apex_javascript.add_attribute(''max'',            coalesce(p_item.attribute_03, c_max_value)) ||',
'                        apex_javascript.add_attribute(''step'',           coalesce(p_item.attribute_04, 1)) ||',
'                        apex_javascript.add_attribute(''animation'',      case when p_item.attribute_05 = ''Y'' then ''true'' else ''false'' end) ||',
'                        apex_javascript.add_attribute(''value'',          apex_escape.html(nvl(p_value, nvl(p_item.attribute_02, 0))), false, false)||',
'                        ''});'' );',
'                            ',
'    ',
'    -- Tell APEX that this field is navigable',
'    l_result.is_navigable := true;',
'',
'    return l_result;',
'end render_slider;',
'',
'function validate_slider (',
'    p_item   in apex_plugin.t_page_item,',
'    p_plugin in apex_plugin.t_plugin,',
'    p_value  in varchar2 )',
'    return apex_plugin.t_page_item_validation_result',
'is',
'    l_result apex_plugin.t_page_item_validation_result;',
'begin',
'    if apex_application.g_debug then',
'        apex_plugin_util.debug_page_item(p_plugin,p_item);',
'    end if;',
'',
'    if p_value is null then return null; end if;',
'    ',
'    if wwv_flow_utilities.is_numeric(p_value) and',
'       not to_number(p_value) between to_number(nvl(p_item.attribute_02, c_min_value)) and to_number(nvl(p_item.attribute_03, c_max_value))',
'    then',
'        l_result.message := apex_escape.html(p_value)||'' is not in the valid range of ''||',
'                            nvl(p_item.attribute_02, c_min_value)||'' - ''||',
'                            nvl(p_item.attribute_03, c_max_value);',
'    end if;',
'    ',
'    return l_result;',
'end validate_slider;'))
,p_render_function=>'render_slider'
,p_ajax_function=>'ajax_slider'
,p_validation_function=>'validate_slider'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:READONLY:ESCAPE_OUTPUT:SOURCE:ELEMENT:ENCRYPT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'http://www.oracleapex.info/'
,p_files_version=>2
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18954871540736733)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Display orientation'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'horizontal'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18955219442736733)
,p_plugin_attribute_id=>wwv_flow_api.id(18954871540736733)
,p_display_sequence=>10
,p_display_value=>'Horizontal'
,p_return_value=>'horizontal'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18955746138736735)
,p_plugin_attribute_id=>wwv_flow_api.id(18954871540736733)
,p_display_sequence=>20
,p_display_value=>'Vertical'
,p_return_value=>'vertical'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18956240417736735)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Minimum Value'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_default_value=>'0'
,p_display_length=>6
,p_max_length=>6
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18956686333736735)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Maximum Value'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_default_value=>'1000'
,p_display_length=>6
,p_max_length=>6
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18957098554736736)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Step'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_default_value=>'1'
,p_display_length=>6
,p_max_length=>6
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18957418739736736)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Animate'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(18957817055736737)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_name=>'slide'
,p_display_name=>'Slide'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(18958226754736737)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_name=>'slidechange'
,p_display_name=>'Change'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(18958684013736737)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_name=>'slidestart'
,p_display_name=>'Start'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(18959079909736738)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_name=>'slidestop'
,p_display_name=>'Stop'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E20636F6D5F6F7261636C655F617065785F736C6964657220287053656C6563746F722C20704F7074696F6E7329207B0D0A202020202F2F2044656661756C74206F7572206F7074696F6E7320616E642073746F7265207468656D2077';
wwv_flow_api.g_varchar2_table(2) := '697468207468652022676C6F62616C22207072656669782C206265636175736520697420636F756C640D0A202020202F2F20626520757365642062792074686520646966666572656E742066756E6374696F6E73206173206120636C6F737572650D0A20';
wwv_flow_api.g_varchar2_table(3) := '20202076617220674F7074696F6E732C2067536C696465723B0D0A202020200D0A202020202F2A674F7074696F6E73203D20617065782E6A51756572792E657874656E64287B0D0A20202020202020202020202020202020202020646570656E64696E67';
wwv_flow_api.g_varchar2_table(4) := '4F6E53656C6563746F723A6E756C6C2C0D0A202020202020202020202020202020202020206F7074696D697A65526566726573683A747275652C0D0A20202020202020202020202020202020202020706167654974656D73546F5375626D69743A6E756C';
wwv_flow_api.g_varchar2_table(5) := '6C2C0D0A2020202020202020202020202020202020202066696C7465725769746856616C75653A66616C73652C0D0A2020202020202020202020202020202020202077696E646F77506172616D65746572733A6E756C6C0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(6) := '20202020202020207D2C20704F7074696F6E73292C2A2F0D0A20202020674F7074696F6E73203D20704F7074696F6E733B20202020202020202020202020202020200D0A2020202067536C69646572203D20617065782E6A5175657279287053656C6563';
wwv_flow_api.g_varchar2_table(7) := '746F72293B0D0A202020200D0A2020202067536C696465722E656163682866756E6374696F6E28297B0D0A20202020202020206C536C6964657253656C6563746F72203D20272327202B20746869732E69643B0D0A20202020202020206C536C69646572';
wwv_flow_api.g_varchar2_table(8) := '446973706C61794964203D20746869732E6964202B20275F646973706C6179273B0D0A20202020202020206C536C69646572436F6E74726F6C53656C6563746F72203D20272327202B20746869732E6964202B20275F636F6E74726F6C273B0D0A202020';
wwv_flow_api.g_varchar2_table(9) := '20202020200D0A20202020202020202F2F20496E697469616C69736520736C696465720D0A2020202020202020617065782E6A5175657279286C536C69646572436F6E74726F6C53656C6563746F72292E736C69646572287B0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(10) := '2020206F7269656E746174696F6E203A20674F7074696F6E732E6F7269656E746174696F6E2C0D0A2020202020202020202020206D696E2020202020202020203A20674F7074696F6E732E6D696E2C0D0A2020202020202020202020206D617820202020';
wwv_flow_api.g_varchar2_table(11) := '20202020203A20674F7074696F6E732E6D61782C0D0A2020202020202020202020207374657020202020202020203A20674F7074696F6E732E737465702C0D0A202020202020202020202020616E696D6174696F6E2020203A20674F7074696F6E732E61';
wwv_flow_api.g_varchar2_table(12) := '6E696D6174696F6E2C0D0A20202020202020202020202076616C7565202020202020203A20674F7074696F6E732E76616C75652C0D0A2020202020202020202020207374617274202020202020203A2066756E6374696F6E28704576656E742C20705569';
wwv_flow_api.g_varchar2_table(13) := '29207B0D0A20202020202020202020202020202020617065782E6A5175657279286C536C6964657253656C6563746F72292E747269676765722827736C6964657374617274272C20705569293B0D0A2020202020202020202020207D2C0D0A2020202020';
wwv_flow_api.g_varchar2_table(14) := '20202020202020736C696465202020202020203A2066756E6374696F6E28704576656E742C2070556929207B0D0A202020202020202020202020202020202F2F20466972737420736574207468652076616C7565206F66207468652068696464656E2069';
wwv_flow_api.g_varchar2_table(15) := '74656D2C20757365642061732074686520504F535465642076616C75650D0A20202020202020202020202020202020617065782E6A5175657279286C536C6964657253656C6563746F72292E76616C287055692E76616C7565293B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(16) := '2020202020202020202F2F205365636F6E64207365742074686520646973706C617965642076616C75650D0A202020202020202020202020202020202473286C536C69646572446973706C617949642C20272427202B207055692E76616C7565293B0D0A';
wwv_flow_api.g_varchar2_table(17) := '202020202020202020202020202020202F2F2046696E616C6C792074726967676572207468652027736C69646527206576656E740D0A20202020202020202020202020202020617065782E6A5175657279286C536C6964657253656C6563746F72292E74';
wwv_flow_api.g_varchar2_table(18) := '7269676765722827736C696465272C20705569293B0D0A2020202020202020202020207D2C0D0A2020202020202020202020206368616E67652020202020203A2066756E6374696F6E28704576656E742C2070556929207B0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(19) := '202020202020617065782E6A5175657279286C536C6964657253656C6563746F72292E747269676765722827736C6964656368616E6765272C20705569293B0D0A2020202020202020202020207D2C0D0A20202020202020202020202073746F70202020';
wwv_flow_api.g_varchar2_table(20) := '20202020203A2066756E6374696F6E28704576656E742C2070556929207B0D0A20202020202020202020202020202020617065782E6A5175657279286C536C6964657253656C6563746F72292E747269676765722827736C69646573746F70272C207055';
wwv_flow_api.g_varchar2_table(21) := '69293B0D0A2020202020202020202020207D0D0A20202020202020207D293B0D0A20202020202020200D0A20202020202020200D0A20202020202020202F2F2052656769737465722063616C6C6261636B730D0A2020202020202020617065782E776964';
wwv_flow_api.g_varchar2_table(22) := '6765742E696E6974506167654974656D28746869732E69642C207B0D0A202020202020202020202020656E61626C652020202020203A2066756E6374696F6E2829207B0D0A202020202020202020202020202020202F2F204669727374207765206E6565';
wwv_flow_api.g_varchar2_table(23) := '6420746F20656E61626C652074686520736C6964657220636F6E74726F6C2C20746869732063616E20626520646F6E65206A7573740D0A202020202020202020202020202020202F2F2062792063616C6C696E6720746865206E6174697665206A517565';
wwv_flow_api.g_varchar2_table(24) := '727920554920656E61626C65206D6574686F64206F6E20746865206D61696E20636F6E7461696E65720D0A202020202020202020202020202020202F2F20736C6964657220656C656D656E742C20776869636820697320616C7761797320746865206974';
wwv_flow_api.g_varchar2_table(25) := '656D206E616D6520706F73746669786564207769746820275F636F6E74726F6C270D0A20202020202020202020202020202020617065782E6A517565727928272327202B20746869732E6964202B20275F636F6E74726F6C27292E736C69646572282765';
wwv_flow_api.g_varchar2_table(26) := '6E61626C6527293B0D0A202020202020202020202020202020200D0A202020202020202020202020202020202F2F205365636F6E646C792C207765206E65656420746F20656E61626C65207468652068696464656E20656C656D656E7420757365642074';
wwv_flow_api.g_varchar2_table(27) := '6F20706F73742074686520736C696465722773200D0A202020202020202020202020202020202F2F2076616C75652E2054686973206D65616E732072656D6F76696E6720746865202264697361626C656422206174747269627574652066726F6D207468';
wwv_flow_api.g_varchar2_table(28) := '6520656C656D656E74200D0A202020202020202020202020202020202F2F207769746820616E204944206F6620746865206974656D206E616D652E200D0A20202020202020202020202020202020617065782E6A5175657279286C536C6964657253656C';
wwv_flow_api.g_varchar2_table(29) := '6563746F72292E72656D6F766541747472282764697361626C656427293B0D0A2020202020202020202020207D2C0D0A20202020202020202020202064697361626C6520202020203A2066756E6374696F6E2829207B0D0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(30) := '202020202F2F204669727374207765206E65656420746F2064697361626C652074686520736C6964657220636F6E74726F6C2C20746869732063616E20626520646F6E65206A7573740D0A202020202020202020202020202020202F2F2062792063616C';
wwv_flow_api.g_varchar2_table(31) := '6C696E6720746865206E6174697665206A51756572792055492064697361626C65206D6574686F64206F6E20746865206D61696E20636F6E7461696E65720D0A202020202020202020202020202020202F2F20736C6964657220656C656D656E742C2077';
wwv_flow_api.g_varchar2_table(32) := '6869636820697320616C7761797320746865206974656D206E616D6520706F73746669786564207769746820275F636F6E74726F6C270D0A20202020202020202020202020202020617065782E6A517565727928272327202B20746869732E6964202B20';
wwv_flow_api.g_varchar2_table(33) := '275F636F6E74726F6C27292E736C69646572282764697361626C6527293B0D0A202020202020202020202020202020200D0A202020202020202020202020202020202F2F205365636F6E646C792C207765206E65656420746F2064697361626C65207468';
wwv_flow_api.g_varchar2_table(34) := '652068696464656E20656C656D656E74207573656420746F20706F73742074686520736C696465722773200D0A202020202020202020202020202020202F2F2076616C75652E2054686973206D65616E7320616464696E6720746865202264697361626C';
wwv_flow_api.g_varchar2_table(35) := '6564222061747472696275746520746F2074686520656C656D656E74200D0A202020202020202020202020202020202F2F207769746820616E204944206F6620746865206974656D206E616D652E200D0A20202020202020202020202020202020617065';
wwv_flow_api.g_varchar2_table(36) := '782E6A5175657279286C536C6964657253656C6563746F72292E61747472282764697361626C6564272C202764697361626C656427293B0D0A2020202020202020202020207D2C0D0A20202020202020202020202073686F7720202020202020203A2066';
wwv_flow_api.g_varchar2_table(37) := '756E6374696F6E2829207B0D0A202020202020202020202020202020202F2F2053686F772074686520656E74697265202774642720636F6E7461696E696E6720616C6C20736C6964657220636F6D706F6E656E74730D0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(38) := '202020617065782E6A517565727928272327202B20746869732E6964202B20275F636F6E74726F6C27292E706172656E742827746427292E73686F7728293B2020200D0A2020202020202020202020207D2C0D0A20202020202020202020202068696465';
wwv_flow_api.g_varchar2_table(39) := '20202020202020203A2066756E6374696F6E2829207B0D0A202020202020202020202020202020202F2F20486964652074686520656E74697265202774642720636F6E7461696E696E6720616C6C20736C6964657220636F6D706F6E656E74730D0A2020';
wwv_flow_api.g_varchar2_table(40) := '2020202020202020202020202020617065782E6A517565727928272327202B20746869732E6964202B20275F636F6E74726F6C27292E706172656E742827746427292E6869646528293B202020200D0A2020202020202020202020207D2C0D0A20202020';
wwv_flow_api.g_varchar2_table(41) := '202020202020202073657456616C7565202020203A2066756E6374696F6E287056616C756529207B0D0A202020202020202020202020202020202F2A2A2053616E697469736520696E70757420627920646F696E672074686520666F6C6C6F77696E673A';
wwv_flow_api.g_varchar2_table(42) := '0D0A2020202020202020202020202020202020202A2020202D204966207056616C75652069732067726561746572207468616E2074686520616C6C6F776564206D6178696D756D2076616C75652C2066616C6C6261636B20746F206D6178696D756D2076';
wwv_flow_api.g_varchar2_table(43) := '616C75652E0D0A2020202020202020202020202020202020202A2020202D204966207056616C7565206973206C657373207468616E2074686520616C6C6F776564206D696E696D756D2076616C75652C2066616C6C6261636B20746F20746865206D696E';
wwv_flow_api.g_varchar2_table(44) := '696D756D2076616C75652E0D0A2020202020202020202020202020202020202A2020200D0A2020202020202020202020202020202020202A2020204E6F74653A204966207056616C7565206973206D6F7265206772616E756C6172207468616E20646566';
wwv_flow_api.g_varchar2_table(45) := '696E65642062792074686520737465702C207468697320697320616C6C6F7765642E20416C74686F7567680D0A2020202020202020202020202020202020202A20202020202020202074686520656E642D757365722077696C6C206E6F74206265206162';
wwv_flow_api.g_varchar2_table(46) := '6C6520746F2072652D73656C6563742074686973206D6F7265206772616E756C61722076616C7565207669612074686520736C696465722E0D0A2020202020202020202020202020202020202A2A2F0D0A20202020202020202020202020202020766172';
wwv_flow_api.g_varchar2_table(47) := '206C56616C75653B0D0A20202020202020202020202020202020696620287056616C7565203C20674F7074696F6E732E6D696E29207B0D0A20202020202020202020202020202020202020206C56616C7565203D20674F7074696F6E732E6D696E3B0D0A';
wwv_flow_api.g_varchar2_table(48) := '202020202020202020202020202020207D20656C736520696620287056616C7565203E20674F7074696F6E732E6D617829207B0D0A20202020202020202020202020202020202020206C56616C7565203D20674F7074696F6E732E6D61783B202020200D';
wwv_flow_api.g_varchar2_table(49) := '0A202020202020202020202020202020207D20656C7365207B0D0A20202020202020202020202020202020202020206C56616C7565203D207056616C75653B0D0A202020202020202020202020202020207D0D0A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(50) := '2F2F204669727374207765206E65656420746F20736574207468652068696464656E20656C656D656E74207573656420746F20706F73742074686520736C6964657227732076616C75650D0A20202020202020202020202020202020617065782E6A5175';
wwv_flow_api.g_varchar2_table(51) := '657279286C536C6964657253656C6563746F72292E76616C286C56616C7565293B0D0A202020202020202020202020202020200D0A202020202020202020202020202020202F2F205365636F6E642C207765206E65656420746F20757064617465207468';
wwv_flow_api.g_varchar2_table(52) := '6520646973706C617920656C656D656E742C207573656420746F20746F20646973706C617920746865200D0A202020202020202020202020202020202F2F206E756D65726963616C2076616C7565206F66207468652063757272656E7420736C69646572';
wwv_flow_api.g_varchar2_table(53) := '2073656C656374696F6E0D0A202020202020202020202020202020202473286C536C69646572446973706C617949642C20272427202B206C56616C7565293B0D0A202020202020202020202020202020200D0A202020202020202020202020202020202F';
wwv_flow_api.g_varchar2_table(54) := '2F2046696E616C6C79207765206E65656420746F20757064617465207468652061637475616C20736C6964657220636F6E74726F6C20697473656C660D0A20202020202020202020202020202020617065782E6A5175657279286C536C69646572436F6E';
wwv_flow_api.g_varchar2_table(55) := '74726F6C53656C6563746F72292E736C69646572282776616C7565272C206C56616C7565293B202020202020202020202020202020202020200D0A2020202020202020202020207D2F2A2C0D0A20202020202020202020202067657456616C7565202020';
wwv_flow_api.g_varchar2_table(56) := '203A2066756E6374696F6E2829207B0D0A20202020202020202020202020202020616C657274282767657456616C756527293B20200D0A2020202020202020202020207D2A2F0D0A2020202020202020202020202F2F6E756C6C56616C7565206E6F7420';
wwv_flow_api.g_varchar2_table(57) := '726571756972656420686572652C206E6F206C6F76206173736F6369617465642E200D0A20202020202020207D293B20200D0A202020207D293B0D0A7D3B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(18959421868736738)
,p_plugin_id=>wwv_flow_api.id(18954504985736726)
,p_file_name=>'com_oracle_apex_slider.js'
,p_mime_type=>'application/x-javascript'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_display_source
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(18959813217736740)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.DISPLAY_SOURCE'
,p_display_name=>'Source Display'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.DISPLAY_SOURCE'),'')
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render (',
'        p_region              in apex_plugin.t_region,',
'        p_plugin              in apex_plugin.t_plugin,',
'        p_is_printer_friendly in boolean )',
'    return apex_plugin.t_region_render_result',
'is',
'    -- It''s better to have named variables instead of using the generic ones,',
'    -- makes the code more readable. We are using the same defaults for the',
'    -- required attributes as in the plug-in attribute configuration, because',
'    -- they can still be null. Keep them in sync!',
'    c_region_static_id    constant varchar2(255) := p_region.attribute_01;',
'    c_highlight_page_item constant varchar2(255) := p_region.attribute_02;',
'',
'    l_highlight_term varchar2(4000) := '''';',
'',
'    cursor sql_csr( d_region_static_id in varchar2 ) is',
'        select source_type, 10 seq, null series_name, region_source source',
'        from apex_application_page_regions',
'        where application_id = :APP_ID',
'            and page_id = :APP_PAGE_ID',
'            and static_id = d_region_static_id',
'            and ( source_type_code like ''PLUGIN%''',
'                or source_type_code like ''STATIC_TEXT%''',
'                or source_type in (',
'                    ''Calendar'',',
'                    ''Easy Calendar'',',
'                    ''Interactive Report'',',
'                    ''List View'',',
'                    ''Report'',',
'                    ''PL/SQL'',',
'                    ''Tabular Form''',
'                )',
'            )',
'        union all',
'        select reg.source_type, fs.series_seq, fs.series_name, fs.series_query source',
'        from apex_application_page_regions reg,',
'            apex_application_page_flash5_s fs',
'        where reg.application_id = :APP_ID',
'            and reg.page_id = :APP_PAGE_ID',
'            and reg.static_id = d_region_static_id',
'            and fs.application_id = reg.application_id',
'            and fs.page_id = reg.page_id',
'            and fs.region_id = reg.region_id',
'            and reg.source_type in (',
'                ''Flash Chart'',',
'                ''Map''',
'            )',
'        union all',
'        select reg.source_type, 10 seq, null series_name, to_clob(tr.tree_query) source',
'        from apex_application_page_regions reg,',
'            apex_application_page_trees tr',
'        where reg.application_id = :APP_ID',
'            and reg.page_id = :APP_PAGE_ID',
'            and reg.static_id = d_region_static_id',
'            and tr.application_id = reg.application_id',
'            and tr.page_id = reg.page_id',
'            and tr.region_id = reg.region_id',
'            and reg.source_type in (''JavaScript Tree'')',
'        union all',
'        select reg.source_type, 10 seq, null series_name, to_clob(list_query) source',
'        from apex_application_page_regions reg,',
'            apex_application_lists li',
'        where reg.application_id = :APP_ID',
'            and reg.page_id = :APP_PAGE_ID',
'            and reg.static_id = d_region_static_id',
'            and li.application_id = reg.application_id',
'            and li.list_id = reg.list_id',
'            and reg.source_type in ( ''List'' )',
'        order by 1, 2;',
'    sql_rec sql_csr%ROWTYPE;',
'begin',
'    if c_highlight_page_item is not null then',
'        l_highlight_term := apex_escape.html(trim(lower(v(c_highlight_page_item))));',
'    end if;',
'',
'    for sql_rec in sql_csr( c_region_static_id ) loop',
'        if sql_rec.series_name is not null then',
'            sys.htp.p(''<p><strong>''||apex_escape.html(sql_rec.series_name)||'':</strong></p>'');',
'        end if;',
'        sys.htp.p(''<pre>'');',
'        if l_highlight_term is not null then',
'            sys.htp.p(replace(apex_escape.html(sql_rec.source),',
'                l_highlight_term,''<span class="highlight">''||l_highlight_term||''</span>''));',
'        else',
'            sys.htp.p(apex_escape.html(sql_rec.source));',
'        end if;',
'        sys.htp.p(''</pre>'');',
'    end loop;',
'',
'    return null;',
'end render;'))
,p_render_function=>'render'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>'This region plug-in is used to display the SQL Source region of an accompanying region.'
,p_version_identifier=>'5.0.1'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18960197470736740)
,p_plugin_id=>wwv_flow_api.id(18959813217736740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Region Static ID'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Enter the static ID as defined in the target region''s attributes section.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18960593606736741)
,p_plugin_id=>wwv_flow_api.id(18959813217736740)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Highlight Term Page Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'If you wish to have a term in your region source highlighted, create a page item and select it here.'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_badge_list
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(18960964510745139)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.BADGE_LIST'
,p_display_name=>'Badge List'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.BADGE_LIST'),'#IMAGE_PREFIX#plugins/com.oracle.apex.badgelist/')
,p_javascript_file_urls=>'#PLUGIN_FILES#com_oracle_apex_badgelist.js'
,p_css_file_urls=>'#PLUGIN_FILES#com_oracle_apex_badgelist.css'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render (',
'    p_region              in apex_plugin.t_region,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_is_printer_friendly in boolean )',
'    return apex_plugin.t_region_render_result is',
'begin',
'    apex_javascript.add_onload_code (',
'        p_code => ''com_oracle_apex_badgelist(''||',
'            apex_javascript.add_value(p_region.static_id)||',
'            ''{''||',
'                -- why is this attribute needed if is not used?',
'                apex_javascript.add_attribute(',
'                    ''pageItems'', ',
'                    apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit)',
'                )||',
'                apex_javascript.add_attribute(',
'                    ''ajaxIdentifier'', ',
'                    apex_plugin.get_ajax_identifier, ',
'                    false, ',
'                    false',
'                )||',
'            ''}''||',
'        '');''',
'    );',
'--    CSS for Big Value List',
'--    apex_css.add_file (',
'--        p_name      => ''com_oracle_apex_badge_list'',',
'--        p_directory => p_plugin.file_prefix );',
'    -- Start the list',
'',
'',
'    -- It''s time to emit the selected rows',
'',
'',
'    return null;',
'',
'end render;',
'',
'function ajax (',
'    p_region in apex_plugin.t_region,',
'    p_plugin in apex_plugin.t_plugin',
') return apex_plugin.t_region_ajax_result ',
'is',
'    -- It''s better to have named variables instead of using the generic ones,',
'    -- makes the code more readable. We are using the same defaults for the',
'    -- required attributes as in the plug-in attribute configuration, because',
'    -- they can still be null. Keep them in sync!',
'    c_label_column      constant varchar2(255) := p_region.attribute_01;',
'    c_value_column      constant varchar2(255) := p_region.attribute_02;',
'    c_percent_column    constant varchar2(255) := p_region.attribute_03;',
'    c_link_target       constant varchar2(255) := p_region.attribute_04;',
'    ',
'    c_layout            constant varchar2(1)   := p_region.attribute_05;',
'    c_chart_size        constant varchar2(3)   := p_region.attribute_06;',
'    c_chart_type        constant varchar2(3)   := p_region.attribute_07;',
'    c_colored           constant varchar2(1)   := p_region.attribute_08;',
'',
'    l_label_column_no   pls_integer;',
'    l_value_column_no   pls_integer;',
'    l_percent_column_no pls_integer;',
'    l_column_value_list apex_plugin_util.t_column_value_list2;',
'    ',
'    l_label             varchar2(4000);',
'    l_value             varchar2(4000);',
'    l_percent           number;',
'    l_url               varchar2(4000);',
'    l_class             varchar2(255);',
'',
'begin',
'    apex_json.initialize_output (',
'        p_http_cache => false );',
'        -- Read the data based on the region source query',
'    l_column_value_list := apex_plugin_util.get_data2 (',
'                               p_sql_statement  => p_region.source,',
'                               p_min_columns    => 2,',
'                               p_max_columns    => null,',
'                               p_component_name => p_region.name );',
'',
'    -- Get the actual column# for faster access and also verify that the data type',
'    -- of the column matches with what we are looking for',
'    l_label_column_no   := apex_plugin_util.get_column_no (',
'                               p_attribute_label   => ''Label Column'',',
'                               p_column_alias      => c_label_column,',
'                               p_column_value_list => l_column_value_list,',
'                               p_is_required       => true,',
'                               p_data_type         => apex_plugin_util.c_data_type_varchar2 );',
'                                      ',
'    l_value_column_no   := apex_plugin_util.get_column_no (',
'                               p_attribute_label   => ''Value Column'',',
'                               p_column_alias      => c_value_column,',
'                               p_column_value_list => l_column_value_list,',
'                               p_is_required       => true,',
'                               p_data_type         => apex_plugin_util.c_data_type_varchar2 );',
'                                      ',
'    l_percent_column_no := apex_plugin_util.get_column_no (',
'                             p_attribute_label   => ''Percent Column'',',
'                             p_column_alias      => c_percent_column,',
'                             p_column_value_list => l_column_value_list,',
'                             p_is_required       => false,',
'                             p_data_type         => apex_plugin_util.c_data_type_number );',
'    ',
'    -- begin output as json',
'    owa_util.mime_header(''application/json'', false);',
'    htp.p(''cache-control: no-cache'');',
'    htp.p(''pragma: no-cache'');',
'    owa_util.http_header_close;',
' --   l_message_when_no_data_found := apex_escape.html_whitelist(',
'  --      apex_plugin_util.replace_substitutions (',
'   --             p_value  => c_message_when_no_data_found,',
'   --             p_escape => false',
'    --        )',
'    --    );',
'    apex_json.open_object();',
'    apex_json.write(''layout'', c_layout); ',
'    apex_json.write(''chart_size'', c_chart_size); ',
'    apex_json.write(''chart_type'', c_chart_type); ',
'    apex_json.write(''colored'', c_colored); ',
'    apex_json.open_array(''data'');',
'    for l_row_num in 1 .. l_column_value_list(1).value_list.count loop',
'        begin',
'            apex_json.open_object(); ',
'            -- Set the column values of our current row so that apex_plugin_util.replace_substitutions',
'            -- can do substitutions for columns contained in the region source query.',
'            apex_plugin_util.set_component_values (',
'                p_column_value_list => l_column_value_list,',
'                p_row_num           => l_row_num );',
'',
'            -- get the label',
'            l_label := ',
'                           apex_plugin_util.get_value_as_varchar2 (',
'                               p_data_type => l_column_value_list(l_label_column_no).data_type,',
'                               p_value     => l_column_value_list(l_label_column_no).value_list(l_row_num) );',
'                         --  p_region.escape_output );apex_plugin_util.escape (',
'',
'            apex_json.    write(''label'', l_label); ',
'            ',
'            -- get the value',
'            l_value := apex_plugin_util.get_value_as_varchar2 (',
'                               p_data_type => l_column_value_list(l_value_column_no).data_type,',
'                               p_value     => l_column_value_list(l_value_column_no).value_list(l_row_num) );',
'',
'            apex_json.    write(''value'', l_value); ',
'',
'            -- get percent',
'            if l_percent_column_no is not null then',
'                l_percent := l_column_value_list(l_percent_column_no).value_list(l_row_num).number_value;',
'                apex_json.    write(''percent'', l_percent); ',
'            end if;',
'',
'            -- get the link target if it does exist',
'            if c_link_target is not null then',
'                l_url := wwv_flow_utilities.prepare_url (',
'                             apex_plugin_util.replace_substitutions (',
'                                 p_value  => c_link_target,',
'                                 p_escape => false ));',
'                apex_json.    write(''url'', l_url);                ',
'            end if;',
'            ',
'            apex_json.close_object();        ',
'',
'',
'            apex_plugin_util.clear_component_values;',
'        exception when others then',
'            apex_plugin_util.clear_component_values;',
'            raise;',
'        end;',
'    end loop;',
'    apex_json.close_all();',
'    ',
'    return null;',
'exception when others then',
'    htp.p(''error: ''||apex_escape.html(sqlerrm));',
'    return null;',
'end ajax;',
'',
''))
,p_render_function=>'render'
,p_ajax_function=>'ajax'
,p_standard_attributes=>'SOURCE_SQL:SOURCE_REQUIRED:AJAX_ITEMS_TO_SUBMIT:ESCAPE_OUTPUT'
,p_sql_min_column_count=>2
,p_sql_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<pre>',
'select ''Open''               as label,',
'       to_char(320,''9G990'') as value,',
'       13                   as percent',
'  from dual',
' union all',
'select ''Closed''             as label,',
'       to_char(87,''9G990'')  as value,',
'       70                   as percent',
'  from dual',
'</pre>'))
,p_substitute_attributes=>false
,p_reference_id=>2128823099783706533
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Badge lists are useful for displaying a region with a small number of counts for important statistics. For example, in Bug Tracker, this plug-in is used to show the total bugs, open bugs, open high priority bugs, and open critical severity bugs.</'
||'p>',
'<p>This plug-in is suitable for adding to the Home page to show important summary information.</p>'))
,p_version_identifier=>'5.0.2'
,p_about_url=>'http://apex.oracle.com/plugins'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18961131277745140)
,p_plugin_id=>wwv_flow_api.id(18960964510745139)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Label Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the labels for the badges.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18961569913745140)
,p_plugin_id=>wwv_flow_api.id(18960964510745139)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Value Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the values for the badges.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18961934013745140)
,p_plugin_id=>wwv_flow_api.id(18960964510745139)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Percent Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the percentage values for the badges. Percentages will be displayed together with the value within the badge.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18962310758745141)
,p_plugin_id=>wwv_flow_api.id(18960964510745139)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Link Target'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Example 1: URL to navigate to page 10 and set P10_EMPNO to the EMPNO value of the clicked entry.',
'<pre>f?p=&amp;APP_ID.:10:&amp;APP_SESSION.::&amp;DEBUG.:RP,10:P10_EMPNO:&amp;EMPNO.</pre>',
'</p>',
'<p>Example 2: Display the EMPNO value of the clicked entry in a JavaScript alert',
'<pre>javascript:alert(''current empno: &amp;EMPNO.'');</pre>',
'</p>'))
,p_help_text=>'<p>Enter a target page to be called when the user clicks a badge entry.</p>'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18962731368745141)
,p_plugin_id=>wwv_flow_api.id(18960964510745139)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Layout'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_is_common=>false
,p_default_value=>'0'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'<p>Select the layout to determine how the badge list is displayed.</p>'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18963178772745141)
,p_plugin_attribute_id=>wwv_flow_api.id(18962731368745141)
,p_display_sequence=>5
,p_display_value=>'Fit to Page'
,p_return_value=>'0'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Sizes the badges to stretch across the page. The width of each badge will be determined by the number of badges and the display width.</p>',
'<p>Note: Badges will not wrap when displayed on smaller devices.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18963660469745141)
,p_plugin_attribute_id=>wwv_flow_api.id(18962731368745141)
,p_display_sequence=>7
,p_display_value=>'Float to Left'
,p_return_value=>'F'
,p_help_text=>'<p>Sizes the badges based on the width of the label for each badge. All badges will be displayed to the left of the region.</p>'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18964116407745143)
,p_plugin_attribute_id=>wwv_flow_api.id(18962731368745141)
,p_display_sequence=>10
,p_display_value=>'1 column'
,p_return_value=>'1'
,p_help_text=>'Displays only one badge per row. Therefore, if there are three badges they are displayed on three rows.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18964603147745143)
,p_plugin_attribute_id=>wwv_flow_api.id(18962731368745141)
,p_display_sequence=>20
,p_display_value=>'2 columns'
,p_return_value=>'2'
,p_help_text=>'Displays only two badges per row. Therefore, if there are three badges they are displayed on two rows.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18965145560745144)
,p_plugin_attribute_id=>wwv_flow_api.id(18962731368745141)
,p_display_sequence=>30
,p_display_value=>'3 columns'
,p_return_value=>'3'
,p_help_text=>'<p>Displays a maximum of three badges per row. Therefore, if there are four badges they are displayed on two rows.</p>'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18965603146745145)
,p_plugin_attribute_id=>wwv_flow_api.id(18962731368745141)
,p_display_sequence=>40
,p_display_value=>'4 columns'
,p_return_value=>'4'
,p_help_text=>'<p>Displays a maximum of four badges per row. Therefore, if there are six badges they are displayed on two rows.</p>'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18966173315745145)
,p_plugin_attribute_id=>wwv_flow_api.id(18962731368745141)
,p_display_sequence=>50
,p_display_value=>'5 columns'
,p_return_value=>'5'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Displays a maximum of fix badges per row. Therefore, if there are seven badges they are displayed on two rows.</p>',
'<p>Note: on smaller displays where the badges cannot be displayed appropriately, the responsive region will revert to less column and additional rows. For example, seven badges may be displayed as three columns on three rows, instead of five columns '
||'on two rows.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18966663649745146)
,p_plugin_id=>wwv_flow_api.id(18960964510745139)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>70
,p_prompt=>'Chart Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_is_common=>false
,p_default_value=>'L'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18969546340745148)
,p_depending_on_condition_type=>'NOT_EQUALS'
,p_depending_on_expression=>'BOX'
,p_lov_type=>'STATIC'
,p_help_text=>'Select the size of badge to display.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18967037435745146)
,p_plugin_attribute_id=>wwv_flow_api.id(18966663649745146)
,p_display_sequence=>0
,p_display_value=>'Small'
,p_return_value=>'S'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18967593787745147)
,p_plugin_attribute_id=>wwv_flow_api.id(18966663649745146)
,p_display_sequence=>10
,p_display_value=>'Medium'
,p_return_value=>'M'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18968019475745147)
,p_plugin_attribute_id=>wwv_flow_api.id(18966663649745146)
,p_display_sequence=>20
,p_display_value=>'Large'
,p_return_value=>'L'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18968507855745147)
,p_plugin_attribute_id=>wwv_flow_api.id(18966663649745146)
,p_display_sequence=>30
,p_display_value=>'Extra Large'
,p_return_value=>'B'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18969027929745147)
,p_plugin_attribute_id=>wwv_flow_api.id(18966663649745146)
,p_display_sequence=>40
,p_display_value=>'Extra Extra Large'
,p_return_value=>'XXL'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18969546340745148)
,p_plugin_id=>wwv_flow_api.id(18960964510745139)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>60
,p_prompt=>'Chart Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'BOX'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select the shape of the badges to display.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18969936198745148)
,p_plugin_attribute_id=>wwv_flow_api.id(18969546340745148)
,p_display_sequence=>10
,p_display_value=>'Rectangular'
,p_return_value=>'BOX'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18970437258745149)
,p_plugin_attribute_id=>wwv_flow_api.id(18969546340745148)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'DOT'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18970966396745149)
,p_plugin_id=>wwv_flow_api.id(18960964510745139)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Color'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'N'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select if the badges should be displayed in different colors, or without colors.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18971306408745149)
,p_plugin_attribute_id=>wwv_flow_api.id(18970966396745149)
,p_display_sequence=>10
,p_display_value=>'Yes'
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18971896826745149)
,p_plugin_attribute_id=>wwv_flow_api.id(18970966396745149)
,p_display_sequence=>20
,p_display_value=>'No'
,p_return_value=>'N'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_d3_barchart
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(18972647317745151)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.D3.BARCHART'
,p_display_name=>'D3 Bar Chart'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.D3.BARCHART'),'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.barchart/')
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/d3/3.5.5/d3.min.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/d3.oracle.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/oracle.jql.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/jquery.getScrollbarWidth.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.tooltip/d3.oracle.tooltip.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.ary/d3.oracle.ary.js',
'#PLUGIN_FILES#d3.oracle.barchart.js',
'#PLUGIN_FILES#d3.oracle.barchart.apex.js',
'#PLUGIN_FILES#com.oracle.apex.d3.barchart.js'))
,p_css_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.tooltip/d3.oracle.tooltip.css',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.ary/d3.oracle.ary.css',
'#PLUGIN_FILES#d3.oracle.barchart.css'))
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render ',
'(',
'    p_region                in  apex_plugin.t_region,',
'    p_plugin                in  apex_plugin.t_plugin,',
'    p_is_printer_friendly   in  boolean ',
')',
'return apex_plugin.t_region_render_result',
'is',
'    c_region_static_id      constant varchar2(255)  := apex_escape.html_attribute( p_region.static_id );',
'',
'-- Assign readable names to plugin attributes. Omit data attributes, they''ll be handled in ajax function.',
'    -- Dimensions',
'    c_height_mode           constant varchar2(200)  := p_region.attribute_21;',
'    c_min_height            constant number         := nvl(p_region.attribute_18, 100);',
'    c_max_height            constant number         := nvl(p_region.attribute_19, 500);',
'    c_spacing               constant number         := nvl(p_region.attribute_16, 20);',
'    c_inner_spacing         constant number         := nvl(p_region.attribute_17, 20);',
'',
'    -- Axis titles',
'    c_x_axis_title          constant varchar2(200)  := p_region.attribute_08;',
'    c_y_axis_title          constant varchar2(200)  := p_region.attribute_09;',
'',
'    -- Axis grid',
'    c_x_axis_grid           constant boolean        := instr('':'' || p_region.attribute_22 || '':'', '':X:'') > 0;',
'    c_y_axis_grid           constant boolean        := instr('':'' || p_region.attribute_22 || '':'', '':Y:'') > 0;',
'',
'    -- Tooltip configuration',
'    c_show_tooltip          constant boolean        := p_region.attribute_10 is not null;',
'    c_series_tooltip        constant boolean        := instr('':'' || p_region.attribute_10 || '':'', '':SERIES:'') > 0;',
'    c_x_tooltip             constant boolean        := instr('':'' || p_region.attribute_10 || '':'', '':X:'') > 0;',
'    c_y_tooltip             constant boolean        := instr('':'' || p_region.attribute_10 || '':'', '':Y:'') > 0;',
'    c_custom_tooltip        constant boolean        := instr('':'' || p_region.attribute_10 || '':'', '':CUSTOM:'') > 0;',
'',
'    -- Legend',
'    c_show_legend           constant boolean        := p_region.attribute_12 is not null;',
'    c_legend_position       constant varchar2(200)  := p_region.attribute_12;',
'',
'    -- Display modes',
'    c_value_template        constant varchar2(200)  := nvl(p_region.attribute_15, p_region.attribute_25);',
'    c_horizontal            constant boolean        := substr(p_region.attribute_06, 1, instr(p_region.attribute_06, '','') - 1) = ''HORIZONTAL'';',
'    c_display               constant varchar2(200)  := substr(p_region.attribute_06, instr(p_region.attribute_06, '','') + 1);',
'    c_responsive            constant boolean        := p_plugin.attribute_06 = ''Y'';',
'    c_transitions           constant boolean        := p_plugin.attribute_05 = ''Y'';',
'',
'    -- Colors',
'    c_color_scheme          constant varchar2(200)  := p_region.attribute_13;',
'    l_colors                varchar2(200)           := p_region.attribute_14;',
'    c_multiple_colors       constant boolean        := p_region.attribute_24 = ''Y'';',
'',
'    -- Aspect ratios',
'    c_min_ar                constant number         := nvl( apex_plugin_util.get_attribute_as_number( p_plugin.attribute_02, ''Min Aspect Radio'' ), 1.333);',
'    c_max_ar                constant number         := nvl( apex_plugin_util.get_attribute_as_number( p_plugin.attribute_01, ''Max Aspect Radio'' ), 3);',
'    c_threshold             constant number         := p_plugin.attribute_03;',
'    c_threshold_of          constant varchar2(200)  := p_plugin.attribute_04;',
'',
'    -- Function constants',
'    c_rgb_list_regex        constant varchar2(200)  := ''^#[0-9a-fA-F]{6}(,#[0-9a-fA-F]{6})*$'';',
'begin',
'    -- Add placeholder div',
'    sys.htp.p (',
'        ''<div class="a-D3BarChart" id="'' || c_region_static_id || ''_region">'' ||',
'            ''<div class="a-D3BarChart-container" id="'' || c_region_static_id || ''_chart"></div>'' ||',
'        ''</div>'' );',
'',
'',
'    -- Color scheme',
'    case c_color_scheme',
'        when ''MODERN'' then',
'            l_colors := ''#FF3B30:#FF9500:#FFCC00:#4CD964:#34AADC:#007AFF:#5856D6:#FF2D55:#8E8E93:#C7C7CC'';',
'        when ''MODERN2'' then',
'            l_colors := ''#1ABC9C:#2ECC71:#4AA3DF:#9B59B6:#3D566E:#F1C40F:#E67E22:#E74C3C'';',
'        when ''SOLAR'' then',
'            l_colors := ''#B58900:#CB4B16:#DC322F:#D33682:#6C71C4:#268BD2:#2AA198:#859900'';',
'        when ''METRO'' then',
'            l_colors := ''#E61400:#19A2DE:#319A31:#EF9608:#8CBE29:#A500FF:#00AAAD:#FF0094:#9C5100:#E671B5'';',
'        else',
'            null;',
'    end case;',
'',
'    -- Build the initial chart. Data will be loaded with ajax.',
'    apex_javascript.add_onload_code (',
'        p_code => ''(function(){ var a = com_oracle_apex_d3_barchart('' ||',
'            apex_javascript.add_value(p_region.static_id) ||',
'            ''{'' ||',
'                apex_javascript.add_attribute(''chartRegionId'',  p_region.static_id || ''_chart'') ||',
'                apex_javascript.add_attribute(''xAxisTitle'',     c_x_axis_title) || ',
'                apex_javascript.add_attribute(''yAxisTitle'',     c_y_axis_title) || ',
'                apex_javascript.add_attribute(''showTooltip'',    c_show_tooltip) || ',
'                apex_javascript.add_attribute(''tooltipSeries'',  c_series_tooltip) || ',
'                apex_javascript.add_attribute(''tooltipX'',       c_x_tooltip) || ',
'                apex_javascript.add_attribute(''tooltipY'',       c_y_tooltip) || ',
'                apex_javascript.add_attribute(''tooltipCustom'',  c_custom_tooltip) || ',
'                apex_javascript.add_attribute(''spacing'',        c_spacing) || ',
'                apex_javascript.add_attribute(''innerSpacing'',   c_inner_spacing) || ',
'                apex_javascript.add_attribute(''horizontal'',     c_horizontal) || ',
'                apex_javascript.add_attribute(''display'',        c_display) || ',
'                apex_javascript.add_attribute(''responsive'',     c_responsive) || ',
'                apex_javascript.add_attribute(''transitions'',    c_transitions) || ',
'                apex_javascript.add_attribute(''valueTemplate'',  c_value_template) || ',
'                apex_javascript.add_attribute(''showLegend'',     c_show_legend) || ',
'                apex_javascript.add_attribute(''legendPosition'', c_legend_position) || ',
'                apex_javascript.add_attribute(''colors'',         l_colors) || ',
'                apex_javascript.add_attribute(''xGrid'',          c_x_axis_grid) || ',
'                apex_javascript.add_attribute(''yGrid'',          c_y_axis_grid) || ',
'                apex_javascript.add_attribute(''multipleColors'', c_multiple_colors) || ',
'                apex_javascript.add_attribute(''heightMode'',     c_height_mode) || ',
'                apex_javascript.add_attribute(''minHeight'',      c_min_height) || ',
'                apex_javascript.add_attribute(''maxHeight'',      c_max_height) || ',
'                apex_javascript.add_attribute(''threshold'',      c_threshold) || ',
'                apex_javascript.add_attribute(''thresholdOf'',    c_threshold_of) || ',
'                apex_javascript.add_attribute(''minAR'',          c_min_ar) || ',
'                apex_javascript.add_attribute(''maxAR'',          c_max_ar) || ',
'                apex_javascript.add_attribute(''noDataFoundMessage'', p_region.no_data_found_message) || ',
'                apex_javascript.add_attribute(''pageItems'',      apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit)) ||',
'                apex_javascript.add_attribute(''ajaxIdentifier'', apex_plugin.get_ajax_identifier, false, false) ||',
'            ''},'' || apex_javascript.add_value( p_region.name, false ) || '');})()'' );',
'    return null;',
'end;',
'',
'function ajax',
'(',
'    p_region    in  apex_plugin.t_region,',
'    p_plugin    in  apex_plugin.t_plugin ',
')',
'return apex_plugin.t_region_ajax_result',
'is',
'    -- It''s better to have named variables instead of using the generic ones, ',
'    -- makes the code more readable. ',
'',
'    c_has_multiple_series   constant boolean := p_region.attribute_03 is not null;',
'',
'    -- Column names',
'    c_x_column              constant varchar2(255) := p_region.attribute_01;',
'    c_y_column              constant varchar2(255) := p_region.attribute_02;',
'    c_series_column         constant varchar2(255) := case when c_has_multiple_series then p_region.attribute_04 end;',
'    c_tooltip_column        constant varchar2(255) := p_region.attribute_11;',
'    c_link_target           constant varchar2(255) := p_region.attribute_20;',
'',
'    -- Series name, for single series configuration',
'    c_series_name           constant varchar2(200) := case when not c_has_multiple_series then p_region.attribute_05 end;',
'    c_use_sql_color         constant boolean       := p_region.attribute_13 = ''COLUMN'';',
'',
'    -- Column numbers for fetching',
'    l_x_column_no           pls_integer;',
'    l_y_column_no           pls_integer;',
'    l_series_column_no      pls_integer;',
'    l_tooltip_column_no     pls_integer;',
'    l_column_value_list     apex_plugin_util.t_column_value_list2;',
'',
'    -- Holders for row data',
'    l_x                     varchar2(200);',
'    l_y                     number;',
'    l_series                varchar2(4000);',
'    l_color                 varchar2(4000);',
'    l_tooltip               varchar2(4000);',
'    l_link                  varchar2(4000);',
'',
'begin',
'',
'    apex_json.initialize_output (',
'        p_http_cache => false );',
'',
'    apex_json.open_object;',
'',
'    -- First, we must get the color mapping if the color scheme requires it.',
'    if c_use_sql_color then',
'        l_column_value_list := apex_plugin_util.get_data2 (',
'            p_sql_statement     => p_region.attribute_23,',
'            p_min_columns       => 2,',
'            p_max_columns       => 2,',
'            p_component_name    => p_region.name );',
'',
'        apex_json.open_array(''colors'');',
'        for l_row_num in 1 .. l_column_value_list(1).value_list.count loop',
'            -- Series, optional',
'            l_series := apex_plugin_util.get_value_as_varchar2 (',
'                p_data_type => l_column_value_list(1).data_type,',
'                p_value     => l_column_value_list(1).value_list(l_row_num) );',
'            l_color := apex_plugin_util.get_value_as_varchar2 (',
'                p_data_type => l_column_value_list(2).data_type,',
'                p_value     => l_column_value_list(2).value_list(l_row_num) );',
'            ',
'            apex_json.open_object;',
'            apex_json.write(''series'', l_series);',
'            apex_json.write(''color'',  l_color);',
'            apex_json.close_object;',
'',
'        end loop;',
'        apex_json.close_array;',
'',
'        l_series := null;',
'    end if;',
'',
'    -- Then, we get the actual data points.',
'    l_column_value_list := apex_plugin_util.get_data2 (',
'        p_sql_statement  => p_region.source,',
'        p_min_columns    => 2,',
'        p_max_columns    => 5,',
'        p_component_name => p_region.name );',
'',
'    -- Get the actual column # for faster access and also verify that the data type',
'    -- of the column matches with what we are looking for',
'    l_x_column_no := apex_plugin_util.get_column_no (',
'                p_attribute_label       => ''x column'',',
'                p_column_alias          => c_x_column,',
'                p_column_value_list     => l_column_value_list,',
'                p_is_required           => true,',
'                p_data_type             => apex_plugin_util.c_data_type_varchar2 );',
'',
'    l_y_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''y column'',',
'        p_column_alias          => c_y_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => true,',
'        p_data_type             => apex_plugin_util.c_data_type_number );',
'',
'    l_series_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''series column'',',
'        p_column_alias          => c_series_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => false,',
'        p_data_type             => apex_plugin_util.c_data_type_varchar2 );',
'',
'    l_tooltip_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''tooltip column'',',
'        p_column_alias          => c_tooltip_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => false,',
'        p_data_type             => apex_plugin_util.c_data_type_varchar2 );',
'',
'    apex_json.open_array(''data'');',
'',
'    -- Fetch data',
'    for l_row_num in 1 .. l_column_value_list(1).value_list.count loop',
'        begin',
'            apex_plugin_util.set_component_values (',
'                p_column_value_list => l_column_value_list,',
'                p_row_num => l_row_num ',
'            );',
'',
'            -- X is a string, required',
'            if l_x_column_no is not null then',
'                l_x := apex_plugin_util.get_value_as_varchar2 (',
'                    p_data_type => l_column_value_list(l_x_column_no).data_type,',
'                    p_value     => l_column_value_list(l_x_column_no).value_list(l_row_num) );',
'            end if;',
'',
'            -- Y is a number, required',
'            l_y := l_column_value_list(l_y_column_no).value_list(l_row_num).number_value;',
'',
'            -- Series, optional',
'            if l_series_column_no is not null then',
'                l_series := apex_plugin_util.get_value_as_varchar2 (',
'                    p_data_type => l_column_value_list(l_series_column_no).data_type,',
'                    p_value     => l_column_value_list(l_series_column_no).value_list(l_row_num) );',
'            end if;',
'',
'            -- Tooltip, optional',
'            if l_tooltip_column_no is not null then',
'                l_tooltip := apex_plugin_util.get_value_as_varchar2 (',
'                    p_data_type => l_column_value_list(l_tooltip_column_no).data_type,',
'                    p_value     => l_column_value_list(l_tooltip_column_no).value_list(l_row_num) );',
'            end if;',
'',
'            -- Link, optional',
'            if c_link_target is not null then',
'                l_link := wwv_flow_utilities.prepare_url (',
'                    apex_plugin_util.replace_substitutions (',
'                        p_value  => c_link_target,',
'                        p_escape => false ) );',
'            end if;',
'',
'            apex_json.open_object;',
'            apex_json.write(''series'',  nvl(l_series, c_series_name));',
'            apex_json.write(''tooltip'', l_tooltip);',
'            apex_json.write(''link'',    l_link);',
'            apex_json.write(''x'',       l_x);',
'            apex_json.write(''y'',       l_y);',
'            apex_json.close_object;',
'',
'            apex_plugin_util.clear_component_values;',
'        exception when others then',
'            apex_plugin_util.clear_component_values;',
'            raise;',
'        end;',
'    end loop;',
'    apex_json.close_array;',
'    apex_json.close_object;',
'',
'    return null;',
'end;'))
,p_render_function=>'render'
,p_ajax_function=>'ajax'
,p_standard_attributes=>'SOURCE_SQL:SOURCE_REQUIRED:AJAX_ITEMS_TO_SUBMIT:NO_DATA_FOUND_MESSAGE'
,p_sql_min_column_count=>2
,p_sql_max_column_count=>5
,p_substitute_attributes=>false
,p_reference_id=>2128459524608545175
,p_subscribe_plugin_settings=>true
,p_help_text=>'Data Driven Documents (D3) Bar Chart provides dynamic and interactive bar charts for data visualization, using Scalable Vector Graphics (SVG), JavaScript, HTML5, and Cascading Style Sheets (CSS3) standards.'
,p_version_identifier=>'5.0.1'
,p_about_url=>'http://apex.oracle.com/plugins'
,p_files_version=>58
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18972907337745152)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>510
,p_prompt=>'Maximum Aspect Ratio'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'3'
,p_display_length=>5
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the maximum aspect ratio that charts use to recommend a height. A maximum aspect ratio of 3 means that the chart''s width should be no greater than 3 times its height. </p>',
'<p>Note: This setting can be overridden by the ''Maximum Height'' setting on the region.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18973353909745153)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>500
,p_prompt=>'Minimum Aspect Ratio'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'1.333'
,p_display_length=>5
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the minimum aspect ratio that charts use to recommend a height. A minimum aspect ratio of 1.333 means that the chart''s width should be no less than 1.333 times its height. </p>',
'<p>Note: This setting can be overridden by the ''Minimum Height'' setting on the region.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18973776606745153)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>3
,p_display_sequence=>540
,p_prompt=>'Responsive Behavior Threshold'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'480'
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'Enter the threshold (in pixels) at which the responsive behavior will be activated.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18974174337745153)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>4
,p_display_sequence=>530
,p_prompt=>'Responsive Behavior Measure'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'WINDOW'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select whether the responsive behavior threshold will be compared to the window or the region width.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18974548833745153)
,p_plugin_attribute_id=>wwv_flow_api.id(18974174337745153)
,p_display_sequence=>10
,p_display_value=>'Window'
,p_return_value=>'WINDOW'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18975041222745154)
,p_plugin_attribute_id=>wwv_flow_api.id(18974174337745153)
,p_display_sequence=>20
,p_display_value=>'Region'
,p_return_value=>'REGION'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18975589965745154)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>5
,p_display_sequence=>550
,p_prompt=>'Enable Transitions'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Select whether transitions are enabled for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18975985045745154)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>6
,p_display_sequence=>520
,p_prompt=>'Responsive Behavior'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Select whether responsive behavior is enabled for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18976399752745154)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'X Values Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query which holds the X-axis values for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18976795534745154)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Y Values Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query which holds the Y-axis values for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18977120595745155)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>50
,p_prompt=>'Multiple Series'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Check multiple series if you want the chart displaying more than one series of data. The different series must be specified by a column from the region SQL Query.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18977546256745155)
,p_plugin_attribute_id=>wwv_flow_api.id(18977120595745155)
,p_display_sequence=>10
,p_display_value=>' '
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18978063988745155)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>60
,p_prompt=>'Series Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18977120595745155)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Select the column from the region SQL Query that defines the multiple series for the chart. The values from this column will become the labels for the series.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18978401079745155)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>70
,p_prompt=>'Series Name'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(18977120595745155)
,p_depending_on_condition_type=>'NULL'
,p_help_text=>'Enter the name of the single data series which is shown on the legend.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18978808684745156)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>40
,p_prompt=>'Display'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'VERTICAL,SIDE-BY-SIDE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select how the bar chart data is displayed.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18979279265745156)
,p_plugin_attribute_id=>wwv_flow_api.id(18978808684745156)
,p_display_sequence=>10
,p_display_value=>'Vertical, Side by Side'
,p_return_value=>'VERTICAL,SIDE-BY-SIDE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18979748371745156)
,p_plugin_attribute_id=>wwv_flow_api.id(18978808684745156)
,p_display_sequence=>20
,p_display_value=>'Horizontal, Side by Side'
,p_return_value=>'HORIZONTAL,SIDE-BY-SIDE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18980207929745156)
,p_plugin_attribute_id=>wwv_flow_api.id(18978808684745156)
,p_display_sequence=>30
,p_display_value=>'Vertical, Stacked'
,p_return_value=>'VERTICAL,STACKED'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18980715688745156)
,p_plugin_attribute_id=>wwv_flow_api.id(18978808684745156)
,p_display_sequence=>40
,p_display_value=>'Horizontal, Stacked'
,p_return_value=>'HORIZONTAL,STACKED'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18981281832745157)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>90
,p_prompt=>'X-Axis Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>20
,p_is_translatable=>true
,p_help_text=>'Enter the label for the X-axis.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18981678713745157)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>100
,p_prompt=>'Y-Axis Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>20
,p_is_translatable=>true
,p_help_text=>'The label for the Y-axis.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18982087108745157)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>130
,p_prompt=>'Tooltips'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Check which attributes are shown on the tooltip for each data point. The ''Custom column'' option allows you to specify text for each individual data point as an additional column in the region SQL Query.</p>',
'<p>Note: Leave all options unchecked to disable the tooltip.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18982460829745157)
,p_plugin_attribute_id=>wwv_flow_api.id(18982087108745157)
,p_display_sequence=>0
,p_display_value=>'Show series name'
,p_return_value=>'SERIES'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18982998380745158)
,p_plugin_attribute_id=>wwv_flow_api.id(18982087108745157)
,p_display_sequence=>10
,p_display_value=>'Show X value'
,p_return_value=>'X'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18983441507745158)
,p_plugin_attribute_id=>wwv_flow_api.id(18982087108745157)
,p_display_sequence=>20
,p_display_value=>'Show Y value'
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18983990649745159)
,p_plugin_attribute_id=>wwv_flow_api.id(18982087108745157)
,p_display_sequence=>30
,p_display_value=>'Custom column'
,p_return_value=>'CUSTOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18984494750745159)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>140
,p_prompt=>'Tooltip Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18982087108745157)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'SERIES:X:Y:CUSTOM,SERIES:X:CUSTOM,SERIES:Y:CUSTOM,X:Y:CUSTOM,SERIES:CUSTOM,X:CUSTOM,Y:CUSTOM,CUSTOM'
,p_help_text=>'Enter the column from the region SQL Query that holds the custom tooltip values.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18984816299745159)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>150
,p_prompt=>'Legend'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'No Legend'
,p_help_text=>'Select where the legend is displayed on the chart.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18985236996745160)
,p_plugin_attribute_id=>wwv_flow_api.id(18984816299745159)
,p_display_sequence=>10
,p_display_value=>'Above chart'
,p_return_value=>'TOP'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18985786569745160)
,p_plugin_attribute_id=>wwv_flow_api.id(18984816299745159)
,p_display_sequence=>20
,p_display_value=>'Below chart'
,p_return_value=>'BOTTOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18986288028745160)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>250
,p_prompt=>'Color Scheme'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'MODERN'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Theme Default'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Select the color scheme used to render the chart.</p>',
'<p>Note: For multiple series charts, each series will be assigned a different color depending on the setting for ''Multiple Colors''.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18986699069745160)
,p_plugin_attribute_id=>wwv_flow_api.id(18986288028745160)
,p_display_sequence=>10
,p_display_value=>'Modern'
,p_return_value=>'MODERN'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18987157133745161)
,p_plugin_attribute_id=>wwv_flow_api.id(18986288028745160)
,p_display_sequence=>20
,p_display_value=>'Modern 2'
,p_return_value=>'MODERN2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18987665723745161)
,p_plugin_attribute_id=>wwv_flow_api.id(18986288028745160)
,p_display_sequence=>30
,p_display_value=>'Solar'
,p_return_value=>'SOLAR'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18988100659745161)
,p_plugin_attribute_id=>wwv_flow_api.id(18986288028745160)
,p_display_sequence=>40
,p_display_value=>'Metro'
,p_return_value=>'METRO'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18988665350745161)
,p_plugin_attribute_id=>wwv_flow_api.id(18986288028745160)
,p_display_sequence=>50
,p_display_value=>'SQL Query'
,p_return_value=>'COLUMN'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18989168494745162)
,p_plugin_attribute_id=>wwv_flow_api.id(18986288028745160)
,p_display_sequence=>60
,p_display_value=>'Custom'
,p_return_value=>'CUSTOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18989645046745162)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>260
,p_prompt=>'Colors'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18986288028745160)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'CUSTOM'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<dl>',
'  <dt>Hexadecimal (hex) notation</dt><dd><pre>#FF3377</pre>;</dd>',
'  <dt>RGB color notation  (red,green,blue)</dt><dd><pre>rgba(0,25,47,0.5)</pre>; or </dd>',
'  <dt>RGBA color notation (red,green,blue,alpha)</dt><dd><pre>rgba(0,25,47,0.5)</pre>; or </dd>',
'  <dt>HTML colors</dt><dd><pre>blue</pre>.</dd>',
'</dl>'))
,p_help_text=>'<p>Enter a colon-separated list of color strings for the custom colors to be used in the chart.</p>'
);
end;
/
begin
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18990014470745162)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>120
,p_prompt=>'Custom Value Formatting'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'FRIENDLY'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_depending_on_condition_type=>'NULL'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul>',
'<li><b>,d</b> = 14,435</li>',
'<li><b>d</b> = 14435</li>',
'<li><b>,.2f</b> = 14,435.49</li>',
'<li><b>.2f</b> = 14435.49</li>',
'<li><b>.3s</b> = 14.4k</li>',
'<li><b>$,d</b> = $14,435</li>',
'<li><b>$d</b> = $14435</li>',
'<li><b>$,.2f</b> = $14,435.49</li>',
'<li><b>$.2f</b> = $14435.49</li>',
'<li><b>$.3s</b> = $14.4k</li>',
'<li><b>n" ft."</b> = 14435.49 ft. **</li>',
'<li><b>"[["$.3s"]]"</b> = [[$14.4k]] **</li>',
'<li>Refer to https://github.com/mbostock/d3/wiki/Formatting#d3_format for the full syntax specification</li>',
'</ul>',
'<br/>',
'** You may use leading and trailing double-quoted literals, but this feature is not part of the standard D3 specification'))
,p_help_text=>'Enter the D3 format string used to format the Y-axis values on axes, tooltips and legends. Use <pre>FRIENDLY</pre> to utilize sensible formatting defaults for your data.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18990449055745162)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>200
,p_prompt=>'Spacing Between Categories'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'10'
,p_display_length=>5
,p_max_length=>3
,p_unit=>'%'
,p_is_translatable=>false
,p_help_text=>'Enter the spacing between categories, expressed as an integer percentage (1-100).'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18990818308745163)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>210
,p_prompt=>'Spacing Between Series'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'10'
,p_display_length=>5
,p_max_length=>3
,p_unit=>'%'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18977120595745155)
,p_depending_on_condition_type=>'NOT_NULL'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the spacing between series on the same category (X-axis value). It is represented as an integer percentage (0-100).</p>',
'<p>Note: This setting only affects charts using the "Side by Side" display modes.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18991253580745163)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>180
,p_prompt=>'Minimum Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_display_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'Enter the minimum height, in pixels, of the chart. Chart width will adapt to the size of the region. Defaults to 100px.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18991674616745163)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>190
,p_prompt=>'Maximum Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_display_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'The maximum height, in pixels, of the chart. Chart width will adapt to the size of the region. Defaults to 500px.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18992042393745163)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>30
,p_prompt=>'Link Target'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_is_translatable=>false
,p_reference_scope=>'ROW'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Example 1: URL to navigate to page 10 and set P10_EMPNO to the EMPNO value of the clicked entry.',
'<pre>f?p=&amp;APP_ID.:10:&amp;APP_SESSION.::&amp;DEBUG.:RP,10:P10_EMPNO:&amp;EMPNO.</pre>',
'</p>',
'<p>Example 2: Display the EMPNO value of the clicked entry in a JavaScript alert',
'<pre>javascript:alert(''current empno: &amp;EMPNO.'');</pre>',
'</p>'))
,p_help_text=>'<p>Enter a target page to be called when the user clicks a chart entry.</p>'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18992446099745163)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>170
,p_prompt=>'Height Measure'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'BARS'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select how the minimum and maximum height of the chart is calculated.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18992855204745164)
,p_plugin_attribute_id=>wwv_flow_api.id(18992446099745163)
,p_display_sequence=>10
,p_display_value=>'Bars Area'
,p_return_value=>'BARS'
,p_help_text=>'Minimum and maximum height for the area is determined by the height of the the bars drawn. Axis labels may take additional space.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18993334777745164)
,p_plugin_attribute_id=>wwv_flow_api.id(18992446099745163)
,p_display_sequence=>20
,p_display_value=>'Chart Area'
,p_return_value=>'CHART'
,p_help_text=>'Minimum and maximum height will include the axes dimensions.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18993816716745164)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>160
,p_prompt=>'Show Grid Lines'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Check the axes to display grid lines for that axis.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18994214734745164)
,p_plugin_attribute_id=>wwv_flow_api.id(18993816716745164)
,p_display_sequence=>10
,p_display_value=>'X-Axis'
,p_return_value=>'X'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18994710991745165)
,p_plugin_attribute_id=>wwv_flow_api.id(18993816716745164)
,p_display_sequence=>20
,p_display_value=>'Y-Axis'
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18995241374745165)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>23
,p_display_sequence=>270
,p_prompt=>'Color SQL Query'
,p_attribute_type=>'SQL'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_sql_min_column_count=>2
,p_sql_max_column_count=>2
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18986288028745160)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'COLUMN'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<pre>select ''SALES'', rgb(0,255,0)',
'from dual',
'UNION',
'select ''RESEARCH'', rgba(0,25,47,0.5)',
'from dual;</pre>'))
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Enter a SQL Query that maps a series name to an RGB color. The first column must contain the series names (and those values must match the ones returned from the region SQL) and the second column must have the RGB or RGBA color notation for the serie'
||'s. ',
'Both columns must be VARCHAR2.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18995602224745165)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>80
,p_prompt=>'Multiple Colors'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(18977120595745155)
,p_depending_on_condition_type=>'NULL'
,p_help_text=>'Select whether each series is displayed in a different color.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(18996063694745165)
,p_plugin_id=>wwv_flow_api.id(18972647317745151)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>25
,p_display_sequence=>110
,p_prompt=>'Value Format Mask'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Custom'
,p_help_text=>'Select the format mask to apply to the displayed values.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18996427792745165)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>30
,p_display_value=>'14,435'
,p_return_value=>',.0f'
,p_help_text=>'Comma-separated thousands, integers'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18996975221745166)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>40
,p_display_value=>'14435'
,p_return_value=>'.0f'
,p_help_text=>'Integer'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18997405399745166)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>60
,p_display_value=>'14,435.49'
,p_return_value=>',.2f'
,p_help_text=>'Comma-separated thousands, 2 decimals'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18997977837745166)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>70
,p_display_value=>'14435.49'
,p_return_value=>'.2f'
,p_help_text=>'2 decimals'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18998422139745166)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>71
,p_display_value=>'14.4k'
,p_return_value=>'.3s'
,p_help_text=>'Precision 3, SI suffixes'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18998918464745167)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>80
,p_display_value=>'$14,435'
,p_return_value=>'$,.0f'
,p_help_text=>'Currency, comma-separated thousands, integer'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18999404109745167)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>90
,p_display_value=>'$14435'
,p_return_value=>'$.0f'
,p_help_text=>'Currency, integer'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(18999916325745167)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>99
,p_display_value=>'$14,435.49'
,p_return_value=>'$,.2f'
,p_help_text=>'Currency, comma-separated thousands, 2 decimals'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19000448229745167)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>100
,p_display_value=>'$14435.49'
,p_return_value=>'$.2f'
,p_help_text=>'Currency, 2 decimals'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19000989596745168)
,p_plugin_attribute_id=>wwv_flow_api.id(18996063694745165)
,p_display_sequence=>120
,p_display_value=>'$14.4k'
,p_return_value=>'$.3s'
,p_help_text=>'Currency, precison 3, SI suffixes'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_d3_bubble
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(19004873475745172)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.D3.BUBBLE'
,p_display_name=>'D3 Bubble Chart'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.D3.BUBBLE'),'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.bubblechart/1.0/')
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/d3/3.5.5/d3.min.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/d3.oracle.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/oracle.jql.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.tooltip/d3.oracle.tooltip.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.ary/d3.oracle.ary.js',
'#PLUGIN_FILES#com.oracle.apex.d3.bubblechart.js',
''))
,p_css_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.tooltip/d3.oracle.tooltip.css',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.ary/d3.oracle.ary.css',
'#PLUGIN_FILES#d3.oracle.bubblechart.css',
''))
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function ora_d3_bubble_ajax (    ',
'    p_region in apex_plugin.t_region,',
'    p_plugin in apex_plugin.t_plugin ',
')',
'    return apex_plugin.t_region_ajax_result is',
'',
'    c_label_col     constant varchar2(255) := p_region.attribute_12;',
'    c_value_col     constant varchar2(255) := p_region.attribute_13;',
'    c_pk_col        constant varchar2(255) := p_region.attribute_14;',
'    c_group_col     constant varchar2(255) := p_region.attribute_15;',
'    c_link_col      constant varchar2(255) := p_region.attribute_16;',
'    c_desc_col      constant varchar2(255) := p_region.attribute_17;',
'    c_link_target   constant varchar2(255) := p_region.attribute_18;',
'    c_tooltip_col   constant varchar2(255) := p_region.attribute_20;',
'',
'    l_label_col_no pls_integer;',
'    l_value_col_no pls_integer;',
'    l_pk_col_no    pls_integer;',
'    l_group_col_no pls_integer;',
'    l_link_col_no  pls_integer;',
'    l_desc_col_no  pls_integer;',
'    l_tooltip_col_no pls_integer;',
'',
'    l_label     varchar2(4000);',
'    l_value     number;',
'    l_pk        varchar2(4000);',
'    l_group     varchar2(4000);',
'    l_link      varchar2(4000);',
'    l_desc      varchar2(4000);',
'    l_tooltip   varchar2(4000);',
'',
'    l_num_rows          pls_integer := p_region.fetched_rows;',
'    l_count             pls_integer := 0;',
'    l_column_value_list apex_plugin_util.t_column_value_list2;',
'begin',
'    apex_json.initialize_output (',
'        p_http_cache => false );',
'',
'    -- get the data to be displayed',
'    l_column_value_list := apex_plugin_util.get_data2 (',
'        p_sql_statement  => p_region.source,',
'        p_min_columns    => 4,',
'        p_max_columns    => null,',
'        p_component_name => p_region.name );',
'',
'    -- Get the actual column number for the fields we want.',
'    l_label_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Label Column'',',
'                        p_column_alias      => c_label_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'    l_value_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Value Column'',',
'                        p_column_alias      => c_value_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_number',
'                    );',
'    l_pk_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Primary Key Column'',',
'                        p_column_alias      => c_pk_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'    l_group_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Color Group Column'',',
'                        p_column_alias      => c_group_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'',
'    if instr('':'' || p_region.attribute_19 || '':'', '':CUSTOM:'') > 0 then',
'        l_tooltip_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Tooltip Column'',',
'                        p_column_alias      => c_tooltip_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => false,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'    end if;',
'    -- Loop through the data',
'    apex_json.open_object;',
'    apex_json.open_array(''row'');',
'    for l_row_num in 1..l_column_value_list(1).value_list.count loop',
'        if l_count < nvl(l_num_rows,l_count) then',
'            l_count := l_count+1;',
'            begin',
'                -- Assign the column values of the current row',
'                -- into session state',
'                apex_plugin_util.set_component_values (',
'                    p_column_value_list => l_column_value_list,',
'                    p_row_num => l_row_num ',
'                );',
'',
'                apex_json.open_object;',
'',
'                l_label := apex_plugin_util.get_value_as_varchar2(',
'                                p_data_type => l_column_value_list(l_label_col_no).data_type,',
'                                p_value     => l_column_value_list(l_label_col_no).value_list(l_row_num) );',
'                l_value := l_column_value_list(l_value_col_no).value_list(l_row_num).number_value;',
'                l_pk    := apex_plugin_util.get_value_as_varchar2(',
'                                p_data_type => l_column_value_list(l_pk_col_no).data_type,',
'                                p_value     => l_column_value_list(l_pk_col_no).value_list(l_row_num) );',
'                l_group := apex_plugin_util.get_value_as_varchar2(',
'                                p_data_type => l_column_value_list(l_group_col_no).data_type,',
'                                p_value     => l_column_value_list(l_group_col_no).value_list(l_row_num) );',
'',
'                -- Emit the optional columns if provided',
'',
'                -- Tooltip, optional',
'                if l_tooltip_col_no is not null then',
'                    l_tooltip := apex_plugin_util.get_value_as_varchar2 (',
'                        p_data_type => l_column_value_list(l_tooltip_col_no).data_type,',
'                        p_value     => l_column_value_list(l_tooltip_col_no).value_list(l_row_num) );',
'                end if;',
'',
'                -- Link Target, optional',
'                if c_link_target is not null then',
'                    l_link := wwv_flow_utilities.prepare_url (',
'                        apex_plugin_util.replace_substitutions (',
'                            p_value  => c_link_target,',
'                            p_escape => false ) );',
'                end if;',
'',
'                -- Emit the required columns',
'                apex_json.write(''ID'',        l_pk);',
'                apex_json.write(''LABEL'',     l_label);',
'                apex_json.write(''COLORVALUE'',l_group);',
'                apex_json.write(''SIZEVALUE'', l_value);',
'                apex_json.write(''TOOLTIP'',l_tooltip);',
'                apex_json.write(''LINK'', l_link);',
'',
'                apex_json.close_object;',
'',
'                apex_plugin_util.clear_component_values;',
'            exception when others then',
'                apex_plugin_util.clear_component_values;',
'                raise;',
'            end;',
'        end if;',
'    end loop;',
'    apex_json.close_all;',
'',
'    return null;',
'end ora_d3_bubble_ajax;',
'',
'function ora_d3_bubble_render ( p_region              in apex_plugin.t_region,',
'                                p_plugin              in apex_plugin.t_plugin,',
'                                p_is_printer_friendly in boolean  )',
'                        return apex_plugin.t_region_render_result is',
'',
'    --Advanced Configuration',
'    l_adv_conf         apex_application_page_regions.attribute_24%type := p_region.attribute_24;',
'    l_sorting          apex_application_page_regions.attribute_25%type := p_region.attribute_25;',
'',
'    --Color Scheme',
'    l_colors           apex_application_page_regions.attribute_02%type := p_region.attribute_02;',
'    l_colors_fg        apex_application_page_regions.attribute_02%type;',
'',
'    --Dimensions',
'    c_min_height            constant number         := nvl(p_region.attribute_21, 100);',
'    c_max_height            constant number         := nvl(p_region.attribute_22, 500);',
'',
'    --Aspect Ratios',
'    c_min_ar                constant number         := apex_plugin_util.get_attribute_as_number(p_plugin.attribute_01, ''Min Aspect Ratio'');',
'    c_max_ar                constant number         := apex_plugin_util.get_attribute_as_number(p_plugin.attribute_02, ''Max Aspect Ratio'');',
'    l_formatted_min_ar      varchar2(200);',
'    l_formatted_max_ar      varchar2(200);',
'',
'    -- Legend',
'    c_show_legend           constant boolean        := p_region.attribute_23 is not null;',
'    c_legend_position       constant varchar2(200)  := p_region.attribute_23;',
'    ',
'     -- Tooltip configuration',
'    c_show_tooltip          constant boolean        := p_region.attribute_19 is not null;',
'    c_series_tooltip        constant boolean        := instr('':'' || p_region.attribute_19 || '':'', '':SERIES:'') > 0;',
'    c_custom_tooltip        constant boolean        := instr('':'' || p_region.attribute_19 || '':'', '':CUSTOM:'') > 0;',
'    c_value_tooltip         constant boolean        := instr('':'' || p_region.attribute_19 || '':'', '':VALUE:'')  > 0;',
'',
'begin',
'',
'    -- Formatting to fix add_attribute bug.',
'    if c_min_ar > -1 and c_min_ar < 1 and c_min_ar <> 0 then',
'        l_formatted_min_ar := (case when c_min_ar < 0 then ''-'' else '''' end) || ''0'' || to_char(abs(c_min_ar));',
'    else',
'        l_formatted_min_ar := to_char(c_min_ar);',
'    end if;',
'    if c_max_ar > -1 and c_max_ar < 1 and c_max_ar <> 0 then',
'        l_formatted_max_ar := (case when c_max_ar < 0 then ''-'' else '''' end) || ''0'' || to_char(abs(c_max_ar));',
'    else',
'        l_formatted_max_ar := to_char(c_max_ar);',
'    end if;',
'',
'    -- Color scheme',
'    IF l_colors = ''MODERN'' THEN',
'        l_colors    := ''#FF3B30:#FF9500:#FFCC00:#4CD964:#34AADC:#007AFF:#5856D6:#FF2D55:#8E8E93:#C7C7CC'';',
'        l_colors_fg := ''#000000:#000000:#000000:#000000:#000000:#000000:#FFFFFF:#000000:#000000:#000000'';',
'    ELSIF l_colors = ''MODERN2'' THEN',
'        l_colors    := ''#1ABC9C:#2ECC71:#4AA3DF:#9B59B6:#3D566E:#F1C40F:#E67E22:#E74C3C'';',
'        l_colors_fg := ''#000000:#000000:#000000:#FFFFFF:#FFFFFF:#000000:#000000:#000000'';',
'    ELSIF l_colors = ''SOLAR'' THEN',
'        l_colors    := ''#B58900:#CB4B16:#DC322F:#D33682:#6C71C4:#268BD2:#2AA198:#859900'';',
'        l_colors_fg := ''#000000:#FFFFFF:#FFFFFF:#FFFFFF:#000000:#000000:#000000:#000000'';',
'    ELSIF l_colors = ''METRO'' then',
'        l_colors    := ''#E61400:#19A2DE:#319A31:#EF9608:#8CBE29:#A500FF:#00AAAD:#FF0094:#9C5100:#E671B5'';',
'        l_colors_fg := ''#FFFFFF:#000000:#000000:#000000:#000000:#FFFFFF:#000000:#000000:#FFFFFF:#000000'';',
'    ELSE',
'        l_colors    := null;',
'        l_colors_fg := null;',
'    END IF;',
'',
'    sys.htp.p(',
'        ''<div class="a-D3BubbleChart" id="'' || apex_plugin_util.escape(p_region.static_id, true) || ''_region">'' ||',
'            ''<div class="a-D3BubbleChart-container" id="'' || apex_plugin_util.escape(p_region.static_id, true) ||''_chart"></div>'' ||',
'        ''</div>'');',
'    apex_javascript.add_onload_code (''com_oracle_apex_d3_bubble_start(''',
'        ||apex_javascript.add_value(p_region.static_id, true)',
'        ||apex_javascript.add_value(apex_plugin.get_ajax_identifier, true)',
'        ||apex_javascript.add_value(l_colors, true)',
'        ||apex_javascript.add_value(l_colors_fg, true)',
'        ||apex_javascript.add_value(l_adv_conf, true)',
'        ||apex_javascript.add_value(l_formatted_min_ar, true)',
'        ||apex_javascript.add_value(l_formatted_min_ar, true)',
'        ||apex_javascript.add_value(c_min_height, true)',
'        ||apex_javascript.add_value(c_max_height, true)',
'        ||apex_javascript.add_value(apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit))',
'        ||apex_javascript.add_value(c_show_tooltip, true) ',
'        ||apex_javascript.add_value(c_series_tooltip, true) ',
'        ||apex_javascript.add_value(c_custom_tooltip, true)',
'        ||apex_javascript.add_value(c_value_tooltip, true)',
'        ||apex_javascript.add_value(c_show_legend, true)',
'        ||apex_javascript.add_value(l_sorting, true) ',
'        ||apex_javascript.add_value(c_legend_position, false)',
'        ||'');''',
'    );',
'    return null;',
'end ora_d3_bubble_render;'))
,p_render_function=>'ora_d3_bubble_render'
,p_ajax_function=>'ora_d3_bubble_ajax'
,p_standard_attributes=>'SOURCE_SQL:SOURCE_REQUIRED:AJAX_ITEMS_TO_SUBMIT:FETCHED_ROWS:ESCAPE_OUTPUT'
,p_sql_min_column_count=>4
,p_sql_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<pre>',
'select',
'  empno as id,         --required',
'  ename as label,      --required',
'  job   as colorgrp,    --required',
'  sal   as bbsize,     --required',
'  null  as LINK,       --optional',
'  dname as description --optional',
'from emp e',
',    dept d',
'where e.deptno = d.deptno',
'</pre>'))
,p_substitute_attributes=>false
,p_reference_id=>2139281663031011956
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>',
'	This plugin provides a&nbsp;<em>Bubble Chart</em> based on the <a href="http://www.d3js.org" target="_blank">D3js</a> framework. Bubble charts allow you to visualize values by bubble sizes and colors and provide a good overview on data distribution.'
||' This plugin is based on the <a href="http://bl.ocks.org/mbostock/4063269" target="_blank">bubble chart example</a> by the D3js author Mike Bostock.</p>',
'<p>',
'	Plugin features:</p>',
'<ul>',
'	<li>',
'		Generate a Bubble Chart based on the SQL query in the Region source',
'		<ul>',
'			<li>',
'				Plugin honors the&nbsp;<em>Page Items to Submit&nbsp;</em>attribute</li>',
'			<li>',
'				Plugin honors the&nbsp;<em>Escape Special Characters&nbsp;</em>attribute (this applies to the &quot;Infobox&quot; which is displayed on Mouseover)<br />',
'				&nbsp;</li>',
'		</ul>',
'	</li>',
'	<li>',
'		The Plugin is AJAX aware',
'		<ul>',
'			<li>',
'				Honors the&nbsp;<em>apexrefresh</em> event - you can refresh the chart with a Dynamic Action</li>',
'			<li>',
'				The Plugin provides an&nbsp;<em>Auto Refresh&nbsp;</em>mode</li>',
'			<li>',
'				Plugin posts events to the APEX Dynamic Action Framework. So you can create dynamic Actions (e.g. to refresh other APEX components) based on the following plugin events.',
'				<ul>',
'					<li>',
'						Bubble Mouseover</li>',
'					<li>',
'						Bubble Mouseout</li>',
'					<li>',
'						Bubble Mouse Click</li>',
'					<li>',
'						Bubble Chart initialized<br />',
'						&nbsp;</li>',
'				</ul>',
'			</li>',
'		</ul>',
'	</li>',
'	<li>',
'		CSS and responsive Features',
'		<ul>',
'			<li>',
'				The plugin is responsive and changes its size according to the device&#39;s display size</li>',
'			<li>',
'				All components (Bubbles, Infoboxes, highlighted bubbles) can be augmented with own CSS classes</li>',
'		</ul>',
'	</li>',
'</ul>'))
,p_version_identifier=>'5.0.2'
,p_about_url=>'http://apex.oracle.com/plugins'
,p_files_version=>163
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19005117875745173)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>510
,p_prompt=>'Minimum Aspect Ratio'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'1.333'
,p_display_length=>5
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the minimum aspect ratio that charts use to recommend a height. A minimum aspect ratio of 1.333 means that the chart''s width should be no less than 1.333 times its height. </p>',
'<p>Note: This setting can be overridden by the ''Min Height'' setting on the region.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19005571340745174)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>520
,p_prompt=>'Maximum Aspect Ratio'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'3'
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the maximum aspect ratio that charts use to recommend a height. A maximum aspect ratio of 3 means that the chart''s width should be no greater than 3 times its height. </p>',
'<p>Note: This setting can be overridden by the ''Maximum Height'' setting on the region.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19005917571745174)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>100
,p_prompt=>'Color Scheme'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'MODERN'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Theme Default'
,p_help_text=>'<p>Select the color scheme used to render the chart.</p>'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19006375975745174)
,p_plugin_attribute_id=>wwv_flow_api.id(19005917571745174)
,p_display_sequence=>10
,p_display_value=>'Modern'
,p_return_value=>'MODERN'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19006812858745174)
,p_plugin_attribute_id=>wwv_flow_api.id(19005917571745174)
,p_display_sequence=>20
,p_display_value=>'Modern 2'
,p_return_value=>'MODERN2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19007319961745175)
,p_plugin_attribute_id=>wwv_flow_api.id(19005917571745174)
,p_display_sequence=>30
,p_display_value=>'Solar'
,p_return_value=>'SOLAR'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19007889461745175)
,p_plugin_attribute_id=>wwv_flow_api.id(19005917571745174)
,p_display_sequence=>40
,p_display_value=>'Metro'
,p_return_value=>'METRO'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19008360817745176)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>10
,p_prompt=>'Label Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the labels for the bubbles.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19008706944745176)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>20
,p_prompt=>'Value Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the values for the bubles.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19009190696745176)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>40
,p_prompt=>'Primary Key Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the primary key column.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19009516154745176)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>50
,p_prompt=>'Color Group Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the color group for the bubble.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19009918512745177)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>30
,p_prompt=>'Link Target'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Example 1: URL to navigate to page 10 and set P10_EMPNO to the EMPNO value of the clicked entry.',
'<pre>f?p=&amp;APP_ID.:10:&amp;APP_SESSION.::&amp;DEBUG.:RP,10:P10_EMPNO:&amp;EMPNO.</pre>',
'</p>',
'<p>Example 2: Display the EMPNO value of the clicked entry in a JavaScript alert',
'<pre>javascript:alert(''current empno: &amp;EMPNO.'');</pre>',
'</p>'))
,p_help_text=>'<p>Enter a target page to be called when the user clicks a chart entry.</p>'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19010390504745177)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>60
,p_prompt=>'Tooltips'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Check which attributes are shown on the tooltip for each data point. The ''Custom column'' option allows you to specify text for each individual data point as an additional column in the region SQL Query.</p>',
'<p>Note: Leave all options unchecked to disable the tooltip.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19010785565745177)
,p_plugin_attribute_id=>wwv_flow_api.id(19010390504745177)
,p_display_sequence=>10
,p_display_value=>'Show series name'
,p_return_value=>'SERIES'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19011298012745177)
,p_plugin_attribute_id=>wwv_flow_api.id(19010390504745177)
,p_display_sequence=>20
,p_display_value=>'Custom column'
,p_return_value=>'CUSTOM'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19011711887745177)
,p_plugin_attribute_id=>wwv_flow_api.id(19010390504745177)
,p_display_sequence=>30
,p_display_value=>'Show Value'
,p_return_value=>'VALUE'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19012280335745178)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>70
,p_prompt=>'Tooltip Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(19010390504745177)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'SERIES:CUSTOM:VALUE,SERIES:CUSTOM,CUSTOM:VALUE,CUSTOM'
,p_help_text=>'Enter the column from the region SQL Query that holds the custom tooltip values.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19012688293745178)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>110
,p_prompt=>'Minimum Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'Enter the minimum height, in pixels, of the chart. Chart width will adapt to the size of the region.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19013008043745178)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>120
,p_prompt=>'Maximum Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'The maximum height, in pixels, of the chart. Chart width will adapt to the size of the region.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19013405923745178)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>23
,p_display_sequence=>80
,p_prompt=>'Legend'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'No Legend'
,p_help_text=>'Select where the legend is displayed on the chart.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19013838669745179)
,p_plugin_attribute_id=>wwv_flow_api.id(19013405923745178)
,p_display_sequence=>10
,p_display_value=>'Above Chart'
,p_return_value=>'TOP'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19014315234745179)
,p_plugin_attribute_id=>wwv_flow_api.id(19013405923745178)
,p_display_sequence=>20
,p_display_value=>'Below Chart'
,p_return_value=>'BOTTOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19014852778745179)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>130
,p_prompt=>'Configuration JSON'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>true
,p_default_value=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'{',
'  "trdur":                       500,',
'  "bubble_padding":              1.5,',
'  "opacity_normal":              "0.8",',
'  "opacity_highlight":           "1.0",',
'  "circle_highlight_radiusplus": 5 ',
'}'))
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'This JSON contains some custom attributes for the chart plugin:',
'- "trdur": Is the transition duration of the effects of the chart in milliseconds. ',
'- "bubble_padding": Spacing between bubbles.',
'- "opacity_normal": The regular opacity of the nodes.',
'- "opacity_highlight": The opacity when the node is hovered.',
'- "circle_highlight_radiusplus": Plus factor to increase the bubble on highlight.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19015224602745180)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>25
,p_display_sequence=>90
,p_prompt=>'Bubble Sorting'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'D3ASCENDING'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select how the bubbles are arranged on the chart.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19015694486745180)
,p_plugin_attribute_id=>wwv_flow_api.id(19015224602745180)
,p_display_sequence=>10
,p_display_value=>'D3 Ascending'
,p_return_value=>'D3ASCENDING'
,p_help_text=>'D3 Ascending sorting function.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19016155257745181)
,p_plugin_attribute_id=>wwv_flow_api.id(19015224602745180)
,p_display_sequence=>20
,p_display_value=>'D3 Descending'
,p_return_value=>'D3DESCENDING'
,p_help_text=>'D3 Descending sorting function.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19016641984745181)
,p_plugin_attribute_id=>wwv_flow_api.id(19015224602745180)
,p_display_sequence=>30
,p_display_value=>'Ascending'
,p_return_value=>'ASCENDING'
,p_help_text=>'Sorts bubble from the smallest size on the outside to the biggest in the center.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19017105175745181)
,p_plugin_attribute_id=>wwv_flow_api.id(19015224602745180)
,p_display_sequence=>40
,p_display_value=>'Descending'
,p_return_value=>'DESCENDING'
,p_help_text=>'Sorts bubbles from the biggest size on the outside to the smallest in the center.'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(19018476039745183)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_name=>'com_oracle_apex_d3_click'
,p_display_name=>'D3Chart_MouseClick'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(19018860911745183)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_name=>'com_oracle_apex_d3_initialized'
,p_display_name=>'D3Chart_Initialized'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(19019248096745183)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_name=>'com_oracle_apex_d3_mouseout'
,p_display_name=>'D3Chart_MouseOut'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(19019633852745183)
,p_plugin_id=>wwv_flow_api.id(19004873475745172)
,p_name=>'com_oracle_apex_d3_mouseover'
,p_display_name=>'D3Chart_MouseOver'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_raphael_justgage
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(19020579653745185)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.RAPHAEL.JUSTGAGE'
,p_display_name=>'JustGage Gauge'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.RAPHAEL.JUSTGAGE'),'#IMAGE_PREFIX#plugins/com.oracle.apex.raphael.justgage/1.0/')
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#plugin.js',
'#PLUGIN_FILES#justgage.js',
'#IMAGE_PREFIX#libraries/raphaeljs/2.1.2/apex.raphael.min.js'))
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render ',
'(',
'    p_region                in  apex_plugin.t_region,',
'    p_plugin                in  apex_plugin.t_plugin,',
'    p_is_printer_friendly   in  boolean ',
')',
'return apex_plugin.t_region_render_result',
'is',
'    -- Assign readable names to plugin attributes. Omit data attributes, they''ll be handled in ajax function.',
'    -- Label configuration',
'    c_show_labels           constant boolean        := p_region.attribute_04 = ''Y'';',
'    l_title                 varchar(200)            := nvl(p_region.attribute_05, '''');',
'    l_units                 varchar(200)            := nvl(p_region.attribute_06, '''');',
'    l_value_prefix          varchar(200)            := nvl(p_region.attribute_07, '''');',
'    l_value_suffix          varchar(200)            := nvl(p_region.attribute_08, '''');',
'    l_show_min_max          boolean                 := nvl(p_region.attribute_09, ''N'') = ''Y'';',
'    c_description_template  constant varchar(2000)  := apex_plugin_util.replace_substitutions(',
'                                                           nvl(p_region.attribute_20, ''''));',
'    l_heading               varchar(200)            := apex_plugin_util.replace_substitutions(',
'                                                           nvl(p_region.attribute_21, ''''));',
'',
'    -- Shadow configuration',
'    c_show_shadow           constant boolean        := nvl(p_region.attribute_10, ''N'') = ''Y'';',
'    c_shadow_opacity        constant number         := nvl( apex_plugin_util.get_attribute_as_number( p_region.attribute_11, ''Shadow Opacity'' ), 0 );',
'    c_shadow_offset         constant number         := to_number(nvl(p_region.attribute_12, 0));',
'',
'    -- Gauge configuration',
'    c_gauge_width           constant number         := nvl( apex_plugin_util.get_attribute_as_number( p_region.attribute_13, ''Gauge Width Scale'' ), 1 );',
'    c_gauge_color_scheme    constant varchar(200)   := p_region.attribute_14;',
'    l_gauge_colors          varchar(200)            := p_region.attribute_15;',
'    l_gauge_bg_color        varchar(200)            := p_region.attribute_16;',
'    c_gauge_mode            constant varchar(200)   := p_region.attribute_17;',
'    c_width                 constant number         := p_region.attribute_18;',
'    c_height                constant number         := p_region.attribute_19;',
'    c_decimals              constant number         := greatest(nvl(p_region.attribute_24, 0), 0);',
'    l_width_style           varchar(200)            := '''';',
'    l_height_style          varchar(200)            := '''';',
'',
'    -- Function constants',
'    c_rgb_single_regex      constant varchar2(200)  := ''^#[0-9a-fA-F]{6}$'';',
'    c_rgb_list_regex        constant varchar2(200)  := ''^#[0-9a-fA-F]{6}(,#[0-9a-fA-F]{6})*$'';',
'begin',
'    -- Size style settings',
'    if c_width is not null then ',
'        l_width_style := ''width:'' || c_width || ''px;'';',
'    end if;',
'    if c_height is not null then ',
'        l_height_style := ''height:'' || c_height || ''px;'';',
'    end if;',
'',
'    -- Add placeholder div',
'    sys.htp.p (',
'        ''<div class="a-BadgeChart a-BadgeChart--justGage" id="'' || p_region.static_id || ''_container">'' ||',
'            ''<div class="a-JustGage-desc"></div>'' ||',
'            ''<div id="'' || p_region.static_id || ''_gauge" class="a-JustGage-chart" style="'' || l_width_style || l_height_style || ''"></div>'' ||',
'            ''<div class="a-BadgeChart-text">'' ||',
'                ''<span class="a-BadgeChart-label"></span>'' ||',
'                ''<span class="a-BadgeChart-desc"></span>'' ||',
'            ''</div>'' ||',
'        ''</div>'');',
'',
'    -- Labels defaults',
'    if not c_show_labels then',
'        l_title := '''';',
'        l_units := '''';',
'        l_value_prefix := '''';',
'        l_value_suffix := '''';',
'        l_show_min_max := false;',
'    end if;',
'',
'    -- Donut mode has no min/max value labels',
'    l_show_min_max := l_show_min_max and c_gauge_mode <> ''donut'';',
'',
'    -- Validate shadow configuration',
'    if c_show_shadow then',
'        if c_shadow_opacity < 0 or c_shadow_opacity > 1 then',
'            -- invalid option',
'            null;',
'        end if; ',
'    end if;',
'',
'    -- Validate gauge configuration',
'    if c_gauge_width <= 0 then',
'        -- invalid option',
'        null;',
'    end if;',
'    case c_gauge_color_scheme',
'        when ''GTR'' then',
'            l_gauge_colors := ''#56bd0d,#f0dc05,#f52900'';',
'        when ''RTG'' then',
'            l_gauge_colors := ''#f52900,#f0dc05,#56bd0d'';',
'        else',
'            l_gauge_colors := replace(l_gauge_colors, '' '', '''');',
'            if not regexp_like(l_gauge_colors, c_rgb_list_regex) then',
'                -- invalid option',
'                null;',
'            end if;',
'    end case;',
'    l_gauge_bg_color := replace(l_gauge_bg_color, '' '', '''');',
'    if not regexp_like(l_gauge_bg_color, c_rgb_single_regex) then',
'        -- invalid option',
'        null;',
'    end if;',
'',
'    -- Build the initial chart. Data will be loaded with ajax.',
'    apex_javascript.add_onload_code (',
'        p_code => ''com_oracle_apex_raphael_justgage('' ||',
'            apex_javascript.add_value(p_region.static_id) ||',
'            ''{'' ||',
'                apex_javascript.add_attribute(''regionId'',       p_region.static_id || ''_gauge'') || ',
'                apex_javascript.add_attribute(''title'',          l_title) || ',
'                apex_javascript.add_attribute(''units'',          l_units) || ',
'                apex_javascript.add_attribute(''valuePrefix'',    l_value_prefix) || ',
'                apex_javascript.add_attribute(''valueSuffix'',    l_value_suffix) || ',
'                apex_javascript.add_attribute(''roundTo'',        c_decimals) || ',
'                apex_javascript.add_attribute(''showMinMax'',     l_show_min_max) || ',
'                apex_javascript.add_attribute(''showShadow'',     c_show_shadow) || ',
'                apex_javascript.add_attribute(''shadowOpacity'',  c_shadow_opacity) || ',
'                apex_javascript.add_attribute(''shadowOffset'',   c_shadow_offset) || ',
'                apex_javascript.add_attribute(''gaugeWidth'',     c_gauge_width) || ',
'                apex_javascript.add_attribute(''gaugeColors'',    l_gauge_colors) || ',
'                apex_javascript.add_attribute(''gaugeBgColor'',   l_gauge_bg_color) || ',
'                apex_javascript.add_attribute(''gaugeMode'',      c_gauge_mode) || ',
'                apex_javascript.add_attribute(''heading'',        l_heading) || ',
'                apex_javascript.add_attribute(''description'',    c_description_template) || ',
'                apex_javascript.add_attribute(''pageItems'',      apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit)) ||',
'                apex_javascript.add_attribute(''ajaxIdentifier'', apex_plugin.get_ajax_identifier, false, false) ||',
'            ''});'' );',
'    return null;',
'end;',
'',
'',
'function ajax ',
'(',
'    p_region    in  apex_plugin.t_region,',
'    p_plugin    in  apex_plugin.t_plugin ',
')',
'return apex_plugin.t_region_ajax_result',
'is',
'    -- It''s better to have named variables instead of using the generic ones, ',
'    -- makes the code more readable. ',
'    c_value_column          constant varchar2(255) := p_region.attribute_01;',
'    c_min_column            constant varchar2(255) := p_region.attribute_02;',
'    c_max_column            constant varchar2(255) := p_region.attribute_03;',
'    c_heading_link          constant varchar2(4000) := p_region.attribute_22;',
'    c_description_link      constant varchar2(4000) := p_region.attribute_23;',
'',
'    l_value_column_no       pls_integer;',
'    l_min_column_no         pls_integer;',
'    l_max_column_no         pls_integer;',
'    l_column_value_list     apex_plugin_util.t_column_value_list2;',
'',
'    l_value                 number;',
'    l_min                   number;',
'    l_max                   number;',
'    l_heading_link          varchar2(4000);',
'    l_description_link      varchar2(4000);',
'begin',
'    apex_plugin_util.print_json_http_header;',
'',
'    l_column_value_list := apex_plugin_util.get_data2 (',
'        p_sql_statement     => p_region.source,',
'        p_min_columns       => 1,',
'        p_max_columns       => 3,',
'        p_component_name    => p_region.name );',
'',
'    -- Get the actual column # for faster access and also verify that the data type',
'    -- of the column matches with what we are looking for',
'    l_value_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''value column'',',
'        p_column_alias          => c_value_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => true,',
'        p_data_type             => apex_plugin_util.c_data_type_number );',
'',
'    l_min_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''min value column'',',
'        p_column_alias          => c_min_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => false,',
'        p_data_type             => apex_plugin_util.c_data_type_number );',
'',
'    l_max_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''min value column'',',
'        p_column_alias          => c_max_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => false,',
'        p_data_type             => apex_plugin_util.c_data_type_number );',
'',
'    -- Fetch the data',
'    if l_column_value_list(1).value_list.count = 1 then',
'        apex_plugin_util.set_component_values (',
'            p_column_value_list => l_column_value_list,',
'            p_row_num => 1 ',
'        );',
'    ',
'        l_heading_link := case',
'            when c_heading_link is not null then',
'                apex_util.prepare_url (',
'                    apex_plugin_util.replace_substitutions (',
'                        p_value  => c_heading_link,',
'                        p_escape => false',
'                    )',
'                )',
'        end;',
'        ',
'        l_description_link := case',
'            when c_description_link is not null then',
'                apex_util.prepare_url (',
'                    apex_plugin_util.replace_substitutions (',
'                        p_value  => c_description_link,',
'                        p_escape => false',
'                    )',
'                )',
'        end;',
'        ',
'        l_value := l_column_value_list(l_value_column_no).value_list(1).number_value;',
'        if l_min_column_no is not null then',
'            l_min := l_column_value_list(l_min_column_no).value_list(1).number_value;',
'        end if;',
'        if l_max_column_no is not null then',
'            l_max := l_column_value_list(l_max_column_no).value_list(1).number_value;',
'        end if;',
'        ',
'        apex_plugin_util.clear_component_values;',
'    else',
'        --invalid number of rows',
'        null;',
'    end if;',
'',
'    -- Default value to 0.',
'    l_value := nvl(l_value, 0);',
'',
'    -- Default min value to 0.',
'    l_min := nvl(l_min, 0);',
'',
'    -- Default max value to the smallest power of 10 equal to or greater than the value, starting with 100.',
'    if l_max is null then',
'        l_max := 100;',
'        loop',
'            exit when l_max >= l_value;',
'            l_max := l_max * 10;',
'        end loop;',
'    end if;',
'',
'    -- Print the actual, max and min values',
'    sys.htp.prn (',
'        ''[{'' ||',
'            apex_javascript.add_attribute(''headingLink'',  l_heading_link) ||',
'            apex_javascript.add_attribute(''descriptionLink'',  l_description_link) ||',
'            apex_javascript.add_attribute(''value'',  l_value) ||',
'            apex_javascript.add_attribute(''min'',    l_min) ||',
'            apex_javascript.add_attribute(''max'',    l_max, false, false) ||',
'        ''}]'' );',
'',
'    return null;',
'end;'))
,p_render_function=>'render'
,p_ajax_function=>'ajax'
,p_standard_attributes=>'SOURCE_SQL:SOURCE_REQUIRED:AJAX_ITEMS_TO_SUBMIT'
,p_sql_min_column_count=>1
,p_sql_max_column_count=>3
,p_substitute_attributes=>false
,p_reference_id=>2128944285843706671
,p_subscribe_plugin_settings=>true
,p_help_text=>'The JustGage plug-in is a simple JavaScript plug-in for displaying gauges.'
,p_version_identifier=>'5.0.1'
,p_about_url=>'http://apex.oracle.com/plugins'
,p_files_version=>7
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19020850999745186)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Value Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the value for the guage.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19021210316745187)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Min Value Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Select the column from the region SQL Query that holds the  minimum value represented by the gauge. When the value is equal or lesser than the minimum, the gauge will be shown as completely empty.</p>',
'<p>Note: If left empty, the minimum value defaults to 0.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19021626593745187)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Max Value Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Select the column from the region SQL Query that holds the  maximum value represented by the gauge. When the value is equal or greater than the maximum, the gauge will be shown as completely full.</p>',
'<p>Note: If left blank, the maximum value defaults to the lesser power of 10 greater than the value.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19022043425745187)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>50
,p_prompt=>'Show Labels'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Select whether labels are displayed.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19022463483745187)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>60
,p_prompt=>'Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>20
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(19022043425745187)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Enter the text for the label above the gauge.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19022856930745187)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>70
,p_prompt=>'Units'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>20
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(19022043425745187)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Enter the text for the label immediately below the gauge value.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19023296735745188)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>80
,p_prompt=>'Value Prefix'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>2
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(19022043425745187)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Enter the text that prefixes the value label.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19023643835745188)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>90
,p_prompt=>'Value Suffix'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>2
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(19022043425745187)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Enter the text that is appended to the value label.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19024052354745188)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>100
,p_prompt=>'Show Min and Max Values'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(19029794257745191)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'GAUGE'
,p_lov_type=>'STATIC'
,p_help_text=>'Select whether the actual minimum and maximum values are displayed on the gauge.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19024406783745188)
,p_plugin_attribute_id=>wwv_flow_api.id(19024052354745188)
,p_display_sequence=>10
,p_display_value=>' '
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19024985594745188)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>220
,p_prompt=>'Show Shadow'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select whether to render a shadow gradient on the gauge.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19025386885745189)
,p_plugin_attribute_id=>wwv_flow_api.id(19024985594745188)
,p_display_sequence=>10
,p_display_value=>' '
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19025840130745189)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>230
,p_prompt=>'Shadow Opacity'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'0.5'
,p_display_length=>5
,p_max_length=>5
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(19024985594745188)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Enter the opacity of the shadow, measured between 0 and 1.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19026230418745189)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>240
,p_prompt=>'Shadow Offset'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_default_value=>'0'
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(19024985594745188)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Enter the vertical offset of the shadow, in pixels.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19026622632745189)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>160
,p_prompt=>'Gauge Width Scale'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'1'
,p_display_length=>5
,p_max_length=>5
,p_is_translatable=>false
,p_help_text=>'Enter the scale of the gauge''s width.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19027069383745190)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>190
,p_prompt=>'Color Scheme'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'GTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select the color scheme for the gauge.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19027450106745190)
,p_plugin_attribute_id=>wwv_flow_api.id(19027069383745190)
,p_display_sequence=>10
,p_display_value=>'Dynamic Green-to-Red'
,p_return_value=>'GTR'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19027985062745190)
,p_plugin_attribute_id=>wwv_flow_api.id(19027069383745190)
,p_display_sequence=>20
,p_display_value=>'Dynamic Red-to-Green'
,p_return_value=>'RTG'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19028420342745190)
,p_plugin_attribute_id=>wwv_flow_api.id(19027069383745190)
,p_display_sequence=>30
,p_display_value=>'Custom Color(s)'
,p_return_value=>'CUSTOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19028986685745190)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>200
,p_prompt=>'Gauge Color(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'#144485'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(19027069383745190)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'CUSTOM'
,p_help_text=>'Enter a comma-separated list of RGB colors to be used on the gauge. The first color will be used when the value is near the minimum and the last color will be used when the value is near the maximum. Enter only one color for a solid fill.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19029319836745191)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>210
,p_prompt=>'Empty Color'
,p_attribute_type=>'COLOR'
,p_is_required=>true
,p_default_value=>'#d9d9d9'
,p_is_translatable=>false
,p_help_text=>'Enter the color to be used on the ''empty'' sector of the gauge.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19029794257745191)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>40
,p_prompt=>'Gauge Mode'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'GAUGE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select whether to render the gauge as a half circle or as a full circle.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19030173510745191)
,p_plugin_attribute_id=>wwv_flow_api.id(19029794257745191)
,p_display_sequence=>10
,p_display_value=>'Normal'
,p_return_value=>'GAUGE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19030692470745191)
,p_plugin_attribute_id=>wwv_flow_api.id(19029794257745191)
,p_display_sequence=>20
,p_display_value=>'Donut'
,p_return_value=>'DONUT'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19031187307745192)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>170
,p_prompt=>'Width'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the fixed width of the gauge, in pixels.</p>',
'<p>Note: Leave this attribute blank for automatic/responsive.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19031516575745192)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>180
,p_prompt=>'Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the fixed height of the gauge, in pixels.</p>',
'<p>Note: Leave blank for automatic/responsive.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19031949530745192)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>110
,p_prompt=>'Description'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>true
,p_examples=>'The actual value is :VALUE: (out of :MAX:)'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Enter the description to be shown under the Gauge. You may use the following text replacements:',
'<ul>',
'<li>:MIN:</li>',
'<li>:MAX:</li>',
'<li>:VALUE:</li>',
'</ul>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19032309001745192)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>130
,p_prompt=>'Heading'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>20
,p_max_length=>200
,p_is_translatable=>true
,p_help_text=>'Enter the heading displayed directly above the description. This is commonly set to the label for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19032766879745192)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>140
,p_prompt=>'Heading Link Target'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_is_translatable=>false
,p_reference_scope=>'ROW'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Example 1: URL to navigate to page 10 and set P10_EMPNO to the EMPNO value of the clicked entry.',
'<pre>f?p=&amp;APP_ID.:10:&amp;APP_SESSION.::&amp;DEBUG.:RP,10:P10_EMPNO:&amp;EMPNO.</pre>',
'</p>',
'<p>Example 2: Display the EMPNO value of the clicked entry in a JavaScript alert',
'<pre>javascript:alert(''current empno: &amp;EMPNO.'');</pre>',
'</p>'))
,p_help_text=>'<p>Enter a target page to be called when the user clicks the heading.</p>'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19033164589745193)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>23
,p_display_sequence=>120
,p_prompt=>'Description Link Target'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_is_translatable=>false
,p_reference_scope=>'ROW'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Example 1: URL to navigate to page 10 and set P10_EMPNO to the EMPNO value of the clicked entry.',
'<pre>f?p=&amp;APP_ID.:10:&amp;APP_SESSION.::&amp;DEBUG.:RP,10:P10_EMPNO:&amp;EMPNO.</pre>',
'</p>',
'<p>Example 2: Display the EMPNO value of the clicked entry in a JavaScript alert',
'<pre>javascript:alert(''current empno: &amp;EMPNO.'');</pre>',
'</p>'))
,p_help_text=>'<p>Enter a target page to be called when the user clicks the description.</p>'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19033518970745193)
,p_plugin_id=>wwv_flow_api.id(19020579653745185)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>150
,p_prompt=>'Decimal Places'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_display_length=>5
,p_is_translatable=>false
,p_help_text=>'Enter the number of decimal places to display. The default value is "0".'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_slidetooltip
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(19036360372745196)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM_ORACLE_APEX_SLIDETOOLTIP'
,p_display_name=>'Slide Tooltip'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM_ORACLE_APEX_SLIDETOOLTIP'),'#IMAGE_PREFIX#plugins/com.oracle.apex.slidetooltip/')
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#PLUGIN_FILES#slideTooltipList.js',
'#PLUGIN_FILES#com_oracle_apex_slide_tooltip.js',
''))
,p_css_file_urls=>'#PLUGIN_FILES#a-DetailedContentList.css'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render_slide_tooltip (',
'    p_region              in apex_plugin.t_region,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_is_printer_friendly in boolean )',
'    return apex_plugin.t_region_render_result',
'is',
'    c_slide_tooltip constant varchar2(255) := p_region.attribute_04;',
'begin',
'    if apex_application.g_debug then',
'        apex_plugin_util.debug_region (',
'            p_plugin => p_plugin,',
'            p_region => p_region );',
'    end if;',
'',
'    sys.htp.p( ''<div'' || apex_plugin_util.get_html_attr( ''id'', p_region.static_id || ''_slideTooltip'' ) || ''></div>'' );',
'',
'    apex_javascript.add_onload_code (',
'        p_code =>',
'            ''com_oracle_apex_slide_tooltip('' ||',
'            apex_javascript.add_value( p_region.static_id ) ||',
'            ''{'' ||',
'            apex_javascript.add_attribute( ''pageitems'',       apex_plugin_util.page_item_names_to_jquery( p_region.ajax_items_to_submit )) ||',
'            apex_javascript.add_attribute( ''slideTooltipOpt'', c_slide_tooltip ) ||',
'            apex_javascript.add_attribute( ''ajaxIdentifier'',  apex_plugin.get_ajax_identifier, false, false ) ||',
'            ''});'' );',
'',
'    return null;',
'end render_slide_tooltip;',
'',
'function ajax_slide_tooltip (',
'    p_region in apex_plugin.t_region,',
'    p_plugin in apex_plugin.t_plugin )',
'    return apex_plugin.t_region_ajax_result',
'is',
'    c_item_icon  constant varchar2(255) := p_region.attribute_01;',
'    c_item_title constant varchar2(255) := p_region.attribute_02;',
'    c_item_badge constant varchar2(255) := p_region.attribute_03;',
'    c_label_link constant varchar2(255) := p_region.attribute_05;',
'',
'    l_column_value_list apex_plugin_util.t_column_value_list2;',
'    l_link    varchar2(4000);',
'    l_icon    varchar2(4000);',
'    l_title   varchar2(4000);',
'    l_badge   varchar2(4000);',
'    l_content varchar2(4000);',
'begin',
'    if apex_application.g_debug then',
'        apex_plugin_util.debug_region (',
'            p_plugin => p_plugin,',
'            p_region => p_region',
'        );',
'    end if;',
'',
'    l_column_value_list := apex_plugin_util.get_data2(',
'                               p_sql_statement => p_region.source,',
'                               p_region        => p_region );',
'',
'    apex_json.initialize_output( p_http_cache => false );',
'    apex_json.open_array;',
'',
'    for l_row_number in 1 .. l_column_value_list( 1 ).value_list.count',
'    loop',
'        begin',
'            apex_plugin_util.set_component_values (',
'                p_column_value_list => l_column_value_list,',
'                p_row_num           => l_row_number );',
'',
'            l_link :=',
'                case when c_label_link is not null then',
'                    apex_util.prepare_url (',
'                        apex_plugin_util.replace_substitutions (',
'                            p_value  => c_label_link,',
'                            p_escape => false )',
'                        )',
'                end;',
'',
'            l_icon  := apex_escape.html( v( c_item_icon ));',
'            l_title := apex_escape.html( v( c_item_title ));',
'            l_badge := apex_escape.html( v( c_item_badge ));',
'',
'            apex_json.open_object;',
'            apex_json.  write( ''icon'',  l_icon );',
'            apex_json.  write( ''title'', l_title );',
'            apex_json.  write( ''badge'', l_badge );',
'            apex_json.  write( ''link'',  l_link );',
'            apex_json.  open_array( ''content'' );',
'',
'            for l_column_no in 1 .. p_region.region_columns.count',
'            loop',
'                if p_region.region_columns( l_column_no ).is_displayed then',
'                    if p_region.region_columns( l_column_no ).name not in ( c_item_icon, c_item_title, c_item_badge ) then',
'                        l_content := apex_escape.html( v( p_region.region_columns( l_column_no ).name ));',
'                        apex_json.open_object;',
'                        apex_json.  write( ''content'', l_content );',
'                        apex_json.  write( ''label'',   p_region.region_columns( l_column_no ).heading );',
'                        apex_json.close_object;',
'                    end if;',
'                end if;',
'            end loop;',
'',
'            apex_json.  close_array;',
'            apex_json.close_object;',
'            wwv_flow_plugin_util.clear_component_values;',
'        exception when others then',
'            wwv_flow_plugin_util.clear_component_values;',
'            raise;',
'        end;',
'    end loop;',
'    apex_json.close_array;',
'',
'    return null;',
'end ajax_slide_tooltip;'))
,p_render_function=>'render_slide_tooltip'
,p_ajax_function=>'ajax_slide_tooltip'
,p_standard_attributes=>'SOURCE_SQL:COLUMNS:COLUMN_HEADING'
,p_sql_min_column_count=>1
,p_substitute_attributes=>false
,p_reference_id=>2128965944192706696
,p_subscribe_plugin_settings=>true
,p_help_text=>'This region plug-in is useful for displaying a report with additional fields either inline or in an expanded tooltip.'
,p_version_identifier=>'5.0.1'
,p_files_version=>352
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19036625146745197)
,p_plugin_id=>wwv_flow_api.id(19036360372745196)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>2
,p_prompt=>'Icon Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the icon displayed before the title.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19037029456745197)
,p_plugin_id=>wwv_flow_api.id(19036360372745196)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>3
,p_prompt=>'Title Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2:NUMBER:DATE:TIMESTAMP:TIMESTAMP_TZ:TIMESTAMP_LTZ:INTERVAL_Y2M:INTERVAL_D2S:BLOB:CLOB:BFILE:ROWID'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the values displayed in the report.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19037461155745197)
,p_plugin_id=>wwv_flow_api.id(19036360372745196)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>5
,p_prompt=>'Badge Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2:NUMBER:DATE:TIMESTAMP:TIMESTAMP_TZ:TIMESTAMP_LTZ:INTERVAL_Y2M:INTERVAL_D2S:BLOB:CLOB:BFILE:ROWID'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the value displayed at the end of each row displayed.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19037876378745198)
,p_plugin_id=>wwv_flow_api.id(19036360372745196)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>1
,p_prompt=>'Mode'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'slide'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select how the report fields are displayed.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19038267440745198)
,p_plugin_attribute_id=>wwv_flow_api.id(19037876378745198)
,p_display_sequence=>10
,p_display_value=>'Slide'
,p_return_value=>'slide'
,p_help_text=>'A dropdown indicator is included at end of each record. Pressing this indicator displays the additional fields inline within the report, pushing additional records down.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19038757530745198)
,p_plugin_attribute_id=>wwv_flow_api.id(19037876378745198)
,p_display_sequence=>20
,p_display_value=>'Tooltip'
,p_return_value=>'tooltip'
,p_help_text=>'The additional fields are displayed as a tooltip next to the record. The tooltip is displayed when you hover over the record.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19039225267745198)
,p_plugin_id=>wwv_flow_api.id(19036360372745196)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>4
,p_prompt=>'Link Target'
,p_attribute_type=>'LINK'
,p_is_required=>true
,p_default_value=>'#&ENAME.'
,p_is_translatable=>false
,p_help_text=>'<p>Enter a target page to be called when the user clicks a record.</p>'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_d3_line
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(23582314266023261)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.D3.LINE'
,p_display_name=>'D3 Line Chart'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.D3.LINE'),'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.linechart/1.0/')
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/d3/3.5.5/d3.min.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/d3.oracle.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/oracle.jql.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.tooltip/d3.oracle.tooltip.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.ary/d3.oracle.ary.js',
'#PLUGIN_FILES#d3.oracle.linechart.js',
'#PLUGIN_FILES#com.oracle.apex.d3.linechart.js'))
,p_css_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.tooltip/d3.oracle.tooltip.css',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.ary/d3.oracle.ary.css',
'#PLUGIN_FILES#d3.oracle.linechart.css'))
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function render ',
'(',
'    p_region                in  apex_plugin.t_region,',
'    p_plugin                in  apex_plugin.t_plugin,',
'    p_is_printer_friendly   in  boolean ',
')',
'return apex_plugin.t_region_render_result',
'is',
'    -- Assign readable names to plugin attributes. Omit data attributes, they''ll be handled in ajax function.',
'    -- Dimensions',
'    c_height_mode           constant varchar2(200)  := p_region.attribute_09;',
'    c_min_height            constant number         := nvl(p_region.attribute_17, 100);',
'    c_max_height            constant number         := nvl(p_region.attribute_18, 500);',
'',
'    -- Axis titles',
'    c_x_axis_title          constant varchar2(200)  := p_region.attribute_03;',
'    c_y_axis_title          constant varchar2(200)  := p_region.attribute_04;',
'',
'    -- Axis grid',
'    c_x_axis_grid           constant boolean        := instr('':'' || p_region.attribute_21 || '':'', '':X:'') > 0;',
'    c_y_axis_grid           constant boolean        := instr('':'' || p_region.attribute_21 || '':'', '':Y:'') > 0;',
'',
'    -- Line interpolation',
'    c_line_interpolation    constant varchar2(200)  := p_region.attribute_08;',
'',
'    -- Tooltip configuration',
'    c_show_tooltip          constant boolean        := p_region.attribute_16 is not null;',
'    c_series_tooltip        constant boolean        := instr('':'' || p_region.attribute_16 || '':'', '':SERIES:'') > 0;',
'    c_x_tooltip             constant boolean        := instr('':'' || p_region.attribute_16 || '':'', '':X:'') > 0;',
'    c_y_tooltip             constant boolean        := instr('':'' || p_region.attribute_16 || '':'', '':Y:'') > 0;',
'    c_custom_tooltip        constant boolean        := instr('':'' || p_region.attribute_16 || '':'', '':CUSTOM:'') > 0;',
'',
'    -- Legend',
'    c_show_legend           constant boolean        := p_region.attribute_25 is not null;',
'    c_legend_position       constant varchar2(200)  := p_region.attribute_25;',
'',
'    -- Display modes',
'    c_x_data_type           constant varchar2(200)  := p_region.attribute_05;',
'    c_x_value_template      constant varchar2(200)  := nvl(p_region.attribute_06, p_region.attribute_07);',
'    c_y_value_template      constant varchar2(200)  := nvl(p_region.attribute_10, p_region.attribute_11);',
'    c_x_tick_interval       constant varchar2(200)  := nvl(p_region.attribute_12, ''auto'');',
'    c_responsive            constant boolean        := p_plugin.attribute_05 = ''Y'';',
'    c_transitions           constant boolean        := p_plugin.attribute_06 = ''Y'';',
'    c_display               constant varchar2(200)  := p_region.attribute_20;',
'',
'    -- Colors',
'    c_color_scheme          constant varchar2(200)  := p_region.attribute_13;',
'    l_colors                varchar2(200)           := p_region.attribute_14;',
'',
'    -- Aspect ratios',
'    c_min_ar                constant number         := nvl( apex_plugin_util.get_attribute_as_number(p_plugin.attribute_02, ''Min Aspect Ratio''), 1.333);',
'    c_max_ar                constant number         := nvl( apex_plugin_util.get_attribute_as_number(p_plugin.attribute_01, ''Max Aspect Ratio''), 3);',
'    c_threshold             constant number         := p_plugin.attribute_03;',
'    c_threshold_of          constant varchar2(200)  := p_plugin.attribute_04;',
'begin',
'    -- Add placeholder div',
'    sys.htp.p (',
'        ''<div class="a-D3LineChart" id="'' || p_region.static_id || ''_region">'' ||',
'            ''<div class="a-D3LineChart-container" id="'' || p_region.static_id || ''_chart"></div>'' ||',
'        ''</div>'' );',
'',
'    -- Color scheme',
'    case c_color_scheme',
'        when ''MODERN'' then',
'            l_colors := ''#FF3B30:#FF9500:#FFCC00:#4CD964:#34AADC:#007AFF:#5856D6:#FF2D55:#8E8E93:#C7C7CC'';',
'        when ''MODERN2'' then',
'            l_colors := ''#1ABC9C:#2ECC71:#4AA3DF:#9B59B6:#3D566E:#F1C40F:#E67E22:#E74C3C'';',
'        when ''SOLAR'' then',
'            l_colors := ''#B58900:#CB4B16:#DC322F:#D33682:#6C71C4:#268BD2:#2AA198:#859900'';',
'        when ''METRO'' then',
'            l_colors := ''#E61400:#19A2DE:#319A31:#EF9608:#8CBE29:#A500FF:#00AAAD:#FF0094:#9C5100:#E671B5'';',
'        else',
'            null;',
'    end case;    ',
'',
'    -- Build the initial chart. Data will be loaded with ajax.',
'    apex_javascript.add_onload_code (',
'        p_code => ''com_oracle_apex_d3_linechart('' ||',
'            apex_javascript.add_value(p_region.static_id) ||',
'            ''{'' ||',
'                apex_javascript.add_attribute(''chartRegionId'',  p_region.static_id || ''_chart'') ||',
'                apex_javascript.add_attribute(''xAxisTitle'',     c_x_axis_title) || ',
'                apex_javascript.add_attribute(''yAxisTitle'',     c_y_axis_title) || ',
'                apex_javascript.add_attribute(''showTooltip'',    c_show_tooltip) || ',
'                apex_javascript.add_attribute(''tooltipSeries'',  c_series_tooltip) || ',
'                apex_javascript.add_attribute(''tooltipX'',       c_x_tooltip) || ',
'                apex_javascript.add_attribute(''tooltipY'',       c_y_tooltip) || ',
'                apex_javascript.add_attribute(''tooltipCustom'',  c_custom_tooltip) ||',
'                apex_javascript.add_attribute(''responsive'',     c_responsive) || ',
'                apex_javascript.add_attribute(''transitions'',    c_transitions) || ',
'                apex_javascript.add_attribute(''xDataType'',      c_x_data_type) || ',
'                apex_javascript.add_attribute(''display'',        c_display) || ',
'                apex_javascript.add_attribute(''xValueTemplate'', c_x_value_template) || ',
'                apex_javascript.add_attribute(''yValueTemplate'', c_y_value_template) || ',
'                apex_javascript.add_attribute(''xTickInterval'',  c_x_tick_interval) || ',
'                apex_javascript.add_attribute(''showLegend'',     c_show_legend) || ',
'                apex_javascript.add_attribute(''legendPosition'', c_legend_position) || ',
'                apex_javascript.add_attribute(''colors'',         l_colors) || ',
'                apex_javascript.add_attribute(''xGrid'',          c_x_axis_grid) || ',
'                apex_javascript.add_attribute(''yGrid'',          c_y_axis_grid) || ',
'                apex_javascript.add_attribute(''interpolation'',  c_line_interpolation) ||',
'                apex_javascript.add_attribute(''heightMode'',     c_height_mode) ||',
'                apex_javascript.add_attribute(''minHeight'',      c_min_height) || ',
'                apex_javascript.add_attribute(''maxHeight'',      c_max_height) || ',
'                apex_javascript.add_attribute(''threshold'',      c_threshold) || ',
'                apex_javascript.add_attribute(''thresholdOf'',    c_threshold_of) || ',
'                apex_javascript.add_attribute(''minAR'',          c_min_ar) ||',
'                apex_javascript.add_attribute(''maxAR'',          c_max_ar) ||',
'                apex_javascript.add_attribute(''noDataFoundMessage'', p_region.no_data_found_message) || ',
'                apex_javascript.add_attribute(''pageItems'',      apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit)) ||',
'                apex_javascript.add_attribute(''ajaxIdentifier'', apex_plugin.get_ajax_identifier, false, false) ||',
'            ''});'' );',
'    return null;',
'end;',
'',
'function ajax',
'(',
'    p_region    in  apex_plugin.t_region,',
'    p_plugin    in  apex_plugin.t_plugin ',
')',
'return apex_plugin.t_region_ajax_result',
'is',
'    -- It''s better to have named variables instead of using the generic ones, ',
'    -- makes the code more readable. ',
'',
'    -- Column names',
'    c_x_column              constant varchar2(255) := p_region.attribute_01;',
'    c_y_column              constant varchar2(255) := p_region.attribute_02;',
'    c_series_column         constant varchar2(255) := p_region.attribute_23;',
'    c_tooltip_column        constant varchar2(255) := p_region.attribute_15;',
'    c_link_template         constant varchar2(255) := p_region.attribute_19;',
'',
'    -- X Column data type',
'    c_x_data_type           constant varchar2(200)  := p_region.attribute_05;',
'',
'    -- Series name, for single series configuration',
'    c_series_name           constant varchar2(200) := p_region.attribute_24;',
'    c_use_sql_color         constant boolean       := p_region.attribute_13 = ''COLUMN'';',
'',
'    -- Column numbers for fetching',
'    l_x_column_no           pls_integer;',
'    l_y_column_no           pls_integer;',
'    l_series_column_no      pls_integer;',
'    l_tooltip_column_no     pls_integer;',
'    l_column_value_list     apex_plugin_util.t_column_value_list2;',
'',
'    -- Holders for row data',
'    l_x                     number;',
'    l_x_date                varchar2(200);',
'    l_y                     number;',
'    l_series                varchar2(4000);',
'    l_color                 varchar2(4000);',
'    l_tooltip               varchar2(4000);',
'    l_link                  varchar2(4000);',
'',
'begin',
'',
'    apex_json.initialize_output (',
'        p_http_cache => false );',
'',
'    apex_json.open_object;',
'',
'    -- First, we must get the color mapping if the color scheme requires it.',
'    if c_use_sql_color then',
'        l_column_value_list := apex_plugin_util.get_data2 (',
'            p_sql_statement     => p_region.attribute_23,',
'            p_min_columns       => 2,',
'            p_max_columns       => 2,',
'            p_component_name    => p_region.name );',
'',
'        apex_json.open_array(''colors'');',
'        for l_row_num in 1 .. l_column_value_list(1).value_list.count loop',
'            -- Series, optional',
'            l_series := apex_plugin_util.get_value_as_varchar2 (',
'                p_data_type => l_column_value_list(1).data_type,',
'                p_value     => l_column_value_list(1).value_list(l_row_num) );',
'            l_color := apex_plugin_util.get_value_as_varchar2 (',
'                p_data_type => l_column_value_list(2).data_type,',
'                p_value     => l_column_value_list(2).value_list(l_row_num) );',
'            ',
'            apex_json.open_object;',
'            apex_json.write(''series'', l_series);',
'            apex_json.write(''color'', l_color);',
'            apex_json.close_object();',
'',
'        end loop;',
'        apex_json.close_array;',
'',
'        l_series := null;',
'    end if;',
'',
'    -- Then, we get the actual data points.',
'    l_column_value_list := apex_plugin_util.get_data2 (',
'        p_sql_statement     => p_region.source,',
'        p_min_columns       => 2,',
'        p_max_columns       => 5,',
'        p_component_name    => p_region.name );',
'',
'    -- Get the actual column # for faster access and also verify that the data type',
'    -- of the column matches with what we are looking for',
'    IF c_x_data_type = ''NUMBER'' THEN',
'        l_x_column_no := apex_plugin_util.get_column_no (',
'            p_attribute_label       => ''x column'',',
'            p_column_alias          => c_x_column,',
'            p_column_value_list     => l_column_value_list,',
'            p_is_required           => true,',
'            p_data_type             => apex_plugin_util.c_data_type_varchar2 );',
'    ELSIF c_x_data_type = ''TIMESTAMP'' THEN',
'        l_x_column_no := apex_plugin_util.get_column_no (',
'            p_attribute_label       => ''x column'',',
'            p_column_alias          => c_x_column,',
'            p_column_value_list     => l_column_value_list,',
'            p_is_required           => true,',
'            p_data_type             => apex_plugin_util.c_data_type_timestamp );',
'    ELSIF c_x_data_type = ''TIMESTAMP_TZ'' THEN',
'        l_x_column_no := apex_plugin_util.get_column_no (',
'            p_attribute_label       => ''x column'',',
'            p_column_alias          => c_x_column,',
'            p_column_value_list     => l_column_value_list,',
'            p_is_required           => true,',
'            p_data_type             => apex_plugin_util.c_data_type_timestamp_tz );',
'    ELSIF c_x_data_type = ''TIMESTAMP_LTZ'' THEN',
'        l_x_column_no := apex_plugin_util.get_column_no (',
'            p_attribute_label       => ''x column'',',
'            p_column_alias          => c_x_column,',
'            p_column_value_list     => l_column_value_list,',
'            p_is_required           => true,',
'            p_data_type             => apex_plugin_util.c_data_type_timestamp_ltz );',
'    ELSE',
'        l_x_column_no := apex_plugin_util.get_column_no (',
'            p_attribute_label       => ''x column'',',
'            p_column_alias          => c_x_column,',
'            p_column_value_list     => l_column_value_list,',
'            p_is_required           => true,',
'            p_data_type             => apex_plugin_util.c_data_type_date );',
'    END IF;',
'',
'    l_y_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''y column'',',
'        p_column_alias          => c_y_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => true,',
'        p_data_type             => apex_plugin_util.c_data_type_number );',
'',
'    l_series_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''series column'',',
'        p_column_alias          => c_series_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => false,',
'        p_data_type             => apex_plugin_util.c_data_type_varchar2 );',
'',
'    l_tooltip_column_no := apex_plugin_util.get_column_no (',
'        p_attribute_label       => ''tooltip column'',',
'        p_column_alias          => c_tooltip_column,',
'        p_column_value_list     => l_column_value_list,',
'        p_is_required           => false,',
'        p_data_type             => apex_plugin_util.c_data_type_varchar2 );',
'',
'    --sys.htp.prn(''"data":['');',
'    apex_json.open_array(''data'');',
'',
'    -- Fetch data',
'    for l_row_num in 1 .. l_column_value_list(1).value_list.count loop',
'        begin',
'            apex_plugin_util.set_component_values (',
'                p_column_value_list => l_column_value_list,',
'                p_row_num => l_row_num ',
'            );',
'',
'            -- X is a string, number or date required',
'            if l_x_column_no is not null then',
'                ',
'                IF c_x_data_type = ''NUMBER'' THEN',
'                    l_x := l_column_value_list(l_x_column_no).value_list(l_row_num).number_value;',
'                ELSIF c_x_data_type = ''TIMESTAMP'' THEN',
'                    l_x_date := to_char(l_column_value_list(l_x_column_no).value_list(l_row_num).timestamp_value, ''DY MON DD YYYY HH24:MI:SS TZH:TZM''); ',
'                ELSIF c_x_data_type = ''TIMESTAMP_TZ'' THEN',
'                    l_x_date := to_char(l_column_value_list(l_x_column_no).value_list(l_row_num).timestamp_tz_value, ''DY MON DD YYYY HH24:MI:SS TZH:TZM'');',
'                ELSIF c_x_data_type = ''TIMESTAMP_LTZ'' THEN',
'                    l_x_date := to_char(l_column_value_list(l_x_column_no).value_list(l_row_num).timestamp_ltz_value, ''DY MON DD YYYY HH24:MI:SS'');',
'                ELSE',
'                    l_x_date := to_char(l_column_value_list(l_x_column_no).value_list(l_row_num).date_value, ''DY MON DD YYYY HH24:MI:SS'');',
'                END IF;',
'',
'',
'            end if;',
'',
'            -- Y is a number, required',
'            l_y := l_column_value_list(l_y_column_no).value_list(l_row_num).number_value;',
'',
'            -- Series, optional',
'            if l_series_column_no is not null then',
'                l_series := apex_plugin_util.get_value_as_varchar2 (',
'                    p_data_type => l_column_value_list(l_series_column_no).data_type,',
'                    p_value     => l_column_value_list(l_series_column_no).value_list(l_row_num) );',
'            end if;',
'',
'            -- Tooltip, optional',
'            if l_tooltip_column_no is not null then',
'                l_tooltip := apex_plugin_util.get_value_as_varchar2 (',
'                    p_data_type => l_column_value_list(l_tooltip_column_no).data_type,',
'                    p_value     => l_column_value_list(l_tooltip_column_no).value_list(l_row_num) );',
'            end if;',
'',
'            -- Link, optional',
'            if c_link_template is not null then',
'                l_link := wwv_flow_utilities.prepare_url (',
'                    apex_plugin_util.replace_substitutions (',
'                        p_value  => c_link_template,',
'                        p_escape => false ) );',
'            end if;',
'',
'            apex_json.open_object;',
'            apex_json.write(''series'', nvl(l_series, c_series_name));',
'            apex_json.write(''tooltip'', l_tooltip);',
'            apex_json.write(''link'', l_link);',
'             IF c_x_data_type = ''NUMBER'' THEN',
'                apex_json.write(''x'', l_x);',
'            ELSE',
'                apex_json.write(''x'', l_x_date);',
'            END IF;',
'            apex_json.write(''y'', l_y);',
'            apex_json.close_object;',
'',
'            apex_plugin_util.clear_component_values;',
'',
'        exception when others then',
'            apex_plugin_util.clear_component_values;',
'            raise;',
'        end;',
'    end loop;',
'    apex_json.close_array;',
'    apex_json.close_object;',
'',
'    return null;',
'end;'))
,p_render_function=>'render'
,p_ajax_function=>'ajax'
,p_standard_attributes=>'SOURCE_SQL:SOURCE_REQUIRED:AJAX_ITEMS_TO_SUBMIT:NO_DATA_FOUND_MESSAGE'
,p_sql_min_column_count=>2
,p_sql_max_column_count=>5
,p_substitute_attributes=>false
,p_reference_id=>1846795575691766306
,p_subscribe_plugin_settings=>true
,p_help_text=>'Data Driven Documents (D3) Line Chart provides dynamic and interactive bar charts for data visualization, using Scalable Vector Graphics (SVG), JavaScript, HTML5, and Cascading Style Sheets (CSS3) standards.'
,p_version_identifier=>'5.0.1'
,p_about_url=>'http://apex.oracle.com/plugins'
,p_files_version=>58
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23582530119023266)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>520
,p_prompt=>'Maximum Aspect Ratio'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'3'
,p_display_length=>5
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the maximum aspect ratio that charts use to recommend a height. A maximum aspect ratio of 3 means that the chart''s width should be no greater than 3 times its height. </p>',
'<p>Note: This setting can be overridden by the ''Maximum Height'' setting on the region.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23582979035023268)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>510
,p_prompt=>'Minimum Aspect Ratio'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'1.333'
,p_display_length=>5
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the minimum aspect ratio that charts use to recommend a height. A minimum aspect ratio of 1.333 means that the chart''s width should be no less than 1.333 times its height. </p>',
'<p>Note: This setting can be overridden by the ''Minimum Height'' setting on the region.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23583327529023268)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>3
,p_display_sequence=>550
,p_prompt=>'Responsive Behavior Threshold'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'480'
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'Enter the threshold (in pixels) at which the responsive behavior will be activated.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23583728714023269)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>4
,p_display_sequence=>540
,p_prompt=>'Responsive Behavior Measure'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'WINDOW'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select whether the responsive behavior threshold will be compared to the window or the region width.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23584128689023269)
,p_plugin_attribute_id=>wwv_flow_api.id(23583728714023269)
,p_display_sequence=>10
,p_display_value=>'Window'
,p_return_value=>'WINDOW'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23584637701023271)
,p_plugin_attribute_id=>wwv_flow_api.id(23583728714023269)
,p_display_sequence=>20
,p_display_value=>'Region'
,p_return_value=>'REGION'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23585139127023271)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>5
,p_display_sequence=>530
,p_prompt=>'Responsive Behavior'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Select whether responsive behavior is enabled for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23585511840023271)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>6
,p_display_sequence=>560
,p_prompt=>'Enable Transitions'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Select whether transitions are enabled for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23585937833023271)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'X Values Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'NUMBER:DATE:TIMESTAMP'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the X-axis values for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23586391401023271)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Y Values Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the Y-axis values for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23586726942023271)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>70
,p_prompt=>'X-Axis Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>20
,p_is_translatable=>true
,p_help_text=>'Enter the label for the X-axis.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23587124291023271)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>80
,p_prompt=>'Y-Axis Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>20
,p_is_translatable=>true
,p_help_text=>'Enter the label for the Y-axis.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23587546652023272)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>90
,p_prompt=>'X-Axis Data Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'NUMBER'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select the data type for the X-axis.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23587965104023273)
,p_plugin_attribute_id=>wwv_flow_api.id(23587546652023272)
,p_display_sequence=>10
,p_display_value=>'Number'
,p_return_value=>'NUMBER'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23588485246023273)
,p_plugin_attribute_id=>wwv_flow_api.id(23587546652023272)
,p_display_sequence=>20
,p_display_value=>'Date'
,p_return_value=>'DATE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23588942974023273)
,p_plugin_attribute_id=>wwv_flow_api.id(23587546652023272)
,p_display_sequence=>30
,p_display_value=>'Timestamp'
,p_return_value=>'TIMESTAMP'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23589410390023273)
,p_plugin_attribute_id=>wwv_flow_api.id(23587546652023272)
,p_display_sequence=>40
,p_display_value=>'Timestamp with Time Zone'
,p_return_value=>'TIMESTAMP_TZ'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23589946960023275)
,p_plugin_attribute_id=>wwv_flow_api.id(23587546652023272)
,p_display_sequence=>50
,p_display_value=>'Timestamp with Local Time Zone'
,p_return_value=>'TIMESTAMP_LTZ'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23590416105023275)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>110
,p_prompt=>'X-Axis Value Format Mask'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Custom'
,p_help_text=>'Select the data format mask for the X-axis.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23590893154023278)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>30
,p_display_value=>'14,435'
,p_return_value=>',.0f'
,p_help_text=>'Comma-separated thousands, integers'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23591344582023279)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>40
,p_display_value=>'14435'
,p_return_value=>'.0f'
,p_help_text=>'Integer'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23591811153023279)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>60
,p_display_value=>'14,435.49'
,p_return_value=>',.2f'
,p_help_text=>'Comma-separated thousands, 2 decimals'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23592360199023279)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>70
,p_display_value=>'14435.49'
,p_return_value=>'.2f'
,p_help_text=>'2 decimals'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23592899860023279)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>71
,p_display_value=>'14.4k'
,p_return_value=>'.3s'
,p_help_text=>'Precision 3, SI suffixes'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23593392262023279)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>80
,p_display_value=>'$14,435'
,p_return_value=>'$,.0f'
,p_help_text=>'Currency, comma-separated thousands, integer'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23593896977023279)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>90
,p_display_value=>'$14435'
,p_return_value=>'$.0f'
,p_help_text=>'Currency, integer'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23594390699023280)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>99
,p_display_value=>'$14,435.49'
,p_return_value=>'$,.2f'
,p_help_text=>'Currency, comma-separated thousands, 2 decimals'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23594896609023280)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>100
,p_display_value=>'$14435.49'
,p_return_value=>'$.2f'
,p_help_text=>'Currency, 2 decimals'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23595334764023280)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>120
,p_display_value=>'$14.4k'
,p_return_value=>'$.3s'
,p_help_text=>'Currency, precison 3, SI suffixes'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23595881280023280)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>130
,p_display_value=>'23:45:12'
,p_return_value=>'%X'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23596322299023280)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>140
,p_display_value=>'12/24/2000'
,p_return_value=>'%x'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23596835055023280)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>150
,p_display_value=>'Mon Jan 5 23:45:12 2000'
,p_return_value=>'%c'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23597373391023281)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>160
,p_display_value=>'12 Jan 2000'
,p_return_value=>'%e %b %Y'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23597808265023281)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>170
,p_display_value=>'Day'
,p_return_value=>'%A'
,p_help_text=>'Full weekday name'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23598344578023281)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>180
,p_display_value=>'Month'
,p_return_value=>'%B'
,p_help_text=>'Full month name'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23598827183023281)
,p_plugin_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_display_sequence=>190
,p_display_value=>'Year'
,p_return_value=>'%Y'
,p_help_text=>'Full year'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23599361141023282)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>120
,p_prompt=>'X-Axis Custom Value Format Mask'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'FRIENDLY'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(23590416105023275)
,p_depending_on_condition_type=>'NULL'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul>',
'<li><b>,d</b> = 14,435</li>',
'<li><b>d</b> = 14435</li>',
'<li><b>,.2f</b> = 14,435.49</li>',
'<li><b>.2f</b> = 14435.49</li>',
'<li><b>.3s</b> = 14.4k</li>',
'<li><b>$,d</b> = $14,435</li>',
'<li><b>$d</b> = $14435</li>',
'<li><b>$,.2f</b> = $14,435.49</li>',
'<li><b>$.2f</b> = $14435.49</li>',
'<li><b>$.3s</b> = $14.4k</li>',
'<li><b>n" ft."</b> = 14435.49 ft. **</li>',
'<li><b>"[["$.3s"]]"</b> = [[$14.4k]] **</li>',
'<li>Refer to https://github.com/mbostock/d3/wiki/Formatting#d3_format for the full syntax specification</li>',
'</ul>',
'<br/>',
'** You may use leading and trailing double-quoted literals, but this feature is not part of the standard D3 specification'))
,p_help_text=>'Enter the D3 format string used to format the X-axis values on axes, tooltips and legends. Use <pre>FRIENDLY</pre> to utilize sensible formatting defaults for your data.'
);
end;
/
begin
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23599769599023283)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>220
,p_prompt=>'Line Interpolation'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'linear'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select how the curvature of the line is fitted for the chart.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23600119955023284)
,p_plugin_attribute_id=>wwv_flow_api.id(23599769599023283)
,p_display_sequence=>10
,p_display_value=>'Linear'
,p_return_value=>'linear'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23600600958023284)
,p_plugin_attribute_id=>wwv_flow_api.id(23599769599023283)
,p_display_sequence=>20
,p_display_value=>'Step Before'
,p_return_value=>'step-before'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23601180161023284)
,p_plugin_attribute_id=>wwv_flow_api.id(23599769599023283)
,p_display_sequence=>30
,p_display_value=>'Step After'
,p_return_value=>'step-after'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23601667465023284)
,p_plugin_attribute_id=>wwv_flow_api.id(23599769599023283)
,p_display_sequence=>40
,p_display_value=>'Cardinal'
,p_return_value=>'cardinal'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23602141507023284)
,p_plugin_attribute_id=>wwv_flow_api.id(23599769599023283)
,p_display_sequence=>50
,p_display_value=>'Monotone'
,p_return_value=>'monotone'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23602691271023284)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>230
,p_prompt=>'Height Measure'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'LINES'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select how the minimum and maximum height of the chart is calculated.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23603089480023285)
,p_plugin_attribute_id=>wwv_flow_api.id(23602691271023284)
,p_display_sequence=>10
,p_display_value=>'Chart Lines Only'
,p_return_value=>'LINES'
,p_help_text=>'Applied to the height of the chart lines only.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23603562717023285)
,p_plugin_attribute_id=>wwv_flow_api.id(23602691271023284)
,p_display_sequence=>20
,p_display_value=>'Include Labels'
,p_return_value=>'CHART'
,p_help_text=>'Applies to the total chart including the labels.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23604018055023285)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>130
,p_prompt=>'Y-Axis Value Format Mask'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Custom'
,p_help_text=>'Select the data format mask for the Y-axis.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23604478839023285)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>10
,p_display_value=>'14,435'
,p_return_value=>',.0f'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23604908597023285)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>20
,p_display_value=>'14435'
,p_return_value=>'.0f'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23605439701023285)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>30
,p_display_value=>'14,435.49'
,p_return_value=>',.2f'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23605959112023285)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>40
,p_display_value=>'14435.49'
,p_return_value=>'.2f'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23606424824023286)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>50
,p_display_value=>'14.4k'
,p_return_value=>'.3s'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23606923631023286)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>60
,p_display_value=>'$14,435'
,p_return_value=>'$,.0f'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23607474594023286)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>70
,p_display_value=>'$14435'
,p_return_value=>'$.0f'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23607942449023286)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>80
,p_display_value=>'$14,435.49'
,p_return_value=>'$,.2f'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23608488353023287)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>90
,p_display_value=>'$14435.49'
,p_return_value=>'$.2f'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23608908298023287)
,p_plugin_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_display_sequence=>100
,p_display_value=>'$14.4k'
,p_return_value=>'$.3s'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23609415159023287)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>140
,p_prompt=>'Y-Axis Custom Value Format Mask'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'FRIENDLY'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(23604018055023285)
,p_depending_on_condition_type=>'NULL'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<ul>',
'<li><b>,d</b> = 14,435</li>',
'<li><b>d</b> = 14435</li>',
'<li><b>,.2f</b> = 14,435.49</li>',
'<li><b>.2f</b> = 14435.49</li>',
'<li><b>.3s</b> = 14.4k</li>',
'<li><b>$,d</b> = $14,435</li>',
'<li><b>$d</b> = $14435</li>',
'<li><b>$,.2f</b> = $14,435.49</li>',
'<li><b>$.2f</b> = $14435.49</li>',
'<li><b>$.3s</b> = $14.4k</li>',
'<li><b>n" ft."</b> = 14435.49 ft. **</li>',
'<li><b>"[["$.3s"]]"</b> = [[$14.4k]] **</li>',
'<li>Refer to https://github.com/mbostock/d3/wiki/Formatting#d3_format for the full syntax specification</li>',
'</ul>',
'<br/>',
'** You may use leading and trailing double-quoted literals, but this feature is not part of the standard D3 specification'))
,p_help_text=>'Enter the D3 format string used to format the Y-axis values on axes, tooltips and legends. Use <pre>FRIENDLY</pre> to utilize sensible formatting defaults for your data.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23609891103023287)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>100
,p_prompt=>'X-Axis Tick Interval'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(23587546652023272)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'DATE,TIMESTAMP,TIMESTAMP_TZ,TIMESTAMP_LTZ'
,p_lov_type=>'STATIC'
,p_null_text=>'Auto'
,p_help_text=>'Select the timeframe displayed on the X-axis for date type columns.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23610217592023288)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>10
,p_display_value=>'Second'
,p_return_value=>'SECOND'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23610787564023288)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>20
,p_display_value=>'Minute'
,p_return_value=>'MINUTE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23611213432023289)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>30
,p_display_value=>'Hour'
,p_return_value=>'HOUR'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23611759587023289)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>40
,p_display_value=>'Day'
,p_return_value=>'DAY'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23612280329023289)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>50
,p_display_value=>'Week'
,p_return_value=>'WEEK'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23612797202023289)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>60
,p_display_value=>'Sunday'
,p_return_value=>'SUNDAY'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23613245990023289)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>70
,p_display_value=>'Monday'
,p_return_value=>'MONDAY'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23613785515023289)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>80
,p_display_value=>'Tuesday'
,p_return_value=>'TUESDAY'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23614240918023290)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>90
,p_display_value=>'Wednesday'
,p_return_value=>'WEDNESDAY'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23614750147023290)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>100
,p_display_value=>'Thursday'
,p_return_value=>'THURSDAY'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23615280785023290)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>110
,p_display_value=>'Friday'
,p_return_value=>'FRIDAY'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23615791487023290)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>120
,p_display_value=>'Saturday'
,p_return_value=>'SATURDAY'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23616277916023290)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>130
,p_display_value=>'Month'
,p_return_value=>'MONTH'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23616786044023290)
,p_plugin_attribute_id=>wwv_flow_api.id(23609891103023287)
,p_display_sequence=>140
,p_display_value=>'Year'
,p_return_value=>'YEAR'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23617247092023291)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>190
,p_prompt=>'Color Scheme'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'MODERN'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Theme Default'
,p_help_text=>'<p>Select the color scheme used to render the chart.</p>'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23617602896023291)
,p_plugin_attribute_id=>wwv_flow_api.id(23617247092023291)
,p_display_sequence=>10
,p_display_value=>'Modern'
,p_return_value=>'MODERN'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23618194856023291)
,p_plugin_attribute_id=>wwv_flow_api.id(23617247092023291)
,p_display_sequence=>20
,p_display_value=>'Modern 2'
,p_return_value=>'MODERN2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23618641306023291)
,p_plugin_attribute_id=>wwv_flow_api.id(23617247092023291)
,p_display_sequence=>30
,p_display_value=>'Solar'
,p_return_value=>'SOLAR'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23619153303023291)
,p_plugin_attribute_id=>wwv_flow_api.id(23617247092023291)
,p_display_sequence=>40
,p_display_value=>'Metro'
,p_return_value=>'METRO'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23619671330023291)
,p_plugin_attribute_id=>wwv_flow_api.id(23617247092023291)
,p_display_sequence=>50
,p_display_value=>'SQL Query'
,p_return_value=>'COLUMN'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23620100258023291)
,p_plugin_attribute_id=>wwv_flow_api.id(23617247092023291)
,p_display_sequence=>60
,p_display_value=>'Custom'
,p_return_value=>'CUSTOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23620674189023292)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>200
,p_prompt=>'Colors'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(23617247092023291)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'CUSTOM'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<dl>',
'  <dt>Hexadecimal (hex) notation</dt><dd><pre>#FF3377</pre>;</dd>',
'  <dt>RGB color notation  (red,green,blue)</dt><dd><pre>rgba(0,25,47,0.5)</pre>; or </dd>',
'  <dt>RGBA color notation (red,green,blue,alpha)</dt><dd><pre>rgba(0,25,47,0.5)</pre>; or </dd>',
'  <dt>HTML colors</dt><dd><pre>blue</pre>.</dd>',
'</dl>'))
,p_help_text=>'<p>Enter a colon-separated list of color strings for the custom colors to be used in the chart.</p>'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23621079749023292)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>160
,p_prompt=>'Tooltip Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(23621419237023292)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'SERIES:X:Y:CUSTOM,SERIES:X:CUSTOM,SERIES:Y:CUSTOM,X:Y:CUSTOM,SERIES:CUSTOM,X:CUSTOM,Y:CUSTOM,CUSTOM'
,p_help_text=>'Enter the column from the region SQL Query that holds the custom tooltip values.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23621419237023292)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>150
,p_prompt=>'Tooltips'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Check which attributes are shown on the tooltip for each data point. The ''Custom column'' option allows you to specify text for each individual data point as an additional column in the region SQL Query.</p>',
'<p>Note: Leave all options unchecked to disable the tooltip.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23621832626023292)
,p_plugin_attribute_id=>wwv_flow_api.id(23621419237023292)
,p_display_sequence=>0
,p_display_value=>'Show series name'
,p_return_value=>'SERIES'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23622305382023292)
,p_plugin_attribute_id=>wwv_flow_api.id(23621419237023292)
,p_display_sequence=>10
,p_display_value=>'Show X value'
,p_return_value=>'X'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23622886204023292)
,p_plugin_attribute_id=>wwv_flow_api.id(23621419237023292)
,p_display_sequence=>20
,p_display_value=>'Show Y value'
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23623327740023293)
,p_plugin_attribute_id=>wwv_flow_api.id(23621419237023292)
,p_display_sequence=>30
,p_display_value=>'Custom column'
,p_return_value=>'CUSTOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23623817197023293)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>240
,p_prompt=>'Minimum Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_display_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'Enter the minimum height, in pixels, of the chart. Chart width will adapt to the size of the region.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23624261589023294)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>250
,p_prompt=>'Maximum Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_display_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'The maximum height, in pixels, of the chart. Chart width will adapt to the size of the region.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23624680946023294)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>30
,p_prompt=>'Link Target'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Example 1: URL to navigate to page 10 and set P10_EMPNO to the EMPNO value of the clicked entry.',
'<pre>f?p=&amp;APP_ID.:10:&amp;APP_SESSION.::&amp;DEBUG.:RP,10:P10_EMPNO:&amp;EMPNO.</pre>',
'</p>',
'<p>Example 2: Display the EMPNO value of the clicked entry in a JavaScript alert',
'<pre>javascript:alert(''current empno: &amp;EMPNO.'');</pre>',
'</p>'))
,p_help_text=>'<p>Enter a target page to be called when the user clicks a chart entry.</p>'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23625048794023294)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>40
,p_prompt=>'Display'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'OVERLAP'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select how the line chart data is displayed.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23625451949023294)
,p_plugin_attribute_id=>wwv_flow_api.id(23625048794023294)
,p_display_sequence=>10
,p_display_value=>'Overlap'
,p_return_value=>'OVERLAP'
,p_is_quick_pick=>true
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23625908960023294)
,p_plugin_attribute_id=>wwv_flow_api.id(23625048794023294)
,p_display_sequence=>20
,p_display_value=>'Stacked'
,p_return_value=>'STACKED'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23626452067023294)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>180
,p_prompt=>'Show Grid Lines'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Check the axes to display grid lines for that axis.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23626830075023294)
,p_plugin_attribute_id=>wwv_flow_api.id(23626452067023294)
,p_display_sequence=>10
,p_display_value=>'X-Axis'
,p_return_value=>'X'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23627363053023295)
,p_plugin_attribute_id=>wwv_flow_api.id(23626452067023294)
,p_display_sequence=>20
,p_display_value=>'Y-Axis'
,p_return_value=>'Y'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23627816740023295)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>210
,p_prompt=>'Color SQL Query'
,p_attribute_type=>'SQL'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_sql_min_column_count=>2
,p_sql_max_column_count=>2
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(23617247092023291)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'COLUMN'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<pre>select ''SALES'', rgb(0,255,0)',
'from dual',
'UNION',
'select ''RESEARCH'', rgba(0,25,47,0.5)',
'from dual;</pre>'))
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Enter a SQL Query that maps a series name to an RGB color. The first column must contain the series names (and those values must match the ones returned from the region SQL) and the second column must have the RGB or RGBA color notation for the serie'
||'s. ',
'Both columns must be VARCHAR2.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23628251511023295)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>23
,p_display_sequence=>60
,p_prompt=>'Multiple Series Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that defines the multiple series for the chart. The values from this column will become the labels for the series.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23628609565023295)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>50
,p_prompt=>'Single Series Name'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_api.id(23628251511023295)
,p_depending_on_condition_type=>'NULL'
,p_help_text=>'Enter the name of the single data series which is shown on the legend.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23629016765023296)
,p_plugin_id=>wwv_flow_api.id(23582314266023261)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>25
,p_display_sequence=>170
,p_prompt=>'Legend'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'No Legend'
,p_help_text=>'Select where the legend is displayed on the chart.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23629441434023296)
,p_plugin_attribute_id=>wwv_flow_api.id(23629016765023296)
,p_display_sequence=>10
,p_display_value=>'Above chart'
,p_return_value=>'TOP'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23629960553023296)
,p_plugin_attribute_id=>wwv_flow_api.id(23629016765023296)
,p_display_sequence=>20
,p_display_value=>'Below chart'
,p_return_value=>'BOTTOM'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_d3_treemap
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(23633528810023302)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.D3.TREEMAP'
,p_display_name=>'D3 Treemap Chart'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.D3.TREEMAP'),'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.treemapchart/1.0/')
,p_javascript_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/d3/3.5.5/d3.min.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/d3.oracle.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3/oracle.jql.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.tooltip/d3.oracle.tooltip.js',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.ary/d3.oracle.ary.js',
'#PLUGIN_FILES#com.oracle.apex.d3.treemapchart.js'))
,p_css_file_urls=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.tooltip/d3.oracle.tooltip.css',
'#IMAGE_PREFIX#plugins/com.oracle.apex.d3.ary/d3.oracle.ary.css',
'#PLUGIN_FILES#d3.oracle.treemapchart.css'))
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'function ora_d3_treemap_ajax (  p_region in apex_plugin.t_region,',
'                                 p_plugin in apex_plugin.t_plugin )',
'                        return apex_plugin.t_region_ajax_result is',
'    c_label_col     constant varchar2(255) := p_region.attribute_12;',
'    c_value_col     constant varchar2(255) := p_region.attribute_13;',
'    c_pk_col        constant varchar2(255) := p_region.attribute_14;',
'    c_parent_col    constant varchar2(255) := p_region.attribute_15;',
'    c_group_col     constant varchar2(255) := p_region.attribute_16;',
'    c_link_col      constant varchar2(255) := p_region.attribute_17;',
'    c_tooltip_col   constant varchar2(255) := p_region.attribute_20;',
'    c_link_target   constant varchar2(255) := p_region.attribute_24;',
'',
'    l_label_col_no      pls_integer;',
'    l_value_col_no      pls_integer;',
'    l_pk_col_no         pls_integer;',
'    l_parent_col_no     pls_integer;',
'    l_group_col_no      pls_integer;',
'    l_link_col_no       pls_integer;',
'    l_tooltip_col_no    pls_integer;',
'',
'    l_label  varchar2(4000);',
'    l_value  number;',
'    l_pk     varchar2(4000);',
'    l_parent varchar2(4000);',
'    l_group  varchar2(4000);',
'    l_link   varchar2(4000);',
'    l_desc   varchar2(4000);',
'    l_tooltip   varchar2(4000);',
'',
'    l_num_rows          pls_integer := p_region.fetched_rows;',
'    l_count             pls_integer := 0;',
'    l_column_value_list apex_plugin_util.t_column_value_list2;',
'    l_region_source     varchar2(32767) := p_region.source;',
'begin',
'    -- get the data to be displayed',
'    l_column_value_list := apex_plugin_util.get_data2 (',
'                               p_sql_statement  => l_region_source,',
'                               p_min_columns    => 4,',
'                               p_max_columns    => null,',
'                               p_component_name => p_region.name,',
'                               p_max_rows       => null );',
'',
'    -- Get the actual column number for the fields we want.',
'    l_label_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Label Column'',',
'                        p_column_alias      => c_label_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'    l_value_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Value Column'',',
'                        p_column_alias      => c_value_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_number',
'                    );',
'    l_pk_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Primary Key Column'',',
'                        p_column_alias      => c_pk_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'    l_parent_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Parent Key Column'',',
'                        p_column_alias      => c_parent_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => false,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'    l_group_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Color Group Column'',',
'                        p_column_alias      => c_group_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'    l_tooltip_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Tooltip Column'',',
'                        p_column_alias      => c_tooltip_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => false,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'',
'    -- Loop through the data',
'    apex_json.open_object;',
'    apex_json.open_array(''row'');',
'    for l_row_num in 1..l_column_value_list(1).value_list.count loop',
'        if l_count < nvl(l_num_rows,l_count) then',
'            l_count := l_count+1;',
'',
'            begin',
'                -- Assign the column values of the current row',
'                -- into session state',
'                apex_plugin_util.set_component_values (',
'                    p_column_value_list => l_column_value_list,',
'                    p_row_num           => l_row_num );',
'',
'                apex_json.open_object;',
'',
'                l_label  := apex_plugin_util.get_value_as_varchar2(',
'                                p_data_type => l_column_value_list(l_label_col_no).data_type,',
'                                p_value     => l_column_value_list(l_label_col_no).value_list(l_row_num) );',
'                l_value  := l_column_value_list(l_value_col_no).value_list(l_row_num).number_value;',
'                l_pk     := apex_plugin_util.get_value_as_varchar2(',
'                                p_data_type => l_column_value_list(l_pk_col_no).data_type,',
'                                p_value     => l_column_value_list(l_pk_col_no).value_list(l_row_num) );',
'                l_group  := apex_plugin_util.get_value_as_varchar2(',
'                                p_data_type => l_column_value_list(l_group_col_no).data_type,',
'                                p_value     => l_column_value_list(l_group_col_no).value_list(l_row_num) );',
'',
'                if l_parent_col_no is not null then',
'                   l_parent := apex_plugin_util.get_value_as_varchar2(',
'                                p_data_type => l_column_value_list(l_parent_col_no).data_type,',
'                                p_value     => l_column_value_list(l_parent_col_no).value_list(l_row_num) );',
'                end if;',
'',
'                -- Emit the optional columns if provided',
'',
'                -- Link Target, optional',
'                if c_link_target is not null then',
'                    l_link := wwv_flow_utilities.prepare_url (',
'                        apex_plugin_util.replace_substitutions (',
'                            p_value  => c_link_target,',
'                            p_escape => false ) );',
'                end if;',
'',
'                -- Tooltip, optional',
'                if l_tooltip_col_no is not null then',
'                    l_tooltip := apex_plugin_util.get_value_as_varchar2 (',
'                        p_data_type => l_column_value_list(l_tooltip_col_no).data_type,',
'                        p_value     => l_column_value_list(l_tooltip_col_no).value_list(l_row_num) );',
'                end if;',
'',
'                -- Emit the required columns',
'                apex_json.write(''ID'',        l_pk);',
'                apex_json.write(''LABEL'',     l_label);',
'                apex_json.write(''COLORVALUE'',l_group);',
'                apex_json.write(''SIZEVALUE'', l_value);',
'                apex_json.write(''PARENT_ID'', l_parent);',
'                apex_json.write(''LINK'', l_link);',
'                apex_json.write(''TOOLTIP'',l_tooltip);',
'',
'                apex_json.close_object;',
'',
'                apex_plugin_util.clear_component_values;',
'            exception when others then',
'                apex_plugin_util.clear_component_values;',
'                raise;',
'            end;',
'        end if;',
'    end loop;',
'    apex_json.close_all;',
'',
'    return null;',
'  end ora_d3_treemap_ajax; ',
'',
' function ora_d3_treemap_render (',
'      p_region              in apex_plugin.t_region,',
'      p_plugin              in apex_plugin.t_plugin,',
'      p_is_printer_friendly in boolean ',
'  ) return apex_plugin.t_region_render_result is ',
'',
'    --Advanced Configuration',
'    l_adv_conf         apex_application_page_regions.attribute_25%type := p_region.attribute_25;',
'',
'    --Color Scheme',
'    l_colors           apex_application_page_regions.attribute_02%type := p_region.attribute_02;',
'    l_colors_fg        apex_application_page_regions.attribute_02%type;',
'',
'     --Dimensions',
'    c_min_height            constant number         := nvl(p_region.attribute_21, 100);',
'    c_max_height            constant number         := nvl(p_region.attribute_22, 500);',
'',
'    --Aspect Ratios',
'    c_min_ar                constant number         := apex_plugin_util.get_attribute_as_number(p_plugin.attribute_01, ''Min Aspect Ratio'');',
'    c_max_ar                constant number         := apex_plugin_util.get_attribute_as_number(p_plugin.attribute_02, ''Max Aspect Ratio'');',
'    l_formatted_min_ar      varchar2(200);',
'    l_formatted_max_ar      varchar2(200);',
'',
'    -- Legend',
'    c_show_legend           constant boolean        := p_region.attribute_23 is not null;',
'    c_legend_position       constant varchar2(200)  := p_region.attribute_23;',
'    ',
'     -- Tooltip configuration',
'    c_show_tooltip          constant boolean        := p_region.attribute_19 is not null;',
'    c_series_tooltip        constant boolean        := instr('':'' || p_region.attribute_19 || '':'', '':SERIES:'') > 0;',
'    c_custom_tooltip        constant boolean        := instr('':'' || p_region.attribute_19 || '':'', '':CUSTOM:'') > 0;',
'    c_value_tooltip         constant boolean        := instr('':'' || p_region.attribute_19 || '':'', '':VALUE:'') > 0;',
'',
'  begin',
'',
'    -- Formatting to fix add_attribute bug.',
'    if c_min_ar > -1 and c_min_ar < 1 and c_min_ar <> 0 then',
'        l_formatted_min_ar := (case when c_min_ar < 0 then ''-'' else '''' end) || ''0'' || to_char(abs(c_min_ar));',
'    else',
'        l_formatted_min_ar := to_char(c_min_ar);',
'    end if;',
'    if c_max_ar > -1 and c_max_ar < 1 and c_max_ar <> 0 then',
'        l_formatted_max_ar := (case when c_max_ar < 0 then ''-'' else '''' end) || ''0'' || to_char(abs(c_max_ar));',
'    else',
'        l_formatted_max_ar := to_char(c_max_ar);',
'    end if;',
'',
'    -- Color scheme',
'    IF l_colors = ''MODERN'' THEN',
'        l_colors    := ''#FF3B30:#FF9500:#FFCC00:#4CD964:#34AADC:#007AFF:#5856D6:#FF2D55:#8E8E93:#C7C7CC'';',
'        l_colors_fg := ''#000000:#000000:#000000:#000000:#000000:#000000:#FFFFFF:#000000:#000000:#000000'';',
'    ELSIF l_colors = ''MODERN2'' THEN',
'        l_colors    := ''#1ABC9C:#2ECC71:#4AA3DF:#9B59B6:#3D566E:#F1C40F:#E67E22:#E74C3C'';',
'        l_colors_fg := ''#000000:#000000:#000000:#FFFFFF:#FFFFFF:#000000:#000000:#000000'';',
'    ELSIF l_colors = ''SOLAR'' THEN',
'        l_colors    := ''#B58900:#CB4B16:#DC322F:#D33682:#6C71C4:#268BD2:#2AA198:#859900'';',
'        l_colors_fg := ''#000000:#FFFFFF:#FFFFFF:#FFFFFF:#000000:#000000:#000000:#000000'';',
'    ELSIF l_colors = ''METRO'' then',
'        l_colors    := ''#E61400:#19A2DE:#319A31:#EF9608:#8CBE29:#A500FF:#00AAAD:#FF0094:#9C5100:#E671B5'';',
'        l_colors_fg := ''#FFFFFF:#000000:#000000:#000000:#000000:#FFFFFF:#000000:#000000:#FFFFFF:#000000'';',
'    ELSE',
'        l_colors    := null;',
'        l_colors_fg := null;',
'    END IF;',
'',
'    sys.htp.p(',
'        ''<div class="a-D3TreemapChart" id="'' || apex_plugin_util.escape(p_region.static_id, true) || ''_region">'' ||',
'            ''<div class="a-D3TreemapChart-container" id="'' || apex_plugin_util.escape(p_region.static_id, true) ||''_chart"></div>'' ||',
'        ''</div>'');',
'    apex_javascript.add_onload_code (',
'      ''com_oracle_apex_d3_treemap_start(''',
'        ||apex_javascript.add_value(p_region.static_id, true)',
'        ||apex_javascript.add_value(apex_plugin.get_ajax_identifier, true)',
'        ||apex_javascript.add_value(l_colors, true)',
'        ||apex_javascript.add_value(l_colors_fg, true)',
'        ||apex_javascript.add_value(l_adv_conf, true)',
'        ||apex_javascript.add_value(l_formatted_min_ar, true)',
'        ||apex_javascript.add_value(l_formatted_min_ar, true)',
'        ||apex_javascript.add_value(c_min_height, true)',
'        ||apex_javascript.add_value(c_max_height, true)',
'        ||apex_javascript.add_value(apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit))',
'        ||apex_javascript.add_value(c_show_tooltip, true) ',
'        ||apex_javascript.add_value(c_series_tooltip, true) ',
'        ||apex_javascript.add_value(c_custom_tooltip, true)',
'        ||apex_javascript.add_value(c_value_tooltip, true)',
'        ||apex_javascript.add_value(c_show_legend, true) ',
'        ||apex_javascript.add_value(c_legend_position, false)',
'        ||'');''',
'    );',
'    return null;',
'  end ora_d3_treemap_render;'))
,p_render_function=>'ora_d3_treemap_render'
,p_ajax_function=>'ora_d3_treemap_ajax'
,p_standard_attributes=>'SOURCE_SQL:SOURCE_REQUIRED:AJAX_ITEMS_TO_SUBMIT:FETCHED_ROWS:ESCAPE_OUTPUT'
,p_sql_min_column_count=>4
,p_sql_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>You can provide either a SQL query or a PL/SQL block returning a SQL query. For a PL/SQL block, make sure that the very first word is either "begin" or "declare" and place comments afterwards.',
'</p>',
'<h1>SQL Example</h1>',
'<pre>',
'select',
'  empno as ID,              --required',
'  job   as COLORVALUE,      --required',
'  sal   as SIZEVALUE,       --required',
'  mgr   as PARENT_ID,       --optional',
'  ename as LABEL,           --required',
'  null  as LINK,            --optional',
'  dname  as INFOSTRING       --optional',
'from emp e',
',    dept d',
'where e.deptno = d.deptno',
'</pre>',
''))
,p_substitute_attributes=>false
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>',
'	This plugin provides a&nbsp;<em>Treemap Chart</em> based on the <a href="http://www.d3js.org" target="_blank">D3js</a> framework. Treemap charts allow to visualize two values by area sizes and colors and provide a good overview on data distribution.'
||' This plugin is based on the <a href="http://bl.ocks.org/mbostock/4063582">treemap chart example</a>&nbsp;by the D3js author Mike Bostock.</p>',
'<p>',
'	Plugin features:</p>',
'<ul>',
'	<li>',
'		Generate a Treemap Chart based on the SQL query in the Region source',
'		<ul>',
'			<li>',
'				The data hierarchy (columns ID and PARENT_ID) is being detected automatically; if PARENT_ID is<br />',
'				missing or if it contains nonexistent values, the nodes are being considered as root nodes.</li>',
'			<li>',
'				Plugin honors the&nbsp;<em>Page Items to Submit&nbsp;</em>attribute</li>',
'			<li>',
'				Plugin honors the&nbsp;<em>Escape Special Characters&nbsp;</em>attribute (this applies to the &quot;Infobox&quot; which is displayed on Mouseover)</li>',
'		</ul>',
'	</li>',
'	<li>',
'		The Plugin is AJAX aware',
'		<ul>',
'			<li>',
'				Honors the&nbsp;<em>apexrefresh</em> event - you can refresh the chart with a Dynamic Action</li>',
'			<li>',
'				The Plugin provides an&nbsp;<em>Auto Refresh&nbsp;</em>mode</li>',
'			<li>',
'				Plugin posts events to the APEX Dynamic Action Framework. So you can create dynamic Actions (e.g. to refresh other APEX components) based on the following plugin events.',
'				<ul>',
'					<li>',
'						Mouseover</li>',
'					<li>',
'						Mouseout</li>',
'					<li>',
'						Mouse Click</li>',
'					<li>',
'						Chart initialized<br />',
'						&nbsp;</li>',
'				</ul>',
'			</li>',
'		</ul>',
'	</li>',
'	<li>',
'		CSS and responsive Features',
'		<ul>',
'			<li>',
'				The plugin is responsive and changes its size according to the device&#39;s display size</li>',
'			<li>',
'				All components (Areas, Infoboxes, highlighted areas) can be augmented with own CSS classes</li>',
'		</ul>',
'	</li>',
'</ul>'))
,p_version_identifier=>'5.0.2'
,p_about_url=>'http://apex.oracle.com/plugins'
,p_files_version=>6
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23633845277023303)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>1
,p_display_sequence=>510
,p_prompt=>'Minimum Aspect Ratio'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'1.33'
,p_display_length=>5
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the minimum aspect ratio that charts use to recommend a height. A minimum aspect ratio of 1.333 means that the chart''s width should be no less than 1.333 times its height. </p>',
'<p>Note: This setting can be overridden by the ''Min Height'' setting on the region.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23634248760023303)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'APPLICATION'
,p_attribute_sequence=>2
,p_display_sequence=>520
,p_prompt=>'Maximum Aspect Ratio'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_default_value=>'3'
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Enter the maximum aspect ratio that charts use to recommend a height. A maximum aspect ratio of 3 means that the chart''s width should be no greater than 3 times its height. </p>',
'<p>Note: This setting can be overridden by the ''Maximum Height'' setting on the region.</p>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23634648033023304)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>100
,p_prompt=>'Color Scheme'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Theme Default'
,p_help_text=>'<p>Select the color scheme used to render the chart.</p>'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23635004521023304)
,p_plugin_attribute_id=>wwv_flow_api.id(23634648033023304)
,p_display_sequence=>60
,p_display_value=>'Modern'
,p_return_value=>'MODERN'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23635566475023304)
,p_plugin_attribute_id=>wwv_flow_api.id(23634648033023304)
,p_display_sequence=>70
,p_display_value=>'Modern 2'
,p_return_value=>'MODERN2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23636046764023304)
,p_plugin_attribute_id=>wwv_flow_api.id(23634648033023304)
,p_display_sequence=>80
,p_display_value=>'Solar'
,p_return_value=>'SOLAR'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23636511220023304)
,p_plugin_attribute_id=>wwv_flow_api.id(23634648033023304)
,p_display_sequence=>90
,p_display_value=>'Metro'
,p_return_value=>'METRO'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23637080213023305)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>10
,p_prompt=>'Label Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the labels for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23637400301023305)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>20
,p_prompt=>'Value Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'NUMBER'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the labels for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23637804160023305)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>40
,p_prompt=>'Primary Key Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the primary key values for the chart. The primary key and parent key columns are used to define the hierarchy for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23638297250023305)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>50
,p_prompt=>'Parent Key Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>false
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the parent key values for the chart. The primary key and parent key columns are used to define the hierarchy for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23638685219023305)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>60
,p_prompt=>'Color Group Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query that holds the color group values for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23639046467023305)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>70
,p_prompt=>'Tooltips'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Check which attributes are shown on the tooltip for each data point. The ''Custom column'' option allows you to specify text for each individual data point as an additional column in the region SQL Query.</p>',
'<p>Note: Leave all options unchecked to disable the tooltip.</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23639402142023305)
,p_plugin_attribute_id=>wwv_flow_api.id(23639046467023305)
,p_display_sequence=>10
,p_display_value=>'Show series name'
,p_return_value=>'SERIES'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23639922917023306)
,p_plugin_attribute_id=>wwv_flow_api.id(23639046467023305)
,p_display_sequence=>20
,p_display_value=>'Custom column'
,p_return_value=>'CUSTOM'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23640466805023306)
,p_plugin_attribute_id=>wwv_flow_api.id(23639046467023305)
,p_display_sequence=>30
,p_display_value=>'Show Value'
,p_return_value=>'VALUE'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23640925522023306)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>80
,p_prompt=>'Tooltip Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_is_common=>false
,p_show_in_wizard=>false
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(23639046467023305)
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'SERIES:CUSTOM:VALUE,SERIES:CUSTOM,CUSTOM:VALUE,CUSTOM'
,p_help_text=>'Select the column from the region SQL Query that holds the tooltip values for the chart.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23641383053023306)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>110
,p_prompt=>'Minimum Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'Enter the minimum height, in pixels, of the chart. Chart width will adapt to the size of the region.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23641741863023306)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>120
,p_prompt=>'Maximum Height'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_common=>false
,p_show_in_wizard=>false
,p_display_length=>5
,p_max_length=>5
,p_unit=>'px'
,p_is_translatable=>false
,p_help_text=>'Enter the maximum height, in pixels, of the chart. Chart width will adapt to the size of the region.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23642186566023306)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>23
,p_display_sequence=>90
,p_prompt=>'Legend'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'No Legend'
,p_help_text=>'Select where the legend is displayed on the chart.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23642518823023307)
,p_plugin_attribute_id=>wwv_flow_api.id(23642186566023306)
,p_display_sequence=>10
,p_display_value=>'Above Chart'
,p_return_value=>'TOP'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(23643037638023307)
,p_plugin_attribute_id=>wwv_flow_api.id(23642186566023306)
,p_display_sequence=>20
,p_display_value=>'Below Chart'
,p_return_value=>'BOTTOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23643575653023307)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>30
,p_prompt=>'Link Target'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<p>Example 1: URL to navigate to page 10 and set P10_EMPNO to the EMPNO value of the clicked entry.',
'<pre>f?p=&amp;APP_ID.:10:&amp;APP_SESSION.::&amp;DEBUG.:RP,10:P10_EMPNO:&amp;EMPNO.</pre>',
'</p>',
'<p>Example 2: Display the EMPNO value of the clicked entry in a JavaScript alert',
'<pre>javascript:alert(''current empno: &amp;EMPNO.'');</pre>',
'</p>'))
,p_help_text=>'<p>Enter a target page to be called when the user clicks a chart entry.</p>'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23643981375023307)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>25
,p_display_sequence=>130
,p_prompt=>'Configuration JSON'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>true
,p_default_value=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'{',
'"trdur":                       500,',
'"opacity_normal":              "0.8",',
'"opacity_highlight":           "1.0"',
'}'))
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'This JSON contains some custom attributes for the chart plugin:',
'-"trdur": Is the transition duration of the effects of the chart in milliseconds. ',
'-"opacity_normal": The regular opacity of the nodes.',
'-"opacity_highlight": The opacity when the node is hovered.'))
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(23645078784023308)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_name=>'com_oracle_apex_d3_click'
,p_display_name=>'D3Chart_MouseClick'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(23645443345023310)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_name=>'com_oracle_apex_d3_initialized'
,p_display_name=>'D3Chart_Initialized'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(23645858404023310)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_name=>'com_oracle_apex_d3_mouseout'
,p_display_name=>'D3Chart_MouseOut'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(23646269463023310)
,p_plugin_id=>wwv_flow_api.id(23633528810023302)
,p_name=>'com_oracle_apex_d3_mouseover'
,p_display_name=>'D3Chart_MouseOver'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_minicalendar
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(23646610262023310)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.MINICALENDAR'
,p_display_name=>'Mini Calendar'
,p_supported_ui_types=>'DESKTOP'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.MINICALENDAR'),'')
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'procedure render_mini_calendar( p_region in apex_plugin.t_region ) is',
'    c_date_col  constant varchar2(255) := p_region.attribute_01;',
'    c_label_col constant varchar2(255) := p_region.attribute_02;',
'',
'    l_date_col_no  pls_integer;',
'    l_label_col_no pls_integer;',
'',
'    c_collection constant varchar2(255) := ''APEX$MINICALENDAR$''||rawtohex(sys_guid());',
'    l_column_value_list    apex_plugin_util.t_column_value_list2;',
'',
'    l_region_source        varchar2(32767) := p_region.source;',
'',
'    --',
'    l_date  timestamp with local time zone;',
'    l_label varchar2(2000);',
'    l_found boolean;',
'    l_count number;',
'',
'    cursor dt_csr is',
'        select c001 label, d001 the_date',
'        from apex_collections',
'        where collection_name = c_collection',
'        order by d001 asc;',
'    dt_rec dt_csr%ROWTYPE;',
'',
'    -- Variables for knowing what to display.',
'    l_startdate  date;',
'    l_enddate    date;',
'    l_daycount   number;',
'    l_month      varchar2(6);',
'',
'    l_class      varchar2(512) := '''';',
'    l_disp       varchar2(255)  := '''';',
'    l_id         varchar2(512) := p_region.static_id;',
'begin',
'    -- get the data to be displayed',
'    l_column_value_list := apex_plugin_util.get_data2 (',
'                               p_sql_statement  => l_region_source,',
'                               p_min_columns    => 2,',
'                               p_max_columns    => null,',
'                               p_component_name => p_region.name,',
'                               p_max_rows       => null );',
'',
'    -- Get the actual column number for the fields we want.',
'    l_date_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Date column'',',
'                        p_column_alias      => c_date_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => null -- might be date, timestamp, etc.',
'                    );',
'',
'    l_label_col_no := apex_plugin_util.get_column_no (',
'                        p_attribute_label   => ''Label column'',',
'                        p_column_alias      => c_label_col,',
'                        p_column_value_list => l_column_value_list,',
'                        p_is_required       => true,',
'                        p_data_type         => apex_plugin_util.c_data_type_varchar2',
'                    );',
'',
'    apex_collection.create_or_truncate_collection( p_collection_name => c_collection );',
'    -- Loop through the data and shove it into the collection for ease of access.',
'    for l_row_num in 1..l_column_value_list(1).value_list.count loop',
'        l_found := true;',
'        if l_column_value_list(l_date_col_no).value_list(l_row_num).date_value is not null then',
'            l_date := l_column_value_list(l_date_col_no).value_list(l_row_num).date_value;',
'        elsif l_column_value_list(l_date_col_no).value_list(l_row_num).timestamp_value is not null then',
'            l_date := l_column_value_list(l_date_col_no).value_list(l_row_num).timestamp_value;',
'        elsif l_column_value_list(l_date_col_no).value_list(l_row_num).timestamp_tz_value is not null then',
'            l_date := l_column_value_list(l_date_col_no).value_list(l_row_num).timestamp_tz_value;',
'        elsif l_column_value_list(l_date_col_no).value_list(l_row_num).timestamp_ltz_value is not null then',
'            l_date := l_column_value_list(l_date_col_no).value_list(l_row_num).timestamp_ltz_value;',
'        else',
'            -- Couldn''t get a usable date value; ignore this row.',
'            l_found := false;',
'        end if;',
'        if l_found then',
'            select count(*) into l_count',
'            from apex_collections',
'            where collection_name = c_collection',
'                and d001 = trunc(l_date);',
'',
'            if l_count = 0 then',
'                l_label := apex_plugin_util.escape(',
'                            apex_plugin_util.get_value_as_varchar2(',
'                                p_data_type => l_column_value_list(l_label_col_no).data_type,',
'                                p_value     => l_column_value_list(l_label_col_no).value_list(l_row_num) ),',
'                            p_region.escape_output );',
'                apex_collection.add_member(',
'                    p_collection_name => c_collection,',
'                    p_c001            => l_label,',
'                    p_d001            => trunc(l_date)',
'                );',
'            end if;',
'        end if;',
'    end loop;',
'',
'    open dt_csr;',
'    fetch dt_csr into dt_rec;',
'    if dt_csr%FOUND then',
'        l_date  := dt_rec.the_date;',
'        l_label := dt_rec.label;',
'    else',
'        l_date  := trunc(localtimestamp);',
'        l_label := ''Today'';',
'    end if;',
'',
'    -- Print the calendar header.',
'    sys.htp.prn(''<div class="a-MiniCal">'');',
'    sys.htp.prn(''<h3 class="a-MiniCal-title">''||to_char(l_date, ''Month'')||'' ''||to_char(l_date,''YYYY'')||''</h3>'');',
'    sys.htp.prn(''<table class="a-MiniCal-month" summary="Calendar of ''||to_char(l_date, ''Month'')||'' ''||to_char(l_date,''YYYY'')||''">'');',
'    sys.htp.prn(''<thead>'');',
'    sys.htp.prn(''<tr>'');',
'    sys.htp.prn(''<th class="a-MiniCal-dayOfWeek" scope="col" id="''||l_id||''_SUN" title="Sunday">Su</th>'');',
'    sys.htp.prn(''<th class="a-MiniCal-dayOfWeek" scope="col" id="''||l_id||''_MON" title="Monday">Mo</th>'');',
'    sys.htp.prn(''<th class="a-MiniCal-dayOfWeek" scope="col" id="''||l_id||''_TUE" title="Tuesday">Tu</th>'');',
'    sys.htp.prn(''<th class="a-MiniCal-dayOfWeek" scope="col" id="''||l_id||''_WED" title="Wednesday">We</th>'');',
'    sys.htp.prn(''<th class="a-MiniCal-dayOfWeek" scope="col" id="''||l_id||''_THU" title="Thursday">Th</th>'');',
'    sys.htp.prn(''<th class="a-MiniCal-dayOfWeek" scope="col" id="''||l_id||''_FRI" title="Friday">Fr</th>'');',
'    sys.htp.prn(''<th class="a-MiniCal-dayOfWeek" scope="col" id="''||l_id||''_SAT" title="Saturday">Sa</th>'');',
'    sys.htp.prn(''</tr>'');',
'    sys.htp.prn(''</thead>'');',
'    -- Print the calendar body.',
'    sys.htp.prn(''<tbody>'');',
'    -- Do some quick manipulation to get the day of the week that the first of the month',
'     --  lands on, and then shift our starting date to the first day of that week.',
'    l_startdate := trunc(l_date,''MM'') - to_char(trunc(l_date,''MM''),''D'') + 1;',
'    l_enddate := last_day(l_date) + 7-to_char(last_day(l_date),''D'');',
'    l_month := to_char(l_date,''YYYYMM'');',
'',
'    for l_daycount in 0..(l_enddate - l_startdate) loop',
'        l_class := '''';',
'        l_disp := to_char(l_startdate+l_daycount,''fmDD'');',
'        -- If the day isn''t part of the month being displayed, grey it out.',
'        if to_char(l_startdate+l_daycount,''YYYYMM'') <> l_month then',
'            l_class := ''is-null'';',
'            l_disp := ''<span class="a-MiniCal-date">''||l_disp||''</span>'';',
'        else',
'            if to_char(l_startdate+l_daycount,''D'') in (''1'',''7'') then',
'                l_class := l_class || ''is-weekend '';',
'                l_disp := ''<span class="a-MiniCal-date">''||l_disp||''</span>'';',
'            end if;',
'            if l_month = to_char(localtimestamp,''YYYYMM'')',
'                    and l_startdate+l_daycount = current_date then',
'                l_class := l_class || ''is-today '';',
'                l_disp := ''<span class="a-MiniCal-date">''||l_disp||''</span>'';',
'            end if;',
'            if to_char(l_startdate+l_daycount,''YYYYMMDD'')',
'                    = to_char(l_date,''YYYYMMDD'') then',
'                l_class := l_class || ''is-active '';',
'                l_disp := ''<span class="a-MiniCal-date" title="''||l_label||''">''||l_disp||''</span>'';',
'            end if;',
'        end if;',
'        if to_char(l_startdate+l_daycount,''D'') = ''1'' then',
'            sys.htp.prn(''<tr>'');',
'        end if;',
'        sys.htp.prn(''<td class="a-MiniCal-day ''||l_class||''" headers="''||l_id||''_''||to_char(l_startdate+l_daycount,''DY'')||''">''||l_disp||''</td>'');',
'        if to_char(l_startdate+l_daycount,''D'') = ''7'' then',
'            sys.htp.prn(''</tr>'');',
'        end if;',
'        if to_char(l_startdate+l_daycount,''YYYYMMDD'') = to_char(l_date,''YYYYMMDD'') then',
'            fetch dt_csr into dt_rec;',
'            if dt_csr%FOUND then',
'                l_date  := dt_rec.the_date;',
'                l_label := dt_rec.label;',
'            end if;',
'        end if;',
'    end loop;',
'    close dt_csr;',
'',
'    -- Clean up after ourselves.',
'    apex_collection.delete_collection( p_collection_name => c_collection );',
'',
'    sys.htp.prn(''</tbody>'');',
'    sys.htp.prn(''</table>'');',
'    sys.htp.prn(''</div>'');',
'end render_mini_calendar;',
'',
'function render ( p_region in apex_plugin.t_region,',
'    p_plugin in apex_plugin.t_plugin, p_is_printer_friendly in boolean )',
'    return apex_plugin.t_region_render_result is',
'begin',
'    -- CSS for the Gantt Chart',
'    apex_css.add_file (',
'        p_name => ''com_oracle_apex_minicalendar'',',
'        p_directory => p_plugin.file_prefix );',
'',
'    render_mini_calendar( p_region );',
'    return null;',
'end;'))
,p_render_function=>'render'
,p_standard_attributes=>'SOURCE_SQL:SOURCE_REQUIRED:ESCAPE_OUTPUT'
,p_sql_min_column_count=>1
,p_sql_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'The query must return at least two columns--a date and its label (other columns will be ignored). The calendar will display for the earliest date returned, highlighting all dates returned within that month.',
'',
'<pre>',
'select date_value, label_value',
'from ...',
'</pre>'))
,p_substitute_attributes=>true
,p_reference_id=>2274280293531485134
,p_subscribe_plugin_settings=>true
,p_help_text=>'This region plug-in displays a small calendar with the specified date highlighted.'
,p_version_identifier=>'5.0.1'
,p_files_version=>3
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23646965265023311)
,p_plugin_id=>wwv_flow_api.id(23646610262023310)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Date Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'DATE:TIMESTAMP:TIMESTAMP_TZ:TIMESTAMP_LTZ'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query which holds the single date value for the calendar.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(23647340820023311)
,p_plugin_id=>wwv_flow_api.id(23646610262023310)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Label Column'
,p_attribute_type=>'REGION SOURCE COLUMN'
,p_is_required=>true
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the column from the region SQL Query which holds the label for the calendar.'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7461626C652E617065782D6D696E692D63616C656E6461727B77696474683A313030257D0D0A7461626C652E617065782D6D696E692D63616C656E6461722063617074696F6E7B6261636B67726F756E642D636F6C6F723A236563663166393B6261636B';
wwv_flow_api.g_varchar2_table(2) := '67726F756E642D696D6167653A2D7765626B69742D6772616469656E74286C696E6561722C203530252030252C2035302520313030252C20636F6C6F722D73746F702830252C2023663266356639292C20636F6C6F722D73746F7028313030252C202365';
wwv_flow_api.g_varchar2_table(3) := '636631663929293B6261636B67726F756E642D696D6167653A2D7765626B69742D6C696E6561722D6772616469656E7428236632663566392C23656366316639293B6261636B67726F756E642D696D6167653A2D6D6F7A2D6C696E6561722D6772616469';
wwv_flow_api.g_varchar2_table(4) := '656E7428236632663566392C23656366316639293B6261636B67726F756E642D696D6167653A6C696E6561722D6772616469656E7428236632663566392C23656366316639293B666F6E742D73697A653A313270783B666F6E742D7765696768743A626F';
wwv_flow_api.g_varchar2_table(5) := '6C643B636F6C6F723A233430343034303B636F6C6F723A7267626128302C302C302C302E3735293B746578742D736861646F773A302031707820302072676261283235352C3235352C3235352C302E3735293B70616464696E673A387078203870782030';
wwv_flow_api.g_varchar2_table(6) := '203870783B746578742D616C69676E3A63656E7465723B2D7765626B69742D626F782D736861646F773A302031707820302072676261283235352C3235352C3235352C302E36352920696E7365743B2D6D6F7A2D626F782D736861646F773A3020317078';
wwv_flow_api.g_varchar2_table(7) := '20302072676261283235352C3235352C3235352C302E36352920696E7365743B626F782D736861646F773A302031707820302072676261283235352C3235352C3235352C302E36352920696E7365747D0D0A7461626C652E617065782D6D696E692D6361';
wwv_flow_api.g_varchar2_table(8) := '6C656E6461722074686561642074687B6261636B67726F756E642D636F6C6F723A236537656466393B6261636B67726F756E642D696D6167653A2D7765626B69742D6772616469656E74286C696E6561722C203530252030252C2035302520313030252C';
wwv_flow_api.g_varchar2_table(9) := '20636F6C6F722D73746F702830252C2023656366316639292C20636F6C6F722D73746F7028313030252C202365376564663929293B6261636B67726F756E642D696D6167653A2D7765626B69742D6C696E6561722D6772616469656E7428236563663166';
wwv_flow_api.g_varchar2_table(10) := '392C23653765646639293B6261636B67726F756E642D696D6167653A2D6D6F7A2D6C696E6561722D6772616469656E7428236563663166392C23653765646639293B6261636B67726F756E642D696D6167653A6C696E6561722D6772616469656E742823';
wwv_flow_api.g_varchar2_table(11) := '6563663166392C23653765646639293B666F6E742D73697A653A313070783B666F6E742D7765696768743A626F6C643B636F6C6F723A233630363036303B636F6C6F723A7267626128302C302C302C302E35293B70616464696E673A3470783B74657874';
wwv_flow_api.g_varchar2_table(12) := '2D736861646F773A302031707820302072676261283235352C3235352C3235352C302E35293B626F726465722D626F74746F6D3A31707820736F6C696420236230626463637D0D0A7461626C652E617065782D6D696E692D63616C656E6461722074626F';
wwv_flow_api.g_varchar2_table(13) := '64792074722074647B77696474683A3134253B6261636B67726F756E643A6E6F6E6520236661666166613B746578742D616C69676E3A63656E7465723B626F726465722D626F74746F6D3A31707820736F6C696420236538653865383B6C696E652D6865';
wwv_flow_api.g_varchar2_table(14) := '696768743A323470783B636F6C6F723A233430343034303B666F6E742D73697A653A313170783B666F6E742D7765696768743A6E6F726D616C3B706F736974696F6E3A72656C61746976657D0D0A7461626C652E617065782D6D696E692D63616C656E64';
wwv_flow_api.g_varchar2_table(15) := '61722074626F64792074722074643A6C6173742D6368696C647B626F726465722D72696768743A6E6F6E657D0D0A7461626C652E617065782D6D696E692D63616C656E6461722074626F64792074722074642E696E6163746976657B6261636B67726F75';
wwv_flow_api.g_varchar2_table(16) := '6E642D636F6C6F723A234630463046303B636F6C6F723A234330433043303B666F6E742D7765696768743A6E6F726D616C7D0D0A7461626C652E617065782D6D696E692D63616C656E6461722074626F64792074722074642E7765656B656E647B636F6C';
wwv_flow_api.g_varchar2_table(17) := '6F723A233730373037303B6261636B67726F756E642D636F6C6F723A234631463446397D0D0A7461626C652E617065782D6D696E692D63616C656E6461722074626F64792074722074642E746F6461797B666F6E742D7765696768743A626F6C647D0D0A';
wwv_flow_api.g_varchar2_table(18) := '7461626C652E617065782D6D696E692D63616C656E6461722074626F64792074722074642E616374697665207370616E7B646973706C61793A626C6F636B3B6D617267696E3A3370783B666F6E742D73697A653A313170783B6C696E652D686569676874';
wwv_flow_api.g_varchar2_table(19) := '3A313670783B6261636B67726F756E642D636F6C6F723A234645453439433B626F726465722D7261646975733A3370783B626F726465723A31707820736F6C696420236363623336383B666F6E742D7765696768743A626F6C643B2D7765626B69742D62';
wwv_flow_api.g_varchar2_table(20) := '6F782D736861646F773A302031707820302072676261283235352C3235352C3235352C302E36352920696E7365743B2D6D6F7A2D626F782D736861646F773A302031707820302072676261283235352C3235352C3235352C302E36352920696E7365743B';
wwv_flow_api.g_varchar2_table(21) := '626F782D736861646F773A302031707820302072676261283235352C3235352C3235352C302E36352920696E7365747D0D0A7461626C652E617065782D6D696E692D63616C656E6461722074626F64792074723A6C6173742D6368696C642074647B626F';
wwv_flow_api.g_varchar2_table(22) := '726465722D626F74746F6D3A6E6F6E657D0D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(23647778436023312)
,p_plugin_id=>wwv_flow_api.id(23646610262023310)
,p_file_name=>'com_oracle_apex_minicalendar.css'
,p_mime_type=>'text/css'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_api.create_user_interface(
 p_id=>wwv_flow_api.id(16244399291317993)
,p_ui_type_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_seq=>10
,p_use_auto_detect=>false
,p_is_default=>true
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:1:&SESSION.'
,p_login_url=>'f?p=&APP_ID.:LOGIN_DESKTOP:&SESSION.'
,p_navigation_list_id=>wwv_flow_api.id(16202135626317875)
,p_navigation_list_position=>'TOP'
,p_navigation_list_template_id=>wwv_flow_api.id(16235864890317962)
,p_nav_list_template_options=>'#DEFAULT#'
,p_css_file_urls=>'#IMAGE_PREFIX#pkgapp_ui/css/5.0#MIN#.css'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_api.id(16244279352317992)
,p_nav_bar_list_template_id=>wwv_flow_api.id(16236424497317963)
,p_nav_bar_template_options=>'#DEFAULT#'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_api.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Home'
,p_page_mode=>'NORMAL'
,p_step_title=>'Home'
,p_step_sub_title=>'Home'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150820222849'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16246135755318035)
,p_plug_name=>'Check List App'
,p_icon_css_classes=>'app-checklist-manager'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(19088598430612035)
,p_plug_name=>'Card Dashboard'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Cards--featured:t-Cards--displayIcons:t-Cards--4cols:t-Cards--desc-2ln:t-Cards--colorize'
,p_plug_template=>wwv_flow_api.id(16210264139317931)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(19250538347221932)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(16232070186317959)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00009
begin
wwv_flow_api.create_page(
 p_id=>9
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Datacube EVM MAIN'
,p_page_mode=>'NORMAL'
,p_step_title=>'Datacube EVM MAIN'
,p_step_sub_title=>'Datacube EVM MAIN'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150805133825'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(19088654521612036)
,p_plug_name=>'Data Cube'
,p_icon_css_classes=>'fa-cubes'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(19161139820380750)
,p_plug_name=>'Datacube EVM MAIN'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16217862042317938)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select "Reporting Period",',
'       "Source File Type",',
'       "Projection Period",',
'       "Deal Code",',
'       "Reporting Fund Num",',
'       "Product Code",',
'       "LOB Code",',
'       "Variable Code",',
'       "Reinsurance Code",',
'       "EVM Non Std Definition Code",',
'       "Run Type Code",',
'       "Step Type Code",',
'       "Basis Layer",',
'       "Asset Manager",',
'       "Amount_YTD",',
'       "AOS_Diff"',
'  from DATACUBE_EVM_MAIN_NEW'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(19161280769380750)
,p_name=>'Datacube EVM MAIN'
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'No data found.'
,p_max_rows_per_page=>'15'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'ADMIN'
,p_internal_uid=>19161280769380750
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19161606614380756)
,p_db_column_name=>'Reporting Period'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Reporting Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19162040014380757)
,p_db_column_name=>'Source File Type'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Source File Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19162472587380757)
,p_db_column_name=>'Projection Period'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Projection Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19162873821380758)
,p_db_column_name=>'Deal Code'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Deal Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19163299147380758)
,p_db_column_name=>'Reporting Fund Num'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Reporting Fund Num'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19163613249380758)
,p_db_column_name=>'Product Code'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Product Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19164087927380759)
,p_db_column_name=>'LOB Code'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Lob Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19164494822380759)
,p_db_column_name=>'Variable Code'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Variable Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19164852925380759)
,p_db_column_name=>'Reinsurance Code'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Reinsurance Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19165254519380760)
,p_db_column_name=>'EVM Non Std Definition Code'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Evm Non Std Definition Code'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19165675292380760)
,p_db_column_name=>'Run Type Code'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Run Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19166013532380760)
,p_db_column_name=>'Step Type Code'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Step Type'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19166479446380760)
,p_db_column_name=>'Basis Layer'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Basis Layer'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19166842811380761)
,p_db_column_name=>'Asset Manager'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Asset Manager'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19167239185380761)
,p_db_column_name=>'Amount_YTD'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Amount Ytd'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(19167681967380761)
,p_db_column_name=>'AOS_Diff'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Aos Diff'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(19168049573392493)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'191681'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'Reporting Period:Source File Type:Projection Period:Deal Code:Reporting Fund Num:Product Code:LOB Code:Variable Code:Reinsurance Code:EVM Non Std Definition Code:Run Type Code:Step Type Code:Basis Layer:Asset Manager:Amount_YTD:AOS_Diff'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(19087791030612027)
,p_name=>'StripeReport'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(19161139820380750)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(19087805928612028)
,p_event_id=>wwv_flow_api.id(19087791030612027)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_COM.ORACLE.APEX.STRIPE.REPORT'
,p_attribute_01=>'#F0F6F9'
,p_stop_execution_on_error=>'Y'
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Checklist Page All Sections'
,p_page_mode=>'NORMAL'
,p_step_title=>'Checklist Page All Sections'
,p_step_sub_title=>'Checklist Page All Sections'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_javascript_code_onload=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'/*',
'$(document).ready(function(){',
'    $("#id_bc").click(function(){',
'        alert("Value: " + $("#P10_SECTION_CATEGORY").val());',
'    });',
'});',
'*/'))
,p_inline_css=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'.important {',
'  font-weight: bold;',
'  font-size: xx-large;',
'}',
'',
'.blue {',
'  color: blue;',
'}',
'',
'span[data-number^="1"]{color:red;}'))
,p_step_template=>wwv_flow_api.id(16202248223317889)
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150821100939'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20800373528768304)
,p_name=>'EV Main/CF PY'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,ev_mn_new',
'    ,ev_mn_old',
'    ,evmn_new_old_diff',
'    ,ev_cf_new',
'    ,ev_cf_old',
'    ,evcf_new_old_diff',
'    ,decode(evmn_new_old_diff,0,null,1) hld1',
'    ,decode(evcf_new_old_diff,0,null,1) hld2',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2013-12''',
'  and coalesce(ev_mn_new,ev_mn_old,ev_cf_new,ev_cf_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'1:2:3:4:5:6:7:8:9:10:11'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 1 then ''Source File'' ',
'when 2 then ''Run Type'' ',
'when 3 then ''Reporting Period'' ',
'when 4 then ''Source File'' ',
'when 5 then ''Deal Code'' ',
'when 6 then ''Deal Code'' ',
'when 7 then ''Govt Fixed(KF)'' ',
'when 8 then ''Public Equities(KF)'' ',
'when 9 then ''Basis Layer'' ',
'when 10 then ''Variable Count'' ',
'when 11 then ''EVM Non STD Def'' ',
'else ''Generic''  end ',
'||'':EV Main New:EV Main Old:New Old Diff:EV CF New:EV CF OLD:CF New Old Diff'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>500000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20802946448768670)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_column_heading=>'Section metrics'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20800621560768595)
,p_query_column_id=>2
,p_column_alias=>'EV_MN_NEW'
,p_column_display_sequence=>2
,p_column_heading=>'Ev mn new'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20801091156768668)
,p_query_column_id=>3
,p_column_alias=>'EV_MN_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Ev mn old'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20801323124768669)
,p_query_column_id=>4
,p_column_alias=>'EVMN_NEW_OLD_DIFF'
,p_column_display_sequence=>4
,p_column_heading=>'Evmn new old diff'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD1#">#EVMN_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20801765458768669)
,p_query_column_id=>5
,p_column_alias=>'EV_CF_NEW'
,p_column_display_sequence=>5
,p_column_heading=>'Ev cf new'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20802108471768669)
,p_query_column_id=>6
,p_column_alias=>'EV_CF_OLD'
,p_column_display_sequence=>6
,p_column_heading=>'Ev cf old'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20802521267768669)
,p_query_column_id=>7
,p_column_alias=>'EVCF_NEW_OLD_DIFF'
,p_column_display_sequence=>7
,p_column_heading=>'Evcf new old diff'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD2#">#EVCF_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25248271095954421)
,p_query_column_id=>8
,p_column_alias=>'HLD1'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25248323888954422)
,p_query_column_id=>9
,p_column_alias=>'HLD2'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20803375622768672)
,p_name=>'EVM Main/CF PY'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,evm_mn_new',
'    ,evm_mn_old',
'    ,evmmn_new_old_diff',
'    ,evm_cf_new',
'    ,evm_cf_old',
'    ,evmcf_new_old_diff',
'    ,decode(evmmn_new_old_diff,0,null,1) hld1',
'    ,decode(evmcf_new_old_diff,0,null,1) hld2',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2013-12''',
'  and coalesce(evm_mn_new,evm_mn_old,evm_cf_new,evm_cf_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'1:2:3:4:5:6:7:8:9:10:11'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 1 then ''Source File'' ',
'when 2 then ''Run Type'' ',
'when 3 then ''Reporting Period'' ',
'when 4 then ''Source File'' ',
'when 5 then ''Deal Code'' ',
'when 6 then ''Deal Code'' ',
'when 7 then ''Govt Fixed(KF)'' ',
'when 8 then ''Public Equities(KF)'' ',
'when 9 then ''Basis Layer'' ',
'when 10 then ''Variable Count'' ',
'when 11 then ''EVM Non STD Def''  ',
'else ''Generic''  end ',
'||'':EVM Main New:EVM Main Old:New Old Diff:EVM CF New:EVM CF Old:CF New Old Diff'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>500000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20804109208768673)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20803748826768673)
,p_query_column_id=>2
,p_column_alias=>'EVM_MN_NEW'
,p_column_display_sequence=>2
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20804519047768673)
,p_query_column_id=>3
,p_column_alias=>'EVM_MN_OLD'
,p_column_display_sequence=>3
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20804922451768676)
,p_query_column_id=>4
,p_column_alias=>'EVMMN_NEW_OLD_DIFF'
,p_column_display_sequence=>4
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD1#">#EVMMN_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20805397692768676)
,p_query_column_id=>5
,p_column_alias=>'EVM_CF_NEW'
,p_column_display_sequence=>5
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20805745465768677)
,p_query_column_id=>6
,p_column_alias=>'EVM_CF_OLD'
,p_column_display_sequence=>6
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20806151441768677)
,p_query_column_id=>7
,p_column_alias=>'EVMCF_NEW_OLD_DIFF'
,p_column_display_sequence=>7
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD2#">#EVMCF_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25247480799954413)
,p_query_column_id=>8
,p_column_alias=>'HLD1'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25247578832954414)
,p_query_column_id=>9
,p_column_alias=>'HLD2'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20806927903768678)
,p_name=>'USGAAP/LOSSREC PY'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,usgaap_mn_new ',
'    ,usgaap_mn_old',
'    ,usgaap_new_old_diff',
'    ,lossrec_mn_new',
'    ,lossrec_mn_old',
'    ,lossrec_new_old_diff',
'    ,decode(usgaap_new_old_diff,0,null,1) hld1',
'    ,decode(lossrec_new_old_diff,0,null,1) hld2',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2013-12''',
'  and coalesce(usgaap_mn_new,usgaap_mn_old,lossrec_mn_new,lossrec_mn_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'1:2:3:4:5:6:7:8:9:10:11'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 1 then ''Source File'' ',
'when 2 then ''Run Type'' ',
'when 3 then ''Reporting Period'' ',
'when 4 then ''Source File'' ',
'when 5 then ''Deal Code'' ',
'when 6 then ''Deal Code'' ',
'when 7 then ''Govt Fixed(KF)'' ',
'when 8 then ''Public Equities(KF)'' ',
'when 9 then ''Basis Layer'' ',
'when 10 then ''Variable Count'' ',
'when 11 then ''EVM Non STD Def'' ',
'else ''Generic''  end ',
'||'':USGAAP Main New:USGAAP Main Old:New Old Diff:LOSSREC Main New:LOSSREC Main OLD:CF New Old Diff'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>500000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20809759842768692)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_column_heading=>'Section metrics'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20807303413768678)
,p_query_column_id=>2
,p_column_alias=>'USGAAP_MN_NEW'
,p_column_display_sequence=>2
,p_column_heading=>'Usgaap mn new'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20807783256768678)
,p_query_column_id=>3
,p_column_alias=>'USGAAP_MN_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Usgaap mn old'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20808120878768679)
,p_query_column_id=>4
,p_column_alias=>'USGAAP_NEW_OLD_DIFF'
,p_column_display_sequence=>4
,p_column_heading=>'Usgaap new old diff'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD1#">#USGAAP_NEW_OLD_DIFF# </span> '
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20808575576768681)
,p_query_column_id=>5
,p_column_alias=>'LOSSREC_MN_NEW'
,p_column_display_sequence=>5
,p_column_heading=>'Lossrec mn new'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20808974986768681)
,p_query_column_id=>6
,p_column_alias=>'LOSSREC_MN_OLD'
,p_column_display_sequence=>6
,p_column_heading=>'Lossrec mn old'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20809386556768692)
,p_query_column_id=>7
,p_column_alias=>'LOSSREC_NEW_OLD_DIFF'
,p_column_display_sequence=>7
,p_column_heading=>'Lossrec new old diff'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD2#">#LOSSREC_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25247874595954417)
,p_query_column_id=>8
,p_column_alias=>'HLD1'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25247999283954418)
,p_query_column_id=>9
,p_column_alias=>'HLD2'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20810961970768830)
,p_name=>'EVM MAIN/CF'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,evm_mn_new',
'    ,evm_mn_old',
'    ,evmmn_new_old_diff',
'    ,evm_cf_new',
'    ,evm_cf_old',
'    ,evmcf_new_old_diff',
'    ,decode(evmmn_new_old_diff,0,null,1) hld1',
'    ,decode(evmcf_new_old_diff,0,null,1) hld2',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2014-12''',
'  and coalesce(evm_mn_new,evm_mn_old,evm_cf_new,evm_cf_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'1:2:3:4:5:6:7:8:9:10:11'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 1 then ''Source File'' ',
'when 2 then ''Run Type'' ',
'when 3 then ''Reporting Period'' ',
'when 4 then ''Source File'' ',
'when 5 then ''Deal Code'' ',
'when 6 then ''Deal Code'' ',
'when 7 then ''Govt Fixed(KF)'' ',
'when 8 then ''Public Equities(KF)'' ',
'when 9 then ''Basis Layer'' ',
'when 10 then ''Variable Count'' ',
'when 11 then ''EVM Non STD Def''',
'else ''Generic''  end ',
'||'':EVM Main New:EVM Main Old:New Old Diff:EVM CF New:EVM CF Old:CF New Old Diff'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>20
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_prn_output_show_link=>'Y'
,p_prn_output_link_text=>'Print'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width_units=>'PERCENTAGE'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#ffffff'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#487ECF'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20811222356768833)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20811686558768833)
,p_query_column_id=>2
,p_column_alias=>'EVM_MN_NEW'
,p_column_display_sequence=>2
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20812080493768833)
,p_query_column_id=>3
,p_column_alias=>'EVM_MN_OLD'
,p_column_display_sequence=>3
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20812473880768833)
,p_query_column_id=>4
,p_column_alias=>'EVMMN_NEW_OLD_DIFF'
,p_column_display_sequence=>4
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD1#">#EVMMN_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20812854923768833)
,p_query_column_id=>5
,p_column_alias=>'EVM_CF_NEW'
,p_column_display_sequence=>5
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20813275633768834)
,p_query_column_id=>6
,p_column_alias=>'EVM_CF_OLD'
,p_column_display_sequence=>6
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20813603609768834)
,p_query_column_id=>7
,p_column_alias=>'EVMCF_NEW_OLD_DIFF'
,p_column_display_sequence=>7
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD2#">#EVMCF_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25247284258954411)
,p_query_column_id=>8
,p_column_alias=>'HLD1'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25247302289954412)
,p_query_column_id=>9
,p_column_alias=>'HLD2'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20814005951768834)
,p_name=>'USGAAP/LOSSREC'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,usgaap_mn_new',
'    ,usgaap_mn_old',
'    ,usgaap_new_old_diff',
'    ,lossrec_mn_new',
'    ,lossrec_mn_old',
'    ,lossrec_new_old_diff',
'    ,decode(usgaap_new_old_diff,0,null,1) hld1',
'    ,decode(lossrec_new_old_diff,0,null,1) hld2',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2014-12''',
'  and coalesce(usgaap_mn_new,usgaap_mn_old,lossrec_mn_new,lossrec_mn_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'1:2:3:4:5:6:7:8:9:10:11'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 1 then ''Source File'' ',
'when 2 then ''Run Type'' ',
'when 3 then ''Reporting Period'' ',
'when 4 then ''Source File'' ',
'when 5 then ''Deal Code'' ',
'when 6 then ''Deal Code'' ',
'when 7 then ''Govt Fixed(KF)'' ',
'when 8 then ''Public Equities(KF)'' ',
'when 9 then ''Basis Layer'' ',
'when 10 then ''Variable Count'' ',
'when 11 then ''EVM Non STD Def''',
'else ''Generic''  end ',
'||'':USGAAP Main New:USGAAP Main Old:New Old Diff:LOSSREC Main New:LOSSREC Main OLD:CF New Old Diff'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>500000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20816724896769091)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20814402661768834)
,p_query_column_id=>2
,p_column_alias=>'USGAAP_MN_NEW'
,p_column_display_sequence=>2
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20814837382768834)
,p_query_column_id=>3
,p_column_alias=>'USGAAP_MN_OLD'
,p_column_display_sequence=>3
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20815294625769090)
,p_query_column_id=>4
,p_column_alias=>'USGAAP_NEW_OLD_DIFF'
,p_column_display_sequence=>4
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD1#">#USGAAP_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20815506446769090)
,p_query_column_id=>5
,p_column_alias=>'LOSSREC_MN_NEW'
,p_column_display_sequence=>5
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20815969147769091)
,p_query_column_id=>6
,p_column_alias=>'LOSSREC_MN_OLD'
,p_column_display_sequence=>6
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20816381131769091)
,p_query_column_id=>7
,p_column_alias=>'LOSSREC_NEW_OLD_DIFF'
,p_column_display_sequence=>7
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD2#">#LOSSREC_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25247669053954415)
,p_query_column_id=>8
,p_column_alias=>'HLD1'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25247779574954416)
,p_query_column_id=>9
,p_column_alias=>'HLD2'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20817183305769092)
,p_plug_name=>'ChecklistNavi'
,p_region_name=>'id_navlist'
,p_component_template_options=>'#DEFAULT#'
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_02'
,p_list_id=>wwv_flow_api.id(20792097848739820)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(16234188221317960)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20819936282769162)
,p_plug_name=>'Selector'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(16220423538317943)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_translate_title=>'N'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20820218371769163)
,p_name=>'EV Main/CF'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,ev_mn_new',
'    ,ev_mn_old',
'    ,evmn_new_old_diff',
'    ,ev_cf_new',
'    ,ev_cf_old',
'    ,evcf_new_old_diff',
'    ,decode(evmn_new_old_diff,0,null,1) hld1',
'    ,decode(evcf_new_old_diff,0,null,1) hld2',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2014-12''',
'  and coalesce(ev_mn_new,ev_mn_old,ev_cf_new,ev_cf_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'1:2:3:4:5:6:7:8:9:10:11'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 1 then ''Source File'' ',
'when 2 then ''Run Type'' ',
'when 3 then ''Reporting Period'' ',
'when 4 then ''Source File'' ',
'when 5 then ''Deal Code'' ',
'when 6 then ''Deal Code'' ',
'when 7 then ''Govt Fixed(KF)'' ',
'when 8 then ''Public Equities(KF)'' ',
'when 9 then ''Basis Layer'' ',
'when 10 then ''Variable Count'' ',
'when 11 then ''EVM Non STD Def''  ',
'else ''Generic''  end ',
'||'':EV Main New:EV Main Old:New Old Diff:EV CF New:EV CF OLD:CF New Old Diff'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>500000
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
end;
/
begin
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20823069954769166)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_column_heading=>'Section metrics'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20820615252769163)
,p_query_column_id=>2
,p_column_alias=>'EV_MN_NEW'
,p_column_display_sequence=>2
,p_column_heading=>'Ev mn new'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20821039828769164)
,p_query_column_id=>3
,p_column_alias=>'EV_MN_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Ev mn old'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20821422127769164)
,p_query_column_id=>4
,p_column_alias=>'EVMN_NEW_OLD_DIFF'
,p_column_display_sequence=>4
,p_column_heading=>'Evmn new old diff'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD1#">#EVMN_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20821898574769164)
,p_query_column_id=>5
,p_column_alias=>'EV_CF_NEW'
,p_column_display_sequence=>5
,p_column_heading=>'Ev cf new'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20822205818769166)
,p_query_column_id=>6
,p_column_alias=>'EV_CF_OLD'
,p_column_display_sequence=>6
,p_column_heading=>'Ev cf old'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20822672356769166)
,p_query_column_id=>7
,p_column_alias=>'EVCF_NEW_OLD_DIFF'
,p_column_display_sequence=>7
,p_column_heading=>'Evcf new old diff'
,p_use_as_row_header=>'N'
,p_column_format=>'999G999G999G999G999G990'
,p_column_html_expression=>'<span data-number="#HLD2#">#EVCF_NEW_OLD_DIFF# </span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_report_column_width=>150
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25248029887954419)
,p_query_column_id=>8
,p_column_alias=>'HLD1'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25248183610954420)
,p_query_column_id=>9
,p_column_alias=>'HLD2'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20828082669812601)
,p_plug_name=>'&P10_SECTION_CATEGORY.'
,p_region_name=>'id_bc'
,p_icon_css_classes=>'fa-check-square-o'
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20828169389812602)
,p_name=>'EVM Main/CF'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,evm_mn_new_appearance',
'    ,evm_mn_drop_from_old',
'    ,evm_cf_new_appearance',
'    ,evm_cf_drop_from_old',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2014-12''',
'  and coalesce(evm_mn_new_appearance',
'    ,evm_mn_drop_from_old',
'    ,evm_cf_new_appearance',
'    ,evm_cf_drop_from_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'12:13'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 12 then ''Projection Period'' ',
'when 13 then ''Variable Code'' ',
'else ''Generic''  end ',
'||'':EVM Main New Appearance:EVM Main Drop From Old:EVM CashFlow New Appearance:EVM CashFlow Drop From Old'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20828282036812603)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20828911927812610)
,p_query_column_id=>2
,p_column_alias=>'EVM_MN_NEW_APPEARANCE'
,p_column_display_sequence=>2
,p_column_heading=>'Evm mn new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20829058164812611)
,p_query_column_id=>3
,p_column_alias=>'EVM_MN_DROP_FROM_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Evm mn drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20829171774812612)
,p_query_column_id=>4
,p_column_alias=>'EVM_CF_NEW_APPEARANCE'
,p_column_display_sequence=>4
,p_column_heading=>'Evm cf new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20829211868812613)
,p_query_column_id=>5
,p_column_alias=>'EVM_CF_DROP_FROM_OLD'
,p_column_display_sequence=>5
,p_column_heading=>'Evm cf drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20829319259812614)
,p_name=>'EVM Main/CF PY'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,evm_mn_new_appearance',
'    ,evm_mn_drop_from_old',
'    ,evm_cf_new_appearance',
'    ,evm_cf_drop_from_old',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2013-12''',
'  and coalesce(evm_mn_new_appearance',
'    ,evm_mn_drop_from_old',
'    ,evm_cf_new_appearance',
'    ,evm_cf_drop_from_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'12:13'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 12 then ''Projection Period'' ',
'when 13 then ''Variable Code'' ',
'else ''Generic''  end ',
'||'':EVM Main New Appearance:EVM Main Drop From Old:EVM CashFlow New Appearance:EVM CashFlow Drop From Old'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20829418768812615)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20829559547812616)
,p_query_column_id=>2
,p_column_alias=>'EVM_MN_NEW_APPEARANCE'
,p_column_display_sequence=>2
,p_column_heading=>'Evm mn new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20829617055812617)
,p_query_column_id=>3
,p_column_alias=>'EVM_MN_DROP_FROM_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Evm mn drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20829798300812618)
,p_query_column_id=>4
,p_column_alias=>'EVM_CF_NEW_APPEARANCE'
,p_column_display_sequence=>4
,p_column_heading=>'Evm cf new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20829872698812619)
,p_query_column_id=>5
,p_column_alias=>'EVM_CF_DROP_FROM_OLD'
,p_column_display_sequence=>5
,p_column_heading=>'Evm cf drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20829906569812620)
,p_name=>'USGAAP/LOSSREC'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,usgaap_mn_new_appearance',
'    ,usgaap_mn_drop_from_old',
'    ,lossrec_mn_new_appearance',
'    ,lossrec_mn_drop_from_old',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2014-12''',
'  and coalesce(',
'    usgaap_mn_new_appearance',
'    ,usgaap_mn_drop_from_old',
'    ,lossrec_mn_new_appearance',
'    ,lossrec_mn_drop_from_old',
'    ) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'12:13'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 12 then ''Projection Period'' ',
'when 13 then ''Variable Code'' ',
'else ''Generic''  end ',
'||'':USGAAP Main New Appearance:USGAAP Main Drop From Old:LOSSREC MAIN New Appearance:LOSSREC MAIN Drop From Old'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20830042906812621)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20830563396812626)
,p_query_column_id=>2
,p_column_alias=>'USGAAP_MN_NEW_APPEARANCE'
,p_column_display_sequence=>2
,p_column_heading=>'Usgaap mn new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20830686468812627)
,p_query_column_id=>3
,p_column_alias=>'USGAAP_MN_DROP_FROM_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Usgaap mn drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20830714283812628)
,p_query_column_id=>4
,p_column_alias=>'LOSSREC_MN_NEW_APPEARANCE'
,p_column_display_sequence=>4
,p_column_heading=>'Lossrec mn new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20830847314812629)
,p_query_column_id=>5
,p_column_alias=>'LOSSREC_MN_DROP_FROM_OLD'
,p_column_display_sequence=>5
,p_column_heading=>'Lossrec mn drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20830990906812630)
,p_name=>'USGAAP/LOSSREC PY'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,usgaap_mn_new_appearance',
'    ,usgaap_mn_drop_from_old',
'    ,lossrec_mn_new_appearance',
'    ,lossrec_mn_drop_from_old',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2013-12''',
'  and coalesce(',
'    usgaap_mn_new_appearance',
'    ,usgaap_mn_drop_from_old',
'    ,lossrec_mn_new_appearance',
'    ,lossrec_mn_drop_from_old',
'    ) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'12:13'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 12 then ''Projection Period'' ',
'when 13 then ''Variable Code'' ',
'else ''Generic''  end ',
'||'':USGAAP Main New Appearance:USGAAP Main Drop From Old:LOSSREC MAIN New Appearance:LOSSREC MAIN Drop From Old'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20831030276812631)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20831114520812632)
,p_query_column_id=>2
,p_column_alias=>'USGAAP_MN_NEW_APPEARANCE'
,p_column_display_sequence=>2
,p_column_heading=>'Usgaap mn new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20831263511812633)
,p_query_column_id=>3
,p_column_alias=>'USGAAP_MN_DROP_FROM_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Usgaap mn drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20831306863812634)
,p_query_column_id=>4
,p_column_alias=>'LOSSREC_MN_NEW_APPEARANCE'
,p_column_display_sequence=>4
,p_column_heading=>'Lossrec mn new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20831467985812635)
,p_query_column_id=>5
,p_column_alias=>'LOSSREC_MN_DROP_FROM_OLD'
,p_column_display_sequence=>5
,p_column_heading=>'Lossrec mn drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20831582795812636)
,p_name=>'EV Main/CF'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,ev_mn_new_appearance',
'    ,ev_mn_drop_from_old',
'    ,ev_cf_new_appearance',
'    ,ev_cf_drop_from_old',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2014-12''',
'  and coalesce(ev_mn_new_appearance',
'    ,ev_mn_drop_from_old',
'    ,ev_cf_new_appearance',
'    ,ev_cf_drop_from_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'12:13'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 12 then ''Projection Period'' ',
'when 13 then ''Variable Code'' ',
'else ''Generic''  end ',
'||'':EV Main New Appearance:EV Main Drop From Old:EV CashFlow New Appearance:EV CashFlow Drop From Old'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20831696560812637)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20832156660812642)
,p_query_column_id=>2
,p_column_alias=>'EV_MN_NEW_APPEARANCE'
,p_column_display_sequence=>2
,p_column_heading=>'Ev mn new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20832268906812643)
,p_query_column_id=>3
,p_column_alias=>'EV_MN_DROP_FROM_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Ev mn drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20832398805812644)
,p_query_column_id=>4
,p_column_alias=>'EV_CF_NEW_APPEARANCE'
,p_column_display_sequence=>4
,p_column_heading=>'Ev cf new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20832431832812645)
,p_query_column_id=>5
,p_column_alias=>'EV_CF_DROP_FROM_OLD'
,p_column_display_sequence=>5
,p_column_heading=>'Ev cf drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(20832547171812646)
,p_name=>'EV Main/CF PY'
,p_template=>wwv_flow_api.id(16217862042317938)
,p_display_sequence=>150
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select ',
'    section_metrics',
'    ,ev_mn_new_appearance',
'    ,ev_mn_drop_from_old',
'    ,ev_cf_new_appearance',
'    ,ev_cf_drop_from_old',
'from mvams_cube_checklist_data',
'where ',
'  report_section = :P10_SECTION_ID',
'  and reporting_period = ''2013-12''',
'  and coalesce(ev_mn_new_appearance',
'    ,ev_mn_drop_from_old',
'    ,ev_cf_new_appearance',
'    ,ev_cf_drop_from_old) is not null'))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_display_when_condition=>'P10_SECTION_ID'
,p_display_when_cond2=>'12:13'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_headings=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'return case v(''P10_SECTION_ID'') ',
'when 12 then ''Projection Period'' ',
'when 13 then ''Variable Code'' ',
'else ''Generic''  end ',
'||'':EV Main New Appearance:EV Main Drop From Old:EV CashFlow New Appearance:EV CashFlow Drop From Old'''))
,p_query_headings_type=>'FUNCTION_BODY_RETURNING_COLON_DELIMITED_LIST'
,p_query_num_rows=>10
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'&NO_DATA_FOUND_MSG.'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20832692102812647)
,p_query_column_id=>1
,p_column_alias=>'SECTION_METRICS'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_report_column_width=>160
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'14'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20832743491812648)
,p_query_column_id=>2
,p_column_alias=>'EV_MN_NEW_APPEARANCE'
,p_column_display_sequence=>2
,p_column_heading=>'Ev mn new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20832875623812649)
,p_query_column_id=>3
,p_column_alias=>'EV_MN_DROP_FROM_OLD'
,p_column_display_sequence=>3
,p_column_heading=>'Ev mn drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20832971322812650)
,p_query_column_id=>4
,p_column_alias=>'EV_CF_NEW_APPEARANCE'
,p_column_display_sequence=>4
,p_column_heading=>'Ev cf new appearance'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(20867648798110801)
,p_query_column_id=>5
,p_column_alias=>'EV_CF_DROP_FROM_OLD'
,p_column_display_sequence=>5
,p_column_heading=>'Ev cf drop from old'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20871003722110835)
,p_plug_name=>'Cube Versions'
,p_region_template_options=>'#DEFAULT#:t-Alert--wizard:t-Alert--defaultIcons:t-Alert--info'
,p_plug_template=>wwv_flow_api.id(16208747833317918)
,p_plug_display_sequence=>160
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20871940600110844)
,p_plug_name=>'CubeDetails-Tooltip'
,p_parent_plug_id=>wwv_flow_api.id(20871003722110835)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select',
'    ''fa-cube'' icon',
'    , cube_type',
'    , ''Previous Cube Name = ''||rpad(regexp_substr(old_cube_name,''\.(.*)\@'',1,1,null,1),28) pcn',
'    , to_date(regexp_substr(old_cube_name,''[0-9]+'')||''2015'',''ddmmyyyy'') "Old Cube Date"',
'    , to_date(regexp_substr(new_cube_name,''[0-9]+'')||''2015'',''ddmmyyyy'') "New Cube Date"',
'    , insby "Refresh By"',
'    , description "Issue# Fixed"',
'    --, regexp_substr(old_cube_name,''\.(.*)\@'',1,1,null,1) "Old Cube"',
'    --, regexp_substr(new_cube_name,''\.(.*)\@'',1,1,null,1) "New cube"',
'from tams_checklist_cubes where current_ind=1'))
,p_plug_source_type=>'PLUGIN_COM_ORACLE_APEX_SLIDETOOLTIP'
,p_plug_query_row_template=>1
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'ICON'
,p_attribute_02=>'CUBE_TYPE'
,p_attribute_03=>'PCN'
,p_attribute_04=>'tooltip'
,p_attribute_05=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RP:P12_CUBE_TYPE,P12_CURRENT_IND:&CUBE_TYPE.,1'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(25033483159843003)
,p_name=>'ICON'
,p_data_type=>'ICON'
,p_is_visible=>true
,p_display_sequence=>20
,p_heading=>'Icon'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(25035334828843022)
,p_name=>'Refresh By'
,p_data_type=>'Refresh By'
,p_is_visible=>true
,p_display_sequence=>50
,p_heading=>'Refresh by'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(25248553431954424)
,p_name=>'PCN'
,p_data_type=>'PCN'
,p_is_visible=>true
,p_display_sequence=>70
,p_heading=>'Pcn'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(25248846726954427)
,p_name=>'CUBE_TYPE'
,p_data_type=>'CUBE_TYPE'
,p_is_visible=>true
,p_display_sequence=>80
,p_heading=>'Cube type'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(25248959501954428)
,p_name=>'Old Cube Date'
,p_data_type=>'Old Cube Date'
,p_is_visible=>true
,p_display_sequence=>30
,p_heading=>'Old cube date'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(25249077786954429)
,p_name=>'New Cube Date'
,p_data_type=>'New Cube Date'
,p_is_visible=>true
,p_display_sequence=>40
,p_heading=>'New cube date'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(25249103758954430)
,p_name=>'Issue# Fixed'
,p_data_type=>'Issue# Fixed'
,p_is_visible=>true
,p_display_sequence=>90
,p_heading=>'Issue# fixed'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(20810505561768693)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(20828082669812601)
,p_button_name=>'REFRESHCHECKLISTDATA_B'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(16239202992317970)
,p_button_image_alt=>'PrepareChecklist'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:20'
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(20817548398769092)
,p_name=>'P10_SECTION_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(20817183305769092)
,p_item_default=>'1'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(20817976760769132)
,p_name=>'P10_CHECKLIST_REFRESH_TS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(20817183305769092)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(20818315728769133)
,p_name=>'P10_SECTION_CATEGORY'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(20817183305769092)
,p_item_default=>'Record Count By Source File Type'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(20824113818769192)
,p_computation_sequence=>10
,p_computation_item=>'P10_CHECKLIST_REFRESH_TS'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select to_char(last_refresh,''DD Mon YYYY HH24:MI'') refresh_dt from user_mview_refresh_times where name=''MVAMS_CUBE_CHECKLIST_DATA'''
);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_api.create_page(
 p_id=>11
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'ChecklistCubeDetails'
,p_page_mode=>'NORMAL'
,p_step_title=>'ChecklistCubeDetails'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150810160131'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(25104369981461698)
,p_name=>'ChecklistCubeDetails'
,p_template=>wwv_flow_api.id(16218364978317939)
,p_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select "CUBE_TYPE", ',
'regexp_substr(old_cube_name,''\.(.*)\@'',1,1,null,1) "Old Cube",',
'regexp_substr(new_cube_name,''\.(.*)\@'',1,1,null,1) "New cube",',
'"WORK_LOG"',
'from "#OWNER#"."TAMS_CHECKLIST_CUBES" ',
' where current_ind=1 ',
'  ',
''))
,p_source_type=>'NATIVE_SQL_REPORT'
,p_ajax_enabled=>'N'
,p_query_row_template=>wwv_flow_api.id(16227141617317951)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'no data found'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_query_row_count_max=>500
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25035553970843024)
,p_query_column_id=>1
,p_column_alias=>'CUBE_TYPE'
,p_column_display_sequence=>1
,p_column_heading=>'Cube type'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25036586675843034)
,p_query_column_id=>2
,p_column_alias=>'Old Cube'
,p_column_display_sequence=>3
,p_column_heading=>'Old cube'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25036686530843035)
,p_query_column_id=>3
,p_column_alias=>'New cube'
,p_column_display_sequence=>4
,p_column_heading=>'New cube'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(25035934451843028)
,p_query_column_id=>4
,p_column_alias=>'WORK_LOG'
,p_column_display_sequence=>2
,p_column_heading=>'Work log'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_api.create_page(
 p_id=>12
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'ChecklistCubeDetailsForm'
,p_page_mode=>'MODAL'
,p_step_title=>'Add Checklist Description'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_step_template=>wwv_flow_api.id(16206283707317913)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'300'
,p_dialog_attributes=>'resizable:true'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_protection_level=>'C'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150813130136'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25097559585461685)
,p_plug_name=>'Add Checklist Description'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16210399753317931)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(25098059946461686)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(25097559585461685)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(16239148892317970)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:::'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(25097910362461686)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(25097559585461685)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(16239148892317970)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition=>'P12_CUBE_TYPE'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_grid=>false
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(25098854112461686)
,p_branch_name=>'Go To Page 11'
,p_branch_action=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(25099214819461690)
,p_name=>'P12_CUBE_TYPE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(25097559585461685)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cube Type'
,p_source=>'CUBE_TYPE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(25099640475461692)
,p_name=>'P12_CURRENT_IND'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(25097559585461685)
,p_use_cache_before_default=>'NO'
,p_source=>'CURRENT_IND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(25100076046461692)
,p_name=>'P12_OLD_CUBE_NAME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(25097559585461685)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Old Cube Name'
,p_source=>'OLD_CUBE_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(25100452230461693)
,p_name=>'P12_NEW_CUBE_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(25097559585461685)
,p_use_cache_before_default=>'NO'
,p_prompt=>'New Cube Name'
,p_source=>'NEW_CUBE_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(25100855060461693)
,p_name=>'P12_DESCRIPTION'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(25097559585461685)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Description'
,p_source=>'DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>500
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(25102827773461695)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from TAMS_CHECKLIST_CUBES'
,p_attribute_02=>'TAMS_CHECKLIST_CUBES'
,p_attribute_03=>'P12_CUBE_TYPE'
,p_attribute_04=>'CUBE_TYPE'
,p_attribute_05=>'P12_CURRENT_IND'
,p_attribute_06=>'CURRENT_IND'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(25103289694461695)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of TAMS_CHECKLIST_CUBES'
,p_attribute_02=>'TAMS_CHECKLIST_CUBES'
,p_attribute_03=>'P12_CUBE_TYPE'
,p_attribute_04=>'CUBE_TYPE'
,p_attribute_05=>'P12_CURRENT_IND'
,p_attribute_06=>'CURRENT_IND'
,p_attribute_11=>'U'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(25103664463461696)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_00020
begin
wwv_flow_api.create_page(
 p_id=>20
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'PrepareChecklist'
,p_page_mode=>'NORMAL'
,p_step_title=>'PrepareChecklist'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_javascript_code_onload=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'$(document).ready(function(){',
'    $("#id_button").click(function(){',
'        $(this).attr("disabled", "disabled");',
'    });',
'});'))
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(32063248862243228)
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150817125551'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(19233015298027265)
,p_plug_name=>'PrepareChecklist'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(19240742043027292)
,p_plug_name=>'Prepare Checklist'
,p_icon_css_classes=>'fa-edit'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(19233566925027268)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(19233015298027265)
,p_button_name=>'SUBMIT'
,p_button_static_id=>'id_button'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(16239202992317970)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Prepare CheckList data'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_icon_css_classes=>'fa-edit'
,p_security_scheme=>wwv_flow_api.id(32063248862243228)
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(19233468086027268)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(19233015298027265)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(16239148892317970)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(19239958244027285)
,p_branch_name=>'Go To Page 30'
,p_branch_action=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.:RP:P30_REFRESH_TIME:#TIMING#&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(19233566925027268)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19234385336027276)
,p_name=>'P20_OLD_EVM_MAIN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'Old Evm Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EVM_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19234712288027277)
,p_name=>'P20_NEW_EVM_MAIN'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'New Evm Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EVM_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19235188752027277)
,p_name=>'P20_OLD_EVM_CF'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'Old Evm Cashflow'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EVM_CF_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19235549941027278)
,p_name=>'P20_NEW_EVM_CF'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'New Evm Cashflow'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EVM_CF_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19235975674027278)
,p_name=>'P20_OLD_USGAAP_MAIN'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'Old Usgaap Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_USGAAP_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_USGAAP_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19236366848027278)
,p_name=>'P20_NEW_USGAAP_MAIN'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'New Usgaap Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_USGAAP_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_USGAAP_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19236723183027278)
,p_name=>'P20_OLD_LOSSREC_MAIN'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'Old Lossrec Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_LOSSREC_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_LOSSREC_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19237126574027279)
,p_name=>'P20_NEW_LOSSREC_MAIN'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'New Lossrec Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_LOSSREC_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_LOSSREC_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19237575475027279)
,p_name=>'P20_OLD_EV_MAIN'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'Old Ev Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EV_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19237990989027280)
,p_name=>'P20_NEW_EV_MAIN'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'New Ev Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EV_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19238343736027280)
,p_name=>'P20_OLD_EV_CF'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'Old Ev Cashflow'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EV_CF_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19238768684027280)
,p_name=>'P20_NEW_EV_CF'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_prompt=>'New Ev Cashflow'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EV_CF_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(19239197074027280)
,p_name=>'P20_MESSAGE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_source=>'select :app_user from dual;'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(32330383537859704)
,p_name=>'P20_IS_SUBMITTED'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(19233015298027265)
,p_use_cache_before_default=>'NO'
,p_item_default=>'0'
,p_source=>'0'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20869827340110823)
,p_validation_name=>'OLD_EVM_MAIN'
,p_validation_sequence=>10
,p_validation=>'P20_OLD_EVM_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of Old EVM Main cube name'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19234385336027276)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20869946098110824)
,p_validation_name=>'New'
,p_validation_sequence=>20
,p_validation=>'P20_NEW_EVM_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of New EVM Main cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19234712288027277)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870093878110825)
,p_validation_name=>'New_1'
,p_validation_sequence=>30
,p_validation=>'P20_OLD_EVM_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of OLD EVM CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19235188752027277)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870113078110826)
,p_validation_name=>'New_2'
,p_validation_sequence=>40
,p_validation=>'P20_NEW_EVM_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of New EVM CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19235549941027278)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870299086110827)
,p_validation_name=>'New_3'
,p_validation_sequence=>50
,p_validation=>'P20_OLD_USGAAP_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old USGAAP cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19235975674027278)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870333122110828)
,p_validation_name=>'New_4'
,p_validation_sequence=>60
,p_validation=>'P20_NEW_USGAAP_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of new USGAAP cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19236366848027278)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870433313110829)
,p_validation_name=>'New_5'
,p_validation_sequence=>70
,p_validation=>'P20_OLD_LOSSREC_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old LOSSREC cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19236723183027278)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870521473110830)
,p_validation_name=>'New_6'
,p_validation_sequence=>80
,p_validation=>'P20_NEW_LOSSREC_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of new LOSSREC cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19237126574027279)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870668142110831)
,p_validation_name=>'New_7'
,p_validation_sequence=>90
,p_validation=>'P20_OLD_EV_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old EV Main cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19237575475027279)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870795252110832)
,p_validation_name=>'New_8'
,p_validation_sequence=>100
,p_validation=>'P20_NEW_EV_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of New EV Main cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19237990989027280)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870819350110833)
,p_validation_name=>'New_9'
,p_validation_sequence=>110
,p_validation=>'P20_OLD_EV_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old EV CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19238343736027280)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(20870995051110834)
,p_validation_name=>'New_10'
,p_validation_sequence=>120
,p_validation=>'P20_NEW_EV_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of New EV CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(19238768684027280)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(19239537259027281)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Run Stored Procedure'
,p_process_sql_clob=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#OWNER#.PA_MANAGE_CUBE_CHECKLIST.PREPARE_CHECKLIST_DATA(',
'I_OLD_EVM_MAIN_CUBE => :P20_OLD_EVM_MAIN,',
'I_NEW_EVM_MAIN_CUBE => :P20_NEW_EVM_MAIN,',
'I_OLD_EVM_CF_CUBE => :P20_OLD_EVM_CF,',
'I_NEW_EVM_CF_CUBE => :P20_NEW_EVM_CF,',
'I_OLD_USGAAP_MAIN_CUBE => :P20_OLD_USGAAP_MAIN,',
'I_NEW_USGAAP_MAIN_CUBE => :P20_NEW_USGAAP_MAIN,',
'I_OLD_LOSSREC_MAIN_CUBE => :P20_OLD_LOSSREC_MAIN,',
'I_NEW_LOSSREC_MAIN_CUBE => :P20_NEW_LOSSREC_MAIN,',
'I_OLD_EV_MAIN_CUBE => :P20_OLD_EV_MAIN,',
'I_NEW_EV_MAIN_CUBE => :P20_NEW_EV_MAIN,',
'I_OLD_EV_CF_CUBE => :P20_OLD_EV_CF,',
'I_NEW_EV_CF_CUBE => :P20_NEW_EV_CF,',
'i_app_user       => :app_user,',
'o_return_message => :P30_RETURN_STATUS,',
'O_ERROR_MESSAGE =>  :P30_SQL_ERR_MSG',
')'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(19233566925027268)
,p_process_when_type=>'NOT_DISPLAYING_INLINE_VALIDATION_ERRORS'
);
end;
/
prompt --application/pages/page_00030
begin
wwv_flow_api.create_page(
 p_id=>30
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'ChecklistPrepareStatus'
,p_page_mode=>'NORMAL'
,p_step_title=>'ChecklistPrepareStatus'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150811114220'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25033800068843007)
,p_plug_name=>'Success'
,p_region_template_options=>'t-Alert--wizard:t-Alert--defaultIcons:t-Alert--success'
,p_plug_template=>wwv_flow_api.id(16208747833317918)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>'&P30_RETURN_STATUS.'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NULL'
,p_plug_display_when_condition=>'P30_SQL_ERR_MSG'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25033962917843008)
,p_plug_name=>'Failure'
,p_region_template_options=>'#DEFAULT#:t-Alert--wizard:t-Alert--defaultIcons:t-Alert--danger'
,p_plug_template=>wwv_flow_api.id(16208747833317918)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Error encountered during checklist preparation. <br>',
'&P30_SQL_ERR_MSG.'))
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P30_SQL_ERR_MSG'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25054577455998292)
,p_plug_name=>'Preparation Status'
,p_icon_css_classes=>'fa-dot-circle-o'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(25034663152843015)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(25054577455998292)
,p_button_name=>'Review_Selected_Cubes'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(16239202992317970)
,p_button_image_alt=>'Review selected cubes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:RP::'
,p_icon_css_classes=>'fa-angle-double-left'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(25034701727843016)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(25054577455998292)
,p_button_name=>'ViewChecklist'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(16239202992317970)
,p_button_image_alt=>'View Checklist'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP::'
,p_icon_css_classes=>'fa-angle-double-right'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(25034059218843009)
,p_name=>'P30_RETURN_STATUS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(25054577455998292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(25034133573843010)
,p_name=>'P30_SQL_ERR_MSG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(25054577455998292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(25034294248843011)
,p_name=>'P30_REFRESH_TIME'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(25054577455998292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
end;
/
prompt --application/pages/page_00040
begin
wwv_flow_api.create_page(
 p_id=>40
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Dashboard'
,p_page_mode=>'NORMAL'
,p_step_title=>'Dashboard'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150902102544'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20867998849110804)
,p_plug_name=>'Total Amount For Deals FA13 - BubbleChart'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(16214611855317934)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select',
'   rownum as id',
'  ,"Deal Code" as label',
'  ,"Deal Code" as colorgrp',
'  ,abs(TOTAL_AMOUNT) as bbsize',
'  ,"Deal Code"||'' Total Amount: ''||to_char(TOTAL_AMOUNT,''FML999G999G999G999G990D00'') description',
'from MV_CUBE_CHECKLIST_TEMP ',
'where "Deal Code" is not null ',
'and reporting_period =''2013-12''',
'and cube_name=''DATACUBE_EVM_MAIN_NEW'''))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.D3.BUBBLE'
,p_plug_query_row_template=>1
,p_plug_query_num_rows=>100
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_02=>'MODERN'
,p_attribute_12=>'LABEL'
,p_attribute_13=>'BBSIZE'
,p_attribute_14=>'ID'
,p_attribute_15=>'COLORGRP'
,p_attribute_19=>'SERIES:CUSTOM'
,p_attribute_20=>'DESCRIPTION'
,p_attribute_22=>'300'
,p_attribute_23=>'TOP'
,p_attribute_24=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'{',
'  "trdur":                       500,',
'  "bubble_padding":              1.5,',
'  "opacity_normal":              "0.8",',
'  "opacity_highlight":           "1.0",',
'  "circle_highlight_radiusplus": 5 ',
'}'))
,p_attribute_25=>'D3ASCENDING'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20868544529110810)
,p_plug_name=>'Public Equities Movement'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16214611855317934)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select  "Variable Code" KF_ACCOUNT',
'  ,to_date("Projection Period",''yyyy-mm'') PROJECTION_PERIOD  ',
'  ,Sum("Amount") TOTAL_AMOUNT',
'from DATACUBE_EVM_CASHFLOW_NEW',
'where ',
'    "Variable Code" in',
'    (',
'        ''1045100''',
'        ,''1045190''',
'        ,''1045200''',
'        ,''1045290''',
'        ,''1046100''',
'        ,''1046190''',
'        ,''1046200''',
'        ,''1046290''',
'    )',
'and "Asset Manager"<>''SRAM''',
'and "LOB Code"=''80''',
'and "Reporting Fund Num"=6',
'and "Reporting Period"=''2014-12''',
'and "Aggregation Method"=''QUARTERLY''',
'group by "Variable Code", "Projection Period"',
'order by 1,2'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.D3.LINE'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'PROJECTION_PERIOD'
,p_attribute_02=>'TOTAL_AMOUNT'
,p_attribute_03=>'Projection Period'
,p_attribute_04=>'Total Amount'
,p_attribute_05=>'DATE'
,p_attribute_06=>'%e %b %Y'
,p_attribute_08=>'linear'
,p_attribute_09=>'CHART'
,p_attribute_10=>',.0f'
,p_attribute_13=>'MODERN'
,p_attribute_15=>'KF_ACCOUNT'
,p_attribute_16=>'SERIES:X:Y:CUSTOM'
,p_attribute_20=>'OVERLAP'
,p_attribute_21=>'X:Y'
,p_attribute_23=>'KF_ACCOUNT'
,p_attribute_25=>'BOTTOM'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(23575152500555799)
,p_plug_name=>'Breadcrumb'
,p_icon_css_classes=>'fa-desktop'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32331872102859719)
,p_plug_name=>'Deal Code Pie Chart'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_FLASH_CHART5'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_flash_chart5(
 p_id=>wwv_flow_api.id(32331911096859720)
,p_default_chart_type=>'3DPie'
,p_chart_title=>'Deal Code Pie Chart'
,p_chart_rendering=>'FLASH_PREFERRED'
,p_chart_width=>1000
,p_chart_height=>500
,p_display_attr=>':H:N:V:::Left::H::None::N:N:::::::'
,p_dial_tick_attr=>':::::::::::'
,p_gantt_attr=>':::::::::::::::::::'
,p_pie_attr=>'Outside:::'
,p_map_attr=>':::N:N:Series:::::'
,p_margins=>':::'
, p_omit_label_interval=> null
,p_bgtype=>'Trans'
,p_grid_gradient_rotation=>0
,p_color_scheme=>'0'
,p_custom_colors=>'#FF3B30,#FFCC00,#4CD964,#34AADC,#5856D6,#FF2D55,#C7C7CC,#FE2E64,#2ECCFA'
,p_x_axis_label_font=>'::'
,p_y_axis_label_font=>'::'
,p_async_update=>'N'
, p_names_font=> null
, p_names_rotation=> null
,p_values_font=>'Tahoma:10:#3D393D'
,p_hints_font=>'Tahoma:10:#3D393D'
,p_legend_font=>'Tahoma:10:#3D393D'
,p_chart_title_font=>'Tahoma:14:NAVY'
,p_x_axis_title_font=>'::'
,p_y_axis_title_font=>'::'
,p_gauge_labels_font=>'::'
,p_use_chart_xml=>'N'
);
wwv_flow_api.create_flash_chart5_series(
 p_id=>wwv_flow_api.id(32332002230859721)
,p_chart_id=>wwv_flow_api.id(32331911096859720)
,p_series_seq=>10
,p_series_name=>'New'
,p_series_query=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select null',
'  ,section_metrics "Deal Code"',
'  ,evm_mn_new',
'from MVAMS_CUBE_CHECKLIST_DATA ',
'where report_section=5 ',
'and reporting_period =''2013-12''',
'order by evm_mn_new desc'))
,p_series_query_type=>'SQL_QUERY'
,p_series_query_parse_opt=>'PARSE_CHART_QUERY'
,p_series_query_row_count_max=>300
,p_show_action_link=>'N'
);
end;
/
prompt --application/pages/page_00050
begin
wwv_flow_api.create_page(
 p_id=>50
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Reports and Charts'
,p_page_mode=>'NORMAL'
,p_step_title=>'Reports and Charts'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150806121506'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20868658164110811)
,p_plug_name=>'Summary Reports'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY_3'
,p_list_id=>wwv_flow_api.id(23653281558266698)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20868734710110812)
,p_plug_name=>'Demo Charts'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY_3'
,p_list_id=>wwv_flow_api.id(23657872137283068)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(16234966380317961)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(23652410015246228)
,p_plug_name=>'Breadcrumb'
,p_icon_css_classes=>'fa-book'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00060
begin
wwv_flow_api.create_page(
 p_id=>60
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Bubble Chart'
,p_page_mode=>'NORMAL'
,p_step_title=>'Bubble Chart'
,p_step_sub_title=>'Bubble Chart'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150806153028'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(23664153993460273)
,p_plug_name=>'Breadcrumb'
,p_icon_css_classes=>'fa-cloud'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(23664518488460274)
,p_plug_name=>'Total Amount For Deals FA13 - BubbleChart'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hiddenOverflow'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select',
'   rownum as id',
'  ,"Deal Code" as label',
'  ,"Deal Code" as colorgrp',
'  ,abs(TOTAL_AMOUNT) as bbsize',
'  ,"Deal Code"||'' Total Amount: ''||to_char(TOTAL_AMOUNT,''FML999G999G999G999G990D00'') description',
'from MV_CUBE_CHECKLIST_TEMP ',
'where "Deal Code" is not null ',
'and reporting_period =''2013-12''',
'and cube_name=''DATACUBE_EVM_MAIN_NEW'''))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.D3.BUBBLE'
,p_plug_query_row_template=>1
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_02=>'MODERN'
,p_attribute_12=>'LABEL'
,p_attribute_13=>'BBSIZE'
,p_attribute_14=>'ID'
,p_attribute_15=>'COLORGRP'
,p_attribute_19=>'CUSTOM'
,p_attribute_20=>'DESCRIPTION'
,p_attribute_23=>'BOTTOM'
,p_attribute_24=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'{',
'  "trdur":                       500,',
'  "bubble_padding":              1.5,',
'  "opacity_normal":              "0.8",',
'  "opacity_highlight":           "1.0",',
'  "circle_highlight_radiusplus": 5 ',
'}'))
,p_attribute_25=>'D3ASCENDING'
);
end;
/
prompt --application/pages/page_00070
begin
wwv_flow_api.create_page(
 p_id=>70
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Line Chart'
,p_page_mode=>'NORMAL'
,p_step_title=>'Line Chart'
,p_step_sub_title=>'Line Chart'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150806121759'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20868855356110813)
,p_plug_name=>'Line Chart'
,p_icon_css_classes=>'fa-stumbleupon'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(23666829310474066)
,p_plug_name=>'Line Chart - Public Equities GL accounts FA14'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select  "Variable Code" KF_ACCOUNT',
'  ,to_date("Projection Period",''yyyy-mm'') PROJECTION_PERIOD  ',
'  ,Sum("Amount") TOTAL_AMOUNT',
'from DATACUBE_EVM_CASHFLOW_NEW',
'where ',
'    "Variable Code" in',
'    (',
'        ''1045100''',
'        ,''1045190''',
'        ,''1045200''',
'        ,''1045290''',
'        ,''1046100''',
'        ,''1046190''',
'        ,''1046200''',
'        ,''1046290''',
'    )',
'and "Asset Manager"<>''SRAM''',
'and "LOB Code"=''80''',
'and "Reporting Fund Num"=6',
'and "Reporting Period"=''2014-12''',
'and "Aggregation Method"=''QUARTERLY''',
'group by "Variable Code", "Projection Period"',
'order by 1,2'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.D3.LINE'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'PROJECTION_PERIOD'
,p_attribute_02=>'TOTAL_AMOUNT'
,p_attribute_03=>'Projection Period'
,p_attribute_04=>'Total Amount'
,p_attribute_05=>'DATE'
,p_attribute_06=>'%e %b %Y'
,p_attribute_08=>'linear'
,p_attribute_09=>'CHART'
,p_attribute_10=>',.0f'
,p_attribute_13=>'MODERN'
,p_attribute_15=>'KF_ACCOUNT'
,p_attribute_16=>'SERIES:X:Y:CUSTOM'
,p_attribute_20=>'OVERLAP'
,p_attribute_21=>'X:Y'
,p_attribute_23=>'KF_ACCOUNT'
,p_attribute_25=>'BOTTOM'
);
end;
/
prompt --application/pages/page_00100
begin
wwv_flow_api.create_page(
 p_id=>100
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Help'
,p_page_mode=>'NORMAL'
,p_step_title=>'Help'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150817103129'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32330024733859701)
,p_plug_name=>'AboutThisApp'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<h2>About this Application</h2>',
'<p>Application is mainly for preparing and viewing the pre-publish checklist. Checklist preparation functionality can only be carried out by ADMIN user. Rest all users can only view the checklist</p>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32330110578859702)
,p_plug_name=>'GettngStarted'
,p_parent_plug_id=>wwv_flow_api.id(32330024733859701)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16210264139317931)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<H2>Getting Started</h2>',
'<p>Home page contains links for following functionalities</p>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32330254208859703)
,p_plug_name=>'Functionalities'
,p_parent_plug_id=>wwv_flow_api.id(32330024733859701)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16210264139317931)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'<h2>Functionalities</h2>',
'<p>',
'<ul>',
'<li>Prepare checklist : Only ADMIN user can perform this activity. After clicking this link, user will be navigated to a new screen where old and new version cubes needs to be selected from the drop down menu. After selection of old/new cubes "Prepar'
||'e Checklist" button needs to be clicked and application will scan through all cubes and collect required stastics in a summary table. View checklist action will query data from this table to display data in matrix format</li>',
'<li>View Checklist : All users are allowed to view the checklist. After clicking this link user will be navigated to the checklist screen. Checklist screen is organised in row and column format. ',
'<ul>',
'<li> Column Data(Horizonal top menu) : All cube data are arranged horizontally in seven tab format. </li>',
'<ol>',
'    <li>EVM MAIN/CF : Contains EVM MAIN and EVM CASHFLOW data for current reporting period.</li>',
'    <li>EVM MAIN/CF PY: Contains EVM MAIN and EVM CASHFLOW data for previous reporting period.</li>',
'    <li>USGAAP MAIN/LOSSREC : Contains USGAAP MAIN and LOSSREC MAIN data for current reporting period.</li>',
'    <li>USGAAP MAIN/LOSSREC PY: Contains USGAAP MAIN and LOSSREC MAIN for previous reporting period.</li>  ',
'    <li>EV MAIN/CF : Contains EV MAIN and EV CASHFLOW data for current reporting period.</li>',
'    <li>EV MAIN/CF PY: Contains EV MAIN and EV CASHFLOW for previous reporting period.</li> ',
'    <li>Cube Versions : Contains detail information about all cubes.</li>',
'    </ol>',
'<li> Row Data(Left side Pane menu) : Row headings provide links to the corresponding cube data in horizontal regions. </li>',
'</ul>',
' </li>',
'<li>EVM Main Cube : Provides link to view the draft version of EVM Main cube data. ',
'    Also provides provisions for applying filters to view select portion of cube data. Returned data can be sorted in scending/descending order. List of columns that needs to be displayed can also be configured. Data can be downloaded t csv format fo'
||'r manual processing.</li>',
'<li>EVM CF Cube :Provides link to view the draft version of EVM Cashflow cube data.',
'    Also provides provisions for applying filters to view select portion of cube data. Returned data can be sorted in scending/descending order. List of columns that needs to be displayed can also be configured. Data can be downloaded t csv format fo'
||'r manual processing</li>',
'<li>USGAAP MAIN Cube :Provides link to view the draft version of USGAAP MAIN cube data.',
'    Also provides provisions for applying filters to view select portion of cube data. Returned data can be sorted in scending/descending order. List of columns that needs to be displayed can also be configured. Data can be downloaded t csv format fo'
||'r manual processing </li>',
'<li>LOSSREC MAIN Cube :Provides link to view the draft version of LOSSREC MAIN cube data.',
'    Also provides provisions for applying filters to view select portion of cube data. Returned data can be sorted in scending/descending order. List of columns that needs to be displayed can also be configured. Data can be downloaded t csv format fo'
||'r manual processing</li>',
'<li>EV Main Cube : Provides link to view the draft version of EV Main cube data. ',
'    Also provides provisions for applying filters to view select portion of cube data. Returned data can be sorted in scending/descending order. List of columns that needs to be displayed can also be configured. Data can be downloaded t csv format fo'
||'r manual processing.</li>',
'<li>EV CF Cube :Provides link to view the draft version of EV Cashflow cube data.',
'    Also provides provisions for applying filters to view select portion of cube data. Returned data can be sorted in scending/descending order. List of columns that needs to be displayed can also be configured. Data can be downloaded t csv format fo'
||'r manual processing</li>',
'</ul>',
'</p>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_api.create_page(
 p_id=>101
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Login Page'
,p_alias=>'LOGIN_DESKTOP'
,p_page_mode=>'NORMAL'
,p_step_title=>'Pre-publish Cube Checklist - Log In'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_api.id(16204139811317908)
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'Y'
,p_cache_mode=>'NOCACHE'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150915141723'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(16244801397318025)
,p_plug_name=>'<b>Cube Checklist App<b>'
,p_icon_css_classes=>'app-checklist-manager'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16218120342317939)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16245157406318029)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(16244801397318025)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(16239148892317970)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'REGION_TEMPLATE_NEXT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16244922741318028)
,p_name=>'P101_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(16244801397318025)
,p_prompt=>'Username'
,p_placeholder=>'Enter User Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(16238552273317966)
,p_item_css_classes=>'icon-login-username'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(16245041535318029)
,p_name=>'P101_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(16244801397318025)
,p_item_default=>'Password'
,p_prompt=>'Password'
,p_placeholder=>'Enter Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(16238552273317966)
,p_item_css_classes=>'icon-login-password'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16245371072318030)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P101_USERNAME) );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16245271237318030)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P101_USERNAME,',
'    p_password => :P101_PASSWORD );'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16245525981318030)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16245479003318030)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>':P101_USERNAME := apex_authentication.get_login_username_cookie;'
);
end;
/
prompt --application/pages/page_00110
begin
wwv_flow_api.create_page(
 p_id=>110
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'EVM Main'
,p_page_mode=>'NORMAL'
,p_step_title=>'EVM Main'
,p_step_sub_title=>'EVM Main'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_html_page_header=>'test123'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150820111842'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25176840074794578)
,p_plug_name=>'EVM Main'
,p_icon_css_classes=>'fa-cubes'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25177463410794579)
,p_plug_name=>'EVM Main'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16217862042317938)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select "Reporting Period",',
'       "Source File Type",',
'       "Unmodelled Version Id",',
'       "Projection Period",',
'       "Reinsurer Legal Entity Code",',
'       "Company Code",',
'       "Deal Code",',
'       "Reporting Fund Num",',
'       "Product Code",',
'       "LOB Code",',
'       "Variable Code",',
'       "Variable Field Name and Type",',
'       "Reinsurance Code",',
'       "Replicating Instrument Code",',
'       "EVM Non Std Definition Code",',
'       "Tax Fund Code",',
'       "Run Type Code",',
'       "Step Type Code",',
'       "Basis Layer",',
'       "Asset Manager",',
'       "Suspended Flag",',
'       "Amount_YTD",',
'       "AOS_Diff"',
'  from DATACUBE_EVM_MAIN_NEW'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_output_show_link=>'Y'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_plug_caching=>'SESSION'
,p_plug_caching_max_age_in_sec=>21600
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(25177543400794579)
,p_name=>'EVM Main'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_max_rows_per_page=>'10'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:XLS'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="Edit">'
,p_owner=>'ADMIN'
,p_internal_uid=>25177543400794579
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25177930163794585)
,p_db_column_name=>'Reporting Period'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Reporting Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25178315378794589)
,p_db_column_name=>'Source File Type'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Source File Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25178711180794589)
,p_db_column_name=>'Unmodelled Version Id'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Unmodelled Ver'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25179148556794590)
,p_db_column_name=>'Projection Period'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Projection Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25179560089794590)
,p_db_column_name=>'Reinsurer Legal Entity Code'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Reinsurer Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25179921339794590)
,p_db_column_name=>'Company Code'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Company Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25180329108794591)
,p_db_column_name=>'Deal Code'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Deal Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25180789653794591)
,p_db_column_name=>'Reporting Fund Num'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Reporting Fund Num'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25181130121794591)
,p_db_column_name=>'Product Code'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Product Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25181591294794592)
,p_db_column_name=>'LOB Code'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Lob Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25181970151794592)
,p_db_column_name=>'Variable Code'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Variable Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25182349266794593)
,p_db_column_name=>'Variable Field Name and Type'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Variable Name/Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25182705676794593)
,p_db_column_name=>'Reinsurance Code'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Reinsurance Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25183134792794593)
,p_db_column_name=>'Replicating Instrument Code'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Replicating Ins Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25183573753794594)
,p_db_column_name=>'EVM Non Std Definition Code'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Evm Non Std Def'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25183916752794594)
,p_db_column_name=>'Tax Fund Code'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Tax Fund Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25184357808794594)
,p_db_column_name=>'Run Type Code'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Run Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25184787279794595)
,p_db_column_name=>'Step Type Code'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Step Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25185100233794595)
,p_db_column_name=>'Basis Layer'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Basis Layer'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25185590221794595)
,p_db_column_name=>'Asset Manager'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Asset Manager'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25185991431794595)
,p_db_column_name=>'Suspended Flag'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Suspended Flag'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25186363241794596)
,p_db_column_name=>'Amount_YTD'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Amount Ytd'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25186717527794596)
,p_db_column_name=>'AOS_Diff'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Aos Diff'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(25187167226796855)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'251872'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'Reporting Period:Source File Type:Unmodelled Version Id:Projection Period:Reinsurer Legal Entity Code:Company Code:Deal Code:Reporting Fund Num:Product Code:LOB Code:Variable Code:Variable Field Name and Type:Reinsurance Code:Replicating Instrument C'
||'ode:EVM Non Std Definition Code:Tax Fund Code:Run Type Code:Step Type Code:Basis Layer:Asset Manager:Suspended Flag:Amount_YTD:AOS_Diff'
,p_flashback_enabled=>'N'
);
end;
/
prompt --application/pages/page_00120
begin
wwv_flow_api.create_page(
 p_id=>120
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Datacube EVM Cashflow'
,p_page_mode=>'NORMAL'
,p_step_title=>'Datacube EVM Cashflow'
,p_step_sub_title=>'Datacube EVM Cashflow'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150820111916'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25247109355954410)
,p_plug_name=>'EVM Cashflow'
,p_icon_css_classes=>'fa-cubes'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25271040464139708)
,p_plug_name=>'Datacube EVM Cashflow'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16217862042317938)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select "Reporting Period",',
'       "Source File Type",',
'       "Unmodelled Version Id",',
'       "Aggregation Method",',
'       "Projection Period",',
'       "Reinsurer Legal Entity Code",',
'       "Company Code",',
'       "Deal Code",',
'       "Reporting Fund Num",',
'       "Product Code",',
'       "LOB Code",',
'       "Variable Code",',
'       "Variable Field Name and Type",',
'       "Reinsurance Code",',
'       "Replicating Instrument Code",',
'       "EVM Non Std Definition Code",',
'       "Tax Fund Code",',
'       "Run Type Code",',
'       "Step Type Code",',
'       "Basis Layer",',
'       "Asset Manager",',
'       "Suspended Flag",',
'       "Amount"',
'  from DATACUBE_EVM_CASHFLOW_NEW'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_caching=>'SESSION'
,p_plug_caching_max_age_in_sec=>1800
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(25271159482139708)
,p_name=>'Datacube EVM Cashflow'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_max_rows_per_page=>'10'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_download_formats=>'CSV:HTML'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="Edit">'
,p_owner=>'ADMIN'
,p_internal_uid=>25271159482139708
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25271560908139719)
,p_db_column_name=>'Reporting Period'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Reporting Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25271910802139720)
,p_db_column_name=>'Source File Type'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Source File Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25272347497139720)
,p_db_column_name=>'Unmodelled Version Id'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Unmodelled Version Id'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25272760636139721)
,p_db_column_name=>'Aggregation Method'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Aggregation Method'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25273121012139721)
,p_db_column_name=>'Projection Period'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Projection Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25273555830139721)
,p_db_column_name=>'Reinsurer Legal Entity Code'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Reinsurer Legal Entity Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25273968568139721)
,p_db_column_name=>'Company Code'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Company Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25274303687139721)
,p_db_column_name=>'Deal Code'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Deal Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25274713197139722)
,p_db_column_name=>'Reporting Fund Num'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Reporting Fund Num'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25275129835139722)
,p_db_column_name=>'Product Code'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Product Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25275519201139723)
,p_db_column_name=>'LOB Code'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Lob Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25275918019139723)
,p_db_column_name=>'Variable Code'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Variable Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25276360945139725)
,p_db_column_name=>'Variable Field Name and Type'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Variable Field Name And Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25276775330139725)
,p_db_column_name=>'Reinsurance Code'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Reinsurance Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25277154419139725)
,p_db_column_name=>'Replicating Instrument Code'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Replicating Instrument Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25277510055139726)
,p_db_column_name=>'EVM Non Std Definition Code'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Evm Non Std Definition Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25277906554139726)
,p_db_column_name=>'Tax Fund Code'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Tax Fund Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25278368669139726)
,p_db_column_name=>'Run Type Code'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Run Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25278726551139726)
,p_db_column_name=>'Step Type Code'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Step Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25279165942139726)
,p_db_column_name=>'Basis Layer'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Basis Layer'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25279536733139727)
,p_db_column_name=>'Asset Manager'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Asset Manager'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25279916713139727)
,p_db_column_name=>'Suspended Flag'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Suspended Flag'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25280315477139727)
,p_db_column_name=>'Amount'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Amount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(25281836070172257)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'252819'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'Reporting Period:Source File Type:Unmodelled Version Id:Aggregation Method:Projection Period:Reinsurer Legal Entity Code:Company Code:Deal Code:Reporting Fund Num:Product Code:LOB Code:Variable Code:Variable Field Name and Type:Reinsurance Code:Repli'
||'cating Instrument Code:EVM Non Std Definition Code:Tax Fund Code:Run Type Code:Step Type Code:Basis Layer:Asset Manager:Suspended Flag:Amount'
,p_flashback_enabled=>'N'
);
end;
/
prompt --application/pages/page_00130
begin
wwv_flow_api.create_page(
 p_id=>130
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Datacube USGAAP Main'
,p_page_mode=>'NORMAL'
,p_step_title=>'Datacube USGAAP Main'
,p_step_sub_title=>'Datacube USGAAP Main'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150820112333'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(25283861501571834)
,p_plug_name=>'Datacube USGAAP Main'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16210264139317931)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select "Reporting Period",',
'       "Source File Type",',
'       "Unmodelled Version Id",',
'       "Projection Period",',
'       "Reinsurer Legal Entity Code",',
'       "Company Code",',
'       "Deal Code",',
'       "Reporting Fund Num",',
'       "Product Code",',
'       "LOB Code",',
'       "FAS Class Code",',
'       "Variable Code",',
'       "Variable Field Name and Type",',
'       "Reinsurance Code",',
'       "Tax Fund Code",',
'       "Run Type Code",',
'       "Step Type Code",',
'       "Basis Layer",',
'       "Asset Manager",',
'       "Suspended Flag",',
'       "Amount_YTD",',
'       "AOS_Diff"',
'  from DATACUBE_USGAAP_MAIN_NEW'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_caching=>'SESSION'
,p_plug_caching_max_age_in_sec=>3600
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(25283984076571834)
,p_name=>'Datacube USGAAP Main'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_max_rows_per_page=>'10'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_download_formats=>'CSV:HTML'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="Edit">'
,p_owner=>'ADMIN'
,p_internal_uid=>25283984076571834
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25284376306571862)
,p_db_column_name=>'Reporting Period'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Reporting Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25284742719571875)
,p_db_column_name=>'Source File Type'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Source File Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25285152106571875)
,p_db_column_name=>'Unmodelled Version Id'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Unmodelled Version Id'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25285594859571877)
,p_db_column_name=>'Projection Period'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Projection Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25285934826571878)
,p_db_column_name=>'Reinsurer Legal Entity Code'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Reinsurer Legal Entity Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25286342418571879)
,p_db_column_name=>'Company Code'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Company Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25286766705571879)
,p_db_column_name=>'Deal Code'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Deal Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25287151397571882)
,p_db_column_name=>'Reporting Fund Num'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Reporting Fund Num'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25287573300571882)
,p_db_column_name=>'Product Code'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Product Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25287927742571883)
,p_db_column_name=>'LOB Code'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Lob Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25288314383571883)
,p_db_column_name=>'FAS Class Code'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Fas Class Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25288762825571884)
,p_db_column_name=>'Variable Code'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Variable Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25289117378571884)
,p_db_column_name=>'Variable Field Name and Type'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Variable Field Name And Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25289510587571890)
,p_db_column_name=>'Reinsurance Code'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Reinsurance Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25289885423571891)
,p_db_column_name=>'Tax Fund Code'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Tax Fund Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25290246740571892)
,p_db_column_name=>'Run Type Code'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Run Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25290600919571895)
,p_db_column_name=>'Step Type Code'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Step Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25291023402571898)
,p_db_column_name=>'Basis Layer'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Basis Layer'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25291412967571898)
,p_db_column_name=>'Asset Manager'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Asset Manager'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25291871735571899)
,p_db_column_name=>'Suspended Flag'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Suspended Flag'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25292262038571900)
,p_db_column_name=>'Amount_YTD'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Amount Ytd'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(25292632806571900)
,p_db_column_name=>'AOS_Diff'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Aos Diff'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(31985422424638494)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'319855'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'Reporting Period:Source File Type:Unmodelled Version Id:Projection Period:Reinsurer Legal Entity Code:Company Code:Deal Code:Reporting Fund Num:Product Code:LOB Code:FAS Class Code:Variable Code:Variable Field Name and Type:Reinsurance Code:Tax Fund '
||'Code:Run Type Code:Step Type Code:Basis Layer:Asset Manager:Suspended Flag:Amount_YTD:AOS_Diff'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32034849091994501)
,p_plug_name=>'USGAAP Main'
,p_icon_css_classes=>'fa-cubes'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00140
begin
wwv_flow_api.create_page(
 p_id=>140
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Datacube LOSSREC Main'
,p_page_mode=>'NORMAL'
,p_step_title=>'Datacube LOSSREC Main'
,p_step_sub_title=>'Datacube LOSSREC Main'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150820112524'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(31986656991652385)
,p_plug_name=>'Datacube LOSSREC Main'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16217862042317938)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select "Reporting Period",',
'       "Source File Type",',
'       "Unmodelled Version Id",',
'       "Projection Period",',
'       "Reinsurer Legal Entity Code",',
'       "Company Code",',
'       "Deal Code",',
'       "Reporting Fund Num",',
'       "Product Code",',
'       "LOB Code",',
'       "Variable Code",',
'       "Variable Field Name and Type",',
'       "Reinsurance Code",',
'       "Tax Fund Code",',
'       "Run Type Code",',
'       "Step Type Code",',
'       "Basis Layer",',
'       "Asset Manager",',
'       "Suspended Flag",',
'       "Amount_YTD",',
'       "AOS_Diff"',
'  from DATACUBE_LOSSREC_MAIN_NEW'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_footer=>'Total Elapsed Time(Second) = #TIMING#'
,p_plug_caching=>'SESSION'
,p_plug_caching_max_age_in_sec=>3600
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(31986749243652385)
,p_name=>'Datacube LOSSREC Main'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_max_rows_per_page=>'10'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_download_formats=>'CSV:HTML'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="Edit">'
,p_owner=>'ADMIN'
,p_internal_uid=>31986749243652385
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31987166603652393)
,p_db_column_name=>'Reporting Period'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Reporting Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31987546861652396)
,p_db_column_name=>'Source File Type'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Source File Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31987994213652396)
,p_db_column_name=>'Unmodelled Version Id'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Unmodelled Version Id'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31988368631652397)
,p_db_column_name=>'Projection Period'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Projection Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31988739771652397)
,p_db_column_name=>'Reinsurer Legal Entity Code'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Reinsurer Legal Entity Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31989185754652397)
,p_db_column_name=>'Company Code'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Company Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31989575247652397)
,p_db_column_name=>'Deal Code'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Deal Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31989928274652398)
,p_db_column_name=>'Reporting Fund Num'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Reporting Fund Num'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31990390654652398)
,p_db_column_name=>'Product Code'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Product Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31990792885652399)
,p_db_column_name=>'LOB Code'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Lob Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31991105035652401)
,p_db_column_name=>'Variable Code'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Variable Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31991544980652401)
,p_db_column_name=>'Variable Field Name and Type'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Variable Field Name And Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31991962814652401)
,p_db_column_name=>'Reinsurance Code'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Reinsurance Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31992394240652402)
,p_db_column_name=>'Tax Fund Code'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Tax Fund Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31992796075652403)
,p_db_column_name=>'Run Type Code'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Run Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31993190088652403)
,p_db_column_name=>'Step Type Code'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Step Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31993500277652403)
,p_db_column_name=>'Basis Layer'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Basis Layer'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31993955355652403)
,p_db_column_name=>'Asset Manager'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Asset Manager'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31994357489652404)
,p_db_column_name=>'Suspended Flag'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Suspended Flag'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31994737818652404)
,p_db_column_name=>'Amount_YTD'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Amount Ytd'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31995181099652404)
,p_db_column_name=>'AOS_Diff'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Aos Diff'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(31996270433666902)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'319963'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'Reporting Period:Source File Type:Unmodelled Version Id:Projection Period:Reinsurer Legal Entity Code:Company Code:Deal Code:Reporting Fund Num:Product Code:LOB Code:Variable Code:Variable Field Name and Type:Reinsurance Code:Tax Fund Code:Run Type C'
||'ode:Step Type Code:Basis Layer:Asset Manager:Suspended Flag:Amount_YTD:AOS_Diff'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32034962577994502)
,p_plug_name=>'LOSSREC Main'
,p_icon_css_classes=>'fa-cubes'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00150
begin
wwv_flow_api.create_page(
 p_id=>150
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Datacube EV Main'
,p_page_mode=>'NORMAL'
,p_step_title=>'Datacube EV Main'
,p_step_sub_title=>'Datacube EV Main'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'SESSION'
,p_cache_timeout_seconds=>3600
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150820112534'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(31997157354675331)
,p_plug_name=>'Datacube EV Main'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16217862042317938)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select "Reporting Period",',
'       "Source File Type",',
'       "Unmodelled Version Id",',
'       "Projection Period",',
'       "Reinsurer Legal Entity Code",',
'       "Company Code",',
'       "Deal Code",',
'       "Reporting Fund Num",',
'       "Product Code",',
'       "LOB Code",',
'       "Variable Code",',
'       "Variable Field Name and Type",',
'       "Reinsurance Code",',
'       "Tax Fund Code",',
'       "Run Type Code",',
'       "Step Type Code",',
'       "Basis Layer",',
'       "Asset Manager",',
'       "Suspended Flag",',
'       "Amount_YTD",',
'       "AOS_Diff"',
'  from DATACUBE_EV_MAIN_NEW'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_footer=>'Total Elapsed Time(Second) = #TIMING#'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(31997250792675331)
,p_name=>'Datacube EV Main'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_max_rows_per_page=>'10'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_download_formats=>'CSV:HTML'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="Edit">'
,p_owner=>'ADMIN'
,p_internal_uid=>31997250792675331
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31997678247675333)
,p_db_column_name=>'Reporting Period'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Reporting Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31998063035675334)
,p_db_column_name=>'Source File Type'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Source File Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31998450066675334)
,p_db_column_name=>'Unmodelled Version Id'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Unmodelled Version Id'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31998812658675334)
,p_db_column_name=>'Projection Period'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Projection Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31999212176675334)
,p_db_column_name=>'Reinsurer Legal Entity Code'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Reinsurer Legal Entity Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(31999622414675334)
,p_db_column_name=>'Company Code'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Company Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32000044987675335)
,p_db_column_name=>'Deal Code'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Deal Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32000438922675335)
,p_db_column_name=>'Reporting Fund Num'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Reporting Fund Num'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32000899066675335)
,p_db_column_name=>'Product Code'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Product Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32001262648675336)
,p_db_column_name=>'LOB Code'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Lob Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32001693886675336)
,p_db_column_name=>'Variable Code'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Variable Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32002065463675336)
,p_db_column_name=>'Variable Field Name and Type'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Variable Field Name And Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32002464264675337)
,p_db_column_name=>'Reinsurance Code'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Reinsurance Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32002850629675337)
,p_db_column_name=>'Tax Fund Code'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Tax Fund Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32003215985675338)
,p_db_column_name=>'Run Type Code'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Run Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32003641716675338)
,p_db_column_name=>'Step Type Code'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Step Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32004051422675338)
,p_db_column_name=>'Basis Layer'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Basis Layer'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32004460979675339)
,p_db_column_name=>'Asset Manager'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Asset Manager'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32004820941675339)
,p_db_column_name=>'Suspended Flag'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Suspended Flag'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32005240771675339)
,p_db_column_name=>'Amount_YTD'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Amount Ytd'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32005688693675339)
,p_db_column_name=>'AOS_Diff'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Aos Diff'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(32006775583682785)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'320068'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'Reporting Period:Source File Type:Unmodelled Version Id:Projection Period:Reinsurer Legal Entity Code:Company Code:Deal Code:Reporting Fund Num:Product Code:LOB Code:Variable Code:Variable Field Name and Type:Reinsurance Code:Tax Fund Code:Run Type C'
||'ode:Step Type Code:Basis Layer:Asset Manager:Suspended Flag:Amount_YTD:AOS_Diff'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32035065741994503)
,p_plug_name=>'EV Main'
,p_icon_css_classes=>'fa-cubes'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_00160
begin
wwv_flow_api.create_page(
 p_id=>160
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Datacube EV Cashflow'
,p_page_mode=>'NORMAL'
,p_step_title=>'Datacube EV Cashflow'
,p_step_sub_title=>'Datacube EV Cashflow'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_footer_text=>'Total Elapsed Time(Second) = #TIMING#'
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'SESSION'
,p_cache_timeout_seconds=>3600
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150820115229'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32007680054690702)
,p_plug_name=>'Datacube EV Cashflow'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16217862042317938)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select "Reporting Period",',
'       "Source File Type",',
'       "Unmodelled Version Id",',
'       "Aggregation Method",',
'       "Projection Period",',
'       "Reinsurer Legal Entity Code",',
'       "Company Code",',
'       "Deal Code",',
'       "Reporting Fund Num",',
'       "Product Code",',
'       "LOB Code",',
'       "Variable Code",',
'       "Variable Field Name and Type",',
'       "Reinsurance Code",',
'    --   "Replicating Instrument Code",',
'    --   "EVM Non Std Definition Code",',
'       "Tax Fund Code",',
'       "Run Type Code",',
'       "Step Type Code",',
'       "Basis Layer",',
'       "Asset Manager",',
'       "Suspended Flag",',
'       "Amount"',
'  from DATACUBE_EV_CASHFLOW_NEW'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_footer=>'Total Elapsed Time(Second) = #TIMING#'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(32007712082690702)
,p_name=>'Datacube EV Cashflow'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_max_rows_per_page=>'10'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_download_formats=>'CSV:HTML'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="Edit">'
,p_owner=>'ADMIN'
,p_internal_uid=>32007712082690702
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32008166226690705)
,p_db_column_name=>'Reporting Period'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Reporting Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32008596103690705)
,p_db_column_name=>'Source File Type'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Source File Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32008933222690705)
,p_db_column_name=>'Unmodelled Version Id'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Unmodelled Version Id'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32009330336690706)
,p_db_column_name=>'Aggregation Method'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Aggregation Method'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32009781381690706)
,p_db_column_name=>'Projection Period'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Projection Period'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32010145573690706)
,p_db_column_name=>'Reinsurer Legal Entity Code'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Reinsurer Legal Entity Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32010543136690707)
,p_db_column_name=>'Company Code'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Company Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32010923996690707)
,p_db_column_name=>'Deal Code'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Deal Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32011373310690707)
,p_db_column_name=>'Reporting Fund Num'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Reporting Fund Num'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32011749778690708)
,p_db_column_name=>'Product Code'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Product Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32012157154690708)
,p_db_column_name=>'LOB Code'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Lob Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32012575469690708)
,p_db_column_name=>'Variable Code'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Variable Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32012921481690709)
,p_db_column_name=>'Variable Field Name and Type'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Variable Field Name And Type'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32013346676690709)
,p_db_column_name=>'Reinsurance Code'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Reinsurance Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32014524485690711)
,p_db_column_name=>'Tax Fund Code'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Tax Fund Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32014928634690711)
,p_db_column_name=>'Run Type Code'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Run Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32015310870690712)
,p_db_column_name=>'Step Type Code'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Step Type Code'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32015766827690712)
,p_db_column_name=>'Basis Layer'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Basis Layer'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32016172217690713)
,p_db_column_name=>'Asset Manager'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Asset Manager'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32016548582690713)
,p_db_column_name=>'Suspended Flag'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Suspended Flag'
,p_column_type=>'STRING'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32016935959690716)
,p_db_column_name=>'Amount'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Amount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(32018074675697769)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'320181'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>50
,p_report_columns=>'Reporting Period:Source File Type:Unmodelled Version Id:Aggregation Method:Projection Period:Reinsurer Legal Entity Code:Company Code:Deal Code:Reporting Fund Num:Product Code:LOB Code:Variable Code:Variable Field Name and Type:Reinsurance Code:Tax F'
||'und Code:Run Type Code:Step Type Code:Basis Layer:Asset Manager:Suspended Flag:Amount'
,p_flashback_enabled=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32035230575994505)
,p_plug_name=>'EV Cashflow'
,p_icon_css_classes=>'fa-cubes'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
prompt --application/pages/page_01000
begin
wwv_flow_api.create_page(
 p_id=>1000
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'Testing'
,p_page_mode=>'NORMAL'
,p_step_title=>'Testing'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_step_template=>wwv_flow_api.id(16203144132317906)
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150820120938'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32331350883859714)
,p_plug_name=>'Region-1'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32331494173859715)
,p_plug_name=>'Region-2'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32331597744859716)
,p_plug_name=>'Region-5'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32331637433859717)
,p_plug_name=>'Region-3'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(32331761559859718)
,p_plug_name=>'Region-4'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(16218364978317939)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
prompt --application/pages/page_02020
begin
wwv_flow_api.create_page(
 p_id=>2020
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'PrepareChecklist'
,p_page_mode=>'NORMAL'
,p_step_title=>'PrepareChecklist'
,p_step_sub_title=>'PrepareChecklist'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_javascript_code_onload=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'$(document).ready(function(){',
'    $("#id_button").click(function(){',
'        $(this).attr("disabled", "disabled");',
'    });',
'});'))
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(32063248862243228)
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150826215849'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35937744635611016)
,p_plug_name=>'WizardVersion'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16221620630317943)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35937805900611017)
,p_plug_name=>'ProgressBar'
,p_region_template_options=>'t-Wizard--hideStepsXSmall'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayLabels'
,p_plug_template=>wwv_flow_api.id(16222192630317944)
,p_plug_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(35976856360068061)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(16238013536317965)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35962500554035025)
,p_plug_name=>'PrepareChecklist'
,p_parent_plug_id=>wwv_flow_api.id(35937805900611017)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16210264139317931)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(35938085104611019)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(35937805900611017)
,p_button_name=>'Next'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(16239148892317970)
,p_button_image_alt=>'Next'
,p_button_position=>'REGION_TEMPLATE_NEXT'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(35975206521035067)
,p_branch_name=>'Branch to next page'
,p_branch_action=>'f?p=&APP_ID.:2021:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(35938085104611019)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35963724904035032)
,p_name=>'P2020_OLD_EVM_MAIN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'Old Evm Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EVM_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35964167365035034)
,p_name=>'P2020_NEW_EVM_MAIN'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'New Evm Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EVM_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35964518151035035)
,p_name=>'P2020_OLD_EVM_CF'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'Old Evm Cashflow'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EVM_CF_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35964968730035035)
,p_name=>'P2020_NEW_EVM_CF'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'New Evm Cashflow'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EVM_CF_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EVM_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35965321310035036)
,p_name=>'P2020_OLD_USGAAP_MAIN'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'Old Usgaap Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_USGAAP_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_USGAAP_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35965741339035036)
,p_name=>'P2020_NEW_USGAAP_MAIN'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'New Usgaap Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_USGAAP_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_USGAAP_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35966117683035036)
,p_name=>'P2020_OLD_LOSSREC_MAIN'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'Old Lossrec Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_LOSSREC_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_LOSSREC_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35966583034035036)
,p_name=>'P2020_NEW_LOSSREC_MAIN'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'New Lossrec Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_LOSSREC_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_LOSSREC_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35966968587035036)
,p_name=>'P2020_OLD_EV_MAIN'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'Old Ev Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EV_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35967332952035037)
,p_name=>'P2020_NEW_EV_MAIN'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'New Ev Main'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EV_MAIN_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_MAIN_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35967750911035037)
,p_name=>'P2020_OLD_EV_CF'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'Old Ev Cashflow'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EV_CF_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35968119125035037)
,p_name=>'P2020_NEW_EV_CF'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_prompt=>'New Ev Cashflow'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'ALL_EV_CF_CUBES'
,p_lov=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'select object_name, owner||''.''||object_name||''@amstest'' full_cube_name from all_objects@amstest ',
'where owner=''ARM'' and object_type in (''TABLE'',''VIEW'')',
'and regexp_like (object_name, ''DATACUBE_EV_CASHFLOW_[0-9,_]+'')',
'order by created desc'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(16238828544317968)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35968541274035038)
,p_name=>'P2020_MESSAGE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_source=>'select :app_user from dual;'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35968987210035038)
,p_name=>'P2020_IS_SUBMITTED'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(35962500554035025)
,p_use_cache_before_default=>'NO'
,p_item_default=>'0'
,p_source=>'0'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35970129912035055)
,p_validation_name=>'OLD_EVM_MAIN'
,p_validation_sequence=>10
,p_validation=>'P2020_OLD_EVM_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of Old EVM Main cube name'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35963724904035032)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35970474182035058)
,p_validation_name=>'New'
,p_validation_sequence=>20
,p_validation=>'P2020_NEW_EVM_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of New EVM Main cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35964167365035034)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35970869149035058)
,p_validation_name=>'New_1'
,p_validation_sequence=>30
,p_validation=>'P2020_OLD_EVM_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of OLD EVM CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35964518151035035)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35971269392035058)
,p_validation_name=>'New_2'
,p_validation_sequence=>40
,p_validation=>'P2020_NEW_EVM_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of New EVM CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35964968730035035)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35971636541035061)
,p_validation_name=>'New_3'
,p_validation_sequence=>50
,p_validation=>'P2020_OLD_USGAAP_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old USGAAP cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35965321310035036)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35972041233035062)
,p_validation_name=>'New_4'
,p_validation_sequence=>60
,p_validation=>'P2020_NEW_USGAAP_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of new USGAAP cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35965741339035036)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35972404704035062)
,p_validation_name=>'New_5'
,p_validation_sequence=>70
,p_validation=>'P2020_OLD_LOSSREC_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old LOSSREC cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35966117683035036)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35972836743035062)
,p_validation_name=>'New_6'
,p_validation_sequence=>80
,p_validation=>'P2020_NEW_LOSSREC_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of new LOSSREC cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35966583034035036)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35973248832035062)
,p_validation_name=>'New_7'
,p_validation_sequence=>90
,p_validation=>'P2020_OLD_EV_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old EV Main cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35966968587035036)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35973602806035062)
,p_validation_name=>'New_8'
,p_validation_sequence=>100
,p_validation=>'P2020_NEW_EV_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of New EV Main cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35967332952035037)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35974031644035063)
,p_validation_name=>'New_9'
,p_validation_sequence=>110
,p_validation=>'P2020_OLD_EV_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old EV CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35967750911035037)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35974477912035063)
,p_validation_name=>'New_10'
,p_validation_sequence=>120
,p_validation=>'P2020_NEW_EV_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of New EV CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35968119125035037)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(35974702644035063)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Run Stored Procedure'
,p_process_sql_clob=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#OWNER#.PA_MANAGE_CUBE_CHECKLIST.PREPARE_CHECKLIST_DATA(',
'I_OLD_EVM_MAIN_CUBE => :P2020_OLD_EVM_MAIN,',
'I_NEW_EVM_MAIN_CUBE => :P2020_NEW_EVM_MAIN,',
'I_OLD_EVM_CF_CUBE => :P2020_OLD_EVM_CF,',
'I_NEW_EVM_CF_CUBE => :P2020_NEW_EVM_CF,',
'I_OLD_USGAAP_MAIN_CUBE => :P2020_OLD_USGAAP_MAIN,',
'I_NEW_USGAAP_MAIN_CUBE => :P2020_NEW_USGAAP_MAIN,',
'I_OLD_LOSSREC_MAIN_CUBE => :P2020_OLD_LOSSREC_MAIN,',
'I_NEW_LOSSREC_MAIN_CUBE => :P2020_NEW_LOSSREC_MAIN,',
'I_OLD_EV_MAIN_CUBE => :P2020_OLD_EV_MAIN,',
'I_NEW_EV_MAIN_CUBE => :P2020_NEW_EV_MAIN,',
'I_OLD_EV_CF_CUBE => :P2020_OLD_EV_CF,',
'I_NEW_EV_CF_CUBE => :P2020_NEW_EV_CF,',
'i_app_user       => :app_user,',
'o_return_message => :P30_RETURN_STATUS,',
'O_ERROR_MESSAGE =>  :P30_SQL_ERR_MSG',
')'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
end;
/
prompt --application/pages/page_02021
begin
wwv_flow_api.create_page(
 p_id=>2021
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'ConfirmSelectedCubes'
,p_page_mode=>'NORMAL'
,p_step_title=>'ConfirmSelectedCubes'
,p_step_sub_title=>'ConfirmSelectedCubes'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(32063248862243228)
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150827104712'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35938559963611024)
,p_plug_name=>'WizardVersion'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16221620630317943)
,p_plug_display_sequence=>15
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35997958358274392)
,p_plug_name=>'ProgressBar'
,p_region_template_options=>'t-Wizard--hideStepsXSmall'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayLabels'
,p_plug_template=>wwv_flow_api.id(16222192630317944)
,p_plug_display_sequence=>5
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(35976856360068061)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(16238013536317965)
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35999118088274392)
,p_plug_name=>'PrepareChecklist'
,p_parent_plug_id=>wwv_flow_api.id(35997958358274392)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16210264139317931)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35938266067611021)
,p_plug_name=>'Message'
,p_parent_plug_id=>wwv_flow_api.id(35999118088274392)
,p_region_template_options=>'#DEFAULT#:t-Alert--wizard:t-Alert--defaultIcons:t-Alert--info'
,p_plug_template=>wwv_flow_api.id(16208747833317918)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35938393689611022)
,p_plug_name=>'OLD_MSG'
,p_parent_plug_id=>wwv_flow_api.id(35938266067611021)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16210264139317931)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>'&P2021_IS_OLD_CUBES_SAME.'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35938465120611023)
,p_plug_name=>'NEW_MSG'
,p_parent_plug_id=>wwv_flow_api.id(35938266067611021)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16210264139317931)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source=>'&P2021_IS_NEW_CUBES_SAME.'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(35998799311274392)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(35997958358274392)
,p_button_name=>'PrepareChecklist'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(16239148892317970)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Prepare Checklist'
,p_button_position=>'REGION_TEMPLATE_NEXT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(35998337050274392)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(35997958358274392)
,p_button_name=>'ChangeCubeSelction'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(16239148892317970)
,p_button_image_alt=>'Change Cube Selction'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:2020:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(36010722231274408)
,p_branch_name=>'Go To Page 30'
,p_branch_action=>'f?p=&APP_ID.:2022:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35999526814274393)
,p_name=>'P2021_OLD_EVM_MAIN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(35999118088274392)
,p_use_cache_before_default=>'NO'
,p_item_default=>'regexp_substr(:P2020_OLD_EVM_MAIN,''\.(.*)@'',1,1,null,1) || '' & ''|| regexp_substr(:P2020_NEW_EVM_MAIN,''\.(.*)@'',1,1,null,1)'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Evm Main'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36000368376274395)
,p_name=>'P2021_OLD_EVM_CF'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(35999118088274392)
,p_use_cache_before_default=>'NO'
,p_item_default=>'regexp_substr(:P2020_OLD_EVM_CF,''\.(.*)@'',1,1,null,1) || '' & ''||regexp_substr(:P2020_NEW_EVM_CF,''\.(.*)@'',1,1,null,1)'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Evm Cashflow'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_css_classes=>'[object Object]'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36001184748274396)
,p_name=>'P2021_OLD_USGAAP_MAIN'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(35999118088274392)
,p_use_cache_before_default=>'NO'
,p_item_default=>'regexp_substr(:P2020_OLD_USGAAP_MAIN,''\.(.*)@'',1,1,null,1)||'' & '' || regexp_substr(:P2020_NEW_USGAAP_MAIN,''\.(.*)@'',1,1,null,1)'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Usgaap Main'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_tag_css_classes=>'mnw240'
,p_grid_column=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36001958707274398)
,p_name=>'P2021_OLD_LOSSREC_MAIN'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(35999118088274392)
,p_use_cache_before_default=>'NO'
,p_item_default=>'regexp_substr(:P2020_OLD_LOSSREC_MAIN,''\.(.*)@'',1,1,null,1) || '' & '' || regexp_substr(:P2020_NEW_LOSSREC_MAIN,''\.(.*)@'',1,1,null,1)'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Lossrec Main'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_tag_css_classes=>'mnw240'
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36002785937274399)
,p_name=>'P2021_OLD_EV_MAIN'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(35999118088274392)
,p_use_cache_before_default=>'NO'
,p_item_default=>'regexp_substr(:P2020_OLD_EV_MAIN,''\.(.*)@'',1,1,null,1) || '' & '' || regexp_substr(:P2020_NEW_EV_MAIN,''\.(.*)@'',1,1,null,1)'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'EV Main'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_tag_css_classes=>'mnw240'
,p_grid_column=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36003513206274399)
,p_name=>'P2021_OLD_EV_CF'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(35999118088274392)
,p_use_cache_before_default=>'NO'
,p_item_default=>'regexp_substr(:P2020_OLD_EV_CF,''\.(.*)@'',1,1,null,1) || '' & '' ||regexp_substr(:P2020_NEW_EV_CF,''\.(.*)@'',1,1,null,1)'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'EV Cashflow'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(16238622797317967)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36004355976274400)
,p_name=>'P2021_IS_OLD_CUBES_SAME'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(35999118088274392)
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'SELECT ',
'decode(',
'    greatest(',
'    regexp_substr(:P2020_OLD_EVM_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_EVM_CF,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_USGAAP_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_LOSSREC_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_EV_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_EV_CF,''_([0-9_]+)@'',1,1,null,1)',
'    )',
'    ,least(',
'    regexp_substr(:P2020_OLD_EVM_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_EVM_CF,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_USGAAP_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_LOSSREC_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_EV_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_OLD_EV_CF,''_([0-9_]+)@'',1,1,null,1)',
'    )',
'    ,''All Selected OLD CUBES are built on sameday''',
'    ,''All Selected OLD CUBES are not built on sameday''',
'    )',
'FROM DUAL'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36004733549274400)
,p_name=>'P2021_IS_NEW_CUBES_SAME'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(35999118088274392)
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'SELECT ',
'DECODE(',
'    greatest(',
'    regexp_substr(:P2020_NEW_EVM_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_EVM_CF,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_USGAAP_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_LOSSREC_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_EV_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_EV_CF,''_([0-9_]+)@'',1,1,null,1)',
'    )',
'    ,least(',
'    regexp_substr(:P2020_NEW_EVM_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_EVM_CF,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_USGAAP_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_LOSSREC_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_EV_MAIN,''_([0-9_]+)@'',1,1,null,1)',
'    ,regexp_substr(:P2020_NEW_EV_CF,''_([0-9_]+)@'',1,1,null,1)',
'    )',
'    ,''All Selected NEW CUBES are built on sameday''',
'    ,''All Selected NEW CUBES are not built on sameday''',
')',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(36005501109274400)
,p_validation_name=>'OLD_EVM_MAIN'
,p_validation_sequence=>10
,p_validation=>'P2021_OLD_EVM_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of Old EVM Main cube name'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(35999526814274393)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(36006363845274402)
,p_validation_name=>'New_1'
,p_validation_sequence=>30
,p_validation=>'P2021_OLD_EVM_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of OLD EVM CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(36000368376274395)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(36007111245274402)
,p_validation_name=>'New_3'
,p_validation_sequence=>50
,p_validation=>'P2021_OLD_USGAAP_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old USGAAP cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(36001184748274396)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(36007943376274402)
,p_validation_name=>'New_5'
,p_validation_sequence=>70
,p_validation=>'P2021_OLD_LOSSREC_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old LOSSREC cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(36001958707274398)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(36008744780274403)
,p_validation_name=>'New_7'
,p_validation_sequence=>90
,p_validation=>'P2021_OLD_EV_MAIN'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old EV Main cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(36002785937274399)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(36009520983274403)
,p_validation_name=>'New_9'
,p_validation_sequence=>110
,p_validation=>'P2021_OLD_EV_CF'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Provide the name of old EV CF cube'
,p_always_execute=>'N'
,p_associated_item=>wwv_flow_api.id(36003513206274399)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(36010232525274403)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Run Stored Procedure'
,p_process_sql_clob=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'#OWNER#.PA_MANAGE_CUBE_CHECKLIST.PREPARE_CHECKLIST_DATA(',
'I_OLD_EVM_MAIN_CUBE => :P2020_OLD_EVM_MAIN,',
'I_NEW_EVM_MAIN_CUBE => :P2020_NEW_EVM_MAIN,',
'I_OLD_EVM_CF_CUBE => :P2020_OLD_EVM_CF,',
'I_NEW_EVM_CF_CUBE => :P2020_NEW_EVM_CF,',
'I_OLD_USGAAP_MAIN_CUBE => :P2020_OLD_USGAAP_MAIN,',
'I_NEW_USGAAP_MAIN_CUBE => :P2020_NEW_USGAAP_MAIN,',
'I_OLD_LOSSREC_MAIN_CUBE => :P2020_OLD_LOSSREC_MAIN,',
'I_NEW_LOSSREC_MAIN_CUBE => :P2020_NEW_LOSSREC_MAIN,',
'I_OLD_EV_MAIN_CUBE => :P2020_OLD_EV_MAIN,',
'I_NEW_EV_MAIN_CUBE => :P2020_NEW_EV_MAIN,',
'I_OLD_EV_CF_CUBE => :P2020_OLD_EV_CF,',
'I_NEW_EV_CF_CUBE => :P2020_NEW_EV_CF,',
'i_app_user       => :app_user,',
'o_return_message => :P2022_RETURN_STATUS,',
'O_ERROR_MESSAGE =>  :P2022_SQL_ERR_MSG',
')'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/page_02022
begin
wwv_flow_api.create_page(
 p_id=>2022
,p_user_interface_id=>wwv_flow_api.id(16244399291317993)
,p_name=>'ChecklistPrepareStatus'
,p_page_mode=>'NORMAL'
,p_step_title=>'ChecklistPrepareStatus'
,p_step_sub_title=>'ChecklistPrepareStatus'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_first_item=>'NO_FIRST_ITEM'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'Y'
,p_overwrite_navigation_list=>'N'
,p_page_is_public_y_n=>'N'
,p_cache_mode=>'NOCACHE'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20150826173018'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35938618000611025)
,p_plug_name=>'WizardVersion'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(16216730653317935)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(16245677836318030)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(16239617562317971)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(35938771522611026)
,p_plug_name=>'Progressbar'
,p_region_template_options=>'#DEFAULT#:t-Wizard--hideStepsXSmall'
,p_component_template_options=>'#DEFAULT#:t-WizardSteps--displayLabels'
,p_plug_template=>wwv_flow_api.id(16222192630317944)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_list_id=>wwv_flow_api.id(35976856360068061)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(16238013536317965)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(36040368553147613)
,p_plug_name=>'Success'
,p_parent_plug_id=>wwv_flow_api.id(35938771522611026)
,p_region_template_options=>'t-Alert--wizard:t-Alert--defaultIcons:t-Alert--success'
,p_plug_template=>wwv_flow_api.id(16208747833317918)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>'&P2022_RETURN_STATUS.'
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NULL'
,p_plug_display_when_condition=>'P2022_SQL_ERR_MSG'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(36040779610147614)
,p_plug_name=>'Failure'
,p_parent_plug_id=>wwv_flow_api.id(35938771522611026)
,p_region_template_options=>'#DEFAULT#:t-Alert--wizard:t-Alert--defaultIcons:t-Alert--danger'
,p_plug_template=>wwv_flow_api.id(16208747833317918)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Error encountered during checklist preparation. <br>',
'&P2022_SQL_ERR_MSG.'))
,p_plug_query_row_template=>1
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P2022_SQL_ERR_MSG'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36041925065147615)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(35938771522611026)
,p_button_name=>'ViewChecklist'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(16239202992317970)
,p_button_image_alt=>'View Checklist'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP::'
,p_icon_css_classes=>'fa-angle-double-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(36041526188147614)
,p_button_sequence=>10
,p_button_name=>'Review_Selected_Cubes'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(16239202992317970)
,p_button_image_alt=>'Review selected cubes'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:20:&SESSION.::&DEBUG.:RP::'
,p_icon_css_classes=>'fa-angle-double-left'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36042341528147615)
,p_name=>'P2022_RETURN_STATUS'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36042704999147617)
,p_name=>'P2022_SQL_ERR_MSG'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(36043156469147617)
,p_name=>'P2022_REFRESH_TIME'
,p_item_sequence=>30
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
end;
/
prompt --application/deployment/definition
begin
wwv_flow_api.create_install(
 p_id=>wwv_flow_api.id(19114688792937468)
);
end;
/
prompt --application/deployment/install
begin
null;
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
