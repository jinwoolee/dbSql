--emp 테이블에 empno컬럼을 기준으로 PRIMARY KEY를 생성
--PRIMARY KEY = UNIQUE + NOT NULL
--UNIQUE ==> 해당 컬럼으로 UNIQUE INDEX를 자동으로 생성

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);


Plan hash value: 2949544139
 --------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    37 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    37 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 Predicate Information (identified by operation id):
---------------------------------------------------
    2 - access("EMPNO"=7782)
    
    
--empno 컬럼으로 인덱스가 존재하는 상황에서
--다른컬럼 값으로 데이터를 조회 하는 경우
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     3 |   111 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     3 |   111 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("JOB"='MANAGER')


--인덱스 구성 컬럼만 SELECT 절에 기술한경우
--테이블 접근이 필요 없다

EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 56244932
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |     1 |     4 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_EMP |     1 |     4 |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMPNO"=7782)


--컬럼에 중복이 가능한 non-unique 인덱스 생성후
--unique index와의 실행계획 비교
--PRIMARY KEY 제약조건 삭제(unique 인덱스 삭제)
ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX /*UNIQUE*/ IDX_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 4208888661
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    37 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    37 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)


--emp 테이블에 job 컬럼으로 두번째 인덱스 생성 (non-unique index)
--job 컬럼은 다른 로우의 job 컬럼과 중복이 가능한 컬럼이다
CREATE INDEX idx_emp_02 ON emp (job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     3 |   111 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     3 |   111 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')



EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    37 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    37 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER')


--emp 테이블에 job, ename 컬럼을 기준으로 non-unique 인덱스 생성
CREATE INDEX IDX_emp_03 ON emp (job, ename);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);


Plan hash value: 2549950125
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    37 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    37 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')

--emp 테이블에 ename, job 컬럼으로 non-unique 인덱스 생성
CREATE INDEX IDX_EMP_04 ON emp (ename, job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE '%C';


SELECT *
FROM TABLE(dbms_xplan.display);       

Plan hash value: 4060516099
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    37 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    37 |     2   (0)| 00:00:01 |
|*  2 |   INDEX SKIP SCAN           | IDX_EMP_04 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')
       filter("JOB"='MANAGER' AND "ENAME" LIKE '%C' AND "ENAME" IS NOT NULL)
       
       
       
--HINT를 사용한 실행계획 제어
EXPLAIN PLAN FOR
SELECT /*+ INDEX ( emp2 idx_emp_01 ) */ *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE '%C';

SELECT *
FROM TABLE(dbms_xplan.display);       

Plan hash value: 4060516099
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    37 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    37 |     2   (0)| 00:00:01 |
|*  2 |   INDEX SKIP SCAN           | IDX_EMP_04 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')
       filter("JOB"='MANAGER' AND "ENAME" LIKE '%C' AND "ENAME" IS NOT NULL)
       


--idx1, 2
--dept_test 테이블 생성
CREATE TABLE dept_test AS
SELECT *
FROM dept
WHERE 1=1;

--deptno 컬럼 기준으로 unique 인덱스 생성
CREATE UNIQUE INDEX idx_u_dept_test_01 ON dept_test (deptno);
DROP INDEX idx_u_dept_test_01;

--dname 컬럼 기준으로 non-unique 인덱스 생성
CREATE INDEX idx_dept_test_02 ON dept_test(dname);
DROP INDEX idx_dept_test_02;

--deptno, dname 컬럼을 기준으로 non-unique 인덱스생성
CREATE INDEX idx_dept_test_03 ON dept_test(deptno, dname);
DROP INDEX idx_dept_test_03;

SELECT deptno, sal, empno
FROM emp
ORDER BY deptno, sal, empno;



