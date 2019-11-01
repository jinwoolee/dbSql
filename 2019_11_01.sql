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

<<<<<<< HEAD
--orderby1
SELECT *
FROM dept
ORDER BY DNAME ASC;

SELECT *
FROM dept
ORDER BY LOC DESC;

--orderby2
SELECT *
FROM emp
WHERE comm is not null
ORDER BY comm DESC, empno ASC;

--orderby3
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job ASC, empno DESC;

--orderby4
SELECT *
FROM emp
--WHERE deptno IN (10, 30)
WHERE (deptno = 10 OR deptno= 30)
AND   sal > 1500
ORDER BY ename DESC;

desc emp;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM > 10;
--WHERE ROWNUM <= 10;


--emp ���̺��� ���(empno), �̸�(ename)�� �޿� �������� �������� �����ϰ�
--���ĵ� ��������� ROWNUM
SELECT empno, ename, sal, ROWNUM
FROM emp
ORDER BY sal;

--row_1
SELECT ROWNUM, B.*
FROM
    (SELECT empno, ename, sal
    FROM emp 
    ORDER BY sal) B
WHERE ROWNUM BETWEEN 1 AND 10;

--row_2
SELECT *
FROM
    (SELECT ROWNUM rn, B.*
    FROM
        (SELECT empno, ename, sal
        FROM emp 
        ORDER BY sal) B )
WHERE rn between 11 AND 20;


--FUNCTION
--DUAL ���̺� ��ȸ
SELECT 'HELLO WORLD' as msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--���ڿ� ��ҹ��� ���� �Լ� 
--LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'), UPPER('Hello, World')
     , INITCAP('hello, world')
FROM dual;

SELECT LOWER('Hello, World'), UPPER('Hello, World')
     , INITCAP('hello, world')
FROM emp
WHERE job = 'SALESMAN';

--FUNCTION�� WHERE�������� ��밡��
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';
--������ SQL ĥ������
--1.�º��� �������� ���ƶ�
--�º�(TABLE �� �÷�) �� �����ϰ� �Ǹ� INDEX�� ���������� ������� ����
--Function Based Index ->  FBI

--CONCAT : ���ڿ� ���� - �ΰ��� ���ڿ��� �����ϴ� �Լ�
--SUBSTR : ���ڿ��� �κ� ���ڿ� (java : String.substring)
--LENGTH : ���ڿ��� ����
--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù�� ° �ε���
--LPAD : ���ڿ��� Ư�� ���ڿ��� ����
SELECT CONCAT(CONCAT('HELLO', ', ') , 'WORLD') CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5) substr,
       SUBSTR('HELLO, WORLD', 1, 5) substr1,
       LENGTH('HELLO, WORLD') length,
       INSTR('HELLO, WORLD', 'O') instr,
       --INSTR(���ڿ�, ã�� ���ڿ�, ���ڿ��� Ư�� ��ġ ���� ǥ��)
       INSTR('HELLO, WORLD', 'O', 6) instr1,
       --LPAD(���ڿ�, ��ü ���ڿ�����, 
       --            ���ڿ��� ��ü���ڿ����̿� ��ġ�� ���Ұ�� �߰��� ����);
       LPAD('HELLO, WORLD', 15, '*') lpad,
       LPAD('HELLO, WORLD', 15) lpad,
       LPAD('HELLO, WORLD', 15, ' ') lpad,
       RPAD('HELLO, WORLD', 15, '*') rpad      
FROM dual;






=======
>>>>>>> 69786431e6ffbc252badfe0653cc1423b9d5940e


