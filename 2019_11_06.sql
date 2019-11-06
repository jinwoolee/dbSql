--�׷��Լ�
--multi row function : �������� ���� �Է����� �ϳ��� ��� ���� ����
--SUM, MAX, MIN, AVG, COUNT
--GROUP BY col | express
--SELECT ������ GROUP BY ���� ����� COL, EXRPESS ǥ�� ����

--������ ���� ���� �޿� ��ȸ
-- 14���� ���� �Է����� �� �ϳ��� ����� ����
SELECT MAX(sal) max_sal
FROM emp;

--�μ����� ���� ���� �޿� ��ȸ
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno;

SELECT *
FROM dept;


--grp3
SELECT /*decode(deptno, 10, 'ACCOUNTING', 
                      20, 'RESEARCH', 
                      30, 'SALES', 
                      40, 'OPERATIONS', 
                                'DDIT') dname, */
                                deptno,
       MAX(sal) max_sal, MIN(sal) min_sal,ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal, COUNT(sal) count_sal,
       COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno;
                                
--grp4
SELECT to_char(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*)cnt
FROM emp
GROUP BY to_char(hiredate, 'YYYYMM');

SELECT to_char(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*)cnt
FROM emp
GROUP BY hiredate;

SELECT to_char(hiredate, 'yyyymm'), to_char(hiredate, 'YYYYMM')
FROM emp
ORDER BY hiredate;

--grp5
SELECT to_char(hiredate, 'YYYY') hire_yyyymm, COUNT(*)cnt
FROM emp
GROUP BY to_char(hiredate, 'YYYY')
ORDER BY to_char(hiredate, 'YYYY');

--grp6
SELECT COUNT(deptno) cnt, count(*) cnt
FROM dept;


--JOIN
--emp ���̺��� dname �÷��� ���� --> �μ���ȣ(deptno)�ۿ� ����
desc emp;

--emp���̺� �μ��̸��� �����Ҽ� �ִ� dname �÷� �߰�
ALTER TABLE emp ADD (dname VARCHAR2(14));

SELECT *
FROM emp;

/*10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON*/
UPDATE emp SET dname ='ACCOUNTING' WHERE DEPTNO=10;
UPDATE emp SET dname ='RESEARCH' WHERE DEPTNO=20;
UPDATE emp SET dname ='SALES' WHERE DEPTNO=30;
COMMIT;

SELECT dname, MAX(sal) max_sal
FROM emp
GROUP BY dname;

ALTER TABLE emp DROP COLUMN DNAME;

SELECT *
FROM emp;

--ansi natural join : ���̺��� �÷����� ���� �÷��� �������� JOIN
SELECT DEPTNO, ENAME, DNAME
FROM EMP NATURAL JOIN DEPT;

--ORACLE join
SELECT emp.empno, emp.ename, emp.deptno, dept.dname, dept.loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;


--ANSI JOING WITH USING
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept USING (deptno);

--from ���� ���� ��� ���̺� ����
--where���� �������� ���
--������ ����ϴ� ���� ���൵ �������
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.job ='SALESMAN'; --job�� SALES�� ����� ������� ��ȸ

--JOIN with ON (�����ڰ� ���� �÷��� on���� ���� ���)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF join : ���� ���̺��� ����
--emp���̺��� mgr ������ �����ϱ� ���ؼ� emp ���̺�� ������ �ؾ��Ѵ�
--a : ���� ����, b : ������
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno)
WHERE a.empno between 7369 AND 7698;

--oracle
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno;
--AND   a.empno between 7369 AND 7698;

select empno, ename, mgr
 from emp;

--non-equijoing (��� ������ �ƴѰ��)
SELECT *
FROM salgrade;

--������ �޿� �����????
SELECT empno, ename, sal
FROM emp;

SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal );

SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--non equi join
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno = 7369;

--JOIN0
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno in (7369, 7499, 7521);


--JOIN0_1
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND   emp.deptno in (10, 30);

SELECT empno, ename, deptno
FROM emp;

SELECT *
FROM dept;