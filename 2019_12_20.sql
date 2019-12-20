--hash join
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;
-- dept 먼저 읽는 형태
-- join 컬럼을 hash 함수로 돌려서 해당 해쉬 함수에 해당하는 bucket에 데이터를 넣는다
-- 10 --> ccc1122 (hashvalue)

-- emp 테이블에 대해 위의 진행을 동일하게 진행
-- 10 -->  ccc1122 (hashvalue)






SELECT *
FROM dept, emp
WHERE emp.deptno BETWEEN dept.dpetno AND 99;
10 --> AAAAAA
20 --> AAAAAB


SELECT COUNT(*)
FROM emp;

-- 사원번호, 사원이름, 부서번호, 급여, 부서원의 전체 급여합
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal 
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --가장 처음부터 현재행까지
       
       --바로 이전행이랑 현재행까지의 급여합
       SUM(sal) OVER (ORDER BY sal
       ROWS BETWEEN 1 PRECEDING AND CURRENT ROW ) c_sum2
FROM emp
ORDER BY sal;


--ROWS vs RANGE 차이 확인하기
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING ) row_sum,
       SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING ) range_sum,       
       SUM(sal) OVER (ORDER BY sal ) c_sum,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED FOLLOWING) range_sum
FROM emp;


-- PL/SQL
-- PL/SQL 기본구조
-- DECLARE : 선언부, 변수를 선언하는 부분
-- BEGIN : PL/SQL의 로직이 들어가는 부분
-- EXCEPTION : 예외처리부

-- DBMS_OUTPUT.PUT_LINE 함수가 출력하는 결과를 화면에 보여주도록 활성화
SET SERVEROUTPUT ON; 
DECLARE --선언부
   -- java : 타입 변수명;
   -- pl/sql : 변수명 타입;
   v_dname VARCHAR2(14);
   v_loc VARCHAR2(13);
BEGIN
    --DEPT 테이블에서 10번 부서의 부서 이름, LOC 정보를 조회
    SELECT dname, loc 
    INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    
END;
/  --PL/SQL 블록을 실행
;

DESC dept;

