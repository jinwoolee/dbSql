--WHERE2 
-- WHERE ���� ����ϴ� ���ǿ� ������ ��ȸ ����� ������ ��ġ�� �ʴ´�
-- SQL�� ������ ������ ���� �ִ�(���� ������ ����)
-- ���� : Ű�� 185cm �̻��̰� �����԰� 70kg �̻��� ������� ����
--       --> �����԰� 70kg �̻��̰� Ű�� 185cm �̻��� ������� ����
-- ������ Ư¡ : ���տ��� ������ ����
-- {1, 5, 10} --> {10, 5, 1} : �� ������ ���� �����ϴ�
-- ���̺��� ������ ������� ����
-- SELECT ����� ������ �ٸ����� ���� �����ϸ� ����
--> ���ı�� ����(ORDER BY)
--     �߻��� ����� ���� --> ����X
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD')
AND   hiredate <= TO_DATE('1983/01/01', 'YYYY/MM/DD');

SELECT *
FROM emp
WHERE hiredate <= TO_DATE('1983/01/01', 'YYYY/MM/DD')
AND   hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');


-- IN ������
-- Ư�� ���տ� ���ԵǴ��� ���θ� Ȯ��
-- �μ���ȣ�� 10�� Ȥ��(OR) 20���� ���ϴ� ���� ��ȸ
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10, 20);

--IN �����ڸ� ������� �ʰ� OR ������ ���
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR    deptno = 20;

-- emp���̺��� ����̸��� SMITH, JONES �� ������ ��ȸ (empno, ename, deptno)
-- AND / OR
-- ���� ���

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'JONES';

SELECT empno, ename, deptno
FROM emp
WHERE ename IN ('SMITH', 'JONES');

--where3
-- users ���̺��� userid�� brown, cony, sally �� �����͸� IN
SELECT userid ���̵�, usernm �̸�, alias ����
FROM users
WHERE userid IN( 'brown', 'cony', 'sally');

-- ���ڿ� ��Ī ������ : LIKE, %, _
-- ������ ������ ������ ���ڿ� ��ġ�� ���ؼ� �ٷ�
-- �̸��� BR�� �����ϴ� ����� ��ȸ
-- �̸��� R ���ڿ��� ���� ����� ��ȸ

-- ��� �̸��� S�� �����ϴ� ��� ��ȸ
-- SMITH, SMILE, SKC
-- % � ���ڿ�(�ѱ���, ���� �������� �ְ�, ���� ���ڿ��� �ü��� �ִ�)
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--���ڼ��� ������ ���� ��Ī
-- _ ��Ȯ�� �ѹ���
-- ���� �̸��� S�� �����ϰ� �̸��� ��ü ���̰� 5���� �� ����
-- S____
SELECT *
FROM emp
WHERE ename LIKE 'S____';

-- ��� �̸��� S���ڰ� ���� ��� ��ȸ
-- ename LIKE '%S%'
SELECT *
FROM emp
WHERE ename LIKE '%S%';

--where4
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--where5
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

-- null �� ���� (IS)
-- comm �÷��� ���� null�� �����͸� ��ȸ (WHERE comm = null)
SELECT *
FROM emp
WHERE comm = null;

SELECT *
FROM emp
WHERE comm = '';

--where6
SELECT *
FROM emp
WHERE comm >= 0;
WHERE comm IS NOT null;

-- ����� �����ڰ� 7698, 7839 �׸��� null�� �ƴ� ������ ��ȸ
-- NOT IN �����ڿ����� NULL ���� ���� ��Ű�� �ȵȴ�
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);

-- -->
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
AND mgr IS NOT NULL;


--where7
SELECT *
FROM emp
WHERE JOB = 'SALESMAN'
AND HIREDATE > To_Date('1981/06/01', 'yyyy/mm/dd');

--where8
SELECT *
FROM emp
WHERE deptno <> 10 and HIREDATE > To_Date('1981/06/01', 'yyyy/mm/dd');


--where9
SELECT *
FROM emp
WHERE deptno NOT IN(10) and HIREDATE > To_Date('1981/06/01', 'yyyy/mm/dd');

--where10
SELECT *
FROM emp
WHERE deptno IN(20,30)
AND HIREDATE > To_Date('1981/06/01', 'yyyy/mm/dd');

--where 11
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR HIREDATE > To_Date('1981/06/01', 'yyyy/mm/dd');

--where12
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%';

--WHERE 13
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR (empno >= 7800 AND empno < 7900);

-- ������ �켱����
-- *,/ �����ڰ� +,- ���� �켱������ ����
-- 1+5*2 = 11 -> (1+5)*2 X
-- �켱���� ���� : ()
-- AND > OR 

-- emp ���̺��� ��� �̸��� SMITH �̰ų�
--               ��� �̸��� ALLEN �̸鼭 �������� SALESMAN�� ��� ��ȸ
SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR ename ='ALLEN' 
AND job = 'SALESMAN';

SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR (ename ='ALLEN' AND job = 'SALESMAN');

-- ��� �̸��� SMITH �̰ų� ALLEN �̸� 
-- �������� SALESMAN�� ��� ��ȸ
SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

SELECT *
FROM emp
WHERE job='SALESMAN' OR (empno LIKE '78%' AND hiredate >= TO_DATE('19810601', 'YYYYMMDD'));

SELECT *
FROM emp
WHERE (job='SALESMAN' OR empno LIKE '78%') AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');


--���� 
-- SELECT *
-- FROM table
-- [WHERE]
-- ORDER BY {�÷�|��Ī|�÷��ε��� [ASC | DESC], ....}

-- emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ �ϼ���
SELECT *
FROM emp
ORDER BY ename;

-- emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ �ϼ���
SELECT *
FROM emp
ORDER BY ename DESC;

DESC emp; -- DESC : DESCRIBE (�����ϴ�)
ORDER BY ename DESC -- DESC : DESCENDING (����)

-- emp ���̺��� ��� ������ ename�÷����� ��������, 
-- ename ���� ���� ��� mgr �÷����� �������� �����ϴ� ������ �ۼ��ϼ���
SELECT *
FROM emp
ORDER BY ename DESC, mgr;

--���Ľ� ��Ī�� ���
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY year_sal;

-- �÷� �ε����� ����
-- java array[0]
-- SQL COLUMN INDEX : 1���� ����
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY 3;


--ORDERBY1
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

--ORDERBY2
SELECT *
FROM emp
WHERE comm IS NOT NULL
AND comm != 0;

SELECT *
FROM emp
WHERE comm > 0
ORDER BY comm DESC, empno ASC;

--ORDERBY3
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;