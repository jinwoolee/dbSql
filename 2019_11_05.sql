-- ��� �Ķ���Ͱ� �־����� �� �ش����� �ϼ��� ���ϴ� ����
-- 201911 --> 30 / 201912  --> 31

--�Ѵ� ������ �������� ���� = �ϼ�
--��������¥ ������ --> DD �� ����
SELECT :yyyymm
as param, TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') dt
FROM DUAL;


desc emp;

explain plan for
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    37 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    37 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
Predicate Information (identified by operation id):
---------------------------------------------------
   1 - filter(TO_CHAR("EMPNO")='7369');
   

SELECT empno, ename, sal, TO_CHAR(sal, 'l000999,999.99') sal_fmt
FROM emp;

--function null
--nvl(col1, col1�� null�� ��� ��ü�� ��)
SELECT empno, ename, sal, comm, nvl(comm, 0) nvl_comm,
       sal + comm, 
       sal + nvl(comm, 0),  
       nvl(sal + comm, 0)
FROM emp;

--NVL2(col1, col1�� null�� �ƴ� ��� ǥ���Ǵ� ��, col1 null�� ��� ǥ�� �Ǵ� ��)
SELECT empno, ename, sal, comm, NVL2(comm, comm, 0) + sal
FROM emp;

--NULLIF(expr1, expr2)
--expr1 == expr2 ������ null 
--else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

--COALESCE(expr1, expr2, expr3....)
--�Լ� ������ null�� �ƴ� ù��° ����
SELECT empno, ename, sal, comm, coalesce(comm, sal)
FROM emp;

--fn4
SELECT empno, ename, mgr, nvl(mgr, 9999) mgr_n,
                          nvl2(mgr, mgr, 9999) mgr_n,
                          coalesce(mgr, 9999) mgr_n
FROM emp;

--fn5
select userid, usernm, reg_dt, nvl(reg_dt, sysdate) n_reg_dt
from users;

--case when
SELECT empno, ename, job, sal,
       case
            when job = 'SALESMAN' then sal*1.05
            when job = 'MANAGER' then sal*1.10
            when job = 'PRESIDENT' then sal*1.20
            else sal
       end case_sal,
       DECODE(job, 'SALESMAN', sal*1.05, 
                   'MANAGER', sal*1.10,
                   'PRESIDENT', sal*1.20,
                                         sal) decode_sal
FROM emp;

--decode(col, search1, return1, search2, return2..... dafult)
SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal*1.05, 
                   'MANAGER', sal*1.10,
                   'PRESIDENT', sal*1.20,
                                         sal) decode_sal
FROM emp;


--cond1
SELECT empno, ename, decode(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS', 'DDIT') dname
FROM emp;

--cond2
SELECT empno, ename, hiredate, 
    CASE WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2)
            THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
    END contact_to_doctor
FROM emp;

SELECT userid, usernm, alias, reg_dt, decode(mod(to_char(reg_dt, 'yyyy') , 2), MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), '�ǰ����� �����',  '�ǰ����� ������') contactToDoctor
FROM users
where userid in ('brown', 'cony', 'james', 'moon', 'sally');


SELECT empno, ename, hiredate, decode(mod(to_char(hiredate, 'yyyy') , 2), MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), '�ǰ����� �����', '�ǰ����� ������') contactToDoctor
FROM emp;

SELECT empno, ename, hiredate, case when mod(to_char(hiredate, 'yyyy') , 2) = MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) then  '�ǰ����� �����'
                                    ELSE '�ǰ�����  ������'
                               end contactToDoctor
FROM emp;



SELECT userid, usernm, alias, reg_dt, decode(mod(to_char(reg_dt, 'yyyy') , 2), MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), '�ǰ����� �����',  '�ǰ����� ������') contactToDoctor
FROM users
where userid in ('brown', 'cony', 'james', 'moon', 'sally');

--�� �ؼ��� ¦���ΰ�? Ȧ���ΰ�?
--1.���� �⵵ ���ϱ� (DATE --> TO_CHAR(DATE, FORMAT))
--2.���� �⵵�� ¦������ ���
--  ����� 2�� ������ �������� �׻� 2���� �۴�
--  2�� ������� �������� 0, 1
-- MOD(���, ������)
SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM DUAL;

--emp ���̺��� �Ի����ڰ� Ȧ�������� ¦�������� Ȯ��
SELECT empno, ename, hiredate, 
       case 
        when MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2)
            then '�ǰ����� ���'
            else   '�ǰ����� ����'
       end contact_to_doctor 
FROM emp;

--cond3
SELECT userid, usernm, reg_dt, 
       case 
        when MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(reg_dt, 'YYYY'), 2)
            then '�ǰ����� ���'
            else   '�ǰ����� ����'
       end contact_to_doctor 
FROM users;



--�׷��Լ� ( AVG, MAX, MIN, SUM, COUNT )
--�׷��Լ��� NULL���� ����󿡼� �����Ѵ�
--SUM(comm), COUNT(*), COUNT(mgr)
--������ ���� ���� �޿��� �޴»���� �޿�
--������ ���� ���� �޿��� �޴»���� �޿�
--������ �޿� ��� (�Ҽ��� ��°�ڸ� ������ ������ --> �Ҽ��� 3°�ڸ����� �ݿø�)
--������ �޿� ��ü��
--������ ��
SELECT MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp;

--�μ��� ���� ���� �޿��� �޴»���� �޿�
--GROUP BY ���� ������� ���� �÷��� SELECT ���� ����� ��� ����
SELECT deptno, 'test', 1, MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp
GROUP BY deptno;


--�μ��� �ִ� �޿�
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) > 3000;

--grp1
SELECT MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(sal) count_sal,
       COUNT(mgr) count_mgr,
       COUNT(*) count_all
FROM emp;

--grp2
SELECT deptno, MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(sal) count_sal,
       COUNT(mgr) count_mgr,
       COUNT(*) count_all
FROM emp
GROUP BY deptno;
 
 
 
 
 
 
SELECT empno, ename, sal
FROM emp
order by sal;

