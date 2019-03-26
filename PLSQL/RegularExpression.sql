REGEXP_COUNT(source_char, pattern, position, match_pattern)
REGEXP_INSTR (source_char, pattern, position, occurrence, return_opt, match_pattern, subexpr)
REGEXP_SUBSTR(source_char, pattern, position, occurrence, match_pattern, subexpr)
REGEXP_REPLACE(source_char, pattern, replace_string, position, occurrence, match_pattern)
REGEXP_LIKE(source_char, pattern, match_pattern)

source_char : is a character expression that serves as the search value.
pattern : is the regular expression. REGEXP_COUNT ignores subexpression parentheses in pattern. For example, the pattern '(123(45))' is equivalent to '12345'
replace_string : The replace_string can contain up to 500 backreferences to subexpressions in the form \n, where n is a number from 1 to 9. If you want to include a backslash (\) in replace_string, then you must precede it with the escape character, which is also a backslash. For example, to replace \2 you would enter \\2.
position : is a positive integer indicating the character of source_char where Oracle should begin the search. The default is 1.
occurrence : is a positive integer indicating which occurrence of pattern in source_char Oracle should search for. The default is 1.
for REGEXP_REPLACE occurrence=0 replace all matches and if any positive number n then replace the nth occurance.
return_option : lets you specify what Oracle should return in relation to the occurrence:
    If you specify 0, then Oracle returns the position of the first character of the occurrence. This is the default.
    If you specify 1, then Oracle returns the position of the character following the occurrence.

match_parameter : is a text literal that lets you change the default matching behavior of the function.
    'i' specifies case-insensitive matching and 'c' specifies case-sensitive matching.
    'n' allows the period (.), which is the match-any-character character, to match the newline character. If you omit this parameter, then the period does not match the newline character.
    'm' treats the source string as multiple lines. Oracle interprets the caret (^) and dollar sign ($) as the start and end, respectively, of any line anywhere in the source string, rather than only at the start or end of the entire source string. If you omit this parameter, then Oracle treats the source string as a single line.
    'x' ignores whitespace characters. By default, whitespace characters match themselves.
If you omit match_param, then:
    The default case sensitivity is determined by the value of the NLS_SORT parameter.
    A period (.) does not match the newline character.
    The source string is treated as a single line.

subexpr : is a nonnegative integer from 0 to 9 indicating which subexpression in pattern is to be returned by the function. 

Examples:

SELECT REGEXP_COUNT('123123123123123', '(12)3', 1, 'i') REGEXP_COUNT FROM DUAL; -- 5
SELECT REGEXP_COUNT('123123123123', '123', 3, 'i') COUNT FROM DUAL; -- 3


SELECT REGEXP_INSTR('500 Oracle Parkway, Redwood Shores, CA', '[^ ]+', 1, 2) "REGEXP_INSTR" FROM DUAL; -- 5
SELECT REGEXP_INSTR('500 Oracle Parkway, Redwood Shores, CA', '[^ ]+', 1, 3) "REGEXP_INSTR" FROM DUAL; -- 12
-- looking for occurrences of words beginning with s, r, or p, regardless of case, followed by any six alphabetic characters.
SELECT REGEXP_INSTR('500 Oracle Parkway, Redwood Shores, CA', '[O|r|p][[:alpha:]]{6}', 1, 1, 0,'i') "REGEXP_INSTR" FROM DUAL; -- 12 (Parkway) 
SELECT REGEXP_INSTR('500 Oracle Parkway, Redwood Shores, CA', '[O|r|p][[:alpha:]]{6}', 1, 1, 1,'i') "REGEXP_INSTR" FROM DUAL; -- 19 (position of , after Parkway)
-- use subexpr argument to search for a particular subexpression in pattern, returns the position in the source string of the first character in the first subexpression, which is '123':
SELECT REGEXP_INSTR('1234567890', '(123)(4(56)(78))', 1, 1, 0, 'i', 1) "REGEXP_INSTR" FROM DUAL; --1
-- returns the position in the source string of the first character in the second subexpression, which is '45678':
SELECT REGEXP_INSTR('1234567890', '(123)(4(56)(78))', 1, 1, 0, 'i', 2) "REGEXP_INSTR" FROM DUAL; --4
-- returns the position in the source string of the first character in the fourth subexpression, which is '78':
SELECT REGEXP_INSTR('1234567890', '(123)(4(56)(78))', 1, 1, 0, 'i',4 ) "REGEXP_INSTR" FROM DUAL; --7


SELECT REGEXP_SUBSTR('500 Oracle Parkway, Redwood Shores, CA',',[^,]+,') "REGEXPR_SUBSTR" FROM DUAL; -- , Redwood Shores,
SELECT REGEXP_SUBSTR('http://www.example.com/products','http://([[:alnum:]]+\.?){3,4}/?') "REGEXP_SUBSTR"   FROM DUAL; -- http://www.example.com/
SELECT REGEXP_SUBSTR('1234567890','(123)(4(56)(78))', 1, 1, 'i', 3) "REGEXP_SUBSTR" FROM DUAL; -- 123
SELECT REGEXP_SUBSTR('1234567890','(123)(4(56)(78))', 1, 1, 'i', 4)  "REGEXP_SUBSTR" FROM DUAL; -- 78


-- Examines phone_number, looking for the pattern xxx.xxx.xxxx. Oracle reformats this pattern with (xxx) xxx-xxxx.
SELECT REGEXP_REPLACE(phone_number, '([[:digit:]]{3})\.([[:digit:]]{3})\.([[:digit:]]{4})', '(\1) \2-\3') "REGEXP_REPLACE"  FROM employees  ORDER BY "REGEXP_REPLACE";
-- Examines country_name and puts a space after each non-null character in the string.
SELECT REGEXP_REPLACE(country_name, '(.)', '\1 ') "REGEXP_REPLACE" FROM countries;
-- examines the string, looking for two or more spaces. Oracle replaces each occurrence of two or more spaces with a single space.
SELECT REGEXP_REPLACE('500   Oracle     Parkway,    Redwood  Shores, CA', '( ){2,}', ' ') "REGEXP_REPLACE" FROM DUAL;
-- examines phone_number, looking for the pattern xxx.xxx.xxxx. Oracle reformats this pattern with (xxx) xxx-xxxx.
SELECT REGEXP_REPLACE('123.456.7890', '([[:digit:]]{3})\.([[:digit:]]{3})\.([[:digit:]]{4})', '(\1) \2-\3') FROM DUAL;


-- returns the first and last names OF employee's with first name of Steven or Stephen (where first_name begins with Ste and ends with en and in between is either v or ph)
SELECT first_name, last_name FROM employees WHERE REGEXP_LIKE (first_name, '^Ste(v|ph)en$');
-- employees with a double vowel in their last name
SELECT last_name FROM employees WHERE REGEXP_LIKE (last_name, '([aeiou])\1', 'i');
SELECT data FROM t1 WHERE  NOT REGEXP_LIKE(data, '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}', 'i');


Players > player_id, first_name, last_name, title, gender, dob, present address, permanent address (if you want to allow multiple address then you have to create another address table)
team > team_name, player_id
Grounds > Ground name, City name, address part 1, address pa post code, 
Schedule > date, ground




