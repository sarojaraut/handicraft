----------- For testing function slacheck.CalcBusinessInterval
set serveroutput on;
DECLARE
	i_start_range     DATE;
	i_end_range       DATE;
	i_diff            NUMBER;
	v_test_id         NUMBER;
	v_test_desc       VARCHAR2(500);
	v_test_result     VARCHAR2(20):= 'FAILURE';
	v_expected_res    NUMBER;
	v_actual_res      NUMBER;
BEGIN
	--
	v_test_id      := 1;
	v_test_desc    := 'Open Time is exactly same as close time';
	v_expected_res := 0;
	i_start_range  := trunc(systimestamp)+interval '0 09:30:00' day to second;
	i_end_range    := trunc(systimestamp)+interval '0 09:30:00' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'*********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	--
	--
	v_test_id      := 2;
	v_test_desc    := 'Difference is exactly one day';
	v_expected_res := 7;
	i_start_range  := to_date('29/11/2012','dd/mm/yyyy') + interval '0 00:00:00' day to second;
	i_end_range    := to_date('29/11/2012','dd/mm/yyyy') + interval '0 23:59:59' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'*********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	--
	
	v_test_id      := 3;
	v_test_desc    := 'Single Day range falles entirely out of business hours';
	v_expected_res := 0;
	i_start_range  := to_date('29/11/2012','dd/mm/yyyy') + interval '0 14:30:00' day to second;
	i_end_range    := to_date('29/11/2012','dd/mm/yyyy') + interval '0 23:59:59' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'  *********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	--
	--
	v_test_id      := 4;
	v_test_desc    := 'Four complete Day range, Without any holiday inbetween.';
	v_expected_res := 28;
	i_start_range  := to_date('26/11/2012','dd/mm/yyyy') + interval '0 00:30:00' day to second;
	i_end_range    := to_date('29/11/2012','dd/mm/yyyy') + interval '0 23:59:59' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'  *********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	--
	--
	v_test_id      := 5;
	v_test_desc    := 'Five day range with Last day holiday and First day from 10:30 AM';
	v_expected_res := 25;
	i_start_range  := to_date('26/11/2012','dd/mm/yyyy') + interval '0 10:30:00' day to second;
	i_end_range    := to_date('30/11/2012','dd/mm/yyyy') + interval '0 23:59:59' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'  *********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	--
	--	
	v_test_id      := 6;
	v_test_desc    := 'First day after 14:30 and last day before 7:30 and two working days in between';
	v_expected_res := 14;
	i_start_range  := to_date('26/11/2012','dd/mm/yyyy') + interval '0 14:30:00' day to second;
	i_end_range    := to_date('29/11/2012','dd/mm/yyyy') + interval '0 07:30:59' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'  *********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	--
	--
	v_test_id      := 7;
	v_test_desc    := 'Only two days RANGE, First day after 14:30 and second day before 7:30';
	v_expected_res := 0;
	i_start_range  := to_date('26/11/2012','dd/mm/yyyy') + interval '0 14:30:00' day to second;
	i_end_range    := to_date('27/11/2012','dd/mm/yyyy') + interval '0 07:30:00' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'  *********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	--
	--
	v_test_id      := 8;
	v_test_desc    := 'Invalid Range -- end date less than first date';
	v_expected_res := 0;
	i_start_range  := to_date('26/11/2012','dd/mm/yyyy') + interval '0 10:30:00' day to second;
	i_end_range    := to_date('25/11/2012','dd/mm/yyyy') + interval '0 10:30:00' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'  *********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	--
	--
	v_test_id      := 9;
	v_test_desc    := 'Same Day, both start and end time falling within business hours';
	v_expected_res := 3;
	i_start_range  := to_date('26/11/2012','dd/mm/yyyy') + interval '0 10:30:00' day to second;
	i_end_range    := to_date('26/11/2012','dd/mm/yyyy') + interval '0 13:30:00' day to second;
	--
	DBMS_OUTPUT.PUT_LINE('Test Execution '||v_test_id|| ' : '||v_test_desc);
	v_actual_res   := slacheck.CalcBusinessInterval(i_start_range,i_end_range );
	IF (v_expected_res = v_actual_res) THEN
		v_test_result := 'SUCCESS';
	ELSE
		v_test_result := 'FAILURE';
	END IF;	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Expected value='||v_expected_res||' and Actual value='||v_actual_res
	||'  *********** Test Execution '||v_test_id||' IS ' ||v_test_result);
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
END;
/

/*
----------- For testing function slacheck.FindDayElapsedTime
declare
	i_start_range   date;
	i_end_range     date;
	i_diff          NUMBER;
BEGIN
	i_start_range := trunc(systimestamp)+interval '0 07:30:00' day to second;
	i_end_range   := trunc(systimestamp)+interval '0 8:36:00' day to second;
	i_diff   := FindDayElapsedTime(i_start_range,i_end_range );
	dbms_output.put_line('Difference in hours is='||i_diff);
END;
/
----------- For testing function slacheck.IsWorkingday

declare
	i_input_date    date := trunc(sysdate);
	i_diff          NUMBER;
BEGIN
	IF IsWorkingday(i_input_date) THEN 
		dbms_output.put_line('Input date '||TRIM(to_char(i_input_date,'DAY'))||' is a Working day !!!');
	ELSE
		dbms_output.put_line('Input date '||TRIM(to_char(i_input_date,'DAY'))||' is a Holiday !!!');
	END IF;
END;
/
---------
*/