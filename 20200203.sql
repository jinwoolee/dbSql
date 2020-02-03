SELECT *
FROM member;

SELECT *
FROM cart;

SELECT *
FROM prod;

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member, cart, prod
WHERE member.mem_id =cart.cart_member
AND cart.cart_prod = prod.prod_id;

-- ANSI
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member JOIN cart ON ( member.mem_id = cart.cart_member )
            JOIN prod ON cart.cart_prod = prod.prod_id;
            

SELECT *
FROM CUSTOMER;

SELECT *
FROM PRODUCT;

SELECT *
FROM CYCLE;

--�Ǹ��� : 200~250
-- ���� 2.5�� ��ǰ
-- �Ϸ� : 500~750
-- �Ѵ� : 15000~17500

SELECT *
FROM daily;

SELECT *
FROM batch;


join4 : join�� �ϸ鼭 ROW�� �����ϴ� ������ ����; 
SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
AND customer.cnm IN( 'brown', 'sally');


join5 : join�� �ϸ鼭(3�� ���̺�) ROW�� �����ϴ� ������ ����; 
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND customer.cnm IN( 'brown', 'sally');


join6 : join�� �ϸ鼭(3�� ���̺�) ROW�� �����ϴ� ������ ����, �׷��Լ� ����; 
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, SUM(cycle.cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;

join7 : ����;


SYSTEM ������ ���� hr ���� Ȱ��ȭ;
�ش� ����Ŭ ������ ��ϵ� �����(����)��ȸ;
SELECT *
FROM dba_users;

HR ������ ��й�ȣ�� JAVA�� �ʱ�ȭ;
ALTER USER HR IDENTIFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;


OUTER JOIN
�� ���̺��� ������ �� ���� ������ ���� ��Ű�� ���ϴ� �����͸�
�������� ������ ���̺��� �����͸��̶� ��ȸ �ǰԲ� �ϴ� ���� ���;

�������� : e.mgr = m.empno : KING�� MGR NULL�̱� ������ ���ο� �����Ѵ�
EMP ���̺��� �����ʹ� �� 14�������� �Ʒ��� ���� ���������� ����� 13���� �ȴ� (1���� ���ν���);
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI OUTER 
1. ���ο� �����ϴ��� ��ȸ���� ���̺��� ���� (�Ŵ��� ������ ��� ��������� �����Բ�);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno;

RIGHT OUTER�� ����
SELECT e.empno, e.ename, e.mgr, m.ename
FROM  emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno;

ORACLE OUTER JOIN 
�����Ͱ� ���� ���� ���̺� �÷� �ڿ� (+)��ȣ�� �ٿ��ش�;
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

���� SQL�� ANSI SQL(OUTER JOIN)���� �����غ�����;
�Ŵ����� �μ���ȣ�� 10���� ������ ��ȸ;
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10);

�Ʒ� LEFT OUTER ������ ���������� OUTER ������ �ƴϴ�
�Ʒ� INNER ���ΰ� ����� �����ϴ�;
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = 10;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = 10;

����Ŭ OUTER JOIN
����Ŭ OUTER JOIN�� ���� ���̺��� �ݴ��� ���̺��� ��� �÷��� (+)�� �ٿ���
�������� OUTER JOIN���� �����Ѵ�
�� �÷��̶� (+)�� �����ϸ� INNER �������� ����;

�Ʒ� ORACLE OUTER ������ INNER �������� ���� : m.deptno �÷��� (+)�� ���� ����
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

��� - �Ŵ����� RIGHT OUTER JOIN;
SELECT empno, ename, mgr
FROM emp e;

SELECT empno, ename
FROM emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ� ����;
LEFT OUTER : 14��, RIGHT OUTER : 21��, FULL OUTER : 22��;
SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

����Ŭ OUTER JOIN������ (+)��ȣ�� �̿��Ͽ� FULL OUTER ������ �������� �ʴ´�
SELECT m.ename, s.ename 
FROM   emp m, emp s
WHERE m.mgr(+) = s.empno(+);


SELECT m.ename, s.ename 
FROM   emp m LEFT OUTER JOIN emp s ON ( m.mgr = s.empno ) 

UNION 

SELECT m.ename, s.ename 
FROM   emp m RIGHT OUTER JOIN emp s ON ( m.mgr = s.empno ) 

MINUS 

SELECT m.ename, s.ename 
FROM   emp m FULL OUTER JOIN emp s ON ( m.mgr = s.empno ); 



SELECT m.ename, s.ename 
FROM   emp m LEFT OUTER JOIN emp s ON ( m.mgr = s.empno ) 

UNION 

SELECT m.ename, s.ename 
FROM   emp m RIGHT OUTER JOIN emp s ON ( m.mgr = s.empno ) 

INTERSECT

SELECT m.ename, s.ename 
FROM   emp m FULL OUTER JOIN emp s ON ( m.mgr = s.empno ); 


SELECT a.buy_date, a.buy_qty, b.prod_name
FROM buyprod a, prod b
WHERE a.buy_prod = b.prod_id(+)
AND a.buy_date = TO_DATE('20050125', 'YYYYMMDD');


SELECT a.buy_date, a.buy_qty, b.prod_name
FROM buyprod a left outer join prod b ON ( a.buy_prod = b.prod_id 
                                       AND a.buy_date = TO_DATE('20050125', 'YYYYMMDD'));


OUTERJOIN1;
SELECT count(*) --148
FROM buyprod;

SELECT *
FROM buyprod;

SELECT count(*) --74
FROM prod;

SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod, buyprod
WHERE prod.prod_id(+)= buyprod.buy_prod;
AND buyprod.buy_date = TO_DATE('20050125', 'YYYYMMDD');

SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod LEFT OUTER JOIN buyprod ON ( prod.prod_id = buyprod.buy_prod
                                   AND buyprod.buy_date = TO_DATE('20050125', 'YYYYMMDD'));

OUTERJOIN2;
SELECT NVL(buyprod.buy_date, TO_DATE('20050125', 'YYYYMMDD')) buy_date,
       buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('20050125', 'YYYYMMDD');
