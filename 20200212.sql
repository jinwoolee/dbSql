SELECT *
FROM
(SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('CUSTOMER','PRODUCT','CYCLE','DAILY'))A,

(SELECT *
FROM USER_COL_COMMENTS)B
WHERE A.TABLE_NAME = B.TABLE_NAME;

SELECT *
FROM USER_TAB_COMMENTS A, USER_COL_COMMENTS B
WHERE A.TABLE_NAME = B.TABLE_NAME
AND A.TABLE_NAME IN ('CUSTOMER','PRODUCT','CYCLE','DAILY');


1. table full
2. idx1 : empno
3. idx2 : job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job ='MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 1112338291
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER');
   
   
   
CREATE INDEX idx_n_emp_03 ON emp (job, ename);   

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 4225125015
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')

SELECT job, ename, rowid
FROM emp
ORDER BY job, ename;


1.table full
2. idx1 : empno
3. idx2 : job
4. idx3 : job + ename
5. idx4 : ename + job;

CREATE INDEX idx_n_emp_04 ON emp (ename, job);

SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

3번째 인덱스를 지우자 
3, 4번째 인덱스가 컬럼 구성이 동일하고 순서만 다르다;

DROP INDEX idx_n_emp_03;


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 1173072073
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_04 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("ENAME" LIKE 'C%' AND "JOB"='MANAGER')
       filter("JOB"='MANAGER' AND "ENAME" LIKE 'C%');
       

emp - table full, pk_emp(empno)
dept - table full, pk_dept(deptno)

(emp-table full, dept-table full)
(dept-table full, emp-table full)

(emp-table full, dept-pk_dept)
(dept-pk_dept, emp-table full)

(emp-pk_emp, dept-table full)
(dept-table full, emp-pk_emp)

(emp-pk_emp, dept-pk_dept)
(dept-pk_dept, emp-pk_emp)

1 순서

2 개 테이블 조인
각각의 테이블에 인덱스 5개씩 있다면
한 테이블에 접근 전략 : 6
36 * 2 = 72

ORALCE - 실시간 응답 : OLTP (ON LINE TRANSACTION PROCESSING)
         전체 처리시간 : OLAP (ON LINE ANALYSIS PROCESSING) - 복잡한 쿼리의 실행계획을 세우는데
                                                            30M~1H);

emp 부터 읽을까 dept 부터 읽을까???;

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno=7788;

SELECT *
FROM TABLE(dbms_xplan.display);


Plan hash value: 3070176698
 
4 - 3 - 5 - 2 - 6 - 1 - 0
----------------------------------------------------------------------------------------------
| Id  | Operation                     | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |              |     1 |    33 |     3   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                 |              |       |       |            |          |
|   2 |   NESTED LOOPS                |              |     1 |    33 |     3   (0)| 00:00:01 |
|   3 |    TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    13 |     2   (0)| 00:00:01 |
|*  4 |     INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN          | PK_DEPT      |     1 |       |     0   (0)| 00:00:01 |
|   6 |   TABLE ACCESS BY INDEX ROWID | DEPT         |     1 |    20 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO") ;
   


CTAS
제약조건 복사가 NOT NULL만 된다
백업이나, 테스트용으로;

IDX1;
CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1 = 1;

deptno 컬럼으로 unique index
dname 컬럼으로 non unique index
deptno, dname 컬럼으로 non unique index ;

CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_n_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_n_dept_test2_03 ON dept_test2 (deptno, dname);

IDX2;
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_u_dept_test2_02;
DROP INDEX idx_u_dept_test2_03;
    

IDX3;
EMP INDEX :
1.
2.
3.




