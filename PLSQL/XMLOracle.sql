Creating a Table with an XMLType Column
CREATE TABLE mytable1 (
  key_column VARCHAR2(10) PRIMARY KEY,
  xml_column XMLType
);

Creating a Table of XMLType
CREATE TABLE mytable2 OF XMLType;

The XQuery language is one of the main ways that you interact with XML data in Oracle XML DB. Support for the language includes SQL*Plus commandXQUERY and SQL/XML functions XMLQuery, XMLTable, XMLExists, and XMLCast.

Common XPath Constructs

// : Used to identify all descendants of the current node. For example, PurchaseOrder//ShippingInstructions matches any ShippingInstructions element under the PurchaseOrder element.
* : Used as a wildcard to match any child node. For example, /PO/ */STREET matches any street element that is a grandchild of the PO element.
[] : Used to denote predicate expressions. XPath supports a rich list of binary operators such as or, and, and not. For example, /PO[PONO = 20 and PNAME = "PO_2"]/SHIPADDR selects the shipping address element of all purchase orders whose purchase-order number is 20 and whose purchase-order name is PO_2.
Brackets are also used to denote a position (index). For example, /PO/PONO[2] identifies the second purchase-order number element under the PO root element.
functions : XPath and XQuery support a set of built-in functions such as substring, round, and not. In addition, these languages provide for extension functions through the use of namespaces.

---------------------

select cast (
            xmlelement("RootNode",
                xmlagg(
                    xmlelement("Row",
                        xmlforest(A,B)
                    )
                )
            )
        as varchar2(200)) as f1
from (select 'A1' as A, 'B1' as B from dual) X

SELECT Y.*
     FROM  (select xmltype('<RootNode><Row><A>A1</A><B>B1</B></Row></RootNode>') as MyXML from dual) X,
          XMLTABLE ('/RootNode/Row'
                    PASSING X.MyXML
                    COLUMNS MyB VARCHAR2(30) PATH 'B',
                            MyA VARCHAR2(30) PATH 'A'
) Y



select empno, ename, XMLELEMENT("Employee", XMLForest(EMPNO, ENAME, job, deptno, sal, comm)) emp_xml from EMP

EMPNO	ENAME	EMP_XML
7839	KING	<Employee><EMPNO>7839</EMPNO><ENAME>KING</ENAME><JOB>PRESIDENT</JOB><DEPTNO>10</DEPTNO><SAL>5000</SAL></Employee>
7698	BLAKE	<Employee><EMPNO>7698</EMPNO><ENAME>BLAKE</ENAME><JOB>MANAGER</JOB><DEPTNO>30</DEPTNO><SAL>2850</SAL></Employee>
7782	CLARK	<Employee><EMPNO>7782</EMPNO><ENAME>CLARK</ENAME><JOB>MANAGER</JOB><DEPTNO>10</DEPTNO><SAL>2450</SAL></Employee>


create table toys (
  toy_id   integer,
  toy_name varchar2(30),
  price    number,
  colour   varchar2(30)
)

begin
  insert into toys values (1, 'Cheapasaurus Rex', 0.99, 'blue');
  insert into toys values (2, 'Costsalottasaurs', 99.99, 'green');
  insert into toys values (3, 'Bluesaurus', 21.99, 'blue');
  commit;
end;

-- XMLForest converts each argument to an XML element. It then combines these into an XML fragment for each row in the input.
select xmlforest(toy_id, toy_name, price, colour).getClobVal() xdoc from toys
XDOC
<TOY_ID>1</TOY_ID><TOY_NAME>Cheapasaurus Rex</TOY_NAME><PRICE>.99</PRICE><COLOUR>blue</COLOUR>
<TOY_ID>2</TOY_ID><TOY_NAME>Costsalottasaurs</TOY_NAME><PRICE>99.99</PRICE><COLOUR>green</COLOUR>
<TOY_ID>3</TOY_ID><TOY_NAME>Bluesaurus</TOY_NAME><PRICE>21.99</PRICE><COLOUR>blue</COLOUR>

--XMLAgg combines multiple XML fragments into a single document.
select xmlagg(xmlelement("ROW", xmlforest(toy_id, toy_name, price, colour))).getClobVal() xdoc
from   toys

--Passing a cursor to XMLType will return the results of the query as a single XML document.
select xmltype(cursor(select * from toys)).getClobVal() xdoc from dual

<?xml version="1.0"?> <ROWSET> <ROW> <TOY_ID>1</TOY_ID> <TOY_NAME>Cheapasaurus Rex</TOY_NAME> <PRICE>.99</PRICE> <COLOUR>blue</COLOUR> </ROW> <ROW> <TOY_ID>2</TOY_ID> <TOY_NAME>Costsalottasaurs</TOY_NAME> <PRICE>99.99</PRICE> <COLOUR>green</COLOUR> </ROW> <ROW> <TOY_ID>3</TOY_ID> <TOY_NAME>Bluesaurus</TOY_NAME> <PRICE>21.99</PRICE> <COLOUR>blue</COLOUR> </ROW> </ROWSET>

--dbms_xmlgen.getxml works in similar way to passing a cursor to XMLType: it executes the query and returns the result as a single XML document.
select dbms_xmlgen.getxml('select * from toys') xdoc from dual

-- Convert REF CURSOR to XML in 3 different way
declare
  gc_date      date := sysdate;
  l_crsr sys_refcursor;

  function to_xml1(a_cursor sys_refcursor) return xmltype is
    l_xml  xmltype;
  begin
    execute immediate q'[alter session set nls_date_format = 'yyyy-mm-dd"T"hh24:mi:ss']';
    l_xml := xmltype.createxml(a_cursor);
    close a_cursor;
    execute immediate q'[alter session set nls_date_format = 'dd-MON-yy']';
    return l_xml;
  end;

  function to_xml2(a_cursor sys_refcursor) return xmltype is
    l_xml  xmltype;
    l_ctx number;
  begin
    execute immediate q'[alter session set nls_date_format = 'yyyy-mm-dd"T"hh24:mi:ss']';
    l_ctx := dbms_xmlgen.newContext(l_crsr);
    l_xml := dbms_xmlgen.getxmltype(l_ctx);
    dbms_xmlgen.closecontext(l_ctx);
    close a_cursor;
    execute immediate q'[alter session set nls_date_format = 'dd-MON-yy']';
    return l_xml;
  end;

  function to_xml3(a_cursor sys_refcursor) return xmltype is
    l_xml  xmltype;
  begin
    execute immediate q'[alter session set nls_date_format = 'yyyy-mm-dd"T"hh24:mi:ss']';
    select xmlagg(value(a))
      into l_xml
      from table(xmlsequence(a_cursor)) a;
    close a_cursor;
    execute immediate q'[alter session set nls_date_format = 'dd-MON-yy']';
    return l_xml;
  end;

begin
    open l_crsr for
      select  gc_date-1 some_date, sysdate another_date, cast(null as number) num
        from dual
       connect by level <= 2;
    dbms_output.put_line(to_xml1(l_crsr).getclobval());

    open l_crsr for
      select  gc_date-1 some_date, sysdate another_date, cast(null as number) num
        from dual
       connect by level <= 2;
    dbms_output.put_line(to_xml2(l_crsr).getclobval());

    open l_crsr for
      select  gc_date-1 some_date, sysdate another_date, cast(null as number) num
        from dual
       connect by level <= 2;
    dbms_output.put_line(to_xml3(l_crsr).getclobval());
end;

https://livesql.oracle.com/apex/livesql/file/tutorial_HE5NRRMNBOHLLKRLZJU0VNRCB.html

https://livesql.oracle.com/apex/livesql/file/content_ET2CD8U5GO17VY2H0CJ8REEWL.html


---------------------
SQL/XML Functions

XMLELEMENT : The XMLELEMENT function is the basic unit for turning column data into XML fragments.

XMLELEMENT (element name, value expression)

You must specify a value for "element name" (identifier), which Oracle Database uses as the enclosing tag. The identifier can be up to 4000 characters and does not have to be a column name or column reference. It cannot be an expression or null.

SELECT XMLELEMENT("name", e.ename) AS employee FROM emp e WHERE  e.empno = 7782;

EMPLOYEE
-------------------
<name>CLARK</name>

SELECT XMLELEMENT ("Emp",
               XMLELEMENT ("ID", empno),
               XMLELEMENT ("Name", ename),
               XMLELEMENT ("JOB", job),
               XMLELEMENT ("Salary", sal)) XMLDATA
FROM emp WHERE empno = 7839;

<Emp><ID>7839</ID><Name>KING</Name><JOB>PRESIDENT</JOB><Salary>500</Salary></Emp>
--
--
XMLATTRIBUTES : The XMLATRIBUTES function converts column data into attributes of the parent element. The function call should contain one or more columns in a comma separated list. The attribute names will match the column names using the default uppercase unless an alias is used.

SELECT XMLELEMENT ("Emp",
                   XMLATTRIBUTES (e.empno AS "ID", e.ename AS "NAME"),
                   XMLELEMENT ("JOB", job),
                   XMLELEMENT ("Salary", sal)) AS "Emp Element"
FROM emp e
WHERE e.empno = 7839;

<Emp ID="7839" NAME="KING"><JOB>PRESIDENT</JOB><Salary>500</Salary></Emp>

XMLFOREST : Using XMLELEMENT to deal with lots of columns is rather clumsy. Like XMLATTRIBUTES, the XMLFOREST function allows you to process multiple columns at once.

SELECT XMLELEMENT("employee",
         XMLFOREST(
           e.empno AS "works_number",
           e.ename AS "name")
       ) AS employees
FROM   emp e
WHERE  e.deptno = 10;

SELECT XMLELEMENT("employee",
         XMLFOREST(
           e.employee_id AS "works_number",
           e.first_name  AS "name")
       ) AS employees
FROM   employees e
WHERE  e.department_id <= 20;

-- Above query returns as three fragments in three separate rows.

SELECT XMLAGG(XMLELEMENT("employee",
         XMLFOREST(
           e.employee_id AS "works_number",
           e.first_name  AS "name")
       )) AS employees
FROM   employees e
WHERE  e.department_id <= 20;

-- Below query
SELECT XMLAGG(
         XMLELEMENT("employee",
           XMLFOREST(
             e.empno AS "works_number",
             e.ename AS "name")
         )
       ) AS employees
FROM   emp e
WHERE  e.deptno = 10;

EMPLOYEE
----------------------------------------------------------------------------------------------------
<employee><works_number>7782</works_number><name>CLARK</name></employee><employee><works_number>7839
</works_number><name>KING</name></employee><employee><works_number>7934</works_number><name>MILLER</
name></employee>

Without a root (base) tag, this is not a well formed document, so we must surround it in an XMLELEMENT to provide the root tag.

SELECT XMLELEMENT("employees",
         XMLAGG(
           XMLELEMENT("employee",
             XMLFOREST(
               e.empno AS "works_number",
               e.ename AS "name")
           )
         )
       ) AS employees
FROM   emp e
WHERE  e.deptno = 10;

EMPLOYEE
----------------------------------------------------------------------------------------------------
<employees><employee><works_number>7782</works_number><name>CLARK</name></employee><employee><works_number>7839</works_number><name>KING</name></employee><employee><works_number>7934</works_number><name>MILLER</name></employee></employees>

XMLROOT : The XMLROOT function allows us to place an XML declaration tag at the start of our XML document. In newer database versions, this function is either deprecated, or removed entirely. If you need and XML declaration, you should add it manually to the document.

SELECT XMLROOT(
         XMLELEMENT("employees",
           XMLAGG(
             XMLELEMENT("employee",
               XMLFOREST(
                 e.empno AS "works_number",
                 e.ename AS "name")
             )
           )
         )
       ) AS employees
FROM   emp e
WHERE  e.deptno = 10;

EMPLOYEE
----------------------------------------------------------------------------------------------------
<?xml version="1.0" encoding="US-ASCII"?>
<employees>
  <employee>
    <works_number>7782</works_number>
    <name>CLARK</name>
  </employee>
  <employee>
    <works_number>7839</works_number>
    <name>KING</name>
  </employee>
  <employee>
    <works_number>7934</works_number>
    <name>MILLER</name>
  </employee>
</employees>

"ORA-03135: connection lost contact"


with xt as (
select
xmltype('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://soap.service.****.com">
  <soapenv:Header />
  <soapenv:Body>
    <soap:UpdateElem>
      <soap:request>
        <soap:att1>123456789</soap:att1>
        <soap:att2 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" />
        <soap:att3>L</soap:att3>
      </soap:request>
    </soap:UpdateElem>
  </soapenv:Body>
</soapenv:Envelope>') xmlmsg from dual
)
select
      atts.att1
      , atts.att2
      , atts.att3
  from  xt, xmltable(
              xmlnamespaces(
                  'http://schemas.xmlsoap.org/soap/envelope/'  as "soapenv"
                  ,'http://soap.service.****.com'              as "soap"
                  ,'http://www.w3.org/2001/XMLSchema-instance' as "xsi"
                )
               ,'/soapenv:Envelope/soapenv:Body/soap:UpdateElem/soap:request'
               passing xt.xmlmsg
               columns
                   att1   number         path 'soap:att1'
                   , att2 varchar2(10)   path 'soap:att2/@xsi:nil'
                   , att3 char(1)        path 'soap:att3'
                   ) atts


with temp as(
select XMLTYPE('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <soapenv:Body>
      <ns1:createLabelAsPdfResponse soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn:DeliveryManager/services">
         <createLabelAsPdfReturn xsi:type="soapenc:string" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/">abcd</createLabelAsPdfReturn>
      </ns1:createLabelAsPdfResponse>
   </soapenv:Body>
</soapenv:Envelope>') xml_str from dual)
select
    EXTRACTVALUE(xml_str, '//ns1:createLabelAsPdfResponse/createLabelAsPdfReturn/text()','xmlns:ns1="urn:DeliveryManager/services"')
from temp


with temp as(
select XMLTYPE('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <soapenv:Body>
      <ns1:createLabelAsPdfResponse soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:ns1="urn:DeliveryManager/services">
         <createLabelAsPdfReturn xsi:type="soapenc:string" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/">abcd</createLabelAsPdfReturn>
      </ns1:createLabelAsPdfResponse>
   </soapenv:Body>
</soapenv:Envelope>') xml_str from dual)
select
    EXTRACTVALUE(xml_str, '//soapenv:Body/ns1:createLabelAsPdfResponse/createLabelAsPdfReturn/text()','xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/
    xmlns:ns1="urn:DeliveryManager/services"')
from temp


select xmlelement("soapenv:Envelope",
        xmlattributes('http://schemas.xmlsoap.org/soap/envelope/' as "xmlns:soapenv",
        'http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi",
        'http://www.w3.org/2001/XMLSchema' as "xmlns:xsd",
        'urn:DeliveryManager/services' as "xmlns:ser",
        'http://schemas.xmlsoap.org/soap/encoding/' as "xmlns:soapenc"),
        xmlelement("soapenv:Header",null),
        xmlelement("soapenv:Body",
            xmlelement("ser:createAndAllocateConsignmentsWithBookingCode",
                xmlattributes('http://schemas.xmlsoap.org/soap/encoding/' as "soapenv:encodingStyle"),
                    xmlelement("consignments",
                    xmlattributes('ser:ArrayOf_tns1_Consignment' as "xsi:type",
                        'typ:Consignment[]' as "soapenc:arrayType",
                        'urn:DeliveryManager/types' as "xmlns:typ"),
                        xmlelement("item",'TEST')
                    )
                )
        )
       )
from dual

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ser="urn:DeliveryManager/services" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/">TEST</soapenv:Envelope>


f_gen_ccwbc_request_xml
f_gen_request_xml_clap
f_check_soap_fault
f_parse_response()
pipe_row

select xmlelement("soapenv:Envelope",
        xmlattributes('http://schemas.xmlsoap.org/soap/envelope/' as "xmlns:soapenv",
        'http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi",
        'http://www.w3.org/2001/XMLSchema' as "xmlns:xsd",
        'urn:DeliveryManager/services' as "xmlns:ser",
        'http://schemas.xmlsoap.org/soap/encoding/' as "xmlns:soapenc"),
        xmlelement("soapenv:Header",null),
        xmlelement("soapenv:Body",
            xmlelement("ser:createAndAllocateConsignmentsWithBookingCode",
            xmlattributes('http://schemas.xmlsoap.org/soap/encoding/' as "soapenv:encodingStyle"),
                xmlelement("consignments",
                    xmlattributes('ser:ArrayOf_tns1_Consignment' as "xsi:type",
                    'typ:Consignment[]' as "soapenc:arrayType",
                    'urn:DeliveryManager/types' as "xmlns:typ"),
                    xmlelement("item",
                        xmlelement("custom1",
                            xmlattributes('soapenc:string' as "xsi:type"),
                            'DC Loc Ref : C-1'),
                        xmlelement("custom2",
                            xmlattributes('soapenc:string' as "xsi:type"),
                            'Store No. : ^40'),
                        xmlelement("custom3",
                            xmlattributes('soapenc:string' as "xsi:type"),
                            'Label Date: ^28 Dec 2016'),
                        xmlelement("custom6",
                            xmlattributes('soapenc:string' as "xsi:type"),
                            'Cage Ref:'),
                        xmlelement("custom8",
                            xmlattributes('soapenc:string' as "xsi:type"),
                            '@29/*/*-*/*/*-23:59'),
                        xmlelement("orderNumber",
                            xmlattributes('soapenc:string' as "xsi:type"),
                            '-123501'),
                        xmlelement("parcelCount",
                            xmlattributes('xsd:int' as "xsi:type"),
                            '1')
                    )
                )
           )
        )
       )
from dual

select * from table(oms_click_collect.f_get_tote_label(1,1,1));


CREATE OR REPLACE TYPE OmsPdfLabel
AS OBJECT
(
  PACKAGE_DOC_ID             NUMBER(10),
  ORDER_ID                   NUMBER(10)
)
/

CREATE OR REPLACE TYPE OmsPdfLabelTab
   AS TABLE OF OmsPdfLabel;
/


