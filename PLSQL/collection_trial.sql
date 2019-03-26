set serveroutput on;
declare
    type t_typ is table of number index by pls_integer;
    l_typ t_typ;
    n pls_integer;
begin
    l_typ(1) :=  10;
    l_typ(2) :=  20;
    l_typ(3) :=  30;
    dbms_output.put_line('First');
    for i in l_typ.first..l_typ.last
    loop
        dbms_output.put_line('l_typ('||i||') ='|| l_typ(i));
    end loop;
    l_typ.delete(2);
    --
    --
    dbms_output.put_line('Second');
    for i in l_typ.first..l_typ.last
    loop
        if l_typ.exists(i) then
            dbms_output.put_line('l_typ('||i||') ='|| l_typ(i));
        end if;
    end loop;
    --
    --
    dbms_output.put_line('Third');
    n := l_typ.first;
    loop
        exit when n is null;
        dbms_output.put_line('l_typ('||n||') ='|| l_typ(n));
        n := l_typ.next(n);
    end loop;
    --
    --
    dbms_output.put_line('Third');
    for n IN INDICES OF l_typ
    loop
        dbms_output.put_line('l_typ('||n||') ='|| l_typ(n));
    end loop;

end;
/