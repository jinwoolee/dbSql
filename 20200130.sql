
-- decode, case를 혼용하여 다음 요구사항을 만족하는 쿼리 작성
-- emp 테이블에서 job 컬럼의 값이 SALMESMAN 이면서 sal가 1400보다 크면 SAL * 1.05 리턴
--                             SALMESMAN 이면서 sal가 1400보다 작으면 SAL * 1.1 리턴                                                           
--                             MANAGER 이면 SAL * 1.1 리턴
--                             PRESIDENT이면 SAL * 1.2 리턴
--                             그밖의 사람들은 SAL을 리턴

-- DECODE안에 CASE나 DECODE 구문이 중첩이 가능하다
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
-- 올해년도가 짝수이면
--    입사년도가 짝수일 때 건강검진 대상자
--    입사년도가 홀수일 때 건강검진 비대상자
-- 올해년도가 홀수이면
--    입사년도가 짝수일 때 건강검진 비대상자
--    입사년도가 홀수일 때 건강검진 대상자
SELECT empno, ename, hiredate,
       MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2) hire,
       MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2),
       CASE 
            WHEN MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2)
                THEN '건강검진 대상자'
            ELSE '건강검진 비대상자' 
       END CONTACT_TO_DOCTOR,
       DECODE(MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2), 
                    MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2), '건강검진 대상자', '건강검진 비대상자') con2
FROM emp;

-- 올해년도가 짝수인지, 홀수인 확인
-- DATE 타입 -> 문자열(여러가지 포맷, YYYY-MM-DD HH24:MI:SS)
-- 짝수-> 2로 나눴을때 나머지0
-- 홀수-> 2로 나눴을때 나머지1
SELECT MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2)
FROM dual;



-- GROUP BY 행을 묶을 기준
-- 부서번호가 같은 ROW 끼리 묶는 경우 : GROUP BY deptno
-- 담당업무가 같은 ROW 끼리 묶는 경우 : GROUP BY job
-- MGR가 같고 담당업무가 같은 ROW 끼리 묶는 경우 : GROUP BY mgr, job

-- 그룹함수의 종류
-- SUM : 합계
-- COUNT : 갯수 - NULL 값이 아닌 ROW의 갯수)
-- MAX : 최대값
-- MIN : 최소값
-- AVG : 평균

-- 그룹함수의 특징
-- 해당 컬럼에 Null값을 갖는 Row가 존재할 경우 해당 값은 무시하고 계산한다 (NULL 연산의 결과는 null)

-- 부서별 급여 합

-- 그룹함수 주의점
-- GROUP BY 절에 나온 컬럼이외의 다른컬럼이 SELECT절에 표현되면 에러
SELECT deptno, ename,
       SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal), 2), COUNT(sal)
FROM emp
GROUP BY deptno, ename;

-- GROUP BY 절이 없는 상태에서 그룹함수를 사용한 경우
-- --> 전체행을 하나의 행으로 묶는다
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal), 2), 
       COUNT(sal), -- sal 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(comm), -- COMM 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(*) -- 몇건의 데이터가 있는지
FROM emp;

-- GROUP BY의 기준이 empno이면 결과수가 몇건??
-- ㄱ룹화와 관련없는 임의의 문자열, 함수, 숫자등은 SELECT절에 나오는 것이 가능
SELECT 1, SYSDATE, 'ACCOUNTING', SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal), 2), 
       COUNT(sal), -- sal 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(comm), -- COMM 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(*) -- 몇건의 데이터가 있는지
FROM emp
GROUP BY empno;

-- SINGLE ROW FUNCTION의 경우 WHERE 절에서 사용하는 것이 가능하나
-- MULTI ROW FUNCTION(GROUP FUNCTION)의 경우 WHERE 절에서 사용하는 것이 불가능 하고
-- HAVING 절에서 조건을 기술한다

-- 부서별 급여 합 조회, 단 급여합이 9000이상인 row만 조회
-- deptno, 급여합
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


--grp1
SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, 
       SUM(sal) sum_sal,
       COUNT(sal)sal_count, -- sal 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(mgr)mgr_count, -- COMM 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(*)all_count -- 몇건의 데이터가 있는지
FROM emp;

--grp2
SELECT deptno, MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, 
       SUM(sal) sum_sal,
       COUNT(sal)sal_count, -- sal 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(mgr)mgr_count, -- COMM 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(*)all_count -- 몇건의 데이터가 있는지
FROM emp
GROUP BY deptno;

--grp3
SELECT DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES'),
       MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal, 
       SUM(sal) sum_sal,
       COUNT(sal)sal_count, -- sal 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(mgr)mgr_count, -- COMM 컬럼의 값이 null이 아닌 row의 갯수
       COUNT(*)all_count -- 몇건의 데이터가 있는지
FROM emp
GROUP BY DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES')
ORDER BY DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES');

--grp4
-- ORACLE 9i 이전까지는 GROUP BY절에 기술한 컬럼으로 정렬을 보장
-- ORACLE 10G 이후부터는 GROUP BY절에 기술한 컬럼으로 정렬을 보장 하지 않는다 (GROUP BY 연산시 속도UP)
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
-- 부서가 뭐가 있는지 : 10, 20, 30 --> 3개의 row가 존재
-- > 테이블의 row 수를 조회 : GROUP BY 없이 COUNT(*)
-- 배열, 포인터, 파일 입출력
-- GROUP BY, JOIN 
SELECT COUNT(*)
FROM
(SELECT deptno
 FROM emp
 GROUP BY deptno);