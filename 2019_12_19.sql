SELECT
    MAX(DECODE(d, 1, dt)) ��, MAX(DECODE(d, 2, dt)) ��,
    MAX(DECODE(d, 3, dt)) ȭ, MAX(DECODE(d, 4, dt)) ��,
    MAX(DECODE(d, 5, dt)) ��, MAX(DECODE(d, 6, dt)) ��,
    MAX(DECODE(d, 7, dt)) ��
FROM
    (SELECT LEVEL, TRUNC((LEVEL-1)/7) m,
            TO_DATE(:yyyymm, 'YYYYMM')- 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1) dt, --BEFORE
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')- 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1), 'D') d
            FROM dual
    CONNECT BY LEVEL <= (SELECT LDT-FDT+1
                        FROM 
                        (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
                        
                               LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
                               7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
                               
                               TO_DATE(:yyyymm, 'YYYYMM')- 
                               (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
                         FROM dual)) )
    GROUP BY M
    ORDER BY M;
    
    
SELECT seq, parent_seq, NVL(parent_seq,seq), LPAD(' ', 4*(LEVEL-1)) || title ti, LEVEL
FROM board_test
START WITH  parent_seq  IS NULL 
CONNECT BY  PRIOR seq =  parent_seq
ORDER SIBLINGS BY NVL(parent_seq,seq) DESC;


SELECT seq, CONNECT_BY_ROOT(seq),
       LPAD(' ', 3 * (level - 1)) || TITLE         title
FROM BOARD_TEST
Start WITH PARENT_SEQ is null
CONNECT BY PRIOR seq = PARENT_SEQ
order by  CONNECT_BY_ROOT(seq)desc ,seq asc;

--����̸�, �����ȣ, ��ü�����Ǽ�
SELECT ename, empno, COUNT(*), SUM(SAL)
FROM emp
GROUP BY ename, empno;


-- �м��Լ�
-- ana0

SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
 FROM 
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC))a,

(SELECT deptno, rn, ROWNUM j_rn
FROM 
(SELECT a.deptno, b.rn
    FROM
        (SELECT deptno, COUNT(*) cnt
         FROM emp
         GROUP BY deptno) a,
        (SELECT rownum rn
         FROM emp) b
    WHERE a.cnt >= b.rn
    ORDER BY a.deptno, b.rn)) b
WHERE a.j_rn = b.j_rn    ;
    
    
SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
    WHERE b.cnt >= a.rn
    ORDER BY b.deptno, a.rn )) b
WHERE a.j_rn = b.j_rn;



-- ana0-�� �м��Լ���
SELECT ename, sal, deptno,
       RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) dense_rank,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) row_number
FROM emp;


SELECT empno, ename, sal, deptno,
       RANK() OVER (ORDER BY sal DESC, empno) sal_rank,
       DENSE_RANK() OVER (ORDER BY sal DESC, empno) sal_dense_rank,
       ROW_NUMBER() OVER (ORDER BY sal DESC, empno) sal_row_number
FROM emp;
    
SELECT empno, ename, deptno
FROM emp;

SELECT emp.empno, emp.ename, emp.deptno, b.cnt
FROM 
 emp,
(SELECT deptno, COUNT(*) cnt
 FROM emp
 GROUP BY deptno ) b
WHERE emp.deptno = b.deptno;


--�����ȣ, ����̸�, �μ���ȣ, �μ��� ������
SELECT empno, ename, deptno,
       COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;
    
-- ana3, 4    
SELECT empno, ename, sal, deptno,
       MAX(sal) OVER (PARTITION BY deptno) max_sal,
       MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;

-- ��ü����� ������� �޿������� �ڽź��� �Ѵܰ� ���� ����� �޿�
-- (�޿��� ������� �Ի����ڰ� ���� ����� ���� ����)
SELECT empno, ename, hiredate, sal,
       LAG(sal) OVER (ORDER BY sal DESC, hiredate) lag_sal
FROM emp;
--ORDER BY sal DESC, hiredate;

    
-- ana6
SELECT empno, ename, hiredate, job, sal,
       LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

-- no_ana3
SELECT empno, ename, sal
FROM emp
ORDER BY sal, hiredate;
    
    
    