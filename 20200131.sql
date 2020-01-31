-- ���� �⵵�� ¦�� ���а�, REG_DT �⵵�� ¦�� ������ �����ϸ� => �ǰ����� �����
-- ���� �⵵�� ¦�� ���а�, REG_DT �⵵�� ¦�� ������ �������� ������ => �ǰ����� ������
SELECT userid, usernm, reg_dt,
    CASE
        WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'),2)= MOD(TO_CHAR(reg_dt, 'YYYY'),2) THEN '�ǰ����� �����'
        ELSE '�ǰ����� ������'
    END
FROM users;

SELECT userid, usernm, reg_dt,
       MOD(TO_NUMBER(TO_CHAR(reg_dt, 'YYYY')), 2) hire,
       MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2),
       CASE 
            WHEN MOD(TO_NUMBER(TO_CHAR(reg_dt, 'YYYY')), 2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2)
                THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������' 
       END CONTACT_TO_DOCTOR,
       DECODE(MOD(TO_NUMBER(TO_CHAR(reg_dt, 'YYYY')), 2), 
                    MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2), '�ǰ����� �����', '�ǰ����� ������') con2
FROM users;


SELECT ename, deptno
FROM emp;

SELECT *
FROM dept;

-- JOIN �� ���̺��� �����ϴ� �۾�
-- JOIN ����
-- 1. ANSI ����
-- 2. ORACLE ����

-- Natural Join
-- �� ���̺� �÷����� ���� �� �ش� �÷����� ����(����)
-- emp, dept ���̺��� deptno ��� �÷��� ����
SELECT *
FROM emp NATURAL JOIN dept;

-- Natural join�� ���� ���� �ø�(deptno)�� ������(ex: ���̺��, ���̺� ��Ī)�� ������� �ʰ�
-- �÷��� ����Ѵ� ( dept.deptno --> deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

-- ���̺� ���� ��Ī�� ��밡��
SELECT e.empno, e.ename, d.dname, deptno
FROM emp e NATURAL JOIN dept d;

-- ORACLE JOIN
-- FROM ���� ������ ���̺� ����� ,�� �����Ͽ� �����Ѵ�
-- ������ ���̺��� ���� ������ WHERE���� ����Ѵ�
-- emp, dept ���̺� �����ϴ� deptno �÷��� [���� ��] ����
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

EXPLAIN PLAN FOR 
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

SELECT *
FROM TABLE(dbms_xplan.display);
Plan hash value: 4192419542

2-3-1-0 
---------------------------------------------------------------------------
| Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |      |    42 |  1764 |    10   (0)| 00:00:01 |
|   1 |  NESTED LOOPS      |      |    42 |  1764 |    10   (0)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| DEPT |     4 |    88 |     3   (0)| 00:00:01 |
|*  3 |   TABLE ACCESS FULL| EMP  |    11 |   220 |     2   (0)| 00:00:01 |
---------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - filter("EMP"."DEPTNO"<>"DEPT"."DEPTNO")
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
   

����Ŭ ������ ���̺� ��Ī;
SELECT e.empno, e.ename, d.dname, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;

ANSI : join with USING 
���� �Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ�������
�ϳ��� �÷����θ� ������ �ϰ��� �Ҷ�
�����Ϸ��� ���� �÷��� ���
emp, dept ���̺��� ���� �÷� : deptno;
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING(deptno);

JOIN WITH USING�� ORACLE�� ǥ���ϸ�?;
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

ANSI : JOIN WITH ON
���� �Ϸ����ϴ� ���̺��� �÷� �̸��� ���� �ٸ���;
SELECT emp.ename, dept.dname, emp.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

JOIN WITH ON --> ORACLE
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELF JOIN : ���� ���̺��� ����;
�� : emp ���̺��� �����Ǵ� ����� ������ ����� �̿��Ͽ�
������ �̸��� ��ȸ�Ҷ�;
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

����Ŭ �������� �ۼ�;
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

equal ���� : = 
non-euqal ���� : !=, >, <, BETWEEN AND ;

����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ�
�ش����� �޿� ����� ���غ���;
SELECT ename, sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal 
                  AND salgrade.hisal;

ANSI ������ �̿��Ͽ� ���� ���� ���� �ۼ�;
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E JOIN SALGRADE S ON ( E.SAL BETWEEN S.LOSAL AND S.HISAL);


JOIN0;
SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY deptno;

JOIN0_1
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.deptno !=20
ORDER BY deptno;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.deptno IN (10, 30)
ORDER BY deptno;

JOIN0_2;
SELECT e.ename, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal > 2500;

JOIN0_3;
SELECT e.ename, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.sal > 2500
AND e.empno > 7600;

JOIN0_4;
SELECT e.ename, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.sal > 2500
AND e.empno > 7600
AND d.dname = 'RESEARCH';

PROD : PROD_LGU
LPROD : LPROD_GU;

SELECT *
FROM prod;

SELECT *
FROM lprod;

JOIN1;
PROD : PROD_LGU
LPROD : LPROD_GU;

JOIN2;
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

