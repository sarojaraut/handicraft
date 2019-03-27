AQ_ADMINISTRATOR_ROLE - Allows creation and administration of queuing infrastructure.
AQ_USER_ROLE - Allows access to queues for enqueue and dequeue operations.

GRANT CREATE TYPE TO HR;
GRANT AQ_ADMINISTRATOR_ROLE TO HR;
ALTER USER HR QUOTA UNLIMITED ON USERS;

Define Payload

The content, or payload, of a message is defined using an object type which must be defined before a queue is created.

sqlplus hr/hr@xe

CREATE OR REPLACE TYPE event_msg_type AS OBJECT (
  name            VARCHAR2(10),
  current_status  NUMBER(5),
  next_status     NUMBER(5)
);
/

Create Queue Table And Queue

Once the payload type is created the queuing infrastructure can be created. Queues are implemented using a queue table which can hold multiple queues with the same payload type. First the queue table must be defined using the payload type, then the queue can be defined and started. These operations are all performed using the DBMS_AQADM package.

BEGIN
    DBMS_AQADM.create_queue_table (
       queue_table            =>  'hr.event_queue_tab',
       queue_payload_type     =>  'hr.event_msg_type');
END;   

BEGIN
    DBMS_AQADM.create_queue (
       queue_name            =>  'hr.event_queue',
       queue_table           =>  'hr.event_queue_tab');
END;

BEGIN
    DBMS_AQADM.start_queue (
       queue_name         => 'hr.event_queue',
       enqueue            => TRUE);
END;

Grant Privilege On Queue

The DBMS_AQADM package is also used to grant privileges on queues so that other users can access them.

CREATE USER aq_user IDENTIFIED BY aq_user DEFAULT TABLESPACE users;

GRANT connect TO aq_user;

GRANT aq_user_role TO aq_user;

GRANT EXECUTE ON event_msg_type TO aq_user;

BEGIN
 DBMS_AQADM.grant_queue_privilege (
   privilege     =>     'ALL',
   queue_name    =>     'hr.event_queue',
   grantee       =>     'aq_user',
   grant_option  =>      FALSE);
END;

At this point the queue can be used for enqueue and dequeue operations by the AQ_USER user.

Enqueue Message

Messages can be written to the queue using the DBMS_AQ.ENQUEUE procedure.

CONNECT aq_user/aq_user

DECLARE
  l_enqueue_options     DBMS_AQ.enqueue_options_t;
  l_message_properties  DBMS_AQ.message_properties_t;
  l_message_handle      RAW(16);
  l_event_msg           hr.event_msg_type;
BEGIN
  l_event_msg := hr.event_msg_type('REPORTER', 1, 2);

  DBMS_AQ.enqueue(queue_name          => 'hr.event_queue',        
                  enqueue_options     => l_enqueue_options,     
                  message_properties  => l_message_properties,   
                  payload             => l_event_msg,             
                  msgid               => l_message_handle);

  COMMIT;
END;
/

Dequeue Message

Messages can be read from the queue using the DBMS_AQ.DEQUEUE procedure

SET SERVEROUTPUT ON

DECLARE
  l_dequeue_options     DBMS_AQ.dequeue_options_t;
  l_message_properties  DBMS_AQ.message_properties_t;
  l_message_handle      RAW(16);
  l_event_msg           hr.event_msg_type;
BEGIN
  DBMS_AQ.dequeue(queue_name          => 'hr.event_queue',
                  dequeue_options     => l_dequeue_options,
                  message_properties  => l_message_properties,
                  payload             => l_event_msg,
                  msgid               => l_message_handle);

  DBMS_OUTPUT.put_line ('Event Name          : ' || l_event_msg.name);
  DBMS_OUTPUT.put_line ('Event Current Status: ' || l_event_msg.current_status);
  DBMS_OUTPUT.put_line ('Event Next Status   : ' || l_event_msg.next_status);
  COMMIT;
END;
/

- what is the throughput of messages in the queue - X messages per hour; 
- are any of the TM features : delay, retry delay , expiration or retention being used; 
- how many messages are currently in the queue (refer to queue table) :

select count(*), msg_state from aq$event_queue_tab group by msg_state;
select count(*) from aq$_event_queue_tab_i;
select count(*) from aq$_<queue_table>_l; (new in 11.2.0.1)
select count(*) from aq$_<queue_table>_h;
select count(*) from aq$_<queue_table>_t;
select count(*) from aq$_<queue_table>_p; (optional / spill / Streams related)
select count(*) from aq$_<queue_table>_d; (optional / spill / Streams related)



------------------
http://docstore.mik.ua/orelly/oracle/bipack/ch05_04.htm

From a PL/SQL standpoint, Oracle AQ is made available through two packages: DBMS_AQADM and DBMS_AQ. The DBMS_AQADM package is the interface to the administrative tasks of Oracle AQ. These tasks include:

Creating or dropping queue tables that contain one or more queues
Creating, dropping, and altering queues, which are stored in a queue table
Starting and stopping queues in accepting message creation or consumption

Most users of the Oracle AQ facility will not work with DBMS_AQADM. The DBA will most likely initialize all needed queue tables and queues. PL/SQL developers will instead work with the DBMS_AQ, whose tasks include:

Creating a message to the specified queue
Consuming a message from the specified queue

Enable or disable a queue for multiple consumers
DBMS_AQADM.SINGLE
DBMS_AQADM.MULTIPLE

Operational tasks
Specify dequeuing mode
DBMS_AQ.BROWSE
DBMS_AQ.LOCKED
DBMS_AQ.REMOVE

Specify state of the message
DBMS_AQ.WAITING
DBMS_AQ.READY
DBMS_AQ.PROCESSED
DBMS_AQ.EXPIRED

Specify amount of time to wait for a dequeue operation to succeed
DBMS_AQ.FOREVER
DBMS_AQ.NO_WAIT

You will specify the name of an Oracle AQ object (queue, queue table, or object type) in many different program calls. An AQ object name can be up to 24 characters long, and can be qualified by an optional schema name

The DBMS_AQADM package is also used to grant privileges on queues so that other users can access them.

In the following example, I modify the properties of the queue created under CREATE_QUEUE. I now want it to allow for up to 20 retries at hourly delays and to keep 30 days worth of history before deleting processed messages.

BEGIN
  DBMS_AQADM.ALTER_QUEUE(
      queue_name => 'never_give_up_queue',
      max_retries => 20,
      retention_time => 30 * 24 * 60 * 60);
END;

I can verify the impact of this call by querying the USER_QUEUES data dictionary view.

SELECT name, max_retries, retention FROM USER_QUEUES;
/

select
   c.owner,
   c.object_name,
   c.object_type,
   b.sid,
   b.serial#,
   b.status,
   b.osuser,
   b.machine
from
   v$locked_object a ,
   v$session b,
   dba_objects c
where
   b.sid = a.session_id
and
   a.object_id = c.object_id;
   

--------------
http://www.nocoug.org/download/2012-08/Jeff_Jacobs_Advanced_Queueing.pdf
https://docs.oracle.com/database/121/ARPLS/d_aqadm.htm#ARPLS65313
https://docs.oracle.com/database/121/ARPLS/d_aq.htm#ARPLS65275
https://docs.oracle.com/cd/A97630_01/appdev.920/a96587/apexampl.htm#62620

DBMS_AQADM.CREATE_QUEUE_TABLE (
   queue_table          IN      VARCHAR2,
   queue_payload_type   IN      VARCHAR2,
   storage_clause       IN      VARCHAR2        DEFAULT NULL,
   sort_list            IN      VARCHAR2        DEFAULT NULL,
   multiple_consumers   IN      BOOLEAN         DEFAULT FALSE,
   message_grouping     IN      BINARY_INTEGER  DEFAULT NONE,
   comment              IN      VARCHAR2        DEFAULT NULL,
   auto_commit          IN      BOOLEAN         DEFAULT TRUE,
   primary_instance     IN      BINARY_INTEGER  DEFAULT 0, 
   secondary_instance   IN      BINARY_INTEGER  DEFAULT 0,
   compatible           IN      VARCHAR2        DEFAULT NULL,
   secure               IN      BOOLEAN         DEFAULT FALSE);

queue_table : Name of a queue table to be created
queue_payload_type : Type of the user data stored. 
storage_clause :  The storage_clause argument can take any text that can be used in a standard CREATE TABLE storage_clause argument. If a tablespace is not specified here, then the queue table and all its related objects are created in the default user tablespace.
sort_list : The columns to be used as the sort key in ascending order. This parameter has the following format: 'sort_column_1,sort_column_2'. The allowed column names are priority, enq_time, and commit_time.If both columns are specified, then sort_column_1 defines the most significant order. If no sort list is specified, then all the queues in this queue table are sorted by the enqueue time in ascending order. This order is equivalent to FIFO order. Even with the default ordering defined, a dequeuer is allowed to choose a message to dequeue by specifying its msgid or correlation. msgid, correlation, and sequence_deviation take precedence over the default dequeueing order, if they are specified.
multiple_consumers : FALSE means queues created in the table can only have one consumer for each message. This is the default. 
message_grouping : Message grouping behavior for queues created in the table. NONE means each message is treated individually. TRANSACTIONAL means messages enqueued as part of one transaction are considered part of the same group and can be dequeued as a group of related messages.
comment : User-specified description of the queue table. 
secure : This parameter must be set to TRUE if you want to use the queue table for secure queues. Secure queues are queues for which AQ agents must be associated explicitly with one or more database users who can perform queue operations, such as enqueue and dequeue. The owner of a secure queue can perform all queue operations on the queue, but other users cannot perform queue operations on a secure queue, unless they are configured as secure queue users.

DBMS_AQADM.CREATE_QUEUE (
   queue_name          IN       VARCHAR2,
   queue_table         IN       VARCHAR2,
   queue_type          IN       BINARY_INTEGER DEFAULT NORMAL_QUEUE,
   max_retries         IN       NUMBER         DEFAULT NULL,
   retry_delay         IN       NUMBER         DEFAULT 0,
   retention_time      IN       NUMBER         DEFAULT 0,
   dependency_tracking IN       BOOLEAN        DEFAULT FALSE,
   comment             IN       VARCHAR2       DEFAULT NULL,
   auto_commit         IN       BOOLEAN        DEFAULT TRUE);

queue_name : Name of the queue that is to be created. The name must be unique within a schema
queue_table : Name of the queue table that will contain the queue.
queue_type : NORMAL_QUEUE means the queue is a normal queue. This is the default. EXCEPTION_QUEUE means it is an exception queue. Only the dequeue operation is allowed on the exception queue.
max_retries : Limits the number of times a dequeue with the REMOVE mode can be attempted on a message. A message is moved to an exception queue if RETRY_COUNT is greater than MAX_RETRIES. RETRY_COUNT is incremented when the application issues a rollback after executing the dequeue. If a dequeue transaction fails because the server process dies (including ALTER SYSTEM KILL SESSION) or SHUTDOWN ABORT on the instance, then RETRY_COUNT is not incremented.
retry_delay : Delay time, in seconds, before this message is scheduled for processing again after an application rollback. The default is 0, which means the message can be retried as soon as possible.
retention_time : Number of seconds for which a message is retained in the queue table after being dequeued from the queue. 
dependency_tracking : Reserved for future use. FALSE is the default.
comment : User-specified description of the queue.

DBMS_AQADM.ADD_SUBSCRIBER (
   queue_name      IN    VARCHAR2,
   subscriber      IN    sys.aq$_agent,
   rule            IN    VARCHAR2 DEFAULT NULL,
   transformation  IN    VARCHAR2 DEFAULT NULL
   queue_to_queue  IN    BOOLEAN DEFAULT FALSE,
   delivery_mode   IN    PLS_INTEGER DEFAULT DBMS_AQADM.PERSISTENT);

queue_name : Name of the queue.
subscriber : Agent on whose behalf the subscription is being defined.
rule : A conditional expression based on the message properties, 
transformation : Specifies a transformation that will be applied when this subscriber dequeues the message. 
queue_to_queue : If TRUE, propagation is from queue-to-queue.
delivery_mode : The administrator may specify one of DBMS_AQADM.PERSISTENT, DBMS_AQADM.BUFFERED, or DBMS_AQADM.PERSISTENT_OR_BUFFERED for the delivery mode of the messages the subscriber is interested in. 

DBMS_AQ.ENQUEUE (
   queue_name          IN      VARCHAR2,
   enqueue_options     IN      enqueue_options_t,
   message_properties  IN      message_properties_t,
   payload             IN       "<ADT_1>",
   msgid               OUT     RAW);
queue_name : Specifies the name of the queue to which this message should be enqueued. 
enqueue_options : 
  TYPE ENQUEUE_OPTIONS_T IS RECORD (
    visibility            BINARY_INTEGER  DEFAULT ON_COMMIT,
    relative_msgid        RAW(16)         DEFAULT NULL,
    sequence_deviation    BINARY_INTEGER  DEFAULT NULL,
    transformation        VARCHAR2(61)    DEFAULT NULL,
    delivery_mode         PLS_INTEGER     NOT NULL DEFAULT PERSISTENT);

    visibility : Specifies the transactional behavior of the enqueue request. Possible settings are: ON_COMMIT: The enqueue is part of the current transaction. The operation is complete when the transaction commits. This setting is the default. IMMEDIATE: The enqueue operation is not part of the current transaction, but an autonomous transaction which commits at the end of the operation. This is the only value allowed when enqueuing to a non-persistent queue.
    relative_msgid : Specifies the message identifier of the message which is referenced in the sequence deviation operation. This field is valid only if BEFORE is specified in sequence_deviation.
    sequence_deviation : Specifies whether the message being enqueued should be dequeued before other messages already in the queue. Possible settings are: BEFORE: The message is enqueued ahead of the message specified by relative_msgid. TOP: The message is enqueued ahead of any other messages. 
    transformation : Specifies a transformation that will be applied before enqueuing the message.
    delivery_mode : The enqueuer specifies the delivery mode of the messages it wishes to enqueue in the enqueue options. It can be BUFFERED or PERSISTENT. The message properties of the enqueued message indicate the delivery mode of the enqueued message. Array enqueue is only supported for buffered messages with an array size of '1'.
message_properties: 
  TYPE message_properties_t IS RECORD (
    priority               BINARY_INTEGER  NOT NULL DEFAULT 1,
    delay                  BINARY_INTEGER  NOT NULL DEFAULT NO_DELAY,
    expiration             BINARY_INTEGER  NOT NULL DEFAULT NEVER,
    correlation            VARCHAR2(128)   DEFAULT NULL,
    attempts               BINARY_INTEGER,
    recipient_list         AQ$_RECIPIENT_LIST_T,
    exception_queue        VARCHAR2(61)    DEFAULT NULL,
    enqueue_time           DATE,
    state                  BINARY_INTEGER,
    sender_id              SYS.AQ$_AGENT   DEFAULT NULL, 
    original_msgid         RAW(16)         DEFAULT NULL,
    signature              aq$_sig_prop    DEFAULT NULL,
    transaction_group      VARCHAR2(30)    DEFAULT NULL,
    user_property          SYS.ANYDATA     DEFAULT NULL
    delivery_mode          PLS_INTEGER     NOT NULL DEFAULT DBMS_AQ.PERSISTENT); 
  priority : Specifies the priority of the message. A smaller number indicates higher priority. The priority can be any number, including negative numbers.
  delay : Specifies the delay of the enqueued message. The delay represents the number of seconds after which a message is available for dequeuing. Dequeuing by msgid overrides the delay specification. A message enqueued with delay set is in the WAITING state, and when the delay expires, the message goes to the READY state. The possible settings follow: NO_DELAY: The message is available for immediate dequeuing. number: The number of seconds to delay the message.
  expiration : Specifies the expiration of the message. It determines, in seconds, the duration the message is available for dequeuing. This parameter is an offset from the time the message is ready for dequeue.  The possible settings follow: NEVER: The message does not expire. number: The number of seconds message remains in READY state. If the message is not dequeued before it expires, then it is moved to the exception queue in the EXPIRED state.
  correlation : Returns the identifier supplied by the producer of the message at enqueue time.
  attempts : Returns the number of attempts that have been made to dequeue the message. This parameter cannot be set at enqueue time.
  https://docs.oracle.com/database/121/ARPLS/t_aq.htm#ARPLS71690
payload : Not interpreted by Oracle Database Advanced Queuing. 
msgid : System generated identification of the message. 