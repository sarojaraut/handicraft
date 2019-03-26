

c:\ggs_src\ggsci
create subdirs
exit

edit params mgr
or
notepad E:\ggs_src\dirprm\mgr.prm


-- add the following to it: ( or 7840 )
port 7809
-- recommended also:
BOOTDELAYMINUTES 3
autostart ER *
PURGEOLDEXTRACTS dirdat/*, USECHECKPOINTS, MINKEEPDAYS 3

-- install the Manager as a service:
E:\ggs_src>install ADDSERVICE AUTOSTART
Service 'GGSMGR' created.
Install program terminated normally.

GGSCI (WIN11SRC) 1>start manager
Starting Manager as service ('GGSMGR')...
Service started.
GGSCI (WIN11SRC) 2> info manager
Manager is running (IP port WIN11SRC.7809).

