--읽기 일관성 (ISOLATION LEVEL)
--DML문이 다른 사용자에게 어떻게 영향을
--미치는지 정의한 레벨(0-3)

--A사용자
SELECT *
FROM dept;

--deptno가 99번인 사용자를 삭제
UPDATE dept SET dname='DDIT'
WHERE deptno=99;



--COMMIT;



--ISOLATION LEVEL2
--선행 트랜잭션에서 읽은 데이터
--(FOR UPDATE)를 수정, 삭제 하지못함
UPDATE dept SET dname='ddit'
WHERE deptno=99;

--BOSTON 40
SELECT *
FROM dept
WHERE deptno=40
FOR UPDATE;

--다른 트랜잭션에서 수정을 못하기 때문에
--현 트랜잭션에서 해당 ROW는 항상
--동일한 결과값으로 조회 할 수 있다
SELECT *
FROM dept;
--하지만 후행 트랜잭션에서 신규 데이터
--입력후 commit을 하면 현 트랜잭션에서
--조회가 된다(phantom read) 


--ISOLATION LEVEL3
--SERIALIZABLE READ
--트래잭션의 데이터 조회 기준이
--트랜잭션 시작 시점으로 맞춰진다
--즉 후행 트랜잭션에서 데이터를 신규
--입력, 수정, 삭제 후 COMMIT을 하더라도
--선행트랜잭션에서는 해당 데이터를 보지
--않는다

--트랜잭션 레벨 수정(serializable read)
SET TRANSACTION isolation LEVEL SERIALIZABLE;


--T0 : 4건의
SELECT *
FROM dept;

INSERT INTO dept VALUES
(99, 'ddit', 'daejeon');


