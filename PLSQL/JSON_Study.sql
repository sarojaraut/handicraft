Oracle 18c onwards json feature has been greatly 

The Oracle default syntax for JSON is lax. In particular: it reflects the JavaScript
syntax for object fields; the Boolean and null values are not case-sensitive; and it
is more permissive with respect to numerals, whitespace, and escaping of Unicode
characters.

The default JSON syntax for Oracle Database is lax. Strict or lax syntax matters
only for SQL/JSON conditions is json and is not json. All other SQL/JSON
functions and conditions use lax syntax for interpreting input and strict syntax
when returning output.


CONSTRAINT ensure_json CHECK (po_document IS JSON (STRICT))

You can query JSON data using a simple dot notation or, for more functionality, using
SQL/JSON functions and conditions. 

In its simplest form a path expression consists
of one or more field names separated by periods (.). More complex path expressions
can contain filters and array indexes.


The return value for a dot-notation query is always a string (data type VARCHAR2)
representing JSON data. The content of the string depends on the targeted JSON
data, as follows:
•
If a single JSON value is targeted, then that value is the string content, whether it
is a JSON scalar, object, or array.
•
If multiple JSON values are targeted, then the string content is a JSON array
whose elements are those values.
This behavior contrasts with that of SQL/JSON functions json_value and json_query,
which you can use for more complex queries. They can return NULL or raise an error if
the path expression you provide them does not match the queried JSON data. They
accept optional clauses to specify the data type of the return value (RETURNING clause),
whether or not to wrap multiple values as an array (wrapper clause), how to handle
errors generally (ON ERROR clause), and how to handle missing JSON fields (ON EMPTY
clause).


dot notation field names are case sensitive 
table aias is mandatory 
and is json check constraint is amndatory in the table column
po.po_document.LineItems[*] – All of the elements of array LineItems (* is a wildcard).
po.po_document.LineItems[1] – The second element of array LineItems (array positions are zero-based).
A simple dot-notation JSON query cannot return a value longer than 4K bytes. If the value surpasses this limit then SQL NULL is returned instead. To obtain the actual value, use SQL/JSON function json_query or json_value instead of dot notation, specifying an appropriate return type with a RETURNING clause.


JSON Dot-Notation Query Compared With JSON_QUERY
SELECT po.po_document.ShippingInstructions.Phone FROM j_purchaseorder po;
SELECT json_query(po_document, '$.ShippingInstructions.Phone')
FROM j_purchaseorder;

SELECT po.po_document.ShippingInstructions.Phone.type FROM j_purchaseorder po;
SELECT json_query(po_document, '$.ShippingInstructions.Phone.type' WITH WRAPPER)
FROM j_purchaseorder;


SQL/JSON Path Expression Syntax
The optional filter expression can be present only when the path expression is used in SQL condition json_exists. No steps can follow the filter expression. (This is not allowed, for example: $.a?(@.b == 2).c.)
An absolute simple path expression begins with a dollar sign ($), which represents the path-expression context item, that is, the JSON data to be matched.
The dollar sign is followed by zero or more path steps. Each step can be an object step or an array step,
An object step is a period (.), sometimes read as "dot", followed by an object field name (object property name) or an asterisk (*) wildcard, which stands for (the values of) all fields. 
An array step is a left bracket ([) followed by either an asterisk (*) wildcard, which stands for all array elements, or one or more specific array indexes or range specifications separated by commas, followed by a right bracket (]). 
A single function step is optional. If present, it is the last step of the path expression. It is a dot (.), followed by a SQL/JSON item method. 
If an item method is applied to an array, it is in effect applied to each of the array elements. 

The available item methods are : abs(),  ceiling(), date(), length(), lower(), upper(), timestamp()
A filter expression (filter, for short) is a question mark (?) followed by a filter condition enclosed in parentheses (()). 
Filter condition predicates can be joined with &&, ||, !, 
A simple path expression is either an absolute simple path expression or a
relative simple path expression. (The former begins with $; the latter begins with @.)

$.friends[*].name – Value of field name of each object in an array that is the value of field friends of a context-item object.
$.*[*].name – Field name values for each object in an array value of a field of a context-item object.
$.friends[3, 8 to 10, 12] – The fourth, ninth through eleventh, and thirteenth elements of an array friends (field of a context-item object). The elements must be specified in ascending order
$.friends[3].cars[0]?(@.year > 2014) – The first object of an array cars (field of an object that is the fourth element of an array friends), provided that the value of its field year is greater than 2014.

$.friends[3]?(@.addresses.city == "San Francisco" && @.addresses.state == "Nevada") – Objects that are the fourth element of an array friends, provided that there is a match for an address with a city of "San Francisco" and there is a match for an address with a state of "Nevada".
Note: The filter conditions in the conjunction do not necessarily apply to the same object — the filter tests for the existence of an object with city San Francisco and for the existence of an object with state Nevada. It does not test for the existence of an object with both city San Francisco and state Nevada.

$.friends[3].addresses?(@.city == "San Francisco" && @.state == "Nevada") – An object that is the fourth element of array friends, provided that object has a match for city of "San Francisco" and a match for state of "Nevada". Unlike the preceding example, in this case the filter conditions in the conjunction, for fields city and state, apply to the same addresses object.

The basic SQL/JSON path-expression syntax is relaxed to allow implicit array wrapping and unwrapping. This means that the object step [*].prop, which stands for the value of field prop of each element of a given array of objects, can be abbreviated as .prop, and the object step .prop, which looks as though it stands for the prop value of a single object, stands also for the prop value of each element of an array to which the object accessor is applied. Path expression $.Phone.number matches either a single phone object, selecting its number, or an array of phone objects, selecting the number of each.

$.friends[0].name : equivalents are $.friends.name,  $[*].friends.name, $[*].friends[0].name

RETURNING Clause for SQL/JSON Query Functions
for json_value : VARCHAR2, NUMBER, DATE, TIMESTAMP
for json_query : VARCHAR2
later in 18c clob is added to both 

WITH WRAPPER, WITHOUT WRAPPER , WITH CONDITIONAL WRAPPER 

The optional error clause can take these forms:
•  ERROR ON ERROR – Raise the error (no special handling).
•  NULL ON ERROR – Return NULL instead of raising the error. Not available for json_exists.
•  FALSE ON ERROR, TRUE ON ERROR  – Return false instead of raising the error. Available only for json_exists, for which it is the default.
EMPTY OBJECT ON ERROR – Return an empty object ({}) instead of raising the error. Available only for json_query.
EMPTY ARRAY ON ERROR – Return an empty array ([]) instead of raising the error. Available only for json_query.
EMPTY ON ERROR – Same as EMPTY ARRAY ON ERROR. DEFAULT 'literal_return_value' ON ERROR – Return the specified value instead of raising the error. The value must be a constant at query compile time.






with tmp as
(
select
    'F'||rownum   f_name
    ,'L'||rownum  l_name
from dual
connect by rownum <=3
),
tmp_json as(
select 
    json_object(
    'emps' is
        json_arrayagg(
            json_object(
                key  'f_name' value f_name
                ,key 'l_name' value l_name
            returning clob
            )
        )
    ) val
from tmp
)
select 
    td.* 
from tmp_json t,
    json_table( -- JSON_TABLE creates a relational view of JSON data. It maps the result of a JSON data evaluation into relational rows and columns. 
        t.val
        ,'$.emps[*]' --  row path expression
        columns  
        -- The COLUMNS clause evaluates the row source, finds specific JSON values within the row source, 
        -- and returns those JSON values as SQL values in individual columns of a row of relational data.
        (
            f_name varchar2(30)  path '$.f_name'
            ,l_name varchar2(30) path '$.l_name'
        )
) td;


SELECT jt.phones
FROM j_purchaseorder,
    JSON_TABLE(po_document, '$.ShippingInstructions'
        COLUMNS(
            phones VARCHAR2(100) FORMAT JSON PATH '$.Phone'
        )
    ) AS jt;

PHONES
-------------------------------------------------------------------------------------
[{"type":"Office","number":"909-555-7307"},{"type":"Mobile","number":"415-555-1234"}]

SELECT jt.*
FROM j_purchaseorder,
JSON_TABLE(po_document, '$.ShippingInstructions.Phone[*]'
COLUMNS (row_number FOR ORDINALITY,
         phone_type VARCHAR2(10) PATH '$.type',
         phone_num VARCHAR2(20) PATH '$.number'))
AS jt;

ROW_NUMBER PHONE_TYPE PHONE_NUM
---------- ---------- --------------------
         1 Office     909-555-7307
         2 Mobile     415-555-1234



with tmp as(
select 
    json_object(
        'info' is
            json_arrayagg( 
                json_object(
                    'name' is 'name_'||rownum
                    ,'val' is 'val_'||rownum
                    returning clob
                )
                returning clob
            ) 
    )jsn
from dual
connect by rownum <=2
)
select t.name, t.val
from tmp ,
    json_table(
        tmp.jsn
        ,'$.info[*]'
        columns(
            name    varchar2(10) path '$.name'
            ,val    varchar2(10) path '$.val'
        ) 
    ) t;

select
    json_object(
    'data' is
        json_arrayagg(
            json_object(
                'ucas_code'         value ucas_code
                ,'course_title'      value course_title
                ,'tariff_advertised' value tariff_advertised
            )
        returning clob)
    returning clob
    )
from clr_course;

with person as(
select 
    dbms_random.string('u',10)       username -- u - upper case, l - lower case, x - alpha numeric, 
    ,dbms_random.string('p',10)      password -- p - any printable including special character
    ,round(dbms_random.value(1,100)) age
    ,round(dbms_random.value,5)      probability  -- int between 0 and 1
    ,round(dbms_random.value(1,5))   turns
from dual
connect by rownum < 100
)
,dice_rolls as(
select
    username
    ,turns
    ,round(dbms_random.value(1,5))   dice
from person
connect by rownum <= turns
)
select 
    json_object(
    'username'     value p.username
    ,'password'    value p.password
    ,'age'         value p.age
    ,'probability' value p.probability
    ,'turns'       value p.turns
    ) as rec
from person p
join dice_rolls dr
on p.username=dr.username;

with t as (
select 
    rownum rn
from dual
connect by rownum < 10
)
select 
    json_arrayagg(rn)
from t;

-- JSON_OBJECT(KEY key_expr VALUE value_expr FORMAT JSON NULL ON NULL RETURNING CLOB)


with lists as(
    select 
        'ANALYST,CLERK,MANAGER,PRESIDENT'      jobs,
        'ACCOUNTING,OPERATIONS,RESEARCH,SALES' depts
    from dual
),
jobs as(
    select
        rownum-1 job_id
        ,regexp_substr(jobs,'[^,]+',1,rownum) job
    from lists
    connect by rownum <= regexp_count(jobs,',')+1
),
depts as(
    select
        rownum dept_id
        ,regexp_substr(depts,'[^,]+',1,rownum) dept
    from lists
    connect by rownum <= regexp_count(depts,',')+1
),
emps as(
    select 
        rownum                                   as empno
        ,'E_'||rownum                            as ename
        , mod(rownum,4)                          as job_id
        , mod(rownum,5)                          as dept_id 
        , round(dbms_random.value(30000,100000)) as sal
        , dbms_random.string('u',10)             as rand_string -- u upper case, l lower case, x alphanum, p, printable including special chars
    from dual
    connect by rownum < =10
),
emps_json as(
    select 
        json_object(
        'emps' is
            json_arrayagg(
                json_object(
                    key  'empno'          value e.empno
                    ,key 'ename'          value e.ename
                    ,key 'sal'            value e.sal
                    ,key 'rand_string'    value e.rand_string
                    ,key 'job '           value j.job 
                    ,key 'dept'           value json_object(
                                                key 'name' value d.dept 
                                                absent on null)
                    absent on null
                    returning  clob
                )
                returning  clob
            )
        ) as json_val
    from emps e
    left join jobs j
    on e.job_id = j.job_id
    left join depts d
    on e.dept_id = d.dept_id
)
select * 
from emps_json;


with ord as (
select 
'{
    "id": "abece703-bbfa-4250-b1a9-8abb7e5c64d6",
    "order": {
        "orderId": "a8924325-f46c-4b3e-8df2-a77ea9444ea8",
        "externalIds": [
            {
                "systemId": "S1",
                "externalId": "EXT-1"
            },
            {
                "systemId": "S2",
                "externalId": "EXT-2"
            }
        ],
        "customer": {
            "customerId": "5181166",
            "email": "firstname.surname@xyz.com"
        },
        "productLineItems": [
            {
                "productId": "P1",
                "skuId": "SKU1",
                "priceAdjustments": [
                    {
                        "couponCode": "ORDER10"
                    },
                    {
                        "couponCode": "ORDER11"
                    }
                ],
                "basePrice": 1600
            },
            {
                "productId": "P2",
                "skuId": "SKU2"
            }
        ]
    }
}' json
from dual
)
select 
    d.*
from ord o,
JSON_TABLE(
    o.json ,
    '$'
    columns (
        externalId         varchar2(20 char)     path '$.order.externalIds[0].externalId',
        email              varchar2(32 char)     path '$.order.customer.email',
        nested PATH '$.order.productLineItems[*]'
        columns (
            sku_row_number  FOR ORDINALITY,
            productId         varchar2(38)       path '$.productId',
            skuId             varchar2(14)       path '$.skuId',
            has_promo         varchar2(5) exists path '$.priceAdjustments',
            nested PATH '$.priceAdjustments[*]'
            columns(
                discount_row_number  FOR ORDINALITY,
                couponCode        varchar2(30)       path '$.couponCode'
            )
        )
    )
) d
/

JSON_VALUE:  to select one scalar value in the JSON data and return it to SQL. (JSON_VALUE is the ‘bridge’ from a JSON value to a SQL value).
JSON_EXISTS: a Boolean operator typically used in the WHERE clause to filter rows based on properties in the JSON data.
JSON_QUERY: an operator to select (scalar or complex) value in the JSON data. In contrast to JSON_VALUE which always returns one scalar value, JSON_QUERY returns a JSON value (object or array). With JSON_QUERY a user can also select multiple values and have them wrapped inside a JSON array.
JSON_TABLE: the most powerful operator that exposes JSON data as a relational view. With JSON_TABLE you can turn your JSON data into a relational representation.

with temp as (
    select '{"name": "black","rgb": [0,0,0],"hex": "#000000"}' color from dual
    union
    select '{"name": "orange red","rgb": [255,69,0],"hex": "#FF4500"}' color from dual
    union
    select '{"name": "dark orange","rgb": [255,140,0],"hex": "#FF8C00"}' color from dual
)
select JSON_VALUE(color, '$.name') from  temp;
-- black
-- dark orange
-- orange red

/*
The JSON_VALUE function also provides options for handling errors that might be encountered when applying the JSON PATH expression to a JSON document. Options available include:
NULL ON ERROR: The default. If an error is encountered while applying a JSON path expression to a JSON document the result is assumed to be SQL NULL and no error is raised.
ERROR ON ERROR: An error is raised in the event that an error is encountered while applying a JSON path expression to a JSON document.
DEFAULT on ERROR: The developer specifies a literal value that is returned in the event that an error is encountered while applying a JSON path expression to a JSON document.
*/

-- RETURNING is optional but we can set a data type and field length
-- but if one of the value is exceeding the field length then that will be defaulted to null by default
-- we can change the behaviour e.g 
-- RETURNING VARCHAR2(10) TRUNCATE will truncate the value to length 10
-- RETURNING VARCHAR2(10) ERROR ON ERROR will trow error
-- RETURNING VARCHAR2(10) DEFAULT '#BADCOLOR#' ON ERROR will default to this value
with temp as (
    select '{"name": "black","rgb": [0,0,0],"hex": "#000000"}' color from dual
    union
    select '{"name": "orange red","rgb": [255,69,0],"hex": "#FF4500"}' color from dual
    union
    select '{"name": "dark orange","rgb": [255,140,0],"hex": "#FF8C00"}' color from dual
)
select 
json_value(color, '$.name' RETURNING VARCHAR2(10)) "NAME"
from  temp;
-- black
-- NULL
-- orange red

with temp as (
    select '{"name": "black","rgb": [0,0,0],"hex": "#000000"}' color from dual
    union
    select '{"name": "orange red","rgb": [255,69,0],"hex": "#FF4500"}' color from dual
    union
    select '{"name": "dark orange","rgb": [255,140,0],"hex": "#FF8C00"}' color from dual
)
select 
    json_value(color, '$.name' RETURNING VARCHAR2(10) default 'NO_COLOUR' ON ERROR) "NAME",
    json_value(color, '$.rgb[0]' RETURNING NUMBER) "RED",
    json_value(color, '$.rgb[1]' RETURNING NUMBER) "GREEN",
    json_value(color, '$.rgb[2]' RETURNING NUMBER) "BLUE"
from  temp;
-- black	0	0	0
-- NO_COLOUR	255	140	0
-- orange red	255	69	0

SELECT 
    JSON_VALUE('{"a":true}', '$.a') boolean_string,
    JSON_VALUE('{"a":true}', '$.a' returning  number) boolean_number
FROM DUAL;
-- true	1

JSON_QUERY is complementary to JSON_VALUE. JSON_VALUE takes JSON a input and returns one scalar SQL value. Think of JSON_VALUE as the ‘bridge’ from JSON to SQL. (We will use it later for relational concepts that operate on SQL values like virtual columns, functional indexing, etc).

JSON_QUERY on the other hand always returns JSON, i.e. an object or an array. This implies that JSON_QUERY could be chained (JSON in – JSON out) versus the output of JSON_VALUE can never be used as the input for another operator that expect a JSON input.

with customertab as(
select '{"custNo":2,"name" : "Jane","status":"Gold","address": {"Street": "Main Rd1","City": "San Jose","zip": 95002}}' custData from dual
union
select '{"custNo":3,"name" : "Jill","status":["Important","Gold"],"address": {"Street": "Broadway2","City": "Belmont","zip": 94065}}' from dual
)
SELECT
    JSON_QUERY(custData, '$.address')
FROM customerTab;
-- {"Street":"Main Rd1","City":"San Jose","zip":95002}
-- {"Street":"Broadway2","City":"Belmont","zip":94065}

--
-- The first row returns null because status is neither an object nor an array
-- if we use error on error this would throw an error
-- this can be fixed by using clause WITH ARRAY WRAPPER
-- but in this we need WITH CONDITIONAL ARRAY WRAPPER as we don't want the second record to be re-wrapped
-- e.g [["Important","Gold"]]
with customertab as(
select '{"custNo":2,"name" : "Jane","status":"Gold","address": {"Street": "Main Rd1","City": "San Jose","zip": 95002}}' custData from dual
union
select '{"custNo":3,"name" : "Jill","status":["Important","Gold"],"address": {"Street": "Broadway2","City": "Belmont","zip": 94065}}' from dual
)
SELECT
    JSON_QUERY(custData, '$.status')
FROM customerTab;
-- NULL
-- ["Important","Gold"]
with customertab as(
select '{"custNo":2,"name" : "Jane","status":"Gold","address": {"Street": "Main Rd1","City": "San Jose","zip": 95002}}' custData from dual
union
select '{"custNo":3,"name" : "Jill","status":["Important","Gold"],"address": {"Street": "Broadway2","City": "Belmont","zip": 94065}}' from dual
)
SELECT
    JSON_QUERY(custData, '$.status' WITH ARRAY WRAPPER)
FROM customerTab;
-- ["Gold"]
-- ["Important","Gold"]

--
-- Notice how the two cities of third rrecord has been fetched by [*} operator
-- actually it also supports subsets like [1 to 5] or even [1,2, 5 to 10].
with customertab as(
select '{"custNo":2,"name" : "Jane","status":"Gold","address": {"Street": "Main Rd1","City": "San Jose","zip": 95002}}' custData from dual
union
select '{"custNo":3,"name" : "Jill","status":["Important","Gold"],"address": {"Street": "Broadway2","City": "Belmont","zip": 94065}}' from dual
union
select '{"custNo":3,"name" : "Jim","status": "Silver","address":[{"Street": "Fastlane4","City": "Atherton","zip": 94027},{"Street": "Slowlane5","City": "SanFrancisco","zip": 94105} ]}' from dual
)
SELECT
    JSON_QUERY(custData, '$.address[*].City' WITH ARRAY WRAPPER) 
FROM customerTab;
-- ["San Jose"]
-- ["Belmont"]
-- ["Atherton","SanFrancisco"]

with customertab as(
    select '{"id":1, "name" : "Jeff"}' custData from dual 
    union
    select '{"id":2, "name" : "Jane","status":"Gold"}' from dual 
    union 
    select '{"id":3, "name" : "Jill","status":["Important","Gold"]}' from dual
    union
    select '{"name" : "John","status":"Silver"}' from dual
)
SELECT
count(1)
FROM customerTab
WHERE JSON_EXISTS (custData, '$.status');
-- 3
-- find gold customer, status=gold
-- query contains a predicate, this is expressed by using a question mark followed by a Boolean condition in parentheses. The symbol’@’ denotes the current context, i.e. the key/value pair selected by the path expression before the predicate. 
with customertab as(
    select '{"id":1, "name" : "Jeff"}' custData from dual 
    union
    select '{"id":2, "name" : "Jane","status":"Gold"}' from dual 
    union 
    select '{"id":3, "name" : "Jill","status":["Important","Gold"]}' from dual
    union
    select '{"name" : "John","status":"Silver"}' from dual
)
SELECT
count(1)
FROM customerTab
WHERE JSON_EXISTS (custData, '$.status?(@ == "Gold")');
-- 2

why you cannot use JSON_VALUE or JSON_QUERY in the WHERE clause in stead of JSON_EXISTS? There are a couple of reasons:
1. JSON_EXISTS checks for the existence of a value. Since JSON can have a ‘null’ value one could not differentiate a JSON ‘null’ from a missing value in JSON_VALUE.
2. JSON_QUERY is not suitable to compare the selected value(s) with one scalar value on contrary JSON_VALUE can only select and return scalar
values so it is practically impossible to check every element of an array like in third row of above example.

we can also add constraints like CONSTRAINT ensure_id CHECK (JSON_EXISTS(custData, '$.id'))

JSON_TABLE is actually not an operator (or function) but something we call a ‘row source’: Given one input (JSON data ) JSON_TABLE can give us multiple outputs (rows). A common use case is to un-nest repeating values inside the JSON data. Each item of an array gets its own row, and values from that item (json object) are mapped to columns. As a consequence we can represent (nested) JSON data fully relational
and leverage any relational mechanism (queries, views, reporting, relational tools) on top of JSON_TABLE.

with feeddata as(
select 
'{
    "data": [
        {
            "from": {
                "category": "Computers/technology",
                "name": "Oracle"
            },
            "message": "How are Baxters Food Group and Elsevier taking their businesses to...",
            "link": "http://onforb.es/1JOki7X",
            "name": "Forbes: How The Cloud Answers Two Businesses Need For Speed ",
            "description": "Cloud computing can support a companys speed and agility, ...",
            "type": "link",
            "created_time": "2015-05-12T16:26:12+0000",
            "likes": {
                "data": [
                    {
                        "name": "Starup Haji"
                    },
                    {
                        "name": "Elaine Dala"
                    }
                ]
            }
        },
        {
            "from": {
                "category": "Computers/technology",
                "name": "Oracle"
            },
            "message": "Its important to have an IT approach that not only red...",
            "link": "http://www.forbes.com/sites/oracle/2015/05/07/3-ways-you-can-avoid-sp...",
            "name": "Forbes: 3 Ways You Can Avoid Spending Too Much On IT ",
            "description": "Oracles suite of SaaS applications not only reduces costs but...",
            "type": "link",
            "created_time": "2015-05-11T19:23:11+0000",
            "shares": {
                "count": 5
            },
            "likes": {
                "data": [
                    {
                        "name": "Asal Alibiga"
                    },
                    {
                        "name": "Hasan Reni"
                    }
                ]
            },
            "comments": {
                "data": [
                    {
                        "from": {
                            "name": "Cesar Sanchez"
                        },
                        "message": "Thanks for this information",
                        "created_time": "2015-05-12T02:52:09+0000",
                        "like_count": 1
                    }
                ]
            }
        }
    ]
}
' as json_data from dual)
SELECT jt.*
FROM feeddata fd,
    JSON_TABLE(json_data,
        '$.data[*]'              -- we need to tell it when to start a new row. 
        -- this row path expr selects every item of the collection (array) that we want to project as a separate row
        COLUMNS (
        -- Then for every item that is selected by this ‘row path expression’ we select the columns values by providing a relative path expression
        -- We can easily add multiple column to the COLUMN clause and customize them with an optional data type and error clause
        -- Each column can also have the semantics of JSON_VALUE, JSON_QUERY or JSON_EXISTS. The default is JSON_VALUE
        "Message"        PATH '$.message',
        "Type"           VARCHAR2(20)               PATH '$.type',
        "ShareCount"     NUMBER                     PATH '$.shares.count' DEFAULT 0 ON ERROR,
        "HasComments"    NUMBER EXISTS              PATH '$.comments',
        "Comments"       VARCHAR2(4000) FORMAT JSON PATH '$.comments' -- FORMAT JSON is must here if returning json segment, otherwise it would return/error
        )
    ) jt;
-- Query extracts the values of the fields and gives us one row per value.

--So how do we drill down into nested array? The answer is to add a NESTED PATH with a new COLUMNS clause to the JSON_TABLE:

SELECT jt.*
   FROM feeddata,
        JSON_TABLE(json_data, '$.data[*]' 
        COLUMNS (
          "Message"                     PATH '$.message',
          "Type"           VARCHAR2(20) PATH '$.type',
          "ShareCount"      NUMBER      PATH '$.shares.count' DEFAULT 0 ON ERROR,
          NESTED PATH '$.likes.data[*]' 
          COLUMNS (
            "Author"             PATH '$.name'
))) "JT";
--The JOIN between the inner and the outer COLUMNS clause is a so called ‘OUTER JOIN’. This means that data which has no nested array (where the NESTED PATH does not select anything) will not be suppressed - all columns of the inner COLUMNS clause have NULL values instead.
--As you can see the nested (inner) item is now responsible for the number of row; we see a new row for each item in the inner array. Values for the outer COLUMNS clause are getting repeated because they are the same for all values of the inner array

--* Sibling arrays 

-- Now what happens if multiple arrays are not nested but on the same level? In the Facebook example this would apply for the array of ‘likes’ and the array of ‘comments’. Both arrays are nested under the posting but they’re both on the same level. We call them ‘sibling arrays’. 
Semantically, sibling arrays represent different ‘things’: a like at position X has nothing to do with a comment at the same position X. This is why we return values for sibling arrays in different rows with only one sibling array at the time returning column value. Thus the total number of returned rows is the sum of the items in the sibling array and not sthe (Cartesian) product. (The Join between the sibling arrays is a UNION join.)

SELECT
"Message", "Author_l",
"Author_c"
FROM fb_tab,
     JSON_TABLE(col, '$.data[*]' 
     COLUMNS (
        "Message" PATH '$.message',
        NESTED PATH '$.likes.data[*]' 
        COLUMNS (
            "Author_l"      VARCHAR2(20) PATH '$.name'
        ),
        NESTED PATH '$.comments.data[*]' 
        COLUMNS ( 
            "Author_c"      VARCHAR2(20) PATH '$.from.name'
         )
)) "JT";


-- Ordinality Column : 
-- Let’s assume you have several nested array. How do we keep track of the hierarchy when unnesting the data? Or asked differently: For two or more column value originating from an inner array how do we now if they belong to the same (or different) outer values? In the example above the repeating message may hint the common parent but what if there were duplicates?

We can use "seq_num" FOR ORDINALITY to handle that 

There are reasons why you may want to consider storing your JSON data as BLOBs:

CLOB data is stored in UCS2 encoding which uses two bytes per character (similar to UTF16). For JSON in most common UTF8 encoding (one byte per ASCII character) this means that the storage size may increase (even double if most characters are ASCII). Also IO would increase during queries and inserts.

On the other hand, storing your JSON data in a BLOB column (Binary Large Object) does not have these disadvantages: here the UTF8 encoded representation of JSON can be written and read without modifications. (This also helps if the database character set is not AL32UTF8, since no character set conversion is performed.)

CREATE TABLE colorTab (
    id    NUMBER,
    color BLOB
);
ADD CONSTRAINT ensure_json CHECK (color IS JSON STRICT);

INSERT INTO colorTab
VALUES(1, utl_raw.cast_to_raw ('
{
"color": "black",
"rgb": [0,0,0],
"hex": "#000000"

}'));

--  ‘utl_raw.cast_to_raw’ performs the type casting so that the insert succeeds if you issue the insert operation inside SQL (e.g. in SQL-Plus or SQLDeveloper). 

What happens if you select the BLOB value? Since it is a binary data type it will be displayed as hex by default (something like 0A7B0A20202022636F6C6F72223A2022…).

select utl_raw.cast_to_varchar2(color) from colorTab;

-- utl_raw.cast_to_raw has a varchar2 limit of 32767 if the data is larger we can write custom function like below
create or replace function clobToBlob( c IN CLOB ) RETURN BLOB is
  b     BLOB;
  warn  VARCHAR2(255);
  cs_id NUMBER := NLS_CHARSET_ID('AL32UTF8');
  do    NUMBER := 1; -- dest offset 
  so    NUMBER := 1; -- src offset 
  lc    NUMBER := 0; -- lang context
BEGIN
   DBMS_LOB.createTemporary(b, TRUE );
   DBMS_LOB.CONVERTTOBLOB(b, c, DBMS_LOB.LOBMAXSIZE, do, so, cs_id, lc, warn);
   RETURN b; 
END clobToBlob;
/

This insert now looks like this

INSERT
INTO colorTab VALUES(1, clobToBlob ('

{
"color": "black",
"rgb": [0,0,0],
"hex": "#000000"

}'));

--JSON_EXISTS takes a path expression (potentially with a predicate) and checks if such path selects one (or multiple) values in the JSON data.
--The Address object is returned as JSON text in a VARCHAR2(4000).

CREATE TABLE j_purchaseorder(
    id RAW (16) NOT NULL,
    date_loaded TIMESTAMP(6) WITH TIME ZONE,
    po_document CLOB CONSTRAINT ensure_json_1 CHECK (po_document IS JSON)
);

INSERT INTO j_purchaseorder
  VALUES (
    SYS_GUID(),
    SYSTIMESTAMP,
    '   
{
    "PONumber": 1600,
    "Reference": "ABULL-20140421",
    "Requestor": "Alexis Bull",
    "User": "ABULL",
    "CostCenter": "A50",
    "ShippingInstructions": {
        "name": "Alexis Bull",
        "Address": {
            "street": "200 Sporting Green",
            "city": "South San Francisco",
            "state": "CA",
            "zipCode": 99236,
            "country": "United States of America"
        },
        "Phone": [
            {
                "type": "Office",
                "number": "909-555-7307"
            },
            {
                "type": "Mobile",
                "number": "415-555-1234"
            }
        ]
    },
    "Special Instructions": null,
    "AllowPartialShipment": true,
    "LineItems": [
        {
            "ItemNumber": 1,
            "Part": {
                "Description": "One Magic Christmas",
                "UnitPrice": 19.95,
                "UPCCode": 13131092899
            },
            "Quantity": 9
        },
        {
            "ItemNumber": 2,
            "Part": {
                "Description": "Lethal Weapon",
                "UnitPrice": 19.95,
                "UPCCode": 85391628927
            },
            "Quantity": 5
        }
    ]
}
');

select j.PO_DOCUMENT.CostCenter, count(*)
from J_PURCHASEORDER j
group by j.PO_DOCUMENT.CostCenter
order by j.PO_DOCUMENT.CostCenter
/

select j.PO_DOCUMENT
from J_PURCHASEORDER j
where j.PO_DOCUMENT.PONumber = 450
/

select j.PO_DOCUMENT.Reference,
j.PO_DOCUMENT.Requestor,
j.PO_DOCUMENT.CostCenter,
j.PO_DOCUMENT.ShippingInstructions.Address.city
from J_PURCHASEORDER j
where j.PO_DOCUMENT.PONumber = 450
/

select j.PO_DOCUMENT.ShippingInstructions.Address
from J_PURCHASEORDER j
where j.PO_DOCUMENT."PONumber" = 450
/

with data as(
select
'{
    "PONumber": 1600,
    "Reference": "ABULL-20140421",
    "Requestor": "Alexis Bull",
    "User": "ABULL",
    "CostCenter": "A50",
    "ShippingInstructions": {
        "name": "Alexis Bull",
        "Address": {
            "street": "200 Sporting Green",
            "city": "South San Francisco",
            "state": "CA",
            "zipCode": 99236,
            "country": "United States of America"
        },
        "Phone": [
            {
                "type": "Office",
                "number": "909-555-7307"
            },
            {
                "type": "Mobile",
                "number": "415-555-1234"
            }
        ]
    },
    "Special Instructions": null,
    "AllowPartialShipment": true,
    "LineItems": [
        {
            "ItemNumber": 1,
            "Part": {
                "Description": "One Magic Christmas",
                "UnitPrice": 19.95,
                "UPCCode": 13131092899
            },
            "Quantity": 9
        },
        {
            "ItemNumber": 2,
            "Part": {
                "Description": "Lethal Weapon",
                "UnitPrice": 19.95,
                "UPCCode": 85391628927
            },
            "Quantity": 5
        }
    ]
}' val
from dual
),
json_data as(
select 
    treat (jd.val as json) val
from data jd
)
select 
    jd.val.CostCenter
    ,jd.val.ShippingInstructions.name name
    ,jd.val.ShippingInstructions.Address address
    ,jd.val.ShippingInstructions.Phone phone
    ,jd.val.ShippingInstructions.Phone[0] phone0
    ,jd.val.ShippingInstructions.Phone[0].type phone_type
from json_data jd;


-- The JSON_VALUE operator uses a JSON path expression to access a single scalar value.
select JSON_VALUE(PO_DOCUMENT,'$.CostCenter'), count(*)
from J_PURCHASEORDER
group by JSON_VALUE(PO_DOCUMENT ,'$.CostCenter')
/

-- how to access a value from within an array.
select JSON_VALUE(PO_DOCUMENT,'$.LineItems[0].Part.UPCCode')
from J_PURCHASEORDER p
where JSON_VALUE(PO_DOCUMENT ,'$.PONumber' returning NUMBER(10)) = 450
/

select JSON_VALUE(PO_DOCUMENT,'$.LineItems[0].Part.UnitPrice' returning NUMBER(5,3))
from J_PURCHASEORDER p
where JSON_VALUE(PO_DOCUMENT ,'$.PONumber' returning NUMBER(10)) = 450
/

select JSON_VALUE(PO_DOCUMENT,'$.ShippingInstruction.Address' DEFAULT 'N/A' ON ERROR)
from J_PURCHASEORDER
where JSON_VALUE(PO_DOCUMENT ,'$.PONumber' returning NUMBER(10)) = 450
/
-- Since the JSON path expression does not evaluate to a scalar value,
select JSON_VALUE(PO_DOCUMENT,'$.ShippingInstruction.Address' ERROR ON ERROR)
from J_PURCHASEORDER
where JSON_VALUE(PO_DOCUMENT ,'$.PONumber' returning NUMBER(10)) = 450
/

--Accessing objects and arrays using JSON_QUERY

select JSON_QUERY(PO_DOCUMENT,'$.ShippingInstructions')
from J_PURCHASEORDER p
where JSON_VALUE(PO_DOCUMENT ,'$.PONumber' returning NUMBER(10)) = 450
/

-- PRETTY keyword to format the output of the JSON_QUERY operator.
select JSON_QUERY(PO_DOCUMENT ,'$.LineItems' PRETTY)
from J_PURCHASEORDER p
where JSON_VALUE(PO_DOCUMENT,'$.PONumber' returning NUMBER(10)) = 450
/

-- how to use an array offset to access one item from an array of objects:
select JSON_QUERY(PO_DOCUMENT,'$.LineItems[0]' PRETTY)
from J_PURCHASEORDER p
where JSON_VALUE(PO_DOCUMENT ,'$.PONumber' returning NUMBER(10)) = 450
/


with json_data as(
select
'{
    "PONumber": 1600,
    "Reference": "ABULL-20140421",
    "Requestor": "Alexis Bull",
    "User": "ABULL",
    "CostCenter": "A50",
    "ShippingInstructions": {
        "name": "Alexis Bull",
        "Address": {
            "street": "200 Sporting Green",
            "city": "South San Francisco",
            "state": "CA",
            "zipCode": 99236,
            "country": "United States of America"
        },
        "Phone": [
            {
                "type": "Office",
                "number": "909-555-7307"
            },
            {
                "type": "Mobile",
                "number": "415-555-1234"
            }
        ]
    },
    "Special Instructions": null,
    "AllowPartialShipment": true,
    "LineItems": [
        {
            "ItemNumber": 1,
            "Part": {
                "Description": "One Magic Christmas",
                "UnitPrice": 19.95,
                "UPCCode": 13131092899
            },
            "Quantity": 9
        },
        {
            "ItemNumber": 2,
            "Part": {
                "Description": "Lethal Weapon",
                "UnitPrice": 19.95,
                "UPCCode": 85391628927
            },
            "Quantity": 5
        }
    ]
}' val
from dual
)
select json_va
from json_data jd;


-- Relational access to JSON content using JSON_TABLE
select M.*
from J_PURCHASEORDER p,
    JSON_TABLE( p.PO_DOCUMENT , '$'
    COLUMNS
        PO_NUMBER   NUMBER(10)        path '$.PONumber',
        REFERENCE   VARCHAR2(30 CHAR) path '$.Reference',
        REQUESTOR   VARCHAR2(32 CHAR) path '$.Requestor',
        USERID      VARCHAR2(10 CHAR) path '$.User',
        COSTCENTER  VARCHAR2(16 CHAR) path '$.CostCenter',
        TELEPHONE   VARCHAR2(16 CHAR) path '$.ShippingInstructions.Phone[0].number'
    ) M
where PO_NUMBER between 450 and 455
/

create or replace view PURCHASEORDER_DETAIL_VIEW
as select D.*
from J_PURCHASEORDER p,
JSON_TABLE(
p.PO_DOCUMENT ,
'$'
columns (
PO_NUMBER NUMBER(10) path'$.PONumber',
REFERENCE VARCHAR2(30 CHAR) path '$.Reference',
REQUESTOR VARCHAR2(128 CHAR) path '$.Requestor',
USERID VARCHAR2(10 CHAR) path '$.User',
COSTCENTER VARCHAR2(16) path '$.CostCenter',
SHIP_TO_NAME VARCHAR2(20 CHAR) path '$.ShippingInstructions.name',
SHIP_TO_STREET VARCHAR2(32 CHAR) path '$.ShippingInstructions.Address.street',
SHIP_TO_CITY VARCHAR2(32 CHAR) path '$.ShippingInstructions.Address.city',
SHIP_TO_COUNTY VARCHAR2(32 CHAR) path '$.ShippingInstructions.Address.county',
SHIP_TO_POSTCODE VARCHAR2(32 CHAR) path '$.ShippingInstructions.Address.postcode',
SHIP_TO_STATE VARCHAR2(2 CHAR) path '$.ShippingInstructions.Address.state',
SHIP_TO_PROVINCE VARCHAR2(2 CHAR) path '$.ShippingInstructions.Address.province',
SHIP_TO_ZIP VARCHAR2(8 CHAR) path '$.ShippingInstructions.Address.zipCode',
SHIP_TO_COUNTRY VARCHAR2(32 CHAR) path '$.ShippingInstructions.Address.country',
SHIP_TO_PHONE VARCHAR2(24 CHAR) path '$.ShippingInstructions.Phones[0].number',
INSTRUCTIONS VARCHAR2(2048 CHAR) path '$.SpecialInstructions'
NESTED PATH
'$.LineItems[*]'
columns (
ITEMNO NUMBER(38) path '$.ItemNumber',
DESCRIPTION VARCHAR2(256 CHAR) path '$.Part.Description',
UPCCODE VARCHAR2(14 CHAR) path '$.Part.UPCCode',
QUANTITY NUMBER(12,4) path '$.Quantity',
UNITPRICE NUMBER(14,2) path '$.Part.UnitPrice'
)
)
) D
/

-- Filtering result sets using JSON_EXISTS
-- JSON_EXISTS makes it possible to differentiate between a document where a key is not present and a document where the key is present but the value is null.
select count(*)
from J_PURCHASEORDER
where JSON_EXISTS(PO_DOCUMENT ,'$.ShippingInstructions.Address.state')
/

-- Predicate support in JSON Path Expressions
-- Predicates are specified by adding a "?" following the parent key and then specifying conditions in parenthesis. Within the predicate the @ sign is used to reference the parent key. A variable is indicated by a name prefixed with a $ sign.

select j.PO_DOCUMENT
from J_PURCHASEORDER j
where JSON_EXISTS(
PO_DOCUMENT,
'$?(@.PONumber == $PO_NUMBER)'
passing 450 as "PO_NUMBER"
)
/

select j.PO_DOCUMENT.PONumber PO_NUMBER
from J_PURCHASEORDER j
where JSON_EXISTS(
PO_DOCUMENT,
'$?(@.LineItems.Part.UPCCode == $UPC)'
passing 27616854773 as "UPC"
)
/

select count(*)
from J_PURCHASEORDER j
where JSON_EXISTS(
    PO_DOCUMENT,
'$?(@.User == $USER && @.LineItems.Quantity > $QUANTITY)'
passing 'AKHOO' as "USER",
8 as "QUANTITY"
)
/

--Indexing JSON documents stored in Oracle Database 12c
create bitmap index COSTCENTER_IDX
on J_PURCHASEORDER(
JSON_VALUE(PO_DOCUMENT ,'$.CostCenter')
)
/

create index ZIPCODE_IDX
on J_PURCHASEORDER(
JSON_VALUE( PO_DOCUMENT, '$.ShippingInstructions.Address.zipCode' returning NUMBER(5) )
)
/

--*** JSON Generation ***

-- JSON_ARRAY : JSON_ARRAY returns each row of data generated by the SQL query as a JSON Array
    -- JSON_ARRAY(expr FORMAT JSON NULL ON NULL RETURNING CLOB)
    -- expr can take any SQL expression that evaluates to a JSON object, a JSON array, a numeric literal, a text literal, or null.
    --  FORMAT JSON is optional and is for semantic clarity.
    --  NULL ON NULL - returns JSON null value. or ABSENT ON NULL default omits the value from the JSON array.
    --* select json_array('1','2',null format json null on null returning clob) from dual;
    -- ["1","2",null]
-- JSON_ARRAYAGG : to generate JSON arrays from the results of a sub query that returns multiple rows
    -- JSON_ARRAYAGG(expr FORMAT JSON ORDER BY NULL ON NULL RETURNING CLOB)
    SELECT JSON_ARRAYAGG(department_id ORDER BY department_id RETURNING VARCHAR2(100)) ID_NUMBERS  FROM departments where department_id <= 30;
    -- [10,20,30]
    SELECT JSON_ARRAY(department_id RETURNING VARCHAR2(100)) ID_NUMBERS FROM departments where department_id <= 30;
    -- [10]
    -- [20]
    -- [30]
    SELECT JSON_ARRAY(department_id, DEPARTMENT_NAME,MANAGER_ID RETURNING VARCHAR2(100)) ID_NUMBERS FROM departments where department_id <= 30;
    -- [10,"Administration",200]
    -- [20,"Marketing",201]
    -- [30,"Purchasing",114]
    --! multiple columns like above is not liked by json_arrayagg

-- JSON_OBJECT : takes one or more property key-value pairs as input. returns object member for each of those key-value pairs. 
    -- JSON_OBJECT(KEY key_expr VALUE value_expr FORMAT JSON NULL ON NULL RETURNING CLOB)
    -- KEY is optional and is provided for semantic clarity. 
    -- string specifies the property key name as a case-sensitive text literal. 
    -- expr is any expression that evaluates to a SQL numeric literal or text literal.
    --! VALUE or IS clause is mandatory
    --  FORMAT JSON is optional 
    --      Use this optional clause to indicate that the input string is JSON, and will therefore not be quoted in the output.
    -- NULL ON NULL - returns JSON null value. or ABSENT ON NULL default omits the value from the JSON array.
    -- STRICT  verify that the output of the JSON generation function is correct JSON. If the check fails, a syntax error is raised.
    -- WITH UNIQUE KEYS :  guarantee that generated JSON objects have unique keys.
    --* select json_object(key 'name' value 'saroj' null on null returning clob) from dual;
    --* select json_object('name' value 'saroj' null on null returning clob) from dual;
    --* select json_object('name' is 'saroj' null on null returning clob) from dual;
    --* select json_object('name' is 'Saroj', 'surname' is 'Raut' null on null returning clob) from dual;
    --* select json_object(dummy is rownum, 'surname' is 'Raut' null on null returning clob) from dual;
    --* select json_object ('name' value 'Foo'  format json strict ) from DUAL; 
    --! Above query Throws ORA-40441: JSON syntax error as FORMAT JSON clause is used which returns value FOO as unquoted and hence syntax error
    --*  
    -- {"name":"Saroj","surname":Raut}
-- JSON_OBJECTAGG :  makes it easy to generate a JSON object from data that has been stored using Key, Value pair storage.
    -- JSON_OBJECTAGG(KEY key_expr VALUE value_expr FORMAT JSON NULL ON NULL RETURNING CLOB)
    -- Similar to JSON_OBJECT but consolidates all key value pais for each row into one object. Unlike JSON_OBJECT
    -- this will only accept two columns if KEY key_expr VALUE value_expr is selected by a select query

    SELECT JSON_OBJECT(KEY department_name VALUE department_id) "Department Numbers"
    FROM departments
    WHERE department_id <= 30;
    -- {"Administration":10}
    -- {"Marketing":20}
    -- {"Purchasing":30}

    SELECT JSON_OBJECTAGG(KEY department_name VALUE department_id) "Department Numbers"
    FROM departments
    WHERE department_id <= 30;
    -- {"Administration":10,"Marketing":20,"Purchasing":30}
    select 
        json_object( 
            'departments' is (
                json_arrayagg(
                json_object( 
                    'departmentid' is d.department_id, 
                    'name'         is d.department_name, 
                    'manager'      is d.manager_id,
                    'location'     is d.location_id 
                    )
                )  
            )
        )
    from hr.departments d
    where department_id <=20
    /
    --{"departments":[{"departmentid":10,"name":"Administration","manager":200,"location":1700},{"departmentid":20,"name":"Marketing","manager":201,"location":1800}]}

-- SELECT json_objectAGG(KEY department_name VALUE department_id) "Department Numbers" FROM departments;
-- {"Administration":10,"Marketing":20,"Purchasing":30}
-- Both agg functions may throw ORA-00937: not a single-group group function
-- The input to JSON_ARRAY is a list of columns. Each column will be mapped to one member of the array.
select JSON_ARRAY( DEPARTMENT_ID,DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID ) DEPARTMENT
from HR.DEPARTMENTS
where DEPARTMENT_ID <=20
/

-- [10,"Administration",200,1700]
-- [20,"Marketing",201,1800]

 -- The generated object contains a key:value pair for each column referenced in the json_object operator. The name of the key can be supplied using a SQL string or a column.

select json_object( 
    'departmentId' IS d.DEPARTMENT_ID, 
    'name'         IS d.DEPARTMENT_NAME, 
    'manager'      IS d.MANAGER_ID,
    'location'     IS d.LOCATION_ID ) DEPARTMENT
from HR.DEPARTMENTS d
where DEPARTMENT_ID <=20
/

-- {"departmentId":10,"name":"Administration","manager":200,"location":1700}
-- {"departmentId":20,"name":"Marketing","manager":201,"location":1800}


SELECT json_object(
    'departmentId' IS d.DEPARTMENT_ID,
    'name'         IS d.DEPARTMENT_NAME,
    'manager' is json_object(
        'employeeId'   is EMPLOYEE_ID,
        'firstName'    is FIRST_NAME,
        'lastName'     is LAST_NAME,
        'emailAddress' is EMAIL
    ),
    'location' is d.LOCATION_ID
) DEPT_WITH_MGR
from HR.DEPARTMENTS d, HR.EMPLOYEES e
where d.MANAGER_ID is not null
and d.MANAGER_ID = e.EMPLOYEE_ID
and d.DEPARTMENT_ID = 10
/

select 
    json_object(
        'departmentId' is d.DEPARTMENT_ID,
        'name'         is d. DEPARTMENT_NAME,
        'employees'    is (
            select JSON_ARRAYAGG(
                json_object(
                'employeeId'   is EMPLOYEE_ID,
                'firstName'    is FIRST_NAME,
                'lastName'     is LAST_NAME,
                'emailAddress' is EMAIL
                )
            )
            from HR.EMPLOYEES e
            where e.DEPARTMENT_ID = d.DEPARTMENT_ID
        )
    ) DEPT_WITH_EMPLOYEES
from HR.DEPARTMENTS d
where DEPARTMENT_NAME = 'Executive'
/

SELECT json_object(
    'id'               is pdtl.event_uuid
    ,'eventDomain'      is 'ORDER'
    ,'eventType'        is 'ORDER-EVENT'
    ,'eventSource'      is 'CORE'
    ,'eventName'        is 'PICKED-LOAD'
    ,'eventOccuredTime' is pdtl.created_dtm
    ,'load' is json_object(
        'id'              is pdtl.load_nbr
        ,'chunkId'         is pdtl.chunk_nbr
        ,'totalChunkCount' is total_chunk_count
        ,'waves'           is ( 
            select 
                json_arrayagg(
                    json_object(
                        'distros' is (
                            select 
                                json_arrayagg(
                                    json_object(
                                        'orderId'            is ord_id
                                        ,'fromStockLocation' is from_stock_loc
                                        ,'toStockLocation'   is to_stock_loc 
                                        , 'productLineItems' is (
                                            select 
                                                json_arrayagg(
                                                    json_object(
                                                        'itemId'            is '1'
                                                        ,'skuId'            is sku_id
                                                        ,'quantity'         is sku_qty
                                                        ,'status'           is action_code
                                                        ,'volume'           is item_volume
                                                        ,'weight'           is item_weight
                                                        ,'flatHangingType'  is flat_hang
                                                    )
                                                )
                                            from w_io_pick_ord_item oi 
                                            where oi.load_nbr =  pdtl.load_nbr
                                            and oi.ord_id = ohdr.ord_id
                                        )
                                    )
                                RETURNING CLOB)
                            from w_io_pick_ord_hdr ohdr
                            where ohdr.load_nbr =  pdtl.load_nbr
                            and ohdr.chunk_nbr = pdtl.chunk_nbr
                        )
                    RETURNING CLOB)
                RETURNING CLOB)
            from dual
        )
    RETURNING CLOB) 
RETURNING CLOB)
from  w_io_pick_hdr phdr
    JOIN w_io_pick_dtl pdtl
        ON(phdr.load_nbr = pdtl.load_nbr);


select json_objectAGG(KEY,VALUE)
from EMPLOYEE_KEY_VALUE
where ID < 105 group by ID
/

Create a Hashmap of users with JSON_OBJECTAGG
 
SELECT JSON_OBJECTAGG(to_char(cust_id) VALUE (first ||' '|| last)) FROM customers;
--------------------------------------------------------------------------------
{"1":"Eric Cartman","2":"Kenny McCormick","3":"Kyle Brofloski","4":"Stan Marsh"}

CREATE TABLE already_json(data VARCHAR2(200));

INSERT INTO already_json VALUES('{"name" : "saroj"}');

SELECT JSON_OBJECT('person' VALUE data) FROM already_json;
-- {"person":"{\"name\" : \"saroj\"}"}

SELECT JSON_OBJECT('person' VALUE data format json) FROM already_json; -- value is not quoted any more
-- {"person":{"name" : "saroj"}}

INSERT INTO already_json VALUES('{actually : not}'); -- value is not quoted any more, but tht's not right
-- {"person":{"name" : "saroj"}}
-- {"person":{actually : not}}

ALTER TABLE already_json ADD CONSTRAINT ensureJson CHECK (data IS JSON); -- now this will fail because of second record

delete from already_json where data='{actually : not}';

ALTER TABLE already_json ADD CONSTRAINT ensureJson CHECK (data IS JSON);

SELECT JSON_OBJECT('person' VALUE data) FROM already_json; -- Now this query returns data without escaping because of check constraint
--{"person":{"name" : "saroj"}}


-- following query returns 5 jsons
with temp as(
select 
    rownum id, 
    mod(rownum,5) dept
from dual 
connect by rownum <= 20)
select
    json_object('dept-'||dept is json_arrayagg(id))
from temp
group by dept;

-- following query returns one aggregated json
with temp as(
select 
    rownum id, 
    mod(rownum,5) dept
from dual 
connect by rownum <= 20)
select
    json_objectagg('dept-'||dept is json_arrayagg(id order by id absent on null returning clob))
from temp
group by dept;

with temp as(
select 
    rownum id, 
    mod(rownum,5) dept
from dual 
connect by rownum <= 20)
select
    json_objectagg(key 'dept-'||dept value json_arrayagg(id order by id  returning clob ))
from temp
group by dept;

--ABSENT ON NULL or NULL ON NULL

-- Introducing the PL/SQL API for JSON

-- The PL/SQL JSON API consists of three PL/SQL objects, JSON_ELEMENT_T, json_object_T and JSON_ARRAY_T. JSON_OJBECT_T and JSON_ARRAY_T extend JSON_ELEMENT_T, so they inherit all of JSON_ELEMENT_T"s methods.

with temp as 
(
    select 
'{
    "PONumber": 1600,
    "Reference": "ABULL-20140421",
    "Requestor": "Alexis Bull",
    "User": "ABULL",
    "CostCenter": "A50",
    "ShippingInstructions": {
        "name": "Alexis Bull",
        "Address": {
            "street": "200 Sporting Green",
            "city": "South San Francisco",
            "state": "CA",
            "zipCode": 99236,
            "country": "United States of America"
        },
        "Phone": [
            {
                "type": "Office",
                "number": "909-555-7307"
            },
            {
                "type": "Mobile",
                "number": "415-555-1234"
            }
        ]
    },
    "Special Instructions": null,
    "AllowPartialShipment": true,
    "LineItems": [
        {
            "ItemNumber": 1,
            "Part": {
                "Description": "One Magic Christmas",
                "UnitPrice": 19.95,
                "UPCCode": 13131092899
            },
            "Quantity": 9
        },
        {
            "ItemNumber": 2,
            "Part": {
                "Description": "Lethal Weapon",
                "UnitPrice": 19.95,
                "UPCCode": 85391628927
            },
            "Quantity": 5
        }
    ]
}' json_data
from dual
)
select 
    JSON_VALUE(json_data,'$.PONumber') PONumber,
    JSON_VALUE(json_data,'$.ShippingInstructions.Address.street') street,
    JSON_VALUE(json_data,'$.ShippingInstructions.Address.street1' DEFAULT 'N/A' ON ERROR) street1, -- ERROR ON ERROR
    JSON_QUERY(json_data,'$.ShippingInstructions') ship_object,
    JSON_QUERY(json_data ,'$.LineItems' PRETTY) LineItems,
    JSON_QUERY(json_data,'$.LineItems[0]' PRETTY) LineItems_0,
    JSON_VALUE(json_data,'$.LineItems[0].Part.UPCCode') UPCCode
from temp
where JSON_VALUE(json_data ,'$.PONumber' returning NUMBER(10)) = 1600;

with temp as 
(
select 
    '{
        "a": "400",
        "c": "500",
        "d": [
            "100",
            "200",
            "300",
            "400"
        ],
        "e": [
            {
                "e1": 11,
                "e2": 12
            },
            {
                "e1": 21,
                "e2": 22
            }
        ]
    }' json_data
from dual
)
select
    json_value(json_data, '$.a') a,
    json_value(json_data, '$.c') c,
    json_value(json_data, '$.d[*]') d --- this will return null however [0] will return the first value
from temp
/

with ord as (
select 
'{
    "id": "abece703-bbfa-4250-b1a9-8abb7e5c64d6",
    "order": {
        "orderId": "a8924325-f46c-4b3e-8df2-a77ea9444ea8",
        "externalIds": [
            {
                "systemId": "S1",
                "externalId": "EXT-1"
            },
            {
                "systemId": "S2",
                "externalId": "EXT-2"
            }
        ],
        "customer": {
            "customerId": "5181166",
            "email": "firstname.surname@xyz.com"
        },
        "productLineItems": [
            {
                "productId": "P1",
                "skuId": "SKU1",
                "priceAdjustments": [
                    {
                        "couponCode": "ORDER10"
                    },
                    {
                        "couponCode": "ORDER11"
                    }
                ],
                "basePrice": 1600
            },
            {
                "productId": "P2",
                "skuId": "SKU2"
            }
        ]
    }
}' json
from dual
)
select 
    d.*
from ord o,
JSON_TABLE(
    o.json ,
    '$'
    columns (
        externalId         varchar2(20 char)     path '$.order.externalIds[0].externalId',
        email              varchar2(32 char)     path '$.order.customer.email',
        nested PATH '$.order.productLineItems[*]'
        columns (
            sku_row_number  FOR ORDINALITY,
            productId         varchar2(38)       path '$.productId',
            skuId             varchar2(14)       path '$.skuId',
            has_promo         varchar2(5) exists path '$.priceAdjustments',
            nested PATH '$.priceAdjustments[*]'
            columns(
                discount_row_number  FOR ORDINALITY,
                couponCode        varchar2(30)       path '$.couponCode'
            )
        )
    )
) d
/
--
-- Above query returns three rows one line item with two promos and one line item with no promos
--

with ord as (
select 
'{
    "id": "abece703-bbfa-4250-b1a9-8abb7e5c64d6",
    "order": {
        "orderId": "a8924325-f46c-4b3e-8df2-a77ea9444ea8",
        "externalIds": [
            {
                "systemId": "S1",
                "externalId": "EXT-1"
            },
            {
              "systemId": "S2",
              "externalId": "EXT-2"
          }
        ],
        "customer": {
            "customerId": "5181166",
            "email": "xyzcolm.surname@xyz.com"
        },
        "productLineItems": [
            {
                "productId": "P1",
                "skuId": "SKU1",
                "priceAdjustments": [
                    {
                        "couponCode": "ORDER10"
                    },
                    {
                        "couponCode": "ORDER11"
                    }
                ],
                "basePrice": 1600
            },
            {
                "productId": "P2",
                "skuId": "SKU2"
            }
        ]
    }
}' json
from dual
)
select 
    d.*
from ord o,
JSON_TABLE(
    o.json ,
    '$'
    columns (
        externalId0         varchar2(20 char)     path '$.order.externalIds[0].externalId',
        nested path '$.order.externalIds[*]'
        columns(
            externalId         varchar2(20 char)     path '$.externalId'
        ),
        email              varchar2(32 char)     path '$.order.customer.email',
        nested PATH '$.order.productLineItems[*]'
        columns (
            sku_row_number  FOR ORDINALITY,
            productId         varchar2(38)       path '$.productId',
            skuId             varchar2(14)       path '$.skuId',
            has_promo         varchar2(5) exists path '$.priceAdjustments',
            nested PATH '$.priceAdjustments[*]'
            columns(
                discount_row_number  FOR ORDINALITY,
                couponCode        varchar2(30)       path '$.couponCode'
            )
        )
    )
) d
/

--
-- Now this wuery will return five rows three rows from previous example
-- and two extra rows for the external ids with all line item details as null
--


CREATE TABLE MY_ADDRESS (json_addr CLOB CONSTRAINT valid_json CHECK (json_addr IS JSON));

INSERT INTO MY_ADDRESS VALUES (
'{
  "firstName": "Saroj",
  "lastName": "Raut",
  "contactAddress": [
    {
      "postCode": "HA01LF",
      "Town": "Lndon"
    },
    {
      "postCode": "TF32HT",
      "country": "Telford"
    }
  ]
}');
COMMIT;

SELECT ma.json_addr.contactAddress.postCode FROM MY_ADDRESS ma;
-- ["HA01LF","TF32HT"] returns array of post codes


JSON Data Guide
-- Create and populate a table
CREATE TABLE json_data(
    json_pk NUMBER NOT NULL PRIMARY KEY,
    json_col CLOB
    CONSTRAINT is_json CHECK ( json_col IS JSON ) );

INSERT INTO json_data
VALUES(1,'{"NUMBERS":[1,2,3,4,5],
           "STRINGS":["A","B","C"],
           "MIXED":[1,2,3,"A","B"]}');
COMMIT;

WITH dataguide_view AS
( SELECT json_pk,
         JSON_DATAGUIDE(json_col) dataguide_rows
    FROM json_data
  GROUP BY json_pk)
SELECT json_pk,
       edetails.*
  FROM dataguide_view,
       JSON_TABLE(dataguide_rows,'$[*]'
 COLUMNS epath VARCHAR2(100) PATH '$."o:path"',
         etype VARCHAR2(10) PATH '$."type"',
         elength NUMBER PATH '$."o:length"') edetails;

-- Result in 12c
-- All we know is there is an array of something
JSON_PK EPATH      ETYPE  ELENGTH
------- ---------- ------ -------
      1 $.MIXED    array       16
      1 $.NUMBERS  array       16
      1 $.STRINGS  array       16

-- Result in 18c
-- The datatype of the scalar entries is provided
JSON_PK EPATH        ETYPE  ELENGTH
------- ------------ ------ -------
      1 $.MIXED      array       16
      1 $.MIXED[*]   string       1
      1 $.NUMBERS    array       16
      1 $.NUMBERS[*] number       1
      1 $.STRINGS    array       16
      1 $.STRINGS[*] string       1

Here are some examples of path expressions, with their meanings spelled out in detail.

$ – The context item.

$.friends – The value of field friends of a context-item object. The dot (.) immediately after the dollar sign ($) indicates that the context item is a JSON object.

$.friends[0] – An object that is the first element of an array that is the value of field friends of a context-item object. The bracket notation indicates that the value of field friends is an array.

$.friends[0].name – Value of field name of an object that is the first element of an array that is the value of field friends of a context-item object. The second dot (.) indicates that the first element of array friends is an object (with a name field).

$.friends[*].name – Value of field name of each object in an array that is the value of field friends of a context-item object.

$.*[*].name – Field name values for each object in an array value of a field of a context-item object.

$.friends[3, 8 to 10, 12] – The fourth, ninth through eleventh, and thirteenth elements of an array friends (field of a context-item object). The elements must be specified in ascending order, and they are returned in that order: fourth, ninth, tenth, eleventh, thirteenth.

$.friends[3].cars – The value of field cars of an object that is the fourth element of an array friends. The dot (.) indicates that the fourth element is an object (with a cars field).

$.friends[3].* – The values of all of the fields of an object that is the fourth element of an array friends.

$.friends[3].cars[0].year – The value of field year of an object that is the first element of an array that is the value of field cars of an object that is the fourth element of an array friends.

$.friends[3].cars[0]?(@.year > 2014) – The first object of an array cars (field of an object that is the fourth element of an array friends), provided that the value of its field year is greater than 2014.

$.friends[3]?(@.addresses.city == "San Francisco") – An object that is the fourth element of an array friends, provided that it has an addresses field whose value is an object with a field city whose value is the string "San Francisco".

$.friends[3]?(@.addresses.city == "San Francisco" && @.addresses.state == "Nevada") – Objects that are the fourth element of an array friends, provided that there is a match for an address with a city of "San Francisco" and there is a match for an address with a state of "Nevada".

Note: The filter conditions in the conjunction do not necessarily apply to the same object — the filter tests for the existence of an object with city San Francisco and for the existence of an object with state Nevada. It does not test for the existence of an object with both city San Francisco and state Nevada. See Using Filters with JSON_EXISTS.

$.friends[3].addresses?(@.city == "San Francisco" && @.state == "Nevada") – An object that is the fourth element of array friends, provided that object has a match for city of "San Francisco" and a match for state of "Nevada".

https://docs.oracle.com/en/database/oracle/oracle-database/18/adjsn/json-path-expressions.html#GUID-D951D27D-6918-40E8-8A0D-8D60AB83FD4A

https://docs.oracle.com/en/database/oracle/oracle-database/18/adjsn/function-JSON_TABLE.html#GUID-0172660F-CE29-4765-BF2C-C405BDE8369A

-- Create new pluggable database. You may not need that if you are running in a non-CDB environment.
CREATE PLUGGABLE DATABASE TEST ADMIN USER ADMIN IDENTIFIED BY ADMIN
FILE_NAME_CONVERT=('/opt/oracle/oradata/DEV/pdbseed', '/opt/oracle/oradata/DEV/TEST');

-- You may not need that if you are running in a non-CDB environment.
ALTER PLUGGABLE DATABASE TEST OPEN;

--You may not need that if you are running in a non-CDB environment.
ALTER SESSION SET CONTAINER=TEST;

-- Creating a scratch tablespace. You may not need that if you are running in a non-CDB environment.
CREATE BIGFILE TABLESPACE USERS DATAFILE '/opt/oracle/oradata/DEV/TEST/users.dbf' SIZE 20M;

-- Create a test user for the example and grant the right privileges.
CREATE USER TEST IDENTIFIED BY test DEFAULT TABLESPACE USERS;
GRANT CONNECT,RESOURCE TO TEST;
GRANT EXECUTE ON DBMS_LOCK TO TEST;
GRANT EXECUTE ON DBMS_RANDOM TO TEST;
ALTER USER TEST QUOTA UNLIMITED ON USERS;

-- Connect as test user
conn TEST/test@//localhost:1521/TEST

-- Create JSON table holidng a JSON document
CREATE TABLE JSON (doc CLOB CONSTRAINT check_is_valid_json CHECK (doc IS JSON));

