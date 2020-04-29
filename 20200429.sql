SELECT e.manager_id mgr_id, m.first_name || m.last_name mgr_name, 
       e.employee_id, e.first_name || e.last_name name,
       e.job_id, jobs.job_title
FROM employees e, jobs, employees m
WHERE e.job_id = jobs.job_id
  AND e.manager_id = m.employee_id;


SELECT *
FROM jobs;


OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<===>
INNER JOIN(�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN    : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN   : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN    : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp���̺��� �÷��� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó���� 
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��.


INNER ���� ���� 
������ ���� ����� ���, ����� �̸�, ���� ���, ���� �̸�


������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�
==> KING�� ����� ����(mgr)�� NULL�̱� ������ ���ο� �����ϰ�
    KING�� ������ ������ �ʴ´� (emp ���̺� �Ǽ� 14�� ==> ���� ��� 13��)
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno );


���� ������ OUTER �������� ����
(KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������, 
 ������ ����� ������ ���� ������ ������ �ʴ´�)

ANSI-SQL : OUTER 
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno );

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON ( e.mgr = m.empno ); 

ORACLE-SQL : OUTER
oracle join
1. FROM���� ������ ���̺� ���(�޸��� ����)
2. WHERE ���� ���� ������ ���
3. ���� �÷�(�����)�� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ� �ش�
   ==> ������ ���̺� �ݴ����� ���̺��� �÷�

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno AND m.deptno = 10);

ORACLE-SQL
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e, emp m
WHERE e.mgr(+) = m.empno
  AND m.deptno = 10;




������ WHERE���� ������� �� 
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON ( e.mgr = m.empno)
WHERE e.deptno = 10;

SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
  AND e.deptno = 10;
  
  
OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�

outerjoin1]
SELECT *
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT *
FROM prod;

outerjoin1]
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod ON (prod.prod_id = buyprod.buy_prod AND
                                      buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));


SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');


outerjoin2]
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD'), buy_prod, prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 
outerjoin3]
NVL, NVL2, COALESCE
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD'), buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');


outerjoin4]
SELECT * 
FROM product;

SELECT *
FROM cycle
WHERE cid=1;


SELECT *
FROM customer
WHERE cid = 1;

SELECT product.pid, product.pnm, 1 cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt
 FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cycle.cid=1)
                         JOIN CUSTOMER;
                         
SELECT product.pid, product.pnm, 1 cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt
 FROM product JOIN cycle ON (product.pid = cycle.pid AND cycle.cid=1)
              JOIN customer ;
                         
15 ==> 45
3�� ==> customer ���̺��� ���� ����
SELECT *
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�

emp 14 * dept 4 = 56

ANSI-SQL
SELECT *
FROM emp CROSS JOIN dept;

ORACLE (���� ���̺� ����ϰ� WHERE ���� ������ ������� �ʴ´�)
SELECT *
FROM emp, dept;

crossjoin1]
SELECT *
FROM customer, product;




��������
WHERE : ������ �����ϴ� �ุ ��ȸ�ǵ��� ����
SELECT *
FROM emp
WHERE 1 = 1
  OR  1 != 1;
  
  1 = 1  OR  1 != 1
  TRUE OR FALSE ==> TRUE

SELECT *
FROM emp
WHERE deptno = 10;

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1. SELECT
    SCALAR SUB QUERY
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�
     EX) DUAL���̺�
    
2. FROM 
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��
    
3. WHERE 
    SUB QUERY
    WHERE ���� ���� ����


SMITH�� ���� �μ��� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������??
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
    �ι�° ������ ù��°�� ������ ����� ���� ���� �ٸ� �����;� �Ѵ�
    (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 20������ 30������ ������ ����
     ==> �������� ���鿡�� ����)
     
ù��° ����;
SELECT deptno   -- 20
FROM emp
WHERE ename = 'SMITH'; 

�ι�° ����;
SELECT *
FROM emp
WHERE deptno = 20;

���������� ���� ���� ����
SELECT *
FROM emp
WHERE deptno = (SELECT deptno   -- 20
                FROM emp
                WHERE ename = :ename);


sub1]
��ü ������ �޿� ���

2073.21....
SELECT AVG(sal)
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
             
sub2]
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);







