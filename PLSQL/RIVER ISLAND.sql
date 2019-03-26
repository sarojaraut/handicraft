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

If you have Oracle enterprise license APEX doesn’t cost you anything extra in license cost. APEX can also be run on Oracle Database 11g Express Edition(XE). This is a free starter version of Oracle DB with the limitations of 11gb storage, 1gb RAM and 1 CPU. The APEX & XE combination is also free even if you don’t have the full Oracle Database 11g license.

The APEX engine is part of the Oracle database and communicates with the user(web browser) using an web server(Tomcat, Glassfish and Weblogic) and PL/SQL. APEX is mostly build on top of a database with other Oracle applications whose data is easily approachable. Communication with other applications can be done by using webservices.

As APEX is part of the Oracle Database it is as scalable as the Oracle Database. This is for example proven at Northgate Revenues and benefits where 10.000 end-users daily use an APEX application with around 1500 forms with sub second response times.

-----------

APEX Optimisation
Region Caching
Page caching

Since the APEX environment runs entirely within the database, many of the recommendations for writing code and good schema design that perform and scale well are the same as for any PL/SQL programs or SQL queries. A sound understanding of SQL and PL/SQL is a definite benefit when developing with APEX.

calculate cache time out depending on the situation, if you have lots of user and the underlaying data does not change that often, then cache it for longer time and give a  manual refresh button. 

When possible, you should use workspace exports. They enable you to rapidly create a copy of an existing workspace and reduce the chance that you’ll forget to create a particular user or developer.
report pagination style
Row Ranges X to Y of Z,”

Keep the workspace name, workspace id, application id, and parsing schema identical in all the environments.

----

Lifecycle Management

We have developed and continue to evolve procedures for requirements management, a proven file-system layout, automated DDL extraction, a completely script-based deployment approach, and integration with Subversion. All of these support the long-term maintainability of the software.

We will start by looking at the typical challenges faced by a team of developers working on an APEX development project.

when you modify an APEX application, you can at least set explicit locks on one or more pages you are working on. After you have acquired a lock on these pages, other developers cannot change them until you unlock them again.

Even if you don’t set explicit locks on the pages you modify, you will still be protected from overwriting other developer’s changes. APEX uses a mechanism called optimistic locking to prevent that. Both Developer A and Developer B will be able to begin changing a page. When Developer A saves the change, it will go through. When Developer B tries to save her changes as well, she will receive an error message that the database state has been modified in the meantime.

Once you are done implementing all features for the next release of your software, you need to install the updated software on the test or production environment. You have to make sure to propagate all the required changes. They can include
• DDL statements for the creation or modification of database objects (users, tablespaces, grants, tables, views, etc.)
• DML statements for the manipulation of data (insert, update, delete)
• The APEX applications
• Files uploaded to the workspace
• Files stored on the application server in the file system
• Changes in the configuration of the application server (virtual directories, compression, URL rewrites, etc.)

Version Numbering Scheme and the Overall Delivery Process

<Major Release>.<Minor Release>.<Patch>.<Revision>
• Major Release: This digit is increased when there are significant jumps in functionality, fundamentally changing application concepts’ interfaces.
• Minor Release: Whenever you only have a functional change to the application, increase the minor release digit of the version number.
• Patch: The patch digit is increased whenever you ship only bug fixes (error corrections) or really minimal functional changes.
• Revision: This is the build counter for each build of the software. In our context this is a number indicating the internal revision with the test team.

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



Agile Manifesto

1. Individuals and interactions - over processes and tools : self-organization and motivation are important, as are interactions like co-location and pair programming
2. Working software - over comprehensive documentation ; working software is more useful and welcome than just presenting documents to clients in meetings.
3. Customer collaboration - over contract negotiation : requirements cannot be fully collected at the beginning of the software development cycle, therefore continuous customer or stakeholder involvement is very important.
4. Responding to change - over following a plan : agile methods are focused on quick responses to change and continuous development. 

The Twelve Principles of Agile Software

1. Customer satisfaction by early and continuous delivery of valuable software : highest priority is to satisfy the customer through early and continuous delivery
of valuable software.
2. Welcome changing requirements, even in late development : 
3. Working software is delivered frequently with a preference to the shorter timescale.(weeks rather than months) 
4. Close, daily cooperation between business people and developers
5. Build projects around motivated individuals. Give them the environment and support they need, and trust them to get the job done.
6. Face-to-face conversation is the best form of communication (co-location)
7. Working software is the principal measure of progress
8. Sustainable development, able to maintain a constant pace
9. Continuous attention to technical excellence and good design enhances agility.
10. Simplicity—the art of maximizing the amount of work not done—is essential
11. Best architectures, requirements, and designs emerge from self-organizing teams
12. Regularly, the team reflects on how to become more effective, and adjusts accordingly

Scrum
Scrum is an iterative, incremental framework for project management. The word scrum refers to the daily stand-up meeting where the day’s immediate work is planned. The team members briefly summarize what was accomplished on the previous day and what will be accomplished on the coming day, and raise a flag if they are experiencing a problem. Problem resolution is done after the meeting. This meeting style keeps all members accountable for their work and gets individual problems resolved quickly.

Work is done in time-boxed sprints that last approximately two to four weeks.

Delivery of high-quality working software to users on a fast and regular basis is a key goal of Agile software development. Oracle Application Express is a highly efficient rapid application development (RAD) environment. 

Agile Manifesto - APEX
1. Individuals and interactions - over processes and tools : self-organization and motivation are important, as are interactions like co-location and pair programming

APEX wizards are one of the chief tools that support an individual developer. There are wizards that help you create most of the artifacts in APEX.
APEX’s Team Development module supports team collaboration. Team Development provides a
light but rich framework that allows a skilled, motivated, and trusted team to self-organize. The feedback
mechanism, features, to-dos, bugs, and milestones are used in concert by the team to efficiently and
effectively communicate among themselves and outside stakeholders.

2. Working software - over comprehensive documentation ; working software is more useful and welcome than just presenting documents to clients in meetings.

Software developers produce working software; that is our primary job. Everything else merely supports the primary purpose and must be looked at as overhead. The overhead is always necessary, but it must be ruthlessly minimized and must never, ever become an end in itself.

APEX’s declarative environment is the tool’s main mechanism for producing working software. Most of the underlying tough coding is taken care of by the APEX engine. The APEX engine does an excellent job of making these database actions safe, quick, and reliable.

3. Customer collaboration - over contract negotiation

APEX delivers working software to the customer quickly. This enables the customer to start working
with the product to test, debug, and evaluate the requirements.
The feedback mechanism that is built into the APEX Team Development module is an ideal
collaboration tool. It enables the customer to provide immediate and useful comments to the
development team from within the context of the application.

4. Responding to change - over following a plan : agile methods are focused on quick responses to change and continuous development. 

Change is a fact of life, and software development is no exception. Agile software development deals with change by expecting it and planning for it. It does this by putting working software into the customer’s hands as quickly as possible so that the team can iterate, multiple times if required, through these stages:
1. Design
2. Build
3. Evaluate

How does APEX support responding to change and building a plan? First, APEX is an efficient rapid application development (RAD) environment. A RAD environment enables you to quickly build the initial version of the application. This environment also enables you to quickly delete a page and then re-create it.

12 Principles

Continuous Attention to Technical Excellence APEX is a tool. It can be used well, or it can be abused. Learning to use APEX well involves two fundamental steps that are true for any tool:

“Simplicity” is one of the key principles of Agile software development. Using the core APEX framework exclusively is an elegant way of applying the Agile principle of “simplicity” to your development environment.

Web pages are the fundamental building blocks of an APEX application. They are containers that hold regions, buttons, items, business logic, and navigation links.
Pages - Blank page, report (interactive and classic), Form (on a table, on a procedure, Master detail form, tabular form, form on a web service, form on a table with report, form on a sql query), chart page, map page, calender, wizard page, data loading page, tree page, feedback page, login page, access control page
Regions - HTML, report  region, form region plug-ins, chart, map, tree, calender, breadcrumb, plsql dynamic content, help text, region display selector.
Button - 1. Button in a region position 2. Button in displayed among region items(button position = region body).
Items : check box, text field, display only, radio button, text area, date picker, selectlist, file browse, display image, pop up LOV, shuttle, text field with auto complete.
computation : Computations are used to assign value to pages items (on the current page or another page or application level item). Computations are fired when a page is either rendered or submitted.
Processes : Processes are used to run business code on a page. PLSQL, web services, reset pagination, session state, data manipulation (automatic row fetch, automatic row processing), close pop-up window.
Dynamic Actions :
Validations : Validations pevent bad data to be entered into the system and returns a meaning full message to fix the corrupt data. Item level validation and page level validation. 
Page item validation > not null, string comparison, regular expression, sql and plsql. 
Page validation > sql, plsql, function returning boolean, function returning error text. 
Branches > control navigation to different pages.
Application > websheet, database, 

Business Cases for Enhanced APEX
Organizations often brand themselves. The appearance of their web pages is extremely important to them. APEX utilizes a theme/template model that uses Hyper Text Markup Language (HTML) and Cascading Style Sheets (CSS). HTML is used to define the content of an APEX web page, while CSS controls how it looks. Enhancing an existing theme or developing your own requires knowledge of HTML and CSS, together with a good understanding of how APEX builds its themes and templates.

Reporting
Core APEX does not have a built-in high-fidelity reporting engine. In this case, APEX developers are forced to look for solutions that are external to APEX.

APEX can be used as a mockup tool. The attractive advantage of this strategy is the fact that the resulting mockup is very close to a working prototype that can quickly evolve into the first version of the application;

Authentication
Authentication controls who is allowed to log on to an APEX application. APEX supports a number of authentication schemes: APEX accounts, database accounts, custom, LDAP, HTTP header variables, No authentication, open door credentials
Authorization
Authorization controls a user’s access to various parts of an application after the user logs on to your application. Authorization involves assigning roles to user groups and then writing a suite of PL/SQL boolean functions that are called from the APEX object you want to control. 
Session-State Protection : Session-state protection is important for defending your APEX application from unauthorized hackers.
Three common security vectors are
• URL tampering
• Cross-site scripting
• SQL injection
Session-state protection adds a checksum to the URL that prevents hackers from manually changing a page number in a URL from an authorized page to an unauthorized page.

Cross-site scripting is done by injecting JavaScript into a web page. This can be done by entering malicious code into a comment item and saving it to the database. When the rogue comment data is returned from the database to the browser, the browser happily executes the JavaScript. The wizards in APEX 4.x now do a lot to protect programmers from this danger by automatically selecting items that “escape” data that is sent to the browser. For example, setting a report column to “Display as Text
(escape special characters, does not save state)” explicitly stops JavaScript code in the column from being executed by the browser.

SQL injection is similar to cross-site scripting. Instead of malicious JavaScript being injected into a web page, malicious SQL is sent to the database and then returns unauthorized data to the browser. In most areas of APEX, this is not a problem because the standard way of building SQL statements in APEX uses bind variables.

Agile documentation can take many forms, the key factors being that it must add value and it must not cost more to produce than that value. Do as little as possible, as efficiently as possible, as late as possible.

It is essential to record information that is not otherwise known that is critical to the end goal of working software. If how to use a particular page of your APEX application is not intuitively obvious, communication of how to use that interface must be provided. This communication may be made in one or more of several forms: as an online help page, online tooltips on page items, an online how-to video, an online step-by-step how-to document.

Short, concise, active sentences are easy to read, easy to understand, and easy to write. Yes, even developers can learn to write short, clear, direct, complete sentences to communicate. Pseudo-code is for code; complete sentences are for documentation. Keep the purpose and the audience of the document in mind, and provide no more and no less information than necessary. In writing documentation, you are not creating a novel; you are communicating facts about your software. Write just enough, and then stop.

Quality Assurance : Delivery of high-quality working software on a fast and regular basis is the goal of Agile software development. 

