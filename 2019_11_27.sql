--con1
--CASE 
--  WHEN condition THEN return1
--END
--DECODE(col|expr, search1, return1, search2, return2...., default)
DESC emp;
SELECT empno, ename, 
       CASE 
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
       END dname,
       DECODE(deptno, 10, 'ACCOUNTING',
                      20,'RESEARCH',  
                      30,'SALES',
                      40,'OPERATIONS',
                                      'DDIT')dname2
FROM emp;


--cond2
--�ǰ����� ����� ��ȸ ����
--1. ���س⵵�� ¦��/Ȧ���� ����
--2. hiredate���� �Ի�⵵�� ¦��/Ȧ�� ����

--1. TO_CHAR(SYSDATE, 'YYYY')
--> ���س⵵ ���� ( 0:¦����, 1:Ȧ����)
SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM dual;

--2. 
--���⵵ �ǰ����� ����ڸ� ��ȸ�ϴ� ������ �ۼ��غ�����
--2020�⵵
SELECT empno, ename,
       CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 
                 MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
            THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
       END contact_to_doctor
FROM emp;

--2020�⵵
SELECT empno, ename, hiredate,
       CASE
            WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 
                 MOD(TO_CHAR(SYSDATE, 'YYYY')+1, 2)
            THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
       END contact_to_doctor
FROM emp;

--cond3
SELECT a.userid, a.usernm, a.alias, a.reg_dt,
       DECODE( mod(a.yyyy, 2), mod(a.this_yyyy, 2), '�ǰ��������', '�ǰ���������') contacttotocdotr
FROM
    (SELECT userid, usernm, alias, reg_dt, TO_CHAR(reg_dt, 'YYYY') yyyy,
           TO_CHAR(SYSDATE, 'YYYY') this_yyyy
     FROM users) a;


--GROUP FUNCTION
--Ư�� �÷��̳�, ǥ���� �������� �������� ���� ������ ����� ����
--COUNT-�Ǽ�, SUM-�հ�, AVG-���, MAX-�ִ밪, MIN-�ּҰ�
--��ü ������ ������� (14���� -> 1��)
DESC emp;
SELECT MAX(sal) max_sal, --���� ���� �޿�
       MIN(sal) min_sal, --���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, --�� ������ �޿� ���
       SUM(sal) sum_sal,  -- �� ������ �޿� �հ�
       COUNT(sal) count_sal, -- �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --������ ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row    --Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������
FROM emp;


--�μ���ȣ�� �׷��Լ� ����
SELECT deptno,
       MAX(sal) max_sal, --�μ����� ���� ���� �޿�
       MIN(sal) min_sal, --�μ����� ���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, --�μ� ������ �޿� ���
       SUM(sal) sum_sal,  -- �μ� ������ �޿� �հ�
       COUNT(sal) count_sal, -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --�μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row    --�μ��� �������� 
FROM emp
GROUP BY deptno;

SELECT deptno, ename,
       MAX(sal) max_sal, --�μ����� ���� ���� �޿�
       MIN(sal) min_sal, --�μ����� ���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, --�μ� ������ �޿� ���
       SUM(sal) sum_sal,  -- �μ� ������ �޿� �հ�
       COUNT(sal) count_sal, -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --�μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row    --�μ��� �������� 
FROM emp
GROUP BY deptno, ename;

--SELECT ������ GROUP BY ���� ǥ���� �÷� �̿��� �÷��� �� �� ����
--�������� ������ ���� ����(�������� ���� ������ �Ѱ��� �����ͷ� �׷���)
--�� ���������� ��������� SELECT ���� ǥ���� ����
SELECT deptno, 1, '���ڿ�', SYSDATE, 
       MAX(sal) max_sal, --�μ����� ���� ���� �޿�
       MIN(sal) min_sal, --�μ����� ���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, --�μ� ������ �޿� ���
       SUM(sal) sum_sal,  -- �μ� ������ �޿� �հ�
       COUNT(sal) count_sal, -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --�μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row    --�μ��� �������� 
FROM emp
GROUP BY deptno;

--�׷��Լ������� NULL �÷��� ��꿡�� ���ܵȴ�
--emp���̺��� comm�÷��� null�� �ƴ� �����ʹ� 4���� ����, 9���� NULL)
SELECT COUNT(comm) count_comm, --NULL�� �ƴ� ���� ���� 4
       SUM(comm) sum_comm,    --NULL���� ����, 300+500+1400+0= 2200
       SUM(sal) sum_sal,    --NULL���� ����, 300+500+1400+0= 2200
       SUM(sal + comm) tot_sal_sum,
       SUM(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;


--WHERE ������ GROUP �Լ��� ǥ�� �� �� ����
--1. �μ��� �ִ� �޿� ���ϱ�
--2. �μ��� �ִ� �޿� ���� 3000�� �Ѵ� �ุ ���ϱ�
--deptno, �ִ�޿�
SELECT deptno, MAX(sal) m_sal
FROM emp
WHERE MAX(sal) >= 3000 --ORA-00934 WHERE ������ GROUP �Լ��� �� �� ����
GROUP BY deptno;

SELECT deptno, MAX(sal) m_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;



--grp1,2 ���� �ǽ����� ��ü

--grp3
SELECT DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES') dname,
       MAX(sal) max_sal, --�μ����� ���� ���� �޿�
       MIN(sal) min_sal, --�μ����� ���� ���� �޿�
       ROUND(AVG(sal), 2) avg_sal, --�μ� ������ �޿� ���
       SUM(sal) sum_sal,  -- �μ� ������ �޿� �հ�
       COUNT(sal) count_sal, -- �μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --�μ� ������ ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row    --�μ��� �������� 
FROM emp
GROUP BY deptno
ORDER BY deptno;



--grp4
--1.hiredate �÷��� ���� YYYYMM �������� �����
-- date Ÿ���� ���ڿ��� ����(YYYYMM)
SELECT TO_CHAR(hiredate, 'YYYYMM')hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

SELECT hire_yyyymm, COUNT(*) cnt
FROM
    (SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm
     FROM emp )
GROUP BY hire_yyyymm;


SELECT hire_yyyymm, COUNT(*) cnt
FROM
    (SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm
     FROM emp )
GROUP BY hire_yyyymm;

--grp6
SELECT TO_CHAR(hiredate, 'YYYY')hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

SELECT COUNT(deptno) cnt
FROM
    (SELECT deptno, COUNT(*)cnt
     FROM emp
     GROUP BY deptno);


--grp6
--��ü ������ ���ϱ�(emp)
SELECT COUNT(*), COUNT(empno), COUNT(mgr)
FROM emp;

--��ü �μ��� ���ϱ�(dept)
DESC dept;
SELECT COUNT(*), COUNT(deptno), COUNT(loc)
FROM dept;

--grp7
--���� ���� �μ��� ���� ���ϱ�
SELECT COUNT(deptno)
FROM
(SELECT deptno
 FROM emp
 GROUP BY deptno);

SELECT COUNT(COUNT(*))
 FROM emp
 GROUP BY deptno;

SELECT COUNT(DISTINCT deptno)
FROM emp;

--JOIN
--1.���̺� ��������(�÷� �߰�)
--2.�߰��� �÷��� ���� update
--dname �÷��� emp ���̺� �߰�
DESC emp;
DESC dept;

--�÷��߰�(dname, VARCHAR2(14))
ALTER TABLE emp ADD (dname VARCHAR2(14));
DESC emp;

SELECT *
FROM emp;

UPDATE emp SET dname = CASE 
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                       END;
COMMIT;                       
                       
SELECT empno, ename, deptno, dname
FROM emp;

-- SALES --> MARKET SALES
-- �� 6���� ������ ������ �ʿ��ϴ�
-- ���� �ߺ��� �ִ� ����(�� ������)
UPDATE emp SET dname = 'MARKET SALES'
WHERE dname = 'SALES';

--emp ���̺�, dept ���̺� ����
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;



