--�б� �ϰ��� (ISOLATION LEVEL)
--DML���� �ٸ� ����ڿ��� ��� ������
--��ġ���� ������ ����(0-3)

--A�����
SELECT *
FROM dept;

--deptno�� 99���� ����ڸ� ����
UPDATE dept SET dname='DDIT'
WHERE deptno=99;



--COMMIT;



--ISOLATION LEVEL2
--���� Ʈ����ǿ��� ���� ������
--(FOR UPDATE)�� ����, ���� ��������
UPDATE dept SET dname='ddit'
WHERE deptno=99;

--BOSTON 40
SELECT *
FROM dept
WHERE deptno=40
FOR UPDATE;

--�ٸ� Ʈ����ǿ��� ������ ���ϱ� ������
--�� Ʈ����ǿ��� �ش� ROW�� �׻�
--������ ��������� ��ȸ �� �� �ִ�
SELECT *
FROM dept;
--������ ���� Ʈ����ǿ��� �ű� ������
--�Է��� commit�� �ϸ� �� Ʈ����ǿ���
--��ȸ�� �ȴ�(phantom read) 


--ISOLATION LEVEL3
--SERIALIZABLE READ
--Ʈ������� ������ ��ȸ ������
--Ʈ����� ���� �������� ��������
--�� ���� Ʈ����ǿ��� �����͸� �ű�
--�Է�, ����, ���� �� COMMIT�� �ϴ���
--����Ʈ����ǿ����� �ش� �����͸� ����
--�ʴ´�

--Ʈ����� ���� ����(serializable read)
SET TRANSACTION isolation LEVEL SERIALIZABLE;


--T0 : 4����
SELECT *
FROM dept;

INSERT INTO dept VALUES
(99, 'ddit', 'daejeon');


