sub7;

SELECT customer.cnm, product.pid, product.pnm, c.day, c.cnt
FROM customer, product, cycle c
WHERE EXISTS (SELECT 'X'
             FROM cycle
             WHERE cid = 2 AND cycle.pid = c.pid)
AND c.cid = 1
AND c.cid = customer.cid
AND product.pid = c.pid; 

SELECT *
FROM cycle;


�����ÿ� �ִ� 5���� �� �ܹ�������
(kfc + ����ŷ + �Ƶ�����) / �Ե�����;

SELECT sido, count(*)
FROM fastfood
WHERE sido LIKE '%����%'
GROUP BY sido;

����(KFC, ����ŷ, �Ƶ�����)
����������	�߱�	7
����������	����	4
����������	����	17
����������	������	4
����������	�����	2;
SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '����������'
AND GB IN ('KFC', '����ŷ', '�Ƶ�����')
GROUP BY sido, sigungu;

������ �ñ����� �Ե�����
����������	�߱�	6
����������	����	8
����������	����	12
����������	������	8
����������	�����	7;
SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '����������'
AND GB IN ('�Ե�����')
GROUP BY sido, sigungu;

SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2, 2) hambuger_score
FROM
(SELECT sido, sigungu, COUNT(*) c1
 FROM fastfood
 WHERE /*sido = '����������'
 AND*/ GB IN ('KFC', '����ŷ', '�Ƶ�����')
 GROUP BY sido, sigungu) a,
 
 (SELECT sido, sigungu, COUNT(*) c2
 FROM fastfood
 WHERE /*sido = '����������'
 AND*/ GB IN ('�Ե�����')
 GROUP BY sido, sigungu) b
 WHERE a.sido = b.sido
 AND a.sigungu = b.sigungu
 ORDER BY hambuger_score DESC;
 

SELECT b.sido, b.sigungu, ROUND(((b.����ŷ /*+ m.������ġ*/ + d.�Ƶ����� + F.kfc) / l.�Ե�����),1) ��������
FROM (SELECT sido, sigungu, COUNT(sigungu) ����ŷ FROM fastfood WHERE GB = '����ŷ' GROUP BY sido, sigungu) b,
     (SELECT sido, sigungu, COUNT(sigungu) ������ġ FROM fastfood WHERE GB = '������ġ' GROUP BY sido, sigungu) m,
     (SELECT sido, sigungu, COUNT(sigungu) �Ƶ����� FROM fastfood WHERE GB = '�Ƶ�����' GROUP BY sido, sigungu) d,
     (SELECT sido, sigungu, COUNT(sigungu) �Ե����� FROM fastfood WHERE GB = '�Ե�����' GROUP BY sido, sigungu) l,
     (SELECT sido, sigungu, COUNT(sigungu) kfc FROM fastfood WHERE GB = 'KFC' GROUP BY sido, sigungu) F
WHERE (b.sido = m.sido AND b.sigungu(+) = m.sigungu) AND (m.sido = d.sido AND m.sigungu(+) = d.sigungu) AND (d.sido = l.sido AND d.sigungu(+) = l.sigungu) AND (F.sido = l.sido AND F.sigungu = l.sigungu) AND (F.sido = b.sido AND F.sigungu = b.sigungu)
ORDER BY �������� DESC;



--�õ�, �ñ���, ��������
SELECT up.sido,up.sigungu,ROUND(bmk/b,2) c , dense_rank() over(order by ROUND(bmk/b,2) desc) rank
FROM(
     
     
        (SELECT sido, sigungu,count(gb) bmk
         FROM fastfood
         WHERE gb IN ('����ŷ','�Ƶ�����','KFC')
         GROUP BY sido, sigungu) up
    
    JOIN
    
    (SELECT sido, sigungu,gb,count(gb) b
     FROM fastfood
     WHERE gb IN ('�Ե�����')
     GROUP BY sido, sigungu,gb )down
     
    ON(up.sido=down.sido and up.sigungu = down.sigungu))
ORDER BY c DESC;


fastfood ���̺��� �ѹ��� �д� ������� �ۼ��ϱ�;

SELECT sido, sigungu, ROUND((kfc + BURGERKING + mac) / lot, 2) burger_score
FROM 
(SELECT sido, sigungu, 
       NVL(SUM(DECODE(gb, 'KFC', 1)), 0) kfc, NVL(SUM(DECODE(gb, '����ŷ', 1)), 0) BURGERKING,
       NVL(SUM(DECODE(gb, '�Ƶ�����', 1)), 0) mac, NVL(SUM(DECODE(gb, '�Ե�����', 1)), 1) lot       
FROM fastfood
WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����', '�Ե�����')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC;


SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;

�ܹ��� ����, ���κ� �ٷμҵ� �ݾ� ������ ���� �õ����� [����]
����, ���κ� �ٷμҵ� �ݾ����� ������ ROWNUM�� ���� ������ �ο�
���� ������ �ೢ�� ����
�ܹ������� �õ�, �ܹ������� �ñ���, �ܹ�������, ���� �õ�, ���� �ñ���, ���κ� �ٷμҵ��
����Ư����	�߱�	5.67        ����Ư����	������	70
����Ư����	������	5       ����Ư����	���ʱ�	69
��⵵	������	5           ����Ư����	��걸	57
����Ư����	������	4.57    ��⵵	��õ��	54
����Ư����	���ʱ�	4       ����Ư����	���α�	47;


ROWNUM ���� ����
1. SELECT ==> ORDER BY 
   ���ĵ� ����� ROWNUM�� �����ϱ� ���ؼ��� INLINE-VIEW
2. 1������ ���������� ��ȸ�� �Ǵ� ���ǿ� ���ؼ��� WHERE ������ ����� ����
   ROWNUM = 1 (O)
   ROWNUM = 2 (X)
   ROWNUM < 10 (O)
   ROWNUM > 10 (X)

SELECT b.sido, b.sigungu, b.burger_score, a.sido, a.sigungu, a.pri_sal
FROM 
(SELECT ROWNUM rn, a.*
FROM 
(SELECT sido, sigungu, ROUND(sal/people) pri_sal
 FROM tax
 ORDER BY pri_sal DESC) a) a,

(SELECT ROWNUM rn, b.*
FROM
(SELECT sido, sigungu, ROUND((kfc + BURGERKING + mac) / lot, 2) burger_score
FROM 
(SELECT sido, sigungu, 
       NVL(SUM(DECODE(gb, 'KFC', 1)), 0) kfc, NVL(SUM(DECODE(gb, '����ŷ', 1)), 0) BURGERKING,
       NVL(SUM(DECODE(gb, '�Ƶ�����', 1)), 0) mac, NVL(SUM(DECODE(gb, '�Ե�����', 1)), 1) lot       
FROM fastfood
WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����', '�Ե�����')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC) b ) b
WHERE a.rn = b.rn;


DESC emp;


DML
INSERT INTO dept (deptno, dname, loc) VALUES (99,'DDIT','daejeon');
INSERT INTO dept (dname, deptno, loc) VALUES ('DDIT', 99, 'daejeon');

DESC dept;

empno �÷��� NOT NULL ���� ������ �ִ� - INSERT �� �ݵ�� ���� �����ؾ� ���������� �Էµȴ�
empno �÷��� ������ ������ �÷��� NULLABLE �̴� (NULL ���� ����� �� �ִ�);
INSERT INTO emp (empno, ename, job) 
VALUES ( 9999, 'brown', NULL);

SELECT *
FROM emp;

INSERT INTO emp (ename, job) 
VALUES ('sally', 'SALESMAN');

���ڿ� : '���ڿ�' ==> "���ڿ�"
���� : 10
��¥ : TO_DATE('20200206', 'YYYYMMDD'), SYSDATE ;

emp ���̺��� hiredate �÷��� date Ÿ��
emp ���̺��� 8���� �÷��� ���� �Է�;
DESC emp ;

INSERT INTO emp VALUES (9998, 'sally', 'SALEMSAN', NULL, SYSDATE, 1000, NULL, 99);
ROLLBACK;


�������� �����͸� �ѹ��� INSERT :
INSERT INTO ���̺�� (�÷���1, �÷���2....)
SELECT ...
FROM ;

INSERT INTO emp
SELECT 9998, 'sally', 'SALEMSAN', NULL, SYSDATE, 1000, NULL, 99
FROM dual
    UNION ALL
SELECT 9999, 'brown', 'CLERK', NULL, TO_DATE('20200205', 'YYYYMMDD'), 1100, NULL, 99
FROM dual;

SELECT *
FROM emp;


WITH emp(empno) AS ;
 
SELECT SUBSTR(MIN(CASE WHEN SUBSTR(empno, 1, 2) BETWEEN '00' AND TO_CHAR(SYSDATE, 'YY') THEN 1 ELSE 0 END || empno), -6) AS empno
FROM (
    SELECT '090024' empno FROM dual UNION ALL
    SELECT '980034' FROM dual UNION ALL
    SELECT '150039' FROM dual UNION ALL
    SELECT '890042' FROM dual );


UPDATE ����
UPDATE ���̺�� �÷���1 = ������ �÷� ��1, �÷���2 = ������ �÷� ��2,....
WHERE �� ���� ����
������Ʈ ���� �ۼ��� WHERE ���� �������� ������ �ش� ���̺���
��� ���� ������� ������Ʈ�� �Ͼ��
UPDATE, DELETE ���� WHERE���� ������ �ǵ��Ѱ� �´��� �ٽ��ѹ� Ȯ���Ѵ�

WHERE���� �ִٰ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT �ϴ� ������ �ۼ��Ͽ� �����ϸ�
UPDATE ��� ���� ��ȸ �Ҽ� �����Ƿ� Ȯ�� �ϰ� �����ϴ� �͵� ��� �߻� ������ ������ �ȴ�;

99�� �μ���ȣ�� ���� �μ� ������ DEPT���̺� �ִ»�Ȳ
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

SELECT *
FROM dept;


99�� �μ���ȣ�� ���� �μ��� dname �÷��� ���� '���IT', loc �÷��� ���� '���κ���'���� ������Ʈ;

UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;

ROLLBACK;

�Ǽ��� WHERE���� ������� �ʾ��� ���;
UPDATE dept SET dname = '���IT', loc = '���κ���'
/*WHERE deptno = 99*/ ;

�����-�ý��� ��ȣ�� �ؾ���� ==> �Ѵ޿� �ѹ��� ��� ������� �������
                               ���� �ֹι�ȣ ���ڸ��� ��й�ȣ�� ������Ʈ
�ý��� ����� : �����(12,000), ������(550), ����(1,300)
UPDATE ����� SET ��й�ȣ = �ֹι�ȣ���ڸ�
WHERE ����ڱ��� = '�����';
COMMIT;

�����͸� �����ϴ� ���α׷�;

10 ==> SUBQUERY ;
SMITH, WARD�� ���� �μ��� �Ҽӵ� ���� ����;
SELECT *
FROM emp
WHERE deptno IN (20, 30);

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno 
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));

UPDATE�ÿ��� ���� ���� ����� ����;
INSERT INTO emp (empno, ename) VALUES ( 9999, 'brown');
9999�� ��� deptno, job ������ SMITH ����� ���� �μ�����, �������� ������Ʈ;

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp;

ROLLBACK;



DELETE SQL  : Ư�� ���� ����

DELETE [FROM] ���̺��
WHERE �� ���� ����;

SELECT *
FROM dept;

99�� �μ���ȣ�� �ش��ϴ� �μ� ���� ����;
DELETE dept 
WHERE deptno = 99;
COMMIT;

SUBQUERY�� ���ؼ� Ư�� ���� �����ϴ� ������ ���� DELETE 
�Ŵ����� 7698 ����� ������ ���� �ϴ� ������ �ۼ�;
DELETE emp
WHERE empno IN ( 7499, 7521, 7654, 7844, 7900 );

DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
ROLLBACK;




