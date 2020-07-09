1. GROUP BY (여러개의 행을 하나의 행으로 묶는 행위)
2. JOIN
3. 서브쿼리
  1. 사용위치
  2. 반환하는 행, 컬럼의 개수
  3. 상호연관 / 비상호연관
     -> 메인쿼리의 컬럼을 서브쿼리에서 사용하는지(참조하는지) 유무에 따른 분류
     : 비상호연관 서브쿼리의 경우 단독으로 실행 가능
     : 상호연관서브 쿼리의 경우 실행하기 위해서 메인쿼리의 컬럼을 사용하기 때문에
       단독으로 실행이 불가능

sub2 : 사원들의 급여평균보다 높은 급여를 받는 직원
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

사원이 속한 부서의 급여 평균보다 높은 급여를 받는 사원 정보 조회
(참고 , 스칼라 서브쿼리를 이용해서 해당 사원이 속한 부서의 
       부서이름을 가져오도록 작성 해봄)

SELECT *
FROM emp e
WHERE sal > (SELECT AVG(sal)
             FROM emp s
             WHERE s.deptno = e.deptno);
             


전체사원의 정보를 조회, 조인 없이 해당 사원이 속한 부서의 부서이름 가져오기
SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno)
FROM emp;

SELECT AVG(sal)
FROM emp
WHERE deptno = 10;

SELECT AVG(sal)
FROM emp
WHERE deptno = 20;

SELECT AVG(sal)
FROM emp
WHERE deptno = 30;
       
       
sub3] SMITH, WARD가 속한 부서의 사원 정보를 조회
SMITH : 20, WARD : 30

SELECT *
FROM emp
WHERE deptno IN (20, 30);

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp 
                 WHERE ename IN ('SMITH', 'WARD') );
                 
                 
                 
단일 값비교는 =
복수행(단일컬럼) 비교는 IN
  

** IN, NOT IN 이용시 NULL값의 존재 유무에 따라 원하지 않는 결과가 나올 수 도 있다
NULL 과 IN, NULL과 NOT IN
IN ==> OR
NOT IN ==> AND


WHERE mgr IN (7902, null) 
==> mgr = 7902 OR mgr = null
==> mgr값이 7902 이거나 [mgr값이 null인 데이터]
SELECT *
FROM emp
WHERE mgr IN (7902, NULL);

WHERE mgr NOT IN (7902, null) 
==> NOT (mgr = 7902 OR mgr = null)
==> mgr != 7902 AND mgr != null
SELECT *
FROM emp
WHERE mgr NOT IN (7902, null) ;


pairwise, non-pairwise
한행의 컬럼 값을 하나씩 비교하는 것 : non-pairwise
한행의 복수 컬럼을 비교하는 것 : pairwise
SELECT *
FROM emp
WHERE job IN ('MANAGER', 'CLERK');

7698,	30
7839,	10

SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499, 7782))
  AND deptno IN (SELECT deptno
                 FROM emp
                 WHERE empno IN (7499, 7782));

SELECT *
FROM emp
WHERE mgr IN (7698, 7893)
  AND deptno IN (10, 30);                 

pairwse
7698,	30
7839,	10

non-pairwise
7698,	30
7698,	10
7839,	30
7839,	10


sub4]
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

SELECT *
FROM dept
WHERE deptno가 emp테이블에 등록된 사원들이 소속되 부서가 아닌것;
WHERE deptno != 10 AND deptno != 20 AND deptno != 30
WHERE deptno NOT IN (10, 20, 30);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

SELECT deptno
FROM emp;


sub5]
SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);



