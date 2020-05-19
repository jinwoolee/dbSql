REPORT GROUP FUNCTION ==> Ȯ��� GROUP BY
REPORT GROUP FUNCTION�� ����� ���ϸ�
�������� SQL�ۼ�, UNION ALL�� ���ؼ� �ϳ��� ����� ��ġ�� ����

==> ���� ���ϰ� �ϴ°� REPORT GROUP FUNCTION




GROUP_AD4]

SELECT dept.dname, emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);

SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
 FROM emp
 GROUP BY ROLLUP (deptno, job)) a, dept
WHERE a.deptno = dept.deptno(+) ;

GROUP_AD5]
SELECT NVL(dept.dname, '�Ѱ�') dname, emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno

GROUP BY ROLLUP (dept.dname, emp.job);
GROUP BY GROUPING SETS (dept.dname, emp.job);


2. GROUPING SETS
ROLLUP�� ���� : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�
               ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
               ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP���� �ٸ��� ���⼺�� ����
  
���� : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col2, col1)
GROUP BY col2
UNION ALL
GROUP BY col1


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY job

UNION ALL

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY deptno;


�׷������ 
1. job, dpetno
2. mgr

GROUP BY GROUPING SETS ( (job, deptno), mgr, job, (mgr, job) )

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ( (job, deptno), mgr );

SELECT job, deptno, NULL, SUM(sal)
FROM emp
GROUP BY job, deptno

UNION ALL

SELECT NULL, NULL, mgr, SUM(sal)
FROM emp
GROUP BY   mgr;



3. CUBE 
���� : GROUP BY CUBE (co11, col2...)
����� �÷��� ������ ��� ���� (������ ��Ų��)

GROUP BY CUBE (job, deptno);
  1      2
job    deptno
job     x
 X     deptno
 X      X
 
 GROUP BY CUBE (job, deptno, mgr);
  1      2         3
job    deptno     mgr
job    deptno     X
job    X          mgr
job    X          X
X    deptno     mgr
X    deptno     X
X    X          mgr
X    X          X

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
1       2        3
job    deptno    mgr ==> GROUP BY job, deptno, mgr
job    X         mgr ==> GROUP BY job, mgr
job    deptno     x  ==> GROUP BY job, deptno
job    X          x  ==> GROUP BY job


GROUP BY job, ROLLUP(job, deptno), CUBE(mgr)

1         2               3
job     job, deptno     mgr   ==> GROUP BY job, job, dpetno, mgr ==> GROUP BY job, dpetno, mgr
job     job             mgr   ==> GROUP BY job, job, mgr ==> GROUP BY job, mgr
job     x               mgr   ==> GROUP BY job, x, mgr  ==> GROUP BY job, mgr
job     job, deptno     x     ==> GROUP BY job, deptno, x ==> GROUP BY job, deptno
job     job             x     ==> GROUP BY job, job, x ==> GROUP BY job
job     x               x     ==> GROUP BY job, x, x ==> GROUP BY job

SELECT 5%2
FROM dual;

SELECT CASE 
        WHEN GROUPING(job)=1 && GROUPING(deptno)=1 THEN 'TEST'
       END


��ȣ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ� emp_test ���̺� ����
    ==> ������ ������ emp_test ���̺� ���� ���� ����
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;
    
2. emp_test ���̺� dname�÷� �߰�(dept ���̺� ����)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;


3. subquery�� �̿��Ͽ� emp_test ���̺� �߰��� danme �÷��� ������Ʈ ���ִ� ���� �ۼ�
emp_test�� dname �÷��� ���� dept ���̺��� dname �÷����� update
emp_test���̺��� deptno���� Ȯ���ؼ� dept���̺��� deptno���̶� ��ġ�ϴ� dname �÷����� ������ update

SELECT *
FROM emp_test;

emp_test���̺��� dname �÷��� dept ���̺��̿��ؼ� dname�� ��ȸ�Ͽ� ������Ʈ
update ����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����

��������� ������� dname �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);
                             
SELECT dname
 FROM dept
 WHERE 30 = dept.deptno
 
 
 
 
sub_a1]
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE emp.deptno = dept_test.deptno
                               GROUP BY deptno);

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE emp.deptno = dept_test.deptno);
                               
SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;

SELECT *
FROM dept_test;









