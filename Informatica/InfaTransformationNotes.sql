Interview Questions

What are the differences between Connected and Unconnected Lookup?

Connected Lookup
Connected lookup participates in dataflow and receives input directly from the pipeline
Connected lookup can use both dynamic and static cache
Connected lookup can return more than one column value ( output port ) 
Connected lookup caches all lookup columns 
Supports user-defined default values (i.e. value to return when lookup conditions are not satisfied)

Unconnected Lookup
Unconnected lookup receives input values from the result of a LKP: expression in another transformation 
Unconnected Lookup cache can NOT be dynamic 
Unconnected Lookup can return only one column value i.e. output port 
Unconnected lookup caches only the lookup output ports in the lookup conditions and the return port 
Does not support user defined default values 

Only the lookup and Stored Procedure transformations can be connected and unconnected, all other transformations are connected.

What is meant by active and passive transformation?

An active transformation is the one that performs any of the following actions: 
1.Change the number of rows between transformation input and output. Example: Filter transformation
2.Change the transaction boundary by defining commit or rollback points., example transaction control transformation
3.Change the row type, example Update strategy is active because it flags the rows for insert, delete, update or reject

What is the difference between Router and Filter?

Router
Router transformation divides the incoming records into multiple groups based on some condition. 
Router transformation itself does not block any record. 
Router acts like CASE.. WHEN statement in SQL (Or Switch().. Case statement in C) 


Filter
Such groups can be mutually inclusive (Different groups may contain same record) Filter transformation restricts or blocks the incoming record set based on one given condition. 
If a certain record does not match any of the routing conditions, the record is routed to default group Filter transformation does not have a default group. If one record does not match filter condition, the record is blocked 
Filter acts like WHERE condition is SQL.

What can we do to improve the performance of Informatica Aggregator Transformation?

Aggregator performance improves dramatically if records are sorted before passing to the aggregator and "sorted input" option under aggregator properties is checked. The record set should be sorted on those columns that are used in Group By operation. It is often a good idea to sort the record set in database level e.g. inside a source qualifier transformation, unless there is a chance that already sorted records from source qualifier can again become unsorted before reaching aggregator 

What are the different lookup cache(s)?
Y1

Infa Book Notes 
------------------------
------------------------
------------------------
Source Qualifier
Filtering
You can add the WHERE clause in the SQL query while you override the default query. When you add the WHERE clause, you reduce the number of records extracted from 
the source. This way, we can say that our Source Qualifier transformation is acting as a filter transformation.

Joining the source data
You can use the Source Qualifier transformation to define the user-defined join types. When you use this option, you can avoid using the Joiner transformation in the mapping. When you use the Source Qualifier transformation to join the data from two database tables, you will not use the master or detail join. You will use the database-level join types, such as the left and right join.

Sorting the data
You can also use the Source Qualifier transformation to sort the data while extracting the data from the database table. When you use the sorted port option, Integration Service will add defined ports to the ORDER BY clause in the default query. It will keep the sequence of the ports in the query similar to the sequence of ports defined in the transformation.

Properties tab > select distinct, number of sorted ports, presql post sql.

Look Up
A Lookup transformation has four different types of ports.
Input Ports (I): The input ports receive the data from other transformations. This port will be used in the lookup condition. You need to have at least one input port.
Output Port (O): Output ports pass the data from the Lookup transformation to other transformations.
Lookup Port (L): Each column in look up source is assigned as the lookup(L) and output(O) port when you create the Lookup transformation. If you delete the lookup port
from the flat file lookup source, the session will fail. If you delete the lookup port from the relational lookup table, Integration Service extracts the data with only the lookup port. This helps to reduce the data extracted from the lookup source.
Return Port (R): This is only used in the case of an unconnected Lookup transformation. It indicates which data you wish to return in the Lookup transformation. You can define only one port as the return port, and it is not used in the case of connected Lookup transformations.

Unconnected Lookup transformations
Unconnected transformations are not connected to any other transformation, source, or target by any links. An unconnected Lookup transformation is called by another transformation with the :LKP function. Using the :LKP function, you can pass the required value to the input port of the Lookup transformation, and the return port passes the output value back to the transformation from which the lookup was called.

:LKP.LKP_FILE(EMPLOYEE_ID)

Lookup transformation properties
Lookup table name : This is the name of the table that you are looking up using the Lookup transformation.
Lookup source filter : Integration Service will extract only those records that satisfy the filter condition defined.
Lookup cache enabled  : This property indicates whether Integration Service caches data during the processing. Enabling this property enhances performance.
Lookup policy on multiple match : The various options available are: • Use First Value • Use Last Value • Use Any Value • Report Error
Lookup condition : This is the lookup condition you defined in the Condition tab of the Lookup transformation.
Connection information : This property indicates the database connection used to extract data in the Lookup transformation.
Source type  : This gives you information indicating that the Lookup transformation is looking up on flat file, a relational database, or a source qualifier.
Dynamic lookup cache : Select this option if you wish to make the lookup cache dynamic.

¨ Static cache. You can configure a static, or read-only, cache for any lookup source. By default, the Integration Service creates a static cache. It caches the lookup file or table and looks up values in the cache for each row that comes into the transformation. When the lookup condition is true, the Integration Service returns a value from the lookup cache. The Integration Service does not update the cache while it processes the Lookup transformation.
¨ Dynamic cache. To cache a table, flat file, or source definition and update the cache, configure a Lookup transformation with dynamic cache. The Integration Service dynamically inserts or updates data in the lookup cache and passes the data to the target. The dynamic cache is synchronized with the target.

When you cache the target table as the lookup, you can look up values in the target and insert them if they do not exist, or update them if they do

The Update Strategy transformation
Update Strategy transformations are used to INSERT, UPDATE, DELETE, or REJECT records based on the defined condition in the mapping. An Update Strategy transformation is mostly used when you design mappings for slowly changing dimensions. When you use the session task, you instruct Integration Service to treat all records in the same way, that is, either INSERT, UPDATE, or DELETE. But when you use the Update Strategy transformation in the mapping, this allows you to INSERT, UPDATE, DELETE, or REJECT records based on the requirement. You need to define the following functions to perform the corresponding operations:

• DD_INSERT: This is used when you wish to insert records, which are also represented by the numeral 0
• DD_UPDATE: This is used when you wish to update the records, which are also represented by the numeral 1
• DD_DELETE: This is used when you wish to delete the records, which are also represented by the numeral 2
• DD_REJECT: This is used when you wish to reject the records, which are also represented by the numeral 3

Consider that we wish to implement a mapping using the Update Strategy transformation, which allows all employees with salaries higher than 10000 to reach the target and eliminates all other records.

Double-click on the Update Strategy transformation and click on Properties to add the condition:
IIF(SALARY >= 10000, DD_INSERT, DD_REJECT)

The Update Strategy transformation accepts the records in a row-wise manner and checks each record for the condition defined. Based on this, it rejects or inserts the
data into the target.

The Normalizer transformation
The Normalizer transformation is used in place of Source Qualifier transformations when you wish to read the data from the cobol copybook source. Also, a Normalizer transformation is used to convert column-wise data to row-wise data.

The Lifeline of Informatica – Transformations Page 205

Every transformation, with a few exceptions, has input and output ports
For expression transformation, when you add new port to perform some manipulation make sure to uncheck the input port, else you will not be allowed to enter any expression. Only output or variable ports can have expressions. port can be input and output or only output or only variable. Make sure you defint eh proper data type and size. Function tab of expression transformation give the list of available function and their syntax and usage.

Can we have output ports not connected to the down stream transformation?

Aggregator transformation

simply calculating sum(sal) for all employees > only connect the sal port to the aggregator transformation, add a new port as output port and put the expression as sum(salary). 
if you want the data grouped across department id, join the department id port and check the group by check box.
It is always recommended that we pass the Sorted Input to the Aggregator transformation, as this will enhance performance. When you pass the sorted input to the Aggregator transformation, Integration Service enhances the performance by storing less data in the cache.
When you pass the sorted data to the Aggregator transformation, check the Sorted Input option in the properties.

Sorter transformation

If we wish to sort the data based on the DEPARTMENT_ID field. To achieve this, mark the key port for the DEPARTMENT_ID columns in the Sorter transformation and select from the drop-down list what you wish to have as the Ascending or Descending sorting.
If you wish to sort the data in multiple columns, check the Key ports corresponding to the required port.
Apart from ordering the data in ascending or descending order, you can also use the Sorter transformation to remove duplicates from the data using the Distinct option in the properties. The sorter can remove duplicates only if the complete record is a duplicate and not just a particular column.

The Sorter transformation accepts the data in a row-wise manner and stores the data in the cache internally. Once all the data is received, it sorts the data in ascending or descending order based on the condition and sends the data to the output port.

Filter transformation

To add a Filter, double-click on the Filter transformation and click on the Properties tab. click on the expression editor button and add the filter expression. If yuo  use the condition as DEPARTMENT_ID=100; this will allow records with DEPARTMENT_ID as 100 to reach the target, and the rest of the records will get filtered.

Router transformation
Can be used in place of in place multiple filters. Router transformations accept the data through an input group once, and based on the output groups you define, it sends the data to multiple output ports. 
When you drag the columns to the router, the Router transformation creates an input group with only input ports and no output port. To add the output groups, click on
the Groups tab and add two new groups. Enter the name of each group under the group name and define the filter condition for each group.

When you add the group, a DEFAULT group gets created automatically. All nonmatching records from the other groups will pass through the default group if you connect the DEFAULT group`s output ports to the target.

Rank transformation

The Rank transformation is used to get a specific number of records from the top or bottom. Consider that you need to take the top five salaried employees from
the EMPLOYEE table.

When you create a Rank transformation, a default RANKINDEX output port comes with the transformation. It is not mandatory to use the RANKINDEX port. You need to check the rank port based which you wihc to rank. If you do not wish to use rank index, you can leave the port unconnected.
You cannot rank the data on multiple ports, you will be allowed to check only one column from the list. Also, you need to define either the "Top" or "Bottom" option and the "Number of Ranks" you wish to rank in the Properties tab. In our case "Number of Ranks" needs to eb set as 5 (default is 1).

Rank transformations accept the data in a row-wise manner and store the data in the cache. Once all the data is received, it checks the data based on the condition and sends the data to the output port.

Group by ranking : Rank transformation also provides a feature to get the data based on a particular group. Consider the scenario discussed previously. We need to get the top five salaried employees from each department. To achieve the functionality, we need to select the group by option for department_id column.

Suppose you have the following data belonging to the SALARY column in the source:
Salary
100
1000
500
600
1000
800
900

the Rank transformation generates the rank index as indicated here:
Rank_Index, Salary
1,1000
1,1000
3,900
4,800
5,600

As you can see, the rank index assigns 1 rank to the same salary values, and 3 to the next salary. So if you have five records with 1000 as the salary in the source along
with other values, and you defined conditions to get the top five salaries, Rank transformation will give all five records with a salary of 1000 and reject all others.

Sequence Generator transformation
Unique values are generated based on the property defined in the Sequence Generator transformation.
The Sequence Generator transformation has only two ports, NEXTVAL and CURRVAL. Both the ports are output ports.

Consider a scenario where we are passing two records to the transformation. in our case, we have defined the start value as 0, the increment by value as 1, and the
end value is the default in the property. Also, the current value defined in Properties is 1. The following is the sequence of events:
1. When the first record enters the target from the filter transformation, the current value, which is set to 1 in the Properties of the sequence generator, is assigned to the NEXTVAL port. This gets loaded into the target by the connected link. So for the first record, SEQUENCE_NO in the target is given
the value of 1.
2. The sequence generator increments CURRVAL internally and assigns that value to the current value, 2 in this case.
3. When the second record enters the target, the current value that is set as 2 now gets assigned to NEXTVAL. The sequence generator gets incremented internally to give CURRVAL a value of 3.

So at the end of the processing of record 2, the NEXTVAL port will have a value of 2 and the CURRVAL port will have its value set as 3. This is how the cycle keeps on running till you reach the end of the records from the source.

Start Value: This comes into the picture only if you select the Cycle option in the properties. Start Value indicates the Integration Service that starts over from this value when the end value is reached after you have checked the cycle option. The default value is 0 and the maximum value is 9223372036854775806.
Current Value: This indicates the value assigned to the CURRVAL port. Specify the current value that you wish to have as the value for the first record. As mentioned earlier, the CURRVAL port gets assigned to NEXTVAL, and the CURRVAL port is incremented.

The CURRVAL port stores the value after the session is over, and when you run the session the next time, it starts incrementing the value from the stored value if you have not checked the reset option. If you check the reset option, Integration Services resets the value to 1. Suppose you have not checked the Reset option and you have passed 17 records at the end of the session; then, the current value will be set to 18, which will be stored internally. When you run the session the next time, it starts generating the value from 18.

Usage > Generating a primary/foreign key,  Replace the missing values: IIF( ISNULL (JOB_ID), NEXTVAL, JOB_ID)

The Joiner transformation
A Joiner transformation has two pipelines; one is called master and the other is called detail. One source is called the master source and the other is called detail. We do not have left or right joins like we have in the SQL database. To use a Joiner transformation, drag all the required columns from two sources into the Joiner transformation and define the join condition and join type in the properties.

By default, when you add the first source, it becomes the detail and the other becomes the master. You can decide to change the master or detail source. To
make a source the master, check the Master port for the corresponding source. By clicking at M column of any port from the source makes it the master.(not required to check all the ports).
It is always recommended that you create a table with a smaller number of records as the master and the other as the detail. This is because Integration Service picks u the data from the master source and scans the corresponding record in the details table.

Join conditions are the most important condition to join the data. To define the join condition, you need to have a common port in both the sources. Also, make sure the
data type and precision of the data you are joining is same. You can join the data based on multiple columns as well. Joining the data on multiple columns increases the processing time. Joiner transformations do not consider NULL as matching data.

Join type : The Joiner transformation matches the data based on the join type defined. it can be normal join, master outer join, detail outer join or full outer join.
Master Outer Join > All records from details will be in the output regardless of matching row in the master source. Assume that you are putting the plus on master side, less info on master side.
Detail outer join > All records from master will be in the output regardless of matching row in detail. Assume that you are putting plus on detail side. less info on detail side.

Oracle Example Recap
select
  author_last_name,
  book_key
from
  author,
  book_author
where  
  author.author_key = book_author.author_key(+)
order by author_last_name;
same as
select
    author_last_name,
    book_key
from
    author left outer join book_author using (author_key)
order by author_last_name;

In the example above, the AUTHOR table is on the left, and we are using a left outer join, so we get all the rows in the AUTHOR table and the matching rows in the book_author table. Notice the (+) in the WHERE clause.  This indicates a left outer join.  If we were using a right outer join, the WHERE clause would be:  author.author_key(+) = book_author.author_key

Union transformation

Union is a multiple input, single output transformation. It is the opposite of router. The basic criterion to use a Union transformation is that you should have data with the matching data type. If you do not have data with the matching data type coming from multiple sources, the Union transformation will not work.

Working on Union transformation is a little different from other transformations.

As soon you drag the port, the union creates an input group and also creates another output group with the same ports as the input. Output ports added in the transformation. Also add as many groups as the input sources you have.
Link the ports from the other source to the input ports of the other group in the Union transformation.

Source Qualifier transformation
A source qualifier is the point where the Informatica processing actually starts. The extraction process starts from the source qualifier.
Note that it is always recommended that the columns of source and source qualifier match. Do not change the columns or their data type in the source qualifier. You can note the data type difference in the source definition and source qualifier, which is because Informatica interprets the data in that way itself.

Viewing the default query
When you use the relational database as a source, the source qualifier generates a default SQL query to extract the data from the database table. Properties
tab > select the SQL query > Click on the Generate SQL option. If required, specify the database username and password. Informatica shows you the default query based on the links connected from the Source Qualifier transformation, only those columns are selectedwhich are connected to the next transformations.
We can override the default query generated by the Source Qualifier transformation. You should not change the list of ports or the order of the ports in the default query. If you have not used SQL override then by default the query field would be null and you need to click generate sql to view the underlyign sql. 
You may use database joins as well.

You can also use the Source Qualifier transformation to sort the data while extracting the data from the database table. Properties tab > specify Number Of Sorted Ports
also option of selecting distinct records : Properties tab > Select Distinct option

Active and passive

Connected and unconnected
A transformation is said to be connected if it is connected to any source, target, or any other transformation by at least one link. If the transformation is not connected by any link, it it classified as unconnected. Only the lookup and Stored Procedure transformations can be connected and unconnected, all other transformations are connected.

lookup - specify the look up condition in the condition tab. A Lookup transformation has four different types of ports.
Input Ports (I): The input ports receive the data from other transformations. This port will be used in the lookup condition. You need to have at least one input port.
Output Port (O): Output ports pass the data from the Lookup transformation to other transformations.
• Lookup Port (L): Each column is assigned as the lookup and output port when you create the Lookup transformation. If you delete the lookup port from the flat file lookup source, the session will fail. If you delete the lookup port from the relational lookup table, Integration Service extracts the data with only the lookup port. This helps to reduce the data extracted from the lookup source.
• Return Port (R): This is only used in the case of an unconnected Lookup transformation. It indicates which data you wish to return in the Lookup transformation. You can define only one port as the return port, and it is not used in the case of connected Lookup transformations.

Similar to the Source Qualifier transformation, which generates a default query when you use the source as a relational database table, the Lookup transformation also
generates a default query based on the ports used in the Lookup transformation. To check the default query generated by the Lookup transformation, click on the Properties tab and open Lookup Sql Override.

An unconnected Lookup transformation is called by another transformation with the :LKP function. Using the :LKP function, you can pass the required value to the input port of the Lookup transformation, and the return port passes the output value back to the transformation from which the lookup was called.

:LKP.LKP_FILE(EMPLOYEE_ID) -- LKP_FILE is the lookup transformation name. EMPLOYEE_ID is the input port name, and it returns the return port from the look up transformation.

Update Strategy transformation
An Update Strategy transformation is mostly used when you design mappings for slowly changing dimensions. 
When you use the session task, you instruct Integration Service to treat all records in the same way, that is, either INSERT, UPDATE, or DELETE. When you use the Update Strategy transformation in the mapping, the control is no longer with the session task. The Update Strategy transformation allows you to INSERT, UPDATE, DELETE, or REJECT records based on the requirement. You need to define the following functions to perform the corresponding operations:

• DD_INSERT: This is used when you wish to insert records, which are also represented by the numeral 0
• DD_UPDATE: This is used when you wish to update the records, which are also represented by the numeral 1
• DD_DELETE: This is used when you wish to delete the records, which are also represented by the numeral 2
• DD_REJECT: This is used when you wish to reject the records, which are also represented by the numeral 3

Requirement to allow all employees with salaries higher than 10000 to reach the target and eliminates all other records.

Double-click on the Update Strategy transformation and click on Properties to add the condition: IIF(SALARY >= 10000, DD_INSERT, DD_REJECT)

Normalizer transformation :  
A Normalizer transformation is used to convert column-wise data to row-wise data. Its similar to unpivot of Oracle.

Normalizer transformation ports are different from other transformations ports. You cannot edit the ports of Normalizer transformations. To define the ports, you need to
configure the Normalizer tab of a Normalizer transformation. 
Add the columns to the Normalizer tab. You need to add the single and multiple occurring ports in the Normalizer tab. When you have multiple occurring columns, you need to define them under the Occurs column. When you add the columns in the Normalizer tab, the columns get reflected in the Ports tab based on the options definitions.

The Normalizer transformation creates a new port called generated column ID (GCID) for every multi-occurring ports you define in the Normalizer tab.

Stored Procedure transformation
Importing the stored procedure is similar to importing the database tables
Mapping Designer > Transformation > Import Stored Procedure
Usually, the best practice is to import the stored procedure, as it takes care of all the properties automatically. Also you have the option of creating the transformation, and you need to take care of all the input, output, and return ports in the Stored Procedure transformation.
The unconnected Stored Procedure transformation is called by another transformation using the :SP function. It works in a manner similar to an unconnected Lookup transformation, which is called using the :LKP function.

Transaction Control transformations

By default, Integration Service commits the data based on the properties you define at the session task level. Using the Commit Interval property, Integration Service commits or rolls backs the data into the target. Suppose you define Commit Interval as 10,000, Integration Service will commit the data after every 10,000 records. When you use a Transaction Control transformation, you get the control at each record to commit or roll back.

When you use the Transaction Control transformation, you need to define the condition in the expression editor of the Transaction Control transformation. When you run the process, the data enters the Transaction Control transformation in a row-wise manner. The Transaction Control transformation evaluates each row, based on which it commits or rolls back the data.

Double-click on the Transaction Control transformation and click on Properties. We need to define the condition in the Transaction Control transformation expression editor.

The Transaction Control transformation supports the following built-in variables in
the expression editor:
• TC_COMMIT_BEFORE: Integration Service commits the current record, starts processing a new record, and then writes the current row to the target.
• TC_COMMIT_AFTER: Integration Service commits and writes the current record to the target and then starts processing the new record.
• TC_ROLLBACK_BEFORE: Integration Service rolls back the current record, starts processing the new record, and then writes the current row to the target.
• TC_ROLLBACK_AFTER: Integration Service writes the current record to the target, rolls back the current record, and then starts processing the new record.
• TC_CONTINUE_TRANSACTION: This is the default value for the Transaction Control transformation. Integration Service does not perform any transaction operations for the record.

Types of lookup cache

A cache is the temporary memory that is created when you execute the process. Caches are created automatically when the process starts and is deleted automatically once the process is complete. 

There are different types of caches available.

You can define the session property to create the cache either sequentially or concurrently.

Sequential cache : When you choose to create the cache sequentially, Integration Service caches the data in a row-wise manner as the records enter the Lookup transformation.
Concurrent cache : Integration Service does not wait for the data to flow from the source, but it first caches the complete data. Once the caching is complete, it allows the data to flow from the source.

Persistent cache – By default, caches are created as nonpersistent, that is, they will be deleted once the session run is complete. If the lookup table or file does not change across the session runs, you can use the existing persistent cache.

Suppose that you have a process that is scheduled to run every day and you are using a Lookup transformation to look up a reference table that is not supposed to change for 6 months. If you choose to create a persistent cache, Integration Service makes the cache permanent in the form of a file in the $PMCacheDir location, so you save the time required to create and delete the cache memory every day.

When the data in the lookup table changes, you need to rebuild the cache. You can define the condition in the session task to rebuild the cache by overwriting the existing cache.

Modifying cache – static or dynamic
When you create a cache, you can configure it to be static or dynamic.
A cache is said to be static if it does not change with the changes happening in the lookup table. A static cache is not synchronized with the lookup table. By default, Integration Service creates a static cache.

Dynamic cache
A cache is said to be dynamic if it changes with the changes happening in the lookup table. The dynamic cache is synchronized with the lookup table.
From the Lookup transformation properties, you can choose to make the cache dynamic. The lookup cache is created as soon as the first record enters the Lookup transformation. Integration Service keeps on updating the cache while it is processing the data.

You use the dynamic cache while you process slowly changing dimension tables. For every record inserted into the target, the record will be inserted in the cache.

The Deployment Phase – Using Repository Manager
Informatica PowerCenter provides three ways to migrate the code from one environment to another, that is, Export/Import, Copy/Paste, and Drag/Drop.



------------------------
------------------------
Filter Transformation >
The Filter transformation allows rows that meet the specified filter condition to pass through. It drops rows that do not meet the condition.
A filter condition returns TRUE or FALSE for each row that the Integration Service evaluates, For each row that returns FALSE, the Integration Service drops and writes a message to the session log.
You cannot concatenate ports from more than one transformation into the Filter transformation. The input ports for the filter must come from a single transformation.
The numeric equivalent of FALSE is zero (0). Any non-zero value is the equivalent of TRUE.
If the filter condition evaluates to NULL, the row is treated as FALSE.
Filtering Rows with Null Values > IIF(ISNULL(FIRST_NAME),FALSE,TRUE)  -- if you want to filter out rows that contain NULL value in the FIRST_NAME port,
IS_SPACES -- if the value is space characters
The Source Qualifier transformation provides an alternate way to filter rows. However, the Source Qualifier transformation only lets you filter rows from relational sources, while the Filter transformation filters rows from any type of source. Also, note that since it runs in the database, you must make sure that the filter condition in the Source Qualifier transformation only uses standard SQL.

HTTP Transformation >

The HTTP transformation enables you to connect to an HTTP server to use its services and applications. When you run a session with an HTTP transformation, the Integration Service connects to the HTTP server and issues a request to retrieve data from or update data on the HTTP server.

Read data from an HTTP server.
Update data on the HTTP server.
Configuring the HTTP Tab
Select the method. Select GET, POST, or SIMPLE POST
Configure groups and ports. Manage HTTP request/response body and header details by configuring input and output ports.
Configure a base URL. Configure the base URL for the HTTP server you want to connect to.

Joiner Transformation
Use the Joiner transformation to join source data from two related heterogeneous sources residing in different locations or file systems.
The Joiner transformation uses a condition that matches one or more pairs of columns between the two sources.
The two input pipelines include a master pipeline and a detail pipeline or a master and a detail branch. The master pipeline ends at the Joiner transformation, while the detail pipeline continues to the target.???
To join more than two sources in a mapping, join the output from the Joiner transformation with another source pipeline.

¨ You cannot use a Joiner transformation when either input pipeline contains an Update Strategy transformation.
¨ You cannot use a Joiner transformation if you connect a Sequence Generator transformation directly before the Joiner transformation.

join condition : The join condition contains ports from both input sources that must match for the Integration Service to join two rows.
join type : A join is a relational operator that combines data from multiple tables in different databases or flat files into a single result set. You can configure the Joiner transformation to use a Normal, Master Outer, Detail Outer, or Full Outer join type.

The Joiner transformation produces result sets based on the join type, condition, and input data sources.

During a session, the Integration Service compares each row of the master source against the detail source. To improve performance for an unsorted Joiner transformation, use the source with fewer rows as the master source. To improve performance for a sorted Joiner transformation, use the source with fewer duplicate key values as the master.

By default, when you add ports to a Joiner transformation, the ports from the first source pipeline display as detail sources. Adding the ports from the second source pipeline sets them as master sources. To change these settings, click the M column on the Ports tab for the ports you want to set as the master source. This sets ports from this source as master ports and ports from the other source as detail ports.
The order of the ports in the condition can impact the performance of the Joiner transformation. If you use multiple ports in the join condition, the Integration Service
compares the ports in the order you specify.

If you join Char and Varchar datatypes, the Integration Service counts any spaces that pad Char values as part of the string: same as in oracle

Note: The Joiner transformation does not match null values. For example, if both EMP_ID1 and EMP_ID2 contain a row with a null value, the Integration Service does not consider them a match and does not join the two rows. To join rows with null values, replace null input with default values, and then join on the default values.

Normal Join : The Integration Service discards all rows of data from the master and detail source that do not match, based on the condition.
Master Outer Join : A master outer join keeps all rows of data from the detail source and the matching rows from the master source. It discards the unmatched rows from the master source.
Detail Outer Join : A detail outer join keeps all rows of data from the master source and the matching rows from the detail source. It discards the unmatched rows from the detail source.
Full Outer Join : A full outer join keeps all rows of data from both the master and detail sources.
You can improve session performance by configuring the Joiner transformation to use sorted input.

¨ Configure the sort order. Configure the sort order of the data you want to join. You can join sorted flat files, or you can sort relational data using a Source Qualifier transformation. You can also use a Sorter transformation.
¨ Add transformations. Use transformations that maintain the order of the sorted data. 
¨ Configure the Joiner transformation. Configure the Joiner transformation to use sorted data and configure the join condition to use the sort origin ports. The sort origin represents the source of the sorted data.

If you pass unsorted or incorrectly sorted data to a Joiner transformation configured to use sorted data, the session fails and the Integration Service logs the error in the session log file.

¨ Do not place any of the following transformations between the sort origin and the Joiner transformation:
- Custom
- Unsorted Aggregator
- Normalizer
- Rank
- Union transformation
- XML Parser transformation
- XML Generator transformation
- Mapplet, if it contains one of the above transformations

Example of a Join Condition
For example, you configure Sorter transformations in the master and detail pipelines with the following sorted ports:
1. ITEM_NO
2. ITEM_NAME
3. PRICE

When you configure the join condition, use the following guidelines to maintain sort order:
¨ You must use ITEM_NO in the first join condition.
¨ If you add a second join condition, you must use ITEM_NAME.
¨ If you want to use PRICE in a join condition, you must also use ITEM_NAME in the second join condition.
If you skip ITEM_NAME and join on ITEM_NO and PRICE, you lose the sort order and the Integration Service fails the session.

Blocking the Source Pipelines : When you run a session with a Joiner transformation, the Integration Service blocks and unblocks the source data, based on the mapping configuration and whether you configure the Joiner transformation for sorted input.

Unsorted Joiner Transformation
When the Integration Service processes an unsorted Joiner transformation, it reads all master rows before it reads the detail rows. To ensure it reads all master rows before the detail rows, the Integration Service blocks the detail source while it caches rows from the master source. Once the Integration Service reads and caches all master rows, it unblocks the detail source and reads the detail rows. Some mappings with unsorted Joiner transformations violate data flow validation. 

Sorted Joiner Transformation
When the Integration Service processes a sorted Joiner transformation, it blocks data based on the mapping configuration. Blocking logic is possible if master and detail input to the Joiner transformation originate from different sources.

The Integration Service uses blocking logic to process the Joiner transformation if it can do so without blocking all sources in a target load order group simultaneously. Otherwise, it does not use blocking logic. Instead, it stores more rows in the cache.
When the Integration Service can use blocking logic to process the Joiner transformation, it stores fewer rows in the cache, increasing performance.

Working with Transactions ??? Needs further attention later

Lookup Transformation

Use a Lookup transformation in a mapping to look up data in a flat file, relational table, view, or synonym. You can import a lookup definition from any flat file or relational database to which both the PowerCenter Client and Integration Service can connect. You can also create a lookup definition from a source qualifier.

The Integration Service queries the lookup source based on the lookup ports in the transformation and a lookup condition. The Lookup transformation returns the result(single row or multiple row) of the lookup to the target or another transformation

Perform the following tasks with a Lookup transformation:
¨ Get multiple values. Retrieve multiple rows from a lookup table. For example, return all employees in a
department.
¨ Get a related value. For example, the source has an employee ID. Retrieve the employee name from the lookup table.
¨ Perform a calculation. Retrieve a value from a lookup table and use it in a calculation. For example, retrieve a sales tax percentage, calculate a tax, and return the tax to a target.
¨ Update slowly changing dimension tables. Determine whether rows exist in a target.

When you create a Lookup transformation, you can choose a relational table, flat file, or a source qualifier as the lookup source.

A Lookup transformation has four different types of ports.

Tests
??? Can we assign expressions to the target object ports in  a mapping
??? Can we sue SQL to join data from two diff source files
can we use sysdate from a source qualifier

The two input pipelines include a master pipeline and a detail pipeline or a master and a detail branch. The master pipeline ends at the Joiner transformation, while the detail pipeline continues to the target.???
¨ You cannot use a Joiner transformation if you connect a Sequence Generator transformation directly before the Joiner transformation. ???

When you create a Lookup transformation using a relational table as a lookup source, you can connect to the lookup source using ODBC and import the table definition as the structure for the Lookup transformation.

Use the following options with relational lookups:
¨ Override the default SQL statement to add a WHERE clause or to query multiple tables.

When you create a Lookup transformation using a flat file as a lookup source, select a flat file definition in the
repository or import the source when you create the transformation.

http://adivaconsulting.com/bi-publisher/item/134-informatica-vs-oracle-data-integrator.html

Neither product will save you if the data model sucks because the wrong person is leading.

Patch application process is still failing. can we please get the index PK_DATABASECHANGELOGLOCK moved to EFRAME_INDX tablespace?

ALTER INDEX EFRAME_DATA.PK_DATABASECHANGELOGLOCK REBUILD TABLESPACE EFRAME_INDX;

db.bat clearChecksums
db.bat update
Deleted the old work floder

eFrame UserName:
First Name:
Last Name:
Email ID:
Access/Privileges Required: What roles and for which environments

work folders are inside

work folder from c:\tmp, tomcat\bin, tomcat\webapp, tomcat\

jespa-1.1.7.jar
Properties files were being over written
Single sign on stopped working

Most likely we will be facing the same problem during production deployment.

Provider=OraOLEDB.Oracle;Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=gba71010)(PORT=11200)))(CONNECT_DATA=(SID=AMSPERF)(GLOBAL_NAME=AMSPERF)));Password=PIy77b9f79;User ID=ams_eframe

PIy77b9f79

sqlplus ams_eframe/PIy77b9f79@gba71010:11200/AMSPERF

Apex Kerberos user Authentication

