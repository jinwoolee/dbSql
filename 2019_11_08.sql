--���κ���
--���� �� ??
--RDBMS�� Ư���� ������ �ߺ��� �ִ� ������ ���踦 �Ѵ�
--EMP ���̺��� ������ ������ ����, �ش� ������ �Ҽ� �μ�������
-- �μ���ȣ�� �����ְ�, �μ���ȣ�� ���� dept ���̺�� ������ ����
-- �ش� �μ��� ������ ������ �� �ִ�

--���� ��ȣ, �����̸�, ������ �Ҽ� �μ���ȣ, �μ��̸�
--emp, dept
SELECT emp.empno, emp.ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;


--�μ���ȣ, �μ���, �ش�μ��� �ο���
--count(col) : col ���� �����ϸ�1, null : 0
--             ����� �ñ��� ���̸� *
SELECT dept.deptno, dname, count(*) cnt
FROM dept, emp
WHERE dept.deptno = emp.deptno
GROUP BY dept.deptno, dname;

--TOTAL ROW : 14
SELECT COUNT(*), COUNT(EMPNO), COUNT(MGR), COUNT(COMM) 
FROM emp;


--OUTER JOIN : ���ο� ���е� ������ �Ǵ� ���̺��� �����ʹ� ��ȸ�����
--              �������� �ϴ� ���� ����
--LEFT OUTER JOIN : JOIN KEYWORD ���ʿ� ��ġ�� ���̺��� ��ȸ ������ 
--                  �ǵ��� �ϴ� ���� ����
--RIGHT OUTER JOIN : JOIN KEYWORD �����ʿ� ��ġ�� ���̺��� ��ȸ ������ 
--                  �ǵ��� �ϴ� ���� ����
--FULL OUTER JOIN : LEFT OUTER JOIN + RIGHT OUTER JOIN - �ߺ�����

--���� ������, �ش� ������ ������ ���� outer join
--���� ��ȣ, �����̸�, ������ ��ȣ, ������ �̸�

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON (a.mgr = b.empno);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno);

--oracle outer join (left, right�� ���� fullouter�� �������� ����)
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno(+);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno;

-- ANSI LEFT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON(a.mgr = b.empno AND b.deptno=10);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON(a.mgr = b.empno)
WHERE b.deptno=10;

--oracle outer ���������� outer ���̺��̵Ǵ� ��� �÷��� (+)�� �ٿ����
-- outer joing�� ���������� �����Ѵ�
SELECT a.empno, a.ename, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno(+)
AND b.deptno(+) = 10;


--ANSI RIGHT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a RIGHT OUTER JOIN emp b ON (a.mgr = b.empno);



--outerjoin1
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name,
        buyprod.buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('05/01/25', 'YY/MM/DD');



--outerjoin2
SELECT TO_DATE('05/01/25', 'YY/MM/DD') buydate, buyprod.buy_prod, prod.prod_id, prod.prod_name,
        buyprod.buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('05/01/25', 'YY/MM/DD');

--outerjoin3
SELECT TO_DATE('05/01/25', 'YY/MM/DD') buydate, buyprod.buy_prod, prod.prod_id, prod.prod_name,
        nvl(buyprod.buy_qty, 0) buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('05/01/25', 'YY/MM/DD');


--outerjoin4
SELECT b.pid, b.pnm, 1 cid, nvl(a.day, 0) day, nvl(a.cnt, 0) cnt
FROM cycle a RIGHT OUTER JOIN product b ON (a.pid = b.pid AND a.cid = 1);

SELECT b.pid, b.pnm, 1 cid, nvl(a.day, 0) day, nvl(a.cnt, 0) cnt
FROM cycle a, product b
WHERE a.pid(+) = b.pid
AND a.cid(+) = 1;


SELECT a.pid, a.pnm, a.cid, c.cnm, a.day, a.cnt
FROM
    (SELECT b.pid, b.pnm, 1 cid, nvl(a.day, 0) day, nvl(a.cnt, 0) cnt
    FROM cycle a, product b
    WHERE a.pid(+) = b.pid
    AND a.cid(+) = 1) a, customer c
WHERE a.cid = c.cid;






--outerjoin5
SELECT b.pid, b.pnm, 1 cid, c.cnm, nvl(a.day, 0) day, nvl(a.cnt, 0) cnt
FROM cycle a RIGHT OUTER JOIN product b ON (a.pid = b.pid AND a.cid = 1)
     JOIN customer c ON( c.cid= nvl(a.cid, 1)) ;

SELECT a.pid, a.pnm, a.cid, c.cnm, a.day, a.cnt
 FROM
    (SELECT b.pid, b.pnm, 1 cid, nvl(a.day, 0) day, nvl(a.cnt, 0) cnt
    FROM cycle a, product b
    WHERE a.pid(+) = b.pid
    AND a.cid(+) = 1) a, customer c
WHERE a.cid = c.cid;

SELECT b.pid, b.pnm, 1 cid, c.cnm, nvl(a.day, 0) day, nvl(a.cnt, 0) cnt
    FROM cycle a, product b, customer c
    WHERE a.pid(+) = b.pid
    AND a.cid(+) = 1
    AND 1 = c.cid;


--crossjoin1
SELECT cid, cnm, pid, pnm
FROM customer, product;



--subquery : main������ ���ϴ� �κ� ����
--���Ǵ� ��ġ : 
-- SELECT - scalar subquery (�ϳ��� ���, �ϳ��� �÷��� ��ȸ�Ǵ� �����̾�� �Ѵ�)
-- FROM - inline view 
-- WHERE - subquery

-- SCALAR subquery 
SELECT empno, ename, SYSDATE now/*���糯¥*/
FROM emp;

SELECT empno, ename, (SELECT SYSDATE FROM dual) now
FROM emp;


SELECT deptno   --20
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;


SELECT deptno   --20
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = (SELECT deptno   --20
                FROM emp
                WHERE ename = 'SMITH');
                

--sub1
SELECT AVG(sal)  --2073.21
FROM emp;

SELECT count(*)
FROM emp 
WHERE sal > (SELECT AVG(sal)  --2073.21
             FROM emp);
--sub2             
SELECT *
FROM emp 
WHERE sal > (SELECT AVG(sal) --2073.21
             FROM emp);             

--sub3
--SMITH, WARD�� �ٹ��ϴ� �μ� ��ȸ
SELECT deptno --20, 30
FROM emp
WHERE ENAME IN ('SMITH', 'WARD');

SELECT *
FROM emp
WHERE deptno IN (20, 30);

SELECT *
FROM emp
WHERE deptno IN(
            SELECT deptno
            FROM emp
            WHERE ENAME IN ('SMITH', 'WARD'));


