-- GROUPING (cube, rollup 절의 사용된 컬럼)
-- 해당 컬럼이 소계 계산에 사용된 경우 1
-- 사용되지 않은 경우 0

--job 컬럼
--case1. GROUPING(job)=1 AND GROUPING(deptno) = 1
--       job --> '총계'
--case esle 
--       job --> job
SELECT CASE WHEN GROUPING(job) = 1 AND 
                 GROUPING(deptno) = 1 THEN '총계'
            ELSE job 
       END job, 
       
       CASE WHEN GROUPING(job) = 0 AND 
                 GROUPING(deptno) = 1 THEN job ||' 소계'
            ELSE TO_CHAR(deptno)
       END deptno,
       /*GROUPING(job), GROUPING(deptno), */sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

/*
GROUP BY job, deptno 
UNION ALL
GROUP BY job
UNION ALL
GROUP BY--전체 데이터(총계)
*/


--GROUP_AD3
SELECT deptno, job, sum(sal) sal
FROM emp
GROUP BY ROLLUP(deptno, job);
/*
GROUP BY deptno, job
UNION ALL
GROUP BY deptno
UNION ALL
GROUP BY 
*/


--CUBE (co1, col2...)
--CUBE 절에 나열된 컬럼의 가능한 모든 조합에 대해 서브 그룹으로 생성
--CUBE에 나열된 컬럼에 대해 방향성은 없다(rollup과의 차이)
--GROUP BY CUBE(job, deptno)
--00 : GROUP BY job, deptno
--0X : GROUP BY job
--X0 : GROUP BY deptno
--XX : GROUP BY --모든 데이터에 대해서...

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE(job, deptno);


SELECT *
FROM emp;


--subquery를 통한 업데이트
DROP TABLE emp_test;

--emp테이블의 데이터를 포함해서 모든 컬럼을 이용하여 emp_test테이블로 생성
CREATE TABLE emp_test AS
SELECT *
FROM emp;

--emp_test 테이블의 dept테이블에서 관리되고있는 dname 컬럼(VARCHAR2(14))을 추가
ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;

--emp_test테이블의 dname 컬럼을 dept테이블의 dname 컬럼 값으로 업데이트하는 
--쿼리 작성

UPDATE emp_test SET dname = ( SELECT dname
                              FROM dept
                              WHERE dept.deptno = emp_test.deptno);
--WHERE empno IN (7369, 7499);
COMMIT;

--sub1
--DROP TABLE dept_test;
--CREATE TABLE dept_test AS
-- SELECT * FROM dept;


--empcnt NUMBER
ALTER TABLE dept_test ADD (empcnt NUMBER);


--10번 부서의 부서원 수 구하는 쿼리
SELECT COUNT(*)
FROM emp
WHERE DEPTNO=20;

--dept_test테이블의 empcnt 컬럼을 emp테이블을 이용하여(subquery) update

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                                FROM emp
                                WHERE DEPTNO=dept_test.deptno);
SELECT *
FROM dept_test;
                              
SELECT COUNT(*)
FROM emp
WHERE DEPTNO=40;

SELECT *
FROM emp
WHERE DEPTNO=40;


--
SELECT *
FROM dept_test;
INSERT INTO dept_test VALUES (98, 'it', 'daejeon', 0);
INSERT INTO dept_test VALUES (99, 'it', 'daejeon', 0);



--사원이 속한 부서정보 조회
SELECT *
FROM DEPT
WHERE NOT EXISTS (SELECT 'X'
              FROM emp
              WHERE emp.deptno = dept.deptno);
              
DELETE DEPT_TEST
WHERE NOT EXISTS (SELECT 'X'
              FROM emp
              WHERE emp.deptno = dept.deptno);              
              
EXPLAIN PLAN FOR
DELETE DEPT_TEST
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);
                     
                     
SELECT *
FROM TABLE(dbms_xplan.display);
                     
SELECT *
FROM dept_test;
ROLLBACK;

DELETE DEPT_TEST
WHERE empcnt = (SELECT COUNT(*)
                FROM emp
                where EMP.DEPTNO = dept_test.deptno
                HAVING COUNT(*) = 0 );


                
                
                
                HAVING COUNT(*) = 0 );                

SELECT COUNT(*)
                  FROM emp
                  where EMP.DEPTNO = 98
                  --GROUP BY DEPTNO
                  HAVING COUNT(*) = 0  ;                 
                      

SELECT DEPTNO, COUNT(*)
FROM emp

GROUP BY DEPTNO;
                      
SELECT *
FROM dept_test;
WHERE deptno=10;
SELECT COUNT(*)
FROM emp
where EMP.DEPTNO = 10
GROUP BY DEPTNO;            


SELECT *
FROM emp_test;


--sub3
--자신이 속한 부서의 급여 평균보다 낮은급여를 받는 사람 조회
-- STEP1. 10번 부서의 급여 평균 구하기
SELECT *
FROM emp_test a
WHERE sal < 
        (SELECT AVG(sal)
        FROM emp_test b
        WHERE b.deptno=a.deptno);
        
UPDATE emp_test a SET sal = sal+200
WHERE sal < 
        (SELECT AVG(sal)
        FROM emp_test b
        WHERE b.deptno=a.deptno);    
        
--emp, emp_test empno컬럼으로 같은갑끼리 조회
--1.emp.empno, emp.ename, emp.sal, emp_test.sal
--2.emp.empno, emp.ename, emp.sal, emp_test.sal, 
--  해당사원(emp테이블 기준)이 속한 부서의 급여평균

SELECT emp.empno, emp.ename, emp.sal, emp_test.sal, emp.deptno, a.sal_avg
FROM emp, emp_test,(SELECT deptno, ROUND(AVG(sal), 2) sal_avg
                    FROM emp
                    GROUP BY deptno) a
WHERE emp.empno = emp_test.empno
AND emp.deptno = a.deptno;










