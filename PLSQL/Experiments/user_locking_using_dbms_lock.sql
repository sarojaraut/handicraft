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

create table stock_trans(
    trans_seq   int,
    stock_id    int,
    stock_price int,
    trans_ts    timestamp);


create or replace package stock_mgmt
is

    procedure buy_stock(
        i_stock_id int default 1,
        i_slow     int default 0
    );


    procedure update_stock_price(
        i_stock_id int default 1,
        i_price    int default 11,
        i_slow     int default 0
    );

    procedure buy_stock_withlock(
        i_stock_id int default 1,
        i_slow     int default 0
    );


    procedure update_stock_price_withlock(
        i_stock_id int default 1,
        i_price    int default 11,
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
        l_price  int;
    begin
        select status, price
        into   l_status, l_price
        from   stock
        where  id = i_stock_id;

        if l_status = 'OPEN' then
            insert into stock_trans(
                trans_seq  
                ,stock_id   
                ,stock_price
                ,trans_ts   
            )
            values (
                audit_seq.nextval,
                i_stock_id,
                l_price,
                localtimestamp);
            dbms_session.sleep(i_slow);
            commit;
        else 
            raise_application_error(-20000,'Stock is closed');
        end if;
    end;

    procedure update_stock_price(
        i_stock_id int default 1,
        i_price    int default 11,
        i_slow     int default 0
    )
    is
    begin
        update stock
        set    status = 'CLOSED',
                close_seq = audit_seq.nextval,
                close_ts = localtimestamp
        where  id = i_stock_id
            and status = 'OPEN';
        insert into stock values (1,i_price,'OPEN',null,systimestamp);

        dbms_session.sleep(i_slow);

        commit;
    end update_stock_price;

    procedure reset
    is 
    begin 
        delete from stock;
        delete from stock_trans;
        insert into stock values (1,10,'OPEN',null,systimestamp);
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

        if l_status not in (0,4) then-- 0 success and 4 is already held
            raise_application_error(-20000,'Time out');
        end if;
    end;
    --
    --
    procedure buy_stock_withlock(
        i_stock_id int default 1,
        i_slow     int default 0
    ) is
        l_status varchar2(10);
        l_price  int;
    begin
        locker(i_stock_id=>i_stock_id,i_mode=>'Shared');
        
        select status, price
        into   l_status, l_price
        from   stock
        where  id = i_stock_id
        and status ='OPEN';

        if l_status = 'OPEN' then
            insert into stock_trans(
                trans_seq  
                ,stock_id   
                ,stock_price
                ,trans_ts   
            )
            values (
                audit_seq.nextval,
                i_stock_id,
                l_price,
                localtimestamp);
            dbms_session.sleep(i_slow);
            commit;
        else 
            raise_application_error(-20000,'Stock is closed');
        end if;
    end buy_stock_withlock;

    procedure update_stock_price_withlock(
        i_stock_id int default 1,
        i_price    int default 11,
        i_slow     int default 0
    )
    is
    begin
        locker(i_stock_id=>i_stock_id,i_mode=>'Exclusive');
        update stock
        set    status = 'CLOSED',
                close_seq = audit_seq.nextval,
                close_ts = localtimestamp
        where  id = i_stock_id
            and status = 'OPEN';
        insert into stock values (1,i_price,'OPEN',null,systimestamp);
        dbms_session.sleep(i_slow);

        commit;
    end update_stock_price_withlock;
end stock_mgmt;
/





/*
Reset process deletes all stock and stock_trans records and creates one stock with id=1 and price=10
stock_mgmt.buy_stock : buy stock creates stock trans record with price same as stock record with open status
stock_mgmt.update_stock_price : close the existing stock with open status and create a new stock with open status and new price(default 11)
*/

set sqlformat ansiconsole;
select id, price, close_seq, status, close_ts from stock;
select trans_seq, stock_price, trans_ts from stock_trans;

-- Session - 1
exec stock_mgmt.reset;
exec stock_mgmt.update_stock_price(i_slow=>10);

--session 2
exec stock_mgmt.buy_stock(i_slow=>10); 

-- you can observe buy stock in session two can still by useing the old price 10
-- to address this issue we will use the withlock version of both functions which use use locking mechanism
-- shared lock by buy price and excluisive lock by update stock to stop stock purchange of the same stock while price update is under process

-- Session - 1
exec stock_mgmt.reset;
exec stock_mgmt.update_stock_price_withlock(i_slow=>10);

--session 2
exec stock_mgmt.buy_stock_withlock(i_slow=>10); 