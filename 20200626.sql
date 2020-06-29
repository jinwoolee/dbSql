숫자 : 4칙 연산
날짜 : +, -  날짜 +- 정수 날짜에 정수만 과거나, 미래 날짜 값을 연산의 결과로 리턴
문자 : +, -연산자를 제공하지 않음, 결합 연산자 : 피연산자1 || 피연자2 , 
                                            CONCAT(문자열1, 문자열2) : O
                                            CONCAT(문자열1, 문자열2, 문자열3) : X


SELECT empno, ename, sal, sal + 500, 500
FROM emp;

NULL : 아직 모르는 값, 아직 정해지지 않은 값
      1. NULL과 숫자타입 0은 다르다
      2. NULL과 문자타입 ''은 다르다
      3. NULL값을 포함한 연산의 결과는 NULL : 필요한 경우 NULL값을 다른값으로 치환
      
ALIAS : 별칭, 컬럼 혹은 expression에 다른 이름을 부여
        컬럼 | expression [AS] 별칭명
        별칭을 작성할 때 주의점
        1. 공백이 들어가면 안됨
           ==>  alias를 더블 쿼테이션으로 묶으면 가능

리터럴 : 값 그 자체
리터럴 표기법 : 리터럴을 표기하는 방법 ==> 언어마다 다르기 때문
test 라는 문자열(리터럴)을 표기하는 벙법
java : String s = "test";
SQL : SELECT 'test' .....


WHERE : 테이블에서 조회할 행의 조건을 기술
        WHERE 절에 기술한 조건을 만족하는 행만 조회가 된다

SELECT *
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 30;

WHERE 절에서 사용가능한 연산자 : =, != <>, >=, <=, >, <

      BETWEEN AND 값이 특정 범위에 포함되는지 ==> >=, <=를 사용하여 표현 가능
      IN : 특정 값이 나열된 리스트에 포함되는지 검사 ==> OR연산자로 대체
      
WHERE 1=1      
WHERE 1=2
WHERE 10 IN (10, 30)

WHERE3]
SQL에서는 키워드는 대소문자를 가리지 않는다
데이터는 대소문자를 가린다

SELECT userid 아이디, usernm 이름, alias AS 별명
FROM users
WHERE userid IN ('BROWN', 'cony', 'sally');


WHERE 절에서 사용 가능한 연산자 : LIKE
사용용도 : 문자의 일부분으로 검색을 하고 싶을 때 사용
          ex: ename 컬럼의 값이 S로 시작하는 사원들을 조회
사용방법 : 컬럼 LIKE '패턴문자열'
마스킹 문자열 : 1.% : 문자가 없거나, 어떤 문자든 여러개의 문자열
                    'S%' : S로 시작하는 모든 문자열을
                           S, SS, SMITH
              2._  : 어떤 문자든 딱 하나의 문자를 의미
                    'S_' : S로 시작하고 두번째 문자가 어떤 문자든 하나의 문자가 오는 2자리 문자열
                    'S____' : S로 시작하고 문자열의 길이가 5글자인 문자열

emp테이블에서 ename 컬럼의 값이 S로 시작하는 사원들만 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

WHERE4]
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

b001 : 이쁜이
UPDATE member set mem_name= '쁜이'
WHERE mem_id = 'b001';


c001	신용환 ==> 신이환
UPDATE member SET mem_name = '신이환'
WHERE mem_id = 'c001';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%'


NULL 비교 : = 연산자로 비교 불가 ==> IS
NULL을 = 비교하여 조회


comm 컬럼의 값이 null인 사원들만 조회
SELECT empno, ename, comm
FROM emp
WHERE comm = NULL;


NULL값에 대한 비교는 =이 아니라 IS 연산자를 사용 한다
SELECT empno, ename, comm
FROM emp
WHERE comm IS NULL;

WHERE6]
emp 테이블에서 comm 값이 NULL이 아닌 데이터를 조회
AND, OR, NOT
SELECT empno, ename, comm
FROM emp
WHERE comm IS NOT NULL;

논리연산자 : AND, OR, NOT
AND : 참 거짓 판단식1 AND 참 거짓 판단식2 ==> 식 두개를 동시에 만족하는 행만 참
      일반적으로 AND 조건이 많이 붙으면 조회되는 행의 수가 줄어든다
      
OR : 참 거짓 판단식1 OR 참 거짓 판단식2 ==> 식 두개 중에 하나라도 만족하면 참

NOT : 조건을 반대로 해석하는 부정형 연산
     NOT IN
     IS NOT NULL
 
emp테이블에서 mgr 컬럼 값이 7698이면서 sal 컬럼의 값이 1000보다 큰 사원 조회
2가지 조건을 동시에 만족하는 사원 리스트
SELECT *
FROM emp
WHERE mgr = 7698 
  AND sal > 1000;


WHERE7]
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
  








mgr 값이 7698이거나 (5명)
sal 값이 1000보다 크거(12명) 나 두개의 조건을 하나라도 만족하는 행을 조회
SELECT *
FROM emp
WHERE mgr = 7698 
   OR sal > 1000;


emp 테이블에서 mgr가 7698, 7839가 아닌 사원들을 조회


7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);



mgr 사번이 7698이 아니고, 7839가 아니고, NULL이 아닌 직원들을 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);

mgr가 (7698, 7839, NULL)에 포함된다
mgr IN (7698, 7839, NULL); ==> mgr = 7698 OR mgr = 7839 OR mgr = NULL
mgr NOT IN (7698, 7839, NULL); ==> mgr != 7698 AND mgr != 7839 AND mgr != NULL;

SELECT *
FROM emp
WHERE mgr != 7698 AND mgr != 7839 AND mgr != NULL;

SELECT *
FROM emp
WHERE mgr = 7698 OR mgr = 7839 OR mgr = NULL;

mgr IN (7698, 7839) ==> OR
mgr = 7698 OR mgr = 7839

mgr NOT IN (7698, 7839)
!(mgr = 7698 OR mgr = 7839) ==> (mgr != 7698 AND mgr != 7839) 
**** mgr 컬럼에 NULL값이 있을 경우 비교 연산으로 NULL 비교가 불가하기 때문에
     NULL을 갖는 행은 무시가 된다 

SELECT *
FROM emp
WHERE mgr != 7698 AND mgr != 7839;

WHERE8]
1. 부서번호가 10번이 아니고
2. 입사일자가 1981년 6월 1일 이후인 사원
SELECT *
FROM emp
WHERE deptno != 10
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

WHERE9]  
SELECT *
FROM emp
WHERE deptno NOT IN ( 10 )
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');  

WHERE10]  
SELECT *
FROM emp
WHERE deptno IN ( 20, 30 )
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');  
  
  
WHERE11]
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


WHERE12]
emp 테이블에서 job이 SALESMAN 이거나 사원번호(empno)가 78로 시작하는 직원의 정보 조회
  
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%';  --형변환 : 명시적, 묵시적

WHERE13]
empno : 7800~7899
781, 78;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno BETWEEN 7800 AND 7899
   OR empno BETWEEN 780 AND 789
   OR empno = 78;

연산자 우선순위
+, -, *, /
*, /  > +, -

3 + 5 * 7 = 38
(3 + 5) * 7 = 56


WHERE14]
1.job이 SALESMAN 이거나
2.사원번호 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 사원

SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%' AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
   
   SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR ((empno BETWEEN 7800 AND 7899 OR empno BETWEEN 780 AND 789 OR empno = 78)
        AND hiredate >= TO_DATE('19810601', 'YYYYMMDD'));

SQL 작성순서(꼭 그렇지는 않다)           ORACLE에서 실행하는 순서
1                            SELECT         3
2                            FROM           1
3                            WHERE          2
4                            ORDER BY       4

정렬
RDBMS 집합적인 사상을 따른다
집합에는 순서가 없다 {1, 3, 5} == {3, 5, 1}
집합에는 중복이 없다 {1, 3, 5, 1} == {3, 5, 1}

정렬 방법 : ORDER BY 절을 통해 정렬 기준 컬럼을 명시
           컬럼뒤에 [ASC | DESC]을 기술하여 오름차순, 내림차순을 지정할 수 있다

1. ORDER BY 컬럼
2. ORDER BY 별칭
3. ORDER BY SELECT 절에 나열된 컬럼의 인덱스 번호

SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
ORDER BY ename DESC;


별칭으로 ORDER BY 
SELECT empno, ename, sal, sal*12 salary
FROM emp
ORDER BY salary;

SELECT 절에 기술된 컬럼순서(인덱스)로 정렬
SELECT empno, ename, sal, sal*12 salary
FROM emp
ORDER BY 4;


orderby1]
SELECT *
FROM dept
ORDER BY dname ASC;

SELECT *
FROM dept
ORDER BY loc DESC;

orderby2]
1. 상여가 있는 사람만 조회, 단 상여가 0이면 상여가 없는 것으로 간주

SELECT *
FROM emp
WHERE comm > 0
ORDER BY comm DESC, empno DESC;


