--날짜관련 함수
--ROUND, TRUNC
--(MOTNHS_BETWEEN) ADD_MONTHS, NEXT_DAY
--LAST_DAY : 해당 날짜가 속한 월의 마지막 일자(DATE)

--월 : 1, 3, 5, 7, 8, 10, 12 : 31일
--  : 2 -윤년 여부 28, 29
--  : 4, 6, 9, 11 : 30일

SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

--fn3
--where14
--입사일자가 1981년6월 1일 이후
SELECT *
FROM emp
WHERE hiredate > TO_DATE('19810601', 'YYYYMMDD');

-- '201912' --> date 타입으로 변경하기
-- 해당 날짜의 마지막날짜로 이동
-- 일자 필드만 추출하기
--DATE --> 일자컬럼(DD)만 추출
--DATE --> 문자열(DD)
--TO_CHAR(DATE, '포맷')
--DATE : LAST_DAY(TO_DATE('201912', 'YYYYMM'))
--포맷 : 'DD'
SELECT :yyyymm param, 
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') dt
FROM dual;

--SYSDATE를 YYYY/MM/DD 포맷의 문자열로 변경 (DATE -> CHAR)
--'2019/11/26' 문자열 --> DATE
-- 문자열 : TO_CHAR(SYSDATE, 'YYYY/MM/DD') - 2019/11/26
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD'),

       -- YYYY-MM-DD HH24:MI:SS 문자열로 변경
       TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM/DD'), 'YYYY/MM/DD'), 
              'YYYY-MM-DD HH24:MI:SS')
FROM dual;

--EMPNO    NOT NULL NUMBER(4)  
--HIREDATE          DATE  
DESC emp;    
    
--empno가 7369인 직원 정보 조회 하기

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';
    
SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';
    
SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')
;


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69';  -- 69 ->숫자로 변경
    
SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369);
   

--
SELECT *
FROM emp
WHERE hiredate > = TO_DATE('1981/06/01', 'YYYY/MM/DD');

--DATE타입의 묵시적 형변환은 사용을 권하지 않음
--YY -> 19
--RR --> 50  / 19, 20
SELECT *
FROM emp
WHERE hiredate > = TO_DATE('1981/06/01', 'YYYY/MM/DD');  
--WHERE hiredate > = '81/06/01';  

SELECT TO_DATE('50/05/05', 'RR/MM/DD'),
       TO_DATE('49/05/05', 'RR/MM/DD'),
       TO_DATE('50/05/05', 'YY/MM/DD'),
       TO_DATE('49/05/05', 'YY/MM/DD')
FROM dual;

--숫자 --> 문자열
--문자열 --> 숫자
--숫자 : 1000000  --> 1,000,000.00 (한국)
--숫자 : 1000000  --> 1.000.000,00 (독일)
--날짜 포맷 : YYYY, MM, DD, HH24, MI, SS
--숫자 포맷 : 숫자 표현 : 9, 자리맞춤을 위한 0표시 : 0, 화폐단위 : L
--           1000자리 구분 : , 소수점 : .
--숫자 -> 문자열  TO_CHAR(숫자, '포맷')
--숫자 포맷의 길어질경우 숫자 자리수를 충분히 표현
SELECT empno, ename, sal, TO_CHAR(sal, 'L009,999') fm_sal
FROM emp;
   
SELECT TO_CHAR(10000000000, '999,999,999,999,999')
FROM dual;

--NULL 처리 함수 : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2) : 함수 인자 두개
--expr1이 NULL 이면 expr2를 반환
--expr1이 NULL이 아니면 expr1을 반환
SELECT empno, ename, comm, NVL(comm, -1) nvl_comm
FROM emp;

--NVL2(expr1, expr2, expr3)
--expr1 IS NOT NULL  expr2리턴
--expr1 IS NULL  expr3리턴
SELECT empno, ename, comm, NVL2(comm, 1000, -500) nvl2_comm,
       NVL2(comm, comm, -500) nvl_comm --NVL과 동일한 결과
FROM emp;

--NULLIF(expr1, expr2)
--expr1 = expr2  NULL을 리턴
--expr1 != expr2 expr1을 리턴
--comm이 NULL일때 comm+500 : NULL
--   NULLIF(NULL, NULL) : NULL
--comm이 NULL이 아닐때 comm+500 : comm+500
--   NULLIF(comm, comm+500) : comm
SELECT empno, ename, comm, NULLIF(comm, comm+500) nullif_comm
FROM emp;

--COALESCE(expr1, expr2, expr3.....)
--인자중에 첫번째로 등장하는 NULL이 아닌 exprN을 리턴
--expr1 IS NOT NULL epxr1을 리턴하고
--expr1 IS NULL COALESCE(expr2, expr3.....)
SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;


--fn4
SELECT empno, ename, mgr, 
       NVL(mgr, 9999) mgr_n,
       NVL2(mgr, mgr, 9999) mgr_n_2,
       COALESCE(mgr, 9999) mgr_n_3
FROM emp;


--fn5
SELECT userid, usernm, reg_dt, 
       NVL(reg_dt, sysdate) nvl_reg_dt,
       COALESCE(reg_dt, sysdate) n_reg_dt
FROM users
WHERE userid NOT IN ('brown');

--condition
--case
--emp.job 컬럼을 기준으로
-- 'SALESMAN'이면 sal * 1.05를 적용한 값 리턴
-- 'MANAGER'이면 sal * 1.10를 적용한 값 리턴
-- 'PRESIDENT'이면 sal * 1.20를 적용한 값 리턴
-- 위 3가지 직군이 아닐 경우  sal 리턴
-- empno, ename, job, sal, 요율 적용한 급여 AS bonus
SELECT empno, ename, job, sal,
       CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
       END bonus,
       comm,
       
       --NULL처리 함수 사용하지 않고  CASE 절을 이용하여
       --comm이 NULL일 경우 -10을 리턴하도록 구성
       CASE 
            WHEN comm IS NULL THEN -10
            ELSE comm
       END case_null
FROM emp;

--DECODE
SELECT empno, ename, job, sal, 
       DECODE(job, 'SALESMAN', sal * 1.05,
                   'MANGER',   sal * 1.10,
                   'PRESIDENT',sal * 1.20,
                               sal) bonus
FROM emp;

