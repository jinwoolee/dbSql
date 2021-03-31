COUNT, AVG, MIN, MAX, SUM

SELECT empno, ename, deptno,
       COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;


ana2~4]
SELECT empno, ename, sal, deptno,
       ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) avg_sal,
       MIN(sal) OVER (PARTITION BY deptno) min_sal,
       MAX(sal) OVER (PARTITION BY deptno) max_sal,
       SUM(sal) OVER (PARTITION BY deptno) sum_sal,
       COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;


자신보다 급여 순위가 한단계 낮은 사람의 급여를 5번째 컬럼으로 생성
SELECT empno, ename, hiredate, sal,
       LEAD(sal) OVER (ORDER BY sal DESC, hiredate)
FROM emp;

SELECT empno, ename, hiredate, sal,
       LAG(sal) OVER (ORDER BY sal DESC, hiredate)
FROM emp;


ana5_1]
SELECT a.empno, a.ename, a.hiredate, a.sal, b.sal
FROM
(SELECT a.*, ROWNUM rn
 FROM 
(SELECT empno, ename, hiredate, sal
 FROM emp
 ORDER BY sal DESC, hiredate) a ) a,
(SELECT a.*, ROWNUM rn
 FROM 
(SELECT empno, ename, hiredate, sal
 FROM emp
 ORDER BY sal DESC, hiredate) a ) b
WHERE a.rn-1 = b.rn(+)
ORDER BY a.sal DESC, a.hiredate; 


ana6]

         













SELECT a.*, b.sal
FROM 
(SELECT a.*, ROWNUM rn
 FROM 
    (SELECT empno, ename, hiredate, sal
    FROM emp
    ORDER BY sal DESC, hiredate) a ) a,
(SELECT a.*, ROWNUM rn
 FROM 
    (SELECT empno, ename, hiredate, sal
    FROM emp
    ORDER BY sal DESC, hiredate) a ) b
WHERE a.rn-1 = b.rn(+)
ORDER BY a.sal DESC, a.hiredate;    

ana6]
SELECT empno, ename, hiredate, job, sal,
       LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate)
FROM emp;

LAG, LEAD 함수의 두번째 인자 : 이전, 이후 몇번째 행을 가져올지 표기
SELECT empno, ename, hiredate, sal,
       LAG(sal, 2) OVER (ORDER BY sal DESC, hiredate)
FROM emp;

SELECT empno, ename, hiredate, sal,
       LEAD(sal, 2) OVER (ORDER BY sal DESC, hiredate)
FROM emp;

1. ROWNUM
2. INLINE VIEW
3. NON-EQUI-JOIN
4. GROUP BY
SELECT a.empno, a.ename, a.sal, SUM(b.sal)
FROM
(SELECT a.*, ROWNUM rn
FROM
(SELECT empno, ename, sal
 FROM emp
 ORDER BY sal, empno ) a ) a,
(SELECT a.*, ROWNUM rn
FROM
(SELECT empno, ename, sal
 FROM emp
 ORDER BY sal, empno ) a ) b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal, a.empno; 




분석함수() OVER ( [PARTITION] [ORDER] [WINDOWING])
WINDOWING : 윈도우 함수의 대상이 되는 행을 지정
UNBOUNDED PRECEDING : 특정 행을 기준으로 모든 이전행(LAG)
    n PRECEDING : 특정 행을 기준으로 N행 이전행(LAG)
CURRENT ROW : 현재행
UNBOUNDED FOLLOWING : 특정 행을 기준으로 모든 이후행(LEAD)
    n FOLLOWING : 특정 행을 기준으로 N행 이후행(LEAD)


분석함수() OVER ( [] [ORDER] [WINDOWING])
SELECT empno, ename, sal,
       SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum,
       SUM(sal) OVER (ORDER BY sal, empno ROWS UNBOUNDED PRECEDING) c_sum
FROM emp
ORDER BY sal, empno;


SELECT empno, ename, sal,
       SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp
ORDER BY sal, empno;



ana7]
SELECT empno, ename, deptno, sal,
       --SUM(sal) OVER ([PARTITION BY deptno] [ORDER BY sal, empno] [ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW]) c_sum
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp
ORDER BY sal, empno;


ROWS와 RANGE의 차이
SELECT empno, ename, sal,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_c_sum,
       SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_c_sum,
       SUM(sal) OVER (ORDER BY sal) no_win_c_sum,  --ORDER BY 이후 윈도윙 없을 경우 기본 설정 : RANGE UNBOUNDED PRECEDING
       SUM(sal) OVER () no_ord_c_sum
FROM emp
ORDER BY sal, empno;



수업시간 내용을 잘 이해 한경우