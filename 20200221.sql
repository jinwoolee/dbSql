SELECT *
FROM dept_test;


INSERT INTO dept_test (deptno, dname, loc) VALUES(99, 'ddit', 'daejeon');

INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon', 0);


CREATE OR REPLACE PROCEDURE registdept_test_sem (p_deptno IN dept_test.deptno%TYPE, 
                                                 p_dname IN dept_test.dname%TYPE,
                                                 p_loc IN dept_test.loc%TYPE) IS
BEGIN
    INSERT INTO dept_test VALUES(p_deptno, p_dname, p_loc, 0);
    COMMIT;
END;
/

exec registdept_test_sem(96, 'ddit', '����');

SELECT *
FROM dept_test;


UPDATE dept_test SET dname = 'ddit_m', loc ='daejeon'
WHERE deptno = 99;

CREATE OR REPLACE PROCEDURE updatedept_test_sem(
                        p_deptno IN dept_test.deptno%TYPE,
                        p_dname IN dept_test.dname%TYPE,
                        p_loc IN dept_test.loc%TYPE) IS
BEGIN
    UPDATE dept_test SET dname= p_dname, loc = p_loc
    WHERE deptno = p_deptno;
    
    COMMIT;
END;
/

EXEC updatedept_test_sem(96, 'ddit_m', 'daejeon');

SELECT *
FROM dept_test;



���պ��� %rowtype : Ư�� ���̺��� ���� ��� �÷��� ������ �� �ִ� ����
��� ��� : ������ ���̺��%ROWTYPE 
;

SET SERVEROUTPUT ON;
DECLARE
    v_dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' ' || v_dept_row.dname || ' ' || v_dept_row.loc);
END;
/

���պ��� RECORD 
�����ڰ� ���� �������� �÷��� ������ �� �ִ� Ÿ���� �����ϴ� ���
JAVA�� �����ϸ� Ŭ������ �����ϴ� ����
�ν��Ͻ��� ����� ������ ��������

����
TYPE Ÿ���̸�(�����ڰ� ����) IS RECORD(
    ������1 ����Ÿ��,
    ������2 ����Ÿ��
);
������ Ÿ���̸�;

DECLARE
    TYPE dept_row IS RECORD(
        deptno NUMBER(2),
        dname VARCHAR2(14)
    );
    
    v_dept_row dept_row;
BEGIN
    SELECT deptno, dname INTO v_dept_row
    FROM dept
    WHERE deptno=10;
    
    DBMS_OUTPUT.PUT_LINE( v_dept_row.deptno || ' ' || v_dept_row.dname);
END;
/

table type ���̺� Ÿ��
�� : ��Į�� ���� 
�� : %ROWTYPE, record type
�� : table type
     � ��(%ROWTYPE, RECORD TYPE)�� ������ �� �ִ���
     �ε��� Ÿ���� ��������;

DEPT ���̺��� ������ ������ �ִ� table type�� ����
������ ��� ��Į�� Ÿ��, rowtype������ �� ���� ������ ���� �� �־�����
table Ÿ�� ������ �̿��ϸ� ���� ���� ������ ���� �� �ִ�

PL/SQL ������ �ڹٿ� �ٸ��� �迭�� ���� �ε����� ������ �����Ǿ� ���� �ʰ�
���ڿ��� �����ϴ�.

�׷��� TABLE Ÿ���� ������ ���� �ε����� ���� Ÿ�Ե� ���� ���
BINARY_INTEGER Ÿ���� PL/SQL������ ��� ������ Ÿ������
NUMBER Ÿ���� �̿��Ͽ� ������ ��� �����ϰ� ���� NUMBER Ÿ���� ���� Ÿ���̴�;

DECLARE 
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept_tab dept_tab;
BEGIN
    SELECT * BULK COLLECT INTO v_dept_tab
    FROM dept;
    --���� ��Į�󺯼�, record Ÿ���� �ǽ��ÿ���
    --���ุ ��ȸ �ǵ��� WHERE���� ���� �����Ͽ���

    --�ڹٿ����� �迭[�ε��� ��ȣ]
    --talbe����(�ε��� ��ȣ) �� ����
    
    FOR i IN 1..v_dept_tab.count LOOP
        DBMS_OUTPUT.PUT_LINE(v_dept_tab(i).deptno || ' ' || v_dept_tab(i).dname);
    END LOOP;
END;
/


�������� IF
����

IF ���ǹ� THEN
    ���๮;
ELSIF ���ǹ� THEN
    ���๮;
ELSE
    ���๮;
END IF;

DECLARE
    p NUMBER(1) := 2; -- ���� ����� ���ÿ� ���� ����
BEGIN
    IF p = 1 THEN
        DBMS_OUTPUT.PUT_LINE('1�Դϴ�');
    ELSIF p = 2 THEN
        DBMS_OUTPUT.PUT_LINE('2�Դϴ�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�˷����� �ʾҽ��ϴ�');
    END IF;
END;
/

CASE ���� 
1.�Ϲ� ���̽� (java�� switch�� ����)
2.�˻� ���̽� (if, else if, else)

CASE expression
    WHEN value THEN
        ���๮;
    WHEN value THEN
        ���๮;
    ELSE
        ���๮;
END CASE;        

DECLARE 
    p NUMBER(1) := 2;
BEGIN
    CASE 
        WHEN P = 1 THEN
            DBMS_OUTPUT.PUT_LINE('1�Դϴ�');
        WHEN P = 2  THEN
            DBMS_OUTPUT.PUT_LINE('2�Դϴ�');
        ELSE
            DBMS_OUTPUT.PUT_LINE('�𸣴� ���Դϴ�');
    END CASE;
END;
/


FOR LOOP ����
FOR ��������/�ε������� IN [REVERSE] ���۰�..���ᰪ LOOP
    �ݺ��� ����;
END LOOP;

1���� 5���� FOR LOOP �ݺ����� �̿��Ͽ� ���� ���;

DECLARE
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/

�ǽ� : 2~9�� ������ �������� ���;
DECLARE 
BEGIN
    FOR i IN 2..9 LOOP
        FOR j IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' || i*j); 
        END LOOP;
    END LOOP;
END;
/

while loop ����
WHILE ���� LOOP
    �ݺ������� ����;
END LOOP;

DECLARE
    i NUMBER := 0;
BEGIN
    WHILE i <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
        i := i+1;
    END LOOP;
END;
/

LOOP�� ���� ==> while(true)
LOOP
    �ݺ������� ����;
    EXIT ����;
END LOOP;    

DECLARE
    i NUMBER := 0;
BEGIN
    LOOP
        EXIT WHEN i > 5;
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
    END LOOP;
END;
/


