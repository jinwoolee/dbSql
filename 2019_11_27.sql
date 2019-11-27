SELECT *
FROM no_emp;

--1.leaf node ã��
SELECT LPAD(' ', (LEVEL-1)*4, ' ') || org_cd, s_emp
FROM
    (SELECT org_cd, parent_org_cd, SUM(s_emp) s_emp
    FROM
        (SELECT org_cd, parent_org_cd, 
               SUM(no_emp/org_cnt) OVER (PARTITION BY GR ORDER BY rn
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) s_emp 
        FROM 
        (SELECT a.*, ROWNUM rn, a.lv + ROWNUM gr,
                COUNT(org_cd) OVER (PARTITION BY org_cd ) org_cnt
            FROM
            (SELECT org_cd, parent_org_cd, no_emp, LEVEL LV, connect_by_isleaf leaf
             FROM no_emp
             START WITH parent_org_cd IS NULL
             CONNECT BY PRIOR org_cd = parent_org_cd) a
            START WITH leaf = 1
            CONNECT BY PRIOR parent_org_cd = org_cd))
    GROUP BY org_cd, parent_org_cd )
START WITH parent_org_cd IS NULL
CONNECT BY PRIOR org_cd = parent_org_cd;



--PL/SQL
--�Ҵ翬�� :=
-- System.out.println("") --> dbms_out.put_line("");
-- Log4j
--set serveroutput on; --��±���� Ȱ��ȭ
--PL/SQL
--declare : ����, ��� ����
--begin : ���� ����
--exception : ����ó��
DESC dept;

set serveroutput on;
DECLARE
    --���� ����
    deptno NUMBER(2);
    dname VARCHAR2(14);
BEGIN
    SELECT deptno, dname INTO deptno, dname
    FROM dept
    WHERE deptno = 10;
    
    --SELECT ���� ����� ������ �� �Ҵ� �ߴ��� Ȯ��
    dbms_output.put_line('dname : ' || dname || '(' || deptno || ')');
END;
/


DECLARE
    --���� ���� ����(���̺� �÷�Ÿ���� ����ǵ� pl/sql ������ ������ �ʿ䰡 ����)
    deptno dept.deptno%TYPE;
    dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO deptno, dname
    FROM dept
    WHERE deptno = 10;
    
    --SELECT ���� ����� ������ �� �Ҵ� �ߴ��� Ȯ��
    dbms_output.put_line('dname : ' || dname || '(' || deptno || ')');
END;
/


--10���μ��� �μ��̸��� LOC������ ȭ���߷��ϴ� ���ν���
--���ν����� : printdept
-- CREATE OR REPLACE VIEW
CREATE OR REPLACE PROCEDURE printdept 
IS
    --��������
    dname dept.dname%TYPE;
    loc  dept.loc%TYPE;
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line('dname, loc = ' || dname || ',' || loc);
END;
/



CREATE OR REPLACE PROCEDURE printdept_p(p_deptno IN dept.deptno%TYPE) 
IS
    --��������
    dname dept.dname%TYPE;
    loc  dept.loc%TYPE;
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
    
    dbms_output.put_line('dname, loc = ' || dname || ',' || loc);
END;
/

exec printdept_p(30);

--procedure : printemp
--�Է� : �����ȣ
--��� : ����̸�, �μ��̸�


CREATE OR REPLACE PROCEDURE printemp (p_empno IN emp.empno%TYPE)
IS
    var_ename emp.ename%TYPE;
    var_dname dept.dname%TYPE;
BEGIN
    SELECT ename, dname
    INTO var_ename, var_dname
    FROM emp, dept
    WHERE empno = p_empno
    AND emp.deptno = dept.deptno;
    
    dbms_output.put_line(var_ename || ', ' || var_dname);
END;
/
exec printemp(7369);

SELECT *
FROM dept_test;

DELETE dept_test
WHERE DEPTNO >90;

COMMIT;

CREATE TABLE dept_test AS
SELECT *
FROM dept;





