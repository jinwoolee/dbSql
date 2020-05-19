SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job)

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY CUBE (deptno, job)

����׷� ���� ���
ROLLUP : �ڿ���(�����ʿ���) �ϳ��� �������鼭 ����׷��� ����
         ==> (deptno, job), (deptno), (��)
CUBE : ������ ��� ����
GROUPING SETS : �����ڰ� ����׷� ������ ���� ���


GROUP BY (deptno, job)
UNION ALL
GROUP BY (deptno)
UNION ALL
��ü....


sub_a1]
SELECT *
FROM dept_test;

sub_a2]
DROP TABLE dept_test;

SELECT *
FROM dept;

DELETE DEPT
WHERE deptno NOT IN (10, 20, 30, 40);

COMMIT;

CREATE TABLE dept_test AS
SELECT *
FROM dept;


SELECT *
FROM dept_test;


DELETE dept_test
WHERE NOT EXISTS ( SELECT 'X'
                   FROM emp
                   WHERE emp.deptno = dept_test.deptno);

SELECT *
FROM dept_test
WHERE NOT EXISTS ( SELECT 'X'
                   FROM emp
                   WHERE emp.deptno = dept_test.deptno);
               
SELECT *
FROM emp
WHERE deptno=40;

sub_a3]
SELECT *
FROM emp_test;

UPDATE emp_test SET sal = sal + 200
WHERE sal < (�ش� ������ ���� �μ��� �޿������ ���ϴ� SQL);

SELECT *
FROM emp_test;

UPDATE emp_test a SET sal = sal + 200
WHERE sal < (SELECT AVG(sal)
             FROM emp_test b
             WHERE 20 = b.deptno
             GROUP BY deptno);

SELECT *
FROM emp_test 
WHERE sal < (SELECT AVG(sal)
             FROM emp_test b
             WHERE 20 = b.deptno
             GROUP BY deptno);

���Ŀ��� �ƴ�����, �˻�-������ ���� ������ ǥ��
���������� ���� ���
1. Ȯ���� : ��ȣ���� �������� (EXISTS)
           ==> ���� ���� ���� ���� ==> ���� ���� ����
2. ������ : ���������� ���� ����Ǽ� ���������� ���� ���� ���ִ� ����

13�� : �Ŵ����� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IN (SELECT empno
                FROM emp);

SELECT *
FROM emp
WHERE mgr IN (7369, 7499, 7521....);

�μ��� �޿������ ��ü �޿���պ��� ū �μ��� �μ���ȣ, �μ��� �޿���� ���ϱ�

�μ��� ��� �޿� (�Ҽ��� ��° �ڸ����� ��� �����)
SELECT deptno, ROUND(AVG(sal), 2) 
FROM emp
GROUP BY deptno;

��ü �޿� ���
SELECT ROUND(AVG(sal), 2) 
FROM emp;

�Ϲ����� �������� ����
SELECT deptno, ROUND(AVG(sal), 2) 
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT ROUND(AVG(sal), 2) 
                             FROM emp);

WITH �� : SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ�
          SQL ����� �ѹ��� �޸𸮿� �ε��� �ϰ� �ݺ������� ����� �� �޸� ������ �����͸�
          Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD
          ��, �ϳ��� SQL���� �ݺ����� SQL ���� ������ ���� �߸� �ۼ��� SQL�� ���ɼ��� ���� ������
          �ٸ� ���·� ������ �� �ִ����� ���� �غ��� ���� ��õ.
          
WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal), 2) 
      FROM emp
)                            
SELECT deptno, ROUND(AVG(sal), 2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT *
                             FROM emp_avg_sal) ;                             
                             
WITH t AS
(
SELECT '��A' gb, '2020-05-01' dt, 2 cnt FROM dual
UNION ALL SELECT '��B', '2020-05-05', 3 FROM dual
UNION ALL SELECT '��C', '2020-05-07', 2 FROM dual
)
SELECT COUNT(DISTINCT TO_DATE(dt, 'yyyy-mm-dd') + lv - 1) dt_cnt
  FROM t
     , (SELECT LEVEL lv FROM dual CONNECT BY LEVEL <= 99)
 WHERE lv <= cnt
;

��������
CONNECT BY LEVEL : ���� �ݺ��ϰ� ���� ����ŭ ������ ���ִ� ���
��ġ : FROM(WHERE)�� ������ ���
DUAL ���̺�� ���� ���

���̺� ���� �Ѱ�, �޸𸮿��� ����
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����
5�� �̻��� �����ϴ� ���̺��� ���� ���� ����
���࿡ �츮�� ������ �����Ͱ� 10000���̸��� 10000�ǿ� ���� DISK I/O�� �߻�
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;


1. �츮���� �־��� ���ڿ� ��� : 202005
   �־��� ����� �ϼ��� ���Ͽ� �ϼ���ŭ ���� ���� ==> 31
   
�޷��� �÷��� 7�� - �÷��� ������ ���� : Ư�����ڴ� �ϳ��� ���Ͽ� ����   
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt, 7�� �÷��� �߰��� ����
       �Ͽ����̸� dt �÷�, �������̸� dt�÷�, ȭ�����̸� dt �÷�.....����� �̸� dt �÷�
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD');

�Ʒ� ������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ�
������ ���鿡�� �ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt, 
       DECODE( TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D'), '1', TO_DATE('202005', 'YYYYMM') + (LEVEL-1)) sun,
       DECODE( TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D'), '2', TO_DATE('202005', 'YYYYMM') + (LEVEL-1)) mon
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD');


�÷��� ����ȭ �Ͽ� ǥ��
TO_DATE('202005', 'YYYYMM') + (LEVEL-1) ==> dt

SELECT dt, dt�� �������̸� dt, dt�� ȭ�����̸� dt......7���� �÷��߿� �� �ϳ��� �÷����� dt ���� ǥ�� �ȴ�
FROM
(SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD'));


SELECT DECODE(d, 1, iw+1, iw),
           MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, 
           MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wed, 
           MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri,
           MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt, 
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') )
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);



SELECT Min(Decode(d, 1, dt)) SUN, Min(Decode(d, 2, dt)) MON, 
       Min(Decode(d, 3, dt)) TUE, Min(Decode(d, 4, dt)) WED, 
       Min(Decode(d, 5, dt)) THU, Min(Decode(d, 6, dt)) FRI, 
       Min(Decode(d, 7, dt)) SAT 
FROM   (SELECT To_date(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ) dt, 
               To_char(To_date(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ), 'd') d, 
               To_date(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ) -
               To_char( To_date(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ), 'd') + 1 f_sun 
        FROM   dual 
        CONNECT BY LEVEL <= To_char(Last_day(To_date(:YYYYMM, 'YYYYMM')), 'DD')) 
GROUP  BY f_sun 
ORDER  BY f_sun; 



create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT *
FROM sales;