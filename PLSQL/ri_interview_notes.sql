What have you done.
What are the challenges you have faced

worlds most-powerful IT services and recently awarded as superbrand value 

Oracle >

APEX >

Shell Scripting >

Tuning >

DBA > 

Informatica >

Doing the intial assesment of business requirements. 
Feasibility study and options evaluation.
Detailed design document and infrastructure architecture document.
Effort estimation and validation.
Requirement implementation.
Unit testing and code review. with the aim of delivering high standard code and right first time.
integration testing, automated testing.
Performance testing and non functional requirement testing.
Release note/Run book and deployment document
Deployment support and post deployment support and product maintenence.
Investigation and fix of production issues.

APEX, HTML, CSS, Java script, JQuery, REST and webservices
TOAD, JIRA, Source control Serena Dimensions, PVCS

JIRA Software is built for every member of your software team to plan, track, and release great software
JIRA is used for issue tracking and project management 

Oracle /9i/10G/11G, SQLPlus, PL/SQL
Oracle forms, Oracle Reports
In depth knowledge of Oracle Tuning (CBO)
Linux Shell Scripts
Rest Data services


Uniface is a model-driven, Rapid Application Development (RAD) environment used to create mission-critical applications
Uniface is a development and deployment platform for enterprise applications that can run in a large range of runtime

If you have Oracle enterprise license APEX doesn�t cost you anything extra in license cost. APEX can also be run on Oracle Database 11g Express Edition(XE). This is a free starter version of Oracle DB with the limitations of 11gb storage, 1gb RAM and 1 CPU. The APEX & XE combination is also free even if you don�t have the full Oracle Database 11g license.

The APEX engine is part of the Oracle database and communicates with the user(web browser) using an web server(Tomcat, Glassfish and Weblogic) and PL/SQL. APEX is mostly build on top of a database with other Oracle applications whose data is easily approachable. Communication with other applications can be done by using webservices.

As APEX is part of the Oracle Database it is as scalable as the Oracle Database. This is for example proven at Northgate Revenues and benefits where 10.000 end-users daily use an APEX application with around 1500 forms with sub second response times.

-----------

APEX Optimisation
Region Caching
Page caching

Since the APEX environment runs entirely within the database, many of the recommendations for writing code and good schema design that perform and scale well are the same as for any PL/SQL programs or SQL queries. A sound understanding of SQL and PL/SQL is a definite benefit when developing with APEX.

calculate cache time out depending on the situation, if you have lots of user and the underlaying data does not change that often, then cache it for longer time and give a  manual refresh button. 

When possible, you should use workspace exports. They enable you to rapidly create a copy of an existing workspace and reduce the chance that you�ll forget to create a particular user or developer.
report pagination style
Row Ranges X to Y of Z,�

Keep the workspace name, workspace id, application id, and parsing schema identical in all the environments.

----

Lifecycle Management

We have developed and continue to evolve procedures for requirements management, a proven file-system layout, automated DDL extraction, a completely script-based deployment approach, and integration with Subversion. All of these support the long-term maintainability of the software.

We will start by looking at the typical challenges faced by a team of developers working on an APEX development project.

when you modify an APEX application, you can at least set explicit locks on one or more pages you are working on. After you have acquired a lock on these pages, other developers cannot change them until you unlock them again.

Even if you don�t set explicit locks on the pages you modify, you will still be protected from overwriting other developer�s changes. APEX uses a mechanism called optimistic locking to prevent that. Both Developer A and Developer B will be able to begin changing a page. When Developer A saves the change, it will go through. When Developer B tries to save her changes as well, she will receive an error message that the database state has been modified in the meantime.

Once you are done implementing all features for the next release of your software, you need to install the updated software on the test or production environment. You have to make sure to propagate all the required changes. They can include
� DDL statements for the creation or modification of database objects (users, tablespaces, grants, tables, views, etc.)
� DML statements for the manipulation of data (insert, update, delete)
� The APEX applications
� Files uploaded to the workspace
� Files stored on the application server in the file system
� Changes in the configuration of the application server (virtual directories, compression, URL rewrites, etc.)

Version Numbering Scheme and the Overall Delivery Process

<Major Release>.<Minor Release>.<Patch>.<Revision>
� Major Release: This digit is increased when there are significant jumps in functionality, fundamentally changing application concepts� interfaces.
� Minor Release: Whenever you only have a functional change to the application, increase the minor release digit of the version number.
� Patch: The patch digit is increased whenever you ship only bug fixes (error corrections) or really minimal functional changes.
� Revision: This is the build counter for each build of the software. In our context this is a number indicating the internal revision with the test team.

Hotfixes :  While working on the next release of the application (e.g., 2.0.0), you might detect a problem in the current production release (e.g., 1.3.0.5). This problem has to be corrected, resulting in another patch release, 1.3.1.

To address this kind of requirement you need to have two instance of development environment, as you can not merge two version of APEX application export.
Version Control

Hot fixing is only mantained by ont team member and he ensures changes are checked-in in the repository. At the end of production deployment.

create restore point BEFORE_REL_2_3_0_1; -- create a restore point before deployment and flash back to this restore point if something goes wrong.

shutdown immediate;
startup mount;
flashback database to restore point BEFORE_REL_2_3_0_1;
alter database open resetlogs;

-------


Agile methodologies
test driven development
co

