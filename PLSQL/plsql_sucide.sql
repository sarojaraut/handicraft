create or replace procedure

 commit_sucide
is
    l_excep exception;
    pragma exception_init(l_excep, -00028);
begin
    raise l_excep;
end;
/


select 'I am not dead' status from dual;

exec commit_sucide;


------

labels do not need to match

begin
 <<mainloop>>
 loop
   <<check_some>>
   begin 
     <<dummyloop>>
     for r in (select * from dual) loop
       -- do nothing
       null;
     end loop dummyloop;
   end check_some;
   exit when 1=1;
 end loop mainloop;
end; 
/

We can use <<labels>> in plsql. Mostly to increase readability of code. This is especially useful for loop constructs, but it also works for normal begin..end blocks.

As we can see there are several <<labels>>. And the usage of those labels at the “end” helps to distinguish which code part we are looking at [1].

But this is only as good as the programmer is!

Unfortunatly this works too if do not nest them properly.

--------

dot notation for parameters

We can refer to parameters using the name of the module that declared them. This is useful when we need to distinguish a parameter from a column name.

create or replace function myFancyFunc (dummy in varchar2) return number
is
  ret number := 0;
begin
  begin
    select 1 into ret
    from dual
    where dummy = myFancyFunc.dummy
    and rownum = 1;
  exception
    when no_data_found then null;
  end;
  return ret;
end myFancyFunc;
/

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

----------------

when others does not catch all exceptions

set serveroutput on 
declare
  e_cancelled exception;
  pragma exception_init(e_cancelled, -1013);
begin
  begin
    raise e_cancelled;
  exception
    when others then
      dbms_output.put_line('EXCEPTION OTHERS');
  end;
end;
/

ORA-01013: user requested cancel of current operation
ORA-06512: at line 6


We still see an exception, but not the dbms buffer output!

This needs some explanation.

There is a very limited set of exceptions that will not be captured by the WHEN OTHERS handler. We need to look closely and understand the exception itself to comprehend why this is a good thing.

Here the ORA-01013 is the “user requested cancel of current operation” exception. Essentially it means somebody pressed “CTRL+C” while running the code. In almost all environments this means: Stop doing whatever you do immediately! Or in more technical terms: It is an interrupt to the os process running your command.

We are allowed to capture this exception and write a special handler for it.

set serveroutput on
declare
  e_cancelled exception;
  pragma exception_init(e_cancelled, -1013);
begin
  begin
    raise e_cancelled;
  exception
    when others then
      dbms_output.put_line('EXCEPTION OTHERS');
  end;
exception 
  when e_cancelled then
    dbms_output.put_line('OPERATION CANCELED');
END;
/

PL/SQL procedure successfully completed.

OPERATION CANCELED
--------------

select UNIQUE

Instead of doing a SELECT DISTINCT you can do SELECT UNIQUE.

But you shouldn’t. None of them. Forget I mentioned this.

Sven says: “SELECT DISTINCT|UNIQUE should be considered a bug in real production code.”
I have yet to find an example where SELECT DISTINCT is needed. More likely there is a bug in the data model or missing joins in the where clause. GROUP BY or sometimes EXISTS are the better long term alternatives.

Using SELECT DISTINCT is absolutly fine for developer ad-hoc queries.

------------

+ vs. –

In some edge cases using a different operator (+|-) leads to disturbing results.

Example: Substracting a tiny number from 1 does not equal 1. But adding a tiny number from 1 does equal 1!

select * from dual
where 1 = 1-0.000000000000000000000000000000000000001;

No data found!

select * from dual
where 1 = 1+0.000000000000000000000000000000000000001;

DUMMY
-----
X

Wat? Why do we get a result?!

The solution is simple. We overstepped the maximum precision of the number datatype when doing the addition. Max precision is 38 digits. The addition would require a precision of 39. Instead the result is rounded (or truncated) to a precision of 38 digits, which happens to equal 1.  The substraction result still is in the 38 precision range and therefore exact (very slightly less than 1).


-----------

(1,2) = ((1,2))

We can compare expression lists using the = operator. But the right side of the comparison needs an extra set of parenthesis.

select 'TRUE' checked from dual
 where (1,2,3,4,5) = ((1,2,3,4,5));
 
 CHECKED
-------
TRUE
This is just a shorthand form of

1=1 and 2=2 and 3=3 and 4=4 and 5=5

If we do not use the second set of parenthesis on the right hand side of the comparison, then we get an error.

select 'TRUE' checked from dual
 where (1,2,3,4,5) = (1,2,3,4,5) ;
ORA-00920: invalid relational operator

This is documented. Although a tiny bit difficult to read in the syntax diagrams.


Don’t confuse precision with maximum value! Precision is the number of different digits that we can store. This can then be moved by an exponent to the left or right for very large or very small values.



https://svenweller.wordpress.com/2017/06/22/10-oracle-sql-features-you-probably-didnt-know/

https://svenweller.wordpress.com/2017/07/14/10-plsql-things-you-probably-didnt-know/#

