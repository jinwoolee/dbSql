PL/SQL : Procedual Language / SQL
SQL 언어에 절차적 문법을 추가한 oracle의 언어
SQL은 집합적이지만 실생활에서 발생하는 요구사항을 처리 하기 위해서는
절차적 처리가 필요할 때가 있음
(복잡한 로직일때 : EX - 연말정산 계산)

PL/SQL 블록의 기본구조
DECLARE : 상수, 변수를 선언, 선언이 필요 없을 경우(생략가능)
          java와 다르게 지역변수를 선언할 수 없음
BEGIN : 로직을 서술하는 부분
EXCEPTION : 예외 발생시 예외 처리 기술(생략가능)
          
화면 출력기능을 활성화 하는 설정 ( System.out.println의 로그가 보이도록)
(oracle 접속후 최초 1회만 실행하면 접속종료시 까지 유지)         
SET SERVEROUTPUT ON;
    
간단한 PL/SQL 익명(이름이 없는) 블럭
dept테이블에서 10번 부서의 deptno, dname 두개의 컬럼 값을 조회해서
변수에 담아 화면 출력

java 변수선언 : 변수타입 변수명 = 10;
pl/sql 변수선언 : 변수명 변수타입 := 10;

DECLARE
    deptno NUMBER(2);
    dname VARCHAR2(14);
BEGIN
    SELECT deptno, dname INTO deptno, dname
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE('deptno : ' || deptno || ', dname : ' || dname);
END;
/
          
변수 참조 타입
 deptno NUMBER(2) ==> deptno dept.deptno%TYPE;
 테이블의 컬럼 타입 변경이 생겨도 pl/sql 코드는 수정할 필요가 없어진다
 ==> 유지보수가 편해진다

DECLARE
    deptno dept.deptno%TYPE;
    dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO deptno, dname
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE('deptno : ' || deptno || ', dname : ' || dname);
END;
/ 


printdept 라는 이름의 프로시져 생성
인자 : 없음
로직 : dept테이블에서 10번부서의 부서이름과, 부서 위치를 로그로 출력

view 와 비교
1. view 생성
2. SELECT *
   FROM 생성한뷰;
   
프로시져 절차
1. 프로시져 생성 (CREATE OR REPLACE ......)
2. 프로시져 실행 (EXEC 프로시져명)
   
CREATE OR REPLACE PROCEDURE printdept IS
    --선언부
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO dname, loc
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE('dname : ' || dname || ', loc : ' || loc);
END;
/

프로시져 실행 : exec 프로시져이름;

EXEC printdept;


printdept 프로시져를 수정
1. 인자를 받게끔 수정( X ==> 부서번호를 인자로 받는다)
2. 받은 인자에 해당하는 부서이름과, 위치 정보를 화면에 출력하도록 수정

JAVA 메소드 : public String 함수명(인자타입1 인자명1, 인자타입2 인자명2)

pl/sql 인자 선언 : 프로시져명(인자명1 IN 인자타입1, 인자명2 IN 인자타입2)
       인자명을 : p_ 접두어를 주로 사용
       변수명은 : v_ 접두어를 주로 사용  
       
CREATE OR REPLACE PROCEDURE printdept(p_deptno IN dept.deptno%TYPE) IS
    --선언부
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = p_deptno;
    DBMS_OUTPUT.PUT_LINE('dname : ' || v_dname || ', loc : ' || v_loc);
END;
/

EXEC printdept(20);



PRO_1]

CREATE OR REPLACE PROCEDURE printemp(p_empno IN emp.empno%TYPE) IS
    v_ename emp.ename%TYPE;
    v_dname dept.dname%TYPE;
BEGIN    
    SELECT ename, dname INTO v_ename, v_dname
    FROM emp NATURAL JOIN dept
    WHERE empno = p_empno;
    
    DBMS_OUTPUT.PUT_LINE('ename :' || v_ename|| ', dname : ' || v_dname);
END;
/
SELECT *
FROM emp;
EXEC printemp(7499);

SELECT *
FROM dept_test;

DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

--인자값을 이용하여 dept_test 테이블 업데이트
CREATE OR REPLACE PROCEDURE UPDATEDEPT_TEST (p_deptno IN dept.deptno%TYPE,
                                   p_dname IN dept.dname%TYPE,
                                   p_loc IN dept.loc%TYPE) IS                                 
BEGIN
    UPDATE dept_test SET dname = p_dname,
                         loc = p_loc
    WHERE deptno = p_deptno;
    COMMIT;
END;
/
EXECUTION

EXEC UPDATEDEPT_TEST(40, 'ddit_m', 'daejeon');

SELECT *
FROM dept_test;

지금까지 배운 변수 선언
변수명 변수타입
변수명 참조타입(ex: dept.deptno%TYPE)
==> 스칼라 변수, 변수하나에 하나의 값만 할당 가능
    java 변수 하나에 여러개의 값을 넣을 수 있는 자료형
    배열 ==> List, Map, Set

변수==> 컬럼의 값
 컬럼 ==> 행 , 행 전체를 담을수 있는 변수

복합변수
1. 특정 테이블의 행의 모든 컬럼을 담을 수 있는 행 참조변수 : 테이블명%ROWTYPE
2. RECORD TYPE : 사용자 정의 타입
   행의 정보를 담을수 있는 것은 ROWTYPE과 동일, 사용자가 원하는 컬럼에 대해서만 정의
3. TABLE TYPE  : 복수개의 행을 담을 수 있는 타입
컬럼 => 행 => 복수행

%ROWTYPE
선언 : 변수명 테이블명%ROWTYPE;
컬럼 접근방법 : 변수명.컬럼명

dept테이블의 10번 부서 정보(3가지 컬럼)를 %ROWTYPE으로 받아 화면에 출력
익명 블럭으로 작성

DECLARE
    v_dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE('dname : ' || v_dept_row.dname || ', loc :' || v_dept_row.loc );
END;
/



