-- variable names be emojis, open in visual studio code
set serveroutput on
declare
  "💩"exception;
  pragma exception_init("💩",-20001);

  "⌚" timestamp := systimestamp;
  "🕑"interval day to second;
  "🎲"number;
  "💤"number := 2;
begin
  "🎲":= round(dbms_random.value(1,6));
  for "🔜"in 1.."🎲"loop
    dbms_lock.sleep("💤");
  end loop;
  "🕑":= systimestamp - "⌚" ;
  dbms_output.put_line('Slept for '|| "🕑");
exception
  when "💩"then
    dbms_output.put_line('Sorry something bad happend!');
    raise "💩";
end;
/

PL/SQL procedure successfully completed.

Slept for +00 00:00:08.049000