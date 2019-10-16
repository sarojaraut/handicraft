create or replace function compress_int (
    n in integer )
return varchar2
--
--Creates a base36 number using A-Z and 0-9
--
as
    ret        varchar2(30);
    quotient   integer;
    remainder  integer;
    digit      char(1); -- Char representation of character
begin
    ret := '';
    quotient := n;
    while quotient > 0
    loop
        remainder := mod(quotient, 10 + 26);
        quotient := floor(quotient  / (10 + 26));
        if remainder < 26 then
            digit := chr(ascii('A') + remainder);
        else
            digit := chr(ascii('0') + remainder - 26);
        end if;
        ret := digit || ret; -- Append the latest character to the left
    end loop ;
    --select power(36,5)-1 from dual -- 60,466,175 - this number can be represented by a five letter alphanum
    ret := case when ret is null then 'A' else ret end; -- handle scenario n=0
    if length(ret) < 5 then
        ret := lpad(ret, 4, 'A');
    end if ;
    return upper(ret);
end compress_int;
/
/* -- Test
select 
    compress_int(0),         -- NULL
    compress_int(1),         -- AAAB
    compress_int(60466175),  -- 99999
    compress_int(60466176)   -- BAAAAA
from dual;
*/
