--emp ���̺�, dept ���̺� ����
--4
SELECT *
FROM  dept;

UPDATE dept SET dname = 'MARKET SALES'
WHERE deptno != '30';

SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno=30;

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;


--natural join : ���� ���̺� ���� Ÿ��, �����̸��� �÷�����
--               ���� ���� ���� ��� ����
DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept b;

--oracle ����
SELECT a.deptno, empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;

--JOIN USING 
--join �Ϸ����ϴ� ���̺� ������ �̸��� �÷��� �ΰ� �̻��� ��
--join �÷��� �ϳ��� ����ϰ� ���� ��

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI JOIN with ON
--���� �ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ� ��
--�����ڰ� ���� ������ ���� ������ ��

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺� ����
--emp ���̺� ���� �Ҹ��� ���� : ������ ������ ���� ��ȸ
--������ ������ ������ ��ȸ
--�����̸�, �������̸�

--ANSI
--���� �̸�, ������ ����� �̸�, ������ ������� ����� �̸�
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

MILLER  CLARK  KING

--ORACLE
-- �����̸�, ������ ������ �̸�, ������ �������� ������ �̸�,
-- ������ �������� �������� �������̸�
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e, emp m, emp t, emp k
WHERE e.mgr = m.empno
AND m.mgr = t.empno
AND t.mgr = k.empno;

--�������̺��� ANSI JOIN�� �̿��� JOIN
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
     JOIN emp t ON ( m.mgr = t.empno)
     JOIN emp k ON ( t.mgr = k.empno);


--������ �̸���, �ش� ������ ������ �̸��� ��ȸ�Ѵ�
--�� ������ ����� 7369~7698�� ������ ������� ��ȸ









KING
    CLARK
        MILLER
    BLAKE
        TURNER
        JAMES
        ALLEN
        WARD
        MARTIN
    JONES
        FORD
            SMITH
        SCOTT
            ADMAS



