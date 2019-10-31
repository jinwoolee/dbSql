--테이블에서 데이터 조회
/*
    SELECT 컬럼 | express (문자열상수) [as] 별칭
    FROM 데이터를 조회할 테이블(VIEW)
    WHERE 조건 (condition)
*/

DESC user_tables;

SELECT table_name, 
    'SELECT * FROM ' || table_name || ';' AS select_query
FROM user_tables
WHERE TABLE_NAME != 'EMP';
--전체건수 - 1


-- 숫자비교 연산
-- 부서번호가 30번 보다 크거나 같은 부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno >= 30;

--부서번호가 30번 보다 작은 부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno < 30;

--입사일자가 1982년 1월 1일 이후인 직원 조회
SELECT *
FROM emp
--WHERE hiredate < '82/01/01';
WHERE hiredate < TO_DATE('01011982', 'MMDDYYYY'); --11명(미국 날짜형식)
--WHERE hiredate < TO_DATE('19820101', 'YYYYMMDD'); --11명
--WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD'); --3명
--WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');

-- col BETWEEN X AND Y 연산
-- 컬럼의 값이 X 보다 크거나 같고, Y보다 작거나 같은 데이터
-- 급여(sal)가 1000보다 크거나 같고, 2000 보다 작거나 같은 데이터를 조회
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--위의 BETWEEN AND 연산자는 아래의 <=, >= 조합과 같다
SELECT *
FROM emp
WHERE sal >= 1000 
  AND sal <= 2000
  AND deptno = 30;


--where1
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND
                       TO_DATE('1983/01/01', 'YYYY/MM/DD');
                       
--where2
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD') 
  AND hiredate <= TO_DATE('1983/01/01', 'YYYY/MM/DD');

--IN 연산자
-- COL IN (values...)
-- 부서번호가 10 혹은 20인 직원 조회
SELECT *
FROM emp 
WHERE deptno in (10, 20);

--IN 연산자는 OR 연산자로 표현 할수 있다
SELECT *
FROM emp 
WHERE deptno = 10
   OR deptno = 20;

--where3
SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid in ('brown', 'cony', 'sally');

--COL LIKE 'S%'
--COL의 값이 대문자 S로 시작하는 모든 값
--COL LIKE 'S____'
--COL의 값이 대문자 S로 시작하고 이어서 4개의 문자열이 존재하는 값

--emp 테이블에서 직원이름이 S로 시작하는 모든 직원 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--where4
SELECT mem_id, mem_name
 FROM member
WHERE mem_name LIKE '신%';

--where5
SELECT mem_id, mem_name
 FROM member
WHERE mem_name LIKE '%이%'; --mem_name이 문자열안에 이로 시작하는 데이터
--WHERE mem_name LIKE '이%';  --mem_name이 이로 시작하는 데이터

--NULL 비교
--col IS NULL
--EMP 테이블에서 MGR 정보가 없는 사람(NULL) 조회
SELECT *
FROM emp
WHERE mgr IS NULL;
--WHERE MGR != null;    -- null 비교가 실패한다

--소속 부서가 10번이 아닌직원들
SELECT *
FROM emp
WHERE deptno != '10'; 

-- null 부정 연산
-- = , !=
-- is null , is not null

--where6
SELECT *
FROM emp
WHERE comm is not null;


--AND / OR
--관리자(mgr) 사번이 7698이고 급여가 1000 이상인 사람
SELECT *
FROM emp
WHERE mgr  = 7698
  AND sal >= 1000;

--emp 테이블에서 관리자(mgr) 사번이 7698 이거나
--    급여(sal)가 1000 이상인 직원 조회
SELECT *
FROM emp
WHERE mgr  = 7698
   OR sal >= 1000;  

--emp 테이블에서 관리자(mgr) 사번이 7698이 아니고, 7839가 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);  -- IN --> OR

--위의 쿼리를 AND/OR 연산자로 변환
SELECT *
FROM emp
WHERE mgr != 7698
  AND mgr != 7839;
  
--IN, NOT IN 연산자의 NULL 처리
--emp 테이블에서 관리자(mgr) 사번이 7698, 7839 또는 null이 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);

-- IN 연산자에서 결과값에 NULL이 있을 경우 의도하지 않은 동작을 한다
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
  AND mgr IS NOT NULL;
  
--where7
desc emp;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
  
SELECT *
FROM emp
WHERE job IN ( 'SALESMAN')
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--where8
SELECT *
FROM emp
WHERE deptno != 10 
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
  
--where9
SELECT *
FROM emp
WHERE deptno NOT IN (10)
--WHERE deptno != (10)
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');  
  
--where10
SELECT *
FROM emp
WHERE deptno in (20, 30)
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
  
--where11
SELECT *
FROM emp
WHERE job = 'SALESMAN'  --job IN ( 'SALESMAN' )
  OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--where12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  OR empno like '78%';



