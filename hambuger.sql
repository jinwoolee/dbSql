시도, 시군구, 버거킹 건수, kfc 건수, 맥도날드 건수, 롯데리아 건수

시도, 시군구, 버거킹 건수
시도, 시군구, kfc 건수
시도, 시군구, 맥도날드 건수
시도, 시군구, 롯데리아 건수

사용된 SQL 문법 : WHERE, 그룹연산을 위한 GROUP BY, 복수행 함수(COUNT),
                 인라인 뷰, ROWNUM, ORDER BY, 별칭(컬럼, 테이블), ROUND, JOIN

SELECT ROWNUM rn, a.sido, a.sigungu, a.city_idx
FROM 
(SELECT bk.sido, bk.sigungu, bk.cnt, kfc.cnt, mac.cnt, lot.cnt, 
       ROUND((bk.cnt +kfc.cnt+ mac.cnt)/ lot.cnt, 2) city_idx
FROM
(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '버거킹'
GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) kfc,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '맥도날드'
GROUP BY sido, sigungu) mac,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '롯데리아'
GROUP BY sido, sigungu) lot
WHERE bk.sido = kfc.sido
  AND bk.sigungu = kfc.sigungu
  AND bk.sido = mac.sido
  AND bk.sigungu = mac.sigungu
  AND bk.sido = lot.sido
  AND bk.sigungu = lot.sigungu
ORDER BY city_idx DESC ) a;  



SELECT *
FROM tax;

필수
과제1] fastfood 테이블과 tax 테이블을 이용하여 다음과 같이 조회되도록 SQL 작성
 1. 시도 시군구별 도시발전지수를 구하고(지수가 높은 도시가 순위가 높다)
 2. 인당 연말 신고액이 높은 시도 시군구별로 순위를 구하여
 3. 도시발전지수와 인당 신고액 순위가 같은 데이터 끼리 조인하여 아래와 같이 컬럼이 조회되도록 SQL 작성
 
순위, 햄버거 시도, 햄버거 시군구, 햄버거 도시발전지수, 국세청 시도, 국세청 시군구, 국세청 연말정산 금액1인당 신고액 


옵션
과제2]
햄버거 도시발전 지수를 구하기 위해 4개의 인라인 뷰를 사용 하였는데 (fastfood 테이블을 4번 사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선 (fastfood 테이블을 1번만 사용)
CASE, DECODE

과제3]
햄버거 지수 sql을 다른 형태로 도전하기


