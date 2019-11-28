--PRO_2
CREATE OR REPLACE PROCEDURE registdept_test 
(p_deptno IN dept.deptno%TYPE,
 p_dname IN dept.dname%TYPE,
 p_loc IN dept.loc%TYPE)
IS

BEGIN
    INSERT INTO dept_test VALUES (p_deptno, p_dname, p_loc);
    COMMIT;
END;
/

exec registdept_test(99, 'ddit', 'daejeon');



--PRO_3
CREATE OR REPLACE PROCEDURE UPDATEdept_test 
(p_deptno IN dept.deptno%TYPE,
 p_dname IN dept.dname%TYPE,
 p_loc IN dept.loc%TYPE)
IS

BEGIN
    UPDATE dept_test SET dname = p_dname, loc = p_loc
    WHERE deptno = p_deptno;
    COMMIT;
END;
/

exec UPDATEDEPT_TEST (99, 'ddit_m', 'DAEJEON');

SELECT *
FROM dept_test;


--ROWTYPE : ���̺��� �� ���� �����͸� ���� �� �ִ� ���� Ÿ��
set serveroutput on;

DECLARE
    dept_row dept%ROWTYPE;    
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line(dept_row.deptno || ', ' ||
                         dept_row.dname|| ', ' || 
                         dept_row.loc);
END;
/

--���պ��� : record
DECLARE
    --UserVo userVo;
    TYPE dept_row IS RECORD(
        deptno NUMBER(2),
        dname dept.dname%TYPE);
    
    v_dname dept.dname%Type;
    v_row dept_row;
BEGIN
    SELECT deptno, dname
    INTO v_row
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line( v_row.deptno || ', ' || v_row.dname);
END;
/

--tabletype
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    
    --java : Ÿ�� ������;
    --pl/sql : ������ Ÿ��;
    v_dept dept_tab;
    
    bi BINARY_INTEGER;
    
BEGIN
    bi := 100;
    
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept;
    
    dbms_output.put_line(bi);
    
    FOR i IN 1..v_dept.count LOOP
        dbms_output.put_line(v_dept(i).dname);
    END LOOP;
END;
/

SELECT *
FROM dept;


--IF
--  ELSE IF --> ELSIF
--END IF;

DECLARE
    ind BINARY_INTEGER;
BEGIN
    ind := 2;
    
    IF ind = 1 THEN
        dbms_output.put_line(ind);
    ELSIF ind = 2 THEN
        dbms_output.put_line('ELSIF ' || ind );
    ELSE
        dbms_output.put_line('ELSE');
    END IF;
END;
/

--FOR LOOP :
--FOR �ε��� ���� IN ���۰�..���ᰪ LOOP
--END LOOP;

DECLARE
BEGIN
    FOR i IN 0..5 LOOP
        dbms_output.put_line('i : ' || i);
    END LOOP;
END;
/


--LOOP : ��� ���� �Ǵ� ������ LOOP �ȿ��� ����
--java : while(true)

DECLARE
    i NUMBER;
BEGIN
    i := 0;
    
    LOOP 
        dbms_output.put_line(i);
        i := i + 1;
        --loop ��� �������� �Ǵ�
        EXIT WHEN i >=5;
    END LOOP;
END;
/


--���� ��� : 5 ��

SELECT *
FROM dt;


DECLARE 
    TYPE d_table IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    d_tab d_table;
    diff_sum NUMBER := 0;
BEGIN
    SELECT *
    BULK COLLECT INTO d_tab
    FROM dt
    ORDER BY dt;
    
    FOR i IN 1..d_tab.count LOOP
        IF i != 1 THEN
            dbms_output.put_line((d_tab(i).dt - d_tab(i-1).dt));
            diff_sum := diff_sum + (d_tab(i).dt - d_tab(i-1).dt);
        END IF;
    END LOOP;
    
    dbms_output.put_line('diff_sum :' || diff_sum);
    dbms_output.put_line('������� :' || (diff_sum/(d_tab.count-1)));
    
END;
/

--lead, lag �������� ����, ���� �����͸� ������ �� �ִ�
SELECT AVG(diff)
FROM 
(SELECT dt - LEAD(dt) OVER (ORDER BY dt DESC) diff
 FROM dt);

--�м��Լ��� ������� ���ϴ� ȯ�濡��
SELECT AVG(a.dt - b.dt)
FROM 
(SELECT ROWNUM RN, dt
 FROM
    (SELECT dt
     FROM dt
     ORDER BY dt DESC)) a,
(SELECT ROWNUM RN, dt
 FROM
    (SELECT dt
     FROM dt
     ORDER BY dt DESC)) b
WHERE a.rn = b.rn(+) -1;

--HALL OF HONOR
SELECT (MAX(dt)-MIN(dt)) / (COUNT(*)-1)
FROM dt;


DECLARE
    --Ŀ�� ����
    CURSOR dept_cursor IS
        SELECT deptno, dname FROM dept;
        
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    --Ŀ�� ����
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO v_deptno, v_dname;
        dbms_output.put_line(v_deptno || ', ' || v_dname);
        EXIT WHEN dept_cursor%NOTFOUND; --���̻� ���� �����Ͱ� ���� �� ����
    END LOOP;
END;
/


--FOR LOOP CURSOR ����
DECLARE
    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept;
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    FOR rec IN dept_cursor LOOP
        dbms_output.put_line(rec.deptno || ', ' || rec.dname);
    END LOOP;
END;
/


--�Ķ���Ͱ� �ִ� ����� Ŀ��
DECLARE
    CURSOR emp_cursor(p_job emp.job%TYPE) IS
        SELECT empno, ename, job 
        FROM emp
        WHERE job = p_job;
    
BEGIN
    FOR emp IN emp_cursor('SALESMAN') LOOP
        dbms_output.put_line(emp.empno || ', ' || emp.ename ||', '|| emp.job);
    END LOOP;
END;
/





