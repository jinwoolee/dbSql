������

��Ģ ������ : +, -, *, / : ���� ������
���� ������ : ?  1==1 ? true�϶� ���� : fasle�� �� ����

SQL ������ 
=  : �÷�|ǥ���� = �� ==> ���� ������
   = 1
IN : �÷�|ǥ���� IN (����)
  deptno IN (10, 30) ==> IN (10, 30),  deptno (10, 30)
  
EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

���������� ���� ���� ���� ���������� ���� ����� �׻� ���� �ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�

�Ʒ� ������ ���ȣ ��������
�Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� ���̻� Ž���� ���� �ʰ� �ߴ�.
���� ���� ���ο� ������ ���� �� ���

SELECT *
FROM emp;
WHERE EXISTS (SELECT 'X'
              FROM dept);


�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ����: 14-KING =13���� ����
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno)


IS NOT NULL�� ���ؼ��� ������ ����� ����� �� �� �ִ�
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

join
SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;

sub9]
SELECT *
FROM product;

1�� �� �Դ� ��ǰ����
SELECT *
FROM cycle
WHERE cid=1;

SELECT *
FROM product
WHERE EXISTS ( SELECT *
               FROM cycle
               WHERE cycle.cid=1
                 AND cycle.pid = product.pid);

sub10]               
SELECT *
FROM product
WHERE NOT EXISTS ( SELECT *
                   FROM cycle
                   WHERE cycle.cid=1
                   AND cycle.pid = product.pid);


���տ���
������
{1, 5, 3} U {2, 3} = {1, 2, 3, 5}

SQL���� �����ϴ� UNION ALL (�ߺ� �����͸� ���� ���� �ʴ´�)
{1, 5, 3} U {2, 3} = {1, 5, 3, 2, 3}

������
{1, 5, 3} ������ {2, 3} = {3}

������
{1, 5, 3} - {2, 3} = {1, 5}

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ�� (��, �Ʒ��� ���� �ȴ�)



UNION ������ : �ߺ�����(������ ������ ���հ� ����)

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


UNION ALL ������ : �ߺ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


INTERSECT ������ : �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


MINUS  ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)


SQL ���տ������� Ư¡

1. ���� �̸� : ù�� SQL�� �÷��� ���󰣴�

ù��° ������ �÷��� ��Ī �ο�
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)

UNION 

SELECT ename, empno
FROM emp
WHERE empno IN (7698);

2. ������ �ϰ���� ��� �������� ���� ����
   ���� SQL���� ORDER BY �Ұ� (�ζ��� �並 ����Ͽ� ������������ ORDER BY�� ������� ������ ����)
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY nm, �߰� ������ ���� �Ұ�
UNION 

SELECT ename, empno
FROM emp
WHERE empno IN (7698)
ORDER BY nm;

3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�(������ ���� ����� ����), �� UNION ALL�� �ߺ� ���

4. �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
   ==> ����ڿ��� ����� �����ִ� �������� ������
       ==> UNION ALL�� ����� �� �ִ� ��Ȳ�� ��� UNION�� ������� �ʾƾ� �ӵ����� ���鿡��
           �����ϴ�

�˰���(����-��ǰ, ���� ����, ���� ����,....
           �ڷ� ���� : Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
                      heap
                      stack, queue
                      list
 ���տ��꿡�� �߿��� ���� : �ߺ�����
 ���� ����
 for(int = 0; ...){
    for(int j = 1;....){
        code...
    }
 };
    

���ù�������

SELECT *
FROM FASTFOOD;






