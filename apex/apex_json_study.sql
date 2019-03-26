What is JSON?

JSON is a syntax for serializing objects, arrays, numbers, strings, booleans, and null. It is based upon JavaScript syntax but is distinct from it: some JavaScript is not JSON, and some JSON is not JavaScript.

You can think of JSON as "skinny XML". Typically the JSON representation of data requires less characters than the XML equivalent, whether you use tag-based or attribute-based XML. Anything that reduces the number of characters being sent, whilst retaining readability, is interesting where data transfers are concerned, which is why JSON has become a strong favourite when coding web services.

JSON data is made up of name/value pairs, where the value can be a JSON object, JSON array, number, string, boolean or null.

A JSON object : is made up of one-to-many name/value pairs separated by commas and placed inside curly braces. The name/value pairs do not have to be of the same types. {"employee_number":7934, "employee_name":"CLARK"}
A JSON array : is a comma-separated list of objects inside square brackets. The objects do not have to be of the same type.
[
  {"employee_number":7782, "employee_name":"CLARK"},
  {"employee_number":7839, "employee_name":"KING"},
  {"employee_number":7934, "employee_name":"MILLER"}
]

What is REST?

REST stands for Representational State Transfer. To put it simply, we should have a URI which represents a specific resource. Assuming we want to interact with data about employees, we might have something like the following.

https://example.com/ws/hr/employees/

SET SERVEROUTPUT ON
DECLARE
  l_json_text VARCHAR2(32767);
  l_count     PLS_INTEGER;
  l_members   WWV_FLOW_T_VARCHAR2;
  l_paths     APEX_T_VARCHAR2;
  l_exists    BOOLEAN;
BEGIN
  l_json_text := '{
	"department": {
		"department_number": 10,
		"department_name": "ACCOUNTING",
		"employees": [
			{
				"employee_number": 7782,
				"employee_name": "CLARK"
			},
			{
				"employee_number": 7839,
				"employee_name": "KING"
			},
			{
				"employee_number": 7934,
				"employee_name": "MILLER"
			}
		]
	},
	"metadata": {
		"published_date": "04-APR-2016",
		"publisher": "oracle-base.com"
	}
}';

  APEX_JSON.parse(l_json_text);

  DBMS_OUTPUT.put_line('----------------------------------------'); 
  DBMS_OUTPUT.put_line('Department Information (Basic path lookup)'); 

  DBMS_OUTPUT.put_line('Department Number : ' ||
    APEX_JSON.get_number(p_path => 'department.department_number')); 

  DBMS_OUTPUT.put_line('Department Name   : ' ||
    APEX_JSON.get_varchar2(p_path => 'department.department_name'));

  DBMS_OUTPUT.put_line('----------------------------------------'); 
  DBMS_OUTPUT.put_line('Employee Information (Loop through array)');

  l_count := APEX_JSON.get_count(p_path => 'department.employees');
  DBMS_OUTPUT.put_line('Employees Count   : ' || l_count);

  FOR i IN 1 .. l_count LOOP
    DBMS_OUTPUT.put_line('Employee Item Idx : ' || i); 

    DBMS_OUTPUT.put_line('Employee Number   : ' ||
      APEX_JSON.get_number(p_path => 'department.employees[%d].employee_number', p0 => i)); 

    DBMS_OUTPUT.put_line('Employee Name     : ' ||
      APEX_JSON.get_varchar2(p_path => 'department.employees[%d].employee_name', p0 => i)); 
  END LOOP;

  DBMS_OUTPUT.put_line('----------------------------------------'); 
  DBMS_OUTPUT.put_line('Check elements (members) below a path');

  l_members := APEX_JSON.get_members(p_path=>'department');
  DBMS_OUTPUT.put_line('Members Count     : ' || l_members.COUNT);

  FOR i IN 1 .. l_members.COUNT LOOP
    DBMS_OUTPUT.put_line('Member Item Idx   : ' || i); 
    DBMS_OUTPUT.put_line('Member Name       : ' || l_members(i)); 
  END LOOP;

  DBMS_OUTPUT.put_line('----------------------------------------'); 
  DBMS_OUTPUT.put_line('Search for matching elements in an array'); 
  l_paths := APEX_JSON.find_paths_like (p_return_path => 'department.employees[%]',
                                        p_subpath     => '.employee_name',
                                        p_value       => 'MILLER' );

  DBMS_OUTPUT.put_line('Matching Paths    : ' || l_paths.COUNT); 
  FOR i IN 1 .. l_paths.COUNT loop
    DBMS_OUTPUT.put_line('Employee Number   : ' ||
      APEX_JSON.get_number(p_path => l_paths(i)||'.employee_number')); 

    DBMS_OUTPUT.put_line('Employee Name     : ' ||
      APEX_JSON.get_varchar2(p_path => l_paths(i)||'.employee_name')); 
  END LOOP;

  DBMS_OUTPUT.put_line('----------------------------------------'); 
  DBMS_OUTPUT.put_line('Check if path exists'); 
  l_exists := APEX_JSON.does_exist (p_path => 'department.employees[%d].employee_name', p0 => 4);

  DBMS_OUTPUT.put('Employee 4 Exists : '); 
  IF l_exists THEN
    DBMS_OUTPUT.put_line('True');
  ELSE
    DBMS_OUTPUT.put_line('False'); 
  END IF;

  DBMS_OUTPUT.put_line('----------------------------------------'); 
  DBMS_OUTPUT.put_line('Metadata (Basic path lookup)'); 

  DBMS_OUTPUT.put_line('Department Number : ' ||
    APEX_JSON.get_date(p_path => 'metadata.published_date', p_format => 'DD-MON-YYYY')); 

  DBMS_OUTPUT.put_line('Department Name   : ' ||
    APEX_JSON.get_varchar2(p_path => 'metadata.publisher'));
  DBMS_OUTPUT.put_line('----------------------------------------'); 
END;
/

DECLARE
    s varchar2(32767) := '{ "a": 1, "b": ["hello", "world"]}';
BEGIN
    APEX_JSON.parse(s);
    dbms_output.put_line('a is '||apex_json.get_varchar2(p_path => 'a'));
END;
/

DECLARE
    l_values apex_json.t_values;
BEGIN
    apex_json.parse (
        p_values => l_values,
        p_source => '{ "type": "circle", "coord": [10, 20] }' );
    dbms_output.put_line('Point at '||
        apex_json.get_number (
            p_values => l_values,
            p_path   => 'coord[1]')||
        ','||
        apex_json.get_number (
            p_values => l_values,
            p_path   => 'coord[2]'));
END;
/

DECLARE 
    j apex_json.t_values; 
BEGIN 
    apex_json.parse(j, '{ "items": [ 1, 2, { "foo": 42 } ] }'); 
    dbms_output.put_line(apex_json.get_varchar2(p_path=>'items[%d].foo',p0=> 2,p_values=>j)); 
END;
/

SET SERVEROUTPUT ON;
DECLARE
    l_url           varchar2(4000);
    l_clob          clob;
    l_values        apex_json.t_values;
    l_paths         apex_t_varchar2;
    l_count         number;
    l_temp_date     date;
    l_select_count  number;
    l_return        boolean := false;
BEGIN
    l_url := 'http://localhost/ords/cms/org/orgmst/?org_lvl_number=9001';

    l_clob := APEX_WEB_SERVICE.MAKE_REST_REQUEST(
        p_url               => l_url,
        p_http_method       =>  'GET'
        );

    apex_json.parse (
        p_values => l_values,
        p_source => l_clob
        );

    dbms_output.put_line ('org_lvl_child:'||
    apex_json.get_varchar2(p_path => 'org_lvl_child')
    );
END;
/

http://wwisdlap002/ords/f?p=clickcollectdemo

DECLARE
    s varchar2(32767) := '{ "a": 1, "b": ["hello", "world"]}';
BEGIN
    apex_json.parse(s);
    sys.dbms_output.put_line('a is '||apex_json.get_varchar2(p_path => 'a'));
END;

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
The following are constants used for the parser interface:

subtype t_kind is binary_integer range 1 .. 7;
c_null     constant t_kind := 1;
c_true     constant t_kind := 2;
c_false    constant t_kind := 3;
c_number   constant t_kind := 4;
c_varchar2 constant t_kind := 5;
c_object   constant t_kind := 6;
c_array    constant t_kind := 7;

