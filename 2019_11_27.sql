SELECT *
FROM no_emp;

--1.leaf node 찾기
SELECT LPAD(' ', (LEVEL-1)*4, ' ') || org_cd, s_emp
FROM
    (SELECT org_cd, parent_org_cd, SUM(s_emp) s_emp
    FROM
        (SELECT org_cd, parent_org_cd, 
               SUM(no_emp/org_cnt) OVER (PARTITION BY GR ORDER BY rn
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) s_emp 
        FROM 
        (SELECT a.*, ROWNUM rn, a.lv + ROWNUM gr,
                COUNT(org_cd) OVER (PARTITION BY org_cd ) org_cnt
            FROM
            (SELECT org_cd, parent_org_cd, no_emp, LEVEL LV, connect_by_isleaf leaf
             FROM no_emp
             START WITH parent_org_cd IS NULL
             CONNECT BY PRIOR org_cd = parent_org_cd) a
            START WITH leaf = 1
            CONNECT BY PRIOR parent_org_cd = org_cd))
    GROUP BY org_cd, parent_org_cd )
START WITH parent_org_cd IS NULL
CONNECT BY PRIOR org_cd = parent_org_cd;



--PL/SQL
--할당연산 :=
-- System.out.println("") --> dbms_out.put_line("");
-- Log4j
--set serveroutput on; --출력기능을 활성화
--PL/SQL
--declare : 변수, 상수 선언
--begin : 로직 실행
--exception : 예외처리
DESC dept;

set serveroutput on;
DECLARE
    --변수 선언
    deptno NUMBER(2);
    dname VARCHAR2(14);
BEGIN
    SELECT deptno, dname INTO deptno, dname
    FROM dept
    WHERE deptno = 10;
    
    --SELECT 절의 결과를 변수에 잘 할당 했는지 확인
    dbms_output.put_line('dname : ' || dname || '(' || deptno || ')');
END;
/


DECLARE
    --참조 변수 선언(테이블 컬럼타입이 변경되도 pl/sql 구문을 수정할 필요가 없다)
    deptno dept.deptno%TYPE;
    dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO deptno, dname
    FROM dept
    WHERE deptno = 10;
    
    --SELECT 절의 결과를 변수에 잘 할당 했는지 확인
    dbms_output.put_line('dname : ' || dname || '(' || deptno || ')');
END;
/


--10번부서의 부서이름과 LOC정보를 화면추력하는 프로시저
--프로시져명 : printdept
-- CREATE OR REPLACE VIEW
CREATE OR REPLACE PROCEDURE printdept 
IS
    --변수선언
    dname dept.dname%TYPE;
    loc  dept.loc%TYPE;
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = 10;
    
    dbms_output.put_line('dname, loc = ' || dname || ',' || loc);
END;
/



CREATE OR REPLACE PROCEDURE printdept_p(p_deptno IN dept.deptno%TYPE) 
IS
    --변수선언
    dname dept.dname%TYPE;
    loc  dept.loc%TYPE;
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
    
    dbms_output.put_line('dname, loc = ' || dname || ',' || loc);
END;
/

exec printdept_p(30);

--procedure : printemp
--입력 : 사원번호
--출력 : 사원이름, 부서이름


CREATE OR REPLACE PROCEDURE printemp (p_empno IN emp.empno%TYPE)
IS
    var_ename emp.ename%TYPE;
    var_dname dept.dname%TYPE;
BEGIN
    SELECT ename, dname
    INTO var_ename, var_dname
    FROM emp, dept
    WHERE empno = p_empno
    AND emp.deptno = dept.deptno;
    
    dbms_output.put_line(var_ename || ', ' || var_dname);
END;
/
exec printemp(7369);

SELECT *
FROM dept_test;

DELETE dept_test
WHERE DEPTNO >90;

COMMIT;

CREATE TABLE dept_test AS
SELECT *
FROM dept;





