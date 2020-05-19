SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job)

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY CUBE (deptno, job)

서브그룹 생성 방식
ROLLUP : 뒤에서(오른쪽에서) 하나씩 지워가면서 서브그룹을 생성
         ==> (deptno, job), (deptno), (싹)
CUBE : 가능한 모든 조합
GROUPING SETS : 개발자가 서브그룹 기준을 직접 기술


GROUP BY (deptno, job)
UNION ALL
GROUP BY (deptno)
UNION ALL
전체....


sub_a1]
SELECT *
FROM dept_test;

sub_a2]
DROP TABLE dept_test;

SELECT *
FROM dept;

DELETE DEPT
WHERE deptno NOT IN (10, 20, 30, 40);

COMMIT;

CREATE TABLE dept_test AS
SELECT *
FROM dept;


SELECT *
FROM dept_test;


DELETE dept_test
WHERE NOT EXISTS ( SELECT 'X'
                   FROM emp
                   WHERE emp.deptno = dept_test.deptno);

SELECT *
FROM dept_test
WHERE NOT EXISTS ( SELECT 'X'
                   FROM emp
                   WHERE emp.deptno = dept_test.deptno);
               
SELECT *
FROM emp
WHERE deptno=40;

sub_a3]
SELECT *
FROM emp_test;

UPDATE emp_test SET sal = sal + 200
WHERE sal < (해당 직원이 속한 부서의 급여평균을 구하는 SQL);

SELECT *
FROM emp_test;

UPDATE emp_test a SET sal = sal + 200
WHERE sal < (SELECT AVG(sal)
             FROM emp_test b
             WHERE 20 = b.deptno
             GROUP BY deptno);

SELECT *
FROM emp_test 
WHERE sal < (SELECT AVG(sal)
             FROM emp_test b
             WHERE 20 = b.deptno
             GROUP BY deptno);

공식용어는 아니지만, 검색-도서에 자주 나오는 표현
서브쿼리의 사용된 방법
1. 확인자 : 상호연관 서브쿼리 (EXISTS)
           ==> 메인 쿼리 부터 실행 ==> 서브 쿼리 실행
2. 공급자 : 서브쿼리가 먼저 실행되서 메인쿼리에 값을 공급 해주는 역할

13건 : 매니저가 존재하는 직원을 조회
SELECT *
FROM emp
WHERE mgr IN (SELECT empno
                FROM emp);

SELECT *
FROM emp
WHERE mgr IN (7369, 7499, 7521....);

부서별 급여평균이 전체 급여평균보다 큰 부서의 부서번호, 부서별 급여평균 구하기

부서별 평균 급여 (소수점 둘째 자리까지 결과 만들기)
SELECT deptno, ROUND(AVG(sal), 2) 
FROM emp
GROUP BY deptno;

전체 급여 평균
SELECT ROUND(AVG(sal), 2) 
FROM emp;

일반적인 서브쿼리 형태
SELECT deptno, ROUND(AVG(sal), 2) 
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT ROUND(AVG(sal), 2) 
                             FROM emp);

WITH 절 : SQL에서 반복적으로 나오는 QUERY BLOCK(SUBQUERY)을 별도로 선언하여
          SQL 실행시 한번만 메모리에 로딩을 하고 반복적으로 사용할 때 메모리 공간의 데이터를
          활용하여 속도 개선을 할 수 있는 KEYWORD
          단, 하나의 SQL에서 반복적인 SQL 블럭이 나오는 것은 잘못 작성한 SQL일 가능성이 높기 때문에
          다른 형태로 변경할 수 있는지를 검토 해보는 것을 추천.
          
WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal), 2) 
      FROM emp
)                            
SELECT deptno, ROUND(AVG(sal), 2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT *
                             FROM emp_avg_sal) ;                             
                             
WITH t AS
(
SELECT '약A' gb, '2020-05-01' dt, 2 cnt FROM dual
UNION ALL SELECT '약B', '2020-05-05', 3 FROM dual
UNION ALL SELECT '약C', '2020-05-07', 2 FROM dual
)
SELECT COUNT(DISTINCT TO_DATE(dt, 'yyyy-mm-dd') + lv - 1) dt_cnt
  FROM t
     , (SELECT LEVEL lv FROM dual CONNECT BY LEVEL <= 99)
 WHERE lv <= cnt
;

계층쿼리
CONNECT BY LEVEL : 행을 반복하고 싶은 수만큼 복제를 해주는 기능
위치 : FROM(WHERE)절 다음에 기술
DUAL 테이블과 많이 사용

테이블에 행이 한건, 메모리에서 복제
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

위의 쿼리 말고도 이미 배운 KEYWORD를 이용하여 작성 가능
5행 이상이 존재하는 테이블을 갖고 행을 제한
만약에 우리가 복제할 데이터가 10000건이면은 10000건에 대한 DISK I/O가 발생
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;


1. 우리에게 주어진 문자열 년월 : 202005
   주어진 년월의 일수를 구하여 일수만큼 행을 생성 ==> 31
   
달력의 컬럼은 7개 - 컬럼의 기준은 요일 : 특정일자는 하나의 요일에 포함   
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt, 7개 컬럼을 추가로 생성
       일요일이면 dt 컬럼, 월요일이면 dt컬럼, 화요일이면 dt 컬럼.....토요일 이면 dt 컬럼
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD');

아래 방식으로 SQL을 작성해도 쿼리를 완성하는게 가능하나
가독성 측면에서 너무 복잡하여 인라인뷰를 이용하여 쿼리를 좀더 단순하게 만든다
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt, 
       DECODE( TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D'), '1', TO_DATE('202005', 'YYYYMM') + (LEVEL-1)) sun,
       DECODE( TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D'), '2', TO_DATE('202005', 'YYYYMM') + (LEVEL-1)) mon
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD');


컬럼을 간소화 하여 표현
TO_DATE('202005', 'YYYYMM') + (LEVEL-1) ==> dt

SELECT dt, dt가 월요일이면 dt, dt가 화요일이면 dt......7개의 컬럼중에 딱 하나의 컬럼에만 dt 값이 표현 된다
FROM
(SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD'));


SELECT DECODE(d, 1, iw+1, iw),
           MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, 
           MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wed, 
           MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri,
           MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt, 
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') )
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);



SELECT Min(Decode(d, 1, dt)) SUN, Min(Decode(d, 2, dt)) MON, 
       Min(Decode(d, 3, dt)) TUE, Min(Decode(d, 4, dt)) WED, 
       Min(Decode(d, 5, dt)) THU, Min(Decode(d, 6, dt)) FRI, 
       Min(Decode(d, 7, dt)) SAT 
FROM   (SELECT To_date(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ) dt, 
               To_char(To_date(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ), 'd') d, 
               To_date(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ) -
               To_char( To_date(:YYYYMM, 'YYYYMM') + ( LEVEL - 1 ), 'd') + 1 f_sun 
        FROM   dual 
        CONNECT BY LEVEL <= To_char(Last_day(To_date(:YYYYMM, 'YYYYMM')), 'DD')) 
GROUP  BY f_sun 
ORDER  BY f_sun; 



create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT *
FROM sales;