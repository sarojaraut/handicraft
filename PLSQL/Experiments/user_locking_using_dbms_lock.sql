/*
This experiment is to show how high cuncurrency can make it look as if close stock price is being used after it's closed.


*/

create sequence audit_seq;


create table stock (
    id         int,
    price      int,
    status     varchar2(10),
    close_seq  int,
    close_ts   timestamp );

create table trans (
    trans_seq int,
    stock_id  int,
    trans_ts  timestamp);


create or replace package stock_mgmt
is

    procedure buy_stock(
        i_stock_id int default 1,
        i_slow     int default 0
    );


    procedure close_stock(
        i_stock_id int default 1,
        i_slow     int default 0
    );

    procedure locker(
        i_stock_id int default 1,
        i_timeout  int default 10,
        i_mode     varchar2
    );

    procedure reset;

end stock_mgmt;
/


create or replace package body stock_mgmt
is
    procedure buy_stock(
        i_stock_id int default 1,
        i_slow     int default 0
    ) is
        l_status varchar2(10);
    begin
        select status
        into   l_status
        from   stock
        where  id = i_stock_id;

        if l_status = 'OPEN' then
            insert into trans
            values (
                audit_seq.nextval,
                i_stock_id,
                localtimestamp);
            dbms_session.sleep(i_slow);
            commit;
        else 
            raise_application_error(-20000,'Stock is closed');
        end if;
    end;

    procedure close_stock(
        i_stock_id int default 1,
        i_slow     int default 0
    )
    is
    begin
        update stock
        set    status = 'CLOSED',
                close_seq = audit_seq.nextval,
                close_ts = localtimestamp
        where  id = i_stock_id;
        dbms_session.sleep(i_slow);

        commit;
    end close_stock;

    procedure reset
    is 
    begin 
        delete from stock;
        delete from trans;
    end;

    procedure locker(
        i_stock_id int default 1,
        i_timeout  int default 10,
        i_mode     varchar2
    ) 
    is

        l_status     pls_integer;
        l_lock_id    pls_integer := i_stock_id;

    begin
        l_status := dbms_lock.request(
            id=>l_lock_id,
            lockmode=>case 
                    when i_mode = 'Shared' then dbms_lock.s_mode 
                    else dbms_lock.x_mode 
                end,
            timeout=>i_timeout,
            release_on_commit=>true);

        if l_status not in (0,4) then
            raise_application_error(-20000,'Time out');
        end if;
    end;
end stock_mgmt;
/








insert into stock
values (1,1.0,'OPEN',null,systimestamp);
commit;

exec stock_mgmt.close_stock(i_slow=>10);

exec stock_mgmt.buy_stock(i_slow=>10);

exec stock_mgmt.reset;

set sqlformat ansiconsole;
select close_seq, close_ts from stock;
select trans_seq, trans_ts from trans;


