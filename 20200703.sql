SELECT empno, ename, sal, emp.deptno, dname, sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500;
  
SELECT empno, ename, sal, emp.deptno, dname, sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500
  AND empno > 7600
  AND dnamw = 'RESEARCH';


join1]
oracle
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;


ansi-SQL 두 테이블의 연결 컬럼명이 다르기 때문에 
NATURAL JOIN, JOIN with USING은 사용이 불가

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu);

join2]
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

ANSI-SQL
FROM 테이블 1 JOIN 테이블2 ON ()


join3]
member, cart, prod
oracle

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
  AND cart.cart_prod = prod.prod_id; 
  
SELECT a.*, prod_id, prod_name
FROM
    (SELECT mem_id, mem_name, cart_prod, cart_qty
     FROM member, cart
     WHERE member.mem_id = cart.cart_member ) a, prod
WHERE a.cart_prod = prod.prod_id; 
    
ANSI-SQL

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON ( member.mem_id = cart.cart_member ) 
            JOIN prod ON (cart.cart_prod = prod.prod_id); 

CUSTOMER : 고객
PRODUCT : 제품
CYCLE(주기) : 고객 제품 애음 주기

SELECT *
FROM cycle;


join4]
SELECT customer.*, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
  AND customer.cnm IN ('brown', 'sally');

join5]
SELECT customer.*, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND customer.cnm IN ('brown', 'sally');

join6]
SELECT customer.*, cycle.pid, pnm, SUM(cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, pnm;

15 조인 ==> 6 group
15 => 6 group ==> join
(SELECT cid, pid, SUM(cnt)
 FROM cycle
 GROUP BY cid, pid) cycle, customer, prodcut;

join7]
SELECT cycle.pid, pnm, SUM(cnt)
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, pnm;


조인 성공 여부로 데이터 조회를 결정하는 구분방법
INNER JOIN : 조인에 성공하는 데이터만 조회하는 조인 방법
OUTTER JOIN : 조인에 실패 하더라도, 개발자가 지정한 기준이 되는 테이블의
               데이터는 나오도록 하는 조인
OUTTER <==> INNER JOIN

복습 - 사원의 관리자 이름을 알고싶은 상황
조회 컬럼 : 사원의 사번, 사원의 이름, 사원의 관리자의 사번, 사원의 관리자의 이름

동일한 테이블끼리 조인 되었기 때문에 : SELF-JOIN
조인 조건을 만족하는 데이터만 조회 되었기 때문에 : INNER-JOIN
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

KING의 경우 PRESIDENT이기 때문에 mgr 컬럼의 값이 NULL ==> 조인에 실패
==> KING의 데이터는 조회되지 않음 (총 14건 데이터중 13건의 데이터만 조인 성공)

OUTER 조인을 이용하여 조인 테이블중 기준이 되는 테이블을 선택하면
조인에 실패하더라도 기준 테이블의 데이터는 조회 되도록 할 수 있다
LEFT / RIGHT OUTER

ANSI-SQL
테이블1 JOIN 테이블2 ON (.....)
테이블1 LEFT OUTER JOIN 테이블2 ON (.....)
위 쿼리는 아래와 동일
테이블2 RIGHT OUTER JOIN 테이블1 ON (.....)

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);





