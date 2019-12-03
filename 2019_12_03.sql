--outerjoin1
SELECT buyprod.buy_date, buyprod.buy_prod,
       prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE('20050125', 'YYYYMMDD')
AND prod.prod_id = buyprod.buy_prod(+);


--outerjoin2
SELECT TO_DATE(:yyyymmdd, 'YYYYMMDD') buydate, buyprod.buy_prod,
       prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE(:yyyymmdd, 'YYYYMMDD')
AND prod.prod_id = buyprod.buy_prod(+);

--outerjoin3
SELECT TO_DATE(:yyyymmdd, 'YYYYMMDD') buydate, buyprod.buy_prod,
       prod.prod_id, prod.prod_name, NVL(buyprod.buy_qty, 0) buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE(:yyyymmdd, 'YYYYMMDD')
AND prod.prod_id = buyprod.buy_prod(+);

--outerjoni4
--100, 400
SELECT product.pid, product.pnm,  --prodcut
       :cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt --cycle
FROM cycle, product
WHERE cycle.cid(+)= :cid
AND cycle.pid(+) = product.pid;


--outerjoni5
--100, 400
SELECT a.pid, a.pnm, a.cid, customer.cnm, a.day, a.cnt
FROM
    (SELECT product.pid, product.pnm,  --prodcut
           :cid cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt --cycle
    FROM cycle, product
    WHERE cycle.cid(+)= :cid
    AND cycle.pid(+) = product.pid) a, customer
WHERE a.cid = customer.cid;





SELECT product.pid, pnm, NVL(cycle.cid,'1')cycle, NVL(cnm, 'brown') cnm, 
        NVL(day,0) day, NVL(cnt,0) cnt
FROM cycle, product, customer
WHERE product.pid = cycle.pid (+)
AND cycle.cid(+) = customer.cid
AND cycle.cid (+)= 1
ORDER BY pid DESC, DAY DESC;

--(product cycle(+)) customer(+)

SELECT p.pid, p.pnm, NVL(c.cid, 1) AS cid, 
       NVL(cus.cnm, 'brown'), NVL(c.day, 0) AS day, 
       NVL(c.cnt, 0) AS cnt
FROM (cycle c RIGHT OUTER JOIN product p
              ON (c.pid = p.pid AND c.cid = 1)) 
      LEFT OUTER JOIN customer cus ON (c.cid = cus.cid);

--crossjoin1
SELECT *
FROM customer, product;

--도시발전지수
SELECT *
FROM FASTFOOD
WHERE sido ='대전광역시';
GROUP BY GB;


--도시발전지수가 높은 순으로 나열
--도시발전지수 = (버거킹개수 + KFC 개수 + 맥도날드 개수) / 롯데리아 개수
--순위 / 시도 / 시군구 / 도시발전지수(소수점 둘째 자리에서 반올림)
-- 1  / 서울특별시 / 서초구 / 7.5
-- 2  / 서울특별시 / 강남구 / 7.2

--해당 시도, 시군구별 프렌차이즈별 건수가 필요
SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM 
(SELECT a.sido, a.sigungu, ROUND(a.cnt/b.cnt, 1) as 도시발전지수
FROM 
    (SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
    FROM fastfood
    WHERE gb IN ('KFC', '버거킹', '맥도날드')
    GROUP BY sido, sigungu) a,
    
    (SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
    FROM fastfood
    WHERE gb = '롯데리아'
    GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 DESC);

SELECT *
FROM TAX
ORDER BY SAL DESC;






--하나의 SQL로 작성하지 마세요
--fastfood 테이블을 이용하여 여러번의 sql 실행 결과를
--손으로 계산해서 도시 발전지수를 계산
--대전시 유성구  10/3 = 3.3
--대전시 동구  
--대전시 서구
--대전시 중구
--대전시 대덕구





