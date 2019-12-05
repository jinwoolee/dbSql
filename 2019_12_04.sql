--1.tax ���̺��� �̿� �õ�/�ñ����� �δ� �������� �Ű�� ���ϱ�
--2.�Ű���� ���� ������ ��ŷ �ο��ϱ�
--��ŷ(1) �õ�(2) �ñ���(3) �δ翬������Ű��(4)-�Ҽ��� ��°�ڸ����� �ݿø�
-- 1   ����Ư���� ���ʱ�  70.3
-- 2   ����Ư���� ������  68.2

SELECT ROWNUM rn, sido, sigungu, cal_sal
FROM 
(SELECT sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
 FROM tax
 ORDER BY cal_sal DESC);

SELECT *
FROM
(SELECT ROWNUM rn, sido, sigungu, ���ù�������
    FROM 
    (SELECT a.sido, a.sigungu, ROUND(a.cnt/b.cnt, 1) as ���ù�������
    FROM 
        (SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
        FROM fastfood
        WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
        GROUP BY sido, sigungu) a,
        
        (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
        FROM fastfood
        WHERE gb = '�Ե�����'
        GROUP BY sido, sigungu) b
    WHERE a.sido = b.sido
    AND a.sigungu = b.sigungu
    ORDER BY ���ù������� DESC)) a,
    
    (SELECT ROWNUM rn, sido, sigungu, cal_sal
     FROM 
    (SELECT sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
     FROM tax
     ORDER BY cal_sal DESC)) b
WHERE a.rn(+) = b.rn
ORDER BY b.rn;

-- ���ù������� �õ�, �ñ����� �������� ���Աݾ��� �õ�, �ñ�����
-- ���� �������� ����
-- ���ļ����� tax ���̺��� id �÷������� ����
--1	����Ư����	 ������ 5.6 ����Ư����	 ������ 70.3



SELECT a.rn, a.sido, a.sigungu, a.���ù�������,
       b.rn, b.sido, b.sigungu, b.cal_sal
FROM
(SELECT ROWNUM rn, sido, sigungu, ���ù�������
    FROM 
    (SELECT a.sido, a.sigungu, ROUND(a.cnt/b.cnt, 1) as ���ù�������
    FROM 
        (SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
        FROM fastfood
        WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
        GROUP BY sido, sigungu) a,
        
        (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
        FROM fastfood
        WHERE gb = '�Ե�����'
        GROUP BY sido, sigungu) b
    WHERE a.sido = b.sido
    AND a.sigungu = b.sigungu
    ORDER BY ���ù������� DESC)) a,
    
    (SELECT ROWNUM rn, id, sido, sigungu, cal_sal
     FROM 
    (SELECT id, sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
     FROM tax
     ORDER BY cal_sal DESC)) b
WHERE a.sido(+) = b.sido
AND a.sigungu(+) = b.sigungu
ORDER BY b.id;



--SMITH�� ���� �μ� ã�� --> 20
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp;
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');

SELECT empno, ename, deptno,
      (SELECT dname FROM dept WHERE dept.deptno= emp.deptno) dname
FROM emp;

--SCALAR SUBQUERY
--SELECT ���� ǥ���� ���� ����
--�� ��, �� COLUMN�� ��ȸ�ؾ� �Ѵ�
SELECT empno, ename, deptno,
      (SELECT dname FROM dept) dname
FROM emp;

--INLINE VIEW
--FROM���� ���Ǵ� ��������

--SUBQUERY
--WHERE�� ���Ǵ� ��������


--sub1 : ��� �޿����� ���� �޿��� �޴� ����� �Ǽ�
SELECT COUNT(*) cnt
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
             
--sub2 : ��� �޿����� ���� �޿��� �޴� ����� ����
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);             

--sub3
--1.SMITH, WARD�� ���� �μ� ��ȸ --> 20, 30
--2. 1���� ���� ������� �̿��Ͽ� �ش� �μ���ȣ(20, 30)�� ���ϴ� ���� ��ȸ
SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'WARD');

SELECT *
FROM emp
WHERE deptno IN (20, 30);

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                  FROM emp
                  WHERE ename IN ('SMITH', 'WARD'));

--SMITH Ȥ�� WARD ���� �޿��� ���� �޴� ������ȸ
SELECT *
FROM emp
WHERE sal <= ANY (SELECT sal  --800, 1250 --> 1250���� ���� ���
                 FROM emp 
                 WHERE ename IN('SMITH', 'WARD'));
                 
SELECT *
FROM emp
WHERE sal < ALL (SELECT sal  --800, 1250 --> 800���� ���� ���
                 FROM emp 
                 WHERE ename IN('SMITH', 'WARD'));                 


--������ ������ ���� �ʴ� ��� ���� ��ȸ

--�������� ���
SELECT *
FROM emp 
WHERE empno IN
            (SELECT mgr
             FROM emp);

--�����ڰ� �ƴ� ���
--NOT IN ������ ���� NULL�� �����Ϳ� �������� �ʾƾ� ������ �Ѵ�
SELECT *
FROM emp 
WHERE empno NOT IN
            (SELECT NVL(mgr, -1) --NULL ���� �������� �������� �����ͷ� ġȯ
             FROM emp);             

SELECT *
FROM emp 
WHERE empno NOT IN
            (SELECT mgr
             FROM emp
             WHERE mgr IS NOT null);             

--pairwise (���� �÷��� ���� ���ÿ� ���� �ؾ��ϴ� ���)
--ALLEN, CLARK�� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ��� ���� ��ȸ
-- (7698, 30)
-- (7839, 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN ( 7499, 7782 ));
                        
--�Ŵ����� 7698�̰ų� 7839 �̸鼭
--�ҼӺμ��� 10�� �̰ų� 30���� ���� ���� ��ȸ
-- 7698, 10
-- 7698, 30
-- 7839, 10
-- 7839, 30
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN ( 7499, 7782 ))
AND deptno IN (SELECT deptno
               FROM emp
               WHERE empno IN ( 7499, 7782 ));                                              

--���ȣ ���� ���� ����
--���������� �÷��� ������������ ������� �ʴ� ������ ���� ����

--���ȣ ���� ���������� ��� ������������ ����ϴ� ���̺�, �������� ��ȸ ������
--���������� ������������ �Ǵ��Ͽ� ������ �����Ѵ�
--���������� emp ���̺��� ���� �������� �ְ�, ���������� emp ���̺���
--���� ���� ���� �ִ�

--���ȣ ���� ������������ ���������� ���̺��� ���� ���� ���� 
--���������� ������ ������ �ߴ� ��� �� �������� ǥ��
--���ȣ ���� ������������ ���������� ���̺��� ���߿� ���� ���� 
--���������� Ȯ���� ������ �ߴ� ��� �� �������� ǥ��

--������ �޿� ��պ��� ���� �޿��� �޴� ���� ���� ��ȸ
--������ �޿� ���
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

--��ȣ���� ��������
--�ش������� ���� �μ��� �޿���պ��� ���� �޿��� �޴� ���� ��ȸ

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = m.deptno);
             
SELECT deptno, ROUND(AVG(sal), 2)
FROM emp             
GROUP BY deptno
ORDER BY deptno;

/*
10	2916.67 --KING
20	2175    --JONES, SCOTT, FORD
30	1566.67 --ALLEN, BLAKE
*/
SELECT empno, ename, deptno, sal
FROM emp;

--10�� �μ��� �޿����
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;








