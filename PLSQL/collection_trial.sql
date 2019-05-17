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


set serveroutput on;
declare
    l_var   logger.tab_param;
    l_clob   clob;
begin
    l_var := logger.tab_param (
         2 => logger.rec_param ('Name-2', 'Val-22'), 
         1 => logger.rec_param ('Name-1', 'Val-1'), 
         3 => logger.rec_param ('Name-3', 'Val-3')
    );
--    l_clob := logger.get_param_clob( p_params => l_var);
    for i in 1..l_var.count
    loop
        l_clob := l_clob || l_var(i).name||' : '||l_var(i).val||chr(13);
    end loop;
    dbms_output.put_line(l_clob);
end;
/
