SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE job = 'SALESMAN' 
    OR empno BETWEEN 7800 AND 7899
    OR empno BETWEEN 780 AND 789
    OR empno = 78;   
    
where13
emp 테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회하세요
(LIKE 연산자 사용하지 마세요)

SELECT *
FROM emp
WHERE job ='SALESMAN' 
OR empno ='7839' OR empno ='7844' OR empno ='7876' ; 



논리연산 (AND,OR 실습 WHERE13) 
emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
12번문제를 LIKE연산자 사용하지 않고 풀기. 

78
781
789

SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR empno between 7800 and 7899;
    
    
연산자 우선순위 ( AND가 OR 보다 우선순위가 높다 )
==> 헷갈리면 ()를 사용하여 우선순위를 조정하자

SELECT *
FROM emp
WHERE ename = 'SMITH'  OR  (ename = 'ALLEN'  AND  job = 'SALESMAN');
             1          +       2            *        3
;
==> 직원의 이름이 ALLEN 이면서 job이 SALESMAN 이거나
    직원의 이름이 SMITH인 직원 정보를 조회

직원의 이름이 ALLEN 이거나 SMITH 이면서
job이 SALESMAN 인 직원을 조회

SELECT *
FROM emp
WHERE (ename = 'SMITH'  OR  ename = 'ALLEN')  AND  job = 'SALESMAN';

WHERE14]
1. job이 SALESMAN 이거나
2. 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인

SELECT *
FROM emp;
WHERE job = 'SALESMAN' OR empno LIKE '78%' AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
    

데이터 정렬이 필요한 이유?
1. table 객체는 순서를 보장하지 않는다
   ==> 오늘 실행한 쿼리를 내일 실행할 경우 동일한 순서로 조회가 되지 않을 수도 있다
   
2. 현실세계에서는 정렬된 데이터가 필요한 경우가 있다
   ==> 게시판의 게시글은 보편적으로 가장 최신글이 처음에나오고, 가장 오래된 글이 맨 밑에 있다

SQL 에서 정렬 : ORDER BY ==> SELECT -> FROM -> [WHERE] -> ORDER BY
정렬 방법 : ORDER BY 컬럼명 | 컬럼인덱스(순서) | 별칭 [정렬순서]
정렬 순서 : 기본 ASC(오름차순), DESC(내림차순)

SELECT *
FROM emp
ORDER BY job DESC, sal ASC, ename;

MILLER
JAMES
SMITH
ADAMS
A-> B -> C -> [D] -> Z
1 -> 2-> .... -> 100 : 오름차순 (ASC => DEFAULT)
100 -> 99 .... -> 1  : 내림차순 (DESC => 명시)

정렬 : 컬럼명이 아니라 select 절의 컬럼 순서(index)
SELECT ename, empno, job, mgr AS m
FROM emp
ORDER BY m;


orderby1]
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

orderby2]
SELECT *
FROM emp
WHERE comm IS NOT NULL
  AND comm != 0;

SELECT *
FROM emp
WHERE comm > 0
ORDER BY comm DESC, empno DESC;


orderby3]
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

orderby4]
SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 30;

SELECT *
FROM emp
WHERE deptno IN (10, 30)
  AND sal > 1500
ORDER BY ename DESC;



페이징 처리 : 전체 데이터를 조회하는게 아니라 페이지 사이즈가 정해졌을 때 원하는 페이지의 데이터만 가져오는 방법
( 1. 400건을 다 조회하고 필요한 20건만 사용하는 방법 --> 전체조회 (400)
  2. 400건의 데이터중 원하는 페이지의 20건만 조회 --> 페이징 처리(20) )
페이징 처리(게시글) ==> 정렬의 기준이 뭔데??? (일반적으로는 게시글의 작성일시 역순)
페이징 처리시 고려할 변수 : 페이지 번호, 페이지 사이즈

ROWNUM : 행번호를 부여하는 특수 키워드(오라클에서만 제공)
   * 제약사항
     ROWNUM은 WHERE 절에서도 사용 가능하다
      단 ROWNUM의 사용을 1부터 사용하는 경우에만 사용 가능
      WHERE ROWNUM BETWEEN 1 AND 5 ==> O
      WHERE ROWNUM BETWEEN 6 AND 10 ==> X
      WHERE ROWNUM = 1; ==> O
      WHERE ROWNUM = 2; ==> X
      WHERE ROWNUM < 10; ==> O
      WHERE ROWNUM > 10; ==> X
    
    SQL 절은 다음의 순서로 실행된다
    FROM => WHERE => SELECT => ORDER BY
    ORDER BY와 ROWNUM을 동시에 사용하면 정렬된 기준으로 ROWNUM이 부여되지 않는다
    (SELECT 절이 먼지 실행되므로 ROWNUM이 부여된 상태에서 ORDER BY 절에 의해 정렬이 된다)
      
전체 데이터 : 14건
페이지사이즈 : 5건
1번째 페이지 : 1~5
2번째 페이지 : 6~10
3번째 페이지 : 11~15(14)
     
     
인라인 뷰
ALIAS

FROM => SELECT => ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;


SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

SELECT *
FROM
(SELECT ROWNUM rn, empno, ename
 FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename))
WHERE rn BETWEEN 11 AND 15;


SELECT *
FROM
(SELECT ROWNUM rn, empno, ename
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename))
WHERE rn BETWEEN (:page-1)*:pageSize + 1 AND :page*:pageSize;


pageSize : 5건
1 page : rn BETWEEN 1 AND 5 ;
2 page : rn BETWEEN 6 AND 10 ;
3 page : rn BETWEEN 11 AND 15 ;
n page : rn BETWEEN n*pageSize-4 AND n*pageSize ;
                    (n-1)*pageSize + 1
                    
rn BETWEEN (page-1)*pageSize + 1 AND page*pageSize ;                    
                    
n*pageSize-(pageSize -1)   
n*pageSize-pageSize + 1
(n-1)*pageSize + 1





SELECT ROWNUM, emp.*
FROM emp;

row_1~2]
SELECT *
FROM 
(SELECT ROWNUM rn, empno, ename
 FROM emp )
WHERE rn BETWEEN 11 AND 14;

row_3]

SELECT a.*
FROM 
(SELECT ROWNUM rn, empno, ename
 FROM 
(SELECT empno, ename
 FROM emp
 ORDER BY ename)) a
WHERE rn BETWEEN 11 AND 14 ;



SELECT ROWNUM rn, e.empno
FROM emp e, emp m, dept;




