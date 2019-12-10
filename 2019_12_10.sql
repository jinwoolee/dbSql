--제약조건 활성화 / 비활성화
--ALTER TABLE 테이블명 ENABLE OR DISABLE CONSTRAINT 제약조건명;

--USER_CONSTRAINTS view를 통해 dept_test 테이블에 설정된
--제약조건 확인
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

ALTER TABLE dept_test DISABLE CONSTRAINT SYS_C007119;

SELECT *
FROM dept_test;

--dept_test테이블의 deptno 컬럼에 적용된 PRIMARY KEY 제약조건을 비활성화 하여
--동일한 부서번호를 갖는 데이터를 입력할 수 있다
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, 'DDIT', '대전');

--dept_test 테이블의 PRIMARY KEY 제약조건 활성화
--이미 위에서 실행한 두개의 INSERT 구문에 의해 같은 부서번호를 갖는 데이터가
--존재하기 때문에 PRIMARY KEY 제약조건을 활성화 할 수 없다
--활성화 하려면 중복데이터를 삭제 해야한다.
ALTER TABLE dept_test ENABLE CONSTRAINT SYS_C007119;

--부서번호가 중복되는 데이터만 조회 하여
--해당 데이터에 대해 수정후 PRIMARY KEY 제약조건을 활성화 할 수 있다
SELECT deptno, COUNT(*)
FROM dept_test
GROUP BY deptno
HAVING COUNT(*) >= 2;

--table_name, constraint_name, column_name
--position 정렬 (ASC)
SELECT *
FROM user_constraints
WHERE table_name ='BUYER';

SELECT *
FROM user_cons_columns
WHERE table_name ='BUYER';

--테이블에 대한 설명(주석) VIEW
SELECT *
FROM USER_TAB_COMMENTS;

--테이블 주석
--COMMENT ON TABLE 테이블명 IS '주석';
COMMENT ON TABLE dept IS '부서';

--컬럼 주석
--COMMENT ON COLUMN 테이블명.컬러명 IS '주석';
COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서위치 지역';

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME ='DEPT';

--COMMENT1
--user_tab_comments, user_col_comments

SELECT *
FROM user_tab_comments;

SELECT *
FROM user_col_comments;

SELECT t.table_name, t.table_type, t.comments tab_comment,
       c.column_name, c.comments col_comment
FROM user_tab_comments t, user_col_comments c
WHERE t.table_name = c.table_name
AND t.table_name IN ('CYCLE', 'DAILY', 'CUSTOMER', 'PRODUCT');


--VIEW : QUERY이다 (O)
--테이블 처럼 데이터가 물리적으로 존재 하는 것이 아니다.
--논리적 데이터 셋 = QUERY
--VIEW는 테이블 이다 (X)

--VIEW 생성
--CREATE OR REPLACE VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2...)] AS
--SUBQUERY

--emp테이블에서 sal, comm컬럼을 제외한 나머지 6개 컬럼만 조회가 되는 view 
--v_emp이름으로 생성
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--SYSTEM 계정에서 작업
--VIEW 생성 권한을 sem 계정에 부여
GRANT CREATE VIEW TO sem;

--VIEW를 통해 데이터 조회
SELECT *
FROM v_emp;

--INLINE VIEW
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
      FROM emp);
      
--emp테이블을 수정하면 view에 영향이 있을까?
--KING의 부서번호가 현재 10번
--emp 테이블의 KING의 부서번호 데이터를 30번으로 수정(COMMIT하지 말것)
UPDATE emp SET deptno=30
WHERE ename='KING';

SELECT *
FROM emp
WHERE ename='KING';

--v_emp 테이블에서 KING의 부서번호를 관찰
SELECT *
FROM v_emp;

ROLLBACK;

--조인된 결과를 view로 생성
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM v_emp_dept;

--emp 테이블에서 KING데이터 삭제(COMMIT 하지 말것)
DELETE emp
WHERE ename = 'KING';

SELECT *
FROM emp
WHERE ename = 'KING';

--emp 테이블에서 KING 데이터 삭제후 v_emp_dept view의 조회 결과 확인
SELECT *
FROM v_emp_dept;
ROLLBACK;

--INLINE VIEW
SELECT *
FROM (SELECT emp.empno, emp.ename, dept.deptno, dept.dname
      FROM emp, dept
      WHERE emp.deptno = dept.deptno);



--emp테이블의 empno 컬럼을 eno로 컬럼이름 변경
ALTER TABLE emp RENAME COLUMN empno TO eno;
ALTER TABLE emp RENAME COLUMN eno TO empno;

SELECT *
FROM v_emp_dept;

--VIEW 삭제
--v_emp 삭제
DROP VIEW v_emp;

--부서별 직원의 급여 합계
CREATE OR REPLACE VIEW v_emp_sal AS
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno;

SELECT *
FROM v_emp_sal
WHERE deptno = 30;

SELECT *
FROM (SELECT deptno, SUM(sal) sum_sal
      FROM emp
      GROUP BY deptno)
WHERE deptno = 20;


SELECT *
FROM (SELECT deptno, sal, rownum
      FROM emp)
WHERE deptno=20;


--SEQUENCE
--오라클객체로 중복되지 않는 정수 값을 리턴해주는 객체
--CREATE SEQUENCE 시퀀스명 
--[옵션...]

CREATE SEQUENCE seq_board;

DROP SEQUENCE seq_board;

--시퀀스 사용방법 : 시퀀스명.nextval
--연월일-순번
--C20191210-00001
--C20191210-00002
SELECT TO_CHAR(sysdate, 'YYYYMMDD') ||'-'|| seq_board.nextval
FROM dual;

SELECT seq_board.currval
FROM dual;

rollback;

SELECT rowid, rownum, emp.*
FROM emp;

SELECT *
FROM emp_test;


      
--emp 테이블 empno 컬럼으로 PRIMARY KEY 제약 생성 : pk_emp
--dept 테이블 deptno 컬럼으로 PRIMARY KEY 제약 생성 : pk_dept
--emp 테이블의 deptno 컬럼이 dept 테이블의 deptno 컬럼을 참조하도록 
--FOREIGN KEY 제약 추가 : fk_dept_deptno

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_dept_deptno FOREIGN KEY (deptno)
            REFERENCES dept (deptno);

--emp_test 테이블 삭제
DROP TABLE emp_test;

--emp 테이블을 이용하여 emp_test 테이블 생성
CREATE TABLE emp_test AS
SELECT *
FROM emp;


--emp_test 테이블에는 인덱스가 없는 상태
--원하는 데이터를 찾기 위해서는 테이블의 데이터를 모두 읽어봐야 한다
EXPLAIN PLAN FOR
SELECT *
FROM emp_test
WHERE empno=7369;

SELECT *
FROM table(dbms_xplan.display);
    
--실행계획을 통해 7369 사번을 갖는 직원 정보를 조회 하기위해
--테이블의 모든 데이터(14)를 읽어 본다음에 사번이 7369인 데이터만 선택하여
--사용자에게 반환
--**13건의 데이터는 불필요하게 조회후 버림

Plan hash value: 3124080142
 
------------------------------------------------------------------------------
| Id  | Operation         | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |          |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP_TEST |     1 |    87 |     3   (0)| 00:00:01 |
------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
 
Note
-----
   - dynamic sampling used for this statement (level=2)

      
      
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7369;

SELECT *
FROM table(dbms_xplan.display);      


--실행계획을 통해 분석을 하면
--empno가 7369인 직원을 index를 통해 매우 빠르게 인덱스에 접근
--같이저장되어 있는 rowid 값을 통해 table에 접근을 한다
--table에서 읽은 데이터는 7369사번 데이터 한건만 조회를 하고
--나머지 13건에서 대해서는 읽지 않고 처리
-- 14--> 1
-- 1--> 1
Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7369)


EXPLAIN PLAN FOR
SELECT rowid, emp.*
FROM emp
WHERE rowid = 'AAAE5uAAFAAAAETAAD';


SELECT *
FROM table(dbms_xplan.display);  

Plan hash value: 1116584662
 
-----------------------------------------------------------------------------------
| Id  | Operation                  | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT           |      |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY USER ROWID| EMP  |     1 |    38 |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------

