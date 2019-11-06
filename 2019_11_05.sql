-- 년월 파라미터가 주어졌을 때 해당년월의 일수를 구하는 문제
-- 201911 --> 30 / 201912  --> 31

--한달 더한후 원래값을 빼면 = 일수
--마지막날짜 구한후 --> DD 만 추출
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
--nvl(col1, col1이 null일 경우 대체할 값)
SELECT empno, ename, sal, comm, nvl(comm, 0) nvl_comm,
       sal + comm, 
       sal + nvl(comm, 0),  
       nvl(sal + comm, 0)
FROM emp;

--NVL2(col1, col1이 null이 아닐 경우 표현되는 값, col1 null일 경우 표현 되는 값)
SELECT empno, ename, sal, comm, NVL2(comm, comm, 0) + sal
FROM emp;

--NULLIF(expr1, expr2)
--expr1 == expr2 같으면 null 
--else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

--COALESCE(expr1, expr2, expr3....)
--함수 인자중 null이 아닌 첫번째 인자
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
            THEN '건강검진 대상자'
            ELSE '건강검진 비대상자'
    END contact_to_doctor
FROM emp;

SELECT userid, usernm, alias, reg_dt, decode(mod(to_char(reg_dt, 'yyyy') , 2), MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), '건강검진 대상자',  '건강검진 비대상자') contactToDoctor
FROM users
where userid in ('brown', 'cony', 'james', 'moon', 'sally');


SELECT empno, ename, hiredate, decode(mod(to_char(hiredate, 'yyyy') , 2), MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), '건강검진 대상자', '건강검진 비대상자') contactToDoctor
FROM emp;

SELECT empno, ename, hiredate, case when mod(to_char(hiredate, 'yyyy') , 2) = MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) then  '건강검진 대상자'
                                    ELSE '건강검진  비대상자'
                               end contactToDoctor
FROM emp;



SELECT userid, usernm, alias, reg_dt, decode(mod(to_char(reg_dt, 'yyyy') , 2), MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), '건강검진 대상자',  '건강검진 비대상자') contactToDoctor
FROM users
where userid in ('brown', 'cony', 'james', 'moon', 'sally');

--올 해수는 짝수인가? 홀수인가?
--1.올해 년도 구하기 (DATE --> TO_CHAR(DATE, FORMAT))
--2.올해 년도가 짝수인지 계산
--  어떤수를 2로 나누면 나머지는 항상 2보다 작다
--  2로 나눌경우 나머지는 0, 1
-- MOD(대상, 나눌값)
SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM DUAL;

--emp 테이블에서 입사일자가 홀수년인지 짝수년인지 확인
SELECT empno, ename, hiredate, 
       case 
        when MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2)
            then '건강검진 대상'
            else   '건강검진 비대상'
       end contact_to_doctor 
FROM emp;

--cond3
SELECT userid, usernm, reg_dt, 
       case 
        when MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(reg_dt, 'YYYY'), 2)
            then '건강검진 대상'
            else   '건강검진 비대상'
       end contact_to_doctor 
FROM users;



--그룹함수 ( AVG, MAX, MIN, SUM, COUNT )
--그룹함수는 NULL값을 계산대상에서 제외한다
--SUM(comm), COUNT(*), COUNT(mgr)
--직원중 가장 높은 급여를 받는사람의 급여
--직원중 가장 낮은 급여를 받는사람의 급여
--직원의 급여 평균 (소수점 둘째자리 까지만 나오게 --> 소수점 3째자리에서 반올림)
--직원의 급여 전체합
--직원의 수
SELECT MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp;

--부서별 가장 높은 급여를 받는사람의 급여
--GROUP BY 절에 기술되지 않은 컬럼이 SELECT 절에 기술될 경우 에러
SELECT deptno, 'test', 1, MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp
GROUP BY deptno;


--부서별 최대 급여
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

