sem.v_emp ==> v_emp
SELECT *
FROM sem.v_emp;

CREATE SYNONYM v_emp FOR sem.v_emp;

SELECT *
FROM v_emp;