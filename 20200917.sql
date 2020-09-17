SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
  AND cycle.cid = customer.cid
  AND cycle.pid = product.pid
  AND cycle.pid IN ( SELECT pid
                     FROM cycle
                     WHERE cid = 2);
                     
순위    시도    시군구     kfc건수  맥도날드    버거킹      롯데리아
1     서울시   서초구         3        4         5          6
2     서울시   강남구      
3     부산시   해운대구   

서울시 시초구 KFC      6
서울시 시초구 맥도날드  5


SELECT sido, sigungu, gb, COUNT(*)
FROM fastfood
WHERE gb = '롯데리아'
  AND sido = '강원도'
  AND sigungu = '강릉시'
GROUP BY sido, sigungu, gb
ORDER BY sido, sigungu, gb;


SELECT * --sido, sigungu, gb, 
FROM fastfood
ORDER BY sido, sigungu, gb;

KFC-66 롯데리아-188 버거킹- 104 맥도날드-126
SELECT sido, sigungu, gb, COUNT(*) cnt
FROM fastfood
WHERE gb = '맥도날드'
GROUP BY sido, sigungu, gb
ORDER BY sido, sigungu, gb;



SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 2) di
FROM
(SELECT sido, sigungu, COUNT(*) cnt
 FROM fastfood
 WHERE gb IN ( 'KFC', '맥도날드', '버거킹')
 GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt
 FROM fastfood
 WHERE gb = '롯데리아'
 GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY di DESC;

 kfc 건수, 롯데리아건수, 버거킹 건수, 맥도날드 건수;
 
SELECT sido, sigungu, 
        ROUND((NVL(SUM(DECODE(gb, 'KFC', cnt)), 0) +       
        NVL(SUM(DECODE(gb, '버거킹', cnt)), 0) +
        NVL(SUM(DECODE(gb, '맥도날드', cnt)), 0) ) /        
        NVL(SUM(DECODE(gb, '롯데리아', cnt)), 1), 2) di 
FROM 
(SELECT sido, sigungu, gb, COUNT(*) cnt
 FROM fastfood
 WHERE gb IN ('KFC', '롯데리아', '버거킹', '맥도날드')
 GROUP BY sido, sigungu, gb)
GROUP BY sido, sigungu 
ORDER BY di DESC;
 
 
ORDER BY sido, sigungu, gb;


SELECT sido, sigungu, ROUND(sal/people) p_sal
FROM tax
ORDER BY p_sal DESC;

도시발전지수 1 - 세금1위
도시발전지수 2 - 세금2위
도시발전지수 3 - 세금3위



DML : Data Manipulate LANGUAGE
1. SELECT ********
2. INSERT : 테이블에 새로운 데이터를 입력하는 명령
3. UPDATE : 테이블에 존재하는 데이터의 컬럼을 변경하는 명령
4. DELETE : 테이블에 존재하는 데이터(행)를 삭제하는 명령

INSERT 3가지
1. 테이블의 특정 컬럼에만 데이터를 입력할 때(입력되지 않은 컬럼은 NULL로 설정 된다)
INSERT INTO 테이블명 (컬럼1, 컬럼2....) VALUES (컬러1의 값1, 컬럼2의 값2....);

DESC emp;

INSERT INTO emp (empno, ename) VALUES (9999, 'brown');
SELECT *
FROM emp
WHERE empno = 9999;

empno컬럼의 설정이 NOT NULL이기 때문에 empno 컬럼에 NULL 값이 들어갈수 없어서 에러가 발생
INSERT INTO emp (ename) VALUES ('sally');


2. 테이블의 모든 컬럼에 모든 데이터를 입력할 때
   **** 단 값을 나열하는 순서는 테이블의 정의된 컬럼 순서대로 기술 해야한다
        테이블 컬럼 순서 확인 방법 : DESC 테이블명
INSERT INTO 테이블명 VALUES (컬러1의 값1, 컬럼2의 값2....);

DESC dept;

INSERT INTO dept VALUES ( 98, '대덕', '대전');
SELECT *
FROM dept;

컬럼을 기술하지 않았기 때문에 테이블에 정의된 모든 컬럼에 대해 값을 기술해야하나
3개중에 2개만 기술하여 에러 발생
INSERT INTO dept VALUES ( 97, 'DDIT');

3. SELECT 결과를(여러행일 수도 있다) 테이블에 입력
INSERT INTO 테이블명 [(co1,...)] 
SELECT 구문;

INSERT INTO emp (empno, ename) 
SELECT 9997, 'cony' FROM dual 
UNION ALL
SELECT 9996, 'moon' FROM dual;

SELECT *
FROM emp;

날짜 컬럼 값 입력하기
INSERT INTO emp VALUES (9996, 'james', 'CLERK', NULL, SYSDATE, 3000, NULL, NULL);

'2020/09/01'
INSERT INTO emp VALUES (9996, 'james', 'CLERK', NULL, 
                        TO_DATE('2020/09/01', 'YYYY/MM/DD'), 3000, NULL, NULL);

SELECT *
FROM emp;

UPDATE : 테이블에 존재하는 데이터를 수정
       1. 어떤 데이터를 수정할지 데이터를 한정 (WHERE)
       2. 어떤 컬럼에 어떤 값을 넣을지 기술

UPDATE 테이블명 SET 변경할 컬럼명 = 수정할 값 [, 변경할 컬럼명 = 수정할 값 ....]       
[WHERE]

99	ddit	daejeon
dept 테이블의 deptno 컬럼의 값이 99번인 데이터의 
    DNAME 컬럼을 대문자 DDIT로, LOC 컬럼을 한글 '영민'으로 변경

UPDATE dept SET dname = 'DDIT', loc = '영민'
WHERE deptno = 99;

SELECT *
FROM dept;

SELECT *
FROM emp;

UPDATE dept SET dname = 'DDIT', loc = '영민';

ROLLBACK;

2. 서브쿼리를 활용한 데이터 변경 (***추후 MERGE 구문을 배우면 더 효율적으로 작성할 수 있다)

테스트 데이터 입력
INSERT INTO emp (empno, ename, job) VALUES (9000, 'brown', NULL);

9000번 사번의 DEPTNO, JOB 컬럼의 값을 SMITH사원의 DEPTNO, JOB 컬럼으로 동일하게 변경
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

UPDATE emp SET deptno = (SELECT deptno
                         FROM emp
                         WHERE ename = 'SMITH')
               ,job = (SELECT job
                         FROM emp
                         WHERE ename = 'SMITH')
WHERE empno = 9000;

SELECT *
FROM emp
WHERE ename IN ('brown', 'SMITH');


3. DELETE : 테이블에 존재하는 데이터를 삭제(행 전체를 삭제)
***** emp테이블에서 9000번 사번의 deptno 컬럼을 지우고 싶을 때(NULL) ??
    ==> deptno 컬럼을 NULL 업데이트 한다

DELETE [FROM] 테이블명
[WHERE ....]

emp테이블에서 9000번 사번의 데이터(행)를 완전히 삭제
DELETE emp
WHERE empno = 9000;

SELECT *
FROM emp;

UPDATE, DELETE절을 실행하기 전에
WHERE절에 기술한 조건으로 SELECT를 먼저 실행하여, 변경, 삭제되는 행을 눈으로 확인 해보자

DELETE emp
WHERE empno = 7369;

SELECT *
FROM emp
WHERE empno = 7369;

DELETE emp;

SELECT *
FROM emp;

ROLLBACK;

고객관리 시스템 - 많은 사용자 : 여사님 -비밀번호 까먹음 ==> 한달에 한번씩 주민번호 뒷자리로 변경
                              영업점 -주사용자
                              
UPDATE 사용자 SET 비밀번호 = 주민번호뒷자리;
COMMIT;

SELECT *
FROM 사용자
WHERE 사용자 구분='영업점';

새로운 트랜잭션
ROLLBACK;


DML 구문 실행시
DBMS는 복구를 위해 로그를 남긴다
즉 데이터 변경 작업  + alpah의 작업량이 필요

하지만 개발 환경에서는 데이터를 복구할 필요가 없기 때문에
삭제 속도를 빠르게 하는것이 개발 효율성에서 좋음.

로그없이 테이블의 모든 데이터를 삭제 하는 방법 : TRUNCATE TABLE 테이블명;

DELETE emp;
TRUNCATE TABLE emp;


SELECT *
FROM fastfood a, fastfood b, fastfood c, fastfood d
WHERE a.gb = b.gb
  AND b.gb = c.gb
  AND c.gb = d.gb;