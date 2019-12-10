--PRIMARY KEY ���� : UNIQUE + NOT NULL

UNIQUE : �ش� �÷��� ������ ���� �ߺ��� �� ����
         (EX : emp���̺��� empno(���)
               dept���̺��� deptno(�μ���ȣ))
        �ش� �÷��� null ���� ��� �� �� �ִ�
        
NOT NULL : ������ �Է½� �ش� �÷��� ���� �ݵ�� ���;� �Ѵ�        

--�÷������� PRIMARY KEY ���� ����  
--����Ŭ�� �������� �̸��� ���Ƿ� ���� (SYS-C000701)
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,

--����Ŭ ���������� �̸��� ������ ���    
--PRIMARY KEY : pk_���̺��
CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test  PRIMARY KEY,;
    
    
--PAIRWISE : ���� ����
--����� PRIMARY KEY  ���� ������ ��� �ϳ��� �÷��� ���������� ����
--���� �÷��� �������� PRIMARY KEY �������� ���� �� �� �ִ�
--�ش� ����� ���� �� ���� ���� ó�� �÷� ���������� ���� �� �� ����
--> TABLE LEVEL ���� ���ǻ���

--������ ������ dept_test ���̺� ����(drop)
DROP TABLE dept_test;

--�÷������� �ƴ�, ���̺� ������ �������� ����    
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13), --������ �÷� ������ �ĸ� ������ �ʱ�
    
    --deptno, dname �÷��� ������ ������(�ߺ���) �����ͷ� �ν�    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno, dname)
);    


--�μ���ȣ, �μ��̸� ���������� �ߺ� �����͸� ����
--�Ʒ� �ΰ��� insert ������ �μ���ȣ�� ������
--�μ����� �ٸ��Ƿ� ���� �ٸ� �����ͷ� �ν� --> INSERT ����
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');    
INSERT INTO dept_test VALUES(99, '���', '����');        

SELECT *
FROM dept_test;

--�ι�° INSERT ������ Ű���� �ߺ��ǹǷ� ����
INSERT INTO dept_test VALUES(99, '���', 'û��');        

--NOT NULL ��������
--�ش� �÷��� NULL���� ������ ���� ������ �� ���
--���� �÷����� �Ÿ��� �ִ�

--������ ������ dept_test ���̺� ����(drop)
DROP TABLE dept_test;

--�÷������� �ƴ�, ���̺� ������ �������� ����    
--dname �÷��� null ���� ������ ���ϵ��� NOT NULL ���� ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13)
);    

--deptno �÷��� primary key ���࿡ �ɸ��� �ʰ�
--loc �÷��� nullable�̱� ������ null ���� �Է� �� �� �ִ�
INSERT INTO dept_test VALUES(99, 'ddit', null);    

--deptno �÷��� priamry key ���࿡ �ɸ��� �ʰ�(�ߺ��� ���� �ƴϴϱ�)
--dname �÷��� NOT NULL ���������� ����
INSERT INTO dept_test VALUES(98, NULL, '����');

--
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    --deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    --dname VARCHAR2(14) NOT NULL,
    dname VARCHAR2(14) CONSTRAINT NN_dname NOT NULL,
    loc VARCHAR2(13)
);    
    

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    --CONSTRAINT pk_dept_test PRIMARY KEY (deptno, dname)
    --CONSTRAINT NN_dname NOT NULL (dname) : ������ �ʴ´�
);        
    
--1.�÷�����
--2.�÷����� �������� �̸� ���̱�
--3.���̺� ����
--[4.���̺� ������ �������� ����]
    
--UNIQUE ���� ����
--�ش� �÷��� ���� �ߺ��Ǵ� ���� ����
--�� null ���� ���
--GLOBAL solution�� ��� ������ ���� ���� ������ �ٸ��� ������
--PK ���ຸ�ٴ� UNIQUE ������ ����ϴ� ���̸�, ������ ���� ������
--APPLICATION �������� üũ �ϵ��� �����ϴ� ������ �ִ�
    
    
--���� ������ ���̺� ����(drop)    
DROP TABLE dept_test;

--�÷� ���� unique ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);            

--�ΰ��� insert ������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname �÷��� ����� UNIQUE ���࿡ ���� �ι�° ������ ����������
--����� �� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');
    
    

--���� ������ ���̺� ����(drop)    
DROP TABLE dept_test;

--�÷� ���� unique ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT IDX_U_dept_test_01 UNIQUE,
    loc VARCHAR2(13)
);            

--�ΰ��� insert ������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname �÷��� ����� UNIQUE ���࿡ ���� �ι�° ������ ����������
--����� �� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');    
    


--���� ������ ���̺� ����(drop)    
DROP TABLE dept_test;

--���̺� ���� unique ���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT IDX_U_dept_test_01 UNIQUE (dname)
);            

--�ΰ��� insert ������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname �÷��� ����� UNIQUE ���࿡ ���� �ι�° ������ ����������
--����� �� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');        



--FOREIGN KEY ��������
--�ٸ� ���̺� �����ϴ� ���� �Է� �� �� �ֵ��� ����

--emp_test.deptno -> dept_test.deptno �÷��� ���� �ϵ���
--FOREIGN KEY ���� ���� ����

--dept_test ���̺� ����(drop)
DROP TABLE dept_test;

--dept_test ���̺� ���� (deptno �÷� PRIMARY KEY ����)
--DEPT ���̺�� �÷��̸�, Ÿ�� �����ϰ� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13) );

INSERT INTO dept_test VALUES(99, 'DDIT', 'daejeon');
COMMIT;


DESC emp;
--empno, ename, deptno : emp_test
--empno PRIMARY KEY 
--deptno dept_test.deptno FOREIGN KEY

--�÷� ���� FOREIGN KEY
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test (deptno) );

--dept_test ���̺� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES(9999, 'brown', 99);

--dept_test ���̺� �������� �ʴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES(9998, 'sally', 98);



--emp_test ����
DROP TABLE emp_test;

--�÷� ���� FOREIGN KEY(�������� �� �߰�)
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test (deptno)  );

--dept_test ���̺� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES(9999, 'brown', 99);

--dept_test ���̺� �������� �ʴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES(9998, 'sally', 98);

DELETE dept_test
WHERE deptno=99;

--�μ������� �������
--��������ϴ� �μ���ȣ�� �����ϴ� ���������� 
--���� �Ǵ� deptno �÷��� NULLó��
--EMP -> DEPT


--���� ���̺� ����(DROP)
DROP TABLE emp_test;

--FOREIGN KEY OPTION -SET DELETE CASCADE
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test (deptno) ON DELETE CASCADE );

--dept_test ���̺� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES(9999, 'brown', 99);
COMMIT;

--������ �Է� Ȯ��
SELECT *
FROM emp_test;

--ON DELETE CASCADE �ɼǿ� ���� DEPT �����͸� ������ ���
--�ش� �����͸� ���� �ϰ� �ִ� EMP���̺��� ��� �����͵� �����ȴ�
DELETE dept_test
WHERE deptno=99;
ROLLBACK;




--���� ���̺� ����(DROP)
DROP TABLE emp_test;

--FOREIGN KEY OPTION -ON DELETE SET NULL
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test (deptno) ON DELETE SET NULL );

--dept_test ���̺� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES(9999, 'brown', 99);
COMMIT;

--������ �Է� Ȯ��
SELECT *
FROM emp_test;

--ON DELETE SET NULL �ɼǿ� ���� DEPT �����͸� ������ ���
--�ش� �����͸� ���� �ϰ� �ִ� EMP���̺��� DEPTNO �÷��� NULL�� ����
DELETE dept_test
WHERE deptno=99;
ROLLBACK;



--CHECK �������� 
--�÷��� ���� ���� ������ ��
--EX : �޿� �÷����� ���� 0���� ū ���� ������ üũ
--     ���� �÷����� ��/�� Ȥ�� F/M ���� ������ ����

--emp_test ���̺� ����(drop)
DROP TABLE emp_test;

--emp_test ���̺� �÷�
--empno NUMBER(4)
--ename VARCHAR2(10)
--sal NUMBER(7,2) --0���� ū���ڸ� �Է� �ǵ��� ����
--emp_gb VARCHAR2(2) --���� ���� 01-������, 02-����
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7, 2) CHECK (sal > 0),
    emp_gb VARCHAR2(2) CHECK (emp_gb IN ('01', '02') ) );

--emp_test ������ �Է�
--sal�÷� check ��������(sal >0)�� ���ؼ� ���� ���� �Է� �ɼ� ����
INSERT INTO emp_test VALUES (9999, 'brown', -1, '01');

--check �������� ���� ���� �����Ƿ� ���� �Է� (sal, emp_gb)
INSERT INTO emp_test VALUES (9999, 'brown', 1000, '01');

--emp_gb check���ǿ� ���� (emp_gb IN ('01', '02') )
INSERT INTO emp_test VALUES (9998, 'sally', 1000, '03');

--check �������� ���� ���� �����Ƿ� ���� �Է� (sal, emp_gb)
INSERT INTO emp_test VALUES (9998, 'sally', 1000, '02');

--���̺� ����
DROP TABLE emp_test;

--CHECK �������� �������� �̸� ����
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    --empno NUMBER(4) CONSTRAINT �������Ǹ� PRIMARY KEY,
    
    ename VARCHAR2(10),
    --sal NUMBER(7, 2) CHECK (sal > 0),
    sal NUMBER(7, 2) CONSTRAINT C_SAL CHECK (sal > 0),
    
    --emp_gb VARCHAR2(2) CHECK (emp_gb IN ('01', '02') ) 
    emp_gb VARCHAR2(2) CONSTRAINT C_EMP_GB 
                                CHECK (emp_gb IN ('01', '02') ) 
    );
    

--���̺� ����
DROP TABLE emp_test;

--table level CHECK �������� �������� �̸� ����
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7, 2),
    emp_gb VARCHAR2(2), 
    
    CONSTRAINT nn_ename CHECK (ename IS NOT NULL),
    CONSTRAINT C_SAL CHECK (sal > 0),
    CONSTRAINT C_EMP_GB CHECK (emp_gb IN ('01', '02') ) 
);    



--���̺� ���� : CREATE TABLE ���̺�� ( 
--                  �÷� �÷�Ÿ�� .....);

--���� ���̺��� Ȱ���ؼ� ���̺� �����ϱ�
-- Create Table AS : CTAS (��Ÿ��)
--      CREATE TABLE ���̺�� [(�÷�1, �÷�2, �÷�3...)] AS
--       SELECT col1, col2..
--       FROM �ٸ� ���̺��
--       WHERE ����

--emp_test ���̺� ����(drop)
DROP TABLE emp_test;

--emp���̺��� �����͸� �����ؼ� emp_test ���̺��� ����
CREATE TABLE emp_test AS
    SELECT *
    FROM emp;

SELECT *
FROM emp_test
INTERSECT
SELECT *
FROM emp;

emp-emp_test =������
emp_test-emp =������;
SELECT *
FROM emp
MINUS
SELECT *
FROM emp_test;
    


--emp_test ���̺� ����(drop)
DROP TABLE emp_test;

--emp���̺��� �����͸� �����ؼ� emp_test ���̺��� �÷����� �����Ͽ� ����
CREATE TABLE emp_test (c1, c2, c3, c4, c5, c6, c7, c8) AS
    SELECT *
    FROM emp;

SELECT *
FROM emp_test;

--emp_test ���̺� ����
DROP TABLE emp_test;

--�����ʹ� �����ϰ� ���̺��� ��ü(�÷� ����)�� �����Ͽ� ���̺� ����
CREATE TABLE emp_test AS
    SELECT *
    FROM emp
    WHERE 1=2;
SELECT *
FROM emp_test;

CREATE TABLE emp_20191209 AS
SELECT *
FROM emp;


--emp_test ���̺� ����
DROP TABLE emp_test;

--empno, ename, deptno �÷����� emp_test ����
CREATE TABLE emp_test AS
    SELECT empno, ename, deptno
    FROM emp
    WHERE 1=2;

--emp_test ���̺� �ű� �÷� �߰� 
-- HP VARCHAR2(20) DEFAULT '010'
--ALTER TABLE ���̺�� ADD (�÷��� �÷� Ÿ�� [default value]);
ALTER TABLE emp_test ADD (hp VARCHAR2(20) DEFAULT '010');

--���� �÷� ����
--ALTER TABLE ���̺�� MODIFY (�÷� �÷� Ÿ�� [default value]);
--hp �÷��� Ÿ���� VARCHAR2(20) -> VARCHAR2(30)
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));

--���� emp_test ���̺� �����Ͱ� ���� ������ �÷� Ÿ���� �����ϴ� ����
--�����ϴ�
--hp �÷��� Ÿ���� VARCHAR2(30) -> NUMBER
ALTER TABLE emp_test MODIFY (hp NUMBER);
DESC emp_test;

--�÷��� ����
--�ش� �÷��� PK, UNIQUE, NOT NULL, CHECK���� ���ǽ� ����� �÷���
--�� ���ؼ��� �ڵ������� ������ �ȴ�
--hp �÷� hp_n 
--ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO �����÷���;
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;
DESC emp_test;

--�÷� ����
--ALTER TABLE ���̺�� DROP (�÷�);
--ALTER TABLE ���̺�� DROP COLUMN �÷�;
--hp_n �÷� ����
ALTER TABLE emp_test DROP ( hp_n);
ALTER TABLE emp_test DROP COLUMN hp_n;

--���� ���� �߰�
--ALTER TABLE ���̺�� ADD   --���̺� ���� �������� ��ũ��Ʈ
--emp_test���̺��� empno�÷��� PK �������� �߰�
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test
                                        PRIMARY KEY(empno);
--���� ���� ����
--ALTER TABLE ���̺�� DROP CONSTRAINT ���������̸�;
--emp_test ���̺��� PRIMARY KEY ���������� pk_emp_test ���� ����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

--���̺� �÷�, Ÿ�� ������ ���������γ��� ����
--���̺��� �÷� ������ �����ϴ� ���� �Ұ����ϴ�
--empno, ename, job  --> empno, job, ename

DROP TABLE emp_test;
CREATE TABLE emp_test AS
SELECT *
FROM emp
ORDER BY job ASC;

SELECT 'ALTER TABLE ' || TABLE_NAME || ' DROP CONSTRAINT ' || CONSTRAINT_NAME || ';'
FROM USER_CONSTRAINTS
WHERE TABLE_NAME ='PROD';

ALTER TABLE PROD DROP CONSTRAINT SYS_C007009;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007010;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007011;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007012;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007013;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007014;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007015;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007016;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007017;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007018;
ALTER TABLE PROD DROP CONSTRAINT SYS_C007019;
ALTER TABLE PROD DROP CONSTRAINT PK_PROD_ID;
ALTER TABLE PROD DROP CONSTRAINT FR_PROD_LGU;
ALTER TABLE PROD DROP CONSTRAINT FR_PROD_BUYER;
