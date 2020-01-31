-- 올해 년도의 짝수 구분과, REG_DT 년도의 짝수 구분이 동일하면 => 건강검진 대상자
-- 올해 년도의 짝수 구분과, REG_DT 년도의 짝수 구분이 동일하지 않으면 => 건강검진 비대상자
SELECT userid, usernm, reg_dt,
    CASE
        WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'),2)= MOD(TO_CHAR(reg_dt, 'YYYY'),2) THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
    END
FROM users;

SELECT userid, usernm, reg_dt,
       MOD(TO_NUMBER(TO_CHAR(reg_dt, 'YYYY')), 2) hire,
       MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2),
       CASE 
            WHEN MOD(TO_NUMBER(TO_CHAR(reg_dt, 'YYYY')), 2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2)
                THEN '건강검진 대상자'
            ELSE '건강검진 비대상자' 
       END CONTACT_TO_DOCTOR,
       DECODE(MOD(TO_NUMBER(TO_CHAR(reg_dt, 'YYYY')), 2), 
                    MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')), 2), '건강검진 대상자', '건강검진 비대상자') con2
FROM users;


SELECT ename, deptno
FROM emp;

SELECT *
FROM dept;

-- JOIN 두 테이블을 연결하는 작업
-- JOIN 문법
-- 1. ANSI 문법
-- 2. ORACLE 문법

-- Natural Join
-- 두 테이블간 컬럼명이 같을 때 해당 컬럼으로 연결(조인)
-- emp, dept 테이블에는 deptno 라는 컬럼이 존재
SELECT *
FROM emp NATURAL JOIN dept;

-- Natural join에 사용된 조언 컬림(deptno)는 한정자(ex: 테이블명, 테이블 별칭)을 사용하지 않고
-- 컬럼명만 기술한다 ( dept.deptno --> deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

-- 테이블에 대한 별칭도 사용가능
SELECT e.empno, e.ename, d.dname, deptno
FROM emp e NATURAL JOIN dept d;

-- ORACLE JOIN
-- FROM 절에 조인할 테이블 목록을 ,로 구분하여 나열한다
-- 조인할 테이블의 연결 조건을 WHERE절에 기술한다
-- emp, dept 테이블에 존재하는 deptno 컬럼이 [같을 때] 조인
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

EXPLAIN PLAN FOR 
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

SELECT *
FROM TABLE(dbms_xplan.display);
Plan hash value: 4192419542

2-3-1-0 
---------------------------------------------------------------------------
| Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |      |    42 |  1764 |    10   (0)| 00:00:01 |
|   1 |  NESTED LOOPS      |      |    42 |  1764 |    10   (0)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| DEPT |     4 |    88 |     3   (0)| 00:00:01 |
|*  3 |   TABLE ACCESS FULL| EMP  |    11 |   220 |     2   (0)| 00:00:01 |
---------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - filter("EMP"."DEPTNO"<>"DEPT"."DEPTNO")
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
   

오라클 조인의 테이블 별칭;
SELECT e.empno, e.ename, d.dname, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;

ANSI : join with USING 
조인 하려는 두개의 테이블에 이름이 같은 컬럼이 두개이지만
하나의 컬럼으로만 조인을 하고자 할때
조인하려는 기준 컬럼을 기술
emp, dept 테이블의 공통 컬럼 : deptno;
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING(deptno);

JOIN WITH USING을 ORACLE로 표현하면?;
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

ANSI : JOIN WITH ON
조인 하려고하는 테이블의 컬럼 이름이 서로 다를때;
SELECT emp.ename, dept.dname, emp.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

JOIN WITH ON --> ORACLE
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELF JOIN : 같은 테이블간의 조인;
예 : emp 테이블에서 관리되는 사원의 관리자 사번을 이용하여
관리자 이름을 조회할때;
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

오라클 문법으로 작성;
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

equal 조인 : = 
non-euqal 조인 : !=, >, <, BETWEEN AND ;

사원의 급여 정보와 급여 등급 테이블을 이용하여
해당사원의 급여 등급을 구해보자;
SELECT ename, sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal 
                  AND salgrade.hisal;

ANSI 문법을 이용하여 위의 조인 문을 작성;
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E JOIN SALGRADE S ON ( E.SAL BETWEEN S.LOSAL AND S.HISAL);


JOIN0;
SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY deptno;

JOIN0_1
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.deptno !=20
ORDER BY deptno;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.deptno IN (10, 30)
ORDER BY deptno;

JOIN0_2;
SELECT e.ename, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal > 2500;

JOIN0_3;
SELECT e.ename, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.sal > 2500
AND e.empno > 7600;

JOIN0_4;
SELECT e.ename, e.ename, e.sal, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.sal > 2500
AND e.empno > 7600
AND d.dname = 'RESEARCH';

PROD : PROD_LGU
LPROD : LPROD_GU;

SELECT *
FROM prod;

SELECT *
FROM lprod;

JOIN1;
PROD : PROD_LGU
LPROD : LPROD_GU;

JOIN2;
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

