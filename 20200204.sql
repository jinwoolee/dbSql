join6;
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, SUM(cycle.cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;

join7;
SELECT cycle.pid, product.pnm, SUM(cycle.cnt)
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm
ORDER BY cycle.pid, product.pnm;



JOIN10;
SELECT *
FROM countries;

SELECT *
FROM regions;

SELECT *
FROM locations;

SELECT *
FROM departments;

JOIN10;
SELECT r.region_id,r.region_name,c.country_name,l.city,d.department_name
FROM countries c, regions r, locations l, departments d
WHERE r.region_id=1 AND r.region_id = c.region_id AND c.country_id = l.country_id 
 AND d.location_id = l.location_id;
 
JOIN13;
SELECT e.manager_id MGR_ID, CONCAT(m.first_name, m.last_name) MGR_NAME,
       e.employee_id, CONCAT(e.first_name, e.last_name) NAME,
       j.job_id, j.job_title
FROM employees e, jobs j, employees m
WHERE e.job_id = j.job_id
AND e.manager_id IS NOT NUll;

SELECT *
FROM employees;

select COUNT(*) from EMPLOYEES;


CROSS JOIN == > īƼ�� ���δ�Ʈ(Cartesian product)
�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ���
������ ��� ���տ� ���� ����(����)�� �õ�
dept(4��), emp(14)�� CROSS JOIN�� ����� 4*14 = 56��


dept ���̺�� emp ���̺��� ������ �ϱ� ���� FROM ���� �ΰ��� ���̺��� ���
WHERE���� �� ���̺��� ���� ������ ����;

SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp
WHERE dept.deptno=10
AND dept.deptno = emp.deptno;

crossjoin1;
SELECT *
FROM customer, product;


SUBQUERY : �����ȿ� �ٸ� ������ �� �ִ� ���
SUBQUERY�� ���� ��ġ�� ���� 3������ �з�
SELECT �� : SCALAR SUBQUERY  : �ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� ����
FROM �� : INLINE - VIEW (VIEW)
WHERE �� : SUBQUERY QUERY




���ϰ��� �ϴ� ��
SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ
1.SMITH�� ���ϴ� �μ� ��ȣ�� ���Ѵ�
2. 1������ ���� �μ� ��ȣ�� ���ϴ� ������ ������ ��ȸ�Ѵ�;

1.;
SELECT deptno
FROM emp 
WHERE ename = 'SMITH';

2. 1������ ���� �μ���ȣ��  �̿��Ͽ� �ش� �μ��� ���ϴ� ���� ������ ��ȸ;
SELECT *
FROM emp
WHERE deptno = 20;

SUBQUERY��  �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ ����;
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp 
                WHERE ename = 'SMITH');
                
SUB1 : ��� �޿����� ���� �޿��� �޴� ������ ��
1. ��� �޿� ���ϱ�
2. ���� ��� �޿����� ���� �޿��� �޴»��;

1.;
SELECT AVG(sal)
FROM emp;

2. ;
SELECT *
FROM emp
WHERE sal > 2073;

3.;
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

sub2;
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
             
������ ������
IN : ���������� �������� ��ġ�ϴ� ���� ���� �� �� 
ANY [Ȱ�뵵�� �ټ� ������] : ���������� �������� �� ���̶� ������ ������ ��
ALL [Ȱ�뵵�� �ټ� ������] : ���������� ���������� ��� �࿡ ���� ������ ������ ��;

SUB3
SMITH�� ���ϴ� �μ��� ��� ������ ��ȸ
SMITH�� WARD ������ ���ϴ� �μ��� ��� ������ ��ȸ;
SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'WARD');

SELECT *
FROM emp
WHERE deptno IN (20, 30);

���������� ����� ���� ���� ���� = �����ڸ� ������� �� �Ѵ�
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));

SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ(SMITH, WARD�� �޿��� �ƹ��ų�)
SMITH : 800
WARD : 1250
 ==> 1250���� ���� ���;
 
SELECT *
FROM emp
WHERE sal < ANY (800, 1250);


SELECT sal
FROM emp
WHERE ename IN ('SMITH', 'WARD');

SELECT *
FROM emp
WHERE sal < ANY (SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));

SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ(SMITH, WARD�� �޿� 2���� ��ο� ���� ���� ��)
SMITH : 800
WARD : 1250
==> 1250���� �޿��� ���� ���;

SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));

IN, NOT IN�� NULL�� ���õ� ���� ����;

������ ������ ����� 7902 �̰ų�(OR) NULL;
IN �����ڴ� OR �����ڷ� ġȯ ����
SELECT *
FROM emp
WHERE mgr IN (7902, null);

NULL�񱳴� = �����ڰ� �ƴ϶� IS NULL�� �� �ؾ������� IN�����ڴ� =�� ����Ѵ�;
SELECT *
FROM emp
WHERE mgr = 7902
OR mgr = null;

empno NOT IN (7902, NULL) ==> AND
��� ��ȣ�� 7902�� �ƴϸ鼭(AND) NULL�� �ƴѵ�����
SELECT *
FROM emp
WHERE empno NOT IN (7902, NULL);

SELECT *
FROM emp
WHERE empno != 7902
AND empno != NULL;

SELECT *
FROM emp
WHERE empno != 7902
AND empno IS NOT NULL;


pairwise (������)
�������� ����� ���ÿ� ���� ��ų��;
(mgr, deptno)
(7698, 30), (7839, 10);
SELECT *
FROM emp
WHERE (mgr, deptno) IN  (SELECT mgr, deptno
                         FROM emp
                         WHERE empno IN (7499, 7782));

non-pairwise�� �������� ���ÿ� ������Ű�� �ʴ� ���·� �ۼ�
mgr ���� 7698�̰ų� 7839  �̸鼭
deptno�� 10�̰ų� 30���� ����
MGR, DEPTO
(7698, 10), (7698, 30)
(7839, 10), (7839, 30);  
SELECT *
FROM emp
WHERE mgr IN  (SELECT mgr
               FROM emp
               WHERE empno IN (7499, 7782))
AND  deptno IN  (SELECT deptno
                 FROM emp
                 WHERE empno IN (7499, 7782));
                 
��Į�� �������� : SELECT ���� ���, 1���� ROW, 1���� COL�� ��ȸ�ϴ� ����
��Į�� ���������� MAIN ������ �÷��� ����ϴ°� �����ϴ�;                         

SELECT (SELECT SYSDATE FROM dual),
        dept.*
FROM dept;
                         
SELECT empno, ename, deptno,
       (SELECT dname
        FROM dept
        WHERE deptno = emp.deptno ) dname
FROM emp;
                         
INLINE VIEW : FROM ���� ����Ǵ� ��������;

MAIN ������ �÷��� SUBQUERY ���� ��� �ϴ��� ������ �����з�
��� �Ұ�� : correlated subqueury(��ȣ ���� ����), ���������� �ܵ����� ���� �ϴ°� �Ұ���
            ��������� �������ִ� (main ==> sub)
������� ������� : non-correlated subquery(���ȣ ���� ��������), ���������� �ܵ����� �����ϴ°� ����
                  ��������� ������ ���� �ʴ�( main ==> sub, sub ==> main)

��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ;
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ;
SELECT AVG(sal)
FROM emp
WHERE deptno=30;

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
             FROM emp s
             WHERE s.deptno = m.deptno);
             
���� ������ ������ �̿��ؼ� Ǯ���
1. ���� ���̺� ����
   emp, �μ��� �޿� ���(inline view)
   
SELECT emp.* --emp.ename, sal, emp.deptno, dept_sal.*
FROM emp, (SELECT deptno, ROUND(AVG(sal)) avg_sal
           FROM emp 
           GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno           
AND emp.sal > dept_sal.avg_sal;


sub4;
������ �߰�;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

DELETE dept
WHERE deptno = 99;

SELECT *
FROM dept;

ROLLBACK; Ʈ����� ���
COMMIT;   Ʈ����� Ȯ��










