-- GROUPING (cube, rollup ���� ���� �÷�)
-- �ش� �÷��� �Ұ� ��꿡 ���� ��� 1
-- ������ ���� ��� 0

--job �÷�
--case1. GROUPING(job)=1 AND GROUPING(deptno) = 1
--       job --> '�Ѱ�'
--case esle 
--       job --> job
SELECT CASE WHEN GROUPING(job) = 1 AND 
                 GROUPING(deptno) = 1 THEN '�Ѱ�'
            ELSE job 
       END job, 
       
       CASE WHEN GROUPING(job) = 0 AND 
                 GROUPING(deptno) = 1 THEN job ||' �Ұ�'
            ELSE TO_CHAR(deptno)
       END deptno,
       /*GROUPING(job), GROUPING(deptno), */sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

/*
GROUP BY job, deptno 
UNION ALL
GROUP BY job
UNION ALL
GROUP BY--��ü ������(�Ѱ�)
*/


--GROUP_AD3
SELECT deptno, job, sum(sal) sal
FROM emp
GROUP BY ROLLUP(deptno, job);
/*
GROUP BY deptno, job
UNION ALL
GROUP BY deptno
UNION ALL
GROUP BY 
*/


--CUBE (co1, col2...)
--CUBE ���� ������ �÷��� ������ ��� ���տ� ���� ���� �׷����� ����
--CUBE�� ������ �÷��� ���� ���⼺�� ����(rollup���� ����)
--GROUP BY CUBE(job, deptno)
--00 : GROUP BY job, deptno
--0X : GROUP BY job
--X0 : GROUP BY deptno
--XX : GROUP BY --��� �����Ϳ� ���ؼ�...

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE(job, deptno);


SELECT *
FROM emp;


--subquery�� ���� ������Ʈ
DROP TABLE emp_test;

--emp���̺��� �����͸� �����ؼ� ��� �÷��� �̿��Ͽ� emp_test���̺�� ����
CREATE TABLE emp_test AS
SELECT *
FROM emp;

--emp_test ���̺��� dept���̺��� �����ǰ��ִ� dname �÷�(VARCHAR2(14))�� �߰�
ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;

--emp_test���̺��� dname �÷��� dept���̺��� dname �÷� ������ ������Ʈ�ϴ� 
--���� �ۼ�

UPDATE emp_test SET dname = ( SELECT dname
                              FROM dept
                              WHERE dept.deptno = emp_test.deptno);
--WHERE empno IN (7369, 7499);
COMMIT;

--sub1
--DROP TABLE dept_test;
--CREATE TABLE dept_test AS
-- SELECT * FROM dept;


--empcnt NUMBER
ALTER TABLE dept_test ADD (empcnt NUMBER);


--10�� �μ��� �μ��� �� ���ϴ� ����
SELECT COUNT(*)
FROM emp
WHERE DEPTNO=20;

--dept_test���̺��� empcnt �÷��� emp���̺��� �̿��Ͽ�(subquery) update

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                                FROM emp
                                WHERE DEPTNO=dept_test.deptno);
SELECT *
FROM dept_test;
                              
SELECT COUNT(*)
FROM emp
WHERE DEPTNO=40;

SELECT *
FROM emp
WHERE DEPTNO=40;


--
SELECT *
FROM dept_test;
INSERT INTO dept_test VALUES (98, 'it', 'daejeon', 0);
INSERT INTO dept_test VALUES (99, 'it', 'daejeon', 0);



--����� ���� �μ����� ��ȸ
SELECT *
FROM DEPT
WHERE NOT EXISTS (SELECT 'X'
              FROM emp
              WHERE emp.deptno = dept.deptno);
              
DELETE DEPT_TEST
WHERE NOT EXISTS (SELECT 'X'
              FROM emp
              WHERE emp.deptno = dept.deptno);              
              
EXPLAIN PLAN FOR
DELETE DEPT_TEST
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);
                     
                     
SELECT *
FROM TABLE(dbms_xplan.display);
                     
SELECT *
FROM dept_test;
ROLLBACK;

DELETE DEPT_TEST
WHERE empcnt = (SELECT COUNT(*)
                FROM emp
                where EMP.DEPTNO = dept_test.deptno
                HAVING COUNT(*) = 0 );


                
                
                
                HAVING COUNT(*) = 0 );                

SELECT COUNT(*)
                  FROM emp
                  where EMP.DEPTNO = 98
                  --GROUP BY DEPTNO
                  HAVING COUNT(*) = 0  ;                 
                      

SELECT DEPTNO, COUNT(*)
FROM emp

GROUP BY DEPTNO;
                      
SELECT *
FROM dept_test;
WHERE deptno=10;
SELECT COUNT(*)
FROM emp
where EMP.DEPTNO = 10
GROUP BY DEPTNO;            


SELECT *
FROM emp_test;


--sub3
--�ڽ��� ���� �μ��� �޿� ��պ��� �����޿��� �޴� ��� ��ȸ
-- STEP1. 10�� �μ��� �޿� ��� ���ϱ�
SELECT *
FROM emp_test a
WHERE sal < 
        (SELECT AVG(sal)
        FROM emp_test b
        WHERE b.deptno=a.deptno);
        
UPDATE emp_test a SET sal = sal+200
WHERE sal < 
        (SELECT AVG(sal)
        FROM emp_test b
        WHERE b.deptno=a.deptno);    
        
--emp, emp_test empno�÷����� ���������� ��ȸ
--1.emp.empno, emp.ename, emp.sal, emp_test.sal
--2.emp.empno, emp.ename, emp.sal, emp_test.sal, 
--  �ش���(emp���̺� ����)�� ���� �μ��� �޿����




SELECT emp.empno, emp.ename, emp.sal, emp_test.sal, emp.deptno, a.sal_avg
FROM emp, emp_test,(SELECT deptno, ROUND(AVG(sal), 2) sal_avg FROM emp GROUP BY deptno) a
WHERE emp.empno = emp_test.empno
AND emp.deptno = a.deptno;










