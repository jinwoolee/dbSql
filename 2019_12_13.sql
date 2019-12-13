SELECT *
FROM emp_test
ORDER BY empno;

-- emp���̺� �����ϴ� �����͸� emp_test ���̺�� ����
-- ���� empno�� ������ �����Ͱ� �����ϸ� 
-- ename update : ename || '_merge'
-- ���� empno�� ������ �����Ͱ� ���� ���� �������
-- emp���̺��� empno, ename emp_test �����ͷ� insert

--emp_test �����Ϳ��� ������ �����͸� ����
DELETE emp_test
WHERE empno >= 7788;
COMMIT;

--emp ���̺��� 14���� �����Ͱ� ����
--emp_test ���̺��� ����� 7788���� ���� 7���� �����Ͱ� ����
--emp���̺��� �̿��Ͽ� emp_test ���̺��� �����ϰԵǸ�
--emp���̺��� �����ϴ� ���� (����� 7788���� ũ�ų� ���� ����) 7��
--emp_test�� ���Ӱ� insert�� �� ���̰�
--emp, emp_test�� �����ȣ�� �����ϰ� �����ϴ� 7���� �����ʹ�
--(����� 7788���� ���� ����)ename�÷��� ename || '_modify'��
--������Ʈ�� �Ѵ�

/*
MERGE INTO ���̺��
USING ������� ���̺�|VIEW|SUBQUUERY
ON (���̺��� ��������� �������)
WHEN MATCHED THEN
    UPDATE ....
WHEN NOT MATCHED THEN
    INSERT ....
*/

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (emp.empno, emp.ename);

SELECT *
FROM emp_test;


-- emp_test ���̺� ����� 9999�� �����Ͱ� �����ϸ�
-- ename�� 'brown'���� update
-- �������� ���� ��� empno, ename VALUES (9999, 'brown')���� insert
-- ���� �ó������� MERGE ������ Ȱ���Ͽ� �ѹ��� sql�� ����
-- :empno - 9999, :ename - 'brown'
MERGE INTO emp_test
USING dual
ON (emp_test.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = :ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (:empno, :ename);
   
SELECT *
FROM emp_test
WHERE empno=9999;

--���� merge ������ ���ٸ� (** 2���� SQL�� �ʿ�)
-- 1. empno = 9999�� �����Ͱ� ���� �ϴ��� Ȯ��
-- 2-1. 1�����׿��� �����Ͱ� �����ϸ� UPDATE
-- 2-2. 1�����׿��� �����Ͱ� �������� ������ INSERT

--GROUP_AD1
--�μ��� �޿� ��
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

--��ü ������ �޿� ��
SELECT SUM(sal)
FROM emp;

SELECT deptno, SUM(sal) --�μ���
FROM emp
GROUP BY deptno

UNION ALL

SELECT NULL, SUM(sal)  -- �Ѱ�
FROM emp;

-- JOIN ������� Ǯ��
-- emp ���̺��� 14�ǿ� �����͸� 28������ ����
-- ������(1 -14, 2-14)�� �������� group by
-- ������ 1 : �μ���ȣ �������� 14 row
-- ������ 2 : ��ü 14 row
SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp, (SELECT ROWNUM rn
           FROM dept
           WHERE ROWNUM <=2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);


SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp, (SELECT 1 rn FROM dual UNION ALL
           SELECT 2 FROM dual) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);


SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp, (SELECT LEVEL rn 
           FROM dual 
           CONNECT BY LEVEL <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);


--REPORT GROUP BY
--ROLLUP
--GROUP BY ROLLOUP(col1....)
--ROLLUP���� ����� �÷��� �����ʿ��� ���� ���� ����� 
--SUB GROUP�� �����Ͽ� �������� GROUP BY���� �ϳ��� SQL���� ���� �ǵ��� �Ѵ�
GROUP BY ROLLUP(job, deptno)
-- GROUP BY job, deptno
-- GROUP BY job
-- GROUP BY --> ��ü ���� ������� GROUP BY


--emp���̺��� �̿��Ͽ� �μ���ȣ��, ��ü������ �޿����� ���ϴ� ������
--ROLLUP ����� �̿��Ͽ� �ۼ�
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);

-- EMP ���̺��� �̿��Ͽ� job, deptno �� sal+comm �հ�
--                    job �� sal+comm �հ�
--                    ��ü������ sal+comm �հ�
-- ROLLUP�� Ȱ���Ͽ� �ۼ�
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno)
ORDER BY deptno, job;

--GROUP BY job, deptno
--GROUP BY job
--GROUP BY -->��ü ROW���


--ROLLUP�� �÷� ������ ��ȸ ����� ������ ��ģ��
GROUP BY ROLLUP(job, deptno);
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY -->��ü ROW���

GROUP BY ROLLUP(deptno, job);
--GROUP BY deptno, job
--GROUP BY deptno
--GROUP BY -->��ü ROW���



--GROUP_AD2
SELECT DECODE(GROUPING(job), 1, '�Ѱ�', job) job,
       deptno, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);


--GROUP_AD2_1
SELECT DECODE(GROUPING(job), 1, '��', job) job,
       CASE 
            WHEN deptno IS NULL AND job IS NULL THEN '��'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '�Ұ�'
            ELSE TO_CHAR(deptno)
       END deptno,
       
       SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);


--DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job), 1, '��', '�Ұ�'), deptno), 
/*
    if( GROUPING(deptno) == 1){
        if ( GROUPING(job) == 1 )
            return  '��'
        else
            return '�Ұ�')
    }
    else
        return deptno;
    

DECODE(GROUPING(deptno) + GROUPING(job), 2,  '��', 1 '�Ұ�', deptno)
    if( GROUPING(deptno) + GROUPING(job) == 2)
        return  '��'
    if( GROUPING(deptno) + GROUPING(job) == 1)
        return '�Ұ�'
    else
        return deptno;    
    
*/

SELECT DECODE(GROUPING(job), 1, '��', job) job,
       DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job), 1, '��', '�Ұ�'), deptno) deptno, 
       /*CASE 
            WHEN deptno IS NULL AND job IS NULL THEN '��'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '�Ұ�'
            ELSE TO_CHAR(deptno)
       END deptno,*/
       
       SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);


--GROUP_AD3
SELECT deptno, job, 
       SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(deptno, job);
--GROUP BY ROLLUP(job, deptno);

--UNION ALL�� ġȯ
SELECT deptno, job, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY deptno, job 
UNION ALL
SELECT deptno, null, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY deptno
UNION ALL
SELECT null, null, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp;


--GROUP_AD4
SELECT dept.dname, a.job, a.sal_sum
FROM 
    (SELECT deptno, job, 
           SUM(sal + NVL(comm, 0)) sal_sum
     FROM emp
     GROUP BY ROLLUP(deptno, job)) a, dept
WHERE a.deptno = dept.deptno(+);

--GROUP_AD5
SELECT NVL(dept.dname, '�Ѱ�') dname , a.job, a.sal_sum
FROM 
    (SELECT deptno, job, 
           SUM(sal + NVL(comm, 0)) sal_sum
     FROM emp
     GROUP BY ROLLUP(deptno, job)) a, dept
WHERE a.deptno = dept.deptno(+);








