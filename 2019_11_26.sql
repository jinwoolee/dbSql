SELECT ename, sal, deptno, 
       RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) d_rank,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) rown
FROM emp;


--ana1
SELECT empno, ename, sal, deptno, 
       RANK() OVER (ORDER BY sal DESC, empno) rank,
       DENSE_RANK() OVER (ORDER BY sal DESC, empno) d_rank,
       ROW_NUMBER() OVER (ORDER BY sal DESC, empno) rown
FROM emp;


--no_ana2
--�μ��� �ο���
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

SELECT ename, empno, emp.deptno, b.cnt
FROM emp, (SELECT deptno, COUNT(*) cnt
           FROM emp
           GROUP BY deptno ) b
WHERE emp.deptno = b.deptno
ORDER BY emp.deptno;


--�м��Լ��� ���� �μ��� ������ (COUNT)
SELECT ename, empno, deptno, 
       COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

--�μ��� ����� �޿� �հ�
--SUM �м��Լ�
SELECT ename, empno, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno) sum_sal
FROM emp;

--ana2
SELECT empno, ename, sal, deptno, /*�μ��� �޿���� �Ҽ��� ���ڸ�����*/
       ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) avg_sal
FROM emp;

--ana3
SELECT empno, ename, sal, deptno, /*�μ��� �޿��� ���� ���������� �޿�*/
       MAX(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;

--ana4
SELECT empno, ename, sal, deptno, /*�μ��� �޿��� ���� ���������� �޿�*/
       MIN(sal) OVER (PARTITION BY deptno) min_sal,
       MAX(sal) OVER (PARTITION BY deptno) max_sal
FROM emp;


--�μ��� �����ȣ�� ���� �������
--�μ��� �����ȣ�� ���� �������

--WINDOWING ��Ȯ��
SELECT empno, ename, deptno,
       FIRST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno) f_emp,
       LAST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno) l_emp
FROM emp;

--LAG (������)
--������
--LEAD (������)
--�޿��� ���������� ���� ������ �ڱ⺸�� �Ѵܰ� �޿��� ���� ����� �޿�,
--                          �ڱ⺸�� �Ѵܰ� �޿��� ���� ����� �޿�

SELECT empno, ename, sal, 
       LAG(sal) OVER (ORDER BY sal) lag_sal,
       LEAD(sal) OVER (ORDER BY sal) lead_sal
FROM emp;

--ana5
SELECT empno, ename, hiredate, sal, 
       LEAD(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

--ana6
SELECT empno, ename, job, hiredate, sal, 
       LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

SELECT a.empno, a.ename, a.sal, sum(b.sal) sal_sum
FROM 
(SELECT a.*, ROWNUM rn
FROM
    (SELECT empno, ename, sal
     FROM emp
     ORDER BY sal, empno) a) a, 
(SELECT a.*, ROWNUM rn
FROM
    (SELECT empno, ename, sal
     FROM emp
     ORDER BY sal, empno) a) b      
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal, a.empno;



--WINDOWING 
--UNBOUNDED PRECEDING : ���� ���� �������� �����ϴ� �����
--CURRENT ROW : ���� ��
--UNBOUNDED FOLLOWING : ���� ���� �������� �����ϴ� �����
--N(����) PRECEDING : ���� ���� �������� �����ϴ� N���� ��
--N(����) FOLLOWING : ���� ���� �������� �����ϴ� N���� ��

SELECT empno, ename, sal,
       SUM(sal) OVER (ORDER BY sal, empno 
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sum_sal,
       
       SUM(sal) OVER (ORDER BY sal, empno 
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) sum_sal2,
       
       SUM(sal) OVER (ORDER BY sal, empno 
       ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) sum_sal3
FROM emp;

--ana7
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno 
                      ORDER BY sal, empno
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
       FROM emp;

SELECT empno, ename, deptno, sal,
    SUM(sal) OVER (ORDER BY sal 
                   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) row_sum,
    SUM(sal) OVER (ORDER BY sal 
                   ROWS UNBOUNDED PRECEDING) row_sum2,
                   
    SUM(sal) OVER (ORDER BY sal 
                   RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) range_sum,
    SUM(sal) OVER (ORDER BY sal 
                   RANGE UNBOUNDED PRECEDING) range_sum2
FROM emp;

