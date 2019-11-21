--��ü ������ �޿���� 2073.21
SELECT ROUND(AVG(sal), 2)
FROM emp;

--�μ��� ������ �޿� ��� 10 XXXX, 20 YYYY, 30 ZZZZ
SELECT *
FROM 
    (SELECT deptno, ROUND(AVG(sal), 2) d_avgsal
    FROM emp
    GROUP BY deptno)
WHERE d_avgsal > (SELECT ROUND(AVG(sal), 2)
                  FROM emp);

SELECT *
FROM 
    (SELECT deptno, ROUND(AVG(sal), 2) d_avgsal
    FROM emp
    GROUP BY deptno)
WHERE d_avgsal > (2073.21);

--���� ���� WITH���� �����Ͽ�
--������ �����ϰ� ǥ���Ѵ�
WITH dept_avg_sal AS(
    SELECT deptno, ROUND(AVG(sal), 2) d_avgsal
    FROM emp
    GROUP BY deptno)
    
SELECT *
FROM dept_avg_sal
WHERE d_avgsal > (SELECT ROUND(AVG(sal), 2)
                  FROM emp);

--�޷� ����� 
--STEP1. �ش� ����� ���� �����
--CONNECT BY LEVEL

--201911
--DATE + ���� = ���� ���ϱ� ����
--ORIGINAL
SELECT d_sun_iw, MAX(DECODE(d, 1, dt)) sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
       MAX(DECODE(d, 4, dt)) wed, MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (level-1) dt,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'iw') iw,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd') d,
           
           TO_DATE(:YYYYMM, 'YYYYMM') + (level-1)-
           (TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd')-1) d_sun,--�ش� ������,
           
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1)-
                   (TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd')-1), 'iw') d_sun_iw
    FROM dual a
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD') ) a
GROUP BY a.d_sun_iw
ORDER BY a.d_sun_iw;


--������ ��� ��¥ ǥ���ϱ�
SELECT MAX(DECODE(d, 1, dt)) sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
       MAX(DECODE(d, 4, dt)) wed, MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM
    (SELECT (TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  ) + (level-1) dt,
           TO_CHAR((TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  ) + (level-1), 'iw') iw,
           TO_CHAR((TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  ) + (level-1), 'd') d,
           
           (TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  ) + (level-1)-
           (TO_CHAR((TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  ) + (level-1), 'd')-1) d_sun,--�ش� ������,
           
           TO_CHAR((TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  ) + (level-1)-
                   (TO_CHAR((TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  ) + (level-1), 'd')-1), 'iw') d_sun_iw
    FROM dual a
    CONNECT BY LEVEL <= LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')) + (7-TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'D')) 
       -
       (TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') ) ) a
GROUP BY a.d_sun_iw
ORDER BY a.d_sun_iw;




SELECT 
        LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')) last,
        7-TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'D') last_d,
        TO_DATE(:YYYYMM, 'YYYYMM') sd,
        7 - (TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1),
       
       LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')) + (7-TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'D'))- 
       TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1   days,
       
       TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  S,
       LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')) + (7-TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'D')) l,
       
       LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')) + (7-TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'D')) 
       -
       (TO_DATE(:YYYYMM, 'YYYYMM') - TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'D') +1  ) days
       
       
       
       
FROM DUAL;



SELECT a.iw,
       DECODE(d, 1, dt) sun, DECODE(d, 2, dt) mon, DECODE(d, 3, dt) tue,
       DECODE(d, 4, dt) wed, DECODE(d, 5, dt) thu, DECODE(d, 6, dt) fri,
       DECODE(d, 7, dt) sat
FROM
    (SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (level-1) dt,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'iw') iw,
           TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd') d
    FROM dual a
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD')) a
order by a.iw;



--�ش� �⵵�� 1���� �������� ������ ���
SELECT  
        TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'), 'iw'),
        TO_DATE('20191231', 'YYYYMMDD')-(TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'), 'd')-1),
        TO_CHAR(TO_DATE('20191231', 'YYYYMMDD')-(TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'), 'd')-1), 'iw'),
        TO_CHAR(NEXT_DAY(TO_DATE('20191231', 'YYYYMMDD'), 5), 'iw'),
        
        TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'), 'iw'),
        TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'), 'd'),
        
        TO_CHAR(TO_DATE('20191230', 'YYYYMMDD'), 'iw'),
        TO_CHAR(TO_DATE('20191229', 'YYYYMMDD'), 'iw')
FROM dual;


--SALES
SELECT NVL(MIN(DECODE(TO_CHAR(DT, 'MM'), '01', SUM(sales))),0) jan,
       NVL(MIN(DECODE(TO_CHAR(DT, 'MM'), '02', SUM(sales))),0) feb,
       NVL(MIN(DECODE(TO_CHAR(DT, 'MM'), '03', SUM(sales))),0) mar,
       NVL(MIN(DECODE(TO_CHAR(DT, 'MM'), '04', SUM(sales))),0) apr,
       NVL(MIN(DECODE(TO_CHAR(DT, 'MM'), '05', SUM(sales))),0) may,
       NVL(MIN(DECODE(TO_CHAR(DT, 'MM'), '06', SUM(sales))),0) june
FROM sales
GROUP BY TO_CHAR(DT, 'MM');

SELECT DECODE(TO_CHAR(DT, 'MM'), '01', SUM(sales)) jan,
       DECODE(TO_CHAR(DT, 'MM'), '02', SUM(sales)) feb,
       DECODE(TO_CHAR(DT, 'MM'), '03', SUM(sales)) mar,
       DECODE(TO_CHAR(DT, 'MM'), '04', SUM(sales)) apr,
       DECODE(TO_CHAR(DT, 'MM'), '05', SUM(sales)) may,
       DECODE(TO_CHAR(DT, 'MM'), '06', SUM(sales)) june
FROM sales
GROUP BY TO_CHAR(DT, 'MM');


--��������
--START WITH : ������ ���� �κ��� ����
--CONNECT BY : ������ ���� ������ ����

--����� �������� (���� �ֻ��� ������������ ��� ������ Ž��)
SELECT  dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*4, ' ') || dept_h.deptnm
FROM dept_h
START WITH deptcd ='dept0' --START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd; --PRIOR ���� ���� ������(XXȸ��)

