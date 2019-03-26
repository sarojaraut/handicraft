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

-- Above query returns as three fragments in three separate rows.

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
                  'http://schemas.xmlsoap.org/soap/envelope/' as "soapenv"
                     , 'http://soap.service.****.com' as "soap"
                     , 'http://www.w3.org/2001/XMLSchema-instance' as "xsi"
                          )
               , '/soapenv:Envelope/soapenv:Body/soap:UpdateElem/soap:request'
               passing xt.xmlmsg
               columns
                   att1 number path 'soap:att1'
                   , att2 varchar2(10) path 'soap:att2/@xsi:nil'
                   , att3 char(1) path 'soap:att3'
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


