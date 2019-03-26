CREATE OR REPLACE PACKAGE pkg_collection_test
IS
    TYPE db_details_rec IS RECORD ( 
        db_name           VARCHAR2(100),
        module            VARCHAR2(100),
        current_user      VARCHAR2(100),
        sessionid         VARCHAR2(100),
        host              VARCHAR2(100),
        rest_end_url      VARCHAR2(500)
    );
    
    TYPE db_details_tab IS TABLE OF db_details_rec index by varchar2(30);
    
    procedure p;
END;
/


CREATE OR REPLACE PACKAGE body pkg_collection_test
IS
    PROCEDURE P
    IS
        l_rec      db_details_rec;
        l_rec_tab  db_details_tab;
    BEGIN
        l_rec.db_name := 'cmsdev';
        l_rec.module := 'ords';
        l_rec_tab('CMSDEV') := l_rec;
        l_rec.db_name := 'cmstst';
        l_rec.module := 'ords';
        l_rec_tab('CMSTST') := l_rec;
        
        dbms_output.put_line(l_rec_tab('CMSTST').db_name);
        
    END;
END;
/

set serveroutput on;
exec pkg_collection_test.p;