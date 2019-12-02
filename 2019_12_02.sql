--�͸� ���
SET serveroutput on;

DECLARE 
    --����̸��� ������ ��Į�� ����(1���� ��)
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename
    INTO v_ename 
    FROM emp;    
    --��ȸ����� �������ε� ��Į�󺯼��� ���� �����Ϸ��� �Ѵ�
    -- --> ����
    
    --�߻�����, �߻����ܸ� Ư�� ���� ���鶧 --> OTHERS (java : Exception)
    EXCEPTION
        WHEN others THEN
            dbms_output.put_line('Excepton others');
END;
/


--����� ���� ����
DECLARE
    --emp ���̺� ��ȸ�� ����� ���� ��� �߻���ų ����� ���� ����
    --���ܸ� EXCEPTION;  --������ ����Ÿ��
    NO_EMP EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
    
    BEGIN
        SELECT ename
        INTO v_ename
        FROM emp
        WHERE empno=9999;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('������ ������');
                --����ڰ� ������ ����� ���� ���ܸ� ����
                RAISE NO_EMP;
    END;
    
    EXCEPTION
        WHEN NO_EMP THEN
            dbms_output.put_line('no_emp exception');
END;
/


--�����ȣ�� �����ϰ�, �ش� �����ȣ�� �ش��ϴ� ����̸��� �����ϴ� �Լ�(function)
CREATE OR REPLACE FUNCTION getEmpName(p_empno emp.empno%TYPE) 
RETURN VARCHAR2 
IS
    --�����
    ret_ename emp.ename%TYPE;
BEGIN
    --����
    SELECT ename
    INTO ret_ename
    FROM emp
    WHERE empno = p_empno;
    
    RETURN ret_ename;
END;
/



SELECT getEmpName(7369)
FROM dual;

SELECT empno, ename, getEmpName(empno)
FROM emp;

--function1
--�μ������� �Ķ���ͷ� �Է¹ް�, �ش� �μ��� �̸��� ����
CREATE OR REPLACE FUNCTION getDeptName(p_deptno dept.deptno%TYPE) 
RETURN VARCHAR2 
IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname
    INTO v_dname
    FROM dept
    WHERE deptno=p_deptno;
    
    RETURN v_dname;
END;
/

SELECT getdeptname(40)
FROM dual;

SELECT deptno, dname, getdeptname(deptno)
FROM dept;

SELECT empno, ename, deptno, getdeptname(deptno)
FROM emp;

--������ ��� --> ����ó��
SELECT empno, ename, deptno, getdeptname(deptno),
      (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname,
      (SELECT loc FROM dept WHERE dept.deptno = emp.deptno) loc
FROM emp;


--SELECT deptcd, LPAD(' ', (LEVEL-1)*4, ' ') || deptnm as deptnm

SELECT deptcd, indent(' ', LEVEL, deptnm) as deptnm
FROM dept_h
START WITH p_deptcd IS null
CONNECT BY PRIOR deptcd = p_deptcd;

CREATE OR REPLACE FUNCTION 
indent(ch VARCHAR2, p_level NUMBER, p_dname dept.dname%TYPE)RETURN VARCHAR2 
IS
    ret_text VARCHAR2(50);
BEGIN
    SELECT LPAD(ch, (p_level - 1)*4, ch) || p_dname
    INTO ret_text
    FROM DUAL;
    RETURN ret_text;
END;
/

SELECT indent(2, 'ACCOUNTING'), indent(3, 'SALES')
FROM dual;


dbms_output.put_line;
SELECT *
FROM TABLE(dbms_xplan.display);

SELECT NAMES.GETEMPNAME(7369)
FROM dual;

CREATE OR replace PACKAGE names AS 
  FUNCTION getEmpname ( p_empno emp.empno%TYPE)   RETURN VARCHAR2; 
  FUNCTION getdeptname ( p_deptno dept.deptno%TYPE)   RETURN VARCHAR2; 
END names; 
/


CREATE OR replace PACKAGE BODY names AS
 
  FUNCTION getEmpname (p_empno emp.empno%TYPE)  RETURN VARCHAR2  IS 
    ename emp.ename%TYPE; 
  BEGIN 
      SELECT ename 
      INTO   ename 
      FROM   emp 
      WHERE  empno = p_empno; 

      RETURN ename; 
  END; 
  FUNCTION getdeptname (p_deptno dept.deptno%TYPE) RETURN VARCHAR2  AS 
    dname dept.dname%TYPE; 
  BEGIN 
      SELECT dname 
      INTO   dname 
      FROM   dept 
      WHERE  deptno = p_deptno; 

      RETURN dname; 
  END; 
END; 
/ 


CREATE TABLE user_history(
    userid VARCHAR2(20),
    pass VARCHAR2(100),
    mod_dt DATE
);

--users ���̺��� pass �÷��� ����� ���
--users_histroy�� ������ pass�� �̷����� ����� Ʈ����
CREATE OR REPLACE TRIGGER make_history
    BEFORE UPDATE ON users --users ���̺��� ������Ʈ ����
    FOR EACH ROW
    
    BEGIN
        --:NEW.�÷��� : UPDATE ������ �ۼ��� ��
        --:OLD.�÷��� : ���� ���̺� ��
        IF :NEW.pass != :OLD.pass THEN
            INSERT INTO user_history 
            VALUES (:OLD.userid, :OLD.pass, sysdate);
        END IF;
    END;
/
--brown	����	c6347b73d5b1f7c77f8be828ee3e871c819578f23779c7d5e082ae2b36a44
SELECT *
FROM users;

UPDATE users SET pass = 'newpass';

SELECT *
FROM user_history;


ibatis(2.X) --> mybatis(3.X)
--����






