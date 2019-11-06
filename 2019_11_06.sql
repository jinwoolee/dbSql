--그룹함수
--multi row function : 여러개의 행을 입력으로 하나의 결과 행을 생성
--SUM, MAX, MIN, AVG, COUNT
--GROUP BY col | express
--SELECT 절에는 GROUP BY 절에 기술된 COL, EXRPESS 표기 가능

--직원중 가장 높은 급여 조회
-- 14개의 행이 입력으로 들어가 하나의 결과가 도출
SELECT MAX(sal) max_sal
FROM emp;

--부서별로 가장 높은 급여 조회
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno;

SELECT *
FROM dept;


--grp3
SELECT /*decode(deptno, 10, 'ACCOUNTING', 
                      20, 'RESEARCH', 
                      30, 'SALES', 
                      40, 'OPERATIONS', 
                                'DDIT') dname, */
                                deptno,
       MAX(sal) max_sal, MIN(sal) min_sal,ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal, COUNT(sal) count_sal,
       COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno;
                                
--grp4
SELECT to_char(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*)cnt
FROM emp
GROUP BY to_char(hiredate, 'YYYYMM');

SELECT to_char(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*)cnt
FROM emp
GROUP BY hiredate;

SELECT to_char(hiredate, 'yyyymm'), to_char(hiredate, 'YYYYMM')
FROM emp
ORDER BY hiredate;

--grp5
SELECT to_char(hiredate, 'YYYY') hire_yyyymm, COUNT(*)cnt
FROM emp
GROUP BY to_char(hiredate, 'YYYY')
ORDER BY to_char(hiredate, 'YYYY');

--grp6
SELECT COUNT(deptno) cnt, count(*) cnt
FROM dept;


--JOIN
--emp 테이블에는 dname 컬럼이 없다 --> 부서번호(deptno)밖에 없음
desc emp;

--emp테이블에 부서이름을 저장할수 있는 dname 컬럼 추가
ALTER TABLE emp ADD (dname VARCHAR2(14));

SELECT *
FROM emp;

/*10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON*/
UPDATE emp SET dname ='ACCOUNTING' WHERE DEPTNO=10;
UPDATE emp SET dname ='RESEARCH' WHERE DEPTNO=20;
UPDATE emp SET dname ='SALES' WHERE DEPTNO=30;
COMMIT;

SELECT dname, MAX(sal) max_sal
FROM emp
GROUP BY dname;

ALTER TABLE emp DROP COLUMN DNAME;

SELECT *
FROM emp;

--ansi natural join : 테이블의 컬럼명이 같은 컬럼을 기준으로 JOIN
SELECT DEPTNO, ENAME, DNAME
FROM EMP NATURAL JOIN DEPT;

--ORACLE join
SELECT emp.empno, emp.ename, emp.deptno, dept.dname, dept.loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;


--ANSI JOING WITH USING
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept USING (deptno);

--from 절에 조인 대상 테이블 나열
--where절에 조인조건 기술
--기존에 사용하던 조건 제약도 기술가능
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.job ='SALESMAN'; --job이 SALES인 사람만 대상으로 조회

--JOIN with ON (개발자가 조인 컬럼을 on절에 직접 기술)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF join : 같은 테이블끼리 조인
--emp테이블의 mgr 정보를 참고하기 위해서 emp 테이블과 조인을 해야한다
--a : 직원 정보, b : 관리자
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno)
WHERE a.empno between 7369 AND 7698;

--oracle
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno;
--AND   a.empno between 7369 AND 7698;

select empno, ename, mgr
 from emp;

--non-equijoing (등식 조인이 아닌경우)
SELECT *
FROM salgrade;

--직원의 급여 등급은????
SELECT empno, ename, sal
FROM emp;

SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal );

SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--non equi join
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno = 7369;

--JOIN0
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno in (7369, 7499, 7521);


--JOIN0_1
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND   emp.deptno in (10, 30);

SELECT empno, ename, deptno
FROM emp;

SELECT *
FROM dept;