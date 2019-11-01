--복습
--WHERE 
--연산자
-- 비교 : =, !=, <>, >=, >, <=, <
-- BETWEEN start AND end
-- IN (set)
-- LIKE 'S%' ( % : 다수의 문자열과 매칭, _ : 정확히 한글자 매칭)
-- IS NULL ( != NULL )
-- AND, OR, NOT 

--emp 테이블에서 입사일자가 1981년 6월 1일부터 1986년 12월 31일 사이에 있는
--직원 정보조회
--BETWEEN AND
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981/06/01', 'YYYY/MM/DD')
                   AND TO_DATE('1986/12/31', 'YYYY/MM/DD');
-- >=, <=
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD')
  AND hiredate <= TO_DATE('1986/12/31', 'YYYY/MM/DD');

--emp 테이블에서 관리자(mgr)가 있는 직원만 조회
SELECT *
FROM emp
WHERE mgr IS NULL;
--WHERE mgr != NULL;


--where12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%';
   
--where13
-- empno는 정수 4자리까지 허용
-- empno : 7800~7899
--         780~789
--         78
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno BETWEEN 7800 AND 7899
   OR empno BETWEEN 780 AND 789
   OR empno =78;
   
--where14
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR (    empno like '78%' 
       AND hiredate >= TO_DATE('19810601', 'YYYYMMDD'));



--order by 컬럼명 | 별칭 | 컬럼인덱스 [ASC | DESC]
--order by 구문은 WHERE절 다음에 기술
--WHERE 절이 없을 경우 FROM절 다음에 기술
--emp테이블을 ename 기준으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY ename ASC;

--ASC :default
--ASC를 안붙여도 위 쿼리와 동일한
SELECT *
FROM emp
ORDER BY ename; -- ASC

--이름(ename)을 기준으로 내림차순
SELECT *
FROM emp
ORDER BY ename desc;

--job을 기준으로 내림차순으로 정렬, 만약 job이 같을경우
--사번(empno)으로 올림차순 정렬
--SALESMASN - PRESIDENT -MANAGER - CLERK - ANALYST

SELECT *
FROM emp
ORDER BY job DESC, empno asc;

--별칭으로 정렬하기
--사원 번호(empno), 사원명(ename), 연봉(sal * 12) as year_sal
--year_sal 별칭으로 오름차순 정렬
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT절 컬럼 순서 인덱스로 정렬
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY 2;



