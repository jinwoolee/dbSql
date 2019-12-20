-- DBMS_OUTPUT.PUT_LINE �Լ��� ����ϴ� ����� ȭ�鿡 �����ֵ��� Ȱ��ȭ
SET SERVEROUTPUT ON; 
DECLARE --�����
   -- java : Ÿ�� ������;
   -- pl/sql : ������ Ÿ��;
   /*v_dname VARCHAR2(14);
   v_loc VARCHAR2(13);*/
   -- ���̺� �÷��� ���Ǹ� �����Ͽ� ������ Ÿ���� �����Ѵ�
   v_dname dept.dname %TYPE;
   v_loc dept.loc %TYPE; 
BEGIN
    --DEPT ���̺��� 10�� �μ��� �μ� �̸�, LOC ������ ��ȸ
    SELECT dname, loc 
    INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    -- String a = "t";
    -- String b = "c";
    -- Sysout.out.println(a + b);
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc);
END;
/  
--PL/SQL ����� ����


-- 10�� �μ��� �μ��̸�, ��ġ������ ��ȸ�ؼ� ������ ���
-- ������ DBMS_OUTPUT.PUT_LINE�Լ��� �̿��Ͽ� console�� ���
CREATE OR REPLACE PROCEDURE printdept
-- �Ķ���͸� IN/OUT Ÿ��
-- p_�Ķ�����̸�
( p_deptno IN dept.deptno%TYPE )   
IS
--�����(�ɼ�)
    dname dept.dname%TYPE;
    loc dept.loc%TYPE;
    
--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc
    FROM dept
    WHERE deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
--����ó����(�ɼ�)
END;
/


exec printdept(50);









