fastfood ���̺� �ѹ��� �а� ���ù������� ���ϱ�;

���� �ܹ������� �ּ�( �����̽�, ������ġ �����ϰ� ���)
SELECT ROWNUM rank, sido, sigungu, city_idx
FROM
    (SELECT sido, sigungu, ROUND((kfc + mac + bk) / lot, 2) city_idx
    FROM 
    (SELECT sido, sigungu,
           NVL(SUM(CASE WHEN gb = '�Ե�����' THEN 1 END), 1) lot, 
           NVL(SUM(CASE WHEN gb = 'KFC' THEN 1 END), 0) kfc,
           NVL(SUM(CASE WHEN gb = '�Ƶ�����' THEN 1 END), 0) mac,
           NVL(SUM(CASE WHEN gb = '����ŷ' THEN 1 END), 0) bk
    FROM fastfood
    WHERE gb IN ('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
    GROUP BY sido, sigungu)
    ORDER BY city_idx DESC);

1�� ����]
SELECT b.rank, a.sido, a.sigungu, a.city_idx, b.sido, b.sigungu, b.tax
FROM 
(SELECT ROWNUM rank, sido, sigungu, city_idx
FROM
    (SELECT sido, sigungu, ROUND((kfc + mac + bk) / lot, 2) city_idx
    FROM 
    (SELECT sido, sigungu,
           NVL(SUM(CASE WHEN gb = '�Ե�����' THEN 1 END), 1) lot, 
           NVL(SUM(CASE WHEN gb = 'KFC' THEN 1 END), 0) kfc,
           NVL(SUM(CASE WHEN gb = '�Ƶ�����' THEN 1 END), 0) mac,
           NVL(SUM(CASE WHEN gb = '����ŷ' THEN 1 END), 0) bk
    FROM fastfood
    WHERE gb IN ('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
    GROUP BY sido, sigungu)
    ORDER BY city_idx DESC)) a, 
    
(SELECT ROWNUM rank, sido, sigungu, tax
FROM 
    (SELECT sido, sigungu, ROUND(sal/people, 2) tax
     FROM tax
    ORDER BY tax DESC)) b
WHERE a.rank(+) = b.rank
ORDER BY b.rank;

SELECT *
FROM fastfood;

3�� ����]
case �ι��� ���

SELECT �õ�, �ñ���, (KFC ��Į�� ��������), (����ŷ ��Į�� ��������), (....)
FROM ...


DML
�����͸� �Է�(INSERT), ����(UPDATE), ����(DELETE) �� �� ����ϴ� SQL

INSERT

����
INSERT INTO ���̺�� [(���̺��� �÷���, ....)] VALUES (�Է��� ��, ....);

ũ�� ���� �ΰ��� ���·� ���
1. ���̺��� ��� �÷��� ���� �Է��ϴ� ���, �÷����� �������� �ʾƵ� �ȴ�
   �� �Է��� ���� ������ ���̺� ���ǵ� �÷� ������ �νĵȴ�
INSERT INTO ���̺�� VALUES (�Է��� ��, �Է��� ��2....);

2.�Է��ϰ��� �ϴ� �÷��� ����ϴ� ���
  ����ڰ� �Է��ϰ��� �ϴ� �÷��� �����Ͽ� �����͸� �Է��� ���.
  �� ���̺� NOT NULL ������ �Ǿ��ִ� �÷��� �����Ǹ� INSERT�� �����Ѵ�
INSERT INTO ���̺�� (�÷�1, �÷�2) VALUES (�Է��� ��, �Է��� ��2);

3. SELECT ����� INSERT
   SELECT ������ �̿��ؼ� ������ ���� ��ȸ�Ǵ� ����� ���̺� �Է� ����
   ==> �������� �����͸� �ϳ��� ������ �Է� ����(ONE-QUERY) ==> ���� ����
   
   ����ڷ� ���� �����͸� ���� �Է� �޴� ��� (ex ȸ������)�� ������ �Ұ�
   db�� �����ϴ� �����͸� ���� �����ϴ� ��� Ȱ�� ����(�̷� ��찡 ����)
   
   INSERT INTO ���̺�� [(�÷���1, �÷���2...)}
   SELECT ......
   FROM .....
   
   
   



dept ���̺� deptno 99, dname DDIT, loc daejeon ���� �Է��ϴ� INSERT ���� �ۼ�

SELECT *
FROM dept;

INSERT INTO dept VALUES (99, 'DDIT', 'daejeon');

SELECT *
FROM dept;

������ �Է��� Ȯ�� �������� : commit - Ʈ����� �Ϸ�
������ �Է��� ��� �Ϸ��� : rollback - Ʈ����� ���

rollback;

SELECT *
FROM dept;

INSERT INTO dept (loc, deptno, dname) VALUES ('daejeon', 99, 'DDIT');

SELECT *
FROM dept;

rollback;

���� INSERT ������ ������ ���ڿ�, ����� �Է��� ���
INSERT �������� ��Į�� ��������, �Լ��� ��� ����
EX : ���̺� �����Ͱ� �� ����� �Ͻ������� ��� �ϴ� ��찡 ���� ==> SYSDATE

SELECT *
FROM emp;

emp ���̺��� ��� �÷� �� ������ 8��, NOT NULL�� 1��(EMPNO)
empno�� 9999�̰� ename�� �����̸�, hiredate�� ���� �Ͻø� �����ϴ� INSERT ������ �ۼ�

INSERT INTO emp (empno, ename, hiredate) VALUES (9999, 'jw', SYSDATE);
INSERT ���� ������� ���� �÷����� ���� NULL�� �Էµȴ�

SELECT *
FROM emp;

9998�� ������� jw ����� �Է�, �Ի����ڴ� 2020�� 4�� 13�Ϸ� �����Ͽ� ������ �Է�
INSERT INTO emp (empno, ename, hiredate) VALUES (9998, 'jw', TO_DATE('2020/04/13', 'YYYY/MM/DD'));


empno �÷��� NOT NULL (DESC emp)
INSERT INTO emp (ename, hiredate) VALUES ('jw', TO_DATE('2020/04/13', 'YYYY/MM/DD'));



3. SELECT ����� ���̺� �Է��ϱ� (�뷮 �Է�)

DESC dept;

dept ���̺��� 4���� �����Ͱ� ����(10~40)
�Ʒ������� �����ϸ�  ���� ���� 4�� + SELECT �� �ԷµǴ� 4�� �� 8���� �����Ͱ� dept ���̺� �Էµ�
INSERT INTO dept
SELECT *
FROM dept;

������ Ȯ��
SELECT *
FROM dept;

������ �۾��� INSERT ������ ��� 
ROLLBACK;

UPDATE : ������ ����
UPDATE ���̺�� SET ������ �÷�1 = ������ ��1,
                   [������ �÷�1 = ������ ��1, ....]
[WHERE condition-SELECT ������ ��� WHERE���� ����
       ������ ���� �ν��ϴ� ������ ���]
       
dept ���̺� 99, DDIT, daejeon;

INSERT INTO dept VALUES (99, 'DDIT', 'daejeon');

������ �Է� Ȯ��
SELECT *
FROM dept;

UPDATE ���̺�� SET ������ �÷�1 = ������ ��1,
                   [������ �÷�1 = ������ ��1, ....]
[WHERE condition-SELECT ������ ��� WHERE���� ����
       ������ ���� �ν��ϴ� ������ ���]

99�� �μ��� �μ����� ���IT��, ��ġ�� ���κ������� ����

UPDATE dept SET dname = '���IT', 
                loc = '���κ���'
WHERE deptno=99;

SELECT *
FROM dept
WHERE deptno=99;

SELECT *
FROM dept;
                
�Ʒ� ������ dept ���̺��� ��� ���� �μ���� ��ġ�� �����ϴ� ����                
UPDATE dept SET dname = '���IT', 
                loc = '���κ���'            

INSERT : ���� �� ���� ����
UPDATE, DELETE : ������ �ִ°� ����, ����
  ==> ������ �ۼ��� ��� ����
      1. WHERE���� �������� �ʾҴ���
      2. UPDATE, DELETE ���� �����ϱ����� WHERE���� �����ؼ� SELECT�� �Ͽ�
         ������ ���� ���� ������ Ȯ��

��������̺� - �Ϲ�����, ������(�߻�), ���(����STAFF), �����                

UPDATE ��������̺� SET ��й�ȣ = �ֹι�ȣ ���ڸ�
WHERE ����ڱ��� IN ('�����');


������-PC
�����(��ȹ��, �����̳�, ���� �����Ͼ�) => �׽�Ʈ ����(����� ���� ����� �ټҳ���)
� ����(��¥ �ߵǳ�...�׽�Ʈ�� ����)

OPEN - ������� �÷� ���� �׽�Ʈ �����͸� ���� ==> ���� ���α׷� 
1. �ּ��� ���� ������ �ȵǰ�
2. ���α׷��� ����

2��3�ϰ� ����..

ORACLE ����ڿ��Դ� UPDATE, DELETE�� �Ǽ� ���� ��� �ѹ��� ��ȸ�� ����
ROLLBACK;
....




INSERT
COMMIT;

INSERT
ROLLBACK;



���������� �̿��� ������ ����
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);

9999�� ������ deptno, job �ΰ��� �÷��� SMITH ����� ������ �����ϰ� ����

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               job = (SELECT job FROM emp WHERE ename = 'SMITH'),
               sal = (SELECT sal FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

�Ϲ����� UPDATE ���������� �÷����� ���������� �ۼ��Ͽ� ��ȿ���� ����
==> MERGE ������ ���� ��ȿ���� ���� �� �� �ִ�.

SELECT *
FROM emp
WHERE empno = 9999;

��������� ���
ROLLBACK;


DELETE : ���̺� �����ϴ� �����͸� ����
����

DELETE [FROM] ���̺��
[WHERE condition]

������
1. Ư�� �÷��� ���� ���� ==> �ش� �÷��� NULL�� UPDATE
   DELETE���� �� ��ü�� ����
2. UPDATE ���������� DELETE ������ �����ϱ� ���� SELECT�� ���� ���� ����̵Ǵ� ���� ��ȸ, Ȯ������

���� �׽�Ʈ ������ �Է�
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);

����� 9999���� ���� ���� �ϴ� ���� �ۼ�
DELETE emp 
WHERE empno = 9999;

SELECT *
FROM emp 
WHERE empno = 9999;

ROLLBACK;

�Ʒ� ������ �ǹ� : emp ���̺��� ��� ���� ����
DELETE emp;

SELECT *
FROM emp;

ROLLBACK;

SELECT *
FROM emp;

UPDATE, DELETE ���� ��� ���̺� �����ϴ� �����Ϳ� ����, ������ �ϴ� ���̱� ������
��� ���� �����ϱ� ���� WHERE ���� ����� ���ְ�
WHERE���� SELECT ������ ����� ������ ���� �� �� �ִ�
���� ��� ���������� ���� ���� ������ ����

�Ŵ����� 7698�� �������� ��� ���� �ϰ� ���� ��

DELETE emp
WHERE empno IN
        (SELECT empno
         FROM emp
         WHERE mgr = 7698);

SELECT *
FROM emp;

ROLLBACK;


DML : SELECT, INSERT, UPDATE, DELETE 
WHERE ���� ��� ������ DML : SELECT, UPDATE, DELETE 
  3���� ������ �����͸� �ĺ��ϴ� WHERE ���� ��� �� �� �ִ�
  �����͸� �ĺ��ϴ� �ӵ��� ���� ������ ���� ������ �¿� ��.
  ==> INDEX ��ü�� ���� �ӵ� ����� ����
  
INSERT : ������� �ű� �����͸� �Է� �ϴ� ��
         ������� �ĺ��ϴ°� �߿�
         ==> �����ڰ� �� �� �ִ� Ʃ�� ����Ʈ�� ���� ����


���̺��� �����͸� ����� ��� (��� ������ �����)
1. DELETE : WHERE���� ������� ������ ��
2. TRUNCATE 
   ���� : TRUNCATE TABLE ���̺��
   Ư¡ : 1) ������ �α׸� ������ ����
             ==> ������ �Ұ���
         2) �α׸� ������ �ʱ� ������ ���� �ӵ��� ������
            ==> �ȯ�濡���� �� ������� ���� (������ �ȵǱ� ������)
                �׽�Ʈ ȯ�濡�� �ַ� ���

�����͸� �����Ͽ� ���̺� ����(���� �غ���)

CREATE TABLE emp_copy AS
SELECT *
FROM emp;

SELECT *
FROM emp;

SELECT *
FROM emp_copy;

emp_copy ���̺��� TRUNCATE ����� ���� ��� �����͸� ����
TRUNCATE TABLE emp_copy;

SELECT *
FROM emp_copy;

ROLLBACK;

SELECT *
FROM emp_copy;



Ʈ����� : ������ ���� ����
ex : ATM- ��ݰ� �Ա��� �Ѵ� ���������� �̷������ ������ �߻����� ����
          ����� ���� ó�� �Ǿ����� �Ա��� ������ ó�� �Ǿ��ٸ� 
          ���� ó���� ��ݵ� ��Ҹ� ����� �Ѵ�
          
���
�Ա�(����)
ROLLBACK;

����Ŭ������ ù��° DML�� ������ �Ǹ� Ʈ���� �������� �ν�
Ʈ������� ROLLBACK, COMMIT�� ���� ���ᰡ �ȴ�

Ʈ����� ������ ���ο� DML�� ����Ǹ� ���ο� Ʈ������� ����


��� ����ϴ� �Խ����� �����غ���
�Խñ� �Է��� �� �Է� �ϴ°� : ����(1��), ����(1��), ÷������(���� ����)
RDBMS������ �Ӽ��� �ߺ��� ��� ������ ����Ƽ(���̺�)�� �и��� �Ѵ�
�Խñ� ���̺�(����, ����) / �Խñ� ÷������ ���̺�(÷�����Ͽ� ���� ����)

�Խñ��� �ϳ� ����� �ϴ���
�Խñ� ���̺��, �Խñ� ÷������ ���̺� �����͸� �űԷ� ����� �Ѵ�
INSERT INTO �Խñ� ���̺� (����, ����, �����, ����Ͻ�) VALUES (.......);
INSERT INTO �Խñ� ÷������ ���̺� (÷�����ϸ�, ÷������ ������) VALUES (.......);

�ΰ��� INSERT ������ �Խñ� ����� Ʈ����� ����
�� �ΰ��߿� �ϳ��� ������ ����� �Ϲ������� ROLLBACK�� ���� �� ���� INSERT ������ ���.


SELECT *
FROM dept;

INSERT INTO dept VALUES (99, 'DDIT', '����');

ROLLBACK;