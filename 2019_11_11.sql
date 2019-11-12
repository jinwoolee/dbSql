--SMITH, WARD �� ���ϴ� �μ��� ������ ��ȸ
SELECT *
FROM emp
WHERE deptno IN (20, 30);

SELECT *
FROM emp
WHERE deptno = 20
  OR  deptno = 30;

SELECT *
FROM emp
WHERE deptno in (SELECT deptno 
                 FROM emp
                 WHERE ename IN  (:name1, :name2) );
                 
-- ANY : set�߿� �����ϴ°� �ϳ��� ������ ������(ũ���)
-- SMITH, WARD �λ���� �޿����� ���� �޿��� �޴� ���� ���� ��ȸ
SELECT ename, sal
FROM emp
ORDER BY sal;

SELECT *
FROM emp
WHERE sal < any(SELECT sal --800, 1250 --> 1250���� ���� �޿��� �޴»��
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

--SMITH�� WARD���� �޿��� ���� ���� ��ȸ
--SMITH���ٵ� �޿��� ���� WARD���ٵ� �޿��� �������(AND)
SELECT *
FROM emp
WHERE sal > all(SELECT sal --800, 1250 --> 1250���ٸ� ���� �޿��� �޴»��
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

--NOT IN

--�������� ��������
--1.�������� ����� ��ȸ
--  . mgr �÷��� ���� ������ ����
SELECT mgr
FROM emp;

--� ������ ������ ������ �ϴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE empno IN (7839,7782,7698,7902,7566,7788);

SELECT *
FROM emp
WHERE empno IN (SELECT mgr
                FROM emp);

--������ ������ ���� �ʴ� �� ��� ���� ��ȸ
--�� NOT IN������ ���� SET�� NULL�� ���Ե� ��� ���������� �������� �ʴ´�
--NULLó�� �Լ��� WHERE���� ���� NULL���� ó���� ���� ���
SELECT *
FROM emp      --7839,7782,7698,7902,7566,7788 ����6���� ����� ���Ե��� �ʴ� ����        
WHERE empno NOT IN (SELECT NVL(mgr, -9999)
                    FROM emp);                

--pair wise
--��� 7499, 7782�� ������ ������, �μ���ȣ ��ȸ
--7698	30
--7839	10
--�����߿� �����ڿ� �μ���ȣ�� (7698, 30) �̰ų�, (7839, 10)�� ���
--mgr, deptno �÷��� [����]�� ���� ��Ű�� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));
--7698	30
--7839	10
--(7698, 30), (7698, 10), (7839, 30), (7839  10)
--(7698, 30), (7839  10)
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499, 7782))
AND deptno IN (SELECT deptno
              FROM emp
              WHERE empno IN (7499, 7782));


--SCALAR SUBQUERY :SELECT ���� �����ϴ� ���� ����(�� ���� �ϳ��� ��, �ϳ��� �÷�)
--������ �Ҽ� �μ����� JOIN�� ������� �ʰ� ��ȸ
SELECT empno, ename, deptno, (SELECT dname
                              FROM dept
                              WHERE deptno = emp.deptno) dname
FROM emp;

SELECT dname
FROM dept
WHERE deptno = 20;


--sub4 ������ ����
SELECT *
FROM dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

SELECT *
FROM DEPT
where deptno NOT IN (SELECT DEPTNO FROM emp);

SELECT *
FROM emp
ORDER BY DEPTNO;

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);


--sub5
SELECT *
FROM product
WHERE pid NOT IN (SELECT pid FROM cycle WHERE cid=1);


--cycle, product ���̺��� �̿��Ͽ� cid=1�� ���� �������� �ʴ� ��ǰ�� ��ȸ
1. cid=1�� ���� �����ϴ� ��ǰ�ڵ�(pid);

SELECT pid  --100, 400
FROM cycle
WHERE cid=1;

SELECT *
FROM product
WHERE pid NOT IN (SELECT pid  --100, 400
                    FROM cycle
                    WHERE cid=1);

--sub6
SELECT *
FROM cycle
WHERE cid=1
  AND pid IN (SELECT pid
              FROM cycle
              WHERE cid=2);


SELECT *        --100, 200
FROM cycle
WHERE cid = 2;

SELECT *        --100, 400
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid FROM cycle WHERE cid=2);  --2�� ���� �Դ� ��ǰ

--EXISTS MAIN������ �÷��� ����ؼ� SUBQUERY�� �����ϴ� ������ �ִ��� üũ 
--�����ϴ� ���� �ϳ��� �����ϸ� ���̻� �������� �ʰ� ���߱� ������
--���ɸ鿡�� ����

--MGR�� �����ϴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'X'
              FROM emp 
              WHERE empno = a.mgr);

--MGR�� �������� �ʴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE NOT EXISTS (SELECT 'X'
                  FROM emp 
                  WHERE empno = a.mgr);

--sub8
SELECT *
FROM emp
WHERE mgr IS NOT NULL;


--�μ��� �Ҽӵ� ������ �ִ� �μ� ���� ��ȸ(EXISTS)
SELECT *
FROM emp
ORDER BY deptno, empno;

SELECT *
FROM dept
WHERE EXISTS (SELECT 'X'
              FROM emp 
              WHERE deptno = dept.deptno);

--IN              
SELECT *
FROM dept
WHERE deptno in (SELECT deptno
                 FROM emp );

--���տ���
--UNION : ������, �ߺ��� ����
--        DBMS������ �ߺ��� �����ϱ����� �����͸� ����
--        (�뷮�� �����Ϳ� ���� ���Ľ� ����)
--UNION ALL : UNION�� ��������
--            �ߺ��� �������� �ʰ�, �� �Ʒ� ������ ���� => �ߺ�����
--            ���Ʒ� ���տ� �ߺ��Ǵ� �����Ͱ� ���ٴ� ���� Ȯ���ϸ�
--            UNION �����ں��� ���ɸ鿡�� ����
--����� 7566 �Ǵ� 7698�� ��� ��ȸ (���, �̸�)

SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

UNION 
--����� 7369, 7499�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno = 7698;
--WHERE empno =7369 OR empno=7499;


--UNION ALL(�ߺ� ���, �� �Ʒ� ������ ��ġ�⸸ �Ѵ�)
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

UNION ALL
--����� 7369, 7499�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno = 7698;
--WHERE empno =7369 OR empno=7499;



--INTERSECT(������ :�� �Ʒ� ���հ� ���� ������)
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369) 

INTERSECT

SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7499);


--MINUS(������ :�� ���տ��� �Ʒ� ������ ����)
--������ ����
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369) 

MINUS

SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7499);

SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7499)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369) ;


SELECT 1 n, 'x' m
FROM dual


union 

SELECT 2, 'y'
FROM dual;


SELECT *
FROM USER_CONSTRAINTS
WHERE OWNER = 'SEM'
AND TABLE_NAME IN ('PROD', 'LPROD')
AND CONSTRAINT_TYPE IN ('P', 'R');


