SUB4;
dept ���̺��� 5���� �����Ͱ� ����
emp ���̺��� 14���� ������ �ְ�, ������ �ϳ��� �μ� ���� �ִ�(deptno)
�μ��� ������ ���� ���� ���� �μ� ������ ��ȸ

������������ �������� ������ �´��� Ȯ���� ������ �ϴ� �������� �ۼ�;

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                     GROUP BY deptno);

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno
                     FROM emp);                     

sub5
��� ��ǰ�� ���� 4����;
SELECT *
FROM product;

cid=1�� ���� �����ϴ� ��ǰ;
SELECT pid
FROM cycle
WHERE cid = 1;

SELECT *
FROM product 
WHERE pid NOT IN (100, 400);

SELECT *
FROM product 
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);

sub6
cid=2�� ���� �����ϴ� ��ǰ�� cid=1�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ�ϴ� ���� �ۼ�;

cid=1�� ���� �������� ==> 100, 400�� ��ǰ�� ������;
SELECT *
FROM cycle
WHERE cid = 1;

cid=2�� ���� �����ϴ� ��ǰ ==> 100, 200 ��ǰ�� ������;
SELECT pid
FROM cycle
WHERE cid = 2;

cid =1, cid=2�� ���� ���ÿ� �����ϴ� ��ǰ�� 100��;
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN ( SELECT pid
             FROM cycle
             WHERE cid = 2 );

sub7 : sub6�� �������� ��ǰ���� �߰�;

SELECT a.cid, customer.cnm, a.pid, product.pnm, a.day, a.cnt
FROM 
    (SELECT *
    FROM cycle
    WHERE cid = 1
    AND pid IN ( SELECT pid
                 FROM cycle
                 WHERE cid = 2 )) a, customer, product
WHERE a.cid = customer.cid
AND   a.pid = product.pid;

SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.pid IN ( SELECT pid
                   FROM cycle
                   WHERE cid = 2 )
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;


SELECT cycle.cid, (SELECT cnm FROM customer WHERE cid = cycle.cid) cnm,
       cycle.pid, (SELECT pnm FROM product WHERE pid = cycle.pid) pnm,
       cycle.day, cycle.cnt
FROM cycle
WHERE cid = 1
AND pid IN ( SELECT pid
             FROM cycle
             WHERE cid = 2 );
             
             
�Ŵ����� �����ϴ� ������ ��ȸ(KING�� ������ 13���� �����Ͱ� ��ȸ);
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

EXSITS ���ǿ� �����ϴ� ���� ���� �ϴ��� Ȯ���ϴ� ������
�ٸ� �����ڿ� �ٸ��� WHERE ���� �÷��� ������� �ʴ´�
  . WHERE empno = 7369
  . WHERE EXISTS (SELECT 'X'  
                  FROM .....);

�Ŵ����� �����ϴ� ������ EXISTS �����ڸ� ���� ��ȸ
�Ŵ����� ����;
SELECT empno, ename, mgr
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);
              
sub9
1�� ���� �����ϴ� ��ǰ ==> 100, 400;
SELECT *
FROM cycle
WHERE cid = 1;

100	����Ʈ (O)
200	�� (X)
300	���۽� (X)
400	����Ʈ400 (O);

SELECT *
FROM cycle
WHERE cid = 1;

DELETE cycle
WHERE cid = 1
AND pid = 400;
ROLLBACK;

SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid = product.pid);

sub10;              
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid = product.pid);              

���տ���
������ : UNION - �ߺ�����(���հ���) / UNION ALL - �ߺ��� �������� ����(�ӵ� ���)
������ : INTERSECT (���հ���)
������ : MINUS (���հ���)
���տ��� �������
�� ������ �÷��� ����, Ÿ���� ��ġ �ؾ� �Ѵ�;

������ ������ �����ϱ� ������ �ߺ��Ǵ� �����ʹ� �ѹ��� ����ȴ�
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


UNION ALL�����ڴ� UNION �����ڿ� �ٸ��� �ߺ��� ����Ѵ�;
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


INTERSECT (������) : ��, �Ʒ� ���տ��� ���� ���� �ุ ��ȸ
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369);


MINUS(������) : �� ���տ��� �Ʒ� ������ �����͸� ������ ������ ����;
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

������ ��� ������ ������ ���� ���տ�����
A UNION B        B UNION A ==> ����
A UNION ALL B    B UNION ALL A ==> ����(����)
A INTERSECT B    B INTERSECT A ==> ����
A MINUS B        B MINUS A     ==> �ٸ�;

���տ����� ��� �÷� �̸��� ù��° ������ �÷����� ������;
SELECT 'X' fir, 'B' sec
FROM dual

UNION 

SELECT 'Y', 'A' 
FROM dual;

����(ORDER BY )�� ���տ��� ���� ������ ���� ������ ���;

SELECT deptno, dname, loc
FROM (SELECT deptno, dname, loc
      FROM dept
      WHERE deptno IN (10, 20)
      ORDER BY DEPTNO)

UNION 

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (30, 40)
ORDER BY DEPTNO;




�ܹ��� ���� ��������;

SELECT *
FROM fastfood;

�������� ==> (kfc���� + ����ŷ ���� + �Ƶ����� ����) / �Ե����� ����
�õ�, �ñ���, ��������
�������� ���� ���� ���ð� ���� �������� ����;

������ �ۼ����� ���Ͻ� ���� �Ʒ� �ټ����� �ñ��� �� ���������� ����� �����ּ���;
������ ����� �������� :  1.5
������ �߱� �������� : 
������ ���� �������� : 
������ ������ �������� : 
������ ���� �������� : 
