Orcale Live SQL

COALESCE vs. NVL : COALESCE is a short circuit function but NVL is not.

CREATE OR REPLACE FUNCTION FOO RETURN NUMBER AS
BEGIN
    RETURN 1;
END FOO;

CREATE OR REPLACE FUNCTION BAR RETURN NUMBER AS
BEGIN
    RAISE_APPLICATION_ERROR(-20000, 'BAR');
END BAR;

SELECT NVL(FOO, BAR) FROM DUAL

Output : ORA-20000: BAR

SELECT COALESCE(FOO, BAR) FROM DUAL

COALESCE(FOO,BAR)
1


Materialies View Performance overhead

create table tst_mv ( 
  plazaid number, 
  lanenum number, 
  transtmst timestamp default systimestamp, 
  platenum number 
);

alter table tst_mv add constraint tst_mv_pk primary key (plazaid, lanenum, transtmst);

declare        
  st timestamp := systimestamp;        
  elps varchar2(100);        
begin        
  for rec in (select trunc(dbms_random.value(1,10)*10) plazaid, trunc(dbms_random.value(1,6)*10) lanenum, systimestamp transtmst        
  from dual connect by level < 100000) loop        
    begin        
    insert into tst_mv        
    values (rec.plazaid, rec.lanenum, rec.transtmst, null);        
    commit;        
    exception        
    when others then        
      null;        
    end;        
  end loop;        
  select systimestamp - st into elps        
  from dual;        
  dbms_output.put_line('Elapsed: ' || elps);        
end;

Elapsed: +000000000 00:00:56.965850000

truncate table tst_mv

create materialized view log on tst_mv 
with primary key 
including new values;

declare        
  st timestamp := systimestamp;        
  elps varchar2(100);        
begin        
  for rec in (select trunc(dbms_random.value(1,10)*10) plazaid, trunc(dbms_random.value(1,6)*10) lanenum, systimestamp transtmst        
  from dual connect by level < 100000) loop        
    begin        
    insert into tst_mv        
    values (rec.plazaid, rec.lanenum, rec.transtmst, null);        
    commit;        
    exception        
    when others then        
      null;        
    end;        
  end loop;        
  select systimestamp - st into elps        
  from dual;        
  dbms_output.put_line('Elapsed: ' || elps);        
end; 

Elapsed: +000000000 00:01:15.010472000

