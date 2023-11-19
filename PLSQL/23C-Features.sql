CREATE TABLE TICKETSALES(

ID NUMBER PRIMARY KEY,

NAME VARCHAR2(100),

CAPACITY NUMBER RESERVABLE CONSTRAINT MINIMUM_CAPACITY CHECK (CAPACITY >= 10)

);

Working with a resource pool with lock-free reservations is quite straightforward:

define a column as reservable. This must be a numeric column
define check constraint(s) to control the allowable values for the column (usually limiting the lower or upper capacity limit; note: check constraints can compare non reservable (regular) columns with reservable columns
access the record to be updated using its primary / unique key – make sure the update is a single row statement
do not use for update of when updating the reservable column’s value (as that would defeat the purpose)
only use set column = column + claim or set column = column – claim to claim part of the capacity; do not use set column = value.
the pool can be replenished; capacity can be added for example. However, the transaction that adds capacity needs to be committed before it will have an effect on additional reservations that can be made by other transactions
Oracle Database creates a “Reservation Journal Table” – SYS_RESERVJRNL_<object_number_of_base_table> – that records the claims made against a resource pool. This table behaves like a global temporary table: each session only sees its own claims. When the session commits (or rolls back) the table is cleared. Flashback query does not return values from this table and even SYS cannot look across sessions to find all currently held reservations

DROP <object> IF EXISTS ...
CREATE <object> IF NOT EXISTS ...

oracle.github.io

