--CURSOR�� ��������� �������� �ʰ�
--LOOP���� inline ���·� cursor ���

set serveroutput on;

--�͸���
DECLARE
    --cursor ���� --> LOOP���� inline ����
BEGIN
    -- for(String str : list)
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
        dbms_output.put_line(rec.deptno ||', ' || rec.dname);
    END LOOP;
END;
/


--PRO_3

CREATE OR REPLACE PROCEDURE avgdt 
IS
    cnt NUMBER := 0;
    diff NUMBER := 0;
    prev_dt DATE;
BEGIN
    FOR rec IN (SELECT dt FROM dt ORDER BY dt DESC) LOOP
        IF cnt = 0 THEN
            prev_dt := rec.dt;
        ELSE
            diff :=  diff + prev_dt -rec.dt;
            prev_dt := rec.dt;
        END IF;
        cnt := cnt + 1;
    END LOOP;
    
    dbms_output.put_line('���ڰ��� ��� :' || diff/(cnt-1));
END;
/

exec avgdt;



SELECT *
FROM CYCLE;

--1	100	2	1
--1�� ���� 100�� ��ǰ�� �����ϳ� �Ѱ��� �Դ´�

-- CYCLE
1 100 2 1

-- DAILY
1 100 20191104 1
1 100 20191111 1
1 100 20191118 1
1 100 20191125 1



CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm IN VARCHAR2)
IS
    TYPE cal_row IS RECORD (
        dt VARCHAR2(8),
        day VARCHAR2(1));
    
    TYPE calendar IS TABLE OF cal_row INDEX BY BINARY_INTEGER;
    
    cal calendar;
    
    CURSOR cycle_data IS
    SELECT *
    FROM cycle;
BEGIN
    --���� ������ ����
    DELETE daily 
    WHERE dt LIKE p_yyyymm || '%';
    
    SELECT TO_CHAR(TO_DATE('201911', 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE('201911', 'YYYYMM') + (LEVEL-1), 'D') d
           BULK COLLECT INTO cal
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD');
    
    FOR cyc IN cycle_data LOOP
        FOR i IN 1..cal.count LOOP
            IF cal(i).day = cyc.day THEN      
                INSERT INTO daily VALUES (cyc.cid, cyc.pid, cal(i).dt, cyc.cnt);
            END IF;
        END LOOP;
    END LOOP;
    
    COMMIT;
END;
/

SELECT *
FROM daily;

exec create_daily_sales('201911');

