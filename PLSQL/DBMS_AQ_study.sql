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
   
