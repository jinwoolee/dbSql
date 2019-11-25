SELECT *
FROM emp
WHERE deptno IN (20, 30)    --20, 30
AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--where12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

--where13 (LIKE연산을 사용하지 말아라)
--전제조건 : EMPNO가 숫자여야된다 (DESC emp.empno NUMBER )
DESC emp;
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno BETWEEN 7800 AND 7899;



--연산자 우선순위 (AND > OR)
--직원 이름이 SMITH 이거나, 직원이름이 ALLEN이면서 역할이 SALESMAN인 직원
SELECT *
FROM emp
WHERE ename = 'SMITH'
OR ename = 'ALLEN'
AND job  = 'SALESMAN';

SELECT *
FROM emp
WHERE ename = 'SMITH'
OR (ename = 'ALLEN' AND job  = 'SALESMAN');

--직원이름이 SMITH 이거나 ALLEN 이면서 역할이 SALESMAN인 사람
SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN' )
AND job  = 'SALESMAN';

--where14
--job이 SALESMAN 이거나 사원번호가 78로 시작하면서, 입사일자가 1981년6월 1일 이후
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR (empno BETWEEN 7800 AND 7899 AND
    hiredate > TO_DATE('19810601', 'YYYYMMDD') );


SELECT *
FROM emp
WHERE (job = 'SALESMAN' OR empno BETWEEN 7800 AND 7899)
AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--데이터 정렬
--10, 5, 3, 2, 1

--오름차순 : 1, 2, 3, 5, 10
--내림차순 : 10, 5, 3, 2, 1

--오름차순 : ASC (표기를 안할경우 기본값)
--내림차순 : DESC (내림차순시 반드시 표기)

/*
    SELECT col1, col2, ......
    FROM 테이블명
    WHERE col1 = '값'
    ORDER BY 정렬기준컬럼1 [ASC / DESC], 정렬기준컬럼2.... [ASC / DESC]
*/
--사원(emp) 테이블에서 직원의 정보를 직원 이름(ename) 으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
ORDER BY ename ASC; --정렬기준을 작성하지 않을 경우 오름차순 적용

--사원(emp) 테이블에서 직원의 정보를 직원 이름(ename) 으로 내림차순 정렬
SELECT *
FROM emp
ORDER BY ename DESC;

--사원(emp) 테이블에서 직원의 정보를 부서번호로 오름차순(ASC) 정렬하고
--부서번호가 같을 때는 sal 내림차순(DESC) 정렬
--급여(sal)가 같을때는 이름으로 오름차순(ASC) 정렬 한다.
SELECT *
FROM emp
ORDER BY deptno, sal DESC, ename ;

--정렬 컬럼을 ALIAS로 표현
SELECT deptno, sal, ename nm
FROM emp
ORDER BY nm;

--조회하는 컬럼의 위치 인덱스로 표현 가능
SELECT deptno, sal, ename nm
FROM emp
ORDER BY 3; --추천 하지는 않음(컬럼 추가시 의도하지 않은 결과가 나올 수 있음)

--orderby1
--dept테이블의 모든 정보를 부서이름으로 오름차순정렬
SELECT *
FROM dept
ORDER BY dname;

--dept테이블의 모든 정보를 부서위치로 내림차순
SELECT *
FROM dept
ORDER BY loc DESC;

--orderby2
--emp 테이블에서 상여정보가 있는 사람들만 조회
--상여를 많이 받는 사람이 먼저 조회되도록 (내림차순, DESC)
--상여 같을 경우 사번으로 오름차순 (ASC)
SELECT *
FROM emp
WHERE comm IS NOT NULL
AND comm != 0
ORDER BY comm DESC, empno;

--orderby3
--emp 테이블에서 관리자가 있는 직원만 조회하고 MGR NULL이 아닌 데이터
--직군(job)순으로 오름차순 정렬(ASC)
--직군이 같을 경우 사원번호가 큰사람이 먼저 조회 되도록  (사원번호 내림차순 DESC)
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

--orderby4
--emp 테이블에서 부서번호가 10번 혹은 30번 부서에 속하는 사람중
--급여가 1500이 넘는 사람만 조회
--이름으로 내림차순(DESC)
SELECT *
FROM emp
WHERE (deptno = 10 OR deptno = 30)   --deptno IN (10, 30)
AND sal > 1500
ORDER BY ename DESC;


--ROWNUM
SELECT ROWNUM, empno, ename
FROM emp;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 2;   --ROWNUM = equal 비교는 1만 가능

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM <= 2;   -- <= (<) ROWNUM을 1부터 순차적으로 조회하는 경우는 가능

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 20;   -- 1부터 시작하는 경우 가능

--SELECT 절과 ORDER BY 구문의 실행순서
--SELECT -> ROWNUM -> ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

--INLINE VIEW를 통해 정렬 먼저 실행하고, 해당 결과에 ROWNUM을 적용
-- SELECT 절에 * 사용하고, 다른 컬럼|표현식을 썼을 경우 
-- *앞에 테이블명이나, 테이블 별칭을 적용
SELECT ROWNUM, a.*                --empno, ename
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename) a;
      
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;

--row_1
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM <= 10;

--row_2 (ROWNUM이 11~14인 데이터)
--ROWNUM BETWEEN 11 AND 14

SELECT a.*
FROM 
    (SELECT ROWNUM rn, empno, ename
     FROM emp) a
WHERE rn BETWEEN 11 AND 20;

--row_3
--emp테이블에서 ename으로 정렬한 결과의 11~14번째행만 조회하는 쿼리를
--작성해보세요(empno, ename 컬럼과 행번호만 조회)
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
         FROM emp
         ORDER BY ename) a ) a
WHERE rn BETWEEN 11 AND 20;



SELECT empno, ename
FROM emp
ORDER BY ename;




