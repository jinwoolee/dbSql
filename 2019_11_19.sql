--�������� ����
--����ŷ, �Ƶ�����, kfc ����
SELECT GB, SIDO, SIGUNGU
FROM fastfood
WHERE SIDO = '����������'
AND gb IN ('����ŷ', '�Ƶ�����', 'KFC')
ORDER BY SIDO, SIGUNGU, GB;

--�Ե�����
SELECT *
FROM fastfood
WHERE SIDO = '����������'
AND gb IN ('�Ե�����');



SELECT a.*, b.*
FROM 
    (SELECT a.*, ROWNUM RN 
     FROM
        (SELECT a.sido, a.sigungu, a.cnt kmb, b.cnt l,
               round(a.cnt/b.cnt, 2) point
        FROM 
            --140��
            (SELECT SIDO, SIGUNGU, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
            GROUP BY SIDO, SIGUNGU) a,
            
            --188��
            (SELECT SIDO, SIGUNGU, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('�Ե�����')
            GROUP BY SIDO, SIGUNGU) b
            WHERE a.sido = b.sido
            AND a.sigungu = b.sigungu
        ORDER BY point DESC )a ) a,
    
    (SELECT b.*, rownum rn
    FROM 
    (SELECT sido, sigungu
    FROM TAX
    ORDER BY sal DESC) b ) b
WHERE b.rn = a.rn(+)
ORDER BY b.rn;
 


SELECT SIDO, SIGUNGU, sal
FROM tax
ORDER BY sal desc;
--ORDER BY point desc;

-- �������� �õ�, �ñ���  | �������� �õ� �ñ��� 
--�õ�, �ñ���, ��������, �õ�, �ñ���, �������� ���Ծ�
--����� �߱� 5.7 ��⵵ ������ 18623591

SELECT a.empno, a.ename, a.rn , b.*
FROM    
    (SELECT a.*, rownum rn
    FROM
        (SELECT emp.*
        FROM emp
        ORDER BY empno desc) a ) a,

    (SELECT b.*, rownum rn
    FROM 
    (SELECT dept.*
    FROM dept
    ORDER BY deptno DESC) b ) b
WHERE a.rn = b.rn(+)
ORDER BY a.rn;



--emp_test ���̺� ����
DROP TABLE emp_test;

--multiple insert�� ���� �׽�Ʈ ���̺� ����
--empno, ename �ΰ��� �÷��� ���� emp_test, emp_test2 ���̺���
--emp ���̺�� ���� �����Ѵ� (CTAS)
--�����ʹ� �������� �ʴ´�

CREATE TABLE emp_test AS;
CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp
WHERE 1=2;

--INSERT ALL 
--�ϳ��� INSERT SQL �������� ���� ���̺� �����͸� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2

SELECT 1, 'brown' FROM dual 
UNION ALL
SELECT 2, 'sally' FROM dual;

--INSERT ������ Ȯ��
SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

--INSERT ALL �÷� ����
ROLLBACK;


INSERT INTO emp_test (empno) VALUES ('test');

INSERT ALL 
    INTO emp_test (empno) VALUES (empno)
    INTO emp_test2 VALUES (empno, ename)
SELECT 1 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

INSERT INTO emp_test (empno)
SELECT 1 empno FROM dual UNION ALL
SELECT 2 empno FROM dual;


SELECT 1 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;


SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;


--multiple insert (conditional insert)
ROLLBACK;
INSERT ALL 
    WHEN empno < 10 THEN
        INTO emp_test (empno) VALUES (empno)
    ELSE    --������ ������� ���� ���� ����
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual ;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;



--INSERT FIRST
--���ǿ� �����ϴ� ù��° INSERT ������ ����
ROLLBACK;

INSERT FIRST 
    WHEN empno > 10 THEN
        INTO emp_test (empno) VALUES (empno)
    WHEN empno > 5 THEN
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

ROLLBACK;
--MERGE : ���ǿ� �����ϴ� �����Ͱ� ������ UPDATE
--        ���ǿ� �����ϴ� �����Ͱ� ������ INSERT

--empno�� 7369�� �����͸� emp ���̺�� ���� emp_test���̺� ����(insert)
INSERT INTO emp_test 
SELECT empno, ename
FROM emp
WHERE EMPNO=7369;

SELECT *
FROM emp_test;

--emp���̺��� �������� emp_test ���̺��� empno�� ���� ���� ���� �����Ͱ� �������
-- emp_test.ename = ename || '_merge' ������ update
-- �����Ͱ� ���� ��쿡�� emp_test���̺� insert

ALTER TABLE emp_test MODIFY (ename VARCHAR2(20));

MERGE INTO emp_test 
USING (SELECT empno, ename
       FROM emp
       WHERE emp.empno IN (7369, 7499) ) emp
 ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename || '_merge'
WHEN NOT MATCHED THEN
    INSERT VALUES ( emp.empno, emp.ename);

SELECT *
FROM emp
WHERE emp.empno IN (7369, 7499)    ;

SELECT *
FROM emp_test;


--�ٸ� ���̺��� ������ �ʰ� ���̺� ��ü�� ������ ���� ������ 
--merge �ϴ� ���
ROLLBACK;

-- empno = 1, ename = 'brown'
-- empno�� ���� ���� ������ ename�� 'brown'���� update
-- empno�� ���� ���� ������ �ű� insert

SELECT *
FROM emp_test;

MERGE INTO emp_test
USING dual
 ON ( emp_test.empno = 1 )
WHEN MATCHED THEN 
    UPDATE set ename = 'brown' || '_merge'
WHEN NOT MATCHED THEN
    INSERT VALUES (1, 'brown');

SELECT 'X'
FROM emp_test
WHERE empno=1;

UPDATE emp_test set ename = 'brown' || '_merge'
WHERE empno=1;

INSERT INTO emp_test VALUES (1, 'brown');


--GROUP_AD1
SELECT deptno, sum(sal) sal
FROM emp
GROUP BY deptno

UNION ALL

--��� ������ �޿���
SELECT null, sum(sal) sal
FROM emp
ORDER BY deptno;

--�� ������ ROLLUP���·� ����
--GROUP BY deptno
--union all
--GROUP BY 
SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno);



--rollup
--group by �� ���� �׷��� ����
--GROUP BY ROLLUP( {col,})
--�÷��� �����ʿ������� �����ذ��鼭 ���� ����׷���
--GROUP BY �Ͽ� UNION �� �Ͱ� ����
--ex : GROUP BY ROLLUP (job, deptno)
--    GROUP BY job, deptno 
--    UNION
--    GROUP BY job
--    UNION
--    GROUP BY  --> �Ѱ� (��� �࿡ ���� �׷��Լ� ����)
SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);


--GROUPING SETS (col1, col2...)
--GROUPING SETS�� ������ �׸��� �ϳ��� ����׷����� GROUP BY ���� �̿�ȴ�

--GROUP BY col1
--UNION ALL
--GROUP BY col2


--emp ���̺��� �̿��Ͽ� �μ��� �޿��հ�, ������(job)�� �޿����� ���Ͻÿ�

--�μ���ȣ, job, �޿��հ�
SELECT deptno, null job, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, job, SUM(sal)
FROM emp
GROUP BY job;

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(deptno, job);


SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(deptno, job, (deptno, job));



