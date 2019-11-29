--join0_3
--사원번호, 사원이름, 급여, 부서번호, 부서이름
--사원번호, 사원이름, 급여 : emp
--부서번호 : emp, dept
--부서이름 : dept
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal > 2500
AND emp.empno > 7600;

--join0_4
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal > 2500
AND emp.empno > 7600
AND dept.dname = 'RESEARCH';


SELECT *
FROM dept;


--lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
--join1
--SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM lprod, prod
WHERE lprod_gu = prod_lgu;


--join4
SELECT cycle.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM cycle, customer
WHERE cycle.cid = customer.cid
AND (customer.cnm = 'brown' OR customer.cnm = 'sally');
AND customer.cnm IN ('brown', 'sally');

--join5
SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = customer.cid
AND cycle.pid = product.pid
AND (customer.cnm = 'brown' OR customer.cnm = 'sally');

--join6
SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day , SUM(cycle.cnt) --SUM(cycle.cnt)
FROM cycle, customer, product
WHERE cycle.cid = customer.cid
AND cycle.pid = product.pid
GROUP BY cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day ;
ORDER BY cid, pid;

SELECT a.cid, customer.cnm, a.pid, product.pnm, a.cnt
FROM
    (SELECT cid, pid, SUM(cnt) cnt
     FROM cycle
     GROUP BY cid, pid) a, customer, product
WHERE a.cid = customer.cid
AND a.pid = product.pid;

--join7
SELECT cycle.pid, product.pnm, SUM(cycle.cnt) cnt --SUM(cycle.cnt)
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm;
ORDER BY cid, pid;