SELECT *
FROM USER_VIEWS;

SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'SEM';

SELECT *
FROM sem.V_EMP_DEPT;

--sem �������� ��ȸ������ ���� V_EMP_DEPT view�� hr �������� ��ȸ�ϱ�
--���ؼ��� ������.view�̸� �������� ����� �ؾ��Ѵ�
--�Ź� �������� ����ϱ� �������Ƿ� �ó���� ���� �ٸ� ��Ī�� ����

CREATE SYNONYM V_EMP_DEPT FOR sem.V_EMP_DEPT;

--sem.V_EMP_DEPT --> V_EMP_DEPT
SELECT *
FROM V_EMP_DEPT;

--�ó�� ����
DROP TABLE ���̺��;

DROP SYNONYM V_EMP_DEPT;


--hr ���� ��й�ȣ : java
--hr ���� ��й�ȣ ���� : hr
ALTER USER hr IDENTIFIED BY hr;
--ALTER USER sem IDENTIFIED BY java; --���� ������ �ƴ϶� ����





--dictionary
--���ξ� : USER : ����� ���� ��ü
--        ALL : ����ڰ� ��밡�� �� ��ü
--        DBA : ������ ������ ��ü ��ü(�Ϲ� ����ڴ� ��� �Ұ�)
--        V$ : �ý��۰� ���õ� view (�Ϲ� ����ڴ� ��� �Ұ�)

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES
WHERE OWNER IN ('SEM', 'HR');

SELECT *
FROM emp
WHERE empno=7369;

--����Ŭ���� ������ SQL�̶�?
--���ڰ� �ϳ��� Ʋ���� �ȵ�
--���� sql���� ��������� ����� ���� ���� DBMS������
--���� �ٸ� SQL�� �νĵȴ�
SELECT /*bind_test */ * FROM emp;
Select /*bind_test */ * FROM emp;
Select /*bind_test */ *  FROM emp;

Select /*bind_test */ *  FROM emp WHERE empno=7369;
Select /*bind_test */ *  FROM emp WHERE empno=7499;
Select /*bind_test */ *  FROM emp WHERE empno=7521;

Select /*bind_test */ *  FROM emp WHERE empno=:empno;



SELECT *
FROM v$SQL;





