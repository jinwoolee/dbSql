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
-- sem.fastfood -->  fastfood �ó������ ����
-- ������ ���� sql�� ���������� �����ϴ��� Ȯ��
CREATE SYNONYM fastfood FOR sem.fastfood;

SELECT *
FROM fastfood;







