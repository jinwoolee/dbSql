--B�����
SELECT *
FROM dept;

DELETE dept WHERE deptno=40;
ROLLBACK;

--ISOLATION LEVEL3 �׽�Ʈ
--T1 :
INSERT INTO dept VALUES
(98, 'ddit2', 'seoul');
COMMIT;

