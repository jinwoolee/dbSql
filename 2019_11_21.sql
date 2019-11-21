-- col IN (value1, value2...)
-- col�� ���� IN ������ �ȿ� ������ ���߿� ���Ե� �� ������ ����

--RDBMS - ���հ���
--1.���տ��� ������ ����
-- {1, 5, 7}, {5, 1, 7}

--2.���տ��� �ߺ��� ����
-- {1, 1, 5, 7}, {5, 1, 7}

SELECT *
FROM emp
WHERE deptno IN (10, 20);   --emp ���̺��� ������ �Ҽ� �μ��� 10�� �̰ų� 20����
                            --    ���� ������ ��ȸ
                            
--�̰ų� --> OR(�Ǵ�)
--�̰�  --> AND(�׸���)

-- IN --> OR
-- BETWEEN AND --> AND + �����

SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 20;

--where3
DESC users;

SELECT userid ���̵�, usernm �̸�, alias ����
FROM users
WHERE userid IN ('brown', 'sally', 'cony');


-- LIKE ������ : ���ڿ� ��Ī ����
-- % : ���� ����(���ڰ� ���� ���� �ִ�)
-- _ : �ϳ��� ����

--emp���̺��� ����̸�(ename)�� S�� �����ϴ� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--SMITH
--SCOTT
--ù���ڴ� S�� �����ϰ� 4��° ���ڴ� T
--�ι�°, ����°, �ټ���° ���ڴ� � ���ڵ� �� �� �ִ�
SELECT *
FROM emp
WHERE ename LIKE 'S__T_';
WHERE ename LIKE 'S%T_'; -- 'STE', 'STTTT', 'STESTS'


--where4
--member ���̺��� [��]�� ���� ���� ����� ��ȸ�ϼ���
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--where5
--member ���̺��� �̸��� [��] ���ڰ� ���ԵǴ� ȸ�� ���� ��ȸ
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

--�÷� ���� NULL�� ������ ã��
--emp ���̺� ���� MGR �÷��� NULL �����Ͱ� ����
SELECT *
FROM emp
WHERE MGR IS NULL;  --NULL�� Ȯ�ο��� IS NULL �����ڸ� ���
WHERE MGR = NULL;   --MGR �÷� ���� NULL�� ��� ������ȸ (��ȸ���� ����)
WHERE MGR = 7698;   --MGR �÷� ���� 7698�� ��� ������ȸ

--where6

UPDATE emp SET comm = 0 
WHERE empno=7844;

COMMIT;


SELECT *
FROM emp
WHERE comm IS NOT NULL;


--AND : ������ ���ÿ� ����
--OR : ������ �Ѱ��� �����ϸ� ����
--emp ���̺��� mgr�� 7698 ��� �̰�(AND), �޿��� 1000���� ū ���
SELECT *
FROM emp
WHERE mgr=7698    
AND sal > 1000;     

--emp ���̺��� mgr�� 7698 �̰ų�(OR), �޿��� 1000���� ū ���
SELECT *
FROM emp
WHERE mgr=7698
OR sal > 1000;

--emp���̺��� ������ ����� 7698, 7839�� �ƴ� ���� ������ȸ
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
OR mgr IS NULL;

DESC emp;

--where7
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD'); 


