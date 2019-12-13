SELECT *
FROM emp_test
ORDER BY empno;

-- emp테이블에 존재하는 데이터를 emp_test 테이블로 머지
-- 만약 empno가 동일한 데이터가 존재하면 
-- ename update : ename || '_merge'
-- 만약 empno가 동일한 데이터가 존재 하지 않을경우
-- emp테이블의 empno, ename emp_test 데이터로 insert

--emp_test 데이터에서 절반의 데이터를 삭제
DELETE emp_test
WHERE empno >= 7788;
COMMIT;

--emp 테이블에는 14건의 데이터가 존재
--emp_test 테이블에는 사번이 7788보다 작은 7명의 데이터가 존재
--emp테이블을 이용하여 emp_test 테이블을 머지하게되면
--emp테이블에만 존재하는 직원 (사번이 7788보다 크거나 같은 같은) 7명
--emp_test로 새롭게 insert가 될 것이고
--emp, emp_test에 사원번호가 동일하게 존재하는 7명의 데이터는
--(사번이 7788보다 작은 직원)ename컬럼으 ename || '_modify'로
--업데이트를 한다

/*
MERGE INTO 테이블명
USING 머지대상 테이블|VIEW|SUBQUUERY
ON (테이블명과 머지대상의 연결관계)
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


-- emp_test 테이블에 사번이 9999인 데이터가 존재하면
-- ename을 'brown'으로 update
-- 존재하지 않을 경우 empno, ename VALUES (9999, 'brown')으로 insert
-- 위의 시나리오를 MERGE 구문을 활용하여 한번의 sql로 구현
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

--만약 merge 구문이 없다면 (** 2번의 SQL이 필요)
-- 1. empno = 9999인 데이터가 존재 하는지 확인
-- 2-1. 1번사항에서 데이터가 존재하면 UPDATE
-- 2-2. 1번사항에서 데이터가 존재하지 않으면 INSERT

--GROUP_AD1
--부서별 급여 합
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

--전체 직원의 급여 합
SELECT SUM(sal)
FROM emp;

SELECT deptno, SUM(sal) --부서계
FROM emp
GROUP BY deptno

UNION ALL

SELECT NULL, SUM(sal)  -- 총계
FROM emp;

-- JOIN 방식으로 풀이
-- emp 테이블의 14건에 데이터를 28건으로 생성
-- 구분자(1 -14, 2-14)를 기준으로 group by
-- 구분자 1 : 부서번호 기준으로 14 row
-- 구분자 2 : 전체 14 row
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
--ROLLUP절에 기술된 컬럼을 오른쪽에서 부터 지원 결과로 
--SUB GROUP을 생성하여 여러개의 GROUP BY절을 하나의 SQL에서 실행 되도록 한다
GROUP BY ROLLUP(job, deptno)
-- GROUP BY job, deptno
-- GROUP BY job
-- GROUP BY --> 전체 행을 대상으로 GROUP BY


--emp테이블을 이용하여 부서번호별, 전체직원별 급여합을 구하는 쿼리를
--ROLLUP 기능을 이용하여 작성
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno);

-- EMP 테이블을 이용하여 job, deptno 별 sal+comm 합계
--                    job 별 sal+comm 합계
--                    전체직원의 sal+comm 합계
-- ROLLUP을 활용하여 작성
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno)
ORDER BY deptno, job;

--GROUP BY job, deptno
--GROUP BY job
--GROUP BY -->전체 ROW대상


--ROLLUP은 컬럼 순서가 조회 결과에 영향을 미친다
GROUP BY ROLLUP(job, deptno);
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY -->전체 ROW대상

GROUP BY ROLLUP(deptno, job);
--GROUP BY deptno, job
--GROUP BY deptno
--GROUP BY -->전체 ROW대상



--GROUP_AD2
SELECT DECODE(GROUPING(job), 1, '총계', job) job,
       deptno, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);


--GROUP_AD2_1
SELECT DECODE(GROUPING(job), 1, '총', job) job,
       CASE 
            WHEN deptno IS NULL AND job IS NULL THEN '계'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '소계'
            ELSE TO_CHAR(deptno)
       END deptno,
       
       SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);


--DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job), 1, '계', '소계'), deptno), 
/*
    if( GROUPING(deptno) == 1){
        if ( GROUPING(job) == 1 )
            return  '계'
        else
            return '소계')
    }
    else
        return deptno;
    

DECODE(GROUPING(deptno) + GROUPING(job), 2,  '계', 1 '소계', deptno)
    if( GROUPING(deptno) + GROUPING(job) == 2)
        return  '계'
    if( GROUPING(deptno) + GROUPING(job) == 1)
        return '소계'
    else
        return deptno;    
    
*/

SELECT DECODE(GROUPING(job), 1, '총', job) job,
       DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job), 1, '계', '소계'), deptno) deptno, 
       /*CASE 
            WHEN deptno IS NULL AND job IS NULL THEN '계'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '소계'
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

--UNION ALL로 치환
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
SELECT NVL(dept.dname, '총계') dname , a.job, a.sal_sum
FROM 
    (SELECT deptno, job, 
           SUM(sal + NVL(comm, 0)) sal_sum
     FROM emp
     GROUP BY ROLLUP(deptno, job)) a, dept
WHERE a.deptno = dept.deptno(+);








