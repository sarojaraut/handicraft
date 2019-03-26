create or replace package dbms_output
as
  procedure enable(BUFFER_SIZE number default null);
  procedure put_line(A in varchar2);
  procedure GET_LINE(LINE out VARCHAR2,STATUS out integer);
  procedure GET_LINES(LINES out sys.dbms_output.CHARARR,NUMLINES in out NUMBER);
  procedure GET_LINES(LINES out sys.DBMSOUTPUT_LINESARRAY,NUMLINES in out NUMBER);
end dbms_output ;
/
 
create or replace package body dbms_output
as
procedure enable(BUFFER_SIZE number default null) is
begin
  sys.dbms_output.enable(BUFFER_SIZE);
end;
 
function getRandomQuote (A in varchar2) return varchar2
is
  type quotes_t is table of varchar2(4000) index by binary_integer;
  v_quotes quotes_t;
  v_random binary_integer;
begin
  v_quotes(1) := 'You are hacked by the Chinese';
  v_quotes(2) := 'Wrong usage of DBMS_OUTPUT detected.';
  v_quotes(3) := 'System failure. Get away from keyboard';
  v_quotes(4) := 'Close all windows! NOW!';
  v_quotes(5) := 'Make Databases Great Again!';
  v_quotes(6) := A; -- sometimes return the correct text
  v_quotes(7) := A; -- sometimes return the correct text
  v_quotes(8) := 'So tell me what you want, what you really, really want';
  v_quotes(9) := 'None but ourselves can free our minds.';
  v_quotes(10) := 'Let there be light!';
  v_random := round(dbms_random.value(1,v_quotes.last));
 
  return v_quotes(v_random);
 
end getRandomQuote;
 
procedure put_line(A in varchar2) is
begin
  sys.dbms_output.put_line(getRandomQuote(A));
end;
 
procedure GET_LINE(LINE out VARCHAR2,STATUS out integer)
is
begin
  sys.dbms_output.GET_LINE(LINE,STATUS);
end;
 
procedure GET_LINES(LINES out sys.dbms_output.CHARARR,NUMLINES in out NUMBER)
is
begin
  sys.dbms_output.GET_LINES(LINES,NUMLINES);
end;
 
procedure GET_LINES(LINES out sys.DBMSOUTPUT_LINESARRAY,NUMLINES in out NUMBER)
is
begin
  sys.dbms_output.GET_LINES(LINES,NUMLINES);
end;
end dbms_output ;
/