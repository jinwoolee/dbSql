-- col IN (value1, value2...)
-- col의 값이 IN 연산자 안에 나열된 값중에 포함될 때 참으로 판정

--RDBMS - 집합개념
--1.집합에는 순서가 없다
-- {1, 5, 7}, {5, 1, 7}

--2.집합에는 중복이 없다
-- {1, 1, 5, 7}, {5, 1, 7}

SELECT *
FROM emp
WHERE deptno IN (10, 20);   --emp 테이블의 직원의 소속 부서가 10번 이거나 20번인
                            --    직원 정보만 조회
                            
--이거나 --> OR(또는)
--이고  --> AND(그리고)

-- IN --> OR
-- BETWEEN AND --> AND + 산술비교

SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 20;

--where3
DESC users;

SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid IN ('brown', 'sally', 'cony');


-- LIKE 연산자 : 문자열 매칭 연산
-- % : 여러 문자(문자가 없을 수도 있다)
-- _ : 하나의 문자

--emp테이블에서 사원이름(ename)이 S로 시작하는 사원 정보만 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--SMITH
--SCOTT
--첫글자는 S로 시작하고 4번째 글자는 T
--두번째, 세번째, 다섯번째 문자는 어떤 문자든 올 수 있다
SELECT *
FROM emp
WHERE ename LIKE 'S__T_';
WHERE ename LIKE 'S%T_'; -- 'STE', 'STTTT', 'STESTS'


--where4
--member 테이블에서 [신]씨 성을 가진 사람을 조회하세요
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

--where5
--member 테이블에서 이름에 [이] 글자가 포함되는 회원 정보 조회
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

--컬럼 값이 NULL인 데이터 찾기
--emp 테이블에 보면 MGR 컬럼이 NULL 데이터가 존재
SELECT *
FROM emp
WHERE MGR IS NULL;  --NULL값 확인에는 IS NULL 연산자를 사용
WHERE MGR = NULL;   --MGR 컬럼 값이 NULL인 사원 정보조회 (조회되지 않음)
WHERE MGR = 7698;   --MGR 컬럼 값이 7698인 사원 정보조회

--where6

UPDATE emp SET comm = 0 
WHERE empno=7844;

COMMIT;


SELECT *
FROM emp
WHERE comm IS NOT NULL;


--AND : 조건을 동시에 만족
--OR : 조건을 한개만 충족하면 만족
--emp 테이블에서 mgr가 7698 사번 이고(AND), 급여가 1000보다 큰 사람
SELECT *
FROM emp
WHERE mgr=7698    
AND sal > 1000;     

--emp 테이블에서 mgr가 7698 이거나(OR), 급여가 1000보다 큰 사람
SELECT *
FROM emp
WHERE mgr=7698
OR sal > 1000;

--emp테이블에서 관리자 사번이 7698, 7839가 아닌 직원 정보조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
OR mgr IS NULL;

DESC emp;

--where7
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD'); 


