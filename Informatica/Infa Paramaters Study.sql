A mapping parameter represents a constant value that can change between mapping runs, such as connections, source file directories, or cache file directories. You can use system or user-defined parameters when you run a mapping. You can create user-defined workflow parameters when you develop a workflow.

System Parameters
System parameters are constant values that define the directories where the Data Integration Service stores cache files, reject files, source files, target files, and temporary files.
You define the values of the system parameters on a Data Integration Service process in the Administrator tool. You cannot define or override system parameter values in a parameter file.  You cannot create system parameters. The Developer tool provides a pre-defined list of system parameters that you can assign to a data object or transformation in a mapping. For example, when you create an Aggregator transformation, the cache directory system parameter is the default value assigned to the cache directory field.

System Parameter : Type : Description
CacheDir : String : Default directory for index and data cache files.
RejectDir : String : Default directory for reject files.
SourceDir : String : Default directory for source files.
TargetDir : String : Default directory for target files.
TempDir   : String : Default directory for temporary files.

User-Defined Parameters
User-defined parameters represent values that change between mapping runs. You can create user-defined parameters that represent connections, long values, or string values.

You can create the following types of user-defined parameters:
¨ Connection. Represents a database connection. You cannot create connection parameters for enterprise application or social media connections.
¨ Long. Represents a long or integer value.
¨ String. Represents a flat file name, flat file directory, cache file directory, temporary file directory, or type of mapping run-time environment.


Create a user defined parameter assign a default value, apply the parameter to the mapping, or data object or transformation. Add the mapping to the application, create a parameter file for the mapping and run the mapping from command line.

You can create user-defined parameters in physical data objects, some reusable transformations, mappings, and mapplets.

Where to Assign Parameters
Assign a system parameter to a field when you want the Data Integration Service to replace the parameter with the value defined for the Data Integration Service process. Assign a user-defined parameter to a field when you want the Data Integration Service to replace the parameter with the value defined in a parameter file.

The following table lists the objects and fields where you can assign system or user-defined parameters:
Object : Field
Aggregator transformation : Cache directory
Customized data object : Connection
Flat file data object : Source file name, Output file name, Source file directory, Output file directory, Connection name, Reject file directory
Joiner transformation : Cache directory
Lookup transformation (flat file lookups) : Lookup cache directory name
Lookup transformation (relational lookups) : Connection, Lookup cache directory name
Mapping : Run-time environment
Nonrelational data object : Connection
Rank transformation : Cache directory
Read transformation created from related relational data objects : Connection
Sorter transformation : Work directory

1. Open the field in which you want to assign a parameter. 2. Click Assign Parameter. The Assign Parameter dialog box appears. 3. Select the system or user-defined parameter. 4. Click OK.

Use the "infacmd ms ListMappingParams" command to list the parameters used in a mapping with the default values. You can use the output of this command as a parameter file template.
Use the "infacmd ms RunMapping" command to run a mapping with a parameter file.

A parameter file must conform to the structure of the parameter file XML schema definition (XSD). If the parameter file does not conform to the schema definition, the Data Integration Service fails the mapping run.

On the machine that hosts the Developer tool, the parameter file XML schema definition appears in the following directory:
<Informatica Installation Directory>\clients\DeveloperClient\infacmd\plugins\ms\parameter_file_schema_1_0.xsd
On the machine that hosts Informatica Services, the parameter file XML schema definition appears in the following directory:
<Informatica Installation Directory>\isp\bin\plugins\ms\parameter_file_schema_1_0.xsd

Deployment
Deploy objects or deploy an application that contains one or more objects.
Deploy an object
Deploy an object to make the object available to end users. If you redeploy an object to a Data Integration Service, you cannot update the application. The Developer tool creates an application with a different name. When you deploy the following objects, the Developer tool prompts you to create an application and the Developer tool
adds the object to the application:
¨ Mappings
¨ Workflows

Deploy an application that contains objects
Create an application to deploy multiple objects at the same time. When you create an application, you select the objects to include in the application. If you redeploy an application to a Data Integration Service you can update or replace the application.

Creating an Application
Create an application when you want to deploy multiple objects at the same time or if you want to be able to update or replace the application when it resides on the Data Integration Service.




What are the different environments used here.
Software development life cycles how the code gets developed and promoted to higher environments.
Version Control tool and process.
Release notes/Run books.
Code deployment process and different servers involved in it.
Any reusble code like preparing the parameter file and invoking a workflow/mapping/Application.


ApexSoft
ApexTech

Functions  : 
IIF( condition, value1 [,value2] )
condition (Required) : The condition you want to evaluate. You can enter any valid transformation expression that evaluates to TRUE or FALSE.
value1 (Required) : Any datatype except Binary. The value you want to return if the condition is TRUE. The return value is always the datatype specified by this argument. You can enter any valid transformation expression, including another IIFexpression.
value2 (Optional) : Any datatype except Binary. The value you want to return if the condition is FALSE. You can enter any valid transformation expression, including another IIF expression.

Return Value
value1 if the condition is TRUE.
value2 if the condition is FALSE.

Alternative to IIF
Use DECODE instead of IIF in many cases. DECODE may improve readability.

IN : IN( valueToSearch, value1, [value2, ..., valueN,] CaseFlag )
Return Value
TRUE (1) if the input value matches the list of values.
FALSE (0) if the input value does not match the list of values.
NULL if the input is a null value.
IN( ITEM_NAME, ‘Chisel Point Knife’, ‘Medium Titanium Knife’, ‘Safety Knife’, 0 )

ITEM_NAME RETURN VALUE
Stabilizing Vest 0 (FALSE)
Safety knife 1 (TRUE)
Medium Titanium knife 1 (TRUE)
NULL

ABORT: Stops the session, and issues a specified error message to the session log file. When the Integration Service encounters an ABORT function, it stops transforming data at that row. It processes any rows read before the session aborts and loads them based on the source- or target-based commit interval and the buffer block size defined for the session.


----

Target load plan > Tools | Mapping Designer | Mapping | Target Load Plan and specify the proper target loading order based on foreign key relationship.

Source Qualifier >
The Source Qualifier transformation provides the SQL Query option to override the default query. You can enter an SQL statement supported by the source database. Before entering the query, connect all the input and output ports you want to use in the mapping.
You can use a parameter or variable as the SQL query or include parameters and variables within the query. When including a string mapping parameter or variable, use a string identifier appropriate to the source system.
When creating a custom SQL query, the SELECT statement must list the port names in the order in which they appear in the transformation.
Every column name must be qualified by the name of the table, view, or synonym in which it appears. For example, if you want to include the ORDER_ID column from the ORDERS table, enter ORDERS.ORDER_ID.

You can enter an outer join as a join override or as part of an override of the default query. when possible, enter outer join syntax as a join override.
In a Source Qualifier transformation, click the button in the User Defined Join field.  Do not enter WHERE at the beginning of the join. The Integration Service adds this when querying rows. Enclose Informatica join syntax in braces ( { } ).
