SELECT *
FROM sem.users;

SELECT *
FROM jobs;

SELECT *
FROM USER_TABLES;

--78 --> 79
SELECT *
FROM ALL_TABLES
WHERE OWNER = 'SEM';

SELECT *
FROM sem.fastfood;
-- sem.fastfood -->  fastfood 시노님으로 생성
-- 생성후 다음 sql이 정상적으로 동작하는지 확인
CREATE SYNONYM fastfood FOR sem.fastfood;

SELECT *
FROM fastfood;







