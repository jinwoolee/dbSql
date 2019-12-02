SELECT employees.manager_id mgr_id, 
       manager.employee_id mgr_id2,
       manager.first_name || manager.last_name mgr_name,
       employees.employee_id,
       employees.first_name || employees.last_name name,
       
       jobs.job_id, jobs.job_title
FROM jobs, employees, employees manager
WHERE jobs.job_id = employees.job_id;

--OUTER join : ���� ���ῡ ���� �ϴ��� ������ �Ǵ� ���̺��� �����ʹ� 
--�������� �ϴ� join
--LEFT OUTER JOIN : ���̺�1 LEFT OUTER JOIN ���̺�2
-- ���̺�1�� ���̺�2�� �����Ҷ� ���ο� �����ϴ��� ���̺�1���� �����ʹ�
-- ��ȸ�� �ǵ��� �Ѵ�
-- ���ο� ������ �࿡�� ���̺�2�� �÷����� �������� �����Ƿ� NULL�� ǥ�� �ȴ�

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno );


SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m
           ON (e.mgr = m.empno );


--
SELECT e.empno, e.ename, e.deptno, m.empno, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno AND m.deptno=10);

SELECT e.empno, e.ename, e.deptno, m.empno, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno)
WHERE m.deptno=10;

--ORACLE outer join syntax
--�Ϲ����ΰ� �������� �÷��� (+)ǥ��
--(+)ǥ�� : �����Ͱ� �������� �ʴµ� ���;� �ϴ� ���̺��� �÷�
-- ���� LEFT OUTER JOIN �Ŵ���
--    ON(����.�Ŵ�����ȣ = �Ŵ���.������ȣ)

-- ORACLE OUTER
--WHERE ����.�Ŵ�����ȣ = �Ŵ���.������ȣ(+) --�Ŵ����� �����Ͱ� �������� ����

--ansi outer
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno );
           
--oracle outer           
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--�Ŵ��� �μ���ȣ ����
--ANSI SQL WHERE ���� ����� ����
-- --> OUJTER ������ ������� ���� ��Ȳ
--**�ƿ��� ������ ����Ǿ�� ���̺��� ��� �÷��� (+)�� �پ�� �ȴ�
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

--ansi sql�� on���� ����� ���� ����
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--���﹮��
--emp ���̺��� 14���� ������ �ְ� 14���� 10, 20, 30�μ��߿� �� �μ���
-- ���Ѵ�
--������ dept���̺��� 10, 20, 30, 40�� �μ��� ����

--�μ���ȣ, �μ���, �ش�μ��� ���� �������� �������� ������ �ۼ�
/*
10	ACCOUNTING   3
20	RESEARCH     5
30	SALES        6
40	OPERATIONS   0

10	3
20	5
30	6
*/ 
-- dept : deptno, dname 
-- inline : deptno, cnt(������ ��)
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM 
dept, 
(SELECT deptno, COUNT(*) cnt
 FROM emp 
 GROUP BY deptno) emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);


--ANSI
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM 
dept LEFT OUTER JOIN (SELECT deptno, COUNT(*) cnt
                      FROM emp 
                      GROUP BY deptno) emp_cnt
                ON(dept.deptno = emp_cnt.deptno);
--
SELECT dept.deptno, dept.dname, count(emp.deptno) cnt
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno
GROUP BY dept.deptno, dept.dname;


SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m
           ON (e.mgr = m.empno );
                   
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m
           ON (e.mgr = m.empno );

--FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ������� �ѰǸ� �����
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m
           ON (e.mgr = m.empno );           
           
--outerjoin1
SELECT buyprod.buy_date, buyprod.buy_prod,
       prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE('20050125', 'YYYYMMDD')
AND prod.prod_id = buyprod.buy_prod(+);

SELECT buyprod.buy_date, buyprod.buy_prod,
       prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod RIGHT OUTER JOIN prod
 ON (buyprod.buy_date = TO_DATE('20050125', 'YYYYMMDD')
     AND prod.prod_id = buyprod.buy_prod);

           
           
           
           
           