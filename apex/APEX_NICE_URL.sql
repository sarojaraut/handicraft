https://gba71011:8443/apextest/f?p=AMS_PORTAL


create or replace procedure AMSPORTAL as
  begin
    f(p=>'AMS_PORTAL');
  end;
/


-- Note: If you have created an application ALIAS for your application you can use it instead of the appid:page# syntax.

grant execute on AMSPORTAL to apex_public_user;

For testing at this moment

Now https://gba71011:8443/apextest/f?p=AMS_PORTAL and https://gba71011:8443/apextest/amsportal are doing the same thing.

create public synonym AMSPORTAL for sarojr.AMSPORTAL;


java -jar apexdev.war configdir C:\Saroj\ApexSoftware\Gba71011\amsdev\config

telford_proxy2

9090

C:\Saroj\ApexSoftware\apache-tomcat-8.0.26\bin

https://localhost

