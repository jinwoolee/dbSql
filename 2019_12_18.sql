-- 12.18일까지 과제

SELECT NVL(1, 0), NVL(1), NVL(NULL)
FROM dual;

SELECT
    MAX(NVL(DECODE(d, 1, dt), dt - d + 1)) 일, MAX(NVL(DECODE(d, 2, dt), dt - d + 2)) 월, MAX(NVL(DECODE(d, 3, dt), dt - d + 3)) 화,
    MAX(NVL(DECODE(d, 4, dt), dt - d + 4)) 수, MAX(NVL(DECODE(d, 5, dt), dt - d + 5)) 목, MAX(NVL(DECODE(d, 6, dt), dt - d + 6)) 금, MAX(NVL(DECODE(d, 7, dt), dt - d + 7)) 토
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);

    
SELECT dt,
    NVL(DECODE(d, 1, dt), dt - d + 1) 일, NVL(DECODE(d, 2, dt), dt - d + 2) 월, NVL(DECODE(d, 3, dt), dt - d + 3) 화,
    NVL(DECODE(d, 4, dt), dt - d + 4) 수, NVL(DECODE(d, 5, dt), dt - d + 5) 목, NVL(DECODE(d, 6, dt), dt - d + 6) 금, NVL(DECODE(d, 7, dt), dt - d + 7) 토
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'));
    
    
--201910 : 35, 첫주의 일요일: 20190929, 마지막주의 토요일 : 20191102
-- 일(1), 월(2), 화(3), 수(4), 목(5), 금(6), 토(7)
SELECT LDT-FDT+1
FROM 
(SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,

       LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
       7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
       
       TO_DATE(:yyyymm, 'YYYYMM')- 
       (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
 FROM dual);




-- 12.18일까지 과제
SELECT
    MAX(DECODE(d, 1, dt)) 일, MAX(DECODE(d, 2, dt)) 월,
    MAX(DECODE(d, 3, dt)) 화, MAX(DECODE(d, 4, dt)) 수,
    MAX(DECODE(d, 5, dt)) 목, MAX(DECODE(d, 6, dt)) 금,
    MAX(DECODE(d, 7, dt)) 토
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM')- 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1) dt, --BEFORE
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')- 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1), 'D') d,
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')- 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= (SELECT LDT-FDT+1
                        FROM 
                        (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
                        
                               LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
                               7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
                               
                               TO_DATE(:yyyymm, 'YYYYMM')- 
                               (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
                         FROM dual)) )
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);




    
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd='dept0'   --시작점은 deptcd = 'dept0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd;

--*********XX회사
SELECT LPAD('XX회사', 15, '*'),
       LPAD('XX회사', 15)
FROM dual;
  

/*
dept0(XX회사)
dept0_00(디자인부)
    dept0_00_0(디자인팀)
dept0_01(정보기획부)
    dept0_01_0(기획팀)
        dept0_00_0_0(기획파트)
dept0_02(정보시스템부)
    dept0_02_0(개발1팀)
    dept0_02_1(개발2팀)
*/    
            

--h_2
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd='dept0_02'   --시작점은 deptcd = 'dept0' --> XX회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM dept_h;

-- 디자인팀(dept0_00_0)을 기준으로 상향식 계층쿼리 작성
-- 자기 부서의 부모 부서와 연결을 한다
SELECT dept_h.*, LPAD(' ', 4*(LEVEL-1)) || deptnm, level
FROM dept_h
START WITH deptcd='dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE '디자인%';

SELECT *
FROM dept_h;






--조인 조건은  한컬럼에만 적용가능한가?
SELECT *
FROM tab_a, tab_b
WHERE tab_a.a = tab_b.a
AND   tab_a.b = tab_b.b;


SELECT LPAD(' ', 4*(LEVEL-1)) || s_id s_id, value, LEVEL
FROM h_sum
START WITH s_id='0'
CONNECT BY ps_id = PRIOR s_id;





-- pruning branch (가지치기)
-- 계층 쿼리의 실행순서
-- FROM --> START WITH ~ CONNECT BY --> WHERE
-- 조건을 CONNECT BY 절에 기술한 경우
--  . 조건에 따라 다음 ROW로 연결이 안되고 종료
-- 조건을 WHERE 절에 기술한 경우
--  . START WITH ~ CONNECT BY 절에 의해 계층형으로 나온 결과에
--    WHERE 절에 기술한 결과 값에 해당하는 데이터만 조회

--최상위 노드에서 하향식으로 탐색
SELECT *
FROM dept_h
WHERE  deptcd='dept0';

--CONNECTY BY절에 deptnm != '정보기획부' 조건을 기술한 경우
SELECT *
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '정보기획부';


-- WHERE 절에 deptnm != '정보기획부' 조건을 기술한 경우
-- 계층쿼리를 실행하고나서 최종 결과에 WHERE 절 조건을 적용
SELECT *
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

-- 계층 쿼리에서 사용 가능한 특수 함수
-- CONNECT_BY_ROOT(col) 가장 최상위 row의 col 정보 값 조회
-- SYS_CONNECT_BY_PATH(col, 구분자) : 최상위 row에서 현재 로우까지 col값을
-- 구분자로 연결해준 문자열 (EX : XX회사-디자인부디자인팀)
-- CONNECT_BY_ISLEAF : 해당 ROW가 마지막 노드인지(leaf Node)
-- leaf node : 1, node : 0
SELECT deptcd, LPAD(' ' , 4*(LEVEL-1)) || deptnm,
       CONNECT_BY_ROOT(deptnm) c_root,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path,
       CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

SELECT *
FROM board_test;

-- h_6
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

-- h_7
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

-- h_8
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;