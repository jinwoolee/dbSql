
-- decode, case�� ȥ���Ͽ� ���� �䱸������ �����ϴ� ���� �ۼ�
-- emp ���̺��� job �÷��� ���� SALMESMAN �̸鼭 sal�� 1400���� ũ�� SAL * 1.05 ����
--                             SALMESMAN �̸鼭 sal�� 1400���� ������ SAL * 1.1 ����                                                           
--                             MANAGER �̸� SAL * 1.1 ����
--                             PRESIDENT�̸� SAL * 1.2 ����
--                             �׹��� ������� SAL�� ����

-- DECODE�ȿ� CASE�� DECODE ������ ��ø�� �����ϴ�
SELECT ename, job, sal,
       DECODE(job, 'SALESMAN', CASE 
                                    WHEN sal > 1400 THEN sal * 1.05
                                    WHEN sal < 1400 THEN sal * 1.1
                               END,
                   'MANAGER', sal * 1.1,
                   'PRESIDENT', sal * 1.2,
                   sal) bonus_sal
                
FROM emp;



SELECT ename, job, sal, 
        CASE
            WHEN (job = 'SALESMAN' AND sal > 1400) THEN sal * 1.05
            WHEN (job = 'SALESMAN' AND sal < 1400) THEN sal * 1.1
        END sal,
        DECODE (job, 'MANAGER', sal * 1.1, 'PRESIDENT', sal * 1.2)
FROM emp;

--cond1
SELECT empno, ename, 
       DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS', 'DDIT') dname
FROM emp;

SELECT empno, ename, 
       CASE
            WHEN deptno=10 THEN 'ACCOUNTING'
            WHEN deptno=20 THEN 'RESEARCH'
            WHEN deptno=30 THEN 'SALES'
            WHEN deptno=40 THEN 'OPERATIONS'
            ELSE 'DDIT'
       END dname
FROM emp;

--cond2
-- ���س⵵�� ¦���̸�
--    �Ի�⵵�� ¦���� �� �ǰ����� �����
--    �Ի�⵵�� Ȧ���� �� �ǰ����� ������
-- ���س⵵�� Ȧ���̸�
--    �Ի�⵵�� ¦���� �� �ǰ����� ������
--    �Ի�⵵�� Ȧ���� �� �ǰ����� �����
SELECT empno, ename, hiredate,
       MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2) hire,
       MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2),
       CASE 
            WHEN MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2)
                THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������' 
       END CONTACT_TO_DOCTOR,
       DECODE(MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2), 
                    MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2), '�ǰ����� �����', '�ǰ����� ������') con2
FROM emp;

-- ���س⵵�� ¦������, Ȧ���� Ȯ��
-- DATE Ÿ�� -> ���ڿ�(�������� ����, YYYY-MM-DD HH24:MI:SS)
-- ¦��-> 2�� �������� ������0
-- Ȧ��-> 2�� �������� ������1
SELECT MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2)
FROM dual;



-- GROUP BY ���� ���� ����
-- �μ���ȣ�� ���� ROW ���� ���� ��� : GROUP BY deptno
-- �������� ���� ROW ���� ���� ��� : GROUP BY job
-- MGR�� ���� �������� ���� ROW ���� ���� ��� : GROUP BY mgr, job

-- �׷��Լ��� ����
-- SUM : �հ�
-- COUNT : ���� - NULL ���� �ƴ� ROW�� ����)
-- MAX : �ִ밪
-- MIN : �ּҰ�
-- AVG : ���

-- �׷��Լ��� Ư¡
-- �ش� �÷��� Null���� ���� Row�� ������ ��� �ش� ���� �����ϰ� ����Ѵ� (NULL ������ ����� null)

-- �μ��� �޿� ��

-- �׷��Լ� ������
-- GROUP BY ���� ���� �÷��̿��� �ٸ��÷��� SELECT���� ǥ���Ǹ� ����
SELECT deptno, ename,
       SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal), 2), COUNT(sal)
FROM emp
GROUP BY deptno, ename;

-- GROUP BY ���� ���� ���¿��� �׷��Լ��� ����� ���
-- --> ��ü���� �ϳ��� ������ ���´�
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal), 2), 
       COUNT(sal), -- sal �÷��� ���� null�� �ƴ� row�� ����
       COUNT(comm), -- COMM �÷��� ���� null�� �ƴ� row�� ����
       COUNT(*) -- ����� �����Ͱ� �ִ���
FROM emp;

-- GROUP BY�� ������ empno�̸� ������� ���??
-- ����ȭ�� ���þ��� ������ ���ڿ�, �Լ�, ���ڵ��� SELECT���� ������ ���� ����
SELECT 1, SYSDATE, 'ACCOUNTING', SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal), 2), 
       COUNT(sal), -- sal �÷��� ���� null�� �ƴ� row�� ����
       COUNT(comm), -- COMM �÷��� ���� null�� �ƴ� row�� ����
       COUNT(*) -- ����� �����Ͱ� �ִ���
FROM emp
GROUP BY empno;

-- SINGLE ROW FUNCTION�� ��� WHERE ������ ����ϴ� ���� �����ϳ�
-- MULTI ROW FUNCTION(GROUP FUNCTION)�� ��� WHERE ������ ����ϴ� ���� �Ұ��� �ϰ�
-- HAVING ������ ������ ����Ѵ�

-- �μ��� �޿� �� ��ȸ, �� �޿����� 9000�̻��� row�� ��ȸ
-- deptno, �޿���
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


--grp1
SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, 
       SUM(sal) sum_sal,
       COUNT(sal)sal_count, -- sal �÷��� ���� null�� �ƴ� row�� ����
       COUNT(mgr)mgr_count, -- COMM �÷��� ���� null�� �ƴ� row�� ����
       COUNT(*)all_count -- ����� �����Ͱ� �ִ���
FROM emp;

--grp2
SELECT deptno, MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, 
       SUM(sal) sum_sal,
       COUNT(sal)sal_count, -- sal �÷��� ���� null�� �ƴ� row�� ����
       COUNT(mgr)mgr_count, -- COMM �÷��� ���� null�� �ƴ� row�� ����
       COUNT(*)all_count -- ����� �����Ͱ� �ִ���
FROM emp
GROUP BY deptno;

--grp3
SELECT DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES'),
       MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, 
       SUM(sal) sum_sal,
       COUNT(sal)sal_count, -- sal �÷��� ���� null�� �ƴ� row�� ����
       COUNT(mgr)mgr_count, -- COMM �÷��� ���� null�� �ƴ� row�� ����
       COUNT(*)all_count -- ����� �����Ͱ� �ִ���
FROM emp
GROUP BY DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES')
ORDER BY DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES');

--grp4
-- ORACLE 9i ���������� GROUP BY���� ����� �÷����� ������ ����
-- ORACLE 10G ���ĺ��ʹ� GROUP BY���� ����� �÷����� ������ ���� ���� �ʴ´� (GROUP BY ����� �ӵ�UP)
SELECT TO_CHAR(hiredate, 'YYYYMM'), COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

--grp5
SELECT TO_CHAR(hiredate, 'YYYY'), COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

--grp6
SELECT COUNT(*) cnt
FROM dept;

--grp7
-- �μ��� ���� �ִ��� : 10, 20, 30 --> 3���� row�� ����
-- > ���̺��� row ���� ��ȸ : GROUP BY ���� COUNT(*)
-- �迭, ������, ���� �����
-- GROUP BY, JOIN 
SELECT COUNT(*)
FROM
(SELECT deptno
 FROM emp
 GROUP BY deptno);