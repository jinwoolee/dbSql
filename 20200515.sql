REPORT GROUP FUNCTION ==> 확장된 GROUP BY
REPORT GROUP FUNCTION을 사용을 안하면
여러개의 SQL작성, UNION ALL을 통해서 하나의 결과로 합치는 과정

==> 좀더 편하게 하는게 REPORT GROUP FUNCTION




GROUP_AD4]

SELECT dept.dname, emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);

SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
 FROM emp
 GROUP BY ROLLUP (deptno, job)) a, dept
WHERE a.deptno = dept.deptno(+) ;

GROUP_AD5]
SELECT NVL(dept.dname, '총계') dname, emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno

GROUP BY ROLLUP (dept.dname, emp.job);
GROUP BY GROUPING SETS (dept.dname, emp.job);


2. GROUPING SETS
ROLLUP의 단점 : 관심없는 서브그룹도 생성 해야한다
               ROLLUP절에 기술한 컬럼을 오른쪽에서 지워나가기 때문에
               만약 중간과정에 있는 서브그룹이 불필요 할 경우 낭비.
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
                ROLLUP과는 다르게 방향성이 없다
  
사용법 : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col2, col1)
GROUP BY col2
UNION ALL
GROUP BY col1


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY job

UNION ALL

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY deptno;


그룹기준을 
1. job, dpetno
2. mgr

GROUP BY GROUPING SETS ( (job, deptno), mgr, job, (mgr, job) )

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ( (job, deptno), mgr );

SELECT job, deptno, NULL, SUM(sal)
FROM emp
GROUP BY job, deptno

UNION ALL

SELECT NULL, NULL, mgr, SUM(sal)
FROM emp
GROUP BY   mgr;



3. CUBE 
사용법 : GROUP BY CUBE (co11, col2...)
기술된 컬럼의 가능한 모든 조합 (순서는 지킨다)

GROUP BY CUBE (job, deptno);
  1      2
job    deptno
job     x
 X     deptno
 X      X
 
 GROUP BY CUBE (job, deptno, mgr);
  1      2         3
job    deptno     mgr
job    deptno     X
job    X          mgr
job    X          X
X    deptno     mgr
X    deptno     X
X    X          mgr
X    X          X

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


여러개의 REPORT GROUP 사용하기
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**발생 가능한 조합을 계산
1       2        3
job    deptno    mgr ==> GROUP BY job, deptno, mgr
job    X         mgr ==> GROUP BY job, mgr
job    deptno     x  ==> GROUP BY job, deptno
job    X          x  ==> GROUP BY job


GROUP BY job, ROLLUP(job, deptno), CUBE(mgr)

1         2               3
job     job, deptno     mgr   ==> GROUP BY job, job, dpetno, mgr ==> GROUP BY job, dpetno, mgr
job     job             mgr   ==> GROUP BY job, job, mgr ==> GROUP BY job, mgr
job     x               mgr   ==> GROUP BY job, x, mgr  ==> GROUP BY job, mgr
job     job, deptno     x     ==> GROUP BY job, deptno, x ==> GROUP BY job, deptno
job     job             x     ==> GROUP BY job, job, x ==> GROUP BY job
job     x               x     ==> GROUP BY job, x, x ==> GROUP BY job

SELECT 5%2
FROM dual;

SELECT CASE 
        WHEN GROUPING(job)=1 && GROUPING(deptno)=1 THEN 'TEST'
       END


상호연관 서브쿼리 업데이트
1. emp테이블을 이용하여 emp_test 테이블 생성
    ==> 기존에 생성된 emp_test 테이블 삭제 먼저 진행
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;
    
2. emp_test 테이블에 dname컬럼 추가(dept 테이블 참고)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;


3. subquery를 이용하여 emp_test 테이블에 추가된 danme 컬럼을 업데이트 해주는 쿼리 작성
emp_test의 dname 컬럼의 값을 dept 테이블의 dname 컬럼으로 update
emp_test테이블의 deptno값을 확인해서 dept테이블의 deptno값이랑 일치하는 dname 컬럼값을 가져와 update

SELECT *
FROM emp_test;

emp_test테이블의 dname 컬럼을 dept 테이블이용해서 dname값 조회하여 업데이트
update 대상이 되는 행 : 14 ==> WHERE 절을 기술하지 않음

모든직원을 대상으로 dname 컬럼을 dept 테이블에서 조회하여 업데이트
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);
                             
SELECT dname
 FROM dept
 WHERE 30 = dept.deptno
 
 
 
 
sub_a1]
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE emp.deptno = dept_test.deptno
                               GROUP BY deptno);

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE emp.deptno = dept_test.deptno);
                               
SELECT 결과 전체를 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을 경우 조회되는 행이 없다
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;

SELECT *
FROM dept_test;









