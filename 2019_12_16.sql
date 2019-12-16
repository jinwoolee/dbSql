-- GROUPING SETS(col1, col2)
-- 다음과 결과가 동일
-- 개발자가 GROUP BY의 기준을 직접 명시한다
-- ROLLUP과 달리 방향성을 갖지 않는다
-- GROUPING SETS(col1, col2) = GROUPING SETS(col2, col1)

-- GROUP BY col1
-- UNION ALL
-- GROUP BY col2

-- emp 테이블에서 직원의 job(업무)별 급여(sal)+상여(comm)합,
--                    deptno(부서)별 급여(sal)+상여(comm)합 구하기
--기존 방식(GROUP FUNCTION) : 2 번의 SQL 작성 필요(UNION / UNION ALL)
SELECT job, null deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job
UNION ALL
SELECT '', deptno, sum(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno;

-- GROUPING SETS 구문을 이용하여 위의 SQL을 집합연산을 사용하지 않고
-- 테이블을 한번 읽어서 처리
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

-- job, deptno를 그룹으로 한 sal+comm 합
-- mgr를 그룹으로 한 sal+comm 합
-- GROUP BY job, deptno
-- UNION ALL
-- GROUP BY mgr
-- --> GROUPING SETS((job, deptno), mgr)
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum,
       GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

-- CUBE (col1, col2 ...)
-- 나열된 컬럼의 모든 가능한 조합으로 GROUP BY subset을 만든다
-- CUBE에 나열된 컬럼이 2개인 경우 : 가능한 조합 4개
-- CUBE에 나열된 컬럼이 3개인 경우 : 가능한 조합 8개
-- CUBE에 나열된 컬럼수를 2의 제곱승 한 결과가 가능한 조합 개수가 된다 (2^n)
-- 컬럼이 조금만 많아져도 가능한 조합이 기하급수적으로 늘어 나기 때문에
-- 많이 사용하지는 않는다

-- job, deptno를 이용하여 CUBE 적용
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
-- job, deptno
-- 1,   1   --> GROUP BY job, deptno
-- 1,   0   --> GROUP BY job
-- 0,   1   --> GROUP BY deptno
-- 0,   0   --> GROUP BY  --emp 테이블의 모든행에 대해 GROUP BY

-- GROUP BY 응용
-- GROUP BY, ROLLUP, CUBE를 섞어 사용하기
-- 가능한 조합을 생각해보면 쉽게 결과를 예측할 수 있다
-- GROUP BY job, rollup(deptno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);


SELECT job, SUM(sal)
FROM emp
GROUP BY job;














SELECT *
FROM emp
WHERE deptno=10;


UPDATE dept_test SET (부서별 인원수..서브쿼리 WHERE = ??);

--sub_a1
CREATE TABLE dept_test AS
SELECT *
FROM dept;

SELECT *
FROM dept_test;

ALTER TABLE dept_test ADD (empcnt NUMBER);

--deptno=10 --> empcnt=3, 
--deptno=20 --> empcnt=5, 
--deptno=30 --> empcnt=6, 
UPDATE dept_test SET empcnt = 
                (SELECT COUNT(*)
                 FROM emp
                 WHERE emp.deptno = dept_test.deptno);
                 
                 
SELECT *
FROM dept_test;
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

-- 전체 : 10, 20, 30, 40, 98, 99
-- 삭제 : 40, 98, 99
SELECT *
FROM dept_test
WHERE deptno NOT IN (10, 20, 30);

SELECT deptno
FROM emp
GROUP BY deptno;

DELETE dept_test
WHERE deptno NOT IN ( 10, 20 ,30);

DELETE dept_test
WHERE deptno NOT IN ( 10, 10, 20, 30, 30, 20 ,30);

DELETE dept_test
WHERE deptno NOT IN (
    SELECT deptno
    FROM emp);

DELETE dept_test
WHERE deptno NOT IN (
    SELECT deptno
    FROM emp
    GROUP BY deptno);
ROLLBACK;
SELECT *
FROM dept_test;


-- 10, 20, 30
SELECT deptno
FROM emp
GROUP BY deptno;

--sub_ad3
UPDATE emp_test SET sal = sal + 200
WHERE sal < (SELECT ROUND(AVG(sal), 2)
             FROM emp
             WHERE deptno = emp_test.deptno);
             
SELECT ROUND(AVG(sal), 2)
FROM emp
WHERE deptno = 30;

SELECT empno, ename, deptno, sal
FROM emp_test
ORDER BY deptno;

SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
ORDER BY deptno;


-- MERGE 구문을 이용한 업데이트
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno) b
ON ( a.deptno = b.deptno)
WHEN MATCHED THEN
    UPDATE SET sal = sal + 200
    WHERE a.sal < b.avg_sal;
ROLLBACK;

MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
       FROM emp_test
       GROUP BY deptno) b
ON ( a.deptno = b.deptno)
WHEN MATCHED THEN
    UPDATE SET sal = CASE 
                        WHEN a.sal < b.avg_sal THEN sal + 200
                        ELSE sal
                     END;
    











