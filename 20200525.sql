CREATE OR REPLACE PROCEDURE pro_3_dt2_table IS
    /*TYPE dt2_row IS RECORD (
        n NUMBER
    );*/
    
    TYPE dt2_table IS TABLE OF dt2%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt2_table dt2_table;
        
    sumValue NUMBER := 0 ;
    
BEGIN

    SELECT * BULK COLLECT INTO v_dt2_table
    FROM dt2
    ORDER BY n DESC;
    
    FOR i IN 1..v_dt2_table.COUNT-1 LOOP
        sumValue := sumValue + v_dt2_table(i).n - v_dt2_table(i+1).n;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( sumValue);
    DBMS_OUTPUT.PUT_LINE( sumValue / (v_dt2_table.COUNT-1));
END;
/
SET SERVEROUTPUT ON;

EXEC pro_3_dt2_table;

PL/SQL :호불호가 많이 갈림, 
        분명히 필요한 경우는 있음(로직이 복잡하고 대다수의 부분이 데이터와 관련되었을 때)
        
그렇지 않은 경우는 대부분 요구사항이 SQL로 해결이 가능

위 문제 경우 화면에 나타내고자 하는게 간격의 평균값 : 5
PL/SQL, SQL을 사용하든 5라는 값을 계산해 내면 목적을 달성.

SQL 문제를 풀어나가기
1] 분석함수
SELECT AVG(diff)
FROM
(SELECT n - LEAD(n) OVER (ORDER BY n DESC ) diff
 FROM dt2);
 
2] 조인

SELECT a.n, b.n
FROM dt2 a, dt2 b
WHERE b.rn = a.rn + 1;

SELECT AVG(a.n - b.n)
FROM
(SELECT ROWNUM rn, n
 FROM
    (SELECT n
     FROM dt2
     ORDER BY n DESC )) a, 
(SELECT ROWNUM rn, n
 FROM
    (SELECT n
     FROM dt2
     ORDER BY n DESC )) b
WHERE b.rn = a.rn + 1;

3]집계함수
SELECT (MAX(n) - MIN(n)) / (COUNT(*) - 1)
FROM dt2;
  

PRO4] cycle 테이블(애음요일)을 이용하여 daily(일실적) 테이블에 데이터를 생성 해주는 프로시져
여사님 한분이 관리하는 고객 2~300명
고객한명당 제품을 2~3개 정도 애음
일실적 (한달 20일이 영업일) 8000 ~ 12000건 정도의 데이터

cycle 테이블
cid, pid, day, cnt
1	100	 2	1    : 1번 고객이 100번 제품을 월요일날 1개 먹는다

sales 테이블
cid, pid, dt, cnt
1	100	 2020/05/04	  1    : 1번 고객이 100번 제품을 2020/05/04일(월요일) 1개 먹는다
1	100	 2020/05/11	  1    : 1번 고객이 100번 제품을 2020/05/04일(월요일) 1개 먹는다
1	100	 2020/05/18	  1    : 1번 고객이 100번 제품을 2020/05/04일(월요일) 1개 먹는다
1	100	 2020/05/25	  1    : 1번 고객이 100번 제품을 2020/05/04일(월요일) 1개 먹는다

SELECT *
FROM cycle;

SELECT *
FROM daily;


2020년 5월에 대한 날짜, 요일 정보를 담은 테이블 생성

'202005' ==> :yyyymm
SELECT TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') DT,
       TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD');

CREATE OR REPLACE PROCEDURE create_daily_sales (p_yyyymm IN VARCHAR2) IS
--    애음주기 커서
    CURSOR cycle_cur IS
        SELECT *
        FROM cycle;
        
--    달력 테이블을 담을 변수(여러개의 행, 행이 특정 테이블에 속하는 경우가 아님)
    TYPE cal_rec_type IS RECORD (
        dt VARCHAR2(8),
        d VARCHAR2(1)
    );
    
    TYPE cal_rec_tab_type IS TABLE OF cal_rec_type INDEX BY BINARY_INTEGER;
    cal_rec_tab cal_rec_tab_type;
BEGIN
    
    SELECT TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') DT,
           TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d
           BULK COLLECT INTO cal_rec_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')), 'DD');
    
    --기존 실행에 의해서 생성된 데이터는 삭제한다
    DELETE daily
    WHERE dt BETWEEN TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM'), 'YYYYMMDD') AND
                     TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')), 'YYYYMMDD');
    
--    커서를 루프를 돌면서(outter loop)
--    해당 고객의 애음요일정보와 일치하는 달력테이블(INNER LOOP)의 일자를 찾아서
--    일치할 경우 SALES 테이블에 저장
    
    FOR cycle_row IN cycle_cur LOOP
        FOR i IN 1..cal_rec_tab.COUNT LOOP
            --현재읽은 애음주기 요일과 달력의 요일이 같을 때
            IF cycle_row.day = cal_rec_tab(i).d THEN
                INSERT INTO daily VALUES (cycle_row.cid, 
                                          cycle_row.pid, 
                                          cal_rec_tab(i).dt, 
                                          cycle_row.cnt );
            END IF;
        END LOOP;
    END LOOP;  
    COMMIT;
END;
/


1 : 0.047 
10 : 0.47 
100 : 4.7 
1000 : 47 
1000 : 47 
INSERT INTO daily VALUES (1, 100, '20200801', 5);

EXEC create_daily_sales('202005');

SELECT *
FROM daily;

SELECT *
FROM cycle
WHERE CID = 1
  AND PID = 100; 월, 수, 금
  
SELECT *
FROM daily
WHERE CID = 1
  AND PID = 100;

TRUNCATE TABLE DAILY;

SELECT *
FROM daily;

one query
INSERT INTO daily
SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
    ( SELECT TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') DT,
           TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d
      FROM dual
      CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') ) cal
WHERE cycle.day = cal.d;




EXCEPTION

DECLARE
    v_ename emp.ename%TYPE;
BEGIN
    --행의결과는 여러건인데 변수는 스칼라 변수 ==> 테이블 타입의 변수로 변경해야 한다
    SELECT ename INTO v_ename
    FROM emp;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
END;
/


사용자 정의 예외 : 오라클에서 정의한 예외가 아니라 개발자가 직접 선언한 예외
java에서도 반드시 처리를 해야하는 예외를 잡아서 해당 회사나 개발자가 정의한 예외로 바꾸어서 처리할 수 있다
mybatis같은 ORM(Object Relation mapping) 프레임워크에서도 jdbc 프로그래밍에서 반드시 들어가야 하는
SQLException(checked exception)을 개발 편의를 위해 프레임워크에서 정의한 예외로 치환하여 사용한다


SELECT 결과가 없을 때 ==> NO_DATA_FOUND

아래 쿼리는 특정 직원을 조회하기 위한 쿼리
만약에 해당하는 데이터가 없을 때 NO_DATA_FOUND
                ==> NO_EMP 개발자 정의 예외로 치환하여 의미상으로 좀더 명확하게 표현
SELECT *
FROM emp
WHERE empno = :empno;


DECLARE
    --사용자 예외 선언
    NO_EMP EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
     BEGIN       
        SELECT ename INTO v_ename
        FROM emp
        WHERE empno = 9999;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            --NO_EMP예외로 치환하여 예외를 던진다
            RAISE NO_EMP;   -- throw new Exception();
     END;
EXCEPTION
    WHEN NO_EMP THEN
        DBMS_OUTPUT.PUT_LINE('NO_EMP');
END;
/



function : 리턴값이 있는 pl/sql 블럭
사원 번호를 입력받아 해당사원의 이름을 리턴하는 function : getEmpName 생성

CREATE OR REPLACE FUNCTION getEmpName(p_empno emp.empno%TYPE) RETURN VARCHAR2 IS
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    RETURN v_ename;
END;
/

SELECT getEmpName(7369)
FROM dual;

SELECT empno, ename, getEmpName(empno)
FROM emp;





function1]
CREATE OR REPLACE FUNCTION getDeptName(p_deptno dept.deptno%TYPE) RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    RETURN v_dname;
END;
/

SELECT getDeptName(10)
FROM dual;

SELECT deptno, dname, getDeptName(deptno)
FROM dept;



function2] 함수를 만들때 어떤 인자가 필요한지, 
           범용적으로 설계를 했을 때 어떤 현상이 발생하는지
SELECT deptcd, LPAD(' ', ( LEVEL - 1 ) * 4, ' ')  || deptnm deptnm 
SELECT deptcd, INDENT(LEVEL, ' ')  || deptnm deptnm 
FROM   dept_h 
START WITH p_deptcd IS NULL 
CONNECT BY PRIOR deptcd = p_deptcd; 

CREATE OR REPLACE FUNCTION INDENT (lv NUMBER, padString VARCHAR2) RETURN VARCHAR2 IS
    indent_string VARCHAR2(50) := '';
BEGIN
    SELECT LPAD(' ', ( lv - 1 ) * 4, padString) INTO indent_string
    FROM dual;
    
    RETURN indent_string;
END;
/

SELECT INDENT(5) || 'TEST'
FROM dual;




