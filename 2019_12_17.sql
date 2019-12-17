-- WITH
-- WITH ����̸� AS (
--   ��������
-- )
-- SELECT *
-- FROM ����̸�

-- deptno, avg(sal) avg_sal
-- �ش� �μ��� �޿������ ��ü ������ �޿� ��պ��� ���� �μ��� ���� ��ȸ
SELECT deptno, avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT AVG(sal) FROM emp );

--WITH ���� ����Ͽ� ���� ������ �ۼ�
WITH dept_sal_avg AS(
     SELECT deptno, avg(sal) avg_sal
     FROM emp
     GROUP BY deptno),
     emp_sal_avg AS(
        SELECT AVG(sal) avg_sal FROM emp)
SELECT *
FROM dept_sal_avg
WHERE avg_sal > (SELECT avg_sal FROM emp_sal_avg);

WITH test AS(
    SELECT 1, 'TEST' FROM DUAL UNION ALL
    SELECT 2, 'TEST2' FROM DUAL UNION ALL
    SELECT 3, 'TEST3' FROM DUAL)
SELECT *
FROM test;


-- �������� 
-- �޷¸����
-- CONNECT BY LEVEL <= N
-- ���̺��� ROW �Ǽ��� N��ŭ �ݺ��Ѵ�
-- CONNECT BY LEVEL ���� ����� ���������� 
-- SELECT ������ LEVEL �̶�� Ư�� �÷��� ����� �� �ִ�
-- ������ ǥ���ϴ� Ư�� �÷����� 1���� �����ϸ� ROWNUM�� �����ϳ�
-- ���� ���Ե� START WITH , CONNECT BY ������ �ٸ� ���� ���� �ȴ�
    
-- 2019�� 11���� 30�ϱ��� ���� 
-- 201911
-- ���� + ���� = ������ŭ �̷��� ����
-- 201911 --> �ش����� ��¥�� ���� ���� ���� �ϴ°�??
-- 1-��, 2-��.....7-��
SELECT /*�Ͽ��ϸ� ��¥, ȭ�����̸� ��¥, ...������̸� ��¥*/
       /*dt, d,*/ /*dt -(d-1),*/
       MAX(DECODE(d, 1, dt)) s, MAX(DECODE(d, 2, dt)) m, MAX(DECODE(d, 3, dt)) t, 
       MAX(DECODE(d, 4, dt)) w, MAX(DECODE(d, 5, dt)) t, MAX(DECODE(d, 6, dt)) f, 
       MAX(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY dt -(d-1)
ORDER BY dt -(d-1);


SELECT /*�Ͽ��ϸ� ��¥, ȭ�����̸� ��¥, ...������̸� ��¥*/
       /*dt, d,*/ /*dt -(d-1),*/
       MAX(DECODE(d, 1, dt)) s, MAX(DECODE(d, 2, dt)) m, MAX(DECODE(d, 3, dt)) t, 
       MAX(DECODE(d, 4, dt)) w, MAX(DECODE(d, 5, dt)) t, MAX(DECODE(d, 6, dt)) f, 
       MAX(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY iw
ORDER BY sat;


SELECT /*�Ͽ��ϸ� ��¥, ȭ�����̸� ��¥, ...������̸� ��¥*/
       dt, d, iw, dt -(d-1),/*DEOCDE(d, 1, iw+1, iw) iw,*/
       DECODE(d, 1, dt) s, DECODE(d, 2, dt) m, DECODE(d, 3, dt) t, 
       DECODE(d, 4, dt) w, DECODE(d, 5, dt) t, DECODE(d, 6, dt) f, 
       DECODE(d, 7, dt) sat
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt, --20191130
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'));

--201911 --> 30
--201912 --> 31
--202402 --> 29
--201902 --> 28
SELECT TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') --30
FROM dual;






SELECT IW, MIN(DECODE(d, 1, dt)) SUN, MIN(DECODE(d, 2, dt)) MON, 
       MIN(DECODE(d, 3, dt)) TUE, MIN(DECODE(d, 4, dt)) WED, 
       MIN(DECODE(d, 5, dt)) THU, MIN(DECODE(d, 6, dt)) FRI, 
       MIN(DECODE(d, 7, dt)) SAT 
FROM   (SELECT TO_DATE(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ) dt, 
               TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ), 'd') d,
               --TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + ( LEVEL ), 'IW') IW,
               CASE WHEN TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + ( LEVEL ), 'IW') = 1 AND
                         TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ), 'MM') = '12'
                         THEN TO_CHAR(TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + ( LEVEL ), 'IW') + 55)
                    ELSE TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + ( LEVEL ), 'IW')
               END IW
        FROM   dual 
        CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD')) 
GROUP  BY IW 
ORDER  BY IW; 



SELECT /*1�� �÷�, 2�� �÷�,*/
      NVL(MIN(DECODE(mm, '01', sales_sum)), 0)JAN, NVL(MIN(DECODE(mm, '02', sales_sum)), 0) FEB,
      NVL(MIN(DECODE(mm, '03', sales_sum)), 0)MAR, NVL(MIN(DECODE(mm, '04', sales_sum)), 0) APR,
      NVL(MIN(DECODE(mm, '05', sales_sum)), 0)MAY, NVL(MIN(DECODE(mm, '06', sales_sum)), 0) JUN
FROM 
(SELECT TO_CHAR(dt, 'MM') mm, SUM(sales) sales_sum
 FROM sales
 GROUP BY TO_CHAR(dt, 'MM'));




SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd='dept0'   --�������� deptcd = 'dept0' --> XXȸ��(�ֻ�������)
CONNECT BY PRIOR deptcd = p_deptcd;
/*
    dept0(XXȸ��)
        dept0_00(�����κ�)
            dept0_00_0(��������)
        dept0_01(������ȹ��)
            dept0_01_0(��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02(�����ý��ۺ�)
            dept0_02_0(����1��)
            dept0_02_1(����2��)
            
