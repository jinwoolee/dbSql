--emp 테이블에는 부서번호(deptno)만 존재
--emp 테이블에서 부서명을  조회하기 위해서는
--dept 테이블과 조인을 통해 부서명 조회

--조인 문법 
--ANSI : 테이블 JOIN 테이블2 ON (테이블.COL = 테이블2.COL)
--       emp JOIN dept ON (emp.deptno = dept.deptno)
--ORALCE : FORM 테이블, 테이블2 WHERE 테이블.col = 테이블2.col
--        FROM emp, dpet WHERE emp.deptno = dept.deptno

--사원번호, 사원명, 부서번호, 부서명
SELECT empno, ename, dept.deptno, dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;


--join0_2
SELECT empno, ename, sal, dept.deptno, dname
FROM emp JOIN dept ON ( emp.deptno = dept.deptno )
WHERE sal > 2500;

SELECT empno, ename, sal, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND  sal > 2500;

--join0_3
SELECT empno, ename, sal, dept.deptno, dname
FROM emp JOIN dept ON ( emp.deptno = dept.deptno )
WHERE sal > 2500
AND empno > 7600;

SELECT empno, ename, sal, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND  sal > 2500
AND empno > 7600;

--join0_4
SELECT empno, ename, sal, dept.deptno, dname
FROM emp JOIN dept ON ( emp.deptno = dept.deptno )
WHERE sal > 2500
AND empno > 7600
AND emp.deptno = 20;

SELECT empno, ename, sal, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND  sal > 2500
AND empno > 7600
AND emp.deptno = 20;



--join1
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu);

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

--join2
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id);

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

--join3
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member join cart ON (MEMBER.MEM_ID = cart.cart_member)
     JOIN prod on (cart.cart_prod = prod.prod_id);
  
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM cart, member, prod
WHERE member.mem_id = cart.cart_member
AND prod.prod_id = cart.cart_prod;


--join4
SELECT customer.cid, cnm, cycle.pid, day, cnt
FROM customer join cycle ON (customer.cid = cycle.cid)
WHERE cnm in ('brown', 'sally');

SELECT customer.cid, cnm, cycle.pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
AND cnm in ('brown', 'sally');

SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer join cycle ON (customer.cid = cycle.cid)
JOIN product ON (cycle.pid = product.pid)
WHERE cnm in ('brown', 'sally');

SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND  cycle.pid = product.pid
AND cnm in ('brown', 'sally');

--join 6
SELECT customer.cid, cnm, cycle.pid, pnm, sum(cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND  cycle.pid = product.pid
GROUP BY customer.cid, cnm, cycle.pid, pnm;


SELECT customer.cid, cnm, product.pid, pnm, cnt
FROM
(SELECT cid, pid, sum(cnt) cnt
FROM cycle
GROUP BY cid, pid) a, customer, product
WHERE a.cid = customer.cid
AND a.pid = product.pid;

--고객, 제품별 애음건수 (요일과 관계없이)

SELECT customer.cid, cnm, product.pid, pnm, cnt
FROM 
    (SELECT cid, pid, SUM(cnt) cnt
    FROM cycle
    GROUP BY cid, pid) cycle_groupby, customer, product
WHERE cycle_groupby.cid = customer.cid
AND cycle_groupby.pid = product.pid;


--join7
SELECT cycle.pid, pnm, cnt --SUM(cnt) cnt
FROM cycle JOIN product ON (cycle.pid = product.pid)
ORDER BY cycle.pid, pnm;

SELECT cycle.pid, pnm, SUM(cnt) cnt
FROM cycle JOIN product ON (cycle.pid = product.pid)
GROUP BY cycle.pid, pnm;

SELECT cycle.pid, pnm, SUM(cnt) cnt
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, pnm;

SELECT cycle.pid, pnm, cnt
FROM (SELECT pid, SUM(cnt) cnt 
      FROM cycle 
      GROUP BY pid) cycle , product
WHERE cycle.pid = product.pid;


SELECT empno, count(*)
FROM emp
GROUP BY empno;







