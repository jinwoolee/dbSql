익명 block : 데이터가 한건만 나와야 하는 상황

SET SERVEROUTPUT ON;

DECLARE
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_ename
    FROM emp;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS');
END;
/

예외포장하기
예외를 잡아 사용자가 정의한 새로운 예외로 던지는 작업

SELECT ename
FROM emp
WHERE empno = -99999;
NO_DATA_FOUND ==> NO_EMP

사용자 정의 예외 생성
예외명 EXCEPTION;

DECLARE
    NO_EMP EXCEPTION;
    v_ename emp.ename%TYPE;
BEGIN
    BEGIN
        SELECT ename INTO v_ename
        FROM emp
        WHERE empno = -99999;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
        RAISE NO_EMP; --throw new Exception();
    END;
EXCEPTION    
    WHEN NO_EMP THEN
        DBMS_OUTPUT.PUT_LINE('NO_EMP');
END;
/