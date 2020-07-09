OUTER JOIN < == > INNER JOIN

INNER JOIN : 조인 조건을 만족하는 (조인에 성공하는) 데이터만 조회
OUTER JOIN : 조인 조건을 만족하지 않더라도 (조인에 실패하더라도) 기준이 되는 테이블 쪽의
             데이터(컬럼)은 조회가 되도록 하는 조인 방식
             
OUTER JOIN : 
    LEFT OUTER JOIN : 조인 키워드의 왼쪽에 위치하는 테이블을 기준삼아 OUTER JOIN 시행
    RIGHT OUTER JOIN : 조인 키워드의 오른쪽에 위치하는 테이블을 기준삼아 OUTER JOIN 시행             
    FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복되는것 제외

ANSI-SQL
FROM 테이블1 LEFT OUTER JOIN 테이블2 ON (조인 조건)

ORACLE-SQL : 데이터가 없는데 나와야하는 테이블의 컬럼
FROM 테이블1, 테이블2
WHERE 테이블1.컬럼 = 테이블2.컬럼(+)

ANSI-SQL OUTER
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
    
ORACLE-SQL OUTER
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);


OUTER JOIN 시 조인 조건(ON 절에 기술)과 일반 조건(WHERE 절에 기술)적용시 주의 사항
: OUTER JOIN을 사용하는데 WHERE 절에 별도의 다른 조건을 기술할 경우 원하는 결과가 안나올 수 있다
   ==> OUTER JOIN의 결과가 무시
   
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno=10);

ORACLE-SQL
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
  AND m.deptno(+)=10;



조인 조건을 WHERE 절로 변경한 경우   
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno=10;

ORACLE-SQL
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
  AND m.deptno=10;


위의 쿼리는 OUTER JOIN을 적용하지 않은 아래 쿼리와 동일한 결과를 나타낸다
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno=10;


RIGHT OUTER JOIN : 기준 테이블이 오른쪽
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno); : 14건
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno); : 21건

FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복제거

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

ORACLE SQL에서는 FULL OUTER 문법을 제공하지 않음
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr(+) = m.empno(+);

A : {1, 3, 5}
B : {2, 3, 4}
A U B : {1, 2, 3, 4, 5} 집합에서 중복의 개념은 없다

A : {1, 3}
B : {1, 3}
C : {1, 2, 3}
A-B = 공집합
A-C : 공집합
C-A : {2}


FULL OUTER 검증

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
UNION
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno)
MINUS
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);



SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
UNION
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno)
INTERSECT
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

WHERE : 행을 제한
JOIN
GROUP FUNCTION


시도 : 서울특별시, 충청남도
시군구 : 강남구, 청주시
스토어 구분

SELECT *
FROM fastfood;

발전지수 =  (KFC + 버거킹 + 맥도날드) / 롯데리아
순위, 시도, 시군구, 버거 도시발전지수(소수점 2자리)
정렬은 순위가 높은 행이 가장 먼저 나오도록
1, 서울특별시, 강남구, 5.32
2, 서울특별시, 서초구, 5.13
....

1. 시도, 시군구, 프렌차이즈별 kfc, 맥도날드, 버거킹, 롯데리아 건수 세기
   1-1. 프렌차이즈별로 SELECT 쿼리 분리 한 경우
        ==> OUTER
        ==> 기준 테이블을 무엇으로??
   1-2. kfc, 맥도날드, 버거킹 1개의 SQL로, 롯데리아 1개     
   1-3. 모든 프렌차이즈를 SELECT 쿼리 하나에서 카운팅 한 경우
   
SELECT kfc.sido, kfc.sigungu, ROUND((kfc.kfc + bk.bk + mac.mac) / lot.lot, 2) score
FROM 
(SELECT sido, sigungu, COUNT(*) kfc
 FROM fastfood
 WHERE gb = 'KFC'
 GROUP BY sido, sigungu) kfc,
(SELECT sido, sigungu, COUNT(*) bk
 FROM fastfood
 WHERE gb = '버거킹'
 GROUP BY sido, sigungu) bk,
 (SELECT sido, sigungu, COUNT(*) mac
 FROM fastfood
 WHERE gb = '맥도날드'
 GROUP BY sido, sigungu) mac,
 (SELECT sido, sigungu, COUNT(*) lot
 FROM fastfood
 WHERE gb = '롯데리아'
 GROUP BY sido, sigungu) lot
WHERE kfc.sido = bk.sido
  AND kfc.sigungu = bk.sigungu
  AND kfc.sido = mac.sido
  AND kfc.sigungu = mac.sigungu
  AND kfc.sido = lot.sido
  AND kfc.sigungu = lot.sigungu
ORDER BY ROUND((kfc.kfc + bk.bk + mac.mac) / lot.lot, 2) DESC  ;


1.2
SELECT m.sido, m.sigungu, ROUND(m.m / d.d, 2) score
FROM 
(SELECT sido, sigungu, COUNT(*) m
 FROM fastfood
 WHERE gb IN ('KFC', '버거킹', '맥도날드')
 GROUP BY sido, sigungu) m,
(SELECT sido, sigungu, COUNT(*) d
 FROM fastfood
 WHERE gb = '롯데리아'
 GROUP BY sido, sigungu) d 
WHERE m.sido =  d.sido
  AND m.sigungu = d.sigungu
ORDER BY score DESC; 


1.3
SELECT sido, sigungu, 
       ROUND((NVL(SUM(DECODE(gb, 'KFC', 1)), 0) + 
           NVL(SUM(DECODE(gb, '맥도날드', 1)), 0) +
           NVL(SUM(DECODE(gb, '버거킹', 1)), 0)) /
           NVL(SUM(DECODE(gb, '롯데리아', 1)), 1), 2) SCORE
FROM fastfood
WHERE gb IN ('KFC', '맥도날드', '버거킹', '롯데리아')
GROUP BY sido, sigungu
ORDER BY SCORE DESC;

SELECT sido, sigungu, 
       ROUND((NVL(SUM(DECODE(storecategory, 'KFC', 1)), 0) + 
           NVL(SUM(DECODE(storecategory, 'MACDONALD', 1)), 0) +
           NVL(SUM(DECODE(storecategory, 'BURGER KING', 1)), 0)) /
           NVL(SUM(DECODE(storecategory, 'LOTTERIA', 1)), 1), 2) SCORE
FROM burgerstore
WHERE storecategory IN ('MACDONALD', 'KFC', 'BURGER KING', 'LOTTERIA')
GROUP BY sido, sigungu
ORDER BY SCORE DESC;

SELECT *
FROM burgerstore;




SELECT *
FROM burgerstore;

 
 