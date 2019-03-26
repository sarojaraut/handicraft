MAPPING PARAMETERS
•A mapping parameter represents a constant value that we can define before running a session. 
•A mapping parameter retains the same value throughout the entire session.

•After we create a parameter, it appears in the Expression Editor. 
•We can then use the parameter in any expression in the mapplet or mapping. 
•We can also use parameters in a source qualifier filter, user-defined join, or extract override, and in the Expression Editor of reusable transformations.

MAPPING VARIABLES
•Unlike mapping parameters, mapping variables are values that can change between sessions. 
•The Integration Service saves the latest value of a mapping variable to the repository at the end of each successful session. 
•We can override a saved value with the parameter file. 
•We can also clear all saved values for the session in the Workflow Manager. 

Mapping Parameters
A mapping parameter represents a constant value that you can define before running a session: such as connections, source file directories, or cache file directories. A mapping parameter retains the same value throughout the entire session. you declare and use the parameter in a mapping or mapplet. Then define the value of the parameter in a parameter file. 

You can use system or user-defined parameters when you run a mapping. System parameters define the directories where the Data Integration Service stores cache files, reject files, source files, target files, and temporary files. You define the values of the system parameters on a Data Integration Service process in the Administrator tool. You cannot define or override system parameter values in a parameter file.

The following table describes the system parameters:
System Parameter : Type : Description
CacheDir  : String : Default directory for index and data cache files.
RejectDir : String : Default directory for reject files.
SourceDir : String : Default directory for source files.
TargetDir : String : Default directory for target files.
TempDir   : String : Default directory for temporary files.

You can create the following types of user-defined parameters:
¨ Connection. Represents a database connection. 
¨ Long. Represents a long or integer value.
¨ String. Represents a flat file name, flat file directory, cache file directory, temporary file directory, or type of mapping run-time environment.

You define the user-defined parameter values in a parameter file. When you run the mapping from the command line and specify a parameter file, the Data Integration Service uses the parameter values defined in the parameter file.

You can create user-defined workflow parameters when you develop a workflow. A workflow parameter is a constant value that can change between workflow runs.
Creating a User-Defined Parameter
Open the physical data object, mapping, mapplet, or reusable transformation where you want to create a userdefined parameter. > Click the Parameters view. > click add

Where to Assign Parameters

The following table lists the objects and fields where you can assign system or user-defined parameters:

Object : Field
Aggregator : transformation Cache directory
Customized : data object Connection
Flat file data object : Source file name
                      : Output file name
                      : Source file directory
                      : Output file directory
                      : Connection name
                      : Reject file directory
Joiner transformation : Cache directory
Lookup transformation :(flat file lookups) Lookup cache directory name
Lookup transformation : (relational lookups) Connection
                      : Lookup cache directory name
To Assign a parameter         
Open the field in which you want to assign a parameter. > Click Assign Parameter. > Select the system or user-defined parameter.
                      
Mapping : Run-time environment
Nonrelational data object : Connection
Rank transformation : Cache directory
Read transformation created from related relational data objects : Connection
Sorter transformation : Work directory

Mapping Variables
Unlike a mapping parameter, a mapping variable represents a value that can change through the session. When you use a mapping variable, you declare the variable in the mapping or mapplet, and then use a variable function in the mapping to change the value of the variable.

At the beginning of a session, the Integration Service evaluates references to a variable to determine the start value. At the end of a successful session, the Integration Service saves the final value of the variable to the repository.

The next time you run the session, the Integration Service evaluates references to the variable to the saved value. To override the saved value, define the start value of the variable in a parameter file or assign a value in the pre-session variable assignment in the session properties.

You can create mapping parameters and variables in the Mapping Designer or Mapplet Designer. Once created, mapping parameters and variables appear on the Variables tab of the Expression Editor.

You cannot use mapping parameters and variables interchangeably between a mapplet and a mapping. Mapping parameters and variables declared for a mapping cannot be used within a mapplet. Similarly, you cannot use a mapping parameter or variable declared for a mapplet in a mapping.

When you declare a mapping parameter or variable in a mapping or a mapplet, you can enter an initial value. The Integration Service uses the configured initial value for a mapping parameter/variable when the parameter/variable is not defined in the parameter file. When the Integration Service needs an initial value, and you did not declare an initial value for the parameter or variable, the Integration Service uses a default value based on the datatype of the parameter or variable.

When you enter mapping parameters and variables of a string datatype in a Source Qualifier transformation, use a string identifier appropriate for the source database.
STATE = '$$State'
You can perform a similar filter in the Filter transformation using the PowerCenter transformation language as follows:
STATE = $$State

In the Designer, you can create a mapping parameter in a mapplet or mapping. After you create a parameter, it appears in the Expression Editor.
Before you run a session, define the mapping parameter value in a parameter file for the session.

Step 1.Create a Mapping Parameter
In the Mapping Designer, click Mappings > Parameters and Variables. The syntax for the parameter name must be $$ followed by any alphanumeric or underscore characters. Select Type as Parameter.
Step 2. Use a Mapping Parameter
After you create a parameter, use it in the Expression Editor of any transformation in a mapping or mapplet.
Step 3. Define a Parameter Value
The Integration Service looks for the value in the following order:
1. Value in parameter file
2. Value in pre-session variable assignment
3. Initial value saved in the repository
4. Datatype default value

Mapping Variables
In the Designer, you can create mapping variables in a mapping or mapplet. Unlike mapping parameters, mapping variables are values that can change between sessions. The Integration Service saves the latest value of a mapping variable to the repository at the end of each successful session.

The Integration Service holds two different values for a mapping variable during a session run:
¨ Start value of a mapping variable
¨ Current value of a mapping variable

Start Value
The start value is the value of the variable at the start of the session.
The Integration Service looks for the start value in the following order:
1. Value in parameter file
2. Value in pre-session variable assignment
3. Value saved in the repository
4. Initial value
5. Datatype default value

When you use a mapping variable ('$$MAPVAR') in an expression, the expression always returns the start value of the mapping variable. If the start value of MAPVAR is 0, then $$MAPVAR returns 0.

Current Value
The current value is the value of the variable as the session progresses. When a session starts, the current value of a variable is the same as the start value. As the session progresses, the Integration Service calculates the current value using a variable function that you set for the variable. 

When you declare a mapping variable in a mapping, you need to configure the datatype and aggregation type for the variable. 

You can create a variable with the following aggregation types:
¨ Count
¨ Max
¨ Min

You can configure a mapping variable for a Count aggregation type when it is an Integer or Small Integer. You can configure mapping variables of any datatype for Max or Min aggregation types.

To keep the variable value consistent throughout the session run, the Designer limits the variable functions you use with a variable based on aggregation type. For example, use the SetMaxVariable function for a variable with a Max aggregation type, but not with a variable with a Min aggregation type.

The following table describes the available variable functions and the aggregation types and datatypes you use with each function:
Variable Function  :Valid Aggregation Types : Valid Datatype
SetVariable : Max or Min : All transformation datatypes except binary datatype.
SetMaxVariable : Max only : All transformation datatypes except binary datatype.
SetMinVariable : Min only : All transformation datatypes except binary datatype.
SetCountVariable : Count only : Integer and small integer datatypes only.


¨ SetMaxVariable. Sets the variable to the maximum value of a group of values. It ignores rows marked for update, delete, or reject. To use the SetMaxVariable with a mapping variable, the aggregation type of the mapping variable must be set to Max.
¨ SetMinVariable. Sets the variable to the minimum value of a group of values. It ignores rows marked for update, delete, or reject. To use the SetMinVariable with a mapping variable, the aggregation type of the mapping variable must be set to Min.
¨ SetCountVariable. Increments the variable value by one. In other words, it adds one to the variable value when a row is marked for insertion, and subtracts one when the row is marked for deletion. It ignores rows marked for update or reject. To use the SetCountVariable with a mapping variable, the aggregation type of the mapping variable must be set to Count.
¨ SetVariable. Sets the variable to the configured value. At the end of a session, it compares the final current value of the variable to the start value of the variable. Based on the aggregate type of the variable, it saves a final value to the repository. To use the SetVariable function with a mapping variable, the aggregation type of the mapping variable must be set to Max or Min. The SetVariable function ignores rows marked for delete or reject.

Mapping Variables in Mapplets
When you declare a mapping variable for a mapplet and use the mapplet multiple times within the same mapping, the same mapping variable value is shared across all mapplet instances.

Defining Expression Strings in Parameter Files

The Integration Service expands mapping parameters and variables when you run a session. If you use a mapping parameter or variable in an expression, the Integration Service expands the parameter or variable after it parses the expression. You might want the Integration Service to expand a parameter or variable before it parses the
expression when you create expressions to represent business rules that change frequently. 

For example, you create an expression that generates a color name based on an ID string as follows: IIF(color=‘A0587’,‘white’)
The next month, you modify the expression as follows: IIF(color=‘A0587’,‘white’,IIF(color=‘A0588’,‘off white’))

To define an expression in a parameter file, set up the mapping and workflow as follows:
1. Create a mapping parameter or variable to store the color name expression. For example, create a mapping parameter, $$ExpColor.
2. For mapping parameter $$ExpColor, set the IsExprVar property to true. You must also set the datatype for the parameter to String or the Integration Service fails the session.
3. In the Expression transformation, set the output port to the following expression: $$ExpColor
4. Configure the session or workflow to use a parameter file.
5. In the parameter file, set $$ExpColor to the correct expression. For example: $$ExpColor=IIF(color=‘A0587’,‘white’)

Because IsExprVar for mapping parameter $$ExpColor is set to true, the Integration Service expands the parameter before it parses the expression.

Tips for Mapping Parameters and Variables
When you know a logical default value for a mapping parameter or variable, use it as the initial value when you create the parameter or variable.
Enclose string and datetime parameters and variables in quotes in the SQL Editor.
Mapping parameter and variable values in mapplets must be preceded by the mapplet name in the parameter file, as follows:
mappletname.parameter=value

Parameter Files
You cannot define system parameter values in a parameter file.
You can define parameters for multiple mappings in a single parameter file.
Use the infacmd ms ListMappingParams command to list the parameters used in a mapping with the default values. You can use the output of this command as a parameter file template.
Use the infacmd ms RunMapping command to run a mapping with a parameter file.

----- Informatica PowerCenter Express Userguide

Built-in Variables
The transformation language provides built-in variables. Built-in variables return either run-time or system information. 
Run-time variables return information such as source and target table name, folder name, session run mode, and workflow run instance name. 
System variables return session start time, system date, and workflow start time.

The following built-in variables provide run-time information:
$PM<SourceName>@TableName, $PM<TargetName>@TableName : For a source instance named “Customers,” the built-in variable name is $PMCustomers@TableName. If the relational source or target is part of a mapplet within a mapping, the built-in variable name includes the mapplet name: $PM<MappletName>.<SourceName>@TableName

$PMFolderName : returns the name of the repository folder as a string value.

$PMIntegrationServiceName : returns the name of the Integration Service that runs the session.

$PMMappingName : returns the mapping name as a string value.

$PMRepositoryServiceName : returns the name of the Repository Service as a string value.

$PMRepositoryUserName : returns the name of the repository user that runs the session.

$PMSessionName : returns the session name as a string value.

$PMSessionRunMode : returns the session run mode, normal or recovery, as a string value.

$PMWorkflowName : returns the name of the workflow as a string value.

$PMWorkflowRunId : returns the workflow run ID as a string value.

$PMWorkflowRunInstanceName : returns the workflow run instance name as a string value. For example, for a concurrent workflow with unique instance names, you can create unique target files for each run instance by setting the target output file name in the session properties to “OutFile_$PMWorkflowRunInstanceName.txt.”

$$$SessStartTime : returns the initial system date value on the machine hosting the Integration Service when the server initializes a session. $$$SessStartTime returns the session start time as a string value. The format of the string depends on the database you are using. (for Oracle MM/DD/YYYY HH24:MI:SS)

SESSSTARTTIME : SESSSTARTTIME returns the current date and time value on the machine that runs the session when the Integration Service initializes the session.

SYSDATE : SYSDATE returns the current date and time up to seconds on the machine that runs the session for each row passing through the transformation.

WORKFLOWSTARTTIME : WORKFLOWSTARTTIME returns the current date and time on the machine hosting the Integration Service when the Integration Service initializes the workflow.

Transaction Control Variables

Transaction control variables define conditions to commit or rollback transactions during the processing of database rows. You use these variables in transaction control expressions that you build in the Expression Editor. Transaction control expressions use the IIF function to test each row against a condition. Depending on the return value of the condition, the Integration Service commits, rolls back, or makes no transaction changes for the row.

The following example uses transaction control variables to determine where to process a row: IIF (NEWTRAN=1, TC_COMMIT_BEFORE, TC_CONTINUE_TRANSACTION)

If NEWTRAN=1, the TC_COMMIT_BEFORE variable causes a commit to occur before the current row processes. Otherwise, the TC_CONTINUE_TRANSACTION variable forces the row to process in the current transaction.

Use the following variables in the Expression Editor when you create a transaction control expression:
TC_CONTINUE_TRANSACTION : The Integration Service does not perform any transaction change for the current row. This is the default transaction control variable value.

TC_COMMIT_BEFORE : The Integration Service commits the transaction, begins a new transaction, and writes the current row to the target. The current row is in the new transaction.

TC_COMMIT_AFTER : The Integration Service writes the current row to the target, commits the transaction, and begins a new transaction. The current row is in the committed transaction.

TC_ROLLBACK_BEFORE : The Integration Service rolls back the current transaction, begins a new transaction, and writes the current row to the target. The current row is in the new transaction.



