--��Ī : ���̺�, �÷��� �ٸ� �̸����� ��Ī 
--  [AS] ��Ī��
-- SELECT empno [AS] eno
-- FROM emp e;

--SYNONYM (���Ǿ�)
--����Ŭ ��ü�� �ٸ��̸����� �θ� �� �ֵ��� �ϴ� ��
--���࿡ emp ���̺��� e ��� �ϴ� synonym(���Ǿ�)�� ������ �ϸ�
-- ������ ���� SQL�� �ۼ� �� �� �ִ�
-- SELECT *
-- FROM e;

--sem������ SYNONYM ���� ������ �ο�
GRANT CREATE SYNONYM TO sem;

-- emp ���̺��� ����Ͽ� synonym e�� ����
-- CREATE SYNONYM �ó�� �̸� FOR ����Ŭ��ü;
CREATE SYNONYM e FOR emp;

-- emp ��� ���̺� �� ��ſ� e ��� �ϴ� �ó���� ����Ͽ� ������ �ۼ� 
-- �� �� �ִ�
SELECT *
FROM emp;

SELECT *
FROM e;

-- sem ������ fastfood ���̺��� hr ���������� �� �� �ֵ���
-- ���̺� ��ȸ ������ �ο�
GRANT SELECT ON fastfood TO hr;


--
SELECT *
FROM emp
WHERE empno = :empno;

--������ SQL�� ���信 ������ �Ʒ� SQL���� �ٸ���
SELECT /* 201911_205 */ * FROM emp;
SELECT /* 201911_205 */ * FROM EMP;
SELECt /* 201911_205 */ * FROM EMP;

SELECt /* 201911_205 */ * FROM EMP WHERE empno=7369;
SELECt /* 201911_205 */ * FROM EMP WHERE empno=7499;
SELECt /* 201911_205 */ * FROM EMP WHERE empno=:empno;


--multiple insert
DROP TABLE emp_test;

--emp ���̺��� empno, ename �÷����� emp_test, emp_test2 ���̺���
--����(CTAS, �����͵� ���� ����)
CREATE TABLE emp_test AS
SELECT empno, ename 
FROM emp;

CREATE TABLE emp_test2 AS
SELECT empno, ename 
FROM emp;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

--uncoditional insert
--���� ���̺� �����͸� ���� �Է�
--brown, cony�����͸� emp_test, emp_test2 ���̺� ���ÿ� �Է�
INSERT ALL 
    INTO emp_test
    INTO emp_test2
SELECT 9999, 'brown' FROM DUAL UNION ALL
SELECT 9998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000;

SELECT *
FROM emp_test2
WHERE empno > 9000;



--���̺� �� �ԷµǴ� �������� �÷��� ���� ����
ROLLBACK;
INSERT ALL 
    INTO emp_test (empno, ename) VALUES(eno, enm)
    INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 9998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 9000;

--CONDITIONAL INSERT
--���ǿ� ���� ���̺� �����͸� �Է�
ROLLBACK;

/*
    CASE
        WHEN ���� THEN ----   //IF
        WHEN ���� THEN ----   //ELSE IF
        ESLE ----            //ELSE
*/
ROLLBACK;

INSERT ALL
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    ELSE
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 8998, 'cony' FROM DUAL;    

SELECT *
FROM emp_test
WHERE empno > 9000 UNION ALL
SELECT *
FROM emp_test2
WHERE empno > 8000;




ROLLBACK;

INSERT FIRST
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    ELSE
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 8998, 'cony' FROM DUAL;    

