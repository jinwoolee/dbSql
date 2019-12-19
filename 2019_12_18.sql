-- 12.18�ϱ��� ����

SELECT NVL(1, 0), NVL(1), NVL(NULL)
FROM dual;

SELECT
    MAX(NVL(DECODE(d, 1, dt), dt - d + 1)) ��, MAX(NVL(DECODE(d, 2, dt), dt - d + 2)) ��, MAX(NVL(DECODE(d, 3, dt), dt - d + 3)) ȭ,
    MAX(NVL(DECODE(d, 4, dt), dt - d + 4)) ��, MAX(NVL(DECODE(d, 5, dt), dt - d + 5)) ��, MAX(NVL(DECODE(d, 6, dt), dt - d + 6)) ��, MAX(NVL(DECODE(d, 7, dt), dt - d + 7)) ��
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);

    
SELECT dt,
    NVL(DECODE(d, 1, dt), dt - d + 1) ��, NVL(DECODE(d, 2, dt), dt - d + 2) ��, NVL(DECODE(d, 3, dt), dt - d + 3) ȭ,
    NVL(DECODE(d, 4, dt), dt - d + 4) ��, NVL(DECODE(d, 5, dt), dt - d + 5) ��, NVL(DECODE(d, 6, dt), dt - d + 6) ��, NVL(DECODE(d, 7, dt), dt - d + 7) ��
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d,
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'));
    
    
--201910 : 35, ù���� �Ͽ���: 20190929, ���������� ����� : 20191102
-- ��(1), ��(2), ȭ(3), ��(4), ��(5), ��(6), ��(7)
SELECT LDT-FDT+1
FROM 
(SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,

       LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
       7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
       
       TO_DATE(:yyyymm, 'YYYYMM')- 
       (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
 FROM dual);




-- 12.18�ϱ��� ����
SELECT
    MAX(DECODE(d, 1, dt)) ��, MAX(DECODE(d, 2, dt)) ��,
    MAX(DECODE(d, 3, dt)) ȭ, MAX(DECODE(d, 4, dt)) ��,
    MAX(DECODE(d, 5, dt)) ��, MAX(DECODE(d, 6, dt)) ��,
    MAX(DECODE(d, 7, dt)) ��
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM')- 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1) dt, --BEFORE
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')- 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1), 'D') d,
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')- 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= (SELECT LDT-FDT+1
                        FROM 
                        (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
                        
                               LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
                               7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
                               
                               TO_DATE(:yyyymm, 'YYYYMM')- 
                               (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
                         FROM dual)) )
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);




    
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd='dept0'   --�������� deptcd = 'dept0' --> XXȸ��(�ֻ�������)
CONNECT BY PRIOR deptcd = p_deptcd;

--*********XXȸ��
SELECT LPAD('XXȸ��', 15, '*'),
       LPAD('XXȸ��', 15)
FROM dual;
  

/*
dept0(XXȸ��)
dept0_00(�����κ�)
    dept0_00_0(��������)
dept0_01(������ȹ��)
    dept0_01_0(��ȹ��)
        dept0_00_0_0(��ȹ��Ʈ)
dept0_02(�����ý��ۺ�)
    dept0_02_0(����1��)
    dept0_02_1(����2��)
*/    
            

--h_2
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd='dept0_02'   --�������� deptcd = 'dept0' --> XXȸ��(�ֻ�������)
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM dept_h;

-- ��������(dept0_00_0)�� �������� ����� �������� �ۼ�
-- �ڱ� �μ��� �θ� �μ��� ������ �Ѵ�
SELECT dept_h.*, LPAD(' ', 4*(LEVEL-1)) || deptnm, level
FROM dept_h
START WITH deptcd='dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE '������%';

SELECT *
FROM dept_h;






--���� ������  ���÷����� ���밡���Ѱ�?
SELECT *
FROM tab_a, tab_b
WHERE tab_a.a = tab_b.a
AND   tab_a.b = tab_b.b;


SELECT LPAD(' ', 4*(LEVEL-1)) || s_id s_id, value, LEVEL
FROM h_sum
START WITH s_id='0'
CONNECT BY ps_id = PRIOR s_id;





-- pruning branch (����ġ��)
-- ���� ������ �������
-- FROM --> START WITH ~ CONNECT BY --> WHERE
-- ������ CONNECT BY ���� ����� ���
--  . ���ǿ� ���� ���� ROW�� ������ �ȵǰ� ����
-- ������ WHERE ���� ����� ���
--  . START WITH ~ CONNECT BY ���� ���� ���������� ���� �����
--    WHERE ���� ����� ��� ���� �ش��ϴ� �����͸� ��ȸ

--�ֻ��� ��忡�� ��������� Ž��
SELECT *
FROM dept_h
WHERE  deptcd='dept0';

--CONNECTY BY���� deptnm != '������ȹ��' ������ ����� ���
SELECT *
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��';


-- WHERE ���� deptnm != '������ȹ��' ������ ����� ���
-- ���������� �����ϰ��� ���� ����� WHERE �� ������ ����
SELECT *
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

-- ���� �������� ��� ������ Ư�� �Լ�
-- CONNECT_BY_ROOT(col) ���� �ֻ��� row�� col ���� �� ��ȸ
-- SYS_CONNECT_BY_PATH(col, ������) : �ֻ��� row���� ���� �ο���� col����
-- �����ڷ� �������� ���ڿ� (EX : XXȸ��-�����κε�������)
-- CONNECT_BY_ISLEAF : �ش� ROW�� ������ �������(leaf Node)
-- leaf node : 1, node : 0
SELECT deptcd, LPAD(' ' , 4*(LEVEL-1)) || deptnm,
       CONNECT_BY_ROOT(deptnm) c_root,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-') sys_path,
       CONNECT_BY_ISLEAF isleaf
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;

SELECT *
FROM board_test;

-- h_6
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

-- h_7
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

-- h_8
SELECT seq, LPAD(' ', 4*(LEVEL-1)) || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;