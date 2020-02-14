group_ad2

group_ad2-1 decode 2중, case 
DECODE(인자 (조건X) 

DECODE(GROUPING(job) || GROUPING(deptno)  , '00', -,
                                            '01', -,
                                            '11', -,



00, 01, 11

SELECT DECODE( GROUPING(job) || GROUPING(deptno), '11', '총',
                                                  '00', job,
                                                  '01', job) job, 
       DECODE( GROUPING(job) || GROUPING(deptno), '11', '계',
                                                  '00', deptno,
                                                  '01', '소계') deptno, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);   


MERGE : SELECT하고나서 데이터가 조회되면 UPDATE
        SELECT하고나서 데이터가 조회되지 않으면 INSERT      
SELECT + UPDATE / SELECT + INSERT ==> MERGE;

REPORT GROUP FUNCTION 
1. ROLLUP
    - GROUP BY ROLLUP (컬럼1, 컬럼2)
    - ROLLUP절에 기술한 컬럼을 오른쪽에서 하나씩 제거한 컬럼으로 SUBGROUP
    - GROUP BY 컬럼1, 컬럼2
      UNION 
      GROUP BY 컬럼1
      UNION 
      GROUP BY
2. CUBE
3. GROUPING SETS ;


GROUP_AD3
GROUP BY ROLLUP (deptno, job)
==>
GROUP BY deptno, job 
GROUP BY deptno
GROUP BY ;

SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno, job);   

SELECT dept.dname, emp.job, SUM(emp.sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);   

SELECT b.dname, a.job, a.sal
FROM
(SELECT deptno, job, SUM(sal) sal
 FROM emp
 GROUP BY ROLLUP (deptno, job) ) a, dept b
WHERE a.deptno = b.deptno(+);

GROUP_AD5;
SELECT DECODE(GROUPING(dept.dname), 1, '총합', dept.dname) dname,
       emp.job, SUM(emp.sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);   

SELECT NVL(dept.dname, '총합') dname,
       emp.job, SUM(emp.sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);   


REPORT GROUP FUNCTION
1. ROLLUP
2. CUBE
3. GROUPING SETS
활용도
3, 1 >>>>>>>>>>>>>>>>>>>>>>>> CUBE;


 GROUPING SETS 
 순서와 관계없이 서브 그룹을 사용자가 직접 선언 
 사용방법 : GROUP BY GROUPING SETS(col1, col2...)
 GROUP BY GROUPING SETS(col1, col2)
 ==>
 GROUP BY col1
 UNION ALL
 GROUP BY col2
 
 GROUP BY GROUPING SETS( (col1, col2), col3, col4 )
 ==>
 GROUP BY col1, col2
 UNION ALL
 GROUP BY col3
 UNION ALL 
 GROUP BY col4;

 
GROUPING SETS의 경우 컬럼 기술 순서가 결과에 영향을 미치지 않는다
ROLLUP은 컬럼 기술 순서가 결과 영향을 미친다;

GROUP BY GROUPING SETS( col1, col2 )
==>
GROUP BY col1
UNION
GROUP BY col2

GROUP BY GROUPING SETS( col2, col1 )
GROUP BY col2
UNION ALL
GROUP BY col1;


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);

GROUP BY GROUPING SETS(job, deptno)
==>
GROUP BY job
UNION ALL
GROUP BY deptno;


SELECT job, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, job);

job, deptno로 GROUP BY 한 결과와
mgr로 GROUP BY한 결과를 조회하는 SQL을 GROUPING SETS로  급여합 SUM(sal)작성;

SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS ( (job, deptno), mgr);

CUBE 
가능한 모든조합으로 컬럼을 조합한 SUB GROUP을 생성한다
단 기술한 컬럼의 순서는 지킨다

EX : GROUP BY CUBE(col1, col2);

(col1, col2) ==>
(null, col2) == GROUP BY col2
(null, null) == GROUP BY 전체
(col1, null) == GROUP BY col1
(col1, col2) == GROUP BY col1, col2

만약 컬럼3개를 CUBE절에 기술한 경우 나올수 있는 가지수는 ??;


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE(job, deptno);


혼종;

SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY job, rollup(deptno), CUBE(mgr)

GROUP BY job, deptno, mgr == GROUP BY job, deptno, mgr
GROUP BY job, deptno == GROUP BY job, deptno
GROUP BY job, null, mgr == GROUP BY job,mgr
GROUP BY job, null, null == GROUP BY job;


서브쿼리 UPDATE
1. emp_test 테이블 drop
2. emp 테이블을 이용해서 emp_test 테이블생성 (모든 행에 대해 ctas)
3. emp_test 테이블에 dname VARCHAR2(14)컬럼추가
4. emp_test.dname 컬럼을 dept 테이블을 이용해서 부서명을 업데이트;

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;

UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE dept.deptno = emp_test.deptno);
                             
COMMIT;                             



sub_a1;
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD ( empcnt NUMBER);

SELECT *
FROM dept_test;

deptno, dname, loc
10	ACCOUNTING	NEW YORK	
20	RESEARCH	DALLAS	
30	SALES	CHICAGO	
40	OPERATIONS	BOSTON;

UPDATE dept_test SET empcnt = NVL((SELECT COUNT(*) cnt
                               FROM emp
                               WHERE deptno = dept_test.deptno
                               GROUP BY deptno), 0);

SELECT COUNT(*) cnt
FROM emp
WHERE deptno = 40
GROUP BY deptno;

SELECT *
FROM dept_test;
WHERE dname ='SALES';


sub_a2
dept_test테이블에 있는 부서중에 직원이 속하지 않은 부서 정보를 삭제
*dept_test.empcnt 컬럼은 사용하지 않고
emp 테이블을 이용하여 삭제;
INSERT INTO dept_test VALUES (99, 'it1', 'daejeon', 0);
INSERT INTO dept_test VALUES (98, 'it2', 'daejeon', 0);
COMMIT;

직원이 속하지 않은 부서 정보 조회?
직원 있다 없다....?
10번 부서에 직원이 있다 없다 ??

SELECT COUNT(*)
FROM emp
WHERE deptno=40;

SELECT *
FROM dept_test
WHERE 0 = (SELECT COUNT(*)
           FROM emp
           WHERE deptno = dept_test.deptno);

DELETE dept_test
WHERE 0 = (SELECT COUNT(*)
           FROM emp
           WHERE deptno = dept_test.deptno);

sub_a3;

SELECT *
FROM emp_test;

UPDATE emp_test a SET sal = sal + 200
WHERE sal < (SELECT AVG(SAL)
             FROM emp_test b
             WHERE a.deptno = b.deptno);

if ( deptno = 10 ){
    UPDATE emp_test a SET sal = sal + 200
    WHERE sal < (SELECT AVG(SAL)
                 FROM emp_test b
                 WHERE 10 = b.deptno)             
}
else if  ( deptno = 20 ){
    UPDATE emp_test a SET sal = sal + 200
    WHERE sal < (SELECT AVG(SAL)
                 FROM emp_test b
                 WHERE 20 = b.deptno)             
}
else if  ( deptno = 30 ){
    UPDATE emp_test a SET sal = sal + 200
    WHERE sal < (SELECT AVG(SAL)
                 FROM emp_test b
                 WHERE 30 = b.deptno)             
};

WITH 절
하나의 쿼리에서 반복되는 SUBQUERY가 있을 때 
해당 SUBQUERY를 별도로 선언하여 재사용.

MAIN쿼리가 실행될 때 WITH 선언한 쿼리 블럭이 메모리에 임시적으로 저장
==> MAIN 쿼리가 종료 되면 메모리 해제

SUBQUERY 작성시에는 해당 SUBQUERY의 결과를 조회하기 위해서 I/O 반복적으로 일어나지만

WITH절을 통해 선언하하면 한번만 SUBQUERY가 실행되고 그 결과를 메모리에 저장해 놓고 재사용

단, 하나의 쿼리에서 동일한 SUBQUERY가 반복적으로 나오는거는 잘못 작성한 SQL일 확률이 높음;

WITH 쿼리블록이름 AS (
    서브쿼리
)

SELECT *
FROM 쿼리블록이름;


직원의 부서별 급여 평균을 조회하는 쿼리블록을 WITH절을 통해 선언;

WITH sal_avg_dept AS (
    SELECT deptno, ROUND(AVG(sal), 2) sal
    FROM emp
    GROUP BY deptno
),
  dept_empcnt AS(
  SELECT deptno, COUNT(*) empcnt
  FROM emp
  GROUP BY deptno)

SELECT *
FROM sal_avg_dept a, dept_empcnt b
WHERE a.deptno = b.deptno;




SELECT *
FROM 
(SELECT deptno, ROUND(AVG(sal), 2) sal
 FROM emp
 GROUP BY deptno) a, 
(SELECT deptno, ROUND(AVG(sal), 2) sal
 FROM emp
 GROUP BY deptno) b
 
WITH sal_avg_dept AS (
    SELECT deptno, ROUND(AVG(sal), 2) sal
    FROM emp
    GROUP BY deptno
)
SELECT *
FROM sal_avg_dept a, sal_avg_dept b;

WITH 절을 이용한 테스트 테이블 작성
WITH temp AS (
    SELECT sysdate -1 FROM dual UNION ALL
    SELECT sysdate -2 FROM dual UNION ALL
    SELECT sysdate -3 FROM dual)
SELECT *
FROM temp;

SELECT *
FROM 
    (SELECT sysdate -1 FROM dual UNION ALL
    SELECT sysdate -2 FROM dual UNION ALL
    SELECT sysdate -3 FROM dual);


달력만들기
CONNECT BY LEVEL <[=] 정수
해당 테이블의 행을 정수 만큼 복제하고, 복제된 행을 구별하기 위해서 LEVEL을 부여
LEVEL은 1부터 시작;

SELECT dummy, LEVEL
FROM dual
CONNECT BY LEVEL <= 10;

SELECT dept.*, LEVEL
FROM dept
CONNECT BY LEVEL <= 5 ;


2020년 2월의 달력을 생성
:dt = 202002, 202003
달력 
일  월  화  수  목  금  토
SELECT TO_DATE('202002', 'YYYYMM') + (LEVEL-1),
       TO_CHAR(TO_DATE('202002', 'YYYYMM') + (LEVEL-1), 'D'),
       DECODE(TO_CHAR(TO_DATE('202002', 'YYYYMM') + (LEVEL-1), 'D'), 
                1, TO_DATE('202002', 'YYYYMM') + (LEVEL-1)) s,
                
       DECODE(TO_CHAR(TO_DATE('202002', 'YYYYMM') + (LEVEL-1), 'D'), 
                2, TO_DATE('202002', 'YYYYMM') + (LEVEL-1)) m,
       DECODE(TO_CHAR(TO_DATE('202002', 'YYYYMM') + (LEVEL-1), 'D'), 
                3, TO_DATE('202002', 'YYYYMM') + (LEVEL-1)) t,
       DECODE(TO_CHAR(TO_DATE('202002', 'YYYYMM') + (LEVEL-1), 'D'), 
                4, TO_DATE('202002', 'YYYYMM') + (LEVEL-1)) w,
       DECODE(TO_CHAR(TO_DATE('202002', 'YYYYMM') + (LEVEL-1), 'D'), 
                5, TO_DATE('202002', 'YYYYMM') + (LEVEL-1)) t2,
       DECODE(TO_CHAR(TO_DATE('202002', 'YYYYMM') + (LEVEL-1), 'D'), 
                6, TO_DATE('202002', 'YYYYMM') + (LEVEL-1)) f,         
      DECODE(TO_CHAR(TO_DATE('202002', 'YYYYMM') + (LEVEL-1), 'D'), 
                7, TO_DATE('202002', 'YYYYMM') + (LEVEL-1)) s2
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002', 'YYYYMM')), 'DD'); 

SELECT TO_CHAR(LAST_DAY(TO_DATE('202002', 'YYYYMM')), 'D')
FROM dual;










