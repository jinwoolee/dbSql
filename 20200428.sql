join0_3]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500
  AND empno > 7600;
  
join0_4]
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND sal > 2500
  AND empno > 7600
  AND dname = RESEARCH;
  
  java : String s= "test";
  sql : 'test'  "tset", test
  

join1]
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM lprod, prod
WHERE lprod.lprod_gu = prod.prod_lgu;
  
join2]
SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;  

join2_1] ��� �Ǽ��� ���ϴ� SQL
74�� ==> 1��
�Ǽ� ==> COUNT

SELECT COUNT(*)
FROM
    (SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
    FROM prod, buyer
    WHERE prod.prod_buyer = buyer.buyer_id);  

SELECT COUNT(*)
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;  


BUYER_NAME �� �Ǽ� ��ȸ ���� �ۼ�
BUYER_NAME, �Ǽ�
    
SELECT buyer.buyer_name, COUNT(*)
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id
GROUP BY buyer.buyer_name;    
  

join3]
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
  AND cart.cart_prod = prod.prod_id;
  
  
���̺� JOIN ���̺� ON/USING

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member JOIN cart ON (member.mem_id = cart.cart_member) 
            JOIN prod ON (cart.cart_prod = prod.prod_id);
  
�������
10 3
20 5
30 6

SELECT *
FROM
    (SELECT deptno, COUNT(*)
     FROM emp
     GROUP BY deptno)
WHERE deptno = 30;

SELECT deptno, COUNT(*)
FROM emp
WHERE deptno = 30     
GROUP BY deptno;

SELECT *
FROM emp;

cid : customer id
cnm : customer name

SELECT *
FROM customer;

pid : product id
pnm : product name

SELECT *
FROM product;
  
cycle : �����ֱ�  
cid : �� id
pid : ��ǰ id
day : �������� (�Ͽ���-1 ������-2 ȭ����...)
cnt : ����
SELECT *
FROM cycle;


join4]
SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
  AND customer.cnm IN ('brown', 'sally');

SELECT cid, cnm, pid, day, cnt
FROM customer NATURAL JOIN cycle
WHERE customer.cnm IN ('brown', 'sally');


SELECT *
FROM cycle;


join5]
SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND customer.cnm IN ('brown', 'sally');
  
  
join6]
SELECT customer.cid, cnm, cycle.pid, pnm, SUM(cnt), COUNT(*)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, cycle.pid, pnm  
ORDER BY customer.cid, cycle.pid;


join7]
SELECT cycle.pid, pnm, SUM(cnt)
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, pnm;

SELECT a.pid, b.pnm, a.cnt
FROM
(SELECT pid, SUM(cnt) cnt
 FROM cycle
 GROUP BY cycle.pid) a, product b
WHERE a.pid = b.pid ;

