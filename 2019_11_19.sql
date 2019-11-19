--DML : SELECT
/*
    SELECT *
    FROM 테이블명;
*/

--코드의 이해를 돕기 위해 설명을 작성 : 주석

-- prod 테이블의 모든 컬럼을 대상으로 모든 데이터를 조회
SELECT *
FROM prod;

--prod 테이블의 prod_id, prod_name 컬럼만 모든 데이터(모든 row)에 대해 조회
SELECT prod_id, prod_name
FROM prod;

--현재 접속한 계정에 생성되어있는 테이블 목록을 조회
SELECT *
FROM USER_TABLES;

--테이블의 컬럼 리스트 조회
SELECT *
FROM USER_TAB_COLUMNS;

--DESC 테이블명
DESC prod;


--select1
SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;












