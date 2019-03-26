In APEX 5.0 you will find the following information in those columns:
• MODULE : Parsing database user /APEX:APP Application ID:Page ID
• CLIENT_INFO : Workspace ID : authenticated username :
• CLIENT_IDENTIFIER : Authenticated username : session ID

For example, let’s look at the following query:
select sid, module, client_info, client_identifier, status
from v$session
where username = 'APEX_PUBLIC_USER'
and status = 'ACTIVE';

SID MODULE CLIENT_INFO CLIENT_IDENTIFIER
--- ------------------------------ ---------------------- --------------------
53 APEX_050000/APEX:APP 4500:1204 3201226568081376:ADMIN ADMIN:27135994032614

Here we can see that there is an active APEX session running in the database.
The MODULE indicates that the schema APEX_050000 using the application 4500 in page 1204 is being
accessed.
The CLIENT_INFO shows that the workspace ID for that specific application is 3201226568081376. By
querying the APEX_WORKSPACES view, it is possible to find out more information about this workspace.
The CLIENT_IDENTIFIER indicates that the APEX session id is 27135994032614.

An application ID is unique to an APEX instance, that is, for the entire APEX installation
in a database instance.

Reverse Proxy
In some cases we want to give access to APEX applications to clients outside of our internal network. we only want to open the access to a specific application ID and not the entire APEX
application install or all the applications in that environment.

Architecture
The concept of the reverse proxy is to put a web server in a demilitarized zone (DMZ) that will accept and
filter the requests from the internet. Then, the valid requests will go through a firewall and to the web listener
used for APEX. This configuration will avoid opening the web listener to the public. The web server in the DMZ first
filters the requests before sending them to the web listener.

-----------------------
OWN IT —  Things sometimes go off track.   Whether it was something on your team that went sideways or it was another team's responsibility, step up, own the problem and deliver a resolution.  
LEARN IT —  There are always new technologies, solutions, processes, and procedures.   Set aside time to learn and master what is new so that you are prepared when the time comes.   
TEACH IT — When you master something new, find someone else with whom you can share it.  
GROW IT — Your team is incredibly valuable. Take the time to invest in your teammates and equip them with new capabilities. 
OVERLOOK IT — People can make poor decisions. Fight the urge to gossip about them. Look for the best and ignore the rest. 

APEX populates the following information in GV$SESSION for ACTIVE sessions:

client_info: Workspace ID:Authenticated username
module: DB Schema/APEX:APP application id:page id
client_identifier: Authenticated username:APEX Session ID

For example, for a recent request I did on apex.oracle.com, I had the following values in the DB session that executed my request:

client_info: 3574091691765823934:JOEL.KALLMAN@FOOBAR.COM
module: JOEL_DB/APEX:APP 17251:4
client_identifier: JOEL.KALLMAN@FOOBAR.COM:12161645673208

Oracle application express administration for DBAs and developers

Today's trend is DevOps, sharing the knowledge between developers and DBAs. 

Target Audiance is mostly the team responsible for future maintenance.

Browser based development framework which supports rapid application development.

Initially it was a oracle internal project called Flow > later renamed as Marvel and then fianally called as APEX in 2006. It has been greatly improved ever since and it has always followed the latest industry trend. Mobile App, responsive design, HTML 5, single sign on, 


https://books.google.co.uk/books?id=ZjdPDQAAQBAJ&pg=PP1&lpg=PP1&dq=oracle+application+express+administration+for+DBAs+and+developers&source=bl&ots=YNfVv0OHWB&sig=xKPwXy8_eRouSHgrM2AwFVDtjsg&hl=en&sa=X&ved=0ahUKEwi21bH4jorQAhUhIsAKHT4IDVAQ6AEIRDAH#v=onepage&q=oracle%20application%20express%20administration%20for%20DBAs%20and%20developers&f=false

It improves the delivery time of fully functional application
It's secure and scalable and it uses strength of Oracle
It's aligned with current inductry trends
It's cloud enabled and ready for cloud

Oracle uses it for selling all it's oracle products shop.oracle.com
It's prefect tool for Oracle Form modrnasation
APEX an offcial and supported tool for extending Oracle EBS
It can be a great compliment for BI applications by using charting and interactive reporting

https://apex.oracle.com/pls/apex/f?p=411:1

https://shop.oracle.com/apex/f?p=dstore:home:0

Apex Requires three main schemas to work

APEX_PUBLIC_USER
FLOWS_FILES
APEX_050000

APEX_PUBLIC_USER : is used to create db sessions and execute all apex stuffs.
FLOW_FILES : This schema is the owner of table WWV_FLOW_FILE_OBJECTS$. This table is used when a file is uploaded to apex or to an application. The file is stored here first before moved to the appropriate table. There is a data base job (oracle_apex_purge_sessions )seheduled to delete to clean this table. An view APEX_APPLICATION_TEMP_FILES can be used to see the files that are stored in WWV_FLOW_FILE_OBJECTS$ contextually to a workspace.
APEX_050000 : This is the schema where APEX engine and mete data are stored.

APEX_PUBLIC_USER should be unlocked all time but the other two accounts are ment t be locked all time.

APEX Views : All information about APEX, workspace, applications, users are stored in mete data. It's possible to get a welth of information via APEX views. These information can be useful for many different purposes like impact analysis, performance tuning, quality control etc. Application builder > workspace utilities > application express views

SELECT DISTINCT APEX_VIEW_NAME FROM APEX_DICTIONARY

select * from apex_application_locked_pages -- pages locked by any username

-- Finding list of LOVs that does not have a order by clause
select * from apex_application_lovs where upper(lov_type)='DYNAMIC' and instr(upper(list_of_values_query),'ORDER BY')=0

-- Select all applications and show their workspace name, application id, authentication 

oms_dcstrlocii_process.sh

oms_dcstrlocii_process_bkp.sh

/apps/projects/oms/dev/remote_data/in/dcstrlocii

/apps/projects/oms/dev/scripts/oms_dcstrlocii_process.sh

/apps/projects/oms/dev/remote_data/archive/in/dcstrlocii

That that will be the straw that breaks the camel's back and makes your server thrash to a halt?

