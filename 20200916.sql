1. 정답 조회 하는 쿼리 작성
2. SQL에 불필요한 부분이 없는지 점검

join6]
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, SUM(cycle.cnt) cnt
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid
   AND cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm   
ORDER BY cid, pid;


join7]
SELECT cycle.pid, product.pnm, SUM(cycle.cnt) cnt
 FROM cycle, product
 WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm   
ORDER BY pid;

SELECT pid, SUM(cnt)
FROM cycle
GROUP BY pid;

SELECT *
FROM USER_TABLES;

JOIN8]
SELECT r.*, c.country_name, l.city
FROM regions r, countries c, locations l
WHERE r.region_id = c.region_id
  AND r.region_id = 1
  AND c.country_id = l.country_id;

SELECT *
FROM locations;


SELECT e.manager_id mgr_id, CONCAT(m.first_name, m.last_name) mgr_name, 
        e.employee_id, CONCAT(e.first_name, e.last_name) name, e.job_id, job_title
FROM employees e JOIN employees m ON (e.manager_id = m.employee_id)
                 JOIN jobs ON (e.job_id = jobs.job_id);
                 
                 
SELECT manager.employee_id mgr_id, manager.first_name||manager.last_name mgr_name , 
        e.employee_id, e.first_name||e.last_name name, 
        j.job_id, j.job_title
FROM employees e JOIN jobs j ON (e.job_id = j.job_id)
                 JOIN employees manager ON e.manager_id = manager.employee_id;                 
                 

SELECT e.employee_id mgr_id, CONCAT(e.first_name, e.last_name) mgr_name, m.employee_id ,CONCAT(m.first_name, m.last_name) name,j.job_id, j.job_title
FROM employees e, employees m, jobs j
WHERE m.job_id = j.job_id 
 AND m.manager_id = e.employee_id;     
 
 
OUTERJOINT5] cid = 1 인 고객만
SELECT a.pid, a.pnm, a.cid, c.cnm, NVL(a.day, 0) day, NVL(a.cnt, 0) cnt
FROM
(SELECT :cid cid, c.day, c.cnt, p.pid, p.pnm
 FROM cycle c, product p
 WHERE c.cid(+) = :cid
   AND c.pid(+) = p.pid ) a, customer c
WHERE  a.cid = c.cid ;
  
SELECT *
FROM 
(SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
 FROM customer, cycle
 WHERE customer.cid = cycle.cid
   AND customer.cid = 1) a, product p
WHERE a.pid(+) = p.pid   ;




전체 직원의 급여 평균보다 높은 급여를 받는 사원들 조회
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) 
             FROM emp);
             
본인 속한 부서의 급여 평균보다 높은 급여를 받는 사람들을 조회             
SELECT *
FROM emp e
WHERE sal > (SELECT AVG(sal) 
             FROM emp 
             WHERE deptno = e.deptno);


sub4]
테스트용 데이터 추가
DESC dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

SELECT *
FROM dept
WHERE deptno NOT IN (10, 20, 30, 10, 20, 30, 30, 30, 30);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

1. emp 테이블에 등록된 사원들이 속한 부서 번호 확인
SELECT deptno
FROM emp;

             
sub5]
1번고객이 먹지 않는 제품 정보를 조회
SELECT *
FROM product
WHERE pid NOT IN ( 100, 100, 100, 400, 400);

SELECT *
FROM product
WHERE pid NOT IN ( SELECT pid
                   FROM cycle
                   WHERE cid = 1);

1번 고객이 먹는 제품은??
SELECT pid
FROM cycle
WHERE cid = 1;


SELECT *
FROM cycle
WHERE cid IN (1)
AND pid = 100;


sub6]
SELECT *
FROM cycle
WHERE cid = 1
  AND pid IN ( 100, 100, 100, 200, 200);
  
SELECT *
FROM cycle
WHERE cid = 1
  AND pid IN ( SELECT pid
               FROM cycle
               WHERE cid = 2);
  
1 - 100, 400
2 - 100, 200


2항 연산자 : 1 + 2
3항 연산자 int a = b == c ? 1 : 2;

EXISTS 연산자 : 조건을 만족하는 서브 쿼리의 행이 존재하면 TRUE

매니저가 존재하는 사원 정보 조회
SELECT *
FROM emp e
WHERE EXISTS ( SELECT 'X'
               FROM emp m
               WHERE e.mgr = m.empno);
               
SELECT *
FROM emp e
WHERE EXISTS ( SELECT 'X'
               FROM emp m
               WHERE 1 = 2);               


SELECT *
FROM emp e
WHERE mgr IS NOT NULL;


sub9] 4개의 제품중 1번고객이 먹는 제품만 조회

SELECT *
FROM product
WHERE EXISTS (SELECT *
              FROM cycle
              WHERE cid = 1
              AND pid = product.pid );
              
sub10] 1번 고객이 먹지 않는 제품 정보 조회              
SELECT *
FROM product
WHERE NOT EXISTS (SELECT *
                 FROM cycle
                 WHERE cid = 1
                  AND pid = product.pid );


SELECT *
FROM product
WHERE pid = 100;

WHERE EXISTS (SELECT *
              FROM cycle
              WHERE cid = 1
              AND pid = 100 );


집합연산자 : 알아두자
수학의 집합 연산
A = { 1, 3, 5 }
B = { 1, 4, 5 }

합집합 : A U B = {1, 3, 4, 5} (교환법칙 성립 A U B  ==  B U A)
교집합 : A ^ B = {1, 5}  (교환법칙 성립 A ^ B == B ^ A) 
차집합 : A - B = {3}  (교환법칙 성립하지 않음 A - B   != B - A )
        B - A = {4}

SQL에서의 집합 연산자
합집합 : UNION      : 수학적 합집합과 개념이 동일(중복을 허용하지 않음)
                     중복을 체크 ==> 두 집합에서 중복된 값을 확인 ==> 연산이 느림
        UNION ALL  : 수학접 합집합 개념을 떠나 두개의 집합을 단순히 합친다
                     (중복 데이터 존재가능)
                     중복 체크 없음 ==> 두 집합에서 중복된 값 확인 없음 ==> 연산이 빠름
                     ** 개발자가 두개의 집합에 중복되는 데이터가 없다는 것을 알 수 있는
                     상황이라면 UNION 연산자를 사용하는 것보다 UNION ALL 을 사용하여
                     (오라클이 하는)연산을 절약할 수 있다
     INTERSECT : 수학적 교집합 개념과 동일
     MINUS : 수학접 차집합 개념과 동일

위아래 집합이 동일하기 때문에 합집합을 하더라도 행이 추가되진 않는다     
SELECT empno, ename
FROM emp
WHERE deptno = 10
UNION
SELECT empno, ename
FROM emp
WHERE deptno = 10;


위아래 집합에서 7369번사번은 중복되므로 한번만 나오게 된다 : 전체 행은 3건
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7566)
UNION
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7782);

UNION ALL 연산자는 중복제거 단계가 없다. 총 데이터 4개의 행
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7566)
UNION ALL
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7782);

두집합의 공통된 부분은 7369행 밖에 없음 : 총 데이터 1행
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7566)
INTERSECT
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7782);

윗쪽 집합에서 아래쪽 집합의 행을 제거하고 남은 행 : 1개의 행(7566)
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7566)
MINUS
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7782);


집합연산자 특징
1. 컬럼명은 첫번째 집합의 컬럼명을 따라간다
2. order by 절은 마지막 집합에 적용 한다
   마지막 sql이 아닌 SQL에서 정렬을 사용하고 싶은 경우 INLINE-VIEW를 활용
   UNION ALL의 경우 위, 아래 집합을 이어 주기 때문에 집합의 순서를 그대로 유지
   하기 때문에 요구사항에 따라 정렬된 데이터 집합이 필요하다면 해당 방법을 고려
SELECT empno e, ename
FROM emp
WHERE empno IN ( 7369, 7566)
--ORDER BY ename
UNION ALL
SELECT empno, ename
FROM emp
WHERE empno IN ( 7369, 7782)
ORDER BY ename;