SELECT s,
       MAX(DECODE(d, 1, dt)) sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
       MAX(DECODE(d, 4, dt)) wed, MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri,
       MAX(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1)
        - (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') -1) s
       
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY s
ORDER BY s;


WITH dt AS (
    SELECT TO_DATE('2019/12/01', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/02', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/03', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/04', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/05', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/06', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/07', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/08', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/09', 'YYYY/MM/DD') dt FROM dual UNION ALL
    SELECT TO_DATE('2019/12/10', 'YYYY/MM/DD') dt FROM dual)
SELECT dt, dt - (TO_CHAR(dt, 'd')-1)
FROM dt;




SELECT MIN(DECODE(d,1,day)) sun,  MIN(DECODE(d,2,day)) mon,  MIN(DECODE(d,3,day)) tue,  
       MIN(DECODE(d,4,day)) wed,  MIN(DECODE(d,5,day)) thu,  MIN(DECODE(d,6,day)) fri,  MIN(DECODE(d,7,day)) sat
FROM(SELECT TO_DATE(:yyyymm,'YYYYMM') + LEVEL - 1 day , 
            TO_CHAR((TO_DATE(:yyyymm,'YYYYMM') + LEVEL - 1), 'D') d,
           (TO_CHAR((TO_DATE(:yyyymm,'YYYYMM')), 'D') + level - 2) temp
     FROM dual
     CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),'DD')) a
GROUP BY TRUNC(temp/7)
ORDER BY TRUNC(temp/7);


SELECT  
        MAX(DECODE(d, 1, dt)) sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
        MAX(DECODE(d, 4, dt)) wed, MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri,
        MAX(DECODE(d, 7, dt)) sat
FROM    (SELECT (TO_DATE(:month, 'YYYYMM') + level -1) dt,
                TO_CHAR(TO_DATE(:month, 'YYYYMM')+ level -1,'D') d,
                DECODE(TO_CHAR(TO_DATE(:month, 'YYYYMM')+ level -1,'D'),
                            1, TO_CHAR(TO_DATE(:month, 'YYYYMM')+ level,'IW'), 
                            TO_CHAR(TO_DATE(:month, 'YYYYMM')+ level -1,'IW')) iw
         FROM dual
         CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:month, 'YYYYMM')), 'DD'))
GROUP BY iw
ORDER BY sat;


SELECT MAX(DECODE(d, 1, dt)), MAX(DECODE(d, 2, dt)), MAX(DECODE(d, 3, dt)), 
       MAX(DECODE(d, 4, dt)), MAX(DECODE(d, 5, dt)), MAX(DECODE(d, 6, dt)), 
       MAX(DECODE(d, 7, dt))
FROM
( SELECT TO_DATE(:dtdt, 'yyyymm') + level - TO_CHAR(TO_DATE(:dtdt, 'yyyymm'), 'd') dt,
       TO_CHAR(TO_DATE(:dtdt, 'yyyymm') + level - TO_CHAR(TO_DATE(:dtdt, 'yyyymm'), 'd'), 'd') d,
       CASE WHEN ROWNUM <= 7 THEN 1 WHEN ROWNUM <= 14 THEN 2 WHEN ROWNUM <= 21 THEN 3
            WHEN ROWNUM <= 28 THEN 4 WHEN ROWNUM <= 35 THEN 5 WHEN ROWNUM <= 42 THEN 6
            END test, ROWNUM
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dtdt, 'yyyymm')), 'dd') + 
                    TO_CHAR(TO_DATE(:dtdt, 'yyyymm'), 'd') - 1 + 7 - 
                    TO_CHAR(LAST_DAY(TO_DATE(:dtdt, 'yyyymm')), 'd') )
GROUP BY test
ORDER BY test;



SELECT 
        MAX(DECODE(d, 1, dt)) sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
        MAX(DECODE(d, 4, dt)) wed, MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri,
        MAX(DECODE(d, 7, dt)) sat
FROM    
        (SELECT (TO_DATE(:month, 'YYYYMM')-TO_CHAR(TO_DATE(:month, 'YYYYMM'),'D') + level) dt,
                TO_CHAR((TO_DATE(:month, 'YYYYMM')-TO_CHAR(TO_DATE(:month, 'YYYYMM'),'D') + level),'D') d,
                DECODE(TO_CHAR((TO_DATE(:month, 'YYYYMM')-TO_CHAR(TO_DATE(:month, 'YYYYMM'),'D') + level),'D'), 1,
                        TO_CHAR(TO_DATE(:month, 'YYYYMM')-TO_CHAR(TO_DATE(:month, 'YYYYMM'),'D')+ level+1,'IW'),
                         TO_CHAR(TO_DATE(:month, 'YYYYMM')-TO_CHAR(TO_DATE(:month, 'YYYYMM'),'D')+ level,'IW')) iw
         FROM dual
         CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:month, 'YYYYMM')), 'DD')+ TO_CHAR(TO_DATE(:month, 'YYYYMM'),'D')-1 +
                                    (7-TO_CHAR(LAST_DAY(TO_DATE(:month, 'YYYYMM')), 'D')))
GROUP BY iw
ORDER BY sun;


SELECT  '31'+ 4-1 + (7-6)
FROM dual;                 


mybatis
SELECT : 결과가 1건이냐, 복수거냐
    1건 : sqlSession.selectOne("네임스페이스.sqlid", [인자]) ==> overloading
          리턴타입 : resultType
    복수 : sqlSession.selectList("네임스페이스.sqlid", [인자]) ==> overloading
          리턴타입 : List<resultType>



SELECT *
FROM dept;


오라클 계층쿼리 : 하나의 테이블(혹은 인라인 뷰)에서 
                특정 행을 기준으로 다른 행을 찾아가는 문법
조인 : 테이블 - 테이블
계층쿼리 : 행-행

1. 시작점(행)을 설정
2. 시작점(행)과 다른행을 연결시킬 조건을 기술

1. 시작점 : mgr 정보가 없는 KING
2. 연결 조건 : KING을 MGR컬럼으로 하는 사원

SELECT LPAD('기준문자열', 15)
FROM dual;

LEVEL = 1 : 0칸
LEVEL = 2 : 4칸
LEVEL = 3 : 8칸

SELECT LPAD(' ', (LEVEL-1)*4) || ename, LEVEL
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;


최하단 노드에서 상위 노드로 연결하는 상향식 연결방법
시작점 : SMITH

**PRIOR 키워드는 CONNECT BY 키워드와 떨어져서 사용해도 무관
**PRIOR 키워드는 현재 읽고 있는 행을 지칭하는 키워드

SELECT LPAD(' ', (LEVEL-1) *4) || ename, emp.*
FROM emp
START WITH ename = 'SMITH'
CONNECT BY empno = PRIOR mgr AND PRIOR hiredate < hiredate;

SELECT *
FROM dept_h;

XX회사 부서부터 시작하는 하향식 계층쿼리 작성, 부서이름과 LEVEL 컬럼을 이용하여
들여쓰기 표현

SELECT LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptnm = 'XX회사'
CONNECT BY PRIOR deptcd = p_deptcd;

