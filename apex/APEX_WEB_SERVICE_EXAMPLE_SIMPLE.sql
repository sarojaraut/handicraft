--Inside WSDL
-- Finding endpoint(p_url) search for soap:address  = http://ws.cdyne.com/ip2geo/ip2geo.asmx
-- Locate the SOAP action(p_action), find the soapAction attribute of the soap:operation = http://ws.cdyne.com/ResolveIP


set serveroutput on;

DECLARE
  l_envelope  CLOB;
  l_xml       XMLTYPE;
  l_result    VARCHAR2(32767);
BEGIN

  -- Build a SOAP document appropriate for the web service.
  l_envelope := '<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope">
<SOAP-ENV:Body>
<ns1:ResolveIP xmlns:ns1="http://ws.cdyne.com/">
<ns1:ipAddress>216.15.156.240</ns1:ipAddress>
<ns1:licenseKey>0</ns1:licenseKey>
</ns1:ResolveIP>
</SOAP-ENV:Body>
</SOAP-ENV:Envelope>';

  -- Get the XML response from the web service.
  l_xml := APEX_WEB_SERVICE.make_request(
    p_url      => 'http://ws.cdyne.com/ip2geo/ip2geo.asmx',
    p_action   => 'http://ws.cdyne.com/ResolveIP',
    p_envelope => l_envelope
  );

  -- Display the whole SOAP document returned.
  DBMS_OUTPUT.put_line('l_xml=' || l_xml.getClobVal());

END;
/


