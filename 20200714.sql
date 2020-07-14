DDL
 오라클 객체
 1. table : 데이터를 저장할 수 있는 공간
    . 제약조건
    NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK 
    
 2. VIEW : SQL => 실제 데이터가 존재하는 것이 아님
           논리적인 데이터 집합의 정의
      * VIEW TABLE 잘못된 표현
     
view 생성 문법
CREATE              TABLE
CREATE              INDEX 
CREATE [OR REPLACE] VIEW 뷰이름 [column1, column2...] AS
SELECT 쿼리;

emp테이블에서 급여 정보인 sal, comm 컬럼을 제외하고 나머지 6개 컬럼만
조회할 수 있는 SELECT 쿼리를 v_emp 이름의 view로 생성

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

오라클 view 객체를 생성하여 조회
SELECT *
FROM v_emp;

inline view를 이용하여 조회
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
      FROM emp);

view 객체를 통해 얻을수 있는 이점
1. 코드를 재사용 할 수 있다
2. SQL 코드가 짧아진다      

hr 계정에게 emp 테이블이 아니라 v_emp에 대한 접근권한을 부여
hr 계정에서는 emp 테이블의 sal, comm 컬럼을 볼 수가 없다 
==> 급여정보에 대한 부분을 비 관련자로부터 차단을 할 수가 있다

GRANT SELECT ON v_emp TO hr;

hr 계정으로 접속하여 테스트
v_emp view는 sem계정이 hr 계정에게 select 권한을 주었기 때문에
정상적으로 조회 가능
SELECT *
FROM sem.v_emp;

emp테이블의 select 권한을 hr에게 준적이 없기 때문에 에러
SELECT *
FROM sem.emp;


VIEW  : SQL
v_emp 정의
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp

1. emp 테이블에 신규 사원을 입력 (기존 15건, 추가되서 16건)
   INSERT INTO emp (empno, ename) VALUES (9990, 'james');
   
2. SELECT *
   FROM v_emp; 
   결과가 몇 건일까? 16건
   view라고하는 것은 실체가 없는 데이터 집합을 정의하는 SQL이기 때문에
   해당 SQL에서 사용하는 테이블의 데이터가 변경이 되면
   VIEW에도 영향을 미친다
  
  SELECT empno, ename, job, mgr, hiredate, deptno
  FROM emp;
   
view은 SQL 이기 때문에 조인된 결과나, 그룹함수를 적용하여 행의 건수가
달라지는 sql도 view로 생성하는 것이 가능.

emp, dept 테이블의 경우 업무상 자주 같이 쓰일수 밖에 없는 테이블
부서명, 사원번호, 사원이름, 담당업무, 입사일자
다섯개의 컬럼을 갖는 view를 v_emp_dept로 생성
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM v_emp_dept;


SEQUENCE : 중복되지 않는 정수값을 반환해주는 오라클 객체
 시작값(default 1, 혹은 개발자가 설정 가능) 부터 1씩 순차적으로
 증가한 값을 반환한다.

문법
CREATE SEQUENCE 시퀀스 명;
[옵션....]

seq_emp 이름으로 SEQUENCE 생성
CREATE SEQUENCE seq_emp;


시퀀스 객체를 통해 중복되지 않는 값을 조회
시퀀스 객체에서 제공하는 함수 
1. nextval (next value)
   시퀀스 객체의 다음 값을 요청하는 함수
   함수를 호출하면 시퀀스 객체의 값이 하나 증가 하여 다음번 호출시
   증가된 값을 반환하게 된다
   
2. currval (current value)
   nextval함수를 사용하고 나서 사용할수 있는 함수
   nextval함수를 통해 얻은 값을 다시 확인 할 때 사용
   시퀀스 객체가 다음에 리턴할 값에 대해 영향을 미치지 않음

nextval 사용하기전에 currval 사용한 경우 ==> 에러

SELECT seq_emp.currval
FROM dual;


SELECT seq_emp.nextval
FROM dual;

SELECT seq_emp.currval
FROM dual;






테이블 : 정렬이 안되어있음 (집합)
==> ORDER BY 

emp 테이블에서 empno = 7698 인 데이터를 조회
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7698;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    36 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    36 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
Predicate Information (identified by operation id):
---------------------------------------------------
    1 - filter("EMPNO"=7698)


ROWID 특수컬럼 : 행의 주소
( c언어 포인터
  java : Tv tv = new TV();
         int a = 5;)
AAAE5gAAFAAAACLAAF
SELECT ROWID, emp.*
FROM emp
WHERE empno = 7698;

ROWID 값을 알고 있으면 테이블에 빠르게 접근 하는 것이 가능
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE ROWID = 'AAAE5gAAFAAAACLAAF';
    
SELECT *
FROM TABLE(dbms_xplan.display);
    
Plan hash value: 1116584662
 
-----------------------------------------------------------------------------------
| Id  | Operation                  | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT           |      |     1 |    36 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY USER ROWID| EMP  |     1 |    36 |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------    

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

emp 테이블의 pk_emp PRIMARY KEY 제약조건을 통해 EMPNO 컬럼으로
인덱스 생성이 되어 있는 상태

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7698;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    36 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    36 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 2-1-0
Predicate Information (identified by operation id):
---------------------------------------------------
   2 - access("EMPNO"=7698)
   

emp 테이블에 primary key 제약조건을 생성하고 나서 변경된 점
 * 오라클 입장에서 데이터를 조회할 때 사용할 수 있는 전략이 하나더 생김
 1. table full scan
 2. pk_emp 인덱스를 이용하여 사용자가 원하는 행을 빠르게 찾아가서
    필요한 컬럼들은 인덱스에 저장된 rowid를 이용하여 테이블의 행으로
    바로 접근


EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7698;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 56244932
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |     1 |     4 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_EMP |     1 |     4 |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------
 1 - 0
Predicate Information (identified by operation id):
---------------------------------------------------
   1 - access("EMPNO"=7698)


empno 컬럼의 인덱스를 unique 인덱스가 아닌 일반 인덱스(중복이 가능한)로
생성한 경우
1. fk_emp_dept 제약 조건 삭제
2. pk_emp 제약조건 삭제
ALTER TABLE emp DROP CONSTRAINT fk_emp_dept;
ALTER TABLE emp DROP CONSTRAINT pk_emp;

1. NON-UNIQUE 인덱스 생성(중복 가능)
 UNIQUE 인덱스 명명규칙 : IDX_U_테이블명_01;
 NON UNIQUE 인덱스 명명규칙 : IDX_NU_테이블명_01;
 
CREATE [UNIQUE] INDEX 인덱스명 ON 테이블 (인덱스로 구성할 컬럼);

CREATE INDEX idx_nu_emp_01 ON emp (empno);

EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE empno = 7698;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 1720330861
 ---------------------------------------------------------------------------------------------
| Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |               |     1 |    36 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP           |     1 |    36 |     2   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_NU_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------------------
 Predicate Information (identified by operation id):
---------------------------------------------------
    2 - access("EMPNO"=7698)