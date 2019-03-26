set serveroutput on;

DECLARE
  l_envelope    CLOB;
  l_xml         XMLTYPE;
  l_result      VARCHAR2(32767);
  l_shipmentXml VARCHAR2(32767);
BEGIN
  -- Build a SOAP document appropriate for the web service.
  l_envelope := '<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <doImport xmlns="http://tempuri.org/">
      <user>t7IpEyMDwss=</user>
      <password>string</password>
<shipmentXml><Shipments xmlns="uriXmlSchema"><ROW><FF_SHORT_NAME>WT</FF_SHORT_NAME><TRANSPORT_METHOD_SHORT_NAME>AIR</TRANSPORT_METHOD_SHORT_NAME><SHIPMENT_NUMBER>17659783850</SHIPMENT_NUMBER><SHIPMENT_NAME>EK9873</SHIPMENT_NAME><DESPATCH_POINT_SHORT_NAME>CN</DESPATCH_POINT_SHORT_NAME><DESPATCH_PORT_SHORT_NAME>SHA</DESPATCH_PORT_SHORT_NAME><DESTINATION_SHORT_NAME>LHR</DESTINATION_SHORT_NAME><ETD_DT>2014-01-19T0:0:0.000</ETD_DT><ETA_DT></ETA_DT><ACTUAL_ARRIVAL_DT>2014-01-20T0:0:0.000</ACTUAL_ARRIVAL_DT><SHIPMENT_DTL_NUMBER>TSHA1218920</SHIPMENT_DTL_NUMBER><SEAL_NUMBER></SEAL_NUMBER><SHIPMENT_DTL_TYPE_SHORT_NAME></SHIPMENT_DTL_TYPE_SHORT_NAME><SHIPMENT_DTL_SIZE_SHORT_NAME></SHIPMENT_DTL_SIZE_SHORT_NAME><TOT_GROSS_WEIGHT>252</TOT_GROSS_WEIGHT><TOT_VOL_WEIGHT>252</TOT_VOL_WEIGHT><TOT_CBM></TOT_CBM><TOT_CARTON>13</TOT_CARTON><TOT_HANGING></TOT_HANGING><PO_NUMBER>526193</PO_NUMBER><PO_LINE_NUMBER>807770</PO_LINE_NUMBER><PRD_LVL_NUMBER>9567</PRD_LVL_NUMBER><LINE_SHIPMENT_QTY>638</LINE_SHIPMENT_QTY><LINE_CARTONS>6</LINE_CARTONS><LINE_GROSS_WEIGHT>116.308</LINE_GROSS_WEIGHT><LINE_VOL_WEIGHT>116.308</LINE_VOL_WEIGHT><FF_REF>STSHA1218920</FF_REF><CUSTOM_CLR_DT></CUSTOM_CLR_DT><STATUS_ONE_DT></STATUS_ONE_DT><CUSTOM_ENT_NUMBER></CUSTOM_ENT_NUMBER><DESTINATION_DC_SHORT_NAME>MAG</DESTINATION_DC_SHORT_NAME><SHIPMENT_COMMENT></SHIPMENT_COMMENT><APPROVAL_ID></APPROVAL_ID><TRUCK_TRAILER_SHORT_NAME></TRUCK_TRAILER_SHORT_NAME><POSITION_CODE></POSITION_CODE><READY_FOR_DELIVERY_DT>2014-01-21T0:0:0.000</READY_FOR_DELIVERY_DT><BILL_OF_LADING_NUMBER></BILL_OF_LADING_NUMBER><CBM></CBM><CFSP_REF></CFSP_REF><DELETE_IND>N</DELETE_IND><ACTUAL_TRANSPORT_SHORT_NAME>AIR</ACTUAL_TRANSPORT_SHORT_NAME><INVOICE_NUMBER>CLE14009</INVOICE_NUMBER><FREIGHT_PAID_BY>RI</FREIGHT_PAID_BY></ROW></Shipments></shipmentXml>
    </doImport>
  </soap:Body>
</soap:Envelope>';

  -- Get the XML response from the web service.
  l_xml := APEX_WEB_SERVICE.make_request(
    p_url      => 'http://ri2k3web180:8101/ACSshipmentimport.asmx',
    p_action   => 'http://tempuri.org/doImport',
    p_envelope => l_envelope
  );

  -- Display the whole SOAP document returned.
 DBMS_OUTPUT.put_line('l_xml=' || l_xml.getClobVal());
  
/*   -- Pull out the specific value of interest.
  l_result := APEX_WEB_SERVICE.parse_xml(
    p_xml   => l_xml,
    p_xpath => '//ResolveIPResponse/ResolveIPResult/StateProvince',
    p_ns    => 'xmlns="http://ws.cdyne.com/"'
  );
  
  DBMS_OUTPUT.put_line('l_result=' || l_result);

  */
  
END;
/

user = t7IpEyMDwss=
Password : g6oQdQJO7/cD0XoKkucymA==

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <doImport xmlns="http://tempuri.org/">
      <user>t7IpEyMDwss=</user>
      <password>string</password>
      <shipmentXml><Shipments xmlns='uriXmlSchema'><ROW><FF_SHORT_NAME>WT</FF_SHORT_NAME><TRANSPORT_METHOD_SHORT_NAME>AIR</TRANSPORT_METHOD_SHORT_NAME><SHIPMENT_NUMBER>17659783850</SHIPMENT_NUMBER><SHIPMENT_NAME>EK9873</SHIPMENT_NAME><DESPATCH_POINT_SHORT_NAME>CN</DESPATCH_POINT_SHORT_NAME><DESPATCH_PORT_SHORT_NAME>SHA</DESPATCH_PORT_SHORT_NAME><DESTINATION_SHORT_NAME>LHR</DESTINATION_SHORT_NAME><ETD_DT>2014-01-19T0:0:0.000</ETD_DT><ETA_DT></ETA_DT><ACTUAL_ARRIVAL_DT>2014-01-20T0:0:0.000</ACTUAL_ARRIVAL_DT><SHIPMENT_DTL_NUMBER>TSHA1218920</SHIPMENT_DTL_NUMBER><SEAL_NUMBER></SEAL_NUMBER><SHIPMENT_DTL_TYPE_SHORT_NAME></SHIPMENT_DTL_TYPE_SHORT_NAME><SHIPMENT_DTL_SIZE_SHORT_NAME></SHIPMENT_DTL_SIZE_SHORT_NAME><TOT_GROSS_WEIGHT>252</TOT_GROSS_WEIGHT><TOT_VOL_WEIGHT>252</TOT_VOL_WEIGHT><TOT_CBM></TOT_CBM><TOT_CARTON>13</TOT_CARTON><TOT_HANGING></TOT_HANGING><PO_NUMBER>526193</PO_NUMBER><PO_LINE_NUMBER>807770</PO_LINE_NUMBER><PRD_LVL_NUMBER>9567</PRD_LVL_NUMBER><LINE_SHIPMENT_QTY>638</LINE_SHIPMENT_QTY><LINE_CARTONS>6</LINE_CARTONS><LINE_GROSS_WEIGHT>116.308</LINE_GROSS_WEIGHT><LINE_VOL_WEIGHT>116.308</LINE_VOL_WEIGHT><FF_REF>STSHA1218920</FF_REF><CUSTOM_CLR_DT></CUSTOM_CLR_DT><STATUS_ONE_DT></STATUS_ONE_DT><CUSTOM_ENT_NUMBER></CUSTOM_ENT_NUMBER><DESTINATION_DC_SHORT_NAME>MAG</DESTINATION_DC_SHORT_NAME><SHIPMENT_COMMENT></SHIPMENT_COMMENT><APPROVAL_ID></APPROVAL_ID><TRUCK_TRAILER_SHORT_NAME></TRUCK_TRAILER_SHORT_NAME><POSITION_CODE></POSITION_CODE><READY_FOR_DELIVERY_DT>2014-01-21T0:0:0.000</READY_FOR_DELIVERY_DT><BILL_OF_LADING_NUMBER></BILL_OF_LADING_NUMBER><CBM></CBM><CFSP_REF></CFSP_REF><DELETE_IND>N</DELETE_IND><ACTUAL_TRANSPORT_SHORT_NAME>AIR</ACTUAL_TRANSPORT_SHORT_NAME><INVOICE_NUMBER>CLE14009</INVOICE_NUMBER><FREIGHT_PAID_BY>RI</FREIGHT_PAID_BY></ROW></Shipments></shipmentXml>
    </doImport>
  </soap:Body>
</soap:Envelope>

--- HELP
-- http://ri2k3web180:8101/RI.Application.Shipping.Service.WebAPI/GetPO
-- Parameters of APEX_WEB_SERVICE.make_request search Inside WSDL
-- Finding endpoint(p_url) search for soap:address  = http://ws.cdyne.com/ip2geo/ip2geo.asmx
-- Locate the SOAP action(p_action), find the soapAction attribute of the soap:operation = http://ws.cdyne.com/ResolveIP
-- Parameters for APEX_WEB_SERVICE.parse_xml
-- p_xpath is the xpath to the element to be searched
-- p_ns is the xml name space as appearing in the response

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
  
   -- Pull out the specific value of interest.
  l_result := APEX_WEB_SERVICE.parse_xml(
    p_xml   => l_xml,
    p_xpath => '//ResolveIPResponse/ResolveIPResult/StateProvince',
    p_ns    => 'xmlns="http://ws.cdyne.com/"'
  );
  
  DBMS_OUTPUT.put_line('l_result=' || l_result);

END;
/




/*

Example Response XML

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<soap:Body>
<ResolveIPResponse xmlns="http://ws.cdyne.com/">
	<ResolveIPResult>
		<City>St Louis</City>
		<StateProvince>MO</StateProvince>
		<Country>United States</Country>
		<Organization />
		<Latitude>38.6273</Latitude>
		<Longitude>-90.1979</Longitude>
		<AreaCode>314</AreaCode>
		<TimeZone />
		<HasDaylightSavings>false</HasDaylightSavings>
		<Certainty>90</Certainty>
		<RegionName />
		<CountryCode>US</CountryCode>
	</ResolveIPResult>
</ResolveIPResponse>
</soap:Body>
</soap:Envelope>

p_xpath => ' //GetTheatersAndMoviesResponse/GetTheatersAndMoviesResult/Theater/Movies/Movie/Name[1]',
p_ns => ' xmlns="http://www.ignyte.com/whatsshowing"'


APEX_WEB_SERVICE.parse_xml

p_xml
The XML document as an XMLTYPE to parse.
p_xpath
The XPath expression to the desired node.
p_ns
The namespace to the desired node.



<?xml version="1.0" encoding="UTF-8"?>

<bookstore>

<book category="COOKING">
  <title lang="en">Everyday Italian</title>
  <author>Giada De Laurentiis</author>
  <year>2005</year>
  <price>30.00</price>
</book>

<book category="CHILDREN">
  <title lang="en">Harry Potter</title>
  <author>J K. Rowling</author>
  <year>2005</year>
  <price>29.99</price>
</book>

<book category="WEB">
  <title lang="en">XQuery Kick Start</title>
  <author>James McGovern</author>
  <author>Per Bothner</author>
  <author>Kurt Cagle</author>
  <author>James Linn</author>
  <author>Vaidyanathan Nagarajan</author>
  <year>2003</year>
  <price>49.99</price>
</book>

<book category="WEB">
  <title lang="en">Learning XML</title>
  <author>Erik T. Ray</author>
  <year>2003</year>
  <price>39.95</price>
</book>

</bookstore> 

XPATH examples :

/bookstore/book/title : selects all the title nodes
/bookstore/book[1]/title : The following example selects the title of the first book node under the bookstore element:
/bookstore/book/price[text()] : The following example selects the text from all the price nodes:
/bookstore/book[price>35]/price  : The following example selects all the price nodes with a price higher than 35
/bookstore/book[price>35]/title  : The following example selects all the title nodes with a price higher than 35

*/)

