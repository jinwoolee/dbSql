SELECT ���� ���� : 
    ��¥ ����(+, -) : ��¥ + ����, -���� : ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    ���� ����(....) : �����ð��� �ٷ��� ����...
    ���ڿ� ����
       ���ͷ� : ǥ����
                ���� ���ͷ� : ���ڷ� ǥ��
                ���� ���ͷ� : java : "���ڿ�" / sql : 'sql'
                           SELECT SELECT * FROM || table_name 
                           SELECT 'SELECT * FROM ' || table_name 
                     ���ڿ� ���տ��� : +�� �ƴ϶� || (java ������ +)
                ��¥?? : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ���� ����')
                        TO_DATE('20200417', 'yyyyMMdd')
                        
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����;
                        
SELECT *
FROM users
WHERE 1 = 1;

SELECT *
FROM users
WHERE 1 = 2;

SELECT *
FROM users
WHERE 1 != 1;

SELECT *
FROM users
WHERE userid = 'brown';                


sal���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND;
�񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����

sal >= 1000 AND sal <= 2000

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

exclusive or (��Ÿ�� or)
a or b  a=true, b=ture ==> true
a exclusive or b  a=true, b=true ==> false

SELECT *
FROM emp
WHERE sal >= 1000
  AND sal <= 2000;
  
  
where1]
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND 
                       TO_DATE('1983/01/01', 'YYYY/MM/DD');

where2]
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD')
  AND hiredate <= TO_DATE('1983/01/01', 'YYYY/MM/DD');
  
  
IN ������  
�÷�|Ư���� IN (��1, ��2,....)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�� �ϸ� TRUE

SELECT *
FROM emp
WHERE deptno IN (10, 30);
==> deptno�� 10�̰ų� 30���� ����
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 30;


SELECT *
FROM emp
WHERE deptno = 10
  OR deptno = 30;


where3]
SELECT userid AS "���̵�", usernm AS "�̸�", alias AS "����"
FROM users
WHERE userid IN ('brown', 'cony', 'sally');


���ڿ� ��Ī ���� : LIKE ���� / JAVA :.startsWith(prefix), .endsWith(suffix)
����ŷ ���ڿ� : % - ��� ���ڿ�(���� ����)
              _ - � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE

�÷�|Ư���� LIKE ���� ���ڿ�;

'cony' : cony�� ���ڿ�
'co%'  : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� ���ִ� ���ڿ�
        'cony', 'con', 'co'
'%co%' : co�� �����ϴ� ���ڿ�
         'cony', 'sally cony'
'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�         
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ�
         �̵��� �ϳ��� ���ڰ� �ü� �ִ� ���ڿ�

�÷�|Ư���� LIKE ���� ���ڿ�;        
���� �̸�(ename)�� �빮�� S�� �����ϴ� ������ ��ȸ       
SELECT *
FROM emp
WHERE ename LIKE 'S%';


where4]
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

where5]
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';


NULL ��
SQL �񱳿����� : =
  WHERE usernm = 'brown'

MGR�÷� ���� ���� ��� ������ ��ȸ  
SELECT *
FROM emp
WHERE mgr = NULL;

SQL���� NULL ���� ���� ��� �Ϲ�����
�񱳿�����(=)�� ��� ���ϰ� IS �����ڸ� ���

SELECT *
FROM emp
WHERE mgr IS NULL;

���� �ִ� ��Ȳ���� � �� : =, !=, <>
NULL : IS NULL , IS NOT NULL

emp���̺��� mgr �÷� ���� NULL�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT NULL;


where6]
SELECT *
FROM emp
WHERE comm IS NOT NULL;



SELECT *
FROM emp
WHERE mgr = 7698
  AND sal > 1000;
  
SELECT *
FROM emp
WHERE mgr = 7698
   OR sal > 1000;  
   
   
SELECT *
FROM emp
WHERE mgr IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);


IN�����ڸ� �� �����ڷ� ����
SELECT *
FROM emp
WHERE mgr IN (7698, 7839);
==> WHERE mgr = 7698 OR mgr = 7839 

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);
==> WHERE (mgr != 7698 AND mgr != 7839) 

where7]
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd')
  AND sal > 1300; 
  
  
where8]  
SELECT *
FROM emp
WHERE deptno != 10
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');
  
where9]  
SELECT *
FROM emp
WHERE deptno NOT IN ( 10 )
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');


where10]
SELECT *
FROM emp
WHERE deptno IN (20, 30)
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');


SELECT *
FROM emp
WHERE deptno IN (10, 20, 30)
  AND deptno != 10
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');
  
where11]
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
  OR hiredate >= TO_DATE('19810601', 'yyyymmdd')


where12]
DESC emp;
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%';
  
where13]
SELECT *
FROM emp
WHERE 
job = 'SALESMAN' OR empno =78  OR (empno >= 780 AND empno < 790) OR (empno >= 7800 AND empno < 7900);


where14]
SELECT *
FROM emp
WHERE (job = 'SALESMAN' 
   OR (empno >= 7800 AND empno < 7900)) 
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');
   

���� : {a, b, c} == {a, c, b}

table���� ��ȸ, ����� ������ ����(�������� ����)
==>  ���нð��� ���հ� ������ ����

SQL������ �����͸� �����Ϸ��� ������ ������ �ʿ�
ORDER BY �÷��� [��������], �÷���2 [��������].....
������ ���� : ��������(DEFAULT) - ASC, �������� - DESC

���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename ASC;

���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename DESC;

job�� �������� ���� ���������ϰ� job�� ������� �Ի����ڷ� �������� ����
��� ������ ��ȸ

SELECT *
FROM emp
ORDER BY job ASC, hiredate DESC;
