--복습
--WHERE 
--연산자
-- 비교 : =, !=, <>, >=, >, <=, <
-- BETWEEN start AND end
-- IN (set)
-- LIKE 'S%' ( % : 다수의 문자열과 매칭, _ : 정확히 한글자 매칭)
-- IS NULL ( != NULL )
-- AND, OR, NOT 

--emp 테이블에서 입사일자가 1981년 6월 1일부터 1986년 12월 31일 사이에 있는
--직원 정보조회
--BETWEEN AND
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981/06/01', 'YYYY/MM/DD')
                   AND TO_DATE('1986/12/31', 'YYYY/MM/DD');
-- >=, <=
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD')
  AND hiredate <= TO_DATE('1986/12/31', 'YYYY/MM/DD');

--emp 테이블에서 관리자(mgr)가 있는 직원만 조회
SELECT *
FROM emp
WHERE mgr IS NULL;
--WHERE mgr != NULL;


--where12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%';
   
--where13
-- empno는 정수 4자리까지 허용
-- empno : 7800~7899
--         780~789
--         78
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno BETWEEN 7800 AND 7899
   OR empno BETWEEN 780 AND 789
   OR empno =78;
   
--where14
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR (    empno like '78%' 
       AND hiredate >= TO_DATE('19810601', 'YYYYMMDD'));



--order by 컬럼명 | 별칭 | 컬럼인덱스 [ASC | DESC]
--order by 구문은 WHERE절 다음에 기술
--WHERE 절이 없을 경우 FROM절 다음에 기술
--emp테이블을 ename 기준으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY ename ASC;

--ASC :default
--ASC를 안붙여도 위 쿼리와 동일한
SELECT *
FROM emp
ORDER BY ename; -- ASC

--이름(ename)을 기준으로 내림차순
SELECT *
FROM emp
ORDER BY ename desc;

--job을 기준으로 내림차순으로 정렬, 만약 job이 같을경우
--사번(empno)으로 올림차순 정렬
--SALESMASN - PRESIDENT -MANAGER - CLERK - ANALYST

SELECT *
FROM emp
ORDER BY job DESC, empno asc;

--별칭으로 정렬하기
--사원 번호(empno), 사원명(ename), 연봉(sal * 12) as year_sal
--year_sal 별칭으로 오름차순 정렬
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT절 컬럼 순서 인덱스로 정렬
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY 2;

--orderby1
SELECT *
FROM dept
ORDER BY DNAME ASC;

SELECT *
FROM dept
ORDER BY LOC DESC;

--orderby2
SELECT *
FROM emp
WHERE comm is not null
ORDER BY comm DESC, empno ASC;

--orderby3
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job ASC, empno DESC;

--orderby4
SELECT *
FROM emp
--WHERE deptno IN (10, 30)
WHERE (deptno = 10 OR deptno= 30)
AND   sal > 1500
ORDER BY ename DESC;

desc emp;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM > 10;
--WHERE ROWNUM <= 10;


--emp 테이블에서 사번(empno), 이름(ename)을 급여 기준으로 오름차순 정렬하고
--정렬된 결과순으로 ROWNUM
SELECT empno, ename, sal, ROWNUM
FROM emp
ORDER BY sal;

--row_1
SELECT ROWNUM, B.*
FROM
    (SELECT empno, ename, sal
    FROM emp 
    ORDER BY sal) B
WHERE ROWNUM BETWEEN 1 AND 10;

--row_2
SELECT *
FROM
    (SELECT ROWNUM rn, B.*
    FROM
        (SELECT empno, ename, sal
        FROM emp 
        ORDER BY sal) B )
WHERE rn between 11 AND 20;


--FUNCTION
--DUAL 테이블 조회
SELECT 'HELLO WORLD' as msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--문자열 대소문자 관련 함수 
--LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'), UPPER('Hello, World')
     , INITCAP('hello, world')
FROM dual;

SELECT LOWER('Hello, World'), UPPER('Hello, World')
     , INITCAP('hello, world')
FROM emp
WHERE job = 'SALESMAN';

--FUNCTION은 WHERE절에서도 사용가능
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';
--개발자 SQL 칠거지악
--1.좌변을 가공하지 말아라
--좌변(TABLE 의 컬럼) 을 가공하게 되면 INDEX를 정상적으로 사용하지 못함
--Function Based Index ->  FBI

--CONCAT : 문자열 결합 - 두개의 문자열을 결합하는 함수
--SUBSTR : 문자열의 부분 문자열 (java : String.substring)
--LENGTH : 문자열의 길이
--INSTR : 문자열에 특정 문자열이 등장하는 첫번 째 인덱스
--LPAD : 문자열에 특정 문자열을 삽입
SELECT CONCAT(CONCAT('HELLO', ', ') , 'WORLD') CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5) substr,
       SUBSTR('HELLO, WORLD', 1, 5) substr1,
       LENGTH('HELLO, WORLD') length,
       INSTR('HELLO, WORLD', 'O') instr,
       --INSTR(문자열, 찾을 문자열, 문자열의 특정 위치 이후 표시)
       INSTR('HELLO, WORLD', 'O', 6) instr1,
       --LPAD(문자열, 전체 문자열길이, 
       --            문자열이 전체문자열길이에 미치지 못할경우 추가할 문자);
       LPAD('HELLO, WORLD', 15, '*') lpad,
       LPAD('HELLO, WORLD', 15) lpad,
       LPAD('HELLO, WORLD', 15, ' ') lpad,
       RPAD('HELLO, WORLD', 15, '*') rpad      
FROM dual;








