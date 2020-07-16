SELECT *
FROM emp
WHERE 1 = 1 AND 1 != 1;
       true     false ==> false
       
SELECT *
FROM emp
WHERE 1 = 1 OR 1 != 1;
      true     false ==> true
      
WHERE deptno NOT IN (10, 20)      
    deptno != 10 AND deptno != 20
    
WHERE deptno IN (10, 20)

DESC ==> DSC

ORDER BY job DESC, hiredate [ASC]


SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

SELECT emp.deptno, MAX(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno IN (SELECT deptno
                     FROM dept)
GROUP BY emp.deptno;

SELECT COUNT(*)
FROM dept;

SELECT COUNT(COUNT(*))
FROM dept
GROUP BY deptno;

SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;


SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                
SELECT *
FROM emp
WHERE deptno = 20;


SELECT empno, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = emp.deptno;

SELECT emp.empno, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;


SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

14 * 4 = 196

emp , dept
14,   8x?

SELECT *
FROM emp, dept
WHERE emp.deptno != dept.deptno;


SELECT empno, ename, 
       (SELECT dname 
        FROM dept 
        WHERE deptno = emp.deptno)
FROM emp;

emp : 1. empno 
      2. deptno, empno, sal
      
dept : 1. deptno, loc
       2. loc
       
CREATE INDEX idx_nu_emp_01 ON emp (empno);
CREATE INDEX idx_nu_emp_02 ON emp (deptno, sal);
CREATE INDEX idx_nu_dept_01 ON dept (deptno, loc);

1. emp : empno(=)(e.1)
2. dept : deptno(=) (d.1)
3. emp : deptno(=), empno(like)
   dept : deptno(=) (d.1)
4. emp : deptno(=), sal(between)  
5. emp : deptno(=)
   dept : deptno(=), [loc(=)] (d.1)
   
   emp : empno(=)(e.1)
   dept : loc(=) (d.2)
   

개발자가 sql을 dbms에 요청을 하더라도
1. 오라클 서버가 항상 최적의 실행계획을 선택할 수는 없음
   (응답성이 중요 하기 때문 : OLTP - 온라인 트랜잭션 프로세싱 
    전체 처리 시간이 중요   :  OLAP - Online Analytical Processing 
                            은행이자 ==> 실행계획세우는 30분이상이 소요 되기도 함)
2. 항상 실행계획을 세우지 않음
   만약에 동일한 SQL이 이미 실행된적이 있으면 해당 SQL의 실행계획을 새롭게 새우지 않고
   Shared pool(메모리)에 존재하는 실행계획을 재사용
   
   동일한 SQL : 문자가 완벽하게 동일한 SQL
                SQL의 실행결과가 같다고 해서 동일한 SQL이 아님
                대소문자를 가리고, 공백도 문자로 취급
  EX : SELECT * FROM emp;
       select * FROM emp; 두개의 sql의 서로 다른 sql로 인식
   
SELECT /* plan_test */ *
FROM emp 
WHERE empno = 7698;

select /* plan_test */ *
FROM emp 
WHERE empno = 7698;

select /* plan_test */ *
FROM emp 
WHERE empno = 7369;

select /* plan_test */ *
FROM emp 
WHERE empno = :empno;


SELECT *
FROM users;

테이블 데이터의 15% 정도까지는 인덱스
1억의 ==>1500만건

3천건을 넘으면 안된다
                            
   LIKE ename LIKE 'S%'
   LIKE ename LIKE '%S'
   
   
DCL :  Data Control Language - 시스템 권한 또는 객체 권한을 부여 / 회수
부여
GRANT 권한명 | 롤명 TO 사용자;
    
회수
REVOKE 권한명 | 롤명 FROM 사용자;





DATA DICTIONARY
오라클 서버가 사용자 정보를 관리하기 위해 저장한 데이터를 볼수 있는 view

CATEGORY(접두어)
USER_ : 해당 사용자가 소유한 객체 조회
ALL_ : 해당 사용자가 소유한 객체 + 권한을 부여받은 객체 조회
DBA_ : 데이터베이스에 설치된 모든 객체(DBA 권한이 있는 사용자만 가능-SYSTEM)
v$ : 성능, 모니터와 관련된 특수 view

SELECT *
FROM dictionary;
   
   
SELECT *
FROM user_tables;

SELECT *
FROM all_tables;

SELECT *
FROM dba_tables;


