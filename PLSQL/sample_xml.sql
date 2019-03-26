-- Tips : fixing Invalid XML using notepad++: if yuo try to validate xml it ill throw line numbers where error, look for mismatch starting and closing tags, extra spaces
create table sample_xml( id number, xml_data xmltype)

insert into sample_xml values(1,
'<html xmlns:ac="http://ac" xmlns:ri="http://ri">
	<h2>Section 1</h2>
	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vel egestas arcu.  Nullam lobortis iaculis arcu, vitae sagittis massa pharetra a. Phasellus nec rutrum nisl. Etiam non ve lit augue.</p>
	<p>
		<ac:image ac:width="600">
			<ri:attachment ri:filename="somepic_on_page1.png" ri:description="Description of somepic on page 1"/>
		</ac:image>
	</p>
	<h2>Section 2</h2>
	<h3>Subsection 2.1</h3>
	<ul>
		<li>First List, Item 1, page 1</li>
		<li>First List, Item 2, page 1</li>
		<li>First List, Item 3, page 1</li>
		<li>First List, Item 4, page 1</li>
	</ul>
	<h3>Subsection 2.2</h3>
	<ul>
		<li>Second List, Item 1, page 1</li>
		<li>Second List, Item 2, page 1</li>
		<li>Second List, Item 3, page 1</li>
	</ul>
	<h2>Table 1</h2>
	<table >
		<tbody>
			<tr>
				<th>Table 1, Column A, page 1</th>
				<th>Table 1, Column B, page 1</th>
				<th colspan="1">Column  C</th>
			</tr>
			<tr>
				<td>Table 1, Row 1, Column A, page 1</td>
				<td>Table 1, Row 1, Column B, page 1</td>
				<td  colspan="1">Row 2, Column C</td>
			</tr>
		</tbody>
	</table>
	<h2>Section 3</h2>
	<h3>Subsection 3.1</h3><p>Inter dum et malesuada fames ac ante ipsum primis in faucibus. Praesent lobortis, libero sed cursus sollicit udin, felis nisl pharetra lectus, sit amet aliquam dui nulla nec lacus.</p>
	<h3>Subsection 3.2</h3><p>
		<ac:image>
			<ri:attachment ri:filename="anotherpic_on_page1.png" ri:description="Description of anotherpi c on page 1"/>
		</ac:image>
	</p>
	<h3>Subsection 3.3</h3>
	<ul>
		<li>Third List, Item 1, page 1</li>
		<li>Third L ist, Item 2, page 1</li>
		<li>Third List, Item 3, page 1</li>
		<li>Third List, Item 4, page 1</li>
		<li>Thir d List, Item 5, page 1</li>
	</ul>
	<h3>Subsection 3.4</h3><p>Ut ut lectus eget felis ullamcorper maximus.  Phasellus nunc diam, egestas a ante a, placerat volutpat augue.</p>
	<h3>Table 2</h3>
	<table>
		<tbody>
			<tr>
				<th>Table 2, Column A, page 1</th>
				<th colspan="1">Table 2, Column B, page 1</th>
				<th>Table 2, Column C,  page 1</th>
			</tr>
			<tr>
				<td colspan="1">Table 2, Row 1, Column A, page 1</td>
				<td colspan="1">Table 2, Row  1, Column B, page 1</td>
				<td colspan="1">Table 2, Row 1, Column C, page 1</td>
			</tr>
			<tr>
				<td colspan="1" >Table 2, Row 2, Column A, page 1</td>
				<td colspan="1">Table 2, Row 2, Column B, page 1</td>
				<td colspan ="1">Table 2, Row 2, Column C, page 1</td>
			</tr>
		</tbody>
	</table>
	<h2>Section 4</h2><p>Quisque finibus pr etium posuere. Cras id dui nunc. </p>
	<h2>Table 3</h2>
	<table>
		<tbody>
			<tr>
				<th>Table 3, Column A, page 1</th>
				<th>Table 3, Column B, page 1</th>
			</tr>
			<tr>
				<td>Table 3, Row 1, Column A, page 1</td>
				<td>Table 3, Ro w 1, Column B, page 1</td>
			</tr>
		</tbody>
	</table>
	<h2>Section 5</h2><p>
		<a href="http://link.to/another/page">Page Link, page 1</a>
	</p><p>
		<a href="http://link.to/yetanother/page">Another Page Link, page 1</a>
	</p><p/>
	<p/>
</html>'
);

--Queries
SELECT x.id, x.list_item
FROM sample_xml x,
      XMLTable(
--            XMLNamespaces('http://ac' as "ac", 'http://ri' as "ri"),
            '/html/ul[preceding-sibling::h3[text()="Subsection 2.2"]]/li'
            PASSING xml_data
            COLUMNS list_item VARCHAR2(1024) PATH 'text()'
      ) x;

--Requirement A (Extract list data from Subsection 2.2)
SELECT x.id, x.list_item
FROM sample_xml x,
      XMLTable(
            XMLNamespaces('http://ac' as "ac", 'http://ri' as "ri"), -- work without this line
            '/html/ul[preceding-sibling::h3[text()="Subsection 2.2"]][1]/li'
            PASSING xml_data
            COLUMNS list_item VARCHAR2(1024) PATH 'text()'
      ) x;
	  
	  
--Requirement B (Extract table data from Table 3):

SELECT h.id, x.first_td_column, x.second_td_column, x.third_td_column
FROM sample_xml h,
     XMLTable(
          XMLNamespaces('http://ac' as "ac", 'http://ri' as "ri"),
          '/html/table[preceding-sibling::h3[text()="Table 2"]][1]/tbody/tr[td]'
          PASSING xml_data
          COLUMNS first_td_column  VARCHAR2(1024) PATH 'td[1]/text()',
                  second_td_column VARCHAR2(1024) PATH 'td[2]/text()',
                  third_td_column  VARCHAR2(1024) PATH 'td[3]/text()'
     ) x;
	 
	 
--Requirement C (Extract all image names and their descriptions):

SELECT h.id, x.image_name, x.description
FROM sample_xml h,
     XMLTable(
         XMLNamespaces('http://ac' as "ac", 'http://ri' as "ri"), -- this query will not work without namespaces
         '//ac:image/ri:attachment' -- can be also epscified as html//p/ac:image/ri:attachment
         PASSING xml_data
         COLUMNS image_name VARCHAR2(1024) PATH '@ri:filename',
                 description VARCHAR2(1024) PATH '@ri:description'
     ) x;
	 
Breakdown of how the XPath works

Analyzing: /html/ul[preceding-sibling::h3[text()=”Subsection 2.2″]][1]/li

1. /html/ul – identifies all of the “ul” elements that are children of the “html” element. 
2. The “ul” portion of the XPath has a predicate [preceding-sibling::h3[text()=”Subsection 2.2″]][1] which we’ll break in to 3 parts and you can think of them as being 3 conditions ANDed together in a where clause

a. preceding-sibling::h3 – only include “ul” elements that are preceded by a sibling element with name “h3”. All 3 of the “ul” elements meet this criteria, because they all have an “h3” element that appears before them as a sibling (i.e. a child under the same parent). The “h3” can occur anywhere before them, and doesn’t have to be immediately before.

b. h3[text()=”Subsection 2.2″] – this further clarifies that the “h3” element must contain the text “Subsection 2.2”, which causes the very first “ul” element to be filtered out, because it appears before the “h3” that contains “Subsection 2.2.” 

c. [1] – this applies to the “ul” elements that remain after the above 2 criteria have been applied and is an index. It identifies the first “ul” that meets the above criteria and leaves us with only a single “ul” element. The “ul” that is after “Subsection 3.3” would be at index 2. See the blue box.

3. li – The final part of the XPath “/li” identifies all of the “li” elements that are children of the identified “ul” element, and so our result is a sequence of “li” elements.

http://www.ateam-oracle.com/using-xmltable-and-xmltype-to-extract-html-clob-data/
