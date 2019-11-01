--����
--WHERE 
--������
-- �� : =, !=, <>, >=, >, <=, <
-- BETWEEN start AND end
-- IN (set)
-- LIKE 'S%' ( % : �ټ��� ���ڿ��� ��Ī, _ : ��Ȯ�� �ѱ��� ��Ī)
-- IS NULL ( != NULL )
-- AND, OR, NOT 

--emp ���̺��� �Ի����ڰ� 1981�� 6�� 1�Ϻ��� 1986�� 12�� 31�� ���̿� �ִ�
--���� ������ȸ
--BETWEEN AND
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981/06/01', 'YYYY/MM/DD')
                   AND TO_DATE('1986/12/31', 'YYYY/MM/DD');
-- >=, <=
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD')
  AND hiredate <= TO_DATE('1986/12/31', 'YYYY/MM/DD');

--emp ���̺��� ������(mgr)�� �ִ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NULL;
--WHERE mgr != NULL;


--where12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%';
   
--where13
-- empno�� ���� 4�ڸ����� ���
-- empno : 7800~7899
--         780~789
--         78
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno BETWEEN 7800 AND 7899
   OR empno BETWEEN 780 AND 789
   OR empno =78;
   
--where14
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR (    empno like '78%' 
       AND hiredate >= TO_DATE('19810601', 'YYYYMMDD'));



--order by �÷��� | ��Ī | �÷��ε��� [ASC | DESC]
--order by ������ WHERE�� ������ ���
--WHERE ���� ���� ��� FROM�� ������ ���
--emp���̺��� ename �������� �������� ����
SELECT *
FROM emp
ORDER BY ename ASC;

--ASC :default
--ASC�� �Ⱥٿ��� �� ������ ������
SELECT *
FROM emp
ORDER BY ename; -- ASC

--�̸�(ename)�� �������� ��������
SELECT *
FROM emp
ORDER BY ename desc;

--job�� �������� ������������ ����, ���� job�� �������
--���(empno)���� �ø����� ����
--SALESMASN - PRESIDENT -MANAGER - CLERK - ANALYST

SELECT *
FROM emp
ORDER BY job DESC, empno asc;

--��Ī���� �����ϱ�
--��� ��ȣ(empno), �����(ename), ����(sal * 12) as year_sal
--year_sal ��Ī���� �������� ����
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT�� �÷� ���� �ε����� ����
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY 2;



