SELECT *
FROM dept;

첫번째 사용자가 dept테이블에
데이터를 입력후 트랜잭션을 확정
짓지 않은 상태

SELECT *
FROM dept;

첫번째 사용자가 commit 실행

SELECT *
FROM dept;



lv1

UPDATE dept SET dname='대덕'
WHERE deptno =99;
commit;

선행 트랜잭션에서 99번부서를
FOR UPDATE로 조회
후행 트랜잭션에서는 수정이 불가능

UPDATE dept SET dname='ddit'
WHERE deptno =99;
ROLLBACK;

팬텀리드 
INSERT INTO dept
VALUES (98, 'ddit', 'daejeon');
commit;

ROLLBACK;


SET TRANSACTION ISOLATION LEVEL
 SERIALIZABLE;

INSERT INTO dept 
    VALUES(97, 'ddit', 'daejeon');
COMMIT;
