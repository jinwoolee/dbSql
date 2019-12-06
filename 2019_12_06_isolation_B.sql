--B사용자
SELECT *
FROM dept;

DELETE dept WHERE deptno=40;
ROLLBACK;

--ISOLATION LEVEL3 테스트
--T1 :
INSERT INTO dept VALUES
(98, 'ddit2', 'seoul');
COMMIT;

