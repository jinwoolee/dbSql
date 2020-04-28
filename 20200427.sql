grp7]
dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ==> ȸ�系�� �����ϴ� ��� �μ�����
emp ���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==> 10, 20, 30 ==> 3��

SELECT COUNT(*)cnt
FROM 
    (SELECT COUNT(*) cnt
     FROM
        (SELECT deptno  /*deptno �÷��� 1�� ����, row�� 3���� ���̺� */
         FROM emp
         GROUP BY deptno));

DBMS �� RDBMS         
DBMS : DataBase Management System
 ==> db
RDBMS : Relational DataBase Management System
 ==> ������ �����ͺ��̽� ���� �ý���
      80�� �ʹ�


SELECT *
FROM emp;

SELECT *
FROM dept;

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE)

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �Ҽ� �ִ� �÷��� ������ ��������(���� Ȯ��)

���տ��� ==> ���� Ȯ�� (���� ��������)


NATURAL JOIN
    . �����Ϸ��� �� ���̺��� ����� �÷��� �̸� ���� ���
    . emp, dept ���̺��� detpno��� �����(������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
    . �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������
      ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����

.emp ���̺� : 14��
.dept ���̺� : 4��

SELECT *
FROM dept;

���� �Ϸ����ϴ� �÷��� ���� ������� ����
SELECT *
FROM emp NATURAL JOIN dept;


ORALCE ���� ������ ANSI ����ó�� ������ ���� ����
����Ŭ ���� ����
 1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
 2. ����� ������ WHERE���� ����ϸ� �ȴ� (ex : WHERE emp.deptno = dept.deptno)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno�� 10���� �����鸸 dept ���̺�� ���� �Ͽ� ��ȸ

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno = 10;


ANSI-SQL : JOIN with USING
 . join �Ϸ��� �׺� �̸��� ���� �÷��� 2�� �̻��� ��
 . �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���

SELECT *
FROM emp JOIN dept USING (deptno)
 
 
ANSI-SQL : JOIN with ON
 . ���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
 . ON���� ����� ������ ���;

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
ORALCE �������� �� SQL�� �ۼ� 
 
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno; 


JOIN�� ������ ����
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
EMP ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����.
�ش� ������ �������� �̸��� �˰���� ��
 
ANSI-SQL�� SQL ���� : 
�����Ϸ��� �ϴ� ���̺� EMP(����),EMP(������ ������)
              ����� �÷�: ����.MGR = ������.EMPNO
               ==> ���� �÷� �̸��� �ٸ���(MGR, EMPNO)  
                    ==> NATURAL JOIN, JOIN with USING�� ����� �Ұ����� ����
                        ==> JOIN with ON
 
ANSI-SQL�� �ۼ�;

SELECT *
FROM emp e JOIN emp m ON (e.mgr = m.empno);
 
 
NONEQUI JOIN : ����� ������ =�� �ƴҶ� 

�׵��� WHERE���� ����� ������ : =, !=, <>, <=, <, >, >=
                             AND, OR, NOT
                             LIKE %, _
                             OR - IN
                             BETWEEN AND ==>  >=, <=

SELECT *
FROM emp;

SELECT *
FROM salgrade;
 
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON ( emp.sal BETWEEN salgrade.losal AND salgrade.hisal )

==> ORACLE ���� �������� ����;
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

 
 
join0]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
 
join0_1]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND dept.deptno IN (10, 30)
  AND emp.deptno IN (10, 30); 
 
 
join0_2]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500;
   
 
join0_3~4]����

�����غ���
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno <= dept.deptno;

emp : 14
dept : 4  (3)

