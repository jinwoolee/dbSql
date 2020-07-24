계층쿼리
1. CONNECT BY LEVEL <, <= 정수
   : 시작행, 연결될 다음 행과의 조건이 없음
     ==> CROSS JOIN과 유사
2. START WITH, CONNECT BY : 일반적인 계층 쿼리
                            시작 행 지칭, 연결될 다음 행과의 조건을 기술
                            
CREATE TABLE imsi(
  t VARCHAR2(2)
);
INSERT INTO imsi VALUES ('a');
INSERT INTO imsi VALUES ('b');
COMMIT;

LEVEL의 시작 : 1

SELECT t, LEVEL, LTRIM(SYS_CONNECT_BY_PATH(t, '-'), '-')
FROM imsi
CONNECT BY LEVEL <= 3;

SELECT DUMMY, LEVEL
FROM dual
CONNECT BY LEVEL <= 10;
X-X-X-X-X-X

X
X
X
X
X
X


SELECT *
FROM dept
CONNECT BY LEVEL <= 2;

LAG(col) : 파티션별 이전 행의 특정 컬럼 값을 가져오는 함수
LEAD(col) : 파티션별 이후 행의 특정 컬럼 값을 가져오는 함수

전체 사원의 급여 순위가 자신보다 1단계 낮은 사람의 급여값을 5번 째로 컬럼으로
생성 ( 단, 급여가 같을 경우 입사일자가 빠른사람이 우선순위가 높다)
SELECT empno, ename, hiredate, sal
FROM emp
ORDER BY sal DESC, hiredate;

SELECT empno, ename, hiredate, sal, 
       LEAD(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal,
       LAG(sal) OVER (ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

ana6]
SELECT empno, ename, hiredate, job, sal, 
       LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;


ana5_1]
SELECT a.*, b.sal
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename, hiredate, sal
         FROM emp
         ORDER BY sal DESC, hiredate) a ) a,
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename, hiredate, sal
         FROM emp
         ORDER BY sal DESC, hiredate) a ) b
WHERE a.rn - 1 = b.rn(+)
ORDER BY a.sal DESC, a.hiredate;
        


WINDOWING : 파티션 내의 행들을 세부적으로 선별하는 범위를 기술
UNBOUNDED PRECEDING : 현재 행을 기준으로 선행(이전)하는 모든 행들
CURRENT ROW : 현재 행
UNBOUNDED FOLLOWING : 현재행을 기준으로 이후 모든 행들

SELECT empno, ename, sal
FROM emp
ORDER BY sal;

WINDOWING 기본 설정값이 존재 : RANGE UNBOUNDED PRECEDING
                             RANGE UNBOUNDED PRECEDING AND CURRENT ROW

SELECT empno, ename, sal, 
       /*SUM(sal) OVER 
       (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum,*/
 SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum2
FROM emp;

ana7]
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno
                      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;


SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_sum,
       SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,
       SUM(sal) OVER (ORDER BY sal) c_sum
FROM emp;


모델링 과정 (요구사항 파악 이후)
[개념모델] -   ==> (논리모델 - 물리모델)
 논리 모델의 요약판
 
논리 모델 : 시스템에서 필요로 하는 엔터티(테이블), 엔터티의 속성, 엔터티간의 관계를 기술
           데이터가 어떻게 저장될지는 관심사항이 아니다 ==> 물리 모델에서 고려할 사항
           논리 모델에서는 데이터의 전반적인 큰 틀을 설계
물리 모델 : 논리 모델을 갖고 해당시스템이 사용할 데이터베이스를 고려하여 최적화된 
           테이블, 컬럼, 제약조건을 설계하는 단계
           
논리 모델               :   물리 모델           
엔터티(entity) type          테이블
속성(attribute)               컬럼
식별자                  :      키    ==> 행들을 구분할 수 있는 유일한 값
관계(relation)          :     제약조건
관계 차수: 1-N, 1-1, N-N==> 1:N으로 변경할 대상
          수직바, 까마귀발
관계 옵션 : mandatory(필수), optional(옵션) O표기



요구사항(요구사항 기술서, 장표, 인터뷰)에서 명사 ==> 엔터티 or 속성일 확률이 높음           

명명규칙
엔터티 : 단수 명사
        서술식 표현은 잘못된 방법

