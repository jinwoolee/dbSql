--member ���̺��� �̿��Ͽ� member2 ���̺��� ����
--member2 ���̺���
--������ ȸ��(mem_id='a001')�� ����(mem_job)�� '����'���� ������
--commit �ϰ� ��ȸ

CREATE TABLE member2 AS
SELECT *
FROM member;

UPDATE member2 SET mem_job = '����'
WHERE mem_id='a001';
COMMIT;

SELECT mem_id, mem_name, mem_job
FROM member2
WHERE mem_id='a001';













--��ǰ�� ��ǰ ���� ����(BUY_QTY)�հ�, ��ǰ ���� �ݾ�(BUY_COST) �հ�
--��ǰ�ڵ�, ��ǰ��, �����հ�, �ݾ��հ�

--VW_PROD_BUY(view ����)
CREATE OR REPLACE VIEW VW_PROD_BUY AS
SELECT buy_prod, b.prod_name, sum_qty, sum_cost
FROM 
(SELECT buy_prod, sum(buy_qty) sum_qty, sum(buy_cost) sum_cost
 FROM buyprod
 GROUP BY buy_prod) a, prod b
WHERE a.buy_prod = b.prod_id;

SELECT *
FROM USER_VIEWS;

--ana0
SELECT /*b.empno,*/ b.ename, b.sal, b.deptno, a.rn sal_rank
FROM
   (SELECT a.*, ROWNUM j_rn
   FROM 
    (SELECT a.deptno, b.rn
    FROM 
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) a,
    (SELECT ROWNUM RN
     FROM emp ) b
    WHERE a.cnt >= b.rn
    ORDER BY deptno, rn) a ) a,
    

(SELECT b.*, ROWNUM j_rn
FROM
    (SELECT empno, ename, deptno, sal
    FROM emp
    ORDER BY deptno, sal DESC) b )b
WHERE a.j_rn = b.j_rn;


SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT a.*, ROWNUM j_rn
 FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal desc) a )a,

(SELECT a.deptno, a.rn, ROWNUM j_rn
 FROM 
    (SELECT a.deptno, b.rn
    FROM
        (SELECT deptno, COUNT(*) cnt
         FROM emp
         GROUP BY deptno) a , 
         (SELECT ROWNUM rn
          FROM emp) b
    WHERE a.cnt >= b.rn
    ORDER BY deptno, rn ) a ) b
WHERE a.j_rn = b.j_rn;




    

--�μ��� ��ŷ
SELECT a.ename, a.sal, a.deptno, b.rn
FROM
    (SELECT a.ename, a.sal, a.deptno, ROWNUM j_rn
     FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC) a ) a, 
(SELECT b.rn, ROWNUM j_rn
FROM 
(SELECT a.deptno, b.rn 
 FROM
    (SELECT deptno, COUNT(*) cnt --3, 5, 6
     FROM emp
     GROUP BY deptno )a,
    (SELECT ROWNUM rn --1~14
     FROM emp) b
WHERE  a.cnt >= b.rn
ORDER BY a.deptno, b.rn ) b ) b
WHERE a.j_rn = b.j_rn;

SELECT ename, sal, deptno,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;





