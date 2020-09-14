 grp4]
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, 
        COUNT(TO_CHAR(hiredate, 'YYYYMM')) CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

GRP5]
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyymm, 
        COUNT(TO_CHAR(hiredate, 'YYYY')) CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');


GRP6]
SELECT COUNT(*)
FROM dept;

GRP7] 직원이 속한 부서의 개수를 구하기
1. 부서가 몇개 존재 하는지?? ==> 3행

SELECT COUNT(*)
FROM
    (SELECT deptno
     FROM emp
     GROUP BY deptno) a;


SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;

join0]
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
ORDER BY emp.deptno;

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY emp.deptno;


SELECT emp.empno, emp.ename, deptno, dept.dname
FROM emp NATURAL JOIN dept
ORDER BY deptno;


join0_1]
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno IN (10, 30)
ORDER BY emp.deptno;

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno = 10 OR emp.deptno = 30
ORDER BY emp.deptno;

join0_2]
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.sal > 2500
ORDER BY emp.deptno;


join0_3]
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.sal > 2500
  AND emp.empno > 7600
ORDER BY emp.deptno;


join0_4]
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.sal > 2500
  AND emp.empno > 7600
  AND dept.dname = 'RESEARCH'
ORDER BY emp.deptno;


%, _

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON ( emp.deptno = dept.deptno)
WHERE emp.deptno LIKE 10 OR emp.deptno LIKE 30;


SELECT COUNT(*) cnt
FROM(
SELECT deptno
FROM emp
GROUP BY deptno);


SELECT lprod_gu, lprod_nm
FROM lprod;

SELECT prod_id, prod_name, prod_lgu
FROM prod;

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM lprod, prod
WHERE prod.prod_lgu = lprod.lprod_gu;

prod 테이블 건수?

SELECT COUNT(*)
FROM prod;

join2]
SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

join3]
join 시 생각할 부분
1. 테이블 기술
2. 연결조건

ORACLE]
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
  AND cart.cart_prod = prod.prod_id;
  
ANSI-SQL]
테이블 JOIN 테이블 ON ()
      JOIN 테이블 ON ()

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member JOIN cart ON ( member.mem_id = cart.cart_member )
            JOIN prod ON ( cart.cart_prod = prod.prod_id );
            
            