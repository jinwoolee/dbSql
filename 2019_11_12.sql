--sub7
--1������ �Դ� ������ǰ
--2������ �Դ� ������ǰ���� ����
--���� �߰�
SELECT cycle.cid, customer.cnm, product.pid, product.pnm, day, cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.cid = customer.cid
AND cycle.pid = product.pid
AND cycle.pid IN (SELECT pid FROM cycle WHERE cid=2);

--sub9
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND pid = product.pid );

--1������ �����ϴ� ��ǰ
SELECT pid
FROM cycle
WHERE cid = 1;


SELECT *
 FROM DEPT;

DELETE DEPT WHERE DEPTNO=99;
COMMIT;

INSERT INTO customer
VALUES (99, 'ddit');
commit;

desc dept;

------ -- ------------ 
DEPTNO    NUMBER(2)    
DNAME     VARCHAR2(14) 
LOC       VARCHAR2(13) 

INSERT INTO DEPT
VALUES ('ddit', 99, 'daejeon');

desc emp;

INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', null);

INSERT INTO emp (ename, job)
VALUES ('brown', null);

SELECT *
FROM emp
WHERE empno=9999;

rollback;

desc emp;

SELECT *
FROM user_tab_columns
WHERE table_name = 'EMP'
ORDER BY column_id;

1.EMPNO
2.ENAME
3.JOB
4.MGR
5.HIREDATE
6.SAL
7.COMM
8.DEPTNO;

INSERT INTO emp 
VALUES (9999, 'brown', 'ranger', null, sysdate, 2500, null, 40);

--SELECT ���(������)�� INSERT

INSERT INTO emp (empno, ename)
SELECT deptno, dname
FROM dept;

SELECT *
FROM emp;

--UPDATE 
-- UPDATE ���̺� SET �÷�=��, �÷�=��....
-- WHERE condition

INSERT INTO dept values (99, 'ddit', 'daejeon');
commit;

SELECT *
FROM dept;

desc dept;

UPDATE dept SET dname='���IT', loc='ym';
--WHERE deptno=99;
rollback;


--������-���ݿ����� (����Ʈ�����-13000, ���, �Ϲ�����, ������-650)
--�ֹι�ȣ ���ڸ�
update ��������̺� set ��й�ȣ=�ֹй�ȣ���ڸ�
where ����� ������='�����';
commit;

SELECT *
FROM emp;

--DELETE ���̺��
--WHERE condition

--�����ȣ�� 9999�� ������ emp ���̺��� ����
DELETE emp
WHERE empno=9999;

--�μ����̺��� �̿��ؼ� emp ���̺� �Է��� 5��(4��)�� �����͸� ����
--10, 20, 30, 40, 99 --> empno < 100, empno BETWEEN 10 AND 99
DELETE emp
WHERE empno < 100;

rollback;

DELETE emp
WHERE empno BETWEEN 10 AND 99;

SELECT *
FROM emp
WHERE empno BETWEEN 10 AND 99;

DELETE emp
WHERE empno IN (SELECT deptno FROM dept);

SELECT *
FROM emp
WHERE empno IN (SELECT deptno FROM dept);
commit;

SELECT *
FROM emp;

DELETE emp WHERE empno=9999;
commit;

--Ʈ�����
--brown
INSERT INTO dept values (99, 'ddit', 'daejeon');
SELECT *
FROM dept;

commit;

--LV1 --> LV3
SET TRANSACTION 
isolation LEVEL SERIALIZABLE;

--DML������ ���� Ʈ����ǽ���
INSERT INTO dept 
values (99, 'ddit', 'daejeon');

SELECT *
FROM dept;


--DDL : AUTO COMMIT , rollback�� �� �ȴ�
--CREATE

DROP TABLE RANGER_NEW;

CREATE TABLE ranger_new(
    ranger_no NUMBER,   --���� Ÿ��
    ranger_name VARCHAR2(50),--���� : [VARCHAR2], CHAR
    reg_dt DATE DEFAULT sysdate --DEFAULT : SYSDATE
);
desc ranger_new;

--ddl�� rollback�� ������� �ʴ´�
rollback;

INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000, 'brown');

SELECT *
FROM ranger_new;
commit;


--��¥ Ÿ�Կ��� Ư�� �ʵ尡������
--ex : sysdate���� �⵵�� ��������
SELECT TO_CHAR(sysdate, 'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, 
       TO_CHAR(reg_dt, 'MM'),
       EXTRACT(MONTH FROM reg_dt) mm,
       EXTRACT(YEAR FROM reg_dt) year,
       EXTRACT(day FROM reg_dt) day
FROM ranger_new;


--��������
--DEPT ����ؼ� DEPT_TEST ����
desc dept_test;
CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY, --deptno �÷��� �ĺ��ڷ� ����
    dname varchar2(14),           --�ĺ��ڷ� ������ �Ǹ� ���� �ߺ���
    loc varchar2(13)              --�ɼ� ������, null�� ���� ����
);

--primary key���� ���� Ȯ��
--1.deptno�÷��� null�� �� �� ����
--2.deptno�÷��� �ߺ��� ���� �� �� ����

INSERT INTO dept_test (deptno, dname, loc)
VALUES (null, 'ddit', 'daejeon');

INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2', 'daejeon');

ROLLBACK;

--����� ���� �������Ǹ��� �ο��� PRIMARY KEY
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

--TABLE CONSTRAINT 
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY (deptno, dname)
);

INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2', 'daejeon');

SELECT *
FROM dept_test;
ROLLBACK;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13)
);
INSERT INTO dept_test VALUES(1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(2, null, 'daejeon');

--UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);
INSERT INTO dept_test VALUES(1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(2, 'ddit', 'daejeon');
