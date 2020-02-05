SUB4;
dept 테이블에는 5건의 데이터가 존재
emp 테이블에는 14명의 직원이 있고, 직원은 하나의 부서 속해 있다(deptno)
부서중 직원이 속해 있지 않은 부서 정보를 조회

서브쿼리에서 데이터의 조건이 맞는지 확인자 역할을 하는 서브쿼리 작성;

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                     GROUP BY deptno);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno
                     FROM emp);                     

sub5
모든 제품은 다음 4가지;
SELECT *
FROM product;

cid=1인 고객이 애음하는 제품;
SELECT pid
FROM cycle
WHERE cid = 1;

SELECT *
FROM product 
WHERE pid NOT IN (100, 400);

SELECT *
FROM product 
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);

sub6
cid=2인 고객이 애음하는 제품중 cid=1인 고객도 애음하는 제품의 애음정보를 조회하는 쿼리 작성;

cid=1인 고객의 애음정보 ==> 100, 400번 제품을 애음중;
SELECT *
FROM cycle
WHERE cid = 1;

cid=2인 고객이 애음하는 제품 ==> 100, 200 제품을 애음중;
SELECT pid
FROM cycle
WHERE cid = 2;

cid =1, cid=2인 고객이 동시에 애음하는 제품은 100번;
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN ( SELECT pid
             FROM cycle
             WHERE cid = 2 );

sub7 : sub6번 문제에서 제품명을 추가;

SELECT a.cid, customer.cnm, a.pid, product.pnm, a.day, a.cnt
FROM 
    (SELECT *
    FROM cycle
    WHERE cid = 1
    AND pid IN ( SELECT pid
                 FROM cycle
                 WHERE cid = 2 )) a, customer, product
WHERE a.cid = customer.cid
AND   a.pid = product.pid;

SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.pid IN ( SELECT pid
                   FROM cycle
                   WHERE cid = 2 )
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;


SELECT cycle.cid, (SELECT cnm FROM customer WHERE cid = cycle.cid) cnm,
       cycle.pid, (SELECT pnm FROM product WHERE pid = cycle.pid) pnm,
       cycle.day, cycle.cnt
FROM cycle
WHERE cid = 1
AND pid IN ( SELECT pid
             FROM cycle
             WHERE cid = 2 );
             
             
매니저가 존재하는 직원을 조회(KING을 제외한 13명의 데이터가 조회);
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

EXSITS 조건에 만족하는 행이 존재 하는지 확인하는 연산자
다른 연산자와 다르게 WHERE 절에 컬럼을 기술하지 않는다
  . WHERE empno = 7369
  . WHERE EXISTS (SELECT 'X'  
                  FROM .....);

매니저가 존재하는 직원을 EXISTS 연산자를 통해 조회
매니저도 직원;
SELECT empno, ename, mgr
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);
              
sub9
1번 고객이 애음하는 제품 ==> 100, 400;
SELECT *
FROM cycle
WHERE cid = 1;

100	야쿠르트 (O)
200	윌 (X)
300	쿠퍼스 (X)
400	야쿠르트400 (O);

SELECT *
FROM cycle
WHERE cid = 1;

DELETE cycle
WHERE cid = 1
AND pid = 400;
ROLLBACK;

SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid = product.pid);

sub10;              
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid = product.pid);              

집합연산
합집합 : UNION - 중복제거(집합개념) / UNION ALL - 중복을 제거하지 않음(속도 향상)
교집합 : INTERSECT (집합개념)
차집합 : MINUS (집합개념)
집합연산 공통사항
두 집합의 컬럼의 개수, 타입이 일치 해야 한다;

동일한 집합을 합집하기 때문에 중복되는 데이터는 한번만 적용된다
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


UNION ALL연산자는 UNION 연산자와 다르게 중복을 허용한다;
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


INTERSECT (교집합) : 위, 아래 집합에서 값이 같은 행만 조회
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369);


MINUS(차집합) : 위 집합에서 아래 집합의 데이터를 제거한 나머지 집합;
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

집합의 기술 순서가 영향이 가는 집합연산자
A UNION B        B UNION A ==> 같음
A UNION ALL B    B UNION ALL A ==> 같음(집합)
A INTERSECT B    B INTERSECT A ==> 같음
A MINUS B        B MINUS A     ==> 다름;

집합연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다;
SELECT 'X' fir, 'B' sec
FROM dual

UNION 

SELECT 'Y', 'A' 
FROM dual;

정렬(ORDER BY )는 집합연산 가장 마지막 집합 다음에 기술;

SELECT deptno, dname, loc
FROM (SELECT deptno, dname, loc
      FROM dept
      WHERE deptno IN (10, 20)
      ORDER BY DEPTNO)

UNION 

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (30, 40)
ORDER BY DEPTNO;




햄버거 도시 발전지수;

SELECT *
FROM fastfood;

버거지수 ==> (kfc개수 + 버거킹 개수 + 맥도날드 개수) / 롯데리아 개수
시도, 시군구, 버거지수
버거지수 값이 높은 도시가 먼저 나오도록 정렬;

쿼리를 작성하지 못하신 분은 아래 다섯개의 시군구 별 버거지수를 수기로 구해주세요;
대전시 대덕구 버거지수 :  1.5
대전시 중구 버거지수 : 
대전시 서구 버거지수 : 
대전시 유성구 버거지수 : 
대전시 동구 버거지수 : 
