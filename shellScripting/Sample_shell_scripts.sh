#simple shell script that attempts to insert a record that contains a future date to determine if there is an accepting partition. If the record is inserted successfully, then the script rolls back the transaction. If the record fails to insert, an error is generated, and the script mails you an email:


#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: $0 SID"
  exit 1
fi
# See Chapter 2 for an example of sourcing OS variables.
# source oracle OS variables
. /var/opt/oracle/oraset $1
#
sqlplus -s <<EOF
darl/foo
WHENEVER SQLERROR EXIT FAILURE
COL date_id NEW_VALUE hold_date_id
SELECT to_char(sysdate+30,'yyyymmdd') date_id FROM dual;
--
INSERT INTO inv.f_regs (reg_count, d_date_id)
VALUES (0, '&hold_date_id');
ROLLBACK;

EOF
#
if [ $? -ne 0 ]; then
  mailx -s "Partition range issue: f_regs" dkuhn@oracle.com <<EOF
  check f_regs high range.
EOF
else
  echo "f_regs ok"
fi
#
exit 0

############## Sample Script For MV refresh

#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: $0 SID"
  exit 1
fi
#
HOSTNAME=`uname -a | awk '{print$2}'`
MAILX='/bin/mailx'
MAIL_LIST='lellison@oracle.com'
ORACLE_SID=$1
jobname=CWP
# See Chapter 2 for details on using a utility
# like oraset to source OS variables
# Source oracle OS variables
. /var/opt/oracle/oraset $ORACLE_SID
date
#
sqlplus -s <<EOF
rep_mv2/foobar
WHENEVER SQLERROR EXIT FAILURE
exec dbms_mview.refresh('CWP_COUNTRY_INFO','C');
EOF
#
if [ $? -ne 0 ]; then
echo "not okay"
$MAILX -s "Problem with MV refresh on $HOSTNAME $jobname" $MAIL_LIST <<EOF
$HOSTNAME $jobname MVs not okay.
EOF
else
echo "okay"
$MAILX -s "MV refresh OK on $HOSTNAME $jobname" $MAIL_LIST <<EOF
$HOSTNAME $jobname MVs okay.
EOF
fi
#
date

exit 0

# Cron Entry. This job runs on a daily basis at 4:25 p.m.

25 16 * * * /orahome/oracle/bin/mvref_cwp.bsh DWREP \ 1>/orahome/oracle/bin/log/mvref_cwp.log 2>&1
