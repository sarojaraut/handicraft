rem Setup sqlplus environment for Unicode
rem Run this before running scripts that contain multibyte characters
rem See http://www.sqlsnippets.com/en/topic-13434.html for details
set NLS_LANG=.AL32UTF8
chcp 65001

rem show raw error messages from sqlplus
rem echo exit | echo show errors | sqlplus %1 %2

rem get errors that can be parsed with problemMatcher
echo exit | echo @_show_errors.sql | sqlplus %1 %2