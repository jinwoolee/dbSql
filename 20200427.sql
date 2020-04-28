grp7]
dept 테이블을 확인하면 총 4개의 부서 정보가 존재 ==> 회사내에 존재하는 모든 부서정보
emp 테이블에서 관리되는 직원들이 실제 속한 부서정보의 개수 ==> 10, 20, 30 ==> 3개

SELECT COUNT(*)cnt
FROM 
    (SELECT COUNT(*) cnt
     FROM
        (SELECT deptno  /*deptno 컬럼이 1개 존재, row는 3개인 테이블 */
         FROM emp
         GROUP BY deptno));

DBMS ≒ RDBMS         
DBMS : DataBase Management System
 ==> db
RDBMS : Relational DataBase Management System
 ==> 관계형 데이터베이스 관리 시스템
      80년 초반


SELECT *
FROM emp;

SELECT *
FROM dept;

JOIN 문법의 종류
ANSI - 표준
벤더사의 문법(ORACLE)

JOIN의 경우 다른 테이블의 컬럼을 사용할 수 있기 때문에
SELECT 할수 있는 컬럼의 개수가 많아진다(가로 확장)

집합연산 ==> 세로 확장 (행이 많아진다)


NATURAL JOIN
    . 조인하려는 두 테이블의 연결고리 컬럼의 이름 같을 경우
    . emp, dept 테이블에는 detpno라는 공통된(동일한 이름의, 타입도 동일) 연결고리 컬럼이 존재
    . 다른 ANSI-SQL 문법을 통해서 대체가 가능하고, 조인 테이블들의 컬럼명이 동일하지 않으면
      사용이 불가능하기 때문에 사용빈도는 다소 낮다

.emp 테이블 : 14건
.dept 테이블 : 4건

SELECT *
FROM dept;

조인 하려고하는 컬럼을 별도 기술하지 않음
SELECT *
FROM emp NATURAL JOIN dept;


ORALCE 조인 문법을 ANSI 문법처럼 세분하 하지 않음
오라클 조인 문법
 1. 조인할 테이블 목록을 FROM 절에 기술하며 구분자는 콜론(,)
 2. 연결고리 조건을 WHERE절에 기술하면 된다 (ex : WHERE emp.deptno = dept.deptno)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno가 10번인 직원들만 dept 테이블과 조인 하여 조회

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno = 10;


ANSI-SQL : JOIN with USING
 . join 하려는 테블간 이름이 같은 컬럼이 2개 이상일 때
 . 개발자가 하나의 컬럼으로만 조인하고 싶을 때 조인 컬럼명을 기술

SELECT *
FROM emp JOIN dept USING (deptno)
 
 
ANSI-SQL : JOIN with ON
 . 조인 하려는 두 테이블간 컬럼명이 다를 때
 . ON절에 연결고리 조건을 기술;

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
ORALCE 문법으로 위 SQL을 작성 
 
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno; 


JOIN의 논리적인 구분
SELF JOIN : 조인하려는 테이블이 서로 같을 때
EMP 테이블의 한행은 직원의 정보를 나타내고 직원의 정보중 mgr 컬럼은 해당 직원의 관리자 사번을 관리.
해당 직원의 관리자의 이름을 알고싶을 때
 
ANSI-SQL로 SQL 조인 : 
조인하려고 하는 테이블 EMP(직원),EMP(직원의 관리자)
              연결고리 컬럼: 직원.MGR = 관리자.EMPNO
               ==> 조인 컬럼 이름이 다르다(MGR, EMPNO)  
                    ==> NATURAL JOIN, JOIN with USING은 사용이 불가능한 형태
                        ==> JOIN with ON
 
ANSI-SQL로 작성;

SELECT *
FROM emp e JOIN emp m ON (e.mgr = m.empno);
 
 
NONEQUI JOIN : 연결고리 조건이 =이 아닐때 

그동안 WHERE에서 사용한 연산자 : =, !=, <>, <=, <, >, >=
                             AND, OR, NOT
                             LIKE %, _
                             OR - IN
                             BETWEEN AND ==>  >=, <=

SELECT *
FROM emp;

SELECT *
FROM salgrade;
 
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON ( emp.sal BETWEEN salgrade.losal AND salgrade.hisal )

==> ORACLE 조인 문법으로 변경;
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

 
 
join0]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
 
join0_1]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND dept.deptno IN (10, 30)
  AND emp.deptno IN (10, 30); 
 
 
join0_2]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500;
   
 
join0_3~4]과제

생각해보기
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno <= dept.deptno;

emp : 14
dept : 4  (3)

