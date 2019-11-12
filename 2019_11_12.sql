--sub7
--1번고객이 먹는 애음제품
--2번고객도 먹는 애음제품으로 제한
--고객명 추가
SELECT cycle.cid, customer.cnm, product.pid, product.pnm, day, cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.cid = customer.cid
AND cycle.pid = product.pid
AND cycle.pid IN (SELECT pid FROM cycle WHERE cid=2);

--sub9
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND pid = product.pid );

--1번고객이 애음하는 제품
SELECT pid
FROM cycle
WHERE cid = 1;


SELECT *
 FROM DEPT;

DELETE DEPT WHERE DEPTNO=99;
COMMIT;

INSERT INTO customer
VALUES (99, 'ddit');
commit;

desc dept;

------ -- ------------ 
DEPTNO    NUMBER(2)    
DNAME     VARCHAR2(14) 
LOC       VARCHAR2(13) 

INSERT INTO DEPT
VALUES ('ddit', 99, 'daejeon');

desc emp;

INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', null);

INSERT INTO emp (ename, job)
VALUES ('brown', null);

SELECT *
FROM emp
WHERE empno=9999;

rollback;

desc emp;

SELECT *
FROM user_tab_columns
WHERE table_name = 'EMP'
ORDER BY column_id;

1.EMPNO
2.ENAME
3.JOB
4.MGR
5.HIREDATE
6.SAL
7.COMM
8.DEPTNO;

INSERT INTO emp 
VALUES (9999, 'brown', 'ranger', null, sysdate, 2500, null, 40);

--SELECT 결과(여러건)를 INSERT

INSERT INTO emp (empno, ename)
SELECT deptno, dname
FROM dept;

SELECT *
FROM emp;

--UPDATE 
-- UPDATE 테이블 SET 컬럼=값, 컬럼=값....
-- WHERE condition

INSERT INTO dept values (99, 'ddit', 'daejeon');
commit;

SELECT *
FROM dept;

desc dept;

UPDATE dept SET dname='대덕IT', loc='ym';
--WHERE deptno=99;
rollback;


--고객관리-현금영수증 (야쿠르트여사님-13000, 운영팀, 일반직원, 영업점-650)
--주민번호 뒷자리
update 사용자테이블 set 비밀번호=주밀번호뒷자리
where 사용자 구분이='여사님';
commit;

SELECT *
FROM emp;

--DELETE 테이블명
--WHERE condition

--사원번호가 9999인 직원을 emp 테이블에서 삭제
DELETE emp
WHERE empno=9999;

--부서테이블을 이용해서 emp 테이블에 입력한 5건(4건)의 데이터를 삭제
--10, 20, 30, 40, 99 --> empno < 100, empno BETWEEN 10 AND 99
DELETE emp
WHERE empno < 100;

rollback;

DELETE emp
WHERE empno BETWEEN 10 AND 99;

SELECT *
FROM emp
WHERE empno BETWEEN 10 AND 99;

DELETE emp
WHERE empno IN (SELECT deptno FROM dept);

SELECT *
FROM emp
WHERE empno IN (SELECT deptno FROM dept);
commit;

SELECT *
FROM emp;

DELETE emp WHERE empno=9999;
commit;

--트랜잭션
--brown
INSERT INTO dept values (99, 'ddit', 'daejeon');
SELECT *
FROM dept;

commit;

--LV1 --> LV3
SET TRANSACTION 
isolation LEVEL SERIALIZABLE;

--DML문장을 통해 트랜잭션시작
INSERT INTO dept 
values (99, 'ddit', 'daejeon');

SELECT *
FROM dept;


--DDL : AUTO COMMIT , rollback이 안 된다
--CREATE

DROP TABLE RANGER_NEW;

CREATE TABLE ranger_new(
    ranger_no NUMBER,   --숫자 타입
    ranger_name VARCHAR2(50),--문자 : [VARCHAR2], CHAR
    reg_dt DATE DEFAULT sysdate --DEFAULT : SYSDATE
);
desc ranger_new;

--ddl은 rollback이 적용되지 않는다
rollback;

INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000, 'brown');

SELECT *
FROM ranger_new;
commit;


--날짜 타입에서 특정 필드가져오기
--ex : sysdate에서 년도만 가져오기
SELECT TO_CHAR(sysdate, 'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, 
       TO_CHAR(reg_dt, 'MM'),
       EXTRACT(MONTH FROM reg_dt) mm,
       EXTRACT(YEAR FROM reg_dt) year,
       EXTRACT(day FROM reg_dt) day
FROM ranger_new;


--제약조건
--DEPT 모방해서 DEPT_TEST 생성
desc dept_test;
CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY, --deptno 컬럼을 식별자로 지정
    dname varchar2(14),           --식별자로 지정이 되면 값이 중복이
    loc varchar2(13)              --될수 없으며, null일 수도 없다
);

--primary key제약 조건 확인
--1.deptno컬럼에 null이 들어갈 수 없다
--2.deptno컬럼에 중복된 값이 들어갈 수 없다

INSERT INTO dept_test (deptno, dname, loc)
VALUES (null, 'ddit', 'daejeon');

INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2', 'daejeon');

ROLLBACK;

--사용자 지정 제약조건명을 부여한 PRIMARY KEY
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

--TABLE CONSTRAINT 
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY (deptno, dname)
);

INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2', 'daejeon');

SELECT *
FROM dept_test;
ROLLBACK;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13)
);
INSERT INTO dept_test VALUES(1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(2, null, 'daejeon');

--UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);
INSERT INTO dept_test VALUES(1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(2, 'ddit', 'daejeon');
