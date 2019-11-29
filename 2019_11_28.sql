--emp 테이블, dept 테이블 조인
--4
SELECT *
FROM  dept;

UPDATE dept SET dname = 'MARKET SALES'
WHERE deptno != '30';

SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno=30;

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;


--natural join : 조인 테이블간 같은 타입, 같은이름의 컬럼으로
--               같은 값을 갖을 경우 조인
DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept b;

--oracle 문법
SELECT a.deptno, empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;

--JOIN USING 
--join 하려고하는 테이블간 동일한 이름의 컬럼이 두개 이상일 때
--join 컬럼을 하나만 사용하고 싶을 때

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI JOIN with ON
--조인 하고자 하는 테이블의 컬럼 이름이 다를 때
--개발자가 조인 조건을 직접 제어할 때

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간 조인
--emp 테이블간 조인 할만한 사항 : 직원의 관리자 정보 조회
--직원의 관리자 정보를 조회
--직원이름, 관리자이름

--ANSI
--직원 이름, 직원의 상급자 이름, 직원의 상급자의 상급자 이름
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

MILLER  CLARK  KING

--ORACLE
-- 직원이름, 직원의 관리자 이름, 직원의 관리자의 관리자 이름,
-- 직원의 관리자의 관리자의 관리자이름
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e, emp m, emp t, emp k
WHERE e.mgr = m.empno
AND m.mgr = t.empno
AND t.mgr = k.empno;

--여러테이블을 ANSI JOIN을 이용한 JOIN
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno)
     JOIN emp t ON ( m.mgr = t.empno)
     JOIN emp k ON ( t.mgr = k.empno);


--직원의 이름과, 해당 직원의 관리자 이름을 조회한다
--단 직원의 사번이 7369~7698인 직원을 대상으로 조회
SELECT s.ename, m.ename
FROM emp s, emp m
WHERE s.empno BETWEEN 7369 AND 7698
AND s.mgr = m.empno;

--ANSI 
SELECT s.ename, m.ename
FROM emp s JOIN emp m ON( s.mgr = m.empno )
WHERE s.empno BETWEEN 7369 AND 7698;


--NON-EQUI JOIN : 조인 조건이 =(equal)이 아닌 JOIN
-- != , BETWEEN AND

SELECT *
FROM salgrade;

SELECT empno, ename, sal, grade /* 급여 grade */
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

WHERE emp.sal >= salgrade.losal
AND emp.sal <= salgrade.hisal;


SELECT empno, ename, sal, grade /* 급여 grade */
FROM emp JOIN salgrade ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal ;


--join0
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY emp.deptno;

--join0_1
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND (emp.deptno =10 OR emp.deptno =30)
--AND emp.deptno IN (10, 30)
ORDER BY emp.deptno;

--join0_2
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.sal > 2500;




KING
    CLARK
        MILLER
    BLAKE
        TURNER
        JAMES
        ALLEN
        WARD
        MARTIN
    JONES
        FORD
            SMITH
        SCOTT
            ADMAS



