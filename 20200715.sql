오라클 객체(object)
 table - 데이터 저장 공간
  . ddl 생성, 수정, 삭제
 view - sql(쿼리다) 논리적인 데이터 정의, 실체가 없다
        view 구성하는 테이블의 데이터가 변경되면 view 결과도 달라지더라
 sequence - 중복되지 않는 정수값을 반환해주는 객체
             유일한 값이 필요할 때 사용할 수 있는 객체
             nextval, currval
 index - 테이블의 일부 컬럼을 기준으로 미리 정렬해 놓은 데이터             
         ==> 테이블 없이 단독적으로 생성 불가, 특정 테이블에 종속
             table 삭제를 하면 관련 인덱스도 같이 삭제
             
DESC emp;             
YYYYMMDD ==> 문자열로 8BYTE

8kb = 1024 * 8 = 8000byte
40 * 200 = 8000, 8bk block 하나에는 40byte 행 정보가 200건 정도 입력 가능

DB 구조에서 중요한 전제 조건
1. DB에서 I/O의 기준은 행단위가 아니라 block 단위
   한건의 데이터를 조회하더라도, 해당 행이 존재하는 block 전체를 읽는다

데이터 접근 방식
1. table full access
   multi block io ==> 읽어야 할 블럭을 여러개를 한번에 읽어 들이는 방식
                       (일반적으로 8~16 block)
   사용자가 원하는 데이터의 결과가 table의 모든 데이터를 다 읽어야 처리가 가능한경우
   ==> 인덱스 보다 여러 블럭을 한번에 많이 조회하는 table full access 방식이 유리 할
   수 있다
   ex : 
   전제조건은 mgr, sal, comm 컬럼으로 인덱스가 없을 때
   mgr, sal, comm 정보를 table에서만 획득이 가능할 때
   SELECT COUNT(mgr), SUM(sal), SUM(comm), AVG(sal)
   FROM emp;
   
   
2. index 접근, index 접근후 table access
   single block io ==> 읽어야할 행이 있는 데이터 block만 읽어서 처리하는 방식
   소수의 몇건 데이터를 사용자가 조회할 경우, 그리고 조건에 맞는 인덱스가 존재할 경우
   빠르게 응답을 받을 수 있다
   
   하지만 single block io가 빈번하게 하게 일어나면 multi block io보다 오히려 느리다
   
2. extent, 공간할당 기준   
   

현재 상태 
인덱스 : IDX_NU_emp_01 (empno)

emp 테이블의 job 컬럼을 기준으로 2번째 NON-UNIQUE 인덱스 생성
CREATE INDEX idx_nu_emp_02 ON emp (job);

현재 상태 
인덱스 : idx_nu_emp_01 (empno), idx_nu_emp_02 (job)
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3525611128
 
---------------------------------------------------------------------------------------------
| Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |               |     1 |    36 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP           |     1 |    36 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_NU_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------
 2 - 1 - 0
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER')
   
   
인덱스 추가 생성
emp 테이블의 job, ename 컬럼으로 복합 non-unique index 생성
idx_nu_emp_03
CREATE INDEX idx_nu_emp_03 ON emp (job, ename);
현재 상태 
인덱스 : idx_nu_emp_01 (empno), idx_nu_emp_02 (job), idx_nu_emp_03(job, ename)

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';


SELECT job, ename, ROWID
FROM emp
ORDER BY job, ename;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 1746703018
 
---------------------------------------------------------------------------------------------
| Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |               |     1 |    36 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP           |     1 |    36 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_NU_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')


현재 상태 
인덱스 : idx_nu_emp_01 (empno), idx_nu_emp_02 (job), idx_nu_emp_03(job, ename)

위에 쿼리와 변경된 부분은 LIKE 패턴이 변경
LIKE 'C%' ==> LIKE '%C'

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE '%C'
  
 SELECT *
FROM TABLE(dbms_xplan.display); 

Plan hash value: 1746703018
 
---------------------------------------------------------------------------------------------
| Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |               |     1 |    36 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP           |     1 |    36 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_NU_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------
 Predicate Information (identified by operation id):
---------------------------------------------------
    2 - access("JOB"='MANAGER')
       filter("ENAME" LIKE '%C' AND "ENAME" IS NOT NULL)
       
DESC emp;       

인덱스 추가
emp 테이블에 ename, job 컬럼을 기준으로 non-unique 인덱스 생성(idx_nu_emp_04)
CREATE INDEX idx_nu_emp_04 ON emp (ename, job);
현재 상태 
인덱스 : idx_nu_emp_01 (empno) 
        idx_nu_emp_02 (job)
        idx_nu_emp_03 (job, ename) ==> 삭제
        idx_nu_emp_04 (ename, job) : 복합 컬럼의 인덱스의 컬럼순서가 미치는 영향

DROP INDEX idx_nu_emp_03;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);        


Plan hash value: 2258096460
 
---------------------------------------------------------------------------------------------
| Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |               |     1 |    36 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP           |     1 |    36 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_NU_EMP_04 |     1 |       |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------
 Predicate Information (identified by operation id):
---------------------------------------------------
    2 - access("ENAME" LIKE 'C%' AND "JOB"='MANAGER')
       filter("JOB"='MANAGER' AND "ENAME" LIKE 'C%')        
       
       
       
조인에서의 인덱스 활용
emp : pk_emp, fk_emp_dept 생성
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) 
                                            REFERENCES dept (deptno);
emp : pk_emp (empno), idx_.....
dept : pk_dept (deptno)

접근방식 : emp 1.table full access, 2. 인덱스 * 4 : 방법 5가지 존재
          dept 1.table full_access, 2. 인덱스 * 1 : 방법 2가지
          가능한 경우의 수가 10가지
          방향성 emp, dept를 먼저 처리할지 ==> 20
          
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE 20 = dept.deptno
  AND emp.empno IN ( 7788, 7398);

SELECT *
FROM TABLE(dbms_xplan.display);                                            

Plan hash value: 999219729
 
-----------------------------------------------------------------------------------------------
| Id  | Operation                     | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |               |     1 |    54 |     2   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                 |               |       |       |            |          |
|   2 |   NESTED LOOPS                |               |     1 |    54 |     2   (0)| 00:00:01 |
|*  3 |    TABLE ACCESS BY INDEX ROWID| EMP           |     1 |    36 |     1   (0)| 00:00:01 |
|*  4 |     INDEX RANGE SCAN          | IDX_NU_EMP_01 |     1 |       |     0   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN          | PK_DEPT       |     1 |       |     0   (0)| 00:00:01 |
|   6 |   TABLE ACCESS BY INDEX ROWID | DEPT          |     8 |   144 |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------
 4 - 3 - 5 - 2 - 6 - 1 - 0 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - filter("EMP"."DEPTNO" IS NOT NULL)
   4 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   
   
EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;
  
SELECT *
FROM TABLE(dbms_xplan.display);   

Plan hash value: 844388907
 
----------------------------------------------------------------------------------------
| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |         |    13 |   702 |     6  (17)| 00:00:01 |
|   1 |  MERGE JOIN                  |         |    13 |   702 |     6  (17)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     8 |   144 |     2   (0)| 00:00:01 |
|   3 |    INDEX FULL SCAN           | PK_DEPT |     8 |       |     1   (0)| 00:00:01 |
|*  4 |   SORT JOIN                  |         |    14 |   504 |     4  (25)| 00:00:01 |
|*  5 |    TABLE ACCESS FULL         | EMP     |    14 |   504 |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------------------
 3 - 2 - 5 - 4 - 1 - 0
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
       filter("EMP"."DEPTNO"="DEPT"."DEPTNO")
   5 - filter("EMP"."DEPTNO" IS NOT NULL)
   
   
idx1]
CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1=1;
deptno [unique] / dname [non-unique] / dpetno, dname [non-unique]
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_nu_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_nu_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_nu_dept_test2_02;
DROP INDEX idx_nu_dept_test2_03;

idx3]

CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_nu_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_nu_dept_test2_03 ON dept_test2 (deptno, dname);



idx3] : 정답 없음
access pattern 분석
1. empno(=)
2. ename(=)
3. deptno(=), empno (LIKE)
4. deptno(=), sal(between)
5. deptno(=)
   empno(=)
6. deptno, hiredate 컬럼으로 구성된 인덱스가 있을경우 table 접근이 필요 없음

3. deptno(=), empno (LIKE)
4. deptno(=), sal(between)
6. deptno, hiredate 컬럼으로 구성된 인덱스가 있을경우 table 접근이 필요 없음

1] empno
2] ename
3] deptno, empno
4] deptno, sal
5] deptno, hiredate

1] empno
2] ename
3] deptno, empno, sal, hiredate

emp테이블에 데이터가 5천만건
10, 20, 30 데이터는 각각 50건씩만 존재 ==> 인덱스
40번데이터 4850만건 ==> table full access


SYNONYM : 오라클 객체체 별칭을 생성
sem.v_emp => v_emp

생성방법
CREATE [PUBLIC] SYNONYM 시노님이름 FOR 원본객체이름;
PUBLIC : 모든 사용자가 사용할 수 있는 시노님
         권한이 있어야 생성가능
PRIVATE [DEFAULT] : 해당 사용자만 사용할 수 있는 시노님         

삭제방법
DROP SYNONYM 시노님이름;

