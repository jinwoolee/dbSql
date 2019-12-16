-- GROUPING SETS(col1, col2)
-- ������ ����� ����
-- �����ڰ� GROUP BY�� ������ ���� ����Ѵ�
-- ROLLUP�� �޸� ���⼺�� ���� �ʴ´�
-- GROUPING SETS(col1, col2) = GROUPING SETS(col2, col1)

-- GROUP BY col1
-- UNION ALL
-- GROUP BY col2

-- emp ���̺��� ������ job(����)�� �޿�(sal)+��(comm)��,
--                    deptno(�μ�)�� �޿�(sal)+��(comm)�� ���ϱ�
--���� ���(GROUP FUNCTION) : 2 ���� SQL �ۼ� �ʿ�(UNION / UNION ALL)
SELECT job, null deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job
UNION ALL
SELECT '', deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno;

-- GROUPING SETS ������ �̿��Ͽ� ���� SQL�� ���տ����� ������� �ʰ�
-- ���̺��� �ѹ� �о ó��
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

-- job, deptno�� �׷����� �� sal+comm ��
-- mgr�� �׷����� �� sal+comm ��
-- GROUP BY job, deptno
-- UNION ALL
-- GROUP BY mgr
-- --> GROUPING SETS((job, deptno), mgr)
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum,
       GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

-- CUBE (col1, col2 ...)
-- ������ �÷��� ��� ������ �������� GROUP BY subset�� �����
-- CUBE�� ������ �÷��� 2���� ��� : ������ ���� 4��
-- CUBE�� ������ �÷��� 3���� ��� : ������ ���� 8��
-- CUBE�� ������ �÷����� 2�� ������ �� ����� ������ ���� ������ �ȴ� (2^n)
-- �÷��� ���ݸ� �������� ������ ������ ���ϱ޼������� �þ� ���� ������
-- ���� ��������� �ʴ´�

-- job, deptno�� �̿��Ͽ� CUBE ����
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
-- job, deptno
-- 1,   1   --> GROUP BY job, deptno
-- 1,   0   --> GROUP BY job
-- 0,   1   --> GROUP BY deptno
-- 0,   0   --> GROUP BY  --emp ���̺��� ����࿡ ���� GROUP BY

-- GROUP BY ����
-- GROUP BY, ROLLUP, CUBE�� ���� ����ϱ�
-- ������ ������ �����غ��� ���� ����� ������ �� �ִ�
-- GROUP BY job, rollup(deptno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);


SELECT job, SUM(sal)
FROM emp
GROUP BY job;














SELECT *
FROM emp
WHERE deptno=10;


UPDATE dept_test SET (�μ��� �ο���..�������� WHERE = ??);

--sub_a1
CREATE TABLE dept_test AS
SELECT *
FROM dept;

SELECT *
FROM dept_test;

ALTER TABLE dept_test ADD (empcnt NUMBER);

--deptno=10 --> empcnt=3, 
--deptno=20 --> empcnt=5, 
--deptno=30 --> empcnt=6, 
UPDATE dept_test SET empcnt = 
                (SELECT COUNT(*)
                 FROM emp
                 WHERE emp.deptno = dept_test.deptno);
                 
                 
SELECT *
FROM dept_test;
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

-- ��ü : 10, 20, 30, 40, 98, 99
-- ���� : 40, 98, 99
SELECT *
FROM dept_test
WHERE deptno NOT IN (10, 20, 30);

SELECT deptno
FROM emp
GROUP BY deptno;

DELETE dept_test
WHERE deptno NOT IN ( 10, 20 ,30);

DELETE dept_test
WHERE deptno NOT IN ( 10, 10, 20, 30, 30, 20 ,30);

DELETE dept_test
WHERE deptno NOT IN (
    SELECT deptno
    FROM emp);

DELETE dept_test
WHERE deptno NOT IN (
    SELECT deptno
    FROM emp
    GROUP BY deptno);
ROLLBACK;
SELECT *
FROM dept_test;


-- 10, 20, 30
SELECT deptno
FROM emp
GROUP BY deptno;

--sub_ad3
UPDATE emp_test SET sal = sal + 200
WHERE sal < (SELECT ROUND(AVG(sal), 2)
             FROM emp
             WHERE deptno = emp_test.deptno);
             
SELECT ROUND(AVG(sal), 2)
FROM emp
WHERE deptno = 30;

SELECT empno, ename, deptno, sal
FROM emp_test
ORDER BY deptno;

SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
ORDER BY deptno;


-- MERGE ������ �̿��� ������Ʈ
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno) b
ON ( a.deptno = b.deptno)
WHEN MATCHED THEN
    UPDATE SET sal = sal + 200
    WHERE a.sal < b.avg_sal;
ROLLBACK;

MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno) b
ON ( a.deptno = b.deptno)
WHEN MATCHED THEN
    UPDATE SET sal = CASE 
                        WHEN a.sal < b.avg_sal THEN sal + 200
                        ELSE sal
                     END;
    











