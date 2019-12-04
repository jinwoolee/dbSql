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

--���ù�������
SELECT *
FROM FASTFOOD
WHERE sido ='����������';
GROUP BY GB;


--���ù��������� ���� ������ ����
--���ù������� = (����ŷ���� + KFC ���� + �Ƶ����� ����) / �Ե����� ����
--���� / �õ� / �ñ��� / ���ù�������(�Ҽ��� ��° �ڸ����� �ݿø�)
-- 1  / ����Ư���� / ���ʱ� / 7.5
-- 2  / ����Ư���� / ������ / 7.2

--�ش� �õ�, �ñ����� ��������� �Ǽ��� �ʿ�
SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM 
(SELECT a.sido, a.sigungu, ROUND(a.cnt/b.cnt, 1) as ���ù�������
FROM 
    (SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
    FROM fastfood
    WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
    GROUP BY sido, sigungu) a,
    
    (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
    FROM fastfood
    WHERE gb = '�Ե�����'
    GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC);


--�ϳ��� SQL�� �ۼ����� ������
--fastfood ���̺��� �̿��Ͽ� �������� sql ���� �����
--������ ����ؼ� ���� ���������� ���
--������ ������  10/3 = 3.3
--������ ����  
--������ ����
--������ �߱�
--������ �����


--1 ���� �߱� 5.8  1 ���� ������ 70.3







