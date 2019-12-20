--hash join
SELECT *
FROM dept, emp
WHERE dept.deptno = emp.deptno;
-- dept ���� �д� ����
-- join �÷��� hash �Լ��� ������ �ش� �ؽ� �Լ��� �ش��ϴ� bucket�� �����͸� �ִ´�
-- 10 --> ccc1122 (hashvalue)

-- emp ���̺� ���� ���� ������ �����ϰ� ����
-- 10 -->  ccc1122 (hashvalue)






SELECT *
FROM dept, emp
WHERE emp.deptno BETWEEN dept.dpetno AND 99;
10 --> AAAAAA
20 --> AAAAAB


SELECT COUNT(*)
FROM emp;

-- �����ȣ, ����̸�, �μ���ȣ, �޿�, �μ����� ��ü �޿���
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal 
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --���� ó������ ���������
       
       --�ٷ� �������̶� ����������� �޿���
       SUM(sal) OVER (ORDER BY sal
       ROWS BETWEEN 1 PRECEDING AND CURRENT ROW ) c_sum2
FROM emp
ORDER BY sal;


--ROWS vs RANGE ���� Ȯ���ϱ�
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING ) row_sum,
       SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING ) range_sum,       
       SUM(sal) OVER (ORDER BY sal ) c_sum,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED FOLLOWING) range_sum
FROM emp;


-- PL/SQL
-- PL/SQL �⺻����
-- DECLARE : �����, ������ �����ϴ� �κ�
-- BEGIN : PL/SQL�� ������ ���� �κ�
-- EXCEPTION : ����ó����

-- DBMS_OUTPUT.PUT_LINE �Լ��� ����ϴ� ����� ȭ�鿡 �����ֵ��� Ȱ��ȭ
SET SERVEROUTPUT ON; 
DECLARE --�����
   -- java : Ÿ�� ������;
   -- pl/sql : ������ Ÿ��;
   v_dname VARCHAR2(14);
   v_loc VARCHAR2(13);
BEGIN
    --DEPT ���̺��� 10�� �μ��� �μ� �̸�, LOC ������ ��ȸ
    SELECT dname, loc 
    INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    
END;
/  --PL/SQL ����� ����
;

DESC dept;

